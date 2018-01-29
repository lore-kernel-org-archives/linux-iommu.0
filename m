From: Gary R Hook <gary.hook@amd.com>
Subject: Re: [PATCH 1/5] iommu/amd - Add debugfs support
Date: Mon, 29 Jan 2018 13:05:15 -0600
Message-ID: <da9402d0-026a-225e-e160-4e41bcd80e6a@amd.com>
References: <151701071164.16448.3611271062222336838.stgit@taos>
 <151701073560.16448.7715293076458740364.stgit@taos>
 <20180127000045.gatkndpu64no3o3j@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180127000045.gatkndpu64no3o3j@pd.tnic>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: iommu@lists.linux-foundation.org, joro@8bytes.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 01/26/2018 06:00 PM, Borislav Petkov wrote:
> On Fri, Jan 26, 2018 at 05:52:15PM -0600, Gary R Hook wrote:
>> --- a/drivers/iommu/Kconfig
>> +++ b/drivers/iommu/Kconfig
>> @@ -135,6 +135,15 @@ config AMD_IOMMU_V2
>>   	  hardware. Select this option if you want to use devices that support
>>   	  the PCI PRI and PASID interface.
>>   
>> +config AMD_IOMMU_DEBUG
>> +	bool "Expose AMD IOMMU internals in DebugFS"
>> +	depends on AMD_IOMMU && DEBUG_FS
>> +	default n
>> +	help
>> +	  With this option you can enable access to AMD IOMMU registers and
>> +	  data structures through debugfs. Select this to see information
>> +	  about the internal state of the device.
>> +
>>   # Intel IOMMU support
>>   config DMAR_TABLE
>>   	bool
>> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
>> index 1fb695854809..d9e9ed5f6cfc 100644
>> --- a/drivers/iommu/Makefile
>> +++ b/drivers/iommu/Makefile
>> @@ -9,7 +9,7 @@ obj-$(CONFIG_IOMMU_IO_PGTABLE_LPAE) += io-pgtable-arm.o
>>   obj-$(CONFIG_IOMMU_IOVA) += iova.o
>>   obj-$(CONFIG_OF_IOMMU)	+= of_iommu.o
>>   obj-$(CONFIG_MSM_IOMMU) += msm_iommu.o
>> -obj-$(CONFIG_AMD_IOMMU) += amd_iommu.o amd_iommu_init.o
>> +obj-$(CONFIG_AMD_IOMMU) += amd_iommu.o amd_iommu_init.o amd_iommu_debugfs.o
> 
> That looks like it needs to be:
> 
> obj-$(CONFIG_AMD_IOMMU_DEBUG) += amd_iommu_debugfs.o

Of course. Thanks, Boris. I'll get that in v2.
