const addEventButton = document.getElementById('add-node');

const formAddEvent = document.getElementById('new_event');

if (formAddEvent) {
  const allInputs = [];
  const event_name = formAddEvent.querySelector('#event_name')
  allInputs.push(event_name)
  const event_date = formAddEvent.querySelector('#event_date')
  allInputs.push(event_date)

  // input[type=radio]

  // console.log(allInputs)
  const allInputsArr = Array.from(allInputs);
  // console.log(allInputsArr)

  const button = document.querySelector('.add-event-submit');

  const isFilled = input => input.value;

  const allFilled = () => allInputsArr.every(isFilled);

  // console.log(allInputsArr.every(isFilled));
  // console.log(formAddEvent["event[category]"]);

  function validateRadio(radios)
  {
      for (i = 0; i < radios.length; ++ i)
      {
          if (radios[i].checked) return true;
      }
      return false;
  }

  const enableButton = () => {
    const all = allFilled();
    console.log(all);
    if (all && validateRadio(formAddEvent["event[category]"])) {
      button.disabled = false;
    }
  };

  allInputs.forEach(input => input.addEventListener('change', enableButton));
  formAddEvent["event[category]"].forEach(choice => choice.addEventListener('change', enableButton));
}


