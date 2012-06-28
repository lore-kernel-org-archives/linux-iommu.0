From: Lucas Stach <dev-8ppwABl0HbeELgA04lAiVw@public.gmane.org>
Subject: Re: Tegra DRM device tree bindings
Date: Thu, 28 Jun 2012 19:01:29 +0200
Message-ID: <1340902889.1348.10.camel@antimon>
References: <23B010BBA481A74B98487467C29BA57BF2361DA3AA@HKMAIL01.nvidia.com>
	<4FEA6E09.30800@nvidia.com>
	<23B010BBA481A74B98487467C29BA57BF2361DA3C4@HKMAIL01.nvidia.com>
	<4FEA7472.7050201@nvidia.com>
	<20120627051418.GB7177@avionic-0098.mockup.avionic-design.de>
	<20120627155907.871b2a506374b7db14c202c4@nvidia.com>
	<20120627140809.GD19319@avionic-0098.mockup.avionic-design.de>
	<20120627172914.30a2ccfd1344161ca7724722@nvidia.com>
	<20120627144414.GA20681@avionic-0098.mockup.avionic-design.de>
	<1340812795.1350.7.camel@antimon>
	<20120628111253.GC15137@avionic-0098.mockup.avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20120628111253.GC15137-RM9K5IK7kjIQXX3q8xo1gnVAuStQJXxyR5q1nwbD4aMs9pC9oP6+/A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Cc: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Mark Zhang <markz-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Thierry,

Am Donnerstag, den 28.06.2012, 13:12 +0200 schrieb Thierry Reding:
> On Wed, Jun 27, 2012 at 05:59:55PM +0200, Lucas Stach wrote:
> > Am Mittwoch, den 27.06.2012, 16:44 +0200 schrieb Thierry Reding:
> > > On Wed, Jun 27, 2012 at 05:29:14PM +0300, Hiroshi Doyu wrote:
> > > > On Wed, 27 Jun 2012 16:08:10 +0200
> > > > Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org> wrote:
> > > > 
> > > > > * PGP Signed by an unknown key
> > > > > 
> > > > > On Wed, Jun 27, 2012 at 03:59:07PM +0300, Hiroshi Doyu wrote:
> > > > > > On Wed, 27 Jun 2012 07:14:18 +0200
> > > > > > Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org> wrote:
> > > > > > 
> > > > > > > > Old Signed by an unknown key
> > > > > > > 
> > > > > > > On Tue, Jun 26, 2012 at 08:48:18PM -0600, Stephen Warren wrote:
> > > > > > > > On 06/26/2012 08:32 PM, Mark Zhang wrote:
> > > > > > > > >> On 06/26/2012 07:46 PM, Mark Zhang wrote:
> > > > > > > > >>>>> On Tue, 26 Jun 2012 12:55:13 +0200
> > > > > > > > >>>>> Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org> wrote:
> > > > > > > > >> ...
> > > > > > > > >>>> I'm not sure I understand how information about the carveout would be
> > > > > > > > >>>> obtained from the IOMMU API, though.
> > > > > > > > >>>
> > > > > > > > >>> I think that can be similar with current gart implementation. Define carveout as:
> > > > > > > > >>>
> > > > > > > > >>> carveout {
> > > > > > > > >>>         compatible = "nvidia,tegra20-carveout";
> > > > > > > > >>>         size = <0x10000000>;
> > > > > > > > >>> };
> > > > > > > > >>>
> > > > > > > > >>> Then create a file such like "tegra-carveout.c" to get these definitions and
> > > > > > > > >> register itself as platform device's iommu instance.
> > > > > > > > >>
> > > > > > > > >> The carveout isn't a HW object, so it doesn't seem appropriate to define a DT
> > > > > > > > >> node to represent it.
> > > > > > > > > 
> > > > > > > > > Yes. But I think it's better to export the size of carveout as a configurable item.
> > > > > > > > > So we need to define this somewhere. How about define carveout as a property of gart?
> > > > > > > > 
> > > > > > > > There already exists a way of preventing Linux from using certain chunks
> > > > > > > > of memory; the /memreserve/ syntax. From a brief look at the dtc source,
> > > > > > > > it looks like /memreserve/ entries can have labels, which implies that a
> > > > > > > > property in the GART node could refer to the /memreserve/ entry by
> > > > > > > > phandle in order to know what memory regions to use.
> > > > > > > 
> > > > > > > Wasn't the whole point of using a carveout supposed to be a replacement
> > > > > > > for the GART?
> > > > > > 
> > > > > > Mostly agree. IIUC, we use both carveout/gart allocated buffers in
> > > > > > android/tegra2.
> > > > > > 
> > > > > > >As such I'd think the carveout should rather be a property
> > > > > > > of the host1x device.
> > > > > > 
> > > > > > Rather than introducing a new property, how about using
> > > > > > "coherent_pool=??M" in the kernel command line if necessary? I think
> > > > > > that this carveout size depends on the system usage/load.
> > > > > 
> > > > > I was hoping that we could get away with using the CMA and perhaps
> > > > > initialize it based on device tree content. I agree that the carveout
> > > > > size depends on the use-case, but I still think it makes sense to
> > > > > specify it on a per-board basis.
> > > > 
> > > > DRM driver doesn't know if it uses CMA or not, because DRM only uses
> > > > DMA API.
> > > 
> > > So how is the DRM supposed to allocate buffers? Does it call the
> > > dma_alloc_from_contiguous() function to do that? I can see how it is
> > > used by arm_dma_ops but how does it end up in the driver?
> > > 
> > As I said before the DMA API is not a good fit for graphics drivers.
> > Most of the DMA buffers used by graphics cores are long lived and big,
> > so we need a special pool to alloc from to avoid eating all contiguous
> > address space, as DMA API does not provide shrinker callbacks for
> > clients using large amount of memory.
> 
> I recall you mentioning TTM as a better alternative several times in the
> past. How does it fit in with this? Does it have the capability of using
> a predefined chunk of contiguous memory as a pool to allocate from?
> 
> One problem that all of these solutions don't address is that not all
> devices below host1x are DRM related. At least for the CSI and VI blocks
> I expect there to be V4L2 drivers eventually, so what we really need is
> to manage allocations outside of the DRM. host1x is the most logical
> choice here.

I think you are right here. We might want to move all those
buffer/memory management in the host1x code and provide contig memory to
the host1x clients from there.

TTM has the ability to manage a chunk of memory for contig allocations.
Also I think TTM does not depend too heavily on DRM, so we may even be
able to use TTM as the general allocator for host1x clients, including
VI and others. The more advanced stuff in TTM like swapping and moving
buffers might be a bit of overkill for simple stuff like V4L, where you
basically just want something like: "give me a contig buffer and pin it
in address space so it won't ever move", but it should do no harm.

> 
> Perhaps we can put host1x code somewhere below drivers/gpu (mm
> subdirectory?), drivers/memory or perhaps some other or new location
> that could eventually host similar drivers for other SoCs.
> 
> Then again, maybe it'd be easier for now to put everything below the
> drivers/gpu/drm/tegra directory and cross that bridge when we get to it.
> 
> > > > I think that "coherent_pool" can be used only when the amount of
> > > > contiguous memory is short in your system. Otherwise even unnecessary.
> > > > 
> > > > Could you explain a bit more why you want carveout size on per-board basis?
> > > 
> > > In the ideal case I would want to not have a carveout size at all.
> > > However there may be situations where you need to make sure some driver
> > > can allocate a given amount of memory. Having to specify this using a
> > > kernel command-line parameter is cumbersome because it may require
> > > changes to the bootloader or whatever. So if you know that a particular
> > > board always needs 128 MiB of carveout, then it makes sense to specify
> > > it on a per-board basis.
> > 
> > If we go with CMA, this is a non-issue, as CMA allows to use the contig
> > area for normal allocations and only purges them if it really needs the
> > space for contig allocs.
> 
> CMA certainly sounds like the most simple approach. While it may not be
> suited for 3D graphics or multimedia processing later on, I think we
> could use it at a starting point to get basic framebuffer and X support
> up and running. We can always move to something more advanced like TTM
> later.
> 
> Thierry
