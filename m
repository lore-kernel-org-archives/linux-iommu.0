From: Wan ZongShun <mcuos.com@gmail.com>
Subject: Re: [PATCH 6/6] iommu/amd: Manage iommu_group for non-pci devices
Date: Fri, 8 Jan 2016 09:44:40 +0800
Message-ID: <CAKT61h9ju3W1KWoCuNEksZqCCOfJfiQ=nOYixuNGnhWzvyQgdQ@mail.gmail.com>
References: <1451988444-4694-1-git-send-email-vincent.wan@amd.com>
 <1451988444-4694-7-git-send-email-vincent.wan@amd.com> <20160107120659.GC19149@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160107120659.GC19149@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Wan Zongshun <vincent.wan@amd.com>, linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org, Ray Huang <ray.huang@amd.com>, Borislav Petkov <bp@suse.de>, ken.xue@amd.com, vw@iommu.org
List-Id: iommu@lists.linux-foundation.org

2016-01-07 20:06 GMT+08:00 Joerg Roedel <joro@8bytes.org>:
> On Tue, Jan 05, 2016 at 05:07:24AM -0500, Wan Zongshun wrote:
>> +static struct iommu_group *amd_iommu_device_group(struct device *dev)
>> +{
>> +     if (dev_is_pci(dev))
>> +             return pci_device_group(dev);
>> +
>> +     return acpihid_device_group(dev);
>> +}
>> +
>>  /*****************************************************************************
>>   *
>>   * The next functions belong to the dma_ops mapping/unmapping code.
>> @@ -3202,7 +3233,7 @@ static const struct iommu_ops amd_iommu_ops = {
>>       .iova_to_phys = amd_iommu_iova_to_phys,
>>       .add_device = amd_iommu_add_device,
>>       .remove_device = amd_iommu_remove_device,
>> -     .device_group = pci_device_group,
>> +     .device_group = amd_iommu_device_group,
>
> Does this work? Which bus do the ACPIHID devices belong to (what does
> dev->bus point to)? If it is not &pci_bus_type, then the iommu core code
> will not create an iommu group for the devices.

Yes, it works, we have already done validation on AMD platform.
Please refer to my previous patch :
[PATCH] iommu/amd: set AMD iommu-callbacks for the amba bus.

Currently, The UART DMA is the use case of ACPIHID device, the
dev->bus is amba_bus, so I add bus_set_iommu for this bus type.

We will do create iommu group in acpihid_device_group which will call
generic_device_group to alloc group.

>
>
>         Joerg
>
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu



-- 
---
Vincent Wan(Zongshun)
www.mcuos.com
