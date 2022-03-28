import Config

config :hound, driver: "chrome_driver"

config :hound_demo,
  host: "https://torus.qa.argos.education",
  gas_student_username: "e2e-student@argos.education",
  gas_student_password: System.get_env("gas_student_password", "PASSWORD")
