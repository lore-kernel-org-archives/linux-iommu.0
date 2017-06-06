From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [v6 2/3] iommu/arm-smmu-v3: Add workaround for Cavium ThunderX2
 erratum #74
Date: Tue, 6 Jun 2017 17:38:37 +0800
Message-ID: <9ab6fba9-5270-a618-d149-2e4c11d4cbf6@linaro.org>
References: <1494592866-14076-1-git-send-email-gakula@caviumnetworks.com>
 <1494592866-14076-3-git-send-email-gakula@caviumnetworks.com>
 <5FC3163CFD30C246ABAA99954A238FA838351762@FRAEML521-MBX.china.huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <5FC3163CFD30C246ABAA99954A238FA838351762@FRAEML521-MBX.china.huawei.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, Geetha sowjanya <gakula@caviumnetworks.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>, "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>, "sudeep.holla@arm.com" <sudeep.holla@arm.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Cc: "Charles.Garcia-Tobin@arm.com" <Charles.Garcia-Tobin@arm.com>, Geetha Sowjanya <geethasowjanya.akula@cavium.com>, "geethasowjanya.akula@gmail.com" <geethasowjanya.akula@gmail.com>, "jcm@redhat.com" <jcm@redhat.com>, "linu.cherian@cavium.com" <linu.cherian@cavium.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "robert.moore@intel.com" <robert.moore@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "robert.richter@cavium.com" <robert.richter@cavium.com>, "lv.zheng@intel.com" <lv.zheng@intel.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "sgoutham@cavium.com" <sgoutham@cavium.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, devel@acpica.o
List-Id: iommu@lists.linux-foundation.org

On 2017/5/17 18:13, Shameerali Kolothum Thodi wrote:
>>   #ifdef CONFIG_ACPI
>> +static void acpi_smmu_get_options(u32 model, struct arm_smmu_device
>> +*smmu) {
>> +	if (model == ACPI_IORT_SMMU_CAVIUM_CN99XX)
>> +		smmu->options |= ARM_SMMU_OPT_PAGE0_REGS_ONLY;
 >
> HiSIlicon hip06/07 boards have a similar existing option to enable,
> ARM_SMMU_OPT_SKIP_PREFETCH. I have just sent out a similar patch to enable
> It-" [PATCH] iommu/arm-smmu-v3: Enable ACPI based HiSilicon CMD_PREFETCH
>   quirk(erratum 161010701)".  May be it can be merged here, if this series goes through.
>   Not sure about the protocol though.

I think you can add a patch on top of Geetha's, and clarify
the dependency in the change log, then it will be easy for
maintainer to apply.

Thanks
Hanjun
