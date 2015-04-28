var gulp = require('gulp');
var sass = require('gulp-sass');
var livereload = require('gulp-livereload')

gulp.task('prod', function () {
    gulp.src('./contents/styles/*.scss')
        .pipe(sass())
        .pipe(gulp.dest('./build/css'))
        .pipe(gulp.dest('./contents/css'))
        .pipe(livereload());
});

gulp.task('dev', function() {
  livereload.listen();
  gulp.watch('./contents/styles/*', ['prod']);
});
