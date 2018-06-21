From: Sudip Mukherjee <sudipm.mukherjee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: usb HC busted?
Date: Thu, 21 Jun 2018 01:53:32 +0100
Message-ID: <20180621005332.5uy74tkjoel6w4xy@debian>
References: <6790b352-add3-5531-115c-15db6c9c744d@intel.com>
	<20180518130458.v73syr3fltdzdzzi@debian>
	<881d576b-c7c1-ef74-c6bc-68b81371e7e0@intel.com>
	<20180523212956.n4ztasdffg2aeaku@debian>
	<80eace7a-976d-65a5-a353-54a2b18edd06@linux.intel.com>
	<20180604152848.db3msouyi4ektvv6@debian>
	<06226ecb-baad-cc36-e9e3-797dabb0aa5e@linux.intel.com>
	<42ec4ab07d96b4302b875ac9c5eb76675bf85690.camel@linux.intel.com>
	<20180606164524.n4vb7xre6rykzxih@debian>
	<2e8829c2-850d-6bca-5f0c-58a809dc9499@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <2e8829c2-850d-6bca-5f0c-58a809dc9499-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Mathias Nyman <mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Mathias Nyman <mathias.nyman-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, lukaszx.szulc-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Mathias, Andy,

On Thu, Jun 07, 2018 at 10:40:03AM +0300, Mathias Nyman wrote:
> On 06.06.2018 19:45, Sudip Mukherjee wrote:
> > Hi Andy,
> > 
> > And we meet again. :)
> > 
> > On Wed, Jun 06, 2018 at 06:36:35PM +0300, Andy Shevchenko wrote:
> > > On Wed, 2018-06-06 at 17:12 +0300, Mathias Nyman wrote:
> > > > On 04.06.2018 18:28, Sudip Mukherjee wrote:
> > > > > On Thu, May 24, 2018 at 04:35:34PM +0300, Mathias Nyman wrote:
> > > > > > 
> > > 
> > > > Odd and unlikely, but to me this looks like some issue in allocating
> > > > dma memory
> > > > from pool using dma_pool_zalloc()
> > > > 
> > > > 
> > > > Here's the story:
> > > > Sudip sees usb issues on a Intel Atom based board with 4.14.2 kernel.
> > > > All tracing points to dma_pool_zalloc() returning the same dma address
> > > > block on
> > > > consecutive calls.
> > > > 
> > > > In the failing case dma_pool_zalloc() is called 3 - 6us apart.
> > > > 
> > > > <...>-26362 [002] ....  1186.756739: xhci_ring_mem_detail: MATTU
> > > > xhci_segment_alloc dma @ 0x000000002d92b000
> > > > <...>-26362 [002] ....  1186.756745: xhci_ring_mem_detail: MATTU
> > > > xhci_segment_alloc dma @ 0x000000002d92b000
> > > > <...>-26362 [002] ....  1186.756748: xhci_ring_mem_detail: MATTU
> > > > xhci_segment_alloc dma @ 0x000000002d92b000
> > > > 
> > > > dma_pool_zalloc() is called from xhci_segment_alloc() in
> > > > drivers/usb/host/xhci-mem.c
> > > > see:
> > > > https://elixir.bootlin.com/linux/v4.14.2/source/drivers/usb/host/xhci-
> > > > mem.c#L52
> > > > 
> > > > prints above are custom traces added right after dma_pool_zalloc()
> > > 
> > > For better understanding it would be good to have dma_pool_free() calls
> > > debugged as well.
> > 
> 
> Sudip has a full (394M unpacked) trace at:
> https://drive.google.com/open?id=1h-3r-1lfjg8oblBGkzdRIq8z3ZNgGZx-
> 

<snip>

> But then it gets stuck, for the whole ring2 dma_pool_zalloc() just returns the same dma address as the last segment for
> ring1:0x2d92b000. Last part of trace snippet is just another ring being freed.

A gentle ping on this. Any idea on what the problem might be and any
possible fix?

--
regards
Sudip
