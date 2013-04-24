From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] documentation: iommu: add description of ARM System MMU
	binding
Date: Wed, 24 Apr 2013 10:55:01 +0100
Message-ID: <20130424095501.GC21850@mudshark.cambridge.arm.com>
References: <1365094259-24847-1-git-send-email-will.deacon@arm.com>
	<515F37C1.4000109@codeaurora.org>
	<20130408092535.GA17476@mudshark.cambridge.arm.com>
	<5162F87A.7070409@codeaurora.org>
	<20130410173732.GQ26992@mudshark.cambridge.arm.com>
	<5169C7D1.8070300@codeaurora.org>
	<20130415131341.GG9827@mudshark.cambridge.arm.com>
	<516D9602.2010404@codeaurora.org>
	<20130418190131.GA12344@mudshark.cambridge.arm.com>
	<5177113D.7060300@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5177113D.7060300-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: "linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Apr 23, 2013 at 11:54:53PM +0100, Olav Haugan wrote:
> Hi Will,

Hello again,

> On 4/18/2013 12:01 PM, Will Deacon wrote:
> > No. The device-tree describes the *hardware*, as per usual. The StreamIDs
> > are fixed properties of the SoC and we can't change them from Linux, so we
> > describe all of the StreamIDs upstream of each SMMU so that we can program
> > the thing. There's no way to generic way to discover them.
> 
> I meant that you are putting phandles to bus masters in the device tree
> that use/need the SMMU for VA2PA translation. Doesn't this put a
> dependency on the bus master devices? How will this work? Lets say that
> we have a device during bootup that needs to use the SMMU (such as a
> display processor [DP]). Don't you have cyclic dependency? The SMMU
> device needs the DP device (phandle) but the DP device needs the SMMU to
> initialize its device driver?

That's a problem you have with the driver model anyway. The SMMU must be
registered on the same bus as the device before it can be used and the
devices must be added to that bus before they can be attached to a domain.

Getting phandles has no dependencies on anything -- the only dependency is
that the device is added to the bus on which the SMMU sits, just like every
other IOMMU driver.

> > Why would a page table shared between devices require multiple context
> > banks? Multiple SMRs and S2CRs, sure, but they would ultimately point at the
> > same context bank (and hence same address space).
> 
> What if you want to have 2 different VMID's being generated? Also, what
> about TLB management? If I have two context banks I can invalidate only
> entries associated with 1 of the context banks (if VMID differ for the
> two context banks).

Huh? We allocate one VMID per domain. If you want more VMIDs, use more
domains. TLB invalidation is per-domain, so there's no issue there.

> > If a master needs to be in two address spaces at once, then it will need to
> > attach it's StreamIDs to different domains. You can't place a single
> > StreamID in two address spaces (this is an architectural constraint).
> 
> Yes, you would have a separate domain. I am just wondering how I would
> model this in DT using the bindings that you are proposing? How does it
> work? The bindings specify bus masters to StreamIDs. So if I call attach
> with the master device you will allocate a context bank and program the
> StreamIDs as specified in the DT. So now if I want to have another
> context bank associated with the same master device what do I do? I call
> into attach with a new domain but with the same master device but the
> master device is already attached to a context/domain.

Why would you want to place a StreamID into two domains? That doesn't make
any sense and isn't even supported by the architecture (things like
conflicting SMR entries may not even be reported).

Will
