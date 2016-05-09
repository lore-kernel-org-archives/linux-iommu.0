From: Wan Zongshun <vw@iommu.org>
Subject: Re: [PATCH] iommu/amd: Set AMD iommu callbacks for platform bus
 driver
Date: Mon, 9 May 2016 20:17:12 +0800
Message-ID: <8c4cc9fc-26df-759e-6630-7bab927cf01b@iommu.org>
References: <1460640533-3025-1-git-send-email-vincent.wan@amd.com>
 <20160509102041.GA13275@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160509102041.GA13275@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, Wan Zongshun <vincent.wan@amd.com>
Cc: iommu@lists.linux-foundation.org, mcuos.com@gmail.com, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org



-------- Original Message --------
> On Thu, Apr 14, 2016 at 09:28:53AM -0400, Wan Zongshun wrote:
>> From: Wan Zongshun <Vincent.Wan@amd.com>
>>
>> AMD has more drivers will use ACPI to platform bus driver later,
>> all those devices need iommu support, such as eMMC acpi driver.
>>
>> Signed-off-by: Wan Zongshun <Vincent.Wan@amd.com>
>> ---
>>  drivers/iommu/amd_iommu.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
>> index c430c10..547cdd4 100644
>> --- a/drivers/iommu/amd_iommu.c
>> +++ b/drivers/iommu/amd_iommu.c
>> @@ -21,6 +21,7 @@
>>  #include <linux/pci.h>
>>  #include <linux/acpi.h>
>>  #include <linux/amba/bus.h>
>> +#include <linux/platform_device.h>
>>  #include <linux/pci-ats.h>
>>  #include <linux/bitmap.h>
>>  #include <linux/slab.h>
>> @@ -2980,6 +2981,9 @@ int __init amd_iommu_init_api(void)
>>  	if (err)
>>  		return err;
>>  #endif
>> +	err = bus_set_iommu(&platform_bus_type, &amd_iommu_ops);
>> +	if (err)
>> +		return err;
>
> Is the platform_bus_type always defined or does this code needs to be
> guarded by another ifdef?

Joerg,

Currently, Only New eMMC driver will rely on this sdhci-acpi.c, but I 
could not find a suitable ifdef XXX micro to limit this 
platform_bus_type here like AMBA bus type before.

Do you think this MMC_SDHCI_ACPI is ok?

Vincent.

>
>
>
> 	Joerg
>
