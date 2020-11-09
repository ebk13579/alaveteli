(function ($) {

  var RefusalWizard = function (target, options) {
    this.$el = $(target);

    var defaults = {
      questionClass: 'wizard__question',
      currentQuestionClass: 'wizard__question--current',
      pastQuestionClass: 'wizard__question--past',
      futureQuestionClass: 'wizard__question--future',
      remainingMessageClass: 'js-wizard-remaining',
      progressBarClass: 'js-wizard-progress',
      nextButtonClass: 'js-wizard-next'
    };

    this.options = $.extend(true, defaults, options);

    this._init(target, options);

    return this;
  };

  RefusalWizard.prototype._init = function (target, options) {
    var _this = this;
    this._updateTotals();
    this._updateUI();

    $('.' + this.options.nextButtonClass).on('click', function () {
      _this._submitAnswer();
    });
  };

  // TODO: Totals need to take into account "future" questions that can’t be reached
  RefusalWizard.prototype._updateTotals = function () {
    this.totalQuestions = this.$el.find('.' + this.options.questionClass).length;
    this.totalAnswered = this.$el.find('.' + this.options.pastQuestionClass).length;
    this.totalUnanswered = this.totalQuestions - this.totalAnswered;
  };

  RefusalWizard.prototype._updateUI = function () {
    console.log(this);
    var remainingString = '' + this.totalUnanswered + ' question' + (this.totalUnanswered === 1 ? '' : 's') + ' remaining';
    var progressPercent = ( this.totalQuestions - this.totalUnanswered ) / this.totalQuestions * 100;

    this.$el.find('.' + this.options.remainingMessageClass).text(remainingString);
    this.$el.find('.' + this.options.progressBarClass).css({
      'width': '' + progressPercent + '%'
    }).attr({
      'aria-valuenow': this.totalQuestions - this.totalUnanswered,
      'aria-valuemax': this.totalQuestions
    });
  };

  RefusalWizard.prototype._submitAnswer = function() {
    var $current = this.$el.find('.' + this.options.currentQuestionClass);
    var $next = $current.next('.' + this.options.questionClass);

    $current.removeClass(this.options.currentQuestionClass);
    $current.addClass(this.options.pastQuestionClass);
    $next.removeClass(this.options.futureQuestionClass);
    $next.addClass(this.options.currentQuestionClass);

    this._updateTotals();
    this._updateUI();
  };

  // Declare public methods here. They should return the
  // plugin target (this.$el) for jQuery chaining, eg:
  //
  // RefusalWizard.prototype.examplePublicMethod = function () {
  //   return this.$el;
  // };

  $.fn[ 'refusalWizard' ] = function( methodOrOptions ) {
    if ( !$(this).length ) {
      return $(this);
    }

    var instance = $(this).data('refusalWizard');
    var wantsToCallPublicMethod = (
      instance
      && methodOrOptions.indexOf('_') != 0
      && instance[ methodOrOptions ]
      && typeof( instance[ methodOrOptions ] ) == 'function'
    );
    var wantsToInitialise = (
      typeof methodOrOptions === 'object'
      || ! methodOrOptions
    );

    if ( wantsToCallPublicMethod ) {
      return instance[ methodOrOptions ]( Array.prototype.slice.call( arguments, 1 ) );

    } else if ( wantsToInitialise ) {
      instance = new RefusalWizard( $(this), methodOrOptions );
      $(this).data( 'refusalWizard', instance );
      return $(this);

    } else if ( !instance ) {
      $.error( 'Plugin must be initialised before using method: ' + methodOrOptions );

    } else if ( methodOrOptions.indexOf('_') == 0 ) {
      $.error( 'Method ' +  methodOrOptions + ' is private!' );

    } else {
      $.error( 'Method ' +  methodOrOptions + ' does not exist.' );
    }
  };

  $('.js-wizard').refusalWizard();

})(window.jQuery)
