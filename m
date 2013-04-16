From: Olav Haugan <ohaugan@codeaurora.org>
Subject: Re: [PATCH] documentation: iommu: add description of ARM System MMU
 binding
Date: Tue, 16 Apr 2013 11:18:42 -0700
Message-ID: <516D9602.2010404@codeaurora.org>
References: <1365094259-24847-1-git-send-email-will.deacon@arm.com> <515F37C1.4000109@codeaurora.org> <20130408092535.GA17476@mudshark.cambridge.arm.com> <5162F87A.7070409@codeaurora.org> <20130410173732.GQ26992@mudshark.cambridge.arm.com> <5169C7D1.8070300@codeaurora.org> <20130415131341.GG9827@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20130415131341.GG9827@mudshark.cambridge.arm.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Andreas Herrmann <andreas.herrmann@calxeda.com>, "tzeng@codeaurora.org" <tzeng@codeaurora.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-arm-msm@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 4/15/2013 6:13 AM, Will Deacon wrote:
> On Sat, Apr 13, 2013 at 10:02:09PM +0100, Olav Haugan wrote:
>> On 4/10/2013 10:37 AM, Will Deacon wrote:
>>> Ok, but then how does that interact with the IOMMU API in Linux? e.g.
>>> if a client asks for an iova <-> pa mapping on a device, then you
>>> need to lookup the StreamIDs for that device, no?
>>
>> Can you explain this use case a bit more. I am not clear what you mean
>> by a "client"? Are you referring to a client in Linux or are you
>> referring to the client being the core behind an IOMMU (such as a DMA
>> engine or a video core)?
> 
> Sure. By `client', I mean any use of the IOMMU API. It could be something
> like your LVD example later on, it could be KVM or it could be indirectly
> via dma-mapping. Basically, any user of <linux/iommu.h>.

Ok, so if I do a VA2PA on a domain (calling iommu_iova_to_phys()) you
don't need any information about StreamID (no need to look up the
StreamID). You would just walk the page table of the domain and find the
address (or use ATS on the IOMMU if supported by the HW).

>> I am not sure how StreamIDs relates to the IOMMU API in Linux :-)
> 
> That's the thing; they don't, at least not explicitly. The StreamIDs must
> all be handled inside the driver and it's actually what the driver would
> deal with, rather than devices.
> 
> For example, if I create an IOMMU domain containing a DMA controller, that
> means that I have associated a set of StreamIDs (i.e. those configured to
> identify the DMA controller's master ports) with that domain. That may have
> further consequences on which other devices can be put in the same domain
> (stream-matching may require some IDs to sit in the same address space/domain)
> and also effectively parameterises the domain, by pointing those StreamIDs
> at the same context bank.

Yes, this is clear to me.

>> I think it helps if I explain my use case to you so you understand how
>> we use the IOMMU and maybe you can explain your use case and how your
>> driver works so that we can get on the same page. BTW, our ARMv1 IOMMU
>> driver can be found @ [1]
>>
>> Our use case:
>>
>> 1) During boot IOMMU HW is probed, devices for each IOMMU and for each
>> context bank are created.
> 
> So you create a device for each context bank...
> 
>> 2) Video session starts.
>> 3) Linux Video Driver (LVD) creates one or more domain
>> (iommu_domain_alloc) and calls iommu_attach_device() for each context
>> bank it is going to use.
> 
> ...and attach the context bank to the domain dynamically?

Yes

> If so, doesn't that strongly tie your video driver to the SMMU?

Isn't this more or less what you are doing in DT where you associate
specific devices with an IOMMU (mmu-masters)?

>> The video driver selects context bank to attach to based on the use case
>> and does not know about StreamIDs really.
>>
>> BTW, when you call iommu_attach_device() what "device" do you pass as
>> argument? Do you pass the IOMMU as a device? How do you specify which
>> Context Bank to attach to?
> 
> This seems to be where we differ. My anticipated use-case is that a domain
> is allocated, which defines an empty address space. Masters are then
> attached to the domain by passing their struct device, so this may
> correspond to a DMA controller or a video core, in your case. The context
> bank is allocated dynamically when the first device is added to the
> domain, and then it is subsequently shared between all the masters in that
> domain.

I feel that there are some limitation with this. Maybe you can address
the following:

1) What if you want two context banks in one domain (shared page table)?
2) What if a master (device) needs to use 2 or more context banks?

>>> Why can't the secure world just hide those context banks by using 
>>> SMMU_SCR1.NSNUMCBO?
>>
>> Yes, that is a possibility for context banks. If you have 1 or more
>> "secure" context banks it also means that Linux does not have access
>> (read: can't have) to the global register space and this must be
>> communicated somehow (hence the "secure-id" IOMMU node property. The
>> secure-context property might be redundant. However, there might be use
>> cases were Linux would want to know about the secure context bank. One
>> such use case could be to register for page fault from the secure
>> context bank so that Linux can log a useful page fault message to the
>> kernel log.
> 
> Perhaps, but I don't think it's worth complicating the binding based on a
> potential nice-to-have fault message.
> 

However, global register space (including Stream Match Registers [SMR])
needs to be programmed by the secure environment for security or by
hyper-visor if you are in such an environment.

Thanks,

Olav Haugan

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
