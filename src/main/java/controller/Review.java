package controller;

public class Review {
    private String email;
    private String reviewTarget;
    private String targetId;
    private String content;
    private int rating;

    public Review(String email, String reviewTarget, String targetId, String content, int rating) {
        this.email = email;
        this.reviewTarget = reviewTarget;
        this.targetId = targetId;
        this.content = content;
        this.rating = rating;
    }

    public String getEmail() { return email; }
    public String getReviewTarget() { return reviewTarget; }
    public String getTargetId() { return targetId; }
    public String getContent() { return content; }
    public int getRating() { return rating; }

    @Override
    public String toString() {
        return email + "|" + reviewTarget + "|" + targetId + "|" + content.replace("|", "/") + "|" + rating;
    }

    public static Review fromString(String line) {
        String[] parts = line.split("\\|");
        if (parts.length == 5) {
            return new Review(parts[0], parts[1], parts[2], parts[3], Integer.parseInt(parts[4]));
        }
        return null;
    }
}
