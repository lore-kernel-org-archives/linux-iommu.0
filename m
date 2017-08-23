From: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH v6 3/3] iommu/arm-smmu-v3:Enable ACPI based HiSilicon
 erratum 161010801
Date: Wed, 23 Aug 2017 14:17:24 +0100
Message-ID: <c6b7c641-b839-1388-7982-366e796e6ba9@huawei.com>
References: <20170809100715.870516-1-shameerali.kolothum.thodi@huawei.com>
 <20170809100715.870516-4-shameerali.kolothum.thodi@huawei.com>
 <20170810172723.GD9980@arm.com>
 <5FC3163CFD30C246ABAA99954A238FA8383CC287@FRAEML521-MBX.china.huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <5FC3163CFD30C246ABAA99954A238FA8383CC287@FRAEML521-MBX.china.huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, Will Deacon <will.deacon@arm.com>
Cc: "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "sudeep.holla@arm.com" <sudeep.holla@arm.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>, "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, Gabriele Paoloni <gabriele.paoloni@huawei.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, Linuxarm <linuxarm@huawei.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>, "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>
List-Id: iommu@lists.linux-foundation.org

>>> Signed-off-by: Shameer Kolothum
>> <shameerali.kolothum.thodi@huawei.com>
>>> ---
>>>  drivers/iommu/arm-smmu-v3.c | 27 ++++++++++++++++++++++-----
>>>  1 file changed, 22 insertions(+), 5 deletions(-)
>>
>> Please can you also add a devicetree binding with corresponding
>> documentation to enable this workaround on non-ACPI based systems too?
>> It should be straightforward if you update the arm_smmu_options table.
>
> As I mentioned before, devicetree was a lower priority and we would definitely
> submit patch to support that. Even if we update the arm_smmu_options table
> with DT binding, the generic function to retrieve the MSI address regions only
> works on ACPI/IORT case now.
>

Hi Will,

Can you confirm your stance on supporting this workaround for DT as well 
as ACPI?

For us, we now only "officially" support ACPI FW, and DT support at this 
point is patchy/limited. To me, adding DT support is just more errata 
workaround code to maintain with little useful gain.

Thanks very much,
John

> Moreover I am on holidays starting tomorrow, and really appreciate if this series
> can go through now.
>
> Please let me know.
>
> Thanks,
> Shameer
>
> .
>


