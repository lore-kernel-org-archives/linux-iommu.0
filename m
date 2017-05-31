From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: Device address specific mapping of arm,mmu-500
Date: Wed, 31 May 2017 13:44:19 +0100
Message-ID: <20170531124418.GE9723@arm.com>
References: <1b79efe2-6835-7a7a-f5ad-361391a7b967@broadcom.com>
	<20170530151437.GC23067@arm.com>
	<81637642-22d9-4868-156f-052f64bd042f@broadcom.com>
	<226bcebc-3902-90d3-24e5-51f2e1f3affb@arm.com>
	<a85b2e3f-93db-7c4d-cde8-32a57e69bef9@broadcom.com>
	<16e5fc9d-b014-af7c-dcda-527522ac5cc9@arm.com>
	<b47a379e-4a1b-42ff-8604-01b5becd685c@broadcom.com>
	<7bd03bf8-71d5-a974-bea2-a38b4349c547@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <7bd03bf8-71d5-a974-bea2-a38b4349c547-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Ray Jui <ray.jui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, May 30, 2017 at 11:13:36PM -0700, Ray Jui wrote:
> I did a little more digging myself and I think I now understand what you
> meant by identity mapping, i.e., configuring the MMU-500 with 1:1 mapping
> between the DMA address and the IOVA address.
> 
> I think that should work. In the end, due to this MSI write parsing issue in
> our PCIe controller, the reason to use IOMMU is to allow the cache
> attributes (AxCACHE) of the MSI writes towards GICv3 ITS to be modified by
> the IOMMU to be device type, while leaving the rest of inbound reads/writes
> from/to DDR with more optimized cache attributes setting, to allow I/O
> coherency to be still enabled for the PCIe controller. In fact, the PCIe
> controller itself is fully capable of DMA to/from the full address space of
> our SoC including both DDR and any device memory.
> 
> The 1:1 mapping will still pose some translation overhead like you
> suggested; however, the overhead of allocating page tables and locking will
> be gone. This sounds like the best possible option I have currently.

It might end up being pretty invasive to work around a hardware bug, so
we'll have to see what it looks like. Ideally, we could just use the SMMU
for everything as-is and work on clawing back the lost performance (it
should be possible to get ~95% of the perf if we sort out the locking, which
we *are* working on).

> May I ask, how do I start to try to get this identity mapping to work as an
> experiment and proof of concept? Any pointer or advise is highly appreciated
> as you can see I'm not very experienced with this. I found Will recently
> added the IOMMU_DOMAIN_IDENTITY support to the arm-smmu driver. But I
> suppose that is to bypass the SMMU completely, instead of still going
> through the MMU with 1:1 translation. Is my understanding correct?

Yes, I don't think IOMMU_DOMAIN_IDENTITY is what you need because you
actally need per-page control of memory attributes.

Robin might have a better idea, but I think you'll have to hack dma-iommu.c
so that you can have a version of the DMA ops that:

  * Initialises the identity map (I guess as normal WB cacheable?)
  * Reserves and maps the MSI region appropriately
  * Just returns the physical address for the dma address for map requests
    (return error for the MSI region)
  * Does nothing for unmap requests

But my strong preference would be to fix the locking overhead from the
SMMU so that the perf hit is acceptable.

Will
