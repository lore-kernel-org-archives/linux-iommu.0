From: Sricharan R <sricharan@codeaurora.org>
Subject: Re: [PATCH 3/4] iommu: add qcom_iommu
Date: Fri, 5 May 2017 18:01:15 +0530
Message-ID: <0c3cd3f0-da66-75d0-b8af-a23ac93e4d95@codeaurora.org>
References: <20170504133436.24288-1-robdclark@gmail.com>
 <20170504133436.24288-4-robdclark@gmail.com>
 <CAL_JsqKCn5sAQfbRQeb_Wr6WMz2n+XgKyiFOdJmbU1_g8pob+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqKCn5sAQfbRQeb_Wr6WMz2n+XgKyiFOdJmbU1_g8pob+A@mail.gmail.com>
Content-Language: en-US
Sender: linux-arm-msm-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>, Rob Clark <robdclark@gmail.com>
Cc: Linux IOMMU <iommu@lists.linux-foundation.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stanimir Varbanov <stanimir.varbanov@linaro.org>, Archit Taneja <architt@codeaurora.org>
List-Id: iommu@lists.linux-foundation.org

< snip ..>
>> +
>> +static struct platform_driver qcom_iommu_driver = {
>> +       .driver = {
>> +               .name           = "qcom-iommu",
>> +               .of_match_table = of_match_ptr(qcom_iommu_of_match),
>> +               .pm             = &qcom_iommu_pm_ops,
>> +       },
>> +       .probe  = qcom_iommu_device_probe,
>> +       .remove = qcom_iommu_device_remove,
>> +};
>> +module_platform_driver(qcom_iommu_driver);
>> +
>> +IOMMU_OF_DECLARE(qcom_iommu_dev, "qcom,msm-iommu-v1", NULL);
> 
> Is this needed any more with deferred probe now?

Yes, because the __iommu_of_table is still used for to find out
the presence of the driver.

Regards,
 Sricharan

> 
>> +
>> +MODULE_DESCRIPTION("IOMMU API for QCOM IOMMU v1 implementations");
>> +MODULE_LICENSE("GPL v2");
>> --
>> 2.9.3
>>

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
