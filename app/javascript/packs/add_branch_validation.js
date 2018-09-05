const addEventButton = document.getElementById('add-node');

const formBranchEvent = document.querySelector('.add_branch').firstElementChild;

if (formBranchEvent) {
  const allInputsBranch = [];
  const event_name = formBranchEvent.querySelector('#event_name')
  allInputsBranch.push(event_name)
  const event_date = formBranchEvent.querySelector('#event_date_branch')
  allInputsBranch.push(event_date)

  console.log(formBranchEvent["branch_event[category]"])

  // input[type=radio]

  // console.log(allInputsBranch)
  const allInputsBranchArr = Array.from(allInputsBranch);
  // console.log(allInputsBranchArr)

  const button = document.querySelector('.branch-event-submit');

  const isFilled = input => input.value;

  const allFilled = () => allInputsBranchArr.every(isFilled);

  // console.log(allInputsBranchArr.every(isFilled));
  // console.log(formBranchEvent["event[category]"]);

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
    if (all && validateRadio(formBranchEvent["branch_event[category]"])) {
      button.disabled = false;
    }
  };

  allInputsBranch.forEach(input => input.addEventListener('change', enableButton));
  formBranchEvent["branch_event[category]"].forEach(choice => choice.addEventListener('change', enableButton));
}
