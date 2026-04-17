Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C5A3C4547
	for <iommu@lists.linux.dev>; Fri, 17 Apr 2026 14:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776437975; cv=none; b=aA7qa2K1jP4mpISlY3MMJw5E6lo9UjfYqBs6vKT+RmIm8Obz+yNhQs86oGrNGlTb/gXzsZZBrA1Jng6a3KYKyxMr3RrIE05okCMChStOkwqTQt18oGCKS2Dusn/9SgirIEEA4t9nYXhOFfRS1fGELz5KN7GWZG5eyDCnkzOe8+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776437975; c=relaxed/simple;
	bh=ZtFUMV5Ri6I8v15suLAsgMNDvgJXDSSXjxvMzdNSqxU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ggO245kpStIRkQRbWpFVc36VKnagTAVchZ/SfKB3kifd0NPFsPXU9Nfr9/L1cjT/66tEbjsg68ZXA4f3xLcNCFcyktBJwAYKXinuU9SOCq671hi4dladm3DN0JVhArYZwuoUIrNwoL4Tlm2Hijr6T7vA5sjl51ea16r4I0/XUYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m0CBwsGg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gjowKdXe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m0CBwsGg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gjowKdXe"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63H8HZJG1872660
	for <iommu@lists.linux.dev>; Fri, 17 Apr 2026 14:59:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3aD0Ou79Jkc4NKI3Dc4kGnC0vDC6y9my+JqL2kx139I=; b=m0CBwsGg4zlDj+KA
	0bnuITrXs7Yxh+34Q7IOoublPE7KogVS0xJrOktdwklUGo1rb/gUQBE3pRXFmqiR
	fa5FUoWK/x6vVi3kEffWrjWNthjwalKe/2+Qg7yZUZG41IPf2HIngbuvyztXQ/pO
	rQnLxu11sMThOArmwY+Phqwb0D3E4mCi7cKVdWuoqsiXA7V8JTJngJFQFLBB3ZJz
	APH4SOcwaEW3l6zboZpsLVtmdtuTcWWa9rjzzJXgNS92ISHMawO7pUjL9JRnocFS
	Yy15Vc7ibGMI4buZF0b9BJt8SIFV03hJ8avCsJ2n8ojroCKqTBll7JBRybeFdqix
	FxYPvA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dk2kncfvs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 17 Apr 2026 14:59:32 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b2d83e7461so12957815ad.3
        for <iommu@lists.linux.dev>; Fri, 17 Apr 2026 07:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776437972; x=1777042772; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3aD0Ou79Jkc4NKI3Dc4kGnC0vDC6y9my+JqL2kx139I=;
        b=gjowKdXe/G/BrGsi+VMA6qehKDy3TnHhq8YoPHmI2Z4Rph/nNzbq7/A/0o8t227N5F
         NM0E+TZIJkJ+lmADlNq5RptIQELamNLKjlVrr/QDg48vbLBjmsbEjvK8pyGpPQT6SvoI
         X8fd2PrOnrKVmzM5kU3GoRv2ZVfotRbjB2AJQEoKtmYOF8XRZj/5rSKd9xwvOv5C+SLH
         SmNtmbafFvuL/avIKGgZUHpywmJDIeGYFJhSds1ju36EmOvOmut8ePKaqkHfgD6Q8OKG
         4Pi6/H+3Mea2dfM+rf7bAJzA7vtRHxVVQUdVFiLyICLe5c1mCmmWN03fxtc3RMW5aDL9
         HPXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776437972; x=1777042772;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3aD0Ou79Jkc4NKI3Dc4kGnC0vDC6y9my+JqL2kx139I=;
        b=k2XlpLsHv/r+z24G6eDJdsn2KAUCp01aE5sh9IhiGpwYjlRVTMIDCmeR5mOU3KNCBR
         lRGNyNGl5yIpT0XaktDPx9AGZ0UFQtstvk5+O8iqO6GbwJ9rARkuoqpG5+Uf3CycnI7U
         Z0q8xvJyl+N2MhA6hFjIxdEtonn2poy6bt+vMvUQwuxNExEJb99QEGepWOiMeZyqH3WN
         EBggPmLJ1S+WrhP0rCtkTJ4SpWiZtLmIflm8ibynX4BSAe/ts4wjioLX5ux4yUjXJG7d
         LQKEtMI0oeNIVJHrtnfHjAwDLwpoeE+0OXXJdOaEZuGF44Eq76+Zu/suBCRjr9KJqyIR
         vSJA==
X-Forwarded-Encrypted: i=1; AFNElJ8DsGh0Va94QLKD86N3Ys+tq2usRMh9JdYJ9nuL2OPe8GYawgvrHLe3ybtqP+3eCUWxTvltjQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzjOyL71vWGiiKqZMY3EcBaaNujROsa3LMctd9CJTeGcKN3yjAI
	NsrYHbIcoHVBd8egCjlYhklmvyl0YhPwNsj9GGEdHQ0k35DGm2q7vsGSt8PlylhaJq2TouFWfZ3
	XrNVd4CE2HnNQ5HxSRHYbPSVVOCofH1p9BZzs9DoZK2KhEWxzoYU4YcnXmw==
X-Gm-Gg: AeBDiesMAEd0uGbrSAV5mZa7CWEcCQT8jp+oqF+b/WA8ihabWW0uUDFOr9ZJMvMKBGi
	c/eKC1rthef4js1kQOOrujjnacvTxrb7k0MPB0XB7i8dXuSGNehRFwvI+DbzrfNSMOoqef4rCB1
	QI9w467Ud5VZEUV7h9DiDutGDg/LNA1dZ2dShhvbVMPS3Wu90PxfM6sN2gfalX88Yyf1C4OjJD4
	lpnzVaDsYDLIZ9qn8OYQHzC14nensClNSMz4FhunmxOUljsLyWGbBF7xf2zjtdughklmBiYO1Sz
	73td9tffxo/0M0l3OBtDUkL6U0pWWFDMLi+sS/FdD6csxCfSy1V7T2CTXLK84K1+r0D4nmSS+jk
	i6Xd8fnITt+M/M1/SFYoWtW1a6d7dQz6jAaf1WleU5QljDaGpTK7B7plaPVLk7aFz
X-Received: by 2002:a17:902:f788:b0:2b2:d126:4e77 with SMTP id d9443c01a7336-2b5f9eaea76mr38560945ad.11.1776437971635;
        Fri, 17 Apr 2026 07:59:31 -0700 (PDT)
X-Received: by 2002:a17:902:f788:b0:2b2:d126:4e77 with SMTP id d9443c01a7336-2b5f9eaea76mr38560565ad.11.1776437971054;
        Fri, 17 Apr 2026 07:59:31 -0700 (PDT)
Received: from [10.206.105.200] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab40786sm25205125ad.79.2026.04.17.07.59.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2026 07:59:30 -0700 (PDT)
Message-ID: <26b71f52-3355-d4e9-f640-007123e3aba2@oss.qualcomm.com>
Date: Fri, 17 Apr 2026 20:29:21 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 02/11] media: iris: Add iris vpu bus support and register
 it with iommu_buses
Content-Language: en-US
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bryan O'Donoghue <bod@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev
References: <20260414-glymur-v1-0-7d3d1cf57b16@oss.qualcomm.com>
 <20260414-glymur-v1-2-7d3d1cf57b16@oss.qualcomm.com>
 <eqxeib5ci42ox4o7l45yjwgsjwjyhekojiigpxj6s5npjw5cwq@ggbtohqh3pip>
 <5dee6da0-9170-d9e0-5ff7-f8436331c6a9@oss.qualcomm.com>
In-Reply-To: <5dee6da0-9170-d9e0-5ff7-f8436331c6a9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 9XVpgJY0IiTLEji93qWuGqhERQPVf74W
X-Authority-Analysis: v=2.4 cv=XNoAjwhE c=1 sm=1 tr=0 ts=69e24ad4 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=mC123iS2TVYQaReKmh0A:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: 9XVpgJY0IiTLEji93qWuGqhERQPVf74W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDE1MCBTYWx0ZWRfX3+eCgDrN8QuJ
 x5mUtfeWAkljl+260DxbiucfCsNl0Vqjo6p4CrHQEHYT59tIkn3sd+TbE5Frje1ewWGwJTgXqsC
 e/XPhDT62y0LrnMZ1bUQ04BesUom6tmijW9Gl657bL9Ebcnd9V/IwrGJKc9VWVh18C1hJmDYWxL
 SpFbjyNPd5mBOgJx/ASioVxtNlYZ+JFhLUYxHwxtZOfYIteC0TMuZquHNBxowcJtXiLnebK5SrA
 gg7jSpK7iLL0Eaye3iVkgL6EmqLkyOdXBPykWyOQw0D2ULtvHXP18bUzdFVe1wxA6BpmjD6blo2
 AqX8EYBMYEKQGYBrhDcX1/jIhVJScx9UipIi/Bc3EMd0wGe5DZYXfpgqLle+3ZxJZnbaOgXP2Fy
 dvuzIoFpJNXCAm8Ll8CgVb3xe9zDBbRCDatDTdsUryNPFa4FVRNhssuw/KN4o7CJugrXdMTu+h6
 Ok1PNSz5IwM6Y0Aw2Jg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604170150

apologies for re-sending (earlier responses was rejected due to HTML format)

On 4/17/2026 8:22 PM, Vishnu Reddy wrote:
> On 4/14/2026 8:44 PM, Dmitry Baryshkov wrote:
>> On Tue, Apr 14, 2026 at 10:29:58AM +0530, Vishnu Reddy wrote:
>>> From: Vikash Garodia<vikash.garodia@oss.qualcomm.com>
>>>
>>> Add a dedicated iris VPU bus type and register it into the iommu_buses
>>> list. Iris devices require their own bus so that each device can run its
>>> own dma_configure() logic.
>> This really tells nothing, unless one has full context about the Iris
>> needs. Start by describing the issue (that the device needs to have
>> multiple devices talking to describe IOMMUs / VAs for several hardware
>> functions), then continue by describing what is needed from the IOMMU
>> subsys.
>
> This series handles firmware device which do not require multiple 
> devices part.
> given this device need for specific IOMMU configuration, I'll update 
> the description
> accordingly.
>
>>> Signed-off-by: Vikash Garodia<vikash.garodia@oss.qualcomm.com>
>>> Signed-off-by: Vishnu Reddy<busanna.reddy@oss.qualcomm.com>
>>> ---
>>>   drivers/iommu/iommu.c                           |  4 ++++
>>>   drivers/media/platform/qcom/iris/Makefile       |  4 ++++
>>>   drivers/media/platform/qcom/iris/iris_vpu_bus.c | 32 +++++++++++++++++++++++++
>>>   include/linux/iris_vpu_bus.h                    | 13 ++++++++++
>> How are you supposed to merge this? Through IOMMU tree? Through venus
>> tree? Can we add one single bus to the IOMMU code and use it for Iris,
>> Venus, FastRPC, host1x and all other device drivers which require
>> per-device DMA configuration?
>
> Separating out the bus definition and the Iris driver handling would 
> provide a
> cleaner merge path.
>
>> Your colleagues from the FastRPC team posted a very similar code few
>> weeks ago and got exactly the same feedback. Is there a reason why your
>> teams don't sync on the IOMMU parts at all?
>
> I would admit that I missed to review that, thank you for bringing 
> that discussion.
> FastRPC patches generalizes the handling for host1x, FastRPC and the 
> same can be
> extended for Iris. I have left few comments there.
>
>>>   4 files changed, 53 insertions(+)
>>>
>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>> index 61c12ba78206..d8ed6ef70ecd 100644
>>> --- a/drivers/iommu/iommu.c
>>> +++ b/drivers/iommu/iommu.c
>>> @@ -13,6 +13,7 @@
>>>   #include <linux/bug.h>
>>>   #include <linux/types.h>
>>>   #include <linux/init.h>
>>> +#include <linux/iris_vpu_bus.h>
>>>   #include <linux/export.h>
>>>   #include <linux/slab.h>
>>>   #include <linux/errno.h>
>>> @@ -179,6 +180,9 @@ static const struct bus_type * const iommu_buses[] = {
>>>   #ifdef CONFIG_CDX_BUS
>>>   	&cdx_bus_type,
>>>   #endif
>>> +#if IS_ENABLED(CONFIG_VIDEO_QCOM_IRIS)
>>> +	&iris_vpu_bus_type,
>>> +#endif
>>>   };
>>>   
>>>   /*
>>> diff --git a/drivers/media/platform/qcom/iris/Makefile b/drivers/media/platform/qcom/iris/Makefile
>>> index 2abbd3aeb4af..6f4052b98491 100644
>>> --- a/drivers/media/platform/qcom/iris/Makefile
>>> +++ b/drivers/media/platform/qcom/iris/Makefile
>>> @@ -31,3 +31,7 @@ qcom-iris-objs += iris_platform_gen1.o
>>>   endif
>>>   
>>>   obj-$(CONFIG_VIDEO_QCOM_IRIS) += qcom-iris.o
>>> +
>>> +ifdef CONFIG_VIDEO_QCOM_IRIS
>>> +obj-y += iris_vpu_bus.o
>>> +endif
>>> diff --git a/drivers/media/platform/qcom/iris/iris_vpu_bus.c b/drivers/media/platform/qcom/iris/iris_vpu_bus.c
>>> new file mode 100644
>>> index 000000000000..b51bb4b82b0e
>>> --- /dev/null
>>> +++ b/drivers/media/platform/qcom/iris/iris_vpu_bus.c
>>> @@ -0,0 +1,32 @@
>>> +// SPDX-License-Identifier: GPL-2.0-only
>>> +/*
>>> + * Copyright (c) Qualcomm Innovation Center, Inc. All rights reserved.
>>> + */
>>> +
>>> +#include <linux/device.h>
>>> +#include <linux/of_device.h>
>>> +
>>> +#include "iris_platform_common.h"
>>> +
>>> +static int iris_vpu_bus_dma_configure(struct device *dev)
>>> +{
>>> +	const u32 *f_id = dev_get_drvdata(dev);
>>> +
>>> +	if (!f_id)
>>> +		return -ENODEV;
>>> +
>>> +	return of_dma_configure_id(dev, dev->parent->of_node, true, f_id);
>> I think it was discussed that this is not enough. Some of devices need
>> multiple function IDs.
>
> In this glymur series we are following the legacy way of handling 
> IOMMUs and does not
> require multi map.
>
> Thanks,
> Vishnu Reddy.
>
>>> +}
>>> +
>>> +const struct bus_type iris_vpu_bus_type = {
>>> +	.name = "iris-vpu-bus",
>>> +	.dma_configure = iris_vpu_bus_dma_configure,
>>> +};
>>> +EXPORT_SYMBOL_GPL(iris_vpu_bus_type);
>>> +
>>> +static int __init iris_vpu_bus_init(void)
>>> +{
>>> +	return bus_register(&iris_vpu_bus_type);
>>> +}
>>> +
>>> +postcore_initcall(iris_vpu_bus_init);
>>> diff --git a/include/linux/iris_vpu_bus.h b/include/linux/iris_vpu_bus.h
>>> new file mode 100644
>>> index 000000000000..5704b226f7d6
>>> --- /dev/null
>>> +++ b/include/linux/iris_vpu_bus.h
>>> @@ -0,0 +1,13 @@
>>> +/* SPDX-License-Identifier: GPL-2.0-only */
>>> +/*
>>> + * Copyright (c) Qualcomm Innovation Center, Inc. All rights reserved.
>>> + */
>>> +
>>> +#ifndef __IRIS_VPU_BUS_H__
>>> +#define __IRIS_VPU_BUS_H__
>>> +
>>> +#if IS_ENABLED(CONFIG_VIDEO_QCOM_IRIS)
>>> +extern const struct bus_type iris_vpu_bus_type;
>>> +#endif
>>> +
>>> +#endif /* __IRIS_VPU_BUS_H__ */
>>>
>>> -- 
>>> 2.34.1
>>>
