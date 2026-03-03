Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA6F36B055
	for <iommu@lists.linux.dev>; Tue,  3 Mar 2026 18:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772562430; cv=none; b=OaUt90I+SpcRigypjudCy1XmWz2xdh1TkgePoz+AX7NWKE5VdYFNpcGEJWv03cBu1ktQDbX7s5jaq+tWvV13A1l5HS8VlRmDpkW/8q/A/joruC2HUjTu0McIGm9SfA4QIFdUy3OKlTpfC0HG71zgNkFSp5SVCuxiFuwppDS1isg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772562430; c=relaxed/simple;
	bh=c2NFnJIc71DDZiAySYYRCxrOWh1tu9lCMtz9n2Hu7w8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KbznUGTZJ4mHEDRbclIdTFY7v9R+UlOeFtwPMoAjYqY1RfG9UFY5nlYMwy/KQmyjet9MGrZgjO+bE3sR0ZIQMutLMC1DP3Fi2ilj5uLP1wxiNOK4oXde3gN+FV5JSyN9GjAj0bPEQn5ENkUrClf4me0dMUfiL8ohzn2s4HzxT18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LHOGoSDP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KCgMrUbV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LHOGoSDP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KCgMrUbV"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 623H1HJd728551
	for <iommu@lists.linux.dev>; Tue, 3 Mar 2026 18:27:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jYGxjAWQoxFG5EFf4xvdURSIz0MaHyEsN6qzt6ChCaM=; b=LHOGoSDPyCOJGLwz
	ODkWI8xjGje3ur1f5gPBuGxM7D3wMrsgvo2naVINiDA3CNCdLbE8r5qv+gZ5Eig4
	m1vzvXtMoUhmMnQgiMRSpukfuU4CuTYf1bF4TU+SF8Nm1fplrkrKCiq9eFOInbf2
	kKAk4BweiP8bp7EyEF921mqgwXj1k8z+CJsHlRKW2poXlOTlsEggfEzbEOrD/0O8
	xdXmCQUNkCMioiPzyuY5Q39+dBDRnSPQRzltMmUmi3f+ySTAhXmaV9LuvI5bgiON
	u5UDWqMMkHOjHZt7T1ILFsljkcrQieKRWYwndBk8VIofkGseCgs+noWC5GEVlE+H
	ZPHTOA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cns5ftnep-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 03 Mar 2026 18:27:08 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c629a3276e9so23044376a12.2
        for <iommu@lists.linux.dev>; Tue, 03 Mar 2026 10:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772562425; x=1773167225; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jYGxjAWQoxFG5EFf4xvdURSIz0MaHyEsN6qzt6ChCaM=;
        b=KCgMrUbV5sxv679py07Ut0Vm8sfxBqRveYhKVPO/OK8ClmTNCWb0OUMh+3trmo8Rhq
         kBMgkiczVlTtXGf9CllqIaO6EzT55V24Kq7uY0KMdL5vBRfKG5d5rb4UyPOpMttR+7Gx
         KFRgQB3srueiiPEvK4uJxPae9AQ4rWy4nSdLBvvEL1yFH4XBKqG2tu5RIejeDNOtkXWo
         GGppRiKHsZpELlD2wDqtiJh0gJ67hMVZRxiRACjzG/aBkdSROYqph54ZuFGD7w9HVFxg
         Yai64037oX594IHX1iZCQHd8GTFSZaf/izRr5xQZHuurjnZTE7CPeW1PynJRt9ey2e1R
         9+6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772562425; x=1773167225;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jYGxjAWQoxFG5EFf4xvdURSIz0MaHyEsN6qzt6ChCaM=;
        b=elzhOYGusk8a9+n+Si4gq05EOpFtabomkxVxhjXKl+F8shc/Ruv1OJX7vGcs0wfJwY
         D5VPgW40N09lazIIFt2hzFFLmv68LTkC9weuaNvrmR21LGiFMLZ4c1LAXVcJLJT+OuGH
         tX0tDndov3HEk97W2MoOoNdMDe2REqU2FX15Siy+SGSFnw25ExmdNnV0dX+/DyBM/4wu
         /iTqypH3B2R2HfR1IgdAHrmN4Xv7udkevYD+67CPac606MJkbxSn4T2q/XY9lrjhr1oX
         NNkxNsyW4HCW9zdST+UO9cgPCVxI1BZjgJNISmtHf3OmzM5hsYSNl2PDG+5m4XSRR5wC
         pvgg==
X-Forwarded-Encrypted: i=1; AJvYcCXWGw0Z5eNepaUmlnLEyEyaKM8y3QM7puq2v/n3Ls8EMtff2gzu/CEOcZMWzYta/e32AZBxLw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxoGmaOo8EPjShED74cmw2PhXLBd94N4F6jZAz1CrdDmOZmDdh8
	U+zJV/7ht7DP/1XZ/i5dRdYG8HBsL+QgbsXjVF3TEtKdYD/7w7mq2w3FAO+eMm5zZlY+fYer+RE
	8zR9vo4bUVHKSwC5OPV97UY5219P2ELpLacumUoWgEnR2NCE5K1gxIT6ZCg==
X-Gm-Gg: ATEYQzwrWQK6Tgucss3CnUXx4JkOPEgobAnD2AuhoFljDl71kCgpGZckqdh3VoajQgC
	+x6qQmh+fD0VvssmYmJ9kF1MrbKZ9wuVvNhRzZcNwMTsMoZhZBu2rk6sy6HvAwWT26Bt2QeAKU9
	7puwacb/4nBow6kBGGfUm7C8bEwcrelY8+2h9PnN6Q6C1nF1hJSpMbfUo0vv1FrXxY5PCnL58ce
	lx7u0bBZZ+ATxqj9oMPR7QNSRMhUWmrZMvJWel7gk7EPlvkWDiN5AVWmv1Nk6kNbtDLROGjzcXT
	t1oGAM//BuFxY8EcHHSvhKcoNkf4Ooqr1Dq4zwUYxf2qvQObRRUYvxMNI8lm7RHpHuBDcmTvEZn
	wslNVlwPUIOSSOGfUW4SAmF+hwSH44JwX6lOhls9q6IfYQEVELeGkglg=
X-Received: by 2002:a05:6a00:3a2a:b0:824:a81e:97b5 with SMTP id d2e1a72fcca58-8274d9f452emr17084695b3a.38.1772562424467;
        Tue, 03 Mar 2026 10:27:04 -0800 (PST)
X-Received: by 2002:a05:6a00:3a2a:b0:824:a81e:97b5 with SMTP id d2e1a72fcca58-8274d9f452emr17084650b3a.38.1772562423945;
        Tue, 03 Mar 2026 10:27:03 -0800 (PST)
Received: from [192.168.0.172] ([49.205.248.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739ff1ca9sm15764781b3a.36.2026.03.03.10.26.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2026 10:27:03 -0800 (PST)
Message-ID: <6dd03335-5fbe-4e01-9929-fcea8e5c0128@oss.qualcomm.com>
Date: Tue, 3 Mar 2026 23:56:55 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] media: iris: add iris vpu bus support and register
 it with iommu_buses
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, Bryan O'Donoghue <bryan.odonoghue@linaro.org>
References: <20260227-kaanapali-iris-v2-0-850043ac3933@oss.qualcomm.com>
 <20260227-kaanapali-iris-v2-3-850043ac3933@oss.qualcomm.com>
 <20257f68-04cf-40fa-9f0b-bd798e62b7eb@kernel.org>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <20257f68-04cf-40fa-9f0b-bd798e62b7eb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Pv2ergM3 c=1 sm=1 tr=0 ts=69a727fc cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=KPiuay1jFzAquJblYynD6w==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=lkRiF8b6XqOJfXNWt28A:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: c3XHSPCPZLuSGf0adghxiYJjfwIhrDZz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDE0OSBTYWx0ZWRfX7grnDt3FcJZn
 Y3B2Q0fr+epCfWoI2gBBDS9XdzTwrt23t0I5L+6eQtpuylRqlC/4OQkoVyTmi5TUo7nSb/kn1su
 HaT+Ok4vKQI6t9XIweT21dsHWwxv4pGtNIVIJJZ7uOsGi66mhSbtO+IBjGHRQhMGiXyAkRqEtLk
 zXwBddLOku+waOLtjl/2kraHH9eAwo1x+lg8p7NXB9VuYy1EVrCGFZCdOy7qor/A8jhmku9AhIQ
 50KHfLZyGZAZC5LdGG4YOiNOMV9RA+Ckr62IVl5NsQZphf/d3DUolpmMoNSolNHGTw8wAhfVw0j
 3wc/OlsZe1c5DrWun6pI7rCj4Z/OakIGY0OO0OO7BUyaaNNn8ZRMTWMlwMUz5g9uLI3II+0gMLA
 zH6eo6DN77Bz4mmmzHNVv0bbP8kUsylRn+xOoQJU5cPeUa8ZA3ykqWaQgYbnvpNWGQ+yBnamX6J
 R6joyNYo32VV+LCmntA==
X-Proofpoint-GUID: c3XHSPCPZLuSGf0adghxiYJjfwIhrDZz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-03_02,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 malwarescore=0 spamscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603030149



On 2/27/2026 9:19 PM, Krzysztof Kozlowski wrote:
> On 27/02/2026 15:11, Vikash Garodia wrote:
>> Add iris vpu bus support and hooks the new bus into the iommu_buses
>> list. Iris devices need their own bus so that each iris device can run
>> its own dma_configure() logic.
>>
>> Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
>> ---
>>   drivers/iommu/iommu.c                           |  4 ++++
>>   drivers/media/platform/qcom/iris/Makefile       |  4 ++++
>>   drivers/media/platform/qcom/iris/iris_vpu_bus.c | 32 +++++++++++++++++++++++++
>>   include/linux/iris_vpu_bus.h                    | 13 ++++++++++
>>   4 files changed, 53 insertions(+)
>>
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 35db5178095404fec87cd0f18e44ea97cf354e78..fd5fb7c10da22ab548d359ca1f44504acc3d646c 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -13,6 +13,7 @@
>>   #include <linux/bug.h>
>>   #include <linux/types.h>
>>   #include <linux/init.h>
>> +#include <linux/iris_vpu_bus.h>
>>   #include <linux/export.h>
>>   #include <linux/slab.h>
>>   #include <linux/errno.h>
>> @@ -178,6 +179,9 @@ static const struct bus_type * const iommu_buses[] = {
>>   #ifdef CONFIG_CDX_BUS
>>   	&cdx_bus_type,
>>   #endif
>> +#if IS_ENABLED(CONFIG_VIDEO_QCOM_IRIS)
>> +	&iris_vpu_bus_type,
>> +#endif
>>   };
>>   
>>   /*
>> diff --git a/drivers/media/platform/qcom/iris/Makefile b/drivers/media/platform/qcom/iris/Makefile
>> index 2abbd3aeb4af07e52bf372a4b2f352463529c92c..6f4052b98491aeddc299669334d4c93e9a3420e4 100644
>> --- a/drivers/media/platform/qcom/iris/Makefile
>> +++ b/drivers/media/platform/qcom/iris/Makefile
>> @@ -31,3 +31,7 @@ qcom-iris-objs += iris_platform_gen1.o
>>   endif
>>   
>>   obj-$(CONFIG_VIDEO_QCOM_IRIS) += qcom-iris.o
>> +
>> +ifdef CONFIG_VIDEO_QCOM_IRIS
>> +obj-y += iris_vpu_bus.o
>> +endif
>> diff --git a/drivers/media/platform/qcom/iris/iris_vpu_bus.c b/drivers/media/platform/qcom/iris/iris_vpu_bus.c
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..34ce78d9b0ff1feda15ba4f060a56d02749a0858
>> --- /dev/null
>> +++ b/drivers/media/platform/qcom/iris/iris_vpu_bus.c
>> @@ -0,0 +1,32 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2026 Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +#include <linux/device.h>
>> +#include <linux/of_device.h>
>> +
>> +#include "iris_platform_common.h"
>> +
>> +static int iris_vpu_bus_dma_configure(struct device *dev)
>> +{
>> +	struct iris_context_bank *cb = dev_get_drvdata(dev);
>> +
>> +	if (!cb)
>> +		return -ENODEV;
>> +
>> +	return of_dma_configure_id(dev, dev->parent->of_node, true, &cb->f_id);
> 
> 
> Apply this patch and build it. Does it build?

it was incorrectly organized, since the struct was defined in subsequent 
patch. Will fix this in next revision.

> 
> Best regards,
> Krzysztof

Regards,
Vikash
