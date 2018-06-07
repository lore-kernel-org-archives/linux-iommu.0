From: Mathias Nyman <mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: usb HC busted?
Date: Thu, 7 Jun 2018 10:40:03 +0300
Message-ID: <2e8829c2-850d-6bca-5f0c-58a809dc9499@linux.intel.com>
References: <20180518100650.kfw6wijpncpvqx7j@debian>
	<6790b352-add3-5531-115c-15db6c9c744d@intel.com>
	<20180518130458.v73syr3fltdzdzzi@debian>
	<881d576b-c7c1-ef74-c6bc-68b81371e7e0@intel.com>
	<20180523212956.n4ztasdffg2aeaku@debian>
	<80eace7a-976d-65a5-a353-54a2b18edd06@linux.intel.com>
	<20180604152848.db3msouyi4ektvv6@debian>
	<06226ecb-baad-cc36-e9e3-797dabb0aa5e@linux.intel.com>
	<42ec4ab07d96b4302b875ac9c5eb76675bf85690.camel@linux.intel.com>
	<20180606164524.n4vb7xre6rykzxih@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180606164524.n4vb7xre6rykzxih@debian>
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
To: Sudip Mukherjee <sudipm.mukherjee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Mathias Nyman <mathias.nyman-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, lukaszx.szulc-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 06.06.2018 19:45, Sudip Mukherjee wrote:
> Hi Andy,
> 
> And we meet again. :)
> 
> On Wed, Jun 06, 2018 at 06:36:35PM +0300, Andy Shevchenko wrote:
>> On Wed, 2018-06-06 at 17:12 +0300, Mathias Nyman wrote:
>>> On 04.06.2018 18:28, Sudip Mukherjee wrote:
>>>> On Thu, May 24, 2018 at 04:35:34PM +0300, Mathias Nyman wrote:
>>>>>
>>
>>> Odd and unlikely, but to me this looks like some issue in allocating
>>> dma memory
>>> from pool using dma_pool_zalloc()
>>>
>>> Adding people with DMA knowledge to cc, maybe someone knows what is
>>> going on.
>>>
>>> Here's the story:
>>> Sudip sees usb issues on a Intel Atom based board with 4.14.2 kernel.
>>> All tracing points to dma_pool_zalloc() returning the same dma address
>>> block on
>>> consecutive calls.
>>>
>>> In the failing case dma_pool_zalloc() is called 3 - 6us apart.
>>>
>>> <...>-26362 [002] ....  1186.756739: xhci_ring_mem_detail: MATTU
>>> xhci_segment_alloc dma @ 0x000000002d92b000
>>> <...>-26362 [002] ....  1186.756745: xhci_ring_mem_detail: MATTU
>>> xhci_segment_alloc dma @ 0x000000002d92b000
>>> <...>-26362 [002] ....  1186.756748: xhci_ring_mem_detail: MATTU
>>> xhci_segment_alloc dma @ 0x000000002d92b000
>>>
>>> dma_pool_zalloc() is called from xhci_segment_alloc() in
>>> drivers/usb/host/xhci-mem.c
>>> see:
>>> https://elixir.bootlin.com/linux/v4.14.2/source/drivers/usb/host/xhci-
>>> mem.c#L52
>>>
>>> prints above are custom traces added right after dma_pool_zalloc()
>>
>> For better understanding it would be good to have dma_pool_free() calls
>> debugged as well.
> 
> So, I am adding another trace event for dma_pool_free() and continuing
> with the test. Is there anything else that I should be adding as debug?
> 

The patch traced both dma_pool_zalloc() and dma_pool_free() calls from xhci,
no need to retry.

Sudip has a full (394M unpacked) trace at:
https://drive.google.com/open?id=1h-3r-1lfjg8oblBGkzdRIq8z3ZNgGZx-

Interesting part is:

<...>-26362 [002] ....  1186.756728: xhci_ring_mem_detail: MATTU xhci_segment_alloc dma @ 0x000000002d34d000
<...>-26362 [002] ....  1186.756735: xhci_ring_mem_detail: MATTU xhci segment alloc seg->dma @ 0x000000002d34d000
<...>-26362 [002] ....  1186.756739: xhci_ring_mem_detail: MATTU xhci_segment_alloc dma @ 0x000000002d92b000
<...>-26362 [002] ....  1186.756740: xhci_ring_mem_detail: MATTU xhci segment alloc seg->dma @ 0x000000002d92b000
<...>-26362 [002] ....  1186.756743: xhci_ring_alloc: ISOC eefa0580: enq 0x000000002d34d000(0x000000002d34d000) deq 0x000000002d34d000(0x000000002d34d000) segs 2 stream 0 free_trbs 509 bounce 17 cycle 1
<...>-26362 [002] ....  1186.756745: xhci_ring_mem_detail: MATTU xhci_segment_alloc dma @ 0x000000002d92b000
<...>-26362 [002] ....  1186.756746: xhci_ring_mem_detail: MATTU xhci segment alloc seg->dma @ 0x000000002d92b000
<...>-26362 [002] ....  1186.756748: xhci_ring_mem_detail: MATTU xhci_segment_alloc dma @ 0x000000002d92b000
<...>-26362 [002] ....  1186.756751: xhci_ring_mem_detail: MATTU xhci segment alloc seg->dma @ 0x000000002d92b000
<...>-26362 [002] ....  1186.756752: xhci_ring_alloc: ISOC f19d7c80: enq 0x000000002d92b000(0x000000002d92b000) deq 0x000000002d92b000(0x000000002d92b000) segs 2 stream 0 free_trbs 509 bounce 17 cycle 1
<...>-26362 [002] d..1  1186.756761: xhci_queue_trb: CMD: Configure Endpoint Command: ctx 000000002ce96000 slot 7 flags d:C
<...>-26362 [002] d..1  1186.756762: xhci_inc_enq: CMD ed930b80: enq 0x000000002d93adb0(0x000000002d93a000) deq 0x000000002d93ada0(0x000000002d93a000) segs 1 stream 0 free_trbs 253 bounce 0 \
cycle 1
<...>-26362 [002] ....  1186.757066: xhci_dbg_context_change: Successful Endpoint Configure command
<...>-26362 [002] ....  1186.757072: xhci_ring_free: ISOC eefd9380: enq 0x000000002c482000(0x000000002c482000) deq 0x000000002c482000(0x000000002c482000) segs 2 stream 0 free_trbs 509 bounce0 cycle 1
<...>-26362 [002] ....  1186.757075: xhci_ring_mem_detail: MATTU xhci segment free seg->dma @ ee2d23c8
<...>-26362 [002] ....  1186.757078: xhci_ring_mem_detail: MATTU xhci segment free seg->dma @ c7a93488
<...>-26362 [002] ....  1186.757080: xhci_ring_free: ISOC eef0d800: enq 0x000000002c50a000(0x000000002c50a000) deq 0x000000002c50a000(0x000000002c50a000) segs 2 stream 0 free_trbs 509 bounce0 cycle 1

What is shown is the allocation of two ISOC transfer rings, each ring has 2 segments (two dma_pool_zalloc() calls per ring)
First ring looks normal, ring1 get dma memory at 0x2d34d000 for first ring segment, and dma memory at 0x2d92b000 for second segment.

But then it gets stuck, for the whole ring2 dma_pool_zalloc() just returns the same dma address as the last segment for
ring1:0x2d92b000. Last part of trace snippet is just another ring being freed.

Full testpatch looked like this:

diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index e5ace89..7d343ad 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -44,10 +44,15 @@ static struct xhci_segment *xhci_segment_alloc(struct xhci_hcd *xhci,
  		return NULL;
  	}
  
+	xhci_dbg_trace(xhci,  trace_xhci_ring_mem_detail,
+		       "MATTU xhci_segment_alloc dma @ %pad", &dma);
+
  	if (max_packet) {
  		seg->bounce_buf = kzalloc(max_packet, flags);
  		if (!seg->bounce_buf) {
  			dma_pool_free(xhci->segment_pool, seg->trbs, dma);
+			xhci_dbg_trace(xhci,  trace_xhci_ring_mem_detail,
+				       "MATTU xhci segment free dma @ %pad", &dma);
  			kfree(seg);
  			return NULL;
  		}
@@ -58,6 +63,9 @@ static struct xhci_segment *xhci_segment_alloc(struct xhci_hcd *xhci,
  			seg->trbs[i].link.control |= cpu_to_le32(TRB_CYCLE);
  	}
  	seg->dma = dma;
+	xhci_dbg_trace(xhci,  trace_xhci_ring_mem_detail,
+		       "MATTU xhci segment alloc seg->dma @ %pad", &seg->dma);
+
  	seg->next = NULL;
  
  	return seg;
@@ -67,6 +75,8 @@ static void xhci_segment_free(struct xhci_hcd *xhci, struct xhci_segment *seg)
  {
  	if (seg->trbs) {
  		dma_pool_free(xhci->segment_pool, seg->trbs, seg->dma);
+		xhci_dbg_trace(xhci,  trace_xhci_ring_mem_detail,
+			       "MATTU xhci segment free seg->dma @ %p", &seg->dma);
  		seg->trbs = NULL;
  	}
  	kfree(seg->bounce_buf);
diff --git a/drivers/usb/host/xhci-trace.h b/drivers/usb/host/xhci-trace.h
index 35bdd06..951e371 100644
--- a/drivers/usb/host/xhci-trace.h
+++ b/drivers/usb/host/xhci-trace.h
@@ -72,6 +72,11 @@ DEFINE_EVENT(xhci_log_msg, xhci_dbg_ring_expansion,
  	TP_ARGS(vaf)
  );
  
+DEFINE_EVENT(xhci_log_msg, xhci_ring_mem_detail,
+	TP_PROTO(struct va_format *vaf),
+	TP_ARGS(vaf)
+);
+
  DECLARE_EVENT_CLASS(xhci_log_ctx,
  	TP_PROTO(struct xhci_hcd *xhci, struct xhci_container_ctx *ctx,
  		 unsigned int ep_num),
-- 

-Mathias
