From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH V3 6/8] arm: dma-mapping: Reset the device's dma_ops
Date: Tue, 23 May 2017 23:42:17 +0100
Message-ID: <20170523224216.GI22219@n2100.armlinux.org.uk>
References: <1475600632-21289-1-git-send-email-sricharan@codeaurora.org>
 <a9debbce-17dc-aeaa-59bd-668aa15b97fe@arm.com>
 <20170523175319.GA22219@n2100.armlinux.org.uk>
 <11967423.kIiHBWZfPn@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <11967423.kIiHBWZfPn@avalon>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, will.deacon@arm.com, tfiga@chromium.org, iommu@lists.linux-foundation.org, srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org, Sricharan <sricharan@codeaurora.org>, linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com
List-Id: iommu@lists.linux-foundation.org

On Wed, May 24, 2017 at 12:46:51AM +0300, Laurent Pinchart wrote:
> Hi Russell,
> 
> On Tuesday 23 May 2017 18:53:19 Russell King - ARM Linux wrote:
> > On Tue, May 23, 2017 at 05:55:57PM +0100, Robin Murphy wrote:
> > > On 23/05/17 17:25, Russell King - ARM Linux wrote:
> > >> So, I've come to apply this patch (since it's finally landed in the
> > >> patch system), and I'm not convinced that the commit message is really
> > >> up to scratch.
> > >> 
> > >> The current commit message looks like this:
> > >> 
> > >> "   ARM: 8674/1: dma-mapping: Reset the device's dma_ops
> > >>     arch_teardown_dma_ops() being the inverse of arch_setup_dma_ops(),
> > >>     dma_ops should be cleared in the teardown path. Otherwise this
> > >>     causes problem when the probe of device is retried after being
> > >>     deferred. The device's iommu structures are cleared after
> > >>     EPROBEDEFER error, but on the next try dma_ops will still be set to
> > >>     old value, which is not right."
> > >> 
> > >> It is obviously a fix, but a fix for which patch?  Looking at the
> > >> history, we have "arm: dma-mapping: Don't override dma_ops in
> > >> arch_setup_dma_ops()" which I would have guessed is the appropriate
> > >> one, but this post-dates your patch (it's very recent, v4.12-rc
> > >> recent.)
> > >> 
> > >> So, I need more description about the problem you were seeing when
> > >> you first proposed this patch.
> > >> 
> > >> How does leaving the dma_ops in place prior to "arm: dma-mapping:
> > >> Don't override dma_ops in arch_setup_dma_ops()" cause problems for
> > >> deferred probing?
> > >> 
> > >> What patch is your change trying to fix?  In other words, how far
> > >> back does this patch need to be backported?
> > > 
> > > In effect, it's fixing a latent inconsistency that's been present since
> > > its introduction in 4bb25789ed28. However, that has clearly not proven
> > > to be an issue in practice since then. With 09515ef5ddad we start
> > > actually calling arch_teardown_dma_ops() in a manner that might leave
> > > things partially initialised if anyone starts removing and reprobing
> > > drivers, but so far that's still from code inspection[1] rather than
> > > anyone hitting it.
> > > 
> > > Given that the changes which tickle it are fresh in -rc1 I'd say there's
> > > no need to backport this, but at the same time it shouldn't do any
> > > damage if you really want to.
> > 
> > Well, looking at this, I'm not convinced that much of it is correct.
> > 
> > 1) set_dma_ops() is in arch_setup_dma_ops() but this patch adds
> >    the unsetting of the DMA ops inside arm_teardown_iommu_dma_ops()
> >    rather than arch_teardown_dma_ops().
> > 
> >    This doesn't strike me as being particularly symmetric.
> >    arm_teardown_iommu_dma_ops() is arm_setup_iommu_dma_ops()'s
> >    counterpart.
> > 
> > 2) arch_setup_dma_ops(), the recent patch to add the existing dma_ops
> >    check, and Xen - Xen wants to override the DMA ops if in the
> >    initial domain.  It's not clear (at least to me) whether the recent
> >    patch adding the dma_ops check took account of this or not.
> > 
> > 3) random places seem to fiddle with the dma_ops - notice that
> >    arm_iommu_detach_device() sets the dma_ops to NULL.
> > 
> >    In fact, I think moving __arm_iommu_detach_device() into
> >    arm_iommu_detach_device(), calling arm_iommu_detach_device(),
> >    and getting rid of the explicit set_dma_ops(, NULL) in this
> >    path would be a good first step.
> > 
> > 4) I think arch_setup_dma_ops() is over-complex.
> > 
> > So, in summary, this code is a mess today, and that means it's not
> > obviously correct - which is bad.  This needs sorting.
> 
> We've reached the same conclusion independently, but I'll refrain from 
> commenting on whether that's a good or bad thing :-)
> 
> I don't think this patch should be applied, as it could break Xen (and other 
> platforms/drivers that set the DMA operations manually) by resetting DMA 
> operations at device remove() time even if they have been set independently of 
> arch_setup_dma_ops().

That will only occur if the dma ops have been overriden once the DMA
operations have been setup via arch_setup_dma_ops.  What saves it from
wholesale NULLing of the DMA operations is the check for a valid
dma_iommu_mapping structure in arm_teardown_iommu_dma_ops().  This only
exists when arm_setup_iommu_dma_ops() has attached a mapping to the
device.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
