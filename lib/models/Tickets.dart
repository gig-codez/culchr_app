class EventTickets {
  final int id;
  final String eventName;
  final String eventDescription;
  final String eventPrice;
  EventTickets({
    required this.id,
    required this.eventName,
    required this.eventDescription,
    required this.eventPrice,
  });

  static List<EventTickets> ticketsList = [
    EventTickets(
        eventName: "Early Bird",
        eventDescription: "longpress",
        eventPrice: "UGx 20,000",
        id: 0),
    EventTickets(
        id: 1,
        eventName: "Standard",
        eventDescription: "Longpress",
        eventPrice: "UGx 50,000"),
    EventTickets(
        id: 2,
        eventName: "Exclusive",
        eventDescription: "Longpress",
        eventPrice: "UGx 200,000"),
    EventTickets(
        id: 3,
        eventName: "VIP",
        eventDescription: "Longpress",
        eventPrice: "UGx 100,000"),
  ];
}
