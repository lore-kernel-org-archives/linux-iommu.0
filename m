From: Bob Liu <liubo95@huawei.com>
Subject: Re: [RFCv2 PATCH 00/36] Process management for IOMMU + SVM for SMMUv3
Date: Wed, 8 Nov 2017 09:21:50 +0800
Message-ID: <79f3610e-e522-29ad-8a93-be7e05df2973@huawei.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
 <0c6778d8-741f-0db7-fe3c-df88a75ebbb2@huawei.com>
 <0fecd29e-eaf7-9503-b087-7bfbc251da88@arm.com>
 <c6b7fb4b-4f2b-0d81-8bb5-8fa6b62aca3a@huawei.com>
 <8a1e090d-22e8-0295-a53f-bc3b5b7d7971@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <8a1e090d-22e8-0295-a53f-bc3b5b7d7971@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Yisheng Xie <xieyisheng1@huawei.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Cc: "joro@8bytes.org" <joro@8bytes.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, Mark Rutland <Mark.Rutland@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "lenb@kernel.org" <lenb@kernel.org>, Robin Murphy <Robin.Murphy@arm.com>, "bhelgaas@google.com" <bhelgaas@google.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "tn@semihalf.com" <tn@semihalf.com>, "thunder.leizhen@huawei.com" <thunder.leizhen@huawei.com>, "gabriele.paoloni@huawei.com" <gabriele.paoloni@huawei.com>, "nwatters@codeaurora.org" <nwatters@codeaurora.org>
List-Id: iommu@lists.linux-foundation.org

Hi Jean,

On 2017/10/12 20:55, Jean-Philippe Brucker wrote:
> On 12/10/17 13:05, Yisheng Xie wrote:
> [...]
>>>>> * An iommu_process can be bound to multiple domains, and a domain can have
>>>>>   multiple iommu_process.
>>>> when bind a task to device, can we create a single domain for it? I am thinking
>>>> about process management without shared PT(for some device only support PASID
>>>> without pri ability), it seems hard to expand if a domain have multiple iommu_process?
>>>> Do you have any idea about this?
>>>
>>> A device always has to be in a domain, as far as I know. Not supporting
>>> PRI forces you to pin down all user mappings (or just the ones you use for
>>> DMA) but you should sill be able to share PT. Now if you don't support
>>> shared PT either, but only PASID, then you'll have to use io-pgtable and a
>>> new map/unmap API on an iommu_process. I don't understand your concern
>>> though, how would the link between process and domains prevent this use-case?
>>>
>> So you mean that if an iommu_process bind to multiple devices it should create
>> multiple io-pgtables? or just share the same io-pgtable?
> 
> I don't know to be honest, I haven't thought much about the io-pgtable
> case, I'm all about sharing the mm :)
> 

Sorry to get back to this thread, but traditional DMA_MAP use case may also want to
enable Substreamid/PASID.
As a general framework, you may also consider SubStreamid/Pasid support for dma map/io-pgtable.

We're considering make io-pgtables per SubStreamid/Pasid, but haven't decide put all 
io-pgtables into a single domain or iommu_process.

Thanks,
Liubo

> It really depends on what the user (GPU driver I assume) wants. I think
> that if you're not sharing an mm with the device, then you're trying to
> hide parts of the process to the device, so you'd also want the
> flexibility of having different io-pgtables between devices. Different
> devices accessing isolated parts of the process requires separate io-pgtables.
> 


