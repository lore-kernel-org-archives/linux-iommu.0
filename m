From: Lucas Stach <dev-8ppwABl0HbeELgA04lAiVw@public.gmane.org>
Subject: Re: Tegra DRM device tree bindings
Date: Thu, 28 Jun 2012 10:11:15 +0200
Message-ID: <1340871075.1377.12.camel@antimon>
References: <20120626160224.40ba10a26e3dd3a56b1f312c@nvidia.com>
	<20120626140033.GC1115@avionic-0098.mockup.avionic-design.de>
	<23B010BBA481A74B98487467C29BA57BF2361DA3AA@HKMAIL01.nvidia.com>
	<4FEA6E09.30800@nvidia.com>
	<23B010BBA481A74B98487467C29BA57BF2361DA3C4@HKMAIL01.nvidia.com>
	<4FEA7472.7050201@nvidia.com>
	<20120627051418.GB7177@avionic-0098.mockup.avionic-design.de>
	<20120627155907.871b2a506374b7db14c202c4@nvidia.com>
	<20120627140809.GD19319@avionic-0098.mockup.avionic-design.de>
	<20120627172914.30a2ccfd1344161ca7724722@nvidia.com>
	<20120627144414.GA20681@avionic-0098.mockup.avionic-design.de>
	<1340812795.1350.7.camel@antimon>
	<20120628090650.b915ad756c91d62d658eb53a@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20120628090650.b915ad756c91d62d658eb53a-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, Mark Zhang <markz-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Am Donnerstag, den 28.06.2012, 09:06 +0300 schrieb Hiroshi Doyu:
> Hi Lucas,
> 
> On Wed, 27 Jun 2012 17:59:55 +0200
> Lucas Stach <dev-8ppwABl0HbeELgA04lAiVw@public.gmane.org> wrote:
> 
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
> For contiguious address space shortage issue in DMA API, I think that
> DMABUF framework can handle?
> 
No, DMABUF is only about sharing DMA buffers between different hardware
blocks. It has no address space management at all.

All DRM drivers manage their address space on their own, either through
GEM or TTM. On the desktop the main pool for contiguous memory is on
card VRAM or a area of system memory set aside for use by the DRM
driver. Having a carveout area only for DRM use would be the same thing,
but makes the split between graphics and system memory a bit unflexible.
Currently we have no sane way for integrating DRM memory managers with
the normal DMA API. There was some discussion about DMA pools and/or
shrinkers for DMA clients, but they have not led to any written code.

DMABUF only makes a limited integration between for example V4L and DRM
possible, so they can share buffers. But we still have the situation
that DRM devices allocate from their own pool, for explained reasons and
not use the standard DMA API.
