From: Fredrik Noring <noring-zgYzP9v7iJcdnm+yROfE0A@public.gmane.org>
Subject: Re: WARN_ON(irqs_disabled()) in dma_free_attrs?
Date: Sun, 4 Mar 2018 18:59:51 +0100
Message-ID: <20180304175949.GB2368@localhost.localdomain>
References: <20180303181904.GA19076@localhost.localdomain>
	<Pine.LNX.4.44L0.1803041054540.13805-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1803041054540.13805-100000-pYrvlCTfrz9XsRXLowluHWD2FQJk+8+b@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban-Mmb7MZpHnFY@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Alan Stern,

> > Alan, can dma_free_coherent be delayed to a point when IRQs are enabled?
> 
> Yes, subject to the usual concerns about not being delayed for too 
> long.  Also, some HCDs are highly memory-constrained.  I don't know if 
> they use this API, but if they do then delaying a free could result in 
> not enough memory being available when an allocation is needed.

The PS2 HCD in this case is limited to 256 KiB and memory allocation
failures can be observed frequently in USB traces (102 subsequent failures
in the trace below involving mass storage transactions, for example). Is
there any smartness to the allocations? My impression is that the USB core
loops until it gets what it wants, and then happily resumes. Does it busy
wait?

The RT3070 wireless USB device driver, for example, has hardcoded buffer
limits that exceed the total amount of available memory. It refuses to
accept devices unless adjusted in the source (as in the patch below), after
which it works nicely.

Other USB device drivers such as the one for the AR9271 wireless device
trigger endlessly repeating kernel warnings claiming

	BOGUS urb xfer, pipe 1 != type 3

as shown in this kernel backtrace:

------------[ cut here ]------------
WARNING: CPU: 0 PID: 15 at drivers/usb/core/urb.c:471 usb_submit_urb+0x280/0x528
usb 1-1: BOGUS urb xfer, pipe 1 != type 3
Modules linked in: ath9k_htc ath9k_common ath9k_hw ath mac80211 cfg80211 usbmon
CPU: 0 PID: 15 Comm: kworker/0:1 Tainted: G        W        4.15.0+ #831
Workqueue: events request_firmware_work_func
Stack : 00000009 000001d7 00000001 81714028 81714000 8006161c 80519af4 0000000f
        805e3b08 000001d7 80519a68 81cd3ad4 81714000 10058c00 81cd3aa8 80587340
        00000000 00000000 000003f8 00000007 00000000 000003f8 00000000 00000000
        00000040 00000008 00000000 81ccd288 00000000 00000000 803036a8 8053e854
        00000009 000001d7 00000001 81714028 00000008 ffffffc7 00000000 805e0000
        ...
Call Trace:
[<2318fb9b>] show_stack+0x74/0x104
[<cc3fea80>] __warn+0x118/0x120
[<01359d10>] warn_slowpath_fmt+0x30/0x3c
[<bfb4c964>] usb_submit_urb+0x280/0x528
[<89eb7b59>] hif_usb_send+0x3b0/0x3e0 [ath9k_htc]
[<51446a9c>] ath9k_wmi_cmd+0x194/0x228 [ath9k_htc]
[<2119badc>] ath9k_regread+0x5c/0x88 [ath9k_htc]
[<f56172da>] ath9k_hw_wait+0xa4/0xc0 [ath9k_hw]
[<368b3c01>] ath9k_hw_set_reset_reg+0x23c/0x288 [ath9k_hw]
[<28807ea6>] ath9k_hw_init+0x3e8/0xa24 [ath9k_hw]
[<a3367fed>] ath9k_htc_probe_device+0x38c/0xa2c [ath9k_htc]
[<da4d1bbe>] ath9k_htc_hw_init+0x20/0x4c [ath9k_htc]
[<6500cd86>] ath9k_hif_usb_firmware_cb+0x780/0x854 [ath9k_htc]
[<b4730ad0>] request_firmware_work_func+0x40/0x70
[<54f8834a>] process_one_work+0x1f4/0x358
[<23b84d12>] worker_thread+0x354/0x4b8
[<583bf61b>] kthread+0x134/0x13c
[<213b5c9e>] ret_from_kernel_thread+0x14/0x1c
---[ end trace 2a97c69dce30b650 ]---

I don't know if this is related to memory limitations or some other problem
though.

Fredrik

--- a/drivers/net/wireless/ralink/rt2x00/rt2800usb.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800usb.c
@@ -871,7 +871,7 @@ static void rt2800usb_queue_init(struct data_queue *queue)
 
 	switch (queue->qid) {
 	case QID_RX:
-		queue->limit = 128;
+		queue->limit = 8;
 		queue->data_size = AGGREGATION_SIZE;
 		queue->desc_size = RXINFO_DESC_SIZE;
 		queue->winfo_size = rxwi_size;
@@ -882,7 +882,7 @@ static void rt2800usb_queue_init(struct data_queue *queue)
 	case QID_AC_VI:
 	case QID_AC_BE:
 	case QID_AC_BK:
-		queue->limit = 16;
+		queue->limit = 8;
 		queue->data_size = AGGREGATION_SIZE;
 		queue->desc_size = TXINFO_DESC_SIZE;
 		queue->winfo_size = txwi_size;

...
81f58280 299082198 C Bi:1:003:1 0 13 = 55534253 ...
81f58280 299082510 S Bo:1:003:2 -150 31 = 55534243 ...
81f58280 299083200 C Bo:1:003:2 0 31 >
81f9aa00 299083298 S Bi:1:003:1 -150 65536 <
81f9a800 299093849 S Ci:1:002:0 s c0 07 0000 1700 0004 4 <
81f9ab00 299095041 S Bi:1:003:1 -150 8192 <
81f9a800 299095229 C Ci:1:002:0 0 4 = 2d000000
81f9a680 299096808 S Bi:1:003:1 -150 49152 <
81f9a680 299096838 E Bi:1:003:1 -12 0
81f9a680 299097868 S Bi:1:003:1 -150 49152 <
81f9a680 299097896 E Bi:1:003:1 -12 0
81f9a680 299098894 S Bi:1:003:1 -150 49152 <
... 97 allocation failures repeated ...
81f9a680 299151156 S Bi:1:003:1 -150 49152 <
81f9a680 299151166 E Bi:1:003:1 -12 0
81f9a680 299151179 S Bi:1:003:1 -150 49152 <
81f9a680 299151190 E Bi:1:003:1 -12 0
81f9a680 299151203 S Bi:1:003:1 -150 49152 <
81f9a680 299151216 E Bi:1:003:1 -12 0
81f9a680 299151231 S Bi:1:003:1 -150 49152 <
81f9a680 299159909 S Bi:1:003:1 -150 49152 <
81f9a680 299160814 S Bi:1:003:1 -150 49152 <
81f9a680 299161732 S Bi:1:003:1 -150 49152 <
81f9a680 299162644 S Bi:1:003:1 -150 49152 <
81f9a680 299163574 S Bi:1:003:1 -150 49152 <
81f9a680 299164490 S Bi:1:003:1 -150 49152 <
81f9aa00 299172593 C Bi:1:003:1 0 65536 = f7b07b39 ...
81f9ab00 299175259 C Bi:1:003:1 0 8192 = 26e2c254 ...
81f9a680 299177824 S Bi:1:003:1 -150 49152 <
81f9a680 299239323 C Bi:1:003:1 0 49152 = a21c1219 ...
81f58280 299239459 S Bi:1:003:1 -150 13 <
81f58280 299241264 C Bi:1:003:1 0 13 = 55534253 ...
81f58280 299241580 S Bo:1:003:2 -150 31 = 55534243 ...
81f58280 299242263 C Bo:1:003:2 0 31 >
...
