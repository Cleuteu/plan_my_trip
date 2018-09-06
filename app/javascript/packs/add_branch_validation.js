const addEventButton = document.getElementById('add-node');

const formBranchEvent = document.querySelector('.add_branch').firstElementChild;
// console.log(formBranchEvent)

if (formBranchEvent) {
  const allInputsBranch = [];
  const event_name = formBranchEvent.querySelector('#event_name')
  allInputsBranch.push(event_name)
  const event_date = formBranchEvent.querySelector('#event_date_branch')
  allInputsBranch.push(event_date)
  // console.log(allInputsBranch)

  // console.log(formBranchEvent["event[category]"])

  // input[type=radio]

  // console.log(allInputsBranch)
  const allInputsBranchArr = Array.from(allInputsBranch);
  // console.log(allInputsBranchArr)

  const button = document.querySelector('.add-branch-submit');

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
    if (all && validateRadio(formBranchEvent["event[category]"])) {
      button.disabled = false;
    }
  };

  allInputsBranch.forEach(input => input.addEventListener('change', enableButton));
  formBranchEvent["event[category]"].forEach(choice => choice.addEventListener('change', enableButton));
}
