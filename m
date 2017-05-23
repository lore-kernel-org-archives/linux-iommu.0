From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH V3 6/8] arm: dma-mapping: Reset the device's dma_ops
Date: Wed, 24 May 2017 00:46:51 +0300
Message-ID: <11967423.kIiHBWZfPn@avalon>
References: <1475600632-21289-1-git-send-email-sricharan@codeaurora.org>
	<a9debbce-17dc-aeaa-59bd-668aa15b97fe@arm.com>
	<20170523175319.GA22219@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170523175319.GA22219-l+eeeJia6m9URfEZ8mYm6t73F7V6hmMc@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Russell King - ARM Linux <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
Cc: will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Russell,

On Tuesday 23 May 2017 18:53:19 Russell King - ARM Linux wrote:
> On Tue, May 23, 2017 at 05:55:57PM +0100, Robin Murphy wrote:
> > On 23/05/17 17:25, Russell King - ARM Linux wrote:
> >> So, I've come to apply this patch (since it's finally landed in the
> >> patch system), and I'm not convinced that the commit message is really
> >> up to scratch.
> >> 
> >> The current commit message looks like this:
> >> 
> >> "   ARM: 8674/1: dma-mapping: Reset the device's dma_ops
> >>     arch_teardown_dma_ops() being the inverse of arch_setup_dma_ops(),
> >>     dma_ops should be cleared in the teardown path. Otherwise this
> >>     causes problem when the probe of device is retried after being
> >>     deferred. The device's iommu structures are cleared after
> >>     EPROBEDEFER error, but on the next try dma_ops will still be set to
> >>     old value, which is not right."
> >> 
> >> It is obviously a fix, but a fix for which patch?  Looking at the
> >> history, we have "arm: dma-mapping: Don't override dma_ops in
> >> arch_setup_dma_ops()" which I would have guessed is the appropriate
> >> one, but this post-dates your patch (it's very recent, v4.12-rc
> >> recent.)
> >> 
> >> So, I need more description about the problem you were seeing when
> >> you first proposed this patch.
> >> 
> >> How does leaving the dma_ops in place prior to "arm: dma-mapping:
> >> Don't override dma_ops in arch_setup_dma_ops()" cause problems for
> >> deferred probing?
> >> 
> >> What patch is your change trying to fix?  In other words, how far
> >> back does this patch need to be backported?
> > 
> > In effect, it's fixing a latent inconsistency that's been present since
> > its introduction in 4bb25789ed28. However, that has clearly not proven
> > to be an issue in practice since then. With 09515ef5ddad we start
> > actually calling arch_teardown_dma_ops() in a manner that might leave
> > things partially initialised if anyone starts removing and reprobing
> > drivers, but so far that's still from code inspection[1] rather than
> > anyone hitting it.
> > 
> > Given that the changes which tickle it are fresh in -rc1 I'd say there's
> > no need to backport this, but at the same time it shouldn't do any
> > damage if you really want to.
> 
> Well, looking at this, I'm not convinced that much of it is correct.
> 
> 1) set_dma_ops() is in arch_setup_dma_ops() but this patch adds
>    the unsetting of the DMA ops inside arm_teardown_iommu_dma_ops()
>    rather than arch_teardown_dma_ops().
> 
>    This doesn't strike me as being particularly symmetric.
>    arm_teardown_iommu_dma_ops() is arm_setup_iommu_dma_ops()'s
>    counterpart.
> 
> 2) arch_setup_dma_ops(), the recent patch to add the existing dma_ops
>    check, and Xen - Xen wants to override the DMA ops if in the
>    initial domain.  It's not clear (at least to me) whether the recent
>    patch adding the dma_ops check took account of this or not.
> 
> 3) random places seem to fiddle with the dma_ops - notice that
>    arm_iommu_detach_device() sets the dma_ops to NULL.
> 
>    In fact, I think moving __arm_iommu_detach_device() into
>    arm_iommu_detach_device(), calling arm_iommu_detach_device(),
>    and getting rid of the explicit set_dma_ops(, NULL) in this
>    path would be a good first step.
> 
> 4) I think arch_setup_dma_ops() is over-complex.
> 
> So, in summary, this code is a mess today, and that means it's not
> obviously correct - which is bad.  This needs sorting.

We've reached the same conclusion independently, but I'll refrain from 
commenting on whether that's a good or bad thing :-)

I don't think this patch should be applied, as it could break Xen (and other 
platforms/drivers that set the DMA operations manually) by resetting DMA 
operations at device remove() time even if they have been set independently of 
arch_setup_dma_ops().

The IOMMU probe deferral support patch series was merged in v4.12-rc1 and 
breaks IOMMU operations on several platforms. We need a fix for v4.12-rc that 
should be as nonintrusive as possible, as a larger cleanup is likely not -rc 
material. Beside reverting the whole series, the simplest option I came up 
with was [1]. Note that this is not the only fix needed to fix v4.12-rc1 IOMMU 
breakage, there are four more patches in the series that Sricharan plans to 
get merged soon. I don't think there are dependencies between the other four 
drivers/ patches and the arch/arm/ patch, so the latter could be merged 
independently through your tree as soon as it's deemed ready.

[1] https://www.spinics.net/lists/arm-kernel/msg583019.html

-- 
Regards,

Laurent Pinchart
