From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH 05/13] iommu/io-pgtable-arm: Allow appropriate DMA API use
Date: Tue, 04 Aug 2015 23:54:27 +0300
Message-ID: <1987558.GfG8OCqzMM@avalon>
References: <1438608355-7335-1-git-send-email-will.deacon@arm.com>
	<55C0D071.1040104@arm.com>
	<20150804145642.GQ7557@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150804145642.GQ7557-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>, Marc Zyngier <Marc.Zyngier-5wv7dgnIgG8@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Russell,

On Tuesday 04 August 2015 15:56:42 Russell King - ARM Linux wrote:
> On Tue, Aug 04, 2015 at 03:47:13PM +0100, Robin Murphy wrote:
> > Hi Laurent,
> > 
> > [ +RMK, as his patch is indirectly involved here ]
> > 
> > On 04/08/15 14:16, Laurent Pinchart wrote:
> >> This is what I believe to be an API abuse. The
> >> dma_sync_single_for_device()
> >> API is meant to pass ownership of a buffer to the device. Unless I'm
> >> mistaken, once that's done the CPU isn't allowed to touch the buffer
> >> anymore until dma_sync_single_for_cpu() is called to get ownership of
> >> the buffer back.
>
> That's what I thought up until recently, but it's not strictly true - see
> Documentation/DMA-API.txt which Robin quoted.

I find the documentation slightly unclear on this topic. I have nothing 
against updating it to state that the sync functions ensure visibility of the 
data to the device or CPU instead of transferring ownership if that's the 
general understanding of how the API work (or should work). This would of 
course need to be carefully reviewed to ensure that the current implementation 
really works that way across all architectures, or at least that it can be 
made to work that way.

> > [3]:Yes, there may generally be exceptions to that, but not in the context
> > of this code. Unless the Renesas IPMMU does something I don't know about?
> 
> If an IOMMU does write to its page tables, then the only way to handle
> those is using DMA-coherent memory, either via a coherent mapping or
> allocated via dma_alloc_coherent().  The streaming DMA API is wholely
> unsuitable for any mapping where both the CPU and DMA device both want
> to simultaneously alter the contained data.

-- 
Regards,

Laurent Pinchart
