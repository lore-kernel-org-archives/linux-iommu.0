From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v3 2/2] iommu/amd: Add basic debugfs infrastructure for
 AMD IOMMU
Date: Tue, 17 Apr 2018 19:05:48 +0100
Message-ID: <7d0e1612-40ce-3091-733f-b553b6c325fe@arm.com>
References: <152302042701.47565.17954813724758433858.stgit@sosxen2.amd.com>
 <152302067362.47565.628887796165116844.stgit@sosxen2.amd.com>
 <1523926423.2747.19.camel@intel.com>
 <823c10d2-e9ab-0f17-22c7-c2eea312bef8@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <823c10d2-e9ab-0f17-22c7-c2eea312bef8@amd.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Hook, Gary" <ghook@amd.com>, "Mehta, Sohil" <sohil.mehta@intel.com>, "gary.hook@amd.com" <gary.hook@amd.com>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On 17/04/18 18:42, Hook, Gary wrote:
> On 4/16/2018 8:52 PM, Mehta, Sohil wrote:
>> On Fri, 2018-04-06 at 08:17 -0500, Gary R Hook wrote:
>>>
>>> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
>>> index 5eb1121d54b9..0ca250f626d9 100644
>>> --- a/drivers/iommu/Makefile
>>> +++ b/drivers/iommu/Makefile
>>> @@ -11,6 +11,7 @@ obj-$(CONFIG_IOMMU_IOVA) += iova.o
>>>   obj-$(CONFIG_OF_IOMMU) += of_iommu.o
>>>   obj-$(CONFIG_MSM_IOMMU) += msm_iommu.o
>>>   obj-$(CONFIG_AMD_IOMMU) += amd_iommu.o amd_iommu_init.o
>>> +obj-$(CONFIG_IOMMU_DEBUG) += amd_iommu_debugfs.o
>>
>> Compiling amd_iommu_debugfs.c seems to depend only
>> on CONFIG_IOMMU_DEBUG. Can we prevent the code within
>> amd_iommu_debugfs.c from getting compiled when either CONFIG_AMD_IOMMU
>> or CONFIG_IOMMU_DEBUG is disabled?
> 
> That's a good point. My intention was that only one switch was required 
> to incorporate any DebugFS support, but I see now that I didn't consider 
> all of the cases.
> 
> It appears that a per-device switch is also necessary. Unless someone 
> has a better idea.

Well, you could do a makefile-level dependency i.e.:

ifeq ($(CONFIG_IOMMU_DEBUG), y)
obj-$(CONFIG_AMD_IOMMU) += amd_iommu_debugfs.o
obj-$(CONFIG_BLAH_IOMMU) += blah_iommu_debugfs.o
...
endif

Or alternatively have an intermediate silent Kconfig option:

config AMD_IOMMU_DEBUG
	def_bool y
	depends on AMD_IOMMU && IOMMU_DEBUG

The makefile option is arguably ugly, but does at least scale better ;)

Robin.

>>>   obj-$(CONFIG_AMD_IOMMU_V2) += amd_iommu_v2.o
>>>   obj-$(CONFIG_ARM_SMMU) += arm-smmu.o
>>>   obj-$(CONFIG_ARM_SMMU_V3) += arm-smmu-v3.o
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
