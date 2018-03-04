var express = require('express');
var router = express.Router();
//pobranie z bazy danych danych i wyswietlenie ich, mamy tu plik dane.jade ktory odpowiada za widok
var mysql = require('mysql');
var db = mysql.createConnection({
	host: '127.0.0.1',
	user: 'root',
	password: 'MY_PASSWORD',
	database: 'library',
	multipleStatements: true
});
db.connect();

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('library_main', { title: 'Strona główna' });
});

router.get('/home', function(req, res, next) {
  res.render('home', { title: 'Library' });
});
router.post('/delete_book', function(req, res, next) {
    var title = req.body.title;
	var isbn = req.body.isbn;
	var autorName = req.body.autorName;
	var autorSurname = req.body.autorSurname;
	var year = req.body.year;
	var publisherName = req.body.publisherName;
	var fieldName = req.body.fieldName;
	//console.log(title + " " + isbn + " " + autorName + " " + autorSurname + " " + year + " " + publisherName + " " + fieldName + " ");
	var sql = "delete from autor where Imie = '"+autorName+"' and Nazwisko = '"+autorSurname+"';\
	delete from dziedzina where Nazwa = '"+fieldName+"';\
	delete from ksiazki where Isbn = '"+isbn+"';\
	delete from wydawnictwo where Nazwa = '"+publisherName+"';\
	";
	db.query(sql,function(error,dane){
		res.redirect('/library/');
			if(error){
				console.log(error);
			}
	});	
});


// //wyswietli te wsadzone dane w library.jade
var sql = 'Select * From biblioteka;';
router.get('/library/', function(req,res){
	db.query(sql,function(error,dane){
			res.render('library', {  library: dane});//library musi sie zgadzac tez w jade each item in library
			if(error){
				console.log(error);
			}
	});	
});
// //wkladanie wartosci za pomoca formularza stworzonego w add_book.jade
router.get('/add_book', function(req, res, next) {
  res.render('add_book', { title: 'Add Book' });
});

router.post('/add_book/', function(req,res){
	var title = req.body.title;
	var isbn = req.body.isbn;
	var autorName = req.body.autorName;
	var autorSurname = req.body.autorSurname;
	var year = req.body.year;
	var publisherName = req.body.publisherName;
	var fieldName = req.body.fieldName;
	var sql = "insert into Autor(Imie,Nazwisko) values ('"+autorName +"','" + autorSurname+"');\
	insert into Wydawnictwo(Nazwa) values ('"+publisherName+"');\
	insert into Ksiazki(Isbn,IdWydano,IdNapisanaPrzez,IdDziedzina,Tytul) values ('"+isbn+"','"+0+"','"+0+"','"+0+"','"+title+"');\
	set @IdWydawnictwa = (select IdWydawnictwa from Wydawnictwo where Nazwa = '"+publisherName+"');\
	set @IdKsiazki = (select IdKsiazki from Ksiazki where Tytul = '"+title+"');\
	insert into Wydano(IdWydawnictwa,IdKsiazki,Rok) values(@IdWydawnictwa,@IdKsiazki,"+year+");\
	set @IdAutora = (select IdAutora from Autor where Imie = '"+autorName+"' and Nazwisko = '"+autorSurname+"');\
	set @IdKsiazki = (select IdKsiazki from Ksiazki where Tytul = '"+title+"');\
	insert into NapisanaPrzez(IdAutora,IdKsiazki) values(@IdAutora,@IdKsiazki);\
	insert into Dziedzina(Nazwa) values ('"+fieldName+"');\
	set @IdDZiedziny = (select IdDziedziny from Dziedzina where Nazwa ='"+fieldName+"');\
	set @IdKsiazki = (select IdKsiazki from Ksiazki where Tytul = '"+title+"');\
	insert into ZDziedziny(IdKsiazki,IdDziedziny) values(@IdKsiazki,@IdDziedziny);\
	set @IdDziedziny = (select IdDziedziny from Dziedzina where Nazwa ='"+fieldName+"');\
	set @IdWydano = (select a.IdWydano from Wydano as a inner join Wydawnictwo as b on a.IdWydawnictwa = b.IdWydawnictwa where Nazwa ='"+publisherName+"');\
	set @IdNapisanaPrzez = (select a.IdAutora from NapisanaPrzez as a inner join Autor as b on a.IdAutora = b.IdAutora where Imie = '"+autorName+"' and Nazwisko = '"+autorSurname+"');\
	update Ksiazki set IdWydano = (@IdWydano), IdNapisanaPrzez = (@IdNapisanaPrzez), IdDziedzina = (@IdDziedziny) where Tytul = '"+title+"';\
	";
	db.query(sql,function(error,dane){
	res.redirect('/library/');
			if(error){
				console.log(error);
			}
	});	
});
module.exports = router;
