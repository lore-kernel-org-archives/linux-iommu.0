From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC 1/3] iommu/arm-smmu: Add support to opt-in to stalling
Date: Thu, 5 Jan 2017 16:07:55 +0000
Message-ID: <20170105160755.GN679@arm.com>
References: <1483479056-15202-1-git-send-email-robdclark@gmail.com>
 <1483479056-15202-2-git-send-email-robdclark@gmail.com>
 <20170105115528.GG679@arm.com>
 <20170105120857.GB21952@leverpostej>
 <20170105140005.GJ679@arm.com>
 <20170105140720.GA25868@leverpostej>
 <20170105144742.GK679@arm.com>
 <d1a36cc5-265d-6971-f698-29b8d76e7884@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d1a36cc5-265d-6971-f698-29b8d76e7884@arm.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, robh@kernel.org, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, Jordan Crouse <jcrouse@codeaurora.org>, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Jan 05, 2017 at 03:32:50PM +0000, Robin Murphy wrote:
> On 05/01/17 14:47, Will Deacon wrote:
> > On Thu, Jan 05, 2017 at 02:07:31PM +0000, Mark Rutland wrote:
> >> Ok. It would be good to elaborate on what "stalling is useable" means in
> >> the property description. i.e. what specificallty the implementation and
> >> integration need to ensure.
> > 
> > We can describe some of those guarantees in the property description, but
> > it's difficult to enumerate them exhaustively. For example, you wouldn't
> > want stalling to lead to data corruption, denial of service, or for the
> > thing to catch fire, but having those as explicit requirements is a bit
> > daft. It's also impossible to check that you thought of everything.
> > 
> > Aside from renaming the option, I'm really after an opinion on whether
> > it's better to have one property or combine it with the compatible
> > string, because I can see benefits of both and don't much care either
> > way.
> 
> The SMMU implementation side of the decision (i.e. independence of IRQ
> assertion vs. SS) seems like exactly the sort of stuff the compatible
> string already has covered. The integration side I'm less confident can
> be described this way at all - the "this device definitely won't go
> wrong if stalled for an indefinite length of time" is inherently a
> per-master thing, so a single property on the SMMU implying that for
> every device connected to it seems a bit optimistic, and breaks down as
> soon as you have one device in the system for which that isn't true (a
> PCI root complex, say), even if that guy's traffic never crosses paths
> with whichever few devices you actually care about using stalls with.
> 
> I think this needs to be some kind of "arm,smmu-stall-safe" property
> placed on individual master device nodes (mad idea: or even an extra
> cell of flags in the IOMMU specifier) to encapsulate both that the given
> device itself is OK with being stalled, and that it's integrated in such
> a way that its stalled transactions cannot disrupt any *other* device
> (e.g. it has a TBU all to itself). Then upon initialising a context bank
> on a suitable SMMU implementation, we set CFCFG based on whatever device
> is being attached to the corresponding domain, and refuse any subsequent
> attempts to attach a non-stallable device to a stalling domain (and
> possibly even vice-versa).

If we're going to add per-master properties, I'd *really* like them to be
independent of the IOMMU in use. That is, we should be able to re-use this
property as part of supporting SVM for platform devices in future.

But I think we agree that we need:

  1. A compatible string for the SMMU that can be used to infer the SS
     behaviour in the driver

  2. A property on the SMMU to say that it's been integrated in such a
     way that stalling is safe (doesn't deadlock)

  3. A generic master property that says that the device can DMA to
     unpinned memory

Anything else?

Will
