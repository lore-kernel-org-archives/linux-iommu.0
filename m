From: Olav Haugan <ohaugan@codeaurora.org>
Subject: Re: [PATCH] documentation: iommu: add description of ARM System MMU
 binding
Date: Mon, 08 Jul 2013 09:20:25 -0700
Message-ID: <51DAE6C9.1000106@codeaurora.org>
References: <20130408092535.GA17476@mudshark.cambridge.arm.com> <5162F87A.7070409@codeaurora.org> <20130410173732.GQ26992@mudshark.cambridge.arm.com> <5169C7D1.8070300@codeaurora.org> <20130415131341.GG9827@mudshark.cambridge.arm.com> <516D9602.2010404@codeaurora.org> <20130418190131.GA12344@mudshark.cambridge.arm.com> <5177113D.7060300@codeaurora.org> <20130424095501.GC21850@mudshark.cambridge.arm.com> <5189635A.8090504@codeaurora.org> <20130513090724.GA10369@alberich>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20130513090724.GA10369@alberich>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Andreas Herrmann <andreas.herrmann@calxeda.com>
Cc: "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Will Deacon <will.deacon@arm.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "tzeng@codeaurora.org" <tzeng@codeaurora.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: iommu@lists.linux-foundation.org

Hi Andreas,

On 5/13/2013 2:07 AM, Andreas Herrmann wrote:
> On Tue, May 07, 2013 at 04:26:02PM -0400, Olav Haugan wrote:
>>
>>>>> If a master needs to be in two address spaces at once, then it will need to
>>>>> attach it's StreamIDs to different domains. You can't place a single
>>>>> StreamID in two address spaces (this is an architectural constraint).
>>>>
>>>> Yes, you would have a separate domain. I am just wondering how I would
>>>> model this in DT using the bindings that you are proposing? How does it
>>>> work? The bindings specify bus masters to StreamIDs. So if I call attach
>>>> with the master device you will allocate a context bank and program the
>>>> StreamIDs as specified in the DT. So now if I want to have another
>>>> context bank associated with the same master device what do I do? I call
>>>> into attach with a new domain but with the same master device but the
>>>> master device is already attached to a context/domain.
>>>
>>> Why would you want to place a StreamID into two domains? That doesn't make
>>> any sense and isn't even supported by the architecture (things like
>>> conflicting SMR entries may not even be reported).
>>
>> I think you misunderstood me. I am talking about having for example 1
>> master with two (2) context banks so that StreamID "1" goes to CB0 and
>> StreamID "2" goes to CB1. This means that the master device is attached
>> to two different domains. How do I model this with the the device tree
>> bindings?
> 
> Hi Olav,
> 
> I think with the proposed device tree binding you can't model this.
> 
> Do we have such use cases already? Or what future use cases would
> require this?
> 
> I can imagine of multiple contexts per device for stuff similar to
> what PASID in PCI Express are used for.
> 
> But in such a case you probably want to have some configurable bits in
> the StreamID (that should be set by an SMMU driver). And the DT
> binding should contain the number of contexts that a master device can
> support.
> 

Sorry for the late reply.

The only real use case at this time for a master having more than 1 CB
is for content protection I believe. I understand that this driver does
not currently support content protection or anything related to security.

Thanks,

Olav Haugan

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
