From: okaya@codeaurora.org
Subject: Re: [RFCv2 PATCH 05/36] iommu/process: Bind and unbind process to and
 from devices
Date: Fri, 19 Jan 2018 08:07:21 -0500
Message-ID: <c0e39c5a69a6f612e11c6076be9c5d53@codeaurora.org>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
 <20171006133203.22803-6-jean-philippe.brucker@arm.com>
 <0772e71e-4861-1e7b-f248-88aaba8bf2fc@codeaurora.org>
 <e2753b59-2b9e-ffc6-a7b8-0ed23df38e10@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <e2753b59-2b9e-ffc6-a7b8-0ed23df38e10@arm.com>
Sender: linux-pci-owner@vger.kernel.org
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, iommu@lists.linux-foundation.org, joro@8bytes.org, robh+dt@kernel.org, Mark Rutland <Mark.Rutland@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, hanjun.guo@linaro.org, Sudeep Holla <Sudeep.Holla@arm.com>, rjw@rjwysocki.net, lenb@kernel.org, Robin Murphy <Robin.Murphy@arm.com>, bhelgaas@google.com, alex.williamson@redhat.com, tn@semihalf.com, liubo95@huawei.com, thunder.leizhen@huawei.com, xieyisheng1@huawei.com, gabriele.paoloni@huawei.com, nwatters@codeaurora.org, rfranz@cavium.com, dwmw2@infradead.org, jacob.jun.pan@linux.intel.com, yi.l.liu@intel.com, ashok.
List-Id: iommu@lists.linux-foundation.org

On 2018-01-19 05:27, Jean-Philippe Brucker wrote:
> Hi Sinan,
> 
> On 19/01/18 04:52, Sinan Kaya wrote:
>> Hi Jean-Philippe,
>> 
>> On 10/6/2017 9:31 AM, Jean-Philippe Brucker wrote:
>>>  /**
>>> + * iommu_process_bind_device - Bind a process address space to a 
>>> device
>>> + * @dev: the device
>>> + * @task: the process to bind
>>> + * @pasid: valid address where the PASID will be stored
>>> + * @flags: bond properties (IOMMU_PROCESS_BIND_*)
>>> + *
>>> + * Create a bond between device and task, allowing the device to 
>>> access the
>>> + * process address space using the returned PASID.
>>> + *
>>> + * On success, 0 is returned and @pasid contains a valid ID. 
>>> Otherwise, an error
>>> + * is returned.
>>> + */
>>> +int iommu_process_bind_device(struct device *dev, struct task_struct 
>>> *task,
>>> +			      int *pasid, int flags)
>> 
>> This API doesn't play nice with endpoint device drivers that have 
>> PASID limitations.
>> 
>> The AMD driver seems to have PASID limitations per product that are 
>> not being
>> advertised in the PCI capability.
>> 
>> device_iommu_pasid_init()
>> {
>>         pasid_limit = min_t(unsigned int,
>>                         (unsigned int)(1 << 
>> kfd->device_info->max_pasid_bits),
>>                         iommu_info.max_pasids);
>>         /*
>>          * last pasid is used for kernel queues doorbells
>>          * in the future the last pasid might be used for a kernel 
>> thread.
>>          */
>>         pasid_limit = min_t(unsigned int,
>>                                 pasid_limit,
>>                                 kfd->doorbell_process_limit - 1);
>> }
>> 
>> kfd->device_info->max_pasid_bits seems to contain per device 
>> limitations.
>> 
>> Would you be willing to extend the API so that the requester can 
>> impose some limit
>> on the PASID value that is getting allocated.
> 
> Good point. Following the feedback for this series, next version adds
> another public function:
> 
> int iommu_sva_device_init(struct device *dev, int features);
> 
> that has to be called by the device driver before any bind(). The 
> intent
> is to let some IOMMU drivers initialize PASID tables and other features
> lazily, only if the device driver actually intends to use them. Maybe I
> could change this function to:
> 
> int iommu_sva_device_init(struct device *dev, int features, unsigned 
> int
> max_pasid);
> 
> @features is a bitmask telling what the device driver needs (PASID 
> and/or
> page faults). If features has IOMMU_SVA_FEAT_PASID set, then device 
> driver
> can set a max_pasid limit, that we'd store in our private device-iommu
> data. If max_pasid is 0, then we'd use the PCI limit.

Yes, this should work.

> 
> Thanks,
> Jean
