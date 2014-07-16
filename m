From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v4] devicetree: Add generic IOMMU device tree bindings
Date: Wed, 16 Jul 2014 11:10:53 +0100
Message-ID: <20140716101053.GJ29414@arm.com>
References: <1404487757-18829-1-git-send-email-thierry.reding@gmail.com>
 <20140712093917.GD18601@arm.com>
 <CAF6AEGutHp+3f3iPA+jjaRkqq=5T_vytZ_ESoSqsQ4RHZ8F8yQ@mail.gmail.com>
 <201407121422.02078.arnd@arndb.de>
 <CAF6AEGs7=3UByP2DLm-uwU03wr7M14x2t-0hLX-VPJ6_eZbU3g@mail.gmail.com>
 <20140713094341.GB23235@arm.com>
 <CAF6AEGt5cQhDCZgYX4=M1EKE=n2J=9G6mO02JMx-+Fcq_0ukfw@mail.gmail.com>
 <53C5D480.3030409@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <53C5D480.3030409-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <Pawel.Moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Marc Zyngier <Marc.Zyngier-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Varun Sethi <varun.sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Dave P Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWOunwaRDDq4rA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Jul 16, 2014 at 02:25:20AM +0100, Olav Haugan wrote:
> On 7/13/2014 4:43 AM, Rob Clark wrote:
> > On Sun, Jul 13, 2014 at 5:43 AM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
> >> My plan for the ARM SMMU driver is:
> >>
> >>   (1) Change ->probe() to walk the device-tree looking for all masters with
> >>       phandles back to the SMMU instance being probed
> >>
> >>   (2) For each master, extract the Stream IDs and add them to the internal
> >>       SMMU driver data structures (an rbtree per SMMU instance). For
> >>       hotpluggable buses, we'll need a way for the bus controller to
> >>       reserve a range of IDs -- this will likely be a later extension to
> >>       the binding.
> >>
> >>   (3) When we get an ->add() call, warn if it's a device we haven't seen
> >>       and reject the addition.
> >>
> >> That way, ->attach() should be the same as it is now, I think.
> >>
> >> Have you tried implementing something like that? We agreed that (1) isn't
> >> pretty, but I don't have a good alternative and it's only done at
> >> probe-time.
> > 
> > I haven't tried implementing that yet, but I'm sure it would work.  I
> > was just hoping to avoid having to do that ;-)
> 
> Is the reason you want to do it this way because you want to guarantee
> that all masters (and stream IDs) have been identified before the first
> attach call? I am just wondering why you cannot continue doing the
> master/streamID discovery during add_device() callback?

That's fine if we have one SMR per ID, but the moment we want to do more
involved matching, we're going to need complete system knowledge prior to
the first attach. I don't think we can safely reconfigure live streams on
the fly.

> >> BTW: Is the msm-v0 IOMMU compatible with the ARM SMMU driver, or is it a
> >> completely different design requiring a different driver?
> > 
> > My understanding is that it is different from msm v1 IOMMU, although I
> > think it shares the same pagetable format with v1.  Not sure if that
> > is the same as arm-smmu?   If so it might be nice to try to extract
> > out some shared helper fxns for map/unmap as well.
> > 
> > I expect Olav knows better the similarities/differences.
> > 
> 
> The msm-v0 IOMMU is not compatible with ARM SMMUv1 specification.
> However, it is a close cousin. The hardware was designed before the ARM
> SMMUv1 specification was available I believe. But it shares many of the
> same concepts as the ARM SMMUv1.
> 
> msm-v0 IOMMU supports V7S page table format only. The ARM SMMU driver
> does not support V7S at this time. However, I believe we need to support
> this.
> 
> Will, this reminds me. We definitely have a need to use different page
> tables in the ARM SMMU driver vs. the ARM CPU. We have an SoC with ARMv8
> cores (and thus ARMv8 page tables) but the SMMUs (SMMUv1) on this SoC
> only have support for V7S/V7L page table format. So we cannot use the
> same page table format as the CPU.

That sounds like a sane use-case. The best thing to do would be to add
some ARM page-table code as a library under drivers/iommu/, then we can
move the ARM IOMMUs over to using that. Since we'd be moving away from the
CPU page table helpers, we could also take the opportunity to use the
coherent DMA API instead of the hack I currently use for flushing out tables
to non-coherent walkers.

Will
