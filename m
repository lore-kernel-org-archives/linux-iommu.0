From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [RFC PATCH 0/6] Add platform device SVM support for ARM SMMUv3
Date: Wed, 6 Sep 2017 09:24:23 +0800
Message-ID: <1bd8a485-d915-5d82-1ffe-0754b32a7656@linaro.org>
References: <1504167642-14922-1-git-send-email-xieyisheng1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1504167642-14922-1-git-send-email-xieyisheng1@huawei.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Yisheng Xie <xieyisheng1@huawei.com>, jean-philippe.brucker@arm.com
Cc: joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org, will.deacon@arm.com, robin.murphy@arm.com, robert.moore@intel.com, lv.zheng@intel.com, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devel@acpica.org, liubo95@huawei.com, chenjiankang1@huawei.com, xieyisheng@huawei.com
List-Id: iommu@lists.linux-foundation.org

On 2017/8/31 16:20, Yisheng Xie wrote:
> Jean-Philippe has post a patchset for Adding PCIe SVM support to ARM SMMUv3:
> https://www.spinics.net/lists/arm-kernel/msg565155.html
> 
> But for some platform devices(aka on-chip integrated devices), there is also
> SVM requirement, which works based on the SMMU stall mode.
> Jean-Philippe has prepared a prototype patchset to support it:
> git://linux-arm.org/linux-jpb.git svm/stall
> 
> We tested this patchset with some fixes on a on-chip integrated device. The
> basic function is ok, so I just send them out for review, although this
> patchset heavily depends on the former patchset (PCIe SVM support for ARM
> SMMUv3), which is still under discussion.
> 
> Patch Overview:
> *1 to 3 prepare for device tree or acpi get the device stall ability and pasid bits
> *4 is to realise the SVM function for platform device
> *5 is fix a bug when test SVM function while SMMU donnot support this feature
> *6 avoid ILLEGAL setting of STE and CD entry about stall
> 
> Acctually here, I also have a question about SVM on SMMUv3:
> 
> 1. Why the SVM feature on SMMUv3 depends on BTM feature? when bind a task to device,
>     it will register a mmu_notify. Therefore, when a page range is invalid, we can
>     send TLBI or ATC invalid without BTM?
> 
> 2. According to ACPI IORT spec, named component specific data has a node flags field
>     whoes bit0 is for Stall support. However, it do not have any field for pasid bit.
>     Can we use other 5 bits[5:1] for pasid bit numbers, so we can have 32 pasid bit for
>     a single platform device which should be enough, because SMMU only support 20 bit pasid

I think we can propose something similar, it's a missing function in
IORT.

Thanks
Hanjun
