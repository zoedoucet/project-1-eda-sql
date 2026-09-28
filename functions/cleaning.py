def column_names_std(df):
    """Standardises column names using snake_case
        - removing leading and trailing spces
        - setting everything to lower case
        - replacing every character that is not a letter or a number with an underscore"""
    df.columns = (df.columns
        .str.strip()# removing spaces
        .str.lower()# everything in lower case
        .str.replace(r"[^a-z0-9]+", "_", regex=True)# replacing every character that is not a letter or a number with an underscore 
        )
    return df