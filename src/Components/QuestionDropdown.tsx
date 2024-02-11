import { useState } from "react";
import { IAnswer } from "./Interfaces";
import { Select, MenuItem, FormControl, InputLabel } from "@mui/material";

interface QuestionDropdownProps {
  id: string;
  setAnswer: (questionId: string, ans: IAnswer) => void;
  options?: string[];
}

export const QuestionDropdown = ({
  id,
  setAnswer,
  options,
}: QuestionDropdownProps) => {
  const [selection, setSelection] = useState();
  const handleChange = (e: any) => {
    setSelection(e.target.value);
    setAnswer(id, { dropdownSelection: e.target.value });
  };
  return (
    <FormControl fullWidth>
      <InputLabel id={`dropdown-select-label-${id}`}>Selection</InputLabel>
      <Select
        labelId={`dropdown-select-label-${id}`}
        id={`dropdown-select-${id}`}
        value={selection}
        label="Selection"
        onChange={handleChange}
      >
        {options?.map((item) => {
          return <MenuItem value={item}>{item}</MenuItem>;
        })}
      </Select>
    </FormControl>
  );
};
