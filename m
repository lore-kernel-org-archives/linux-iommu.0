From: Sudip Mukherjee <sudipm.mukherjee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: usb HC busted?
Date: Tue, 17 Jul 2018 18:01:08 +0100
Message-ID: <20180717170108.5bv22bfmqbjktifs@debian>
References: <20180717120411.GB28592@kroah.com>
	<Pine.LNX.4.44L0.1807171029310.1689-100000@iolanthe.rowland.org>
	<20180717155259.GB2416@kroah.com>
	<20180717155901.5csifwp5ak2ixfk5@debian>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="irlgiq2damz5zlpp"
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180717155901.5csifwp5ak2ixfk5@debian>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Mathias Nyman <mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Mathias Nyman <mathias.nyman-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, lukaszx.szulc-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--irlgiq2damz5zlpp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 17, 2018 at 04:59:01PM +0100, Sudip Mukherjee wrote:
> On Tue, Jul 17, 2018 at 05:52:59PM +0200, Greg KH wrote:
> > On Tue, Jul 17, 2018 at 10:31:38AM -0400, Alan Stern wrote:
> > > On Tue, 17 Jul 2018, Greg KH wrote:
> > > 
> > > > > From: Sudip Mukherjee <sudipm.mukherjee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > > > > Date: Tue, 10 Jul 2018 09:50:00 +0100
> > > > > Subject: [PATCH] hacky solution to mem-corruption
> > > > > 
> > > > > Signed-off-by: Sudip Mukherjee <sudipm.mukherjee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > > > > ---
> <snip>
> > > 
> > > No, neither of these is right.  It's possible to use 
> > > usb_set_interface() as a kind of "soft" reset.  Even when the new 
> > > altsetting is specified to be the same as the current one, we still 
> > > have to tell the lower-layer drivers and hardware about it.
> > 
> > You are right, it's a hacky soft reset, I was just trying to figure out
> > what the bluetooth driver was trying to do.  I wouldn't expect it to be
> > calling that function a lot, but I guess it does :(
> 
> usb_set_interface() is being called two times from bluetooth event. But
> I am now adding more debugs to see why your patch did not work.

So, a very simple debug to see the sequence of functions being called.
I have attached the patch I used.

In a good case:
[  124.287991] sudip: xhci_urb_dequeue
[  124.287997] sudip: xhci_queue_stop_endpoint cmd=ee032950
[  124.288016] sudip: handle_cmd_completion cmd=ee032950
[  124.288173] sudip: xhci_urb_dequeue
[  124.288176] sudip: xhci_queue_stop_endpoint cmd=ee032950
[  124.288189] sudip: handle_cmd_completion cmd=ee032950
[  124.290647] sudip: usb_hcd_flush_endpoint
[  124.290652] sudip: usb_hcd_flush_endpoint

But in a bad case:
[  186.786900] sudip: xhci_urb_dequeue
[  186.786905] sudip: xhci_queue_stop_endpoint cmd=ebe47cb0
[  186.786923] sudip: handle_cmd_completion cmd=ebe47cb0
[  186.789040] sudip: xhci_urb_dequeue
[  186.789047] sudip: xhci_queue_stop_endpoint cmd=ebe47cb0
[  186.789069] sudip: handle_cmd_completion cmd=ebe47cb0
[  186.790082] sudip: usb_hcd_flush_endpoint
[  186.790094] sudip: xhci_urb_dequeue
[  186.790097] sudip: xhci_queue_stop_endpoint cmd=ebe47290
[  186.790150] sudip: handle_cmd_completion cmd=ebe47290
[  186.790202] sudip: usb_hcd_flush_endpoint

So, when usb_hcd_flush_endpoint() is called by usb_disable_endpoint() it
finds urbs still on the urb_list of the ep. And in the process of unlinking
them, it again sends the command to stop the endpoint, although that endpoint
has already been stopped.
So Greg's patch did not work as the memory got corrupted on the first call
to usb_set_interface(), whereas that patch was preventing the second call
to usb_set_interface().

--
Regards
Sudip

--irlgiq2damz5zlpp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 467bedeb542a..8d28f120ec0a 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -1885,6 +1885,7 @@ void usb_hcd_flush_endpoint(struct usb_device *udev,
 	might_sleep();
 	hcd = bus_to_hcd(udev->bus);
 
+	pr_err("sudip: %s\n", __func__);
 	/* No more submits can occur */
 	spin_lock_irq(&hcd_urb_list_lock);
 rescan:
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 6996235e34a9..4f80791fdfc5 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1450,6 +1450,7 @@ static void handle_cmd_completion(struct xhci_hcd *xhci,
 	case TRB_STOP_RING:
 		WARN_ON(slot_id != TRB_TO_SLOT_ID(
 				le32_to_cpu(cmd_trb->generic.field[3])));
+		pr_err("sudip: %s cmd=%p\n", __func__, cmd);
 		xhci_handle_cmd_stop_ep(xhci, slot_id, cmd_trb, event);
 		break;
 	case TRB_SET_DEQ:
@@ -4009,6 +4010,7 @@ int xhci_queue_stop_endpoint(struct xhci_hcd *xhci, struct xhci_command *cmd,
 	u32 type = TRB_TYPE(TRB_STOP_RING);
 	u32 trb_suspend = SUSPEND_PORT_FOR_TRB(suspend);
 
+	pr_err("sudip: %s cmd=%p\n", __func__, cmd);
 	return queue_command(xhci, cmd, 0, 0, 0,
 			trb_slot_id | trb_ep_index | type | trb_suspend, false);
 }
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index db1de6113db2..3832128107ff 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -1516,6 +1516,7 @@ static int xhci_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 		ep->stop_cmd_timer.expires = jiffies +
 			XHCI_STOP_EP_CMD_TIMEOUT * HZ;
 		add_timer(&ep->stop_cmd_timer);
+		pr_err("sudip: %s\n", __func__);
 		xhci_queue_stop_endpoint(xhci, command, urb->dev->slot_id,
 					 ep_index, 0);
 		xhci_ring_cmd_db(xhci);

--irlgiq2damz5zlpp
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--irlgiq2damz5zlpp--
