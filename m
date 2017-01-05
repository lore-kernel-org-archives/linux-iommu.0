From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC 1/3] iommu/arm-smmu: Add support to opt-in to stalling
Date: Thu, 5 Jan 2017 14:47:42 +0000
Message-ID: <20170105144742.GK679@arm.com>
References: <1483479056-15202-1-git-send-email-robdclark@gmail.com>
	<1483479056-15202-2-git-send-email-robdclark@gmail.com>
	<20170105115528.GG679@arm.com> <20170105120857.GB21952@leverpostej>
	<20170105140005.GJ679@arm.com> <20170105140720.GA25868@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170105140720.GA25868@leverpostej>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jordan Crouse <jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Jan 05, 2017 at 02:07:31PM +0000, Mark Rutland wrote:
> On Thu, Jan 05, 2017 at 02:00:05PM +0000, Will Deacon wrote:
> > On Thu, Jan 05, 2017 at 12:08:57PM +0000, Mark Rutland wrote:
> > > On Thu, Jan 05, 2017 at 11:55:29AM +0000, Will Deacon wrote:
> > > > On Tue, Jan 03, 2017 at 04:30:54PM -0500, Rob Clark wrote:
> > > > > diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> > > > > index ef465b0..5f405a6 100644
> > > > > --- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> > > > > +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> > > > > @@ -68,6 +68,9 @@ conditions.
> > > > >                    aliases of secure registers have to be used during
> > > > >                    SMMU configuration.
> > > > >  
> > > > > +- arm,smmu-enable-stall : Enable stall mode to stall memory transactions
> > > > > +                  and resume after fault is handled
> > > 
> > > The wording here seems to describe a policy rather than a property.
> > > 
> > > Can you elaborate on when/why this is required/preferred/valid?
> > 
> > It's not a policy, it's a hardware capability. There are some non-probeable
> > reasons why stalling mode is unsafe or unusable:
> > 
> >   http://lists.infradead.org/pipermail/linux-arm-kernel/2016-December/474530.html
> 
> Ok. My point was that the wording above is an imperative -- it tells
> the kernel to enable stall mode, not if/why it is safe to do so (i.e. it
> is a policy, not a property).
> 
> It sounds like that's just a wording issue. Something like
> "arm,stalling-is-usable" (along with a descrition of when that
> can/should be in the DT) would be vastly better.

Why does it need a vendor prefix? I'm not down on the convention there.
"stalling-safe" or "stalling-supported" are alternative strings.

> > > > >  static irqreturn_t arm_smmu_global_fault(int irq, void *dev)
> > > > > @@ -824,6 +852,8 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
> > > > >  
> > > > >  	/* SCTLR */
> > > > >  	reg = SCTLR_CFIE | SCTLR_CFRE | SCTLR_AFE | SCTLR_TRE | SCTLR_M;
> > > > > +	if (smmu->options & ARM_SMMU_OPT_ENABLE_STALL)
> > > > > +		reg |= SCTLR_CFCFG;
> > > > 
> > > > I wonder if this should also be predicated on the compatible string, so
> > > > that the "arm,smmu-enable-stall" property is ignored (with a warning) if
> > > > the compatible string isn't specific enough to identify an implementation
> > > > with the required SS behaviour? On the other hand, it feels pretty
> > > > redundant and a single "stalling works" property is all we need.
> > > 
> > > Can you elaborate on what "stalling works" entails? Is that just the SS
> > > bit behaviour? are there integration or endpoint-specific things that we
> > > need to care about?
> > 
> > See above. The "stalling works" property (arm,smmu-enable-stall) would
> > indicate that both the implementation *and* the integration are such
> > that stalling is usable for demand paging. I suspect there are endpoints
> > that can't deal with stalls (e.g. they might timeout and signal a RAS
> > event), but in that case their respective device drivers should ensure
> > that any DMA buffers are pinned and/or register a fault handler to
> > request termination of the faulting transaction.
> 
> Ok. It would be good to elaborate on what "stalling is useable" means in
> the property description. i.e. what specificallty the implementation and
> integration need to ensure.

We can describe some of those guarantees in the property description, but
it's difficult to enumerate them exhaustively. For example, you wouldn't
want stalling to lead to data corruption, denial of service, or for the
thing to catch fire, but having those as explicit requirements is a bit
daft. It's also impossible to check that you thought of everything.

Aside from renaming the option, I'm really after an opinion on whether
it's better to have one property or combine it with the compatible
string, because I can see benefits of both and don't much care either
way.

Will
