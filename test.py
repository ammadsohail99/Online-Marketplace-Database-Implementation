# import the Streamlit library
import streamlit as st
import matplotlib.pyplot as plt
# Create a title for the app
st.title("Sample Streamlit App By Krishan Gupta")

# Add text to the app
st.write("This is a simple example of a Streamlit app.")

# Create a slider widget
slider_value = st.slider("Select a value", 0, 100, 50)

# Display the selected value
st.write("You selected:", slider_value)

# Create a text input widget
text_input = st.text_input("Hey guys", "Hello, Streamlit!")

# Display the entered text
st.write("You entered:", text_input)

# Create a button
button_clicked = st.button("Click me")

# Display a message when the button is clicked
if button_clicked:
    st.write("Button was clicked!")

# Create a plot
import matplotlib.pyplot as plt
import numpy as np

x = np.linspace(0, 10, 100)
y = np.sin(x)
plt.plot(x, y)
st.pyplot(plt)

st.write("This is a awesome app")

# Add a footer to the app
st.text("Created with Streamlit by NASA")

# Run the app
if __name__ == "__main__":
    st.sidebar.header("Look up XD")
    st.sidebar.text("Just close it bro!!!")
