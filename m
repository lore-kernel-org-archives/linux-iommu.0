From: Olav Haugan <ohaugan@codeaurora.org>
Subject: Re: [PATCH] documentation: iommu: add description of ARM System MMU
 binding
Date: Tue, 23 Apr 2013 15:54:53 -0700
Message-ID: <5177113D.7060300@codeaurora.org>
References: <1365094259-24847-1-git-send-email-will.deacon@arm.com> <515F37C1.4000109@codeaurora.org> <20130408092535.GA17476@mudshark.cambridge.arm.com> <5162F87A.7070409@codeaurora.org> <20130410173732.GQ26992@mudshark.cambridge.arm.com> <5169C7D1.8070300@codeaurora.org> <20130415131341.GG9827@mudshark.cambridge.arm.com> <516D9602.2010404@codeaurora.org> <20130418190131.GA12344@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20130418190131.GA12344@mudshark.cambridge.arm.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Andreas Herrmann <andreas.herrmann@calxeda.com>, "tzeng@codeaurora.org" <tzeng@codeaurora.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

Hi Will,

On 4/18/2013 12:01 PM, Will Deacon wrote:
> On Tue, Apr 16, 2013 at 07:18:42PM +0100, Olav Haugan wrote:
>> On 4/15/2013 6:13 AM, Will Deacon wrote:
>>> If so, doesn't that strongly tie your video driver to the SMMU?
>>
>> Isn't this more or less what you are doing in DT where you associate
>> specific devices with an IOMMU (mmu-masters)?
> 
> No. The device-tree describes the *hardware*, as per usual. The StreamIDs
> are fixed properties of the SoC and we can't change them from Linux, so we
> describe all of the StreamIDs upstream of each SMMU so that we can program
> the thing. There's no way to generic way to discover them.

I meant that you are putting phandles to bus masters in the device tree
that use/need the SMMU for VA2PA translation. Doesn't this put a
dependency on the bus master devices? How will this work? Lets say that
we have a device during bootup that needs to use the SMMU (such as a
display processor [DP]). Don't you have cyclic dependency? The SMMU
device needs the DP device (phandle) but the DP device needs the SMMU to
initialize its device driver?

>>> This seems to be where we differ. My anticipated use-case is that a domain
>>> is allocated, which defines an empty address space. Masters are then
>>> attached to the domain by passing their struct device, so this may
>>> correspond to a DMA controller or a video core, in your case. The context
>>> bank is allocated dynamically when the first device is added to the
>>> domain, and then it is subsequently shared between all the masters in that
>>> domain.
>>
>> I feel that there are some limitation with this. Maybe you can address
>> the following:
>>
>> 1) What if you want two context banks in one domain (shared page table)?
> 
> Why would a page table shared between devices require multiple context
> banks? Multiple SMRs and S2CRs, sure, but they would ultimately point at the
> same context bank (and hence same address space).

What if you want to have 2 different VMID's being generated? Also, what
about TLB management? If I have two context banks I can invalidate only
entries associated with 1 of the context banks (if VMID differ for the
two context banks).

>> 2) What if a master (device) needs to use 2 or more context banks?
> 
> If a master needs to be in two address spaces at once, then it will need to
> attach it's StreamIDs to different domains. You can't place a single
> StreamID in two address spaces (this is an architectural constraint).

Yes, you would have a separate domain. I am just wondering how I would
model this in DT using the bindings that you are proposing? How does it
work? The bindings specify bus masters to StreamIDs. So if I call attach
with the master device you will allocate a context bank and program the
StreamIDs as specified in the DT. So now if I want to have another
context bank associated with the same master device what do I do? I call
into attach with a new domain but with the same master device but the
master device is already attached to a context/domain.

Thanks,

Olav Haugan

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
