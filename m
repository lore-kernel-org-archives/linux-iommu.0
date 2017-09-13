From: Bob Liu <liubo95-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH 0/6] Add platform device SVM support for ARM SMMUv3
Date: Wed, 13 Sep 2017 09:11:03 +0800
Message-ID: <9d7083a7-fc67-26a3-0d3d-f1a5a4942eaf@huawei.com>
References: <1504167642-14922-1-git-send-email-xieyisheng1@huawei.com>
 <95d1a9e2-1816-ff7d-9a8d-98406a6c2c22@arm.com>
 <caf68193-6aff-1e1c-86cd-9cc7069b0e37@huawei.com>
 <2874a1f3-22f1-20d4-4009-50add127a10f@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2874a1f3-22f1-20d4-4009-50add127a10f-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, Yisheng Xie <xieyisheng1-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Cc: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org, chenjiankang1-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, xieyisheng-hv44wF8Li93QT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 2017/9/6 17:57, Jean-Philippe Brucker wrote:
> On 06/09/17 02:02, Bob Liu wrote:
>> On 2017/9/5 20:56, Jean-Philippe Brucker wrote:
>>> On 31/08/17 09:20, Yisheng Xie wrote:
>>>> Jean-Philippe has post a patchset for Adding PCIe SVM support to ARM SMMUv3:
>>>> https://www.spinics.net/lists/arm-kernel/msg565155.html
>>>>
>>>> But for some platform devices(aka on-chip integrated devices), there is also
>>>> SVM requirement, which works based on the SMMU stall mode.
>>>> Jean-Philippe has prepared a prototype patchset to support it:
>>>> git://linux-arm.org/linux-jpb.git svm/stall
>>>
>>> Only meant for testing at that point, and unfit even for an RFC.
>>>
>>
>> Sorry for the misunderstanding.
>> The PRI mode patches is in RFC even no hardware for testing, so I thought it's fine for "Stall mode" patches sent as RFC.
>> We have tested the Stall mode on our platform.
>> Anyway, I should confirm with you in advance.
>>
>> Btw, Would you consider the "stall mode" upstream at first? Since there is no hardware for testing the PRI mode.
>> (We can provide you the hardware which support SMMU stall mode if necessary.)
> 
> Yes. What's blocking the ATS, PRI and PASID patches at the moment is the
> lack of endpoints for testing. There has been lots of discussion on the
> API side since my first RFC and I'd like to resubmit the API changes soon.
> It is the same API for ATS+PRI+PASID and SSID+Stall, so the backend
> doesn't matter.
> 
> I'm considering upstreaming SSID+Stall first if it can be tested on
> hardware (having direct access to it would certainly speed things up).
> This would require some work in moving the PCI bits at the end of the
> series. I can reserve some time in the coming months to do it, but I need
> to know what to focus on. Are you able to test SSID as well?
> 

Update:
Our current platform device has only one SSID register, so that have to do manually 
switch(write different ssid to that register) if want to use by different processes.

But we're going to have an new platform who's platform device can support multi ssid.

Regards,
Bob

>>>> We tested this patchset with some fixes on a on-chip integrated device. The
>>>> basic function is ok, so I just send them out for review, although this
>>>> patchset heavily depends on the former patchset (PCIe SVM support for ARM
>>>> SMMUv3), which is still under discussion.
>>>>
>>>> Patch Overview:
>>>> *1 to 3 prepare for device tree or acpi get the device stall ability and pasid bits
>>>> *4 is to realise the SVM function for platform device
>>>> *5 is fix a bug when test SVM function while SMMU donnot support this feature
>>>> *6 avoid ILLEGAL setting of STE and CD entry about stall
>>>>
>>>> Acctually here, I also have a question about SVM on SMMUv3:
>>>>
>>>> 1. Why the SVM feature on SMMUv3 depends on BTM feature? when bind a task to device,
>>>>    it will register a mmu_notify. Therefore, when a page range is invalid, we can
>>>>    send TLBI or ATC invalid without BTM?
>>>
>>> We could, but the end goal for SVM is to perfectly mirror the CPU page
>>> tables. So for platform SVM we would like to get rid of MMU notifiers
>>> entirely.
>>>
>>>> 2. According to ACPI IORT spec, named component specific data has a node flags field
>>>>    whoes bit0 is for Stall support. However, it do not have any field for pasid bit.
>>>>    Can we use other 5 bits[5:1] for pasid bit numbers, so we can have 32 pasid bit for
>>>>    a single platform device which should be enough, because SMMU only support 20 bit pasid
>>>>
>>
>> Any comment on this?
>> The ACPI IORT spec may need be updated?
> 
> I suppose that the Named Component Node could be used for SSID and stall
> capability bits. Can't the ACPI namespace entries be extended to host
> these capabilities in a more generic way? Platforms with different IOMMUs
> might also need this information some day.
> 


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
