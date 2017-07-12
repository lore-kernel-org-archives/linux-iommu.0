From: Federico Vaga <federico.vaga-VIMSii5OdOuonA0d6jMUrA@public.gmane.org>
Subject: Re: IOMMU - DMA debugging
Date: Wed, 12 Jul 2017 14:15:34 +0200
Message-ID: <2775295.95PBxBV1eL@harkonnen>
References: <1807773.bRUB8Ke59R@harkonnen>
	<1c0e4473-9b50-fe0c-d544-71464360ab7f@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1c0e4473-9b50-fe0c-d544-71464360ab7f-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Thank you Robin

(inline comments)

On Wednesday, July 12, 2017 1:10:51 PM CEST Robin Murphy wrote:
> On 12/07/17 08:11, Federico Vaga wrote:
> > Hello,
> > 
> > kernel version 4.4.x
> > 
> > I'm facing an issue with the INTEL IOMMU driver and DMA mapping. I have an
> > Ethernet driver that uses `dma_alloc_coherent()` to allocate and map some
> > memory for DMA transfers.
> 
> Assuming 02:00.0 is your actual endpoint and not some upstream aliasing
> bridge, is your driver definitely using the correct struct device
> pointer corresponding to that for its DMA API calls?
> 
> > The driver uses the DMA API as described in the documentation and I was
> > expecting the IOMMU to be transparent, but apparently it is not. When the
> > IOMMU is disabled the driver works fine, but when `intel_iommu=on|pt` then
> > it does not work
> > 
> > I enabled the iommu events in ftrace at boot time; a weird thing that I
> > noticed is that I do not see any map/unmap event in ftrace while I was
> > expecting to have some of them.
> 
> Note that intel-iommu implements its own DMA ops, so will not go via the
> IOMMU API abstraction in the DMA path - you'd need to trace
> intel_{alloc,free}_coherent() and intel_{map,unmap}_{page,sg}() to see
> what's actually being called.

Yes I know. Perhaps I'm missing something in the IOMMU code but I was 
expecting to see the event in:

/sys/kernel/debug/tracing/events/iommu/

I can see the various intel_* function. With SystemTap I tracked variables and 
everything looks fine to me. Indeed, I trust the intel-iommu.c code. And I 
think that the problem is on our side (driver, motherboard, BIOS, ...)

> > How can be debugged this kind of issue? Where should I look for troubles
> > (BIOS, Linux kernel, the ethernet driver, the ethernet device, PCI
> > bridges)?
> The faulting addresses below don't look like the kind of IOVAs that
> iommu=on mode would map things to, which would usually imply the driver
> calling the wrong DMA ops or erroneously bypassing the DMA API
> somewhere, but the fact that it also doesn't work in passthrough
> suggests something more fundamental,

I missed to make explicit the fact that with intel_iommu=off, it works fine.

> like the IOMMU being configured for the wrong requester ID entirely.
>
> Robin.
> 
> > Following the typical errors when `intel_iommu=on|pt`
> > 
> > Thank you
> > 
> > 
> > 
> > [...]
> > [ 1156.858606] DMAR: DRHD: handling fault status reg 302
> > [ 1156.864249] DMAR: DMAR:[DMA Read] Request device [02:00.0] fault addr
> > 3febf0
> > [ 1156.864249] DMAR:[fault reason 06] PTE Read access is not set
> > [ 1189.179531] DMAR: DRHD: handling fault status reg 402
> > [ 1189.185182] DMAR: DMAR:[DMA Write] Request device [02:00.0] fault addr
> > 6d9c7
> > [ 1189.185182] DMAR:[fault reason 05] PTE Write access is not set
> > [ 1196.313544] DMAR: DRHD: handling fault status reg 502
> > [ 1196.319194] DMAR: DMAR:[DMA Write] Request device [02:00.0] fault addr
> > 657bb
> > [ 1196.319194] DMAR:[fault reason 05] PTE Write access is not set
> > [ 1230.607870] DMAR: DRHD: handling fault status reg 602
> > [ 1230.613520] DMAR: DMAR:[DMA Write] Request device [02:00.0] fault addr
> > 16cfe
> > [ 1230.613520] DMAR:[fault reason 05] PTE Write access is not set
> > [ 1236.314332] DMAR: DRHD: handling fault status reg 702
> > [ 1236.319983] DMAR: DMAR:[DMA Write] Request device [02:00.0] fault addr
> > 6e59e
> > [ 1236.319983] DMAR:[fault reason 05] PTE Write access is not set
> > [ 1246.314521] DMAR: DRHD: handling fault status reg 2
> > [ 1246.319979] DMAR: DMAR:[DMA Write] Request device [02:00.0] fault addr
> > 7e59f
> > [ 1246.319979] DMAR:[fault reason 05] PTE Write access is not set
> > [ 1261.169485] DMAR: DRHD: handling fault status reg 102
> > [ 1261.175135] DMAR: DMAR:[DMA Write] Request device [02:00.0] fault addr
> > 7ddee
> > [ 1261.175135] DMAR:[fault reason 05] PTE Write access is not set
> > [ 1272.640611] DMAR: DRHD: handling fault status reg 202
> > [ 1272.646261] DMAR: DMAR:[DMA Write] Request device [02:00.0] fault addr
> > 7bbee
> > [ 1272.646261] DMAR:[fault reason 05] PTE Write access is not set


-- 
Federico Vaga
http://www.federicovaga.it/
