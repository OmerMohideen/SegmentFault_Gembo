export interface VisaApplication {
  [x: string]: any;
  id: string;
  passport_name: string;
  passport_number: string;
  visa_type: string;
  date_of_arrival: string;
  date_of_departure: string;
  dob: string;
  email: string;
  gender: string;
  issue_date: string;
  nationality: string;
  personal_country_code: string;
  phone_number: string;
  port_entry: string;
  purpose: string;
  country_of_residence: string;
  residential_address: string;
  sub_visa_type: string;
  travel_document: string;
  valid_date: string;
  visa_category: string;
  whatsapp_country_code: string;
  whatsapp_number: string;
  fileUrls: {
    add_docs: string;
    invite_letter: string;
    passport_bio: string;
  };
}

