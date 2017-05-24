From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH V3 6/8] arm: dma-mapping: Reset the device's dma_ops
Date: Wed, 24 May 2017 14:26:13 +0300
Message-ID: <7413479.FJ3cKQnUFA@avalon>
References: <1475600632-21289-1-git-send-email-sricharan@codeaurora.org>
	<20170523224216.GI22219@n2100.armlinux.org.uk>
	<c4ad7341-fa9f-81b7-a41c-417144c4f842@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <c4ad7341-fa9f-81b7-a41c-417144c4f842-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, Russell King - ARM Linux <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hello,

On Wednesday 24 May 2017 16:01:45 Sricharan R wrote:
> On 5/24/2017 4:12 AM, Russell King - ARM Linux wrote:
> > On Wed, May 24, 2017 at 12:46:51AM +0300, Laurent Pinchart wrote:
> >> On Tuesday 23 May 2017 18:53:19 Russell King - ARM Linux wrote:
> >>> On Tue, May 23, 2017 at 05:55:57PM +0100, Robin Murphy wrote:
> >>>> On 23/05/17 17:25, Russell King - ARM Linux wrote:
> >>>>> So, I've come to apply this patch (since it's finally landed in the
> >>>>> patch system), and I'm not convinced that the commit message is really
> >>>>> up to scratch.
> >>>>> 
> >>>>> The current commit message looks like this:
> >>>>> 
> >>>>> "   ARM: 8674/1: dma-mapping: Reset the device's dma_ops
> >>>>> 
> >>>>>     arch_teardown_dma_ops() being the inverse of arch_setup_dma_ops(),
> >>>>>     dma_ops should be cleared in the teardown path. Otherwise this
> >>>>>     causes problem when the probe of device is retried after being
> >>>>>     deferred. The device's iommu structures are cleared after
> >>>>>     EPROBEDEFER error, but on the next try dma_ops will still be set
> >>>>>     to old value, which is not right."
> >>>>> 
> >>>>> It is obviously a fix, but a fix for which patch?  Looking at the
> >>>>> history, we have "arm: dma-mapping: Don't override dma_ops in
> >>>>> arch_setup_dma_ops()" which I would have guessed is the appropriate
> >>>>> one, but this post-dates your patch (it's very recent, v4.12-rc
> >>>>> recent.)
> >>>>> 
> >>>>> So, I need more description about the problem you were seeing when
> >>>>> you first proposed this patch.
> >>>>> 
> >>>>> How does leaving the dma_ops in place prior to "arm: dma-mapping:
> >>>>> Don't override dma_ops in arch_setup_dma_ops()" cause problems for
> >>>>> deferred probing?
> >>>>> 
> >>>>> What patch is your change trying to fix?  In other words, how far
> >>>>> back does this patch need to be backported?
> >>>> 
> >>>> In effect, it's fixing a latent inconsistency that's been present since
> >>>> its introduction in 4bb25789ed28. However, that has clearly not proven
> >>>> to be an issue in practice since then. With 09515ef5ddad we start
> >>>> actually calling arch_teardown_dma_ops() in a manner that might leave
> >>>> things partially initialised if anyone starts removing and reprobing
> >>>> drivers, but so far that's still from code inspection[1] rather than
> >>>> anyone hitting it.
> >>>> 
> >>>> Given that the changes which tickle it are fresh in -rc1 I'd say
> >>>> there's no need to backport this, but at the same time it shouldn't do
> >>>> any damage if you really want to.
> >>> 
> >>> Well, looking at this, I'm not convinced that much of it is correct.
> >>> 
> >>> 1) set_dma_ops() is in arch_setup_dma_ops() but this patch adds
> >>>    the unsetting of the DMA ops inside arm_teardown_iommu_dma_ops()
> >>>    rather than arch_teardown_dma_ops().
> >>>    
> >>>    This doesn't strike me as being particularly symmetric.
> >>>    arm_teardown_iommu_dma_ops() is arm_setup_iommu_dma_ops()'s
> >>>    counterpart.
> >>> 
> >>> 2) arch_setup_dma_ops(), the recent patch to add the existing dma_ops
> >>>    check, and Xen - Xen wants to override the DMA ops if in the
> >>>    initial domain.  It's not clear (at least to me) whether the recent
> >>>    patch adding the dma_ops check took account of this or not.
> >>> 
> >>> 3) random places seem to fiddle with the dma_ops - notice that
> >>>    arm_iommu_detach_device() sets the dma_ops to NULL.
> >>>    
> >>>    In fact, I think moving __arm_iommu_detach_device() into
> >>>    arm_iommu_detach_device(), calling arm_iommu_detach_device(),
> >>>    and getting rid of the explicit set_dma_ops(, NULL) in this
> >>>    path would be a good first step.
> >>> 
> >>> 4) I think arch_setup_dma_ops() is over-complex.
> >>> 
> >>> So, in summary, this code is a mess today, and that means it's not
> >>> obviously correct - which is bad.  This needs sorting.
> >> 
> >> We've reached the same conclusion independently, but I'll refrain from
> >> commenting on whether that's a good or bad thing :-)
> >> 
> >> I don't think this patch should be applied, as it could break Xen (and
> >> other platforms/drivers that set the DMA operations manually) by
> >> resetting DMA operations at device remove() time even if they have been
> >> set independently of arch_setup_dma_ops().
> > 
> > That will only occur if the dma ops have been overriden once the DMA
> > operations have been setup via arch_setup_dma_ops. What saves it from
> > wholesale NULLing of the DMA operations is the check for a valid
> > dma_iommu_mapping structure in arm_teardown_iommu_dma_ops().  This only
> > exists when arm_setup_iommu_dma_ops() has attached a mapping to the
> > device.

Unfortunately I don't think that's always the case. The dma_iommu_mapping is 
also set by direct callers of arm_iommu_attach_device(), namely

- the Renesas R-Car IOMMU driver (ipmmu-vmsa)
- the Mediatek IOMMU driver (mtk-iommu-v1)
- the Exynos DRM driver
- the OMAP3 ISP driver

All these need to be fixed, but that's not v4.12-rc material. At least in the 
ipmmu-vmsa case, which is the one I noticed the problem with, 
arm_iommu_attach_device() is called before arch_setup_dma_ops(). 
arch_setup_dma_ops() then exits immediately when called due to the

        if (dev->dma_ops)
                return;

check at the beginning of the function. We must ensure that in that case 
arch_teardown_dma_ops() will not remove the mapping or set the DMA ops to 
NULL, and testing to_dma_iommu_mapping(dev) won't help.

> Right, only if the dma ops are set and no dma_iommu_mapping is created for
> the device, then arch_teardown_iommu_dma_ops does nothing.
> 
> Firstly, this patch for resetting the dma_ops in teardown was required
> only when arch_setup_dma_ops has created both the mapping and dma_ops
> for the device. Because mappings that were created in arch_setup_dma_ops
> are cleared in teardown, so dma ops should also be reset. But this can be
> done by calling arm_iommu_detach_device() from arm_teardown_iommu_dma_ops
> to avoid explicitly calling set_dma_ops again, probably this what was
> suggested in #3 above ?
> 
> Really sorry for the mess, but below cleanups looks required otherwise,
> 
> 1) set_dma_ops is called for mach-highbank, mach-mevbu during the
>    BUS_NOTIFY_ADD_DEVICE. That should be removed and made to come from
>    DT path and arch_setup_dma_ops. dmabounce.c also does set_dma_ops,
>    not very sure how to handle that (swiotlb ?), are call
>    dmabounce_register_dev during the device's probe instead to have the
>    dma_set_ops overriding later in probe ?

All this needs to be addressed, but it's definitely not v4.12-rc material.

> 2) arm_iommu_attach_device is called from ipmmu-vmsa.c, mtk_iommu_v1.c,
>    iommu drivers, from the iommu add_device callback, called
>    from BUS_NOTIFY_ADD_DEVICE notifier. This is a problem because,
>    with probe-deferral, this can be overridden in arch_setup_dma_ops
>    during device probe and cleared in teardown path. But the add_device
>    callback notifier is not called again when the device gets reprobed
>    again.
> 
>    With probe deferral, add_device callback also gets called from
>    of_iommu_configure during device probe, so the above drivers should
>    be adapted to properly register the iommu_ops to have its add_device
>    called from of_iommu_configure path. mtk_iommu_v1.c seems to be fine,
>    but ipmmu-vmsa.c should be adapted. otherwise if the devices attached
>    to those iommus call arm_iommu_attach_device from its probe path to
>    override the default ops set in arch_setup_dma_ops, then all is fine.
>    This seems to be the case with exynos_drm_iommu.c, omap3isp/isp.c.

Same here, this needs to be addressed, but not in v4.12-rc. We need a simpler 
fix for v4.12-rc.

>    If the above two are done, the overridding of the default dma_ops and
>    mapping should happen after arch_setup_dma_ops is called and also
>    overridden every time the device gets reprobed. That should help to get
>    rid of couple of fixes that has been added.
> 
> 3) As Laurent already pointed out earlier, return error codes from some of
>    the IOMMU apis needs to standardized.
> 
>    Please let me know if its right way of doing it ?

Again, the patch I propose is the simplest v4.12-rc fix I can think of, short 
of reverting your complete IOMMU probe deferral patch series. Let's focus on 
the v4.12-rc fix, and then discuss how to move forward in v4.13 and beyond.

-- 
Regards,

Laurent Pinchart
