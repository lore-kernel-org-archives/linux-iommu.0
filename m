From: Mathias Nyman <mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: usb HC busted?
Date: Fri, 20 Jul 2018 14:10:58 +0300
Message-ID: <d3f5575c-c75b-ea16-6da9-b2fe3cc9c102@linux.intel.com>
References: <20180717114104.irgdb5rmg2qxclgp@debian>
	<Pine.LNX.4.44L0.1807171022001.1689-100000@iolanthe.rowland.org>
	<20180717144022.4wabhdhysori3mvg@debian>
	<20180717144918.7ymzbhijxfcc3fhb@debian>
	<20180717151017.yk5d4glzwqcrxpqc@debian>
	<f7801c24-fa98-6338-0b26-33a0ac9498bb@linux.intel.com>
	<20180719113455.urktqxijzoyhfoou@debian>
	<ab814c88-0857-5444-57da-34c21b8d7f6c@linux.intel.com>
	<20180719173256.hc5aprma4biuqd4p@debian>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------9B3FAA6CDCAE530347B9BBF6"
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180719173256.hc5aprma4biuqd4p@debian>
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
--------------9B3FAA6CDCAE530347B9BBF6
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.07.2018 20:32, Sudip Mukherjee wrote:
> Hi Mathias,
> 
> On Thu, Jul 19, 2018 at 06:42:19PM +0300, Mathias Nyman wrote:
>>>> As first aid I could try to implement checks that make sure the flushed URBs
>>>> trb pointers really are on the current endpoint ring, and also add some warning
>>>> if we are we are dropping endpoints with URBs still queued.
>>>
>>> Yes, please. I think your first-aid will be a much better option than
>>> the hacky patch I am using atm.
>>>
>>
>> Attached a patch that checks canceled URB td/trb pointers.
>> I haven't tested it at all (well compiles and boots, but new code never exercised)
>>
>> Does it work for you?
> 
> No, not exactly. :(
> 
> I can see your message getting printed.
> [  249.518394] xhci_hcd 0000:00:14.0: Canceled URB td not found on endpoint ring
> [  249.518431] xhci_hcd 0000:00:14.0: Canceled URB td not found on endpoint ring
> 
> But I can see the message from slub debug again:
> 
> [  348.279986] =============================================================================
> [  348.279993] BUG kmalloc-96 (Tainted: G     U     O   ): Poison overwritten
> [  348.279995] -----------------------------------------------------------------------------
> 
> [  348.279997] Disabling lock debugging due to kernel taint
> [  348.280000] INFO: 0xe5acda60-0xe5acda67. First byte 0x60 instead of 0x6b
> [  348.280012] INFO: Allocated in xhci_ring_alloc.constprop.14+0x31/0x125 [xhci_hcd] age=129264 cpu=0 pid=33
...
> [  348.280095] INFO: Freed in xhci_ring_free+0xa7/0xc6 [xhci_hcd] age=98722 cpu=0 pid=33
...
> [  348.280158] INFO: Slab 0xf46e0fe0 objects=29 used=29 fp=0x  (null) flags=0x40008100
> [  348.280160] INFO: Object 0xe5acda48 @offset=6728 fp=0xe5acd700
> 
> [  348.280164] Redzone e5acda40: bb bb bb bb bb bb bb bb                          ........
> [  348.280167] Object e5acda48: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
> [  348.280169] Object e5acda58: 6b 6b 6b 6b 6b 6b 6b 6b 60 da ac e5 60 da ac e5  kkkkkkkk`...`...

So poison is overwritten at e5acda58 with almost its own address, (reading backwards) e5 ac da 60, twice.
looks like something (32bit?)is pointing to itself twice, maybe a linked list node next and prev pointer
being set to point to itself as last item was removed from list.

The cancelled_td_list is part of struct xhci_virt_ep, so that should be fine.
But td_list is part of struct xhci_ring, which was freed. and we removed the URBs tds from the td_list when
flushing the ring after ring was freed

I changed the patch (attached) to make sure it doesn't touch the td_list when canceling a URB after
ring is freed.

How about this one, any improvements?

-Mathias  

  

--------------9B3FAA6CDCAE530347B9BBF6
Content-Type: text/x-patch;
 name="0001-xhci-when-dequeing-a-URB-make-sure-it-exists-on-the-.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-xhci-when-dequeing-a-URB-make-sure-it-exists-on-the-.pa";
 filename*1="tch"

>From ee48d9f9c2d82058489dcdc38faa34a3cbdb08d1 Mon Sep 17 00:00:00 2001
From: Mathias Nyman <mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Date: Thu, 19 Jul 2018 18:06:18 +0300
Subject: [PATCH v2] xhci: when dequeing a URB make sure it exists on the
 current endpoint ring.

If the endpoint ring has been reallocated since the URB was enqueued,
then URB may contain TD and TRB pointers to a already freed ring.
If this the case then manuallt return the URB without touching any of the
freed ring structure data.

Don't try to stop the ring. It would be useless.

This can happened if endpoint is not flushed before it is dropped and
re-added, which is the case in usb_set_interface() as xhci does
things in an odd order.

Signed-off-by: Mathias Nyman <mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/usb/host/xhci.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 711da33..7093341 100644
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
@@ -1467,6 +1482,21 @@ static int xhci_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 		goto done;
 	}
 
+	/*
+	 * check ring is not re-allocated since URB was enqueued. If it is, then
+	 * make sure none of the ring related pointers in this URB private data
+	 * are touched, such as td_list, otherwise we overwrite freed data
+	 */
+	if (!td_on_ring(&urb_priv->td[0], ep_ring)) {
+		xhci_err(xhci, "Canceled URB td not found on endpoint ring");
+		for (i = urb_priv->num_tds_done; i < urb_priv->num_tds; i++) {
+			td = &urb_priv->td[i];
+			if (!list_empty(&td->cancelled_td_list))
+				list_del_init(&td->cancelled_td_list);
+		}
+		goto err_giveback;
+	}
+
 	if (xhci->xhc_state & XHCI_STATE_HALTED) {
 		xhci_dbg_trace(xhci, trace_xhci_dbg_cancel_urb,
 				"HC halted, freeing TD manually.");
-- 
2.7.4


--------------9B3FAA6CDCAE530347B9BBF6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------9B3FAA6CDCAE530347B9BBF6--
