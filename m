From: Andreas Herrmann <andreas.herrmann@calxeda.com>
Subject: Re: [PATCH] documentation: iommu: add description of ARM System MMU
 binding
Date: Mon, 13 May 2013 11:07:24 +0200
Message-ID: <20130513090724.GA10369@alberich>
References: <20130408092535.GA17476@mudshark.cambridge.arm.com>
 <5162F87A.7070409@codeaurora.org>
 <20130410173732.GQ26992@mudshark.cambridge.arm.com>
 <5169C7D1.8070300@codeaurora.org>
 <20130415131341.GG9827@mudshark.cambridge.arm.com>
 <516D9602.2010404@codeaurora.org>
 <20130418190131.GA12344@mudshark.cambridge.arm.com>
 <5177113D.7060300@codeaurora.org>
 <20130424095501.GC21850@mudshark.cambridge.arm.com>
 <5189635A.8090504@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5189635A.8090504@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Olav Haugan <ohaugan@codeaurora.org>
Cc: Will Deacon <will.deacon@arm.com>, "tzeng@codeaurora.org" <tzeng@codeaurora.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, May 07, 2013 at 04:26:02PM -0400, Olav Haugan wrote:
> Hi Will,
> 
> On 4/24/2013 2:55 AM, Will Deacon wrote:
> > On Tue, Apr 23, 2013 at 11:54:53PM +0100, Olav Haugan wrote:
> >> On 4/18/2013 12:01 PM, Will Deacon wrote:
> > Getting phandles has no dependencies on anything -- the only dependency is
> > that the device is added to the bus on which the SMMU sits, just like every
> > other IOMMU driver.
> > 
> >>> Why would a page table shared between devices require multiple context
> >>> banks? Multiple SMRs and S2CRs, sure, but they would ultimately point at the
> >>> same context bank (and hence same address space).
> >>
> >> What if you want to have 2 different VMID's being generated? Also, what
> >> about TLB management? If I have two context banks I can invalidate only
> >> entries associated with 1 of the context banks (if VMID differ for the
> >> two context banks).
> > 
> > Huh? We allocate one VMID per domain. If you want more VMIDs, use more
> > domains. TLB invalidation is per-domain, so there's no issue there.
> 
> If we allocate a new domain you would have another address space (page
> table), no? I was just trying to figure out if your binding proposal
> would allow for 2 context banks in one domain which it does not seem to
> support.
> 
> >>> If a master needs to be in two address spaces at once, then it will need to
> >>> attach it's StreamIDs to different domains. You can't place a single
> >>> StreamID in two address spaces (this is an architectural constraint).
> >>
> >> Yes, you would have a separate domain. I am just wondering how I would
> >> model this in DT using the bindings that you are proposing? How does it
> >> work? The bindings specify bus masters to StreamIDs. So if I call attach
> >> with the master device you will allocate a context bank and program the
> >> StreamIDs as specified in the DT. So now if I want to have another
> >> context bank associated with the same master device what do I do? I call
> >> into attach with a new domain but with the same master device but the
> >> master device is already attached to a context/domain.
> > 
> > Why would you want to place a StreamID into two domains? That doesn't make
> > any sense and isn't even supported by the architecture (things like
> > conflicting SMR entries may not even be reported).
> 
> I think you misunderstood me. I am talking about having for example 1
> master with two (2) context banks so that StreamID "1" goes to CB0 and
> StreamID "2" goes to CB1. This means that the master device is attached
> to two different domains. How do I model this with the the device tree
> bindings?

Hi Olav,

I think with the proposed device tree binding you can't model this.

Do we have such use cases already? Or what future use cases would
require this?

I can imagine of multiple contexts per device for stuff similar to
what PASID in PCI Express are used for.

But in such a case you probably want to have some configurable bits in
the StreamID (that should be set by an SMMU driver). And the DT
binding should contain the number of contexts that a master device can
support.


Andreas
