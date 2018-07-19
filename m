From: Mathias Nyman <mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: usb HC busted?
Date: Thu, 19 Jul 2018 18:42:19 +0300
Message-ID: <ab814c88-0857-5444-57da-34c21b8d7f6c@linux.intel.com>
References: <20180717114104.irgdb5rmg2qxclgp@debian>
	<Pine.LNX.4.44L0.1807171022001.1689-100000@iolanthe.rowland.org>
	<20180717144022.4wabhdhysori3mvg@debian>
	<20180717144918.7ymzbhijxfcc3fhb@debian>
	<20180717151017.yk5d4glzwqcrxpqc@debian>
	<f7801c24-fa98-6338-0b26-33a0ac9498bb@linux.intel.com>
	<20180719113455.urktqxijzoyhfoou@debian>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------CCF90E165C54D8B35E62BA11"
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180719113455.urktqxijzoyhfoou@debian>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Sudip Mukherjee <sudipm.mukherjee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mathias Nyman <mathias.nyman-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, lukaszx.szulc-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This is a multi-part message in MIME format.
--------------CCF90E165C54D8B35E62BA11
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

>> As first aid I could try to implement checks that make sure the flushed URBs
>> trb pointers really are on the current endpoint ring, and also add some warning
>> if we are we are dropping endpoints with URBs still queued.
> 
> Yes, please. I think your first-aid will be a much better option than
> the hacky patch I am using atm.
> 

Attached a patch that checks canceled URB td/trb pointers.
I haven't tested it at all (well compiles and boots, but new code never exercised)

Does it work for you?

>>
>> But we need to fix this properly as well.
>> xhci needs to be more in sync with usb core in usb_set_interface(), currently xhci
>> has the altssetting up and running when usb core hasn't event started flushing endpoints.
> 
> I am able to reproduce this on almost all cycles, so I can always test
> the fix for you after you are fully back from your holiday.

Nice, thanks

-Mathias

--------------CCF90E165C54D8B35E62BA11
Content-Type: text/x-patch;
 name="0001-xhci-when-dequeing-a-URB-make-sure-it-exists-on-the-.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-xhci-when-dequeing-a-URB-make-sure-it-exists-on-the-.pa";
 filename*1="tch"

>From a7d4af3129a91811c95ea642f6c916b1c1ca6d46 Mon Sep 17 00:00:00 2001
From: Mathias Nyman <mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Date: Thu, 19 Jul 2018 18:06:18 +0300
Subject: [PATCH] xhci: when dequeing a URB make sure it exists on the current
 endpoint ring.

If the endpoint ring has been reallocated since the URB was enqueued,
then URB may contain TD and TRB pointers to a already freed ring.
If this the case then manuallt return the URB, and don't try to stop
the ring. It would be useless.

This can happened if endpoint is not flushed before it is dropped and
re-added, which is the case in usb_set_interface() as xhci does
things in an odd order.

Signed-off-by: Mathias Nyman <mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/usb/host/xhci.c | 43 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 711da33..5bedab7 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -37,6 +37,21 @@ static unsigned int quirks;
 module_param(quirks, uint, S_IRUGO);
 MODULE_PARM_DESC(quirks, "Bit flags for quirks to be enabled as default");
 
+static bool td_on_ring(struct xhci_td *td, struct xhci_ring *ring)
+{
+	struct xhci_segment *seg = ring->first_seg;
+
+	if (!td || !td->start_seg)
+		return false;
+	do {
+		if (seg == td->start_seg)
+			return true;
+		seg = seg->next;
+	} while (seg && seg != ring->first_seg);
+
+	return false;
+}
+
 /* TODO: copied from ehci-hcd.c - can this be refactored? */
 /*
  * xhci_handshake - spin reading hc until handshake completes or fails
@@ -1467,19 +1482,16 @@ static int xhci_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 		goto done;
 	}
 
+	/* check ring is not re-allocated since URB was enqueued */
+	if (!td_on_ring(&urb_priv->td[0], ep_ring)) {
+		xhci_err(xhci, "Canceled URB td not found on endpoint ring");
+		goto err_unlink_giveback;
+	}
+
 	if (xhci->xhc_state & XHCI_STATE_HALTED) {
 		xhci_dbg_trace(xhci, trace_xhci_dbg_cancel_urb,
-				"HC halted, freeing TD manually.");
-		for (i = urb_priv->num_tds_done;
-		     i < urb_priv->num_tds;
-		     i++) {
-			td = &urb_priv->td[i];
-			if (!list_empty(&td->td_list))
-				list_del_init(&td->td_list);
-			if (!list_empty(&td->cancelled_td_list))
-				list_del_init(&td->cancelled_td_list);
-		}
-		goto err_giveback;
+			       "HC halted, freeing TD manually.");
+		goto err_unlink_giveback;
 	}
 
 	i = urb_priv->num_tds_done;
@@ -1519,6 +1531,15 @@ static int xhci_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 	spin_unlock_irqrestore(&xhci->lock, flags);
 	return ret;
 
+err_unlink_giveback:
+	for (i = urb_priv->num_tds_done; i < urb_priv->num_tds; i++) {
+		td = &urb_priv->td[i];
+		if (!list_empty(&td->td_list))
+			list_del_init(&td->td_list);
+		if (!list_empty(&td->cancelled_td_list))
+			list_del_init(&td->cancelled_td_list);
+	}
+
 err_giveback:
 	if (urb_priv)
 		xhci_urb_free_priv(urb_priv);
-- 
2.7.4


--------------CCF90E165C54D8B35E62BA11
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------CCF90E165C54D8B35E62BA11--
