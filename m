From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [RFCv2 PATCH 05/36] iommu/process: Bind and unbind process to and
 from devices
Date: Thu, 18 Jan 2018 23:52:03 -0500
Message-ID: <0772e71e-4861-1e7b-f248-88aaba8bf2fc@codeaurora.org>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
 <20171006133203.22803-6-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20171006133203.22803-6-jean-philippe.brucker@arm.com>
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, iommu@lists.linux-foundation.org
Cc: joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org, sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org, robin.murphy@arm.com, bhelgaas@google.com, alex.williamson@redhat.com, tn@semihalf.com, liubo95@huawei.com, thunder.leizhen@huawei.com, xieyisheng1@huawei.com, gabriele.paoloni@huawei.com, nwatters@codeaurora.org, rfranz@cavium.com, dwmw2@infradead.org, jacob.jun.pan@linux.intel.com, yi.l.liu@intel.com, ashok.raj@intel.com, robdclark@gmail.com
List-Id: iommu@lists.linux-foundation.org

Hi Jean-Philippe,

On 10/6/2017 9:31 AM, Jean-Philippe Brucker wrote:
>  /**
> + * iommu_process_bind_device - Bind a process address space to a device
> + * @dev: the device
> + * @task: the process to bind
> + * @pasid: valid address where the PASID will be stored
> + * @flags: bond properties (IOMMU_PROCESS_BIND_*)
> + *
> + * Create a bond between device and task, allowing the device to access the
> + * process address space using the returned PASID.
> + *
> + * On success, 0 is returned and @pasid contains a valid ID. Otherwise, an error
> + * is returned.
> + */
> +int iommu_process_bind_device(struct device *dev, struct task_struct *task,
> +			      int *pasid, int flags)

This API doesn't play nice with endpoint device drivers that have PASID limitations.

The AMD driver seems to have PASID limitations per product that are not being
advertised in the PCI capability.

device_iommu_pasid_init()
{
        pasid_limit = min_t(unsigned int,
                        (unsigned int)(1 << kfd->device_info->max_pasid_bits),
                        iommu_info.max_pasids);
        /*
         * last pasid is used for kernel queues doorbells
         * in the future the last pasid might be used for a kernel thread.
         */
        pasid_limit = min_t(unsigned int,
                                pasid_limit,
                                kfd->doorbell_process_limit - 1);
}

kfd->device_info->max_pasid_bits seems to contain per device limitations.

Would you be willing to extend the API so that the requester can impose some limit
on the PASID value that is getting allocated.

Sinan

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
