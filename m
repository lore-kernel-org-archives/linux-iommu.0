From: Mathias Nyman <mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: usb HC busted?
Date: Wed, 6 Jun 2018 17:12:21 +0300
Message-ID: <06226ecb-baad-cc36-e9e3-797dabb0aa5e@linux.intel.com>
References: <20180518100650.kfw6wijpncpvqx7j@debian>
	<6790b352-add3-5531-115c-15db6c9c744d@intel.com>
	<20180518130458.v73syr3fltdzdzzi@debian>
	<881d576b-c7c1-ef74-c6bc-68b81371e7e0@intel.com>
	<20180523212956.n4ztasdffg2aeaku@debian>
	<80eace7a-976d-65a5-a353-54a2b18edd06@linux.intel.com>
	<20180604152848.db3msouyi4ektvv6@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180604152848.db3msouyi4ektvv6@debian>
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
Cc: Mathias Nyman <mathias.nyman-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, lukaszx.szulc-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 04.06.2018 18:28, Sudip Mukherjee wrote:
> On Thu, May 24, 2018 at 04:35:34PM +0300, Mathias Nyman wrote:
>>
>> Log show two rings having the same TRB segment dma address, this will completely mess up the transfer:
>>
>> While allocating rigs the enque pointers for the two rings are the same:
>>
>> 461.859315: xhci_ring_alloc: ISOC efa4e580: enq 0x0000000033386000(0x0000000033386000) deq 0x0000000033386000(0x0000000033386000) segs 2 stream 0 ...bs
>> 461.859320: xhci_ring_alloc: ISOC f0ce1f00: enq 0x0000000033386000(0x0000000033386000) deq 0x0000000033386000(0x0000000033386000) segs 2 stream 0 ...
>>
>> So something goes really wrong when allocating or setting up the rings in one of these functions:
>>
>> To verify and rule out dma_pool_zalloc(), could you apply the attached patch and reproduce with new logs?
> 
> I spoke too soon in my yesterday's mail. We were able to reproduce it
> on the automated tests. The log and the trace is at:
> https://drive.google.com/open?id=1h-3r-1lfjg8oblBGkzdRIq8z3ZNgGZx-
> 
> Will request you to have a look at it.
> 

Odd and unlikely, but to me this looks like some issue in allocating dma memory
from pool using dma_pool_zalloc()

Adding people with DMA knowledge to cc, maybe someone knows what is going on.

Here's the story:
Sudip sees usb issues on a Intel Atom based board with 4.14.2 kernel.
All tracing points to dma_pool_zalloc() returning the same dma address block on
consecutive calls.

In the failing case dma_pool_zalloc() is called 3 - 6us apart.

<...>-26362 [002] ....  1186.756739: xhci_ring_mem_detail: MATTU xhci_segment_alloc dma @ 0x000000002d92b000
<...>-26362 [002] ....  1186.756745: xhci_ring_mem_detail: MATTU xhci_segment_alloc dma @ 0x000000002d92b000
<...>-26362 [002] ....  1186.756748: xhci_ring_mem_detail: MATTU xhci_segment_alloc dma @ 0x000000002d92b000

dma_pool_zalloc() is called from xhci_segment_alloc() in drivers/usb/host/xhci-mem.c
see:
https://elixir.bootlin.com/linux/v4.14.2/source/drivers/usb/host/xhci-mem.c#L52

prints above are custom traces added right after dma_pool_zalloc()
@@ -44,10 +44,15 @@ static struct xhci_segment *xhci_segment_alloc(struct xhci_hcd *xhci,
  		return NULL;
  	}
  
+	xhci_dbg_trace(xhci,  trace_xhci_ring_mem_detail,
+		       "MATTU xhci_segment_alloc dma @ %pad", &dma);
+

Any idea what's going on?
dma_pool_alloc() has a comment that it drops &pool->lock if it needs to allocate
a page, can it be related?

Thanks
-Mathias
