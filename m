From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/2] iommu/tegra: gart: Reserve iomem resource
Date: Mon, 18 Jun 2012 13:37:36 +0300
Message-ID: <20120618133736.8d23c4e70b34b1de8cb71f6f@nvidia.com>
References: <1337019127-6863-1-git-send-email-hdoyu@nvidia.com>
	<1337019127-6863-2-git-send-email-hdoyu@nvidia.com>
	<20120521141152.GA21513@avionic-0098.mockup.avionic-design.de>
	<4FBA702A.1010203@wwwdotorg.org> <1337619935.1621.13.camel@tellur>
	<4FBA77E2.4000409@wwwdotorg.org>
	<20120521173124.GB11824@avionic-0098.mockup.avionic-design.de>
	<1337621908.1621.16.camel@tellur>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1337621908.1621.16.camel@tellur>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Lucas Stach <dev-8ppwABl0HbeELgA04lAiVw@public.gmane.org>, joerg.roedel-5C7GfCeVMHo@public.gmane.org
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Bharat Nihalani <bnihalani-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Vandana Salve <vsalve-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Lucas,

On Mon, 21 May 2012 19:38:28 +0200
Lucas Stach <dev-8ppwABl0HbeELgA04lAiVw@public.gmane.org> wrote:

> Am Montag, den 21.05.2012, 19:31 +0200 schrieb Thierry Reding:
> > * Stephen Warren wrote:
> > > On 05/21/2012 11:05 AM, Lucas Stach wrote:
> > > > Am Montag, den 21.05.2012, 10:41 -0600 schrieb Stephen Warren:
> > > >> On 05/21/2012 08:11 AM, Thierry Reding wrote:
> > > >>> * Hiroshi DOYU wrote:
> > > >>>> GART Register/Aperture range should be reserved.
> > > >> ...
> > > >>>> diff --git a/drivers/iommu/tegra-gart.c
> > > >>>> b/drivers/iommu/tegra-gart.c
> > > >> ...
> > > >>>> +	if (!devm_request_mem_region(dev, res_remap->start, +
> > > >>>> resource_size(res_remap), dev_name(dev))) { +		dev_err(dev,
> > > >>>> "failed to reserve GART aperture\n"); +		return -EBUSY; +	} +
> > > >>>
> > > >>> I'm not so sure that this is a good idea. If the GART driver
> > > >>> requests the GART aperture, then users of the GART aperture (e.g.
> > > >>> the DRM driver) will no longer be able to use it.
> > > >>
> > > >> Presumably the DRM driver would be obtaining access to parts of the
> > > >> GART aperture through the GART driver, rather than just grabbing the
> > > >> IO region and using it for itself?
> > > > 
> > > > With a TTM-like memory manager the DRM driver will take over the address
> > > > space management of the GART aperture. The GART driver is only used to
> > > > set up the mappings in the IOMMU. The DRM driver is the one that sets
> > > > up/tears down the CPU mappings on demand, so the aperture should be
> > > > claimed in the DRM driver.
> > > 
> > > Even if the DRM driver is managing the aperture, I still think the GART
> > > driver should claim it. The physical address of the aperture is a
> > > property of the GART, so only the GART's resources (and DT node) should
> > > contain a representation of where that aperture is. The DRM driver
> > > should call into the GART driver to find out where the aperture is, and
> > > hence GART is able to claim it without conflict.
> > 
> > That could be difficult to do. There isn't any API to allow this. I guess if
> > something like that is added it should probably go into the IOMMU framework.
> 
> Ah, yes. There already was a plan to add properties for this to the
> IOMMU API. So I'm ok with the GART driver claiming the resources.

I think that DRM driver should be independent of GART, one specific
implementation of IOMMU H/W, but it should be a normal client of DMA
BUF(or DMABUF API?), which asks info via IOMMU API if necessary.

For new IOMMU API, I guess that the following would be the one we need here.

[PATCH 0/5] IOMMU: Make IOMMU-API ready for GART-like hardware
  https://lkml.org/lkml/2012/1/19/170

> I will try to push the needed API changes forward in the next few
> days.

Have you had any chance to post the above succeeding patch? I couldn't
find.
