From: Yisheng Xie <xieyisheng1-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH 0/6] Add platform device SVM support for ARM SMMUv3
Date: Wed, 6 Sep 2017 09:16:38 +0800
Message-ID: <de1a6b52-5e4f-1c0a-af3d-f6adb4b01daf@huawei.com>
References: <1504167642-14922-1-git-send-email-xieyisheng1@huawei.com>
 <95d1a9e2-1816-ff7d-9a8d-98406a6c2c22@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <95d1a9e2-1816-ff7d-9a8d-98406a6c2c22-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Cc: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org, liubo95-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, chenjiankang1-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, xieyisheng-hv44wF8Li93QT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Jean-Philippe,

On 2017/9/5 20:56, Jean-Philippe Brucker wrote:
> On 31/08/17 09:20, Yisheng Xie wrote:
>> Jean-Philippe has post a patchset for Adding PCIe SVM support to ARM SMMUv3:
>> https://www.spinics.net/lists/arm-kernel/msg565155.html
>>
>> But for some platform devices(aka on-chip integrated devices), there is also
>> SVM requirement, which works based on the SMMU stall mode.
>> Jean-Philippe has prepared a prototype patchset to support it:
>> git://linux-arm.org/linux-jpb.git svm/stall
> 
> Only meant for testing at that point, and unfit even for an RFC.

Sorry about that, I should ask you before send it out. It's my mistake. For I also
have some question about this patchset.

We have related device, and would like to do some help about it. Do you have
any plan about upstream ?

> 
>> We tested this patchset with some fixes on a on-chip integrated device. The
>> basic function is ok, so I just send them out for review, although this
>> patchset heavily depends on the former patchset (PCIe SVM support for ARM
>> SMMUv3), which is still under discussion.
>>
>> Patch Overview:
>> *1 to 3 prepare for device tree or acpi get the device stall ability and pasid bits
>> *4 is to realise the SVM function for platform device
>> *5 is fix a bug when test SVM function while SMMU donnot support this feature
>> *6 avoid ILLEGAL setting of STE and CD entry about stall
>>
>> Acctually here, I also have some questions about SVM on SMMUv3:
>>
>> 1. Why the SVM feature on SMMUv3 depends on BTM feature? when bind a task to device,
>>    it will register a mmu_notify. Therefore, when a page range is invalid, we can
>>    send TLBI or ATC invalid without BTM?
> 
> We could, but the end goal for SVM is to perfectly mirror the CPU page
> tables. So for platform SVM we would like to get rid of MMU notifiers
> entirely.

I see, but for some SMMU which do not support BTM, it cannot benefit from SVM.

Meanwhile, do you mean even with BTM feature, the PCI-e device also need to send a
ATC invalid by MMU notify? It seems not fair, why not hardware do the entirely work
in this case? It may costly for send ATC invalid and sync.

> 
>> 2. According to ACPI IORT spec, named component specific data has a node flags field
>>    whoes bit0 is for Stall support. However, it do not have any field for pasid bit.
>>    Can we use other 5 bits[5:1] for pasid bit numbers, so we can have 32 pasid bit for
>>    a single platform device which should be enough, because SMMU only support 20 bit pasid
>>
>> 3. Presently, the pasid is allocate for a task but not for a context, if a task is trying
>>    to bind to 2 device A and B:
>>      a) A support 5 pasid bits
>>      b) B support 2 pasid bits
>>      c) when the task bind to device A, it allocate pasid = 16
>>      d) then it must be fail when trying to bind to task B, for its highest pasid is 4.
>>    So it should allocate a single pasid for a context to avoid this?
> 
> Ideally yes, but the model chosen for the IOMMU API was one PASID per
> task, so I implemented this model (the PASID allocator will be common to
> IOMMU core in the future).
It is fair, for each IOMMU need PASID allocator to support SVM.

Thanks
Yisheng Xie

> 
> Therefore the PASID allocation will fail in your example, and there is no
> way around it. If you do (d) then (c), the task will have PASID 4.
> 
> Thanks,
> Jean
> 
> .
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
