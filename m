From: Fredrik Noring <noring-zgYzP9v7iJcdnm+yROfE0A@public.gmane.org>
Subject: Re: WARN_ON(irqs_disabled()) in dma_free_attrs?
Date: Sun, 11 Mar 2018 19:01:25 +0100
Message-ID: <20180311180124.GA27731@localhost.localdomain>
References: <20180302180704.GA3846@localhost.localdomain>
	<20180302213711.GA30356@lst.de>
	<20180303082234.GB24991@localhost.localdomain>
	<20180303161249.GA9516@lst.de>
	<20180303181904.GA19076@localhost.localdomain>
	<20180305151010.GA15965@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180305151010.GA15965-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban-Mmb7MZpHnFY@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Christoph,

> The point is that you should always use a pool, period.
> dma_alloc*/dma_free* are fundamentally expensive operations on my
> architectures, so if you call them from a fast path you are doing
> something wrong.

The author's comment in commit b3476675320e "usb: dma bounce buffer support"
seems to suggest that the greatest concern is space efficiency as opposed to
speed. I tried to evaluate strict pool allocations, similar to the patch
below, but that didn't turn out as I expected.

I chose a 64 KiB pool maximum since it has been the largest requested size I
have observed in USB traces (which may not hold in general, of course). This
change caused the USB mass storage driver to get stuck in some kind of memory
deadlock, with endless busy-looping on 64 KiB allocation failures.

I also tried a progression of pool sizes including nonpowers of two, for
example 12288, to make better use of the 256 KiB memory capacity. However,
the following part of dma_pool_create in linux/mm/dmapool.c is somewhat
puzzling:

	if (!boundary)
		boundary = allocation;
	else if ((boundary < size) || (boundary & (boundary - 1)))
		return NULL;

Is the boundary variable required to be a power of two only when it is
explicitly given as nonzero?

Fredrik

diff --git a/drivers/usb/core/buffer.c b/drivers/usb/core/buffer.c
index 77eef8acff94..8cc8fbc91c76 100644
--- a/drivers/usb/core/buffer.c
+++ b/drivers/usb/core/buffer.c
@@ -26,7 +26,7 @@
 
 /* FIXME tune these based on pool statistics ... */
 static size_t pool_max[HCD_BUFFER_POOLS] = {
-	32, 128, 512, 2048,
+	32, 128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32768, 65536
 };
 
 void __init usb_init_pool_max(void)
@@ -76,7 +76,7 @@ int hcd_buffer_create(struct usb_hcd *hcd)
 			continue;
 		snprintf(name, sizeof(name), "buffer-%d", size);
 		hcd->pool[i] = dma_pool_create(name, hcd->self.sysdev,
-				size, size, 0);
+				size, min_t(size_t, 4096, size), 0);
 		if (!hcd->pool[i]) {
 			hcd_buffer_destroy(hcd);
 			return -ENOMEM;
@@ -140,7 +140,7 @@ void *hcd_buffer_alloc(
 		if (size <= pool_max[i])
 			return dma_pool_alloc(hcd->pool[i], mem_flags, dma);
 	}
-	return dma_alloc_coherent(hcd->self.sysdev, size, dma, mem_flags);
+	return NULL;
 }
 
 void hcd_buffer_free(
@@ -169,5 +169,5 @@ void hcd_buffer_free(
 			return;
 		}
 	}
-	dma_free_coherent(hcd->self.sysdev, size, addr, dma);
+	BUG();		/* The buffer could not have been allocated. */
 }
diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
index 176900528822..2075f1e22e32 100644
--- a/include/linux/usb/hcd.h
+++ b/include/linux/usb/hcd.h
@@ -189,7 +189,7 @@ struct usb_hcd {
 	struct usb_hcd		*primary_hcd;
 
 
-#define HCD_BUFFER_POOLS	4
+#define HCD_BUFFER_POOLS	11
 	struct dma_pool		*pool[HCD_BUFFER_POOLS];
 
 	int			state;
