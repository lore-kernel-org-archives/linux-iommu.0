From: Lucas Stach <dev-8ppwABl0HbeELgA04lAiVw@public.gmane.org>
Subject: Re: [PATCH 2/2] iommu/tegra: gart: Reserve iomem resource
Date: Mon, 18 Jun 2012 23:14:05 +0200
Message-ID: <1340054045.1367.31.camel@tellur>
References: <1337019127-6863-1-git-send-email-hdoyu@nvidia.com>
	 <1337019127-6863-2-git-send-email-hdoyu@nvidia.com>
	 <20120521141152.GA21513@avionic-0098.mockup.avionic-design.de>
	 <4FBA702A.1010203@wwwdotorg.org> <1337619935.1621.13.camel@tellur>
	 <4FBA77E2.4000409@wwwdotorg.org>
	 <20120521173124.GB11824@avionic-0098.mockup.avionic-design.de>
	 <1337621908.1621.16.camel@tellur>
	 <20120618133736.8d23c4e70b34b1de8cb71f6f@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120618133736.8d23c4e70b34b1de8cb71f6f-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: joerg.roedel-5C7GfCeVMHo@public.gmane.org, Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Bharat Nihalani <bnihalani-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Vandana Salve <vsalve-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hello Hiroshi,

Am Montag, den 18.06.2012, 13:37 +0300 schrieb Hiroshi Doyu:
> Hi Lucas,
> 
> On Mon, 21 May 2012 19:38:28 +0200
> Lucas Stach <dev-8ppwABl0HbeELgA04lAiVw@public.gmane.org> wrote:
> 
> > Am Montag, den 21.05.2012, 19:31 +0200 schrieb Thierry Reding:
> > > * Stephen Warren wrote:
> > > > On 05/21/2012 11:05 AM, Lucas Stach wrote:
> > > > > Am Montag, den 21.05.2012, 10:41 -0600 schrieb Stephen Warren:
> > > > >> On 05/21/2012 08:11 AM, Thierry Reding wrote:
> > > > >>> * Hiroshi DOYU wrote:
> > > > >>>> GART Register/Aperture range should be reserved.
> > > > >> ...
> > > > >>>> diff --git a/drivers/iommu/tegra-gart.c
> > > > >>>> b/drivers/iommu/tegra-gart.c
> > > > >> ...
> > > > >>>> +	if (!devm_request_mem_region(dev, res_remap->start, +
> > > > >>>> resource_size(res_remap), dev_name(dev))) { +		dev_err(dev,
> > > > >>>> "failed to reserve GART aperture\n"); +		return -EBUSY; +	} +
> > > > >>>
> > > > >>> I'm not so sure that this is a good idea. If the GART driver
> > > > >>> requests the GART aperture, then users of the GART aperture (e.g.
> > > > >>> the DRM driver) will no longer be able to use it.
> > > > >>
> > > > >> Presumably the DRM driver would be obtaining access to parts of the
> > > > >> GART aperture through the GART driver, rather than just grabbing the
> > > > >> IO region and using it for itself?
> > > > > 
> > > > > With a TTM-like memory manager the DRM driver will take over the address
> > > > > space management of the GART aperture. The GART driver is only used to
> > > > > set up the mappings in the IOMMU. The DRM driver is the one that sets
> > > > > up/tears down the CPU mappings on demand, so the aperture should be
> > > > > claimed in the DRM driver.
> > > > 
> > > > Even if the DRM driver is managing the aperture, I still think the GART
> > > > driver should claim it. The physical address of the aperture is a
> > > > property of the GART, so only the GART's resources (and DT node) should
> > > > contain a representation of where that aperture is. The DRM driver
> > > > should call into the GART driver to find out where the aperture is, and
> > > > hence GART is able to claim it without conflict.
> > > 
> > > That could be difficult to do. There isn't any API to allow this. I guess if
> > > something like that is added it should probably go into the IOMMU framework.
> > 
> > Ah, yes. There already was a plan to add properties for this to the
> > IOMMU API. So I'm ok with the GART driver claiming the resources.
> 
> I think that DRM driver should be independent of GART, one specific
> implementation of IOMMU H/W, but it should be a normal client of DMA
> BUF(or DMABUF API?), which asks info via IOMMU API if necessary.

You are right that the DRM driver should not care about the specific
IOMMU implementation. It shouldn't matter to the graphics driver if it
sits on top of a Tegra 2 GART with a fixed aperture of 32MB or on top of
a Tegra 3 SMMU with an virtual address space of several Gigabytes. 

However graphics cores are one of the most complicated devices when it
comes to DMA resource management. Because of it's natural operation mode
as a completely parallel coprocessor to the CPU and the big amounts of
data that has to be mapped at every given time, the GPU doesn't fit
terribly well within the normal Linux Kernel DMA API.

We already have a solution for GPU address space management in the
kernel, called TTM, which in turn integrates with other things like
DMABUF. But to guarantee the best performance TTM will have to manage
the whole virtual address space of the GPU. So I think the IOMMU API is
the perfect abstraction level for interaction between the DRM and the
GART/SMMU driver. This way the DRM is able to manage the DMA resources
on it's own while staying completely agnostic about the underlying IOMMU
hardware.

> 
> For new IOMMU API, I guess that the following would be the one we need here.
> 
> [PATCH 0/5] IOMMU: Make IOMMU-API ready for GART-like hardware
>   https://lkml.org/lkml/2012/1/19/170
> 
Yes, this is exactly the patchset I had in mind.

> > I will try to push the needed API changes forward in the next few
> > days.
> 
> Have you had any chance to post the above succeeding patch? I couldn't
> find.
> 
No, sorry. I was occupied with other things for the last weeks and
couldn't find the time to revisit this topic.

-- Lucas
