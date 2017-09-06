From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [RFC PATCH 0/6] Add platform device SVM support for ARM SMMUv3
Date: Wed, 6 Sep 2017 10:59:43 +0100
Message-ID: <fd4200c1-3c89-23f1-a2b1-6457ef8475c1@arm.com>
References: <1504167642-14922-1-git-send-email-xieyisheng1@huawei.com>
 <95d1a9e2-1816-ff7d-9a8d-98406a6c2c22@arm.com>
 <de1a6b52-5e4f-1c0a-af3d-f6adb4b01daf@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <de1a6b52-5e4f-1c0a-af3d-f6adb4b01daf@huawei.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Yisheng Xie <xieyisheng1@huawei.com>
Cc: joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org, sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org, will.deacon@arm.com, robin.murphy@arm.com, robert.moore@intel.com, lv.zheng@intel.com, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devel@acpica.org, liubo95@huawei.com, chenjiankang1@huawei.com, xieyisheng@huawei.com
List-Id: iommu@lists.linux-foundation.org

On 06/09/17 02:16, Yisheng Xie wrote:
> Hi Jean-Philippe,
> 
> On 2017/9/5 20:56, Jean-Philippe Brucker wrote:
>> On 31/08/17 09:20, Yisheng Xie wrote:
>>> Jean-Philippe has post a patchset for Adding PCIe SVM support to ARM SMMUv3:
>>> https://www.spinics.net/lists/arm-kernel/msg565155.html
>>>
>>> But for some platform devices(aka on-chip integrated devices), there is also
>>> SVM requirement, which works based on the SMMU stall mode.
>>> Jean-Philippe has prepared a prototype patchset to support it:
>>> git://linux-arm.org/linux-jpb.git svm/stall
>>
>> Only meant for testing at that point, and unfit even for an RFC.
> 
> Sorry about that, I should ask you before send it out. It's my mistake. For I also
> have some question about this patchset.
> 
> We have related device, and would like to do some help about it. Do you have
> any plan about upstream ?
> 
>>
>>> We tested this patchset with some fixes on a on-chip integrated device. The
>>> basic function is ok, so I just send them out for review, although this
>>> patchset heavily depends on the former patchset (PCIe SVM support for ARM
>>> SMMUv3), which is still under discussion.
>>>
>>> Patch Overview:
>>> *1 to 3 prepare for device tree or acpi get the device stall ability and pasid bits
>>> *4 is to realise the SVM function for platform device
>>> *5 is fix a bug when test SVM function while SMMU donnot support this feature
>>> *6 avoid ILLEGAL setting of STE and CD entry about stall
>>>
>>> Acctually here, I also have some questions about SVM on SMMUv3:
>>>
>>> 1. Why the SVM feature on SMMUv3 depends on BTM feature? when bind a task to device,
>>>    it will register a mmu_notify. Therefore, when a page range is invalid, we can
>>>    send TLBI or ATC invalid without BTM?
>>
>> We could, but the end goal for SVM is to perfectly mirror the CPU page
>> tables. So for platform SVM we would like to get rid of MMU notifiers
>> entirely.
> 
> I see, but for some SMMU which do not support BTM, it cannot benefit from SVM.
> 
> Meanwhile, do you mean even with BTM feature, the PCI-e device also need to send a
> ATC invalid by MMU notify? It seems not fair, why not hardware do the entirely work
> in this case? It may costly for send ATC invalid and sync.

It will certainly be costly. But there are major problems with
transforming broadcast TLB maintenance into ATC invalidations in HW:

* VMID:ASID to SID:SSID conversion. TLBIs use VMID:ASID, while ATCIs use
SID:SSID.

* Most importantly, ATC invalidations accounting. Each endpoint has a
limited number of in-flight ATC invalidate requests. The conversion module
would have to buffer incoming invalidations and wait for in-flight ATC
invalidation to complete before sending the next ones. In case of
overflow, either we lose invalidation (which opens security holes) or we
somehow put back-pressure on the interconnect (no idea how feasible this
is, I suspect really hard).

Solving the last one is also quite difficult in software, but at least we
can still invalidate a range. In hardware we would invalidate the ATC
page-by-page and quickly jam the bus.

Thanks,
Jean
