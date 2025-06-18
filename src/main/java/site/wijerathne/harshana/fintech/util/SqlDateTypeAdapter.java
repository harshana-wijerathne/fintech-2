package site.wijerathne.harshana.fintech.util;

import com.google.gson.TypeAdapter;
import com.google.gson.stream.JsonReader;
import com.google.gson.stream.JsonWriter;
import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.text.ParseException;

public class SqlDateTypeAdapter extends TypeAdapter<Date> {
    private final SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

    @Override
    public void write(JsonWriter out, Date value) throws IOException {
        if (value == null) {
            out.nullValue();
        } else {
            out.value(dateFormat.format(value));
        }
    }

    @Override
    public Date read(JsonReader in) throws IOException {
        try {
            String dateString = in.nextString();
            if (dateString == null || dateString.isEmpty()) {
                return null;
            }
            return new Date(dateFormat.parse(dateString).getTime());
        } catch (ParseException e) {
            throw new IOException("Failed to parse date. Expected format: YYYY-MM-DD", e);
        }
    }
}
