Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1A0359A75
	for <iommu@lists.linux.dev>; Mon, 20 Apr 2026 14:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776693761; cv=none; b=rOIwbrb9QB+lCWL5gd1y40VDrYvp2zyGFHNGmBMRKqa1I0eHNtZLumLqGqbGlclVfgXC8ZQnCCQba4okCV2eIuOjEg9txoMRqbobOx29z8CCRZlwuLO4ZPuIrCtzHNOleQyKOjmGsq25pyLxWhAFY/yIfhxl7jpL4y19MSo8Gf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776693761; c=relaxed/simple;
	bh=lGmqSKRT6CM/TxRcqxDkVJvKI4sTpx9Qlqby2pYKzIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sz++ODLUkTjPlrnQAaruOU4F/s0/AAW3DSAZ7kwmKcCQ4KCMU8V/vP9oQxDCDciOC4TJ6OtQ7hdxzk55y57qpuscRZ6L7ExmbbcuDwInvz9E4Cyv8mWfN5yJ5oof+DO+ebDlaTPlWor82Y/Zwy0IP/lkUQj7DeY9YPWooHSO/0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Sd9Al1z2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fbhHCVum; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Sd9Al1z2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fbhHCVum"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63K9JHEZ785847
	for <iommu@lists.linux.dev>; Mon, 20 Apr 2026 14:02:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kzOPLkbup/xZQgzFN0xvKjJCRL775HS/q+EXgkWm92w=; b=Sd9Al1z2o0RljW9X
	gdXXQHjsnb3eduC3tOnsYEAI4Eae4XCFSS8Q4+hIr1FGuhKx1xiQavvugLpFHI2G
	hE3jdCyu6dCDDJckL1tImFbnrR37mQf/SWuvz+HeKWwJMelbZnoj8x7pJ9gJw7Bs
	g0lBCic/2MPo8XetUritDWxONQbTP5OB5/EJyX9AVILU2czuEM3A72KoxCRa2H94
	DzH8Smi8PWyd7t3QguT16pNE2lyd+wfPqBwviZnsglcUKJxbvsUU4BUeAiebJp2Y
	HfPuNjF0R+rlOK4MkBDu6WH58SYe7MYWhEJfdZOTCpTVV/PvcJaRtzKz+6SiuPq8
	wOLeLg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnhdhgyjd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 20 Apr 2026 14:02:37 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-82f07078eaaso2407533b3a.0
        for <iommu@lists.linux.dev>; Mon, 20 Apr 2026 07:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776693756; x=1777298556; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kzOPLkbup/xZQgzFN0xvKjJCRL775HS/q+EXgkWm92w=;
        b=fbhHCVumuNx+wySrz7JfidoCBXcYcgHXGSd2G/jaIbgfhVG4bsHZSt2evG7Cs/6Uuz
         V4UxrVthr3VhDf6VnsoRvhryC4/f4+iBv14HcDoNRNMmQwS4C3B48tMBwuPFdJid0/u4
         ZxABp/ePUkovfPveglN+59j902Qzm67X6sevst8UrvEXO1y9V5HVLs/lRoexhzGYqIay
         zwqebrNOCYOpWKGeln456VS6oUYss31HDZrfeQdTVTkBUU33gRUcO1feVOUGJ2i10I0T
         yFRTqUiz7GkSUbzH7Fd19V6oOoSwqkgO1uRlEgdo1CZoiV9pC5OUHR/l5sclX/LST0gq
         UwLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776693756; x=1777298556;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kzOPLkbup/xZQgzFN0xvKjJCRL775HS/q+EXgkWm92w=;
        b=o1PQtHDssZrT6Bm2qk9uF4+NkUwr1qwNiNPBKcg0Vu/eKS5zZVkg7rxrh/pY51LwE6
         8Z5rbjkG4GQ38rPk8jnih8Wsu6UC3GssuzOiLZAcARCrl6fYOnbNJj3HieCWMASQ2wih
         TEHeCkOLApAq/6IRotQqUujNJZfaM6I7Q76eb2F0rs1Tv1K1/6q57UHUI6kpJVqC867V
         bmAkJSRnpCFhMS8D31sHPXDUPM3zVT2cxYJjqerfUtfazDqmuaV/6v+mGNOkyyAqEqsB
         8iTJqSWbCiqrjx2310qU16yavYmpU9v1lVBMxfnEzGAJsKtXf4uf3D+bFDLUwvxZzU/A
         BVhQ==
X-Forwarded-Encrypted: i=1; AFNElJ+gzC6c4AdlyB4r9KVz+DJ4VsP93Empausox381N7PF+Oiq2nQ+deUH2DqhG7yO1cXuzycnxA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzP2NPgCn+f2pGXIfG7i/asQFzLaYRnN0me5sKKBiMjhXj8a6Ll
	RegzCCN/A8DQPGSLKiiRSSGfa6s0ZrigR3B4DwgV/cqGepV9HOi9OHEyEigfM8SMhT5C5xA9fXB
	EC3X7VOQuZTmW7tWzTjpf9dkNlQ6Bjo9EIPdKVyvcAjqfAflqcpXE9yj3dQ==
X-Gm-Gg: AeBDiestIkD6GGUh5RfEYYUmyxuRcv7WHT1PTEYqXKSJ/15+cLNJgaLlD1eB6oTdpxE
	qmV6FJ8unZpr1adRqKVW0JbAN9LmL/YzChUuFvStNl7jASUO/F2DJKxcefN93kkjTUvLnx2uBmX
	sVI0HlEnMkp15Xowt8NEdmDKa9DQ2ETWNPn1q2Tkfku8tpwKUzI5ebx8DYU98x0jU0BIQCTYifu
	La08BPFfep5kIOohvLGXwWkMPNs+ykYlCDoR2KTMjt78R8MDxX7GsCCM2iJpUP9P8zeXYX/cjtW
	EtXFV1Xg4LMELXofaXi0LgyGwyiQhKAElasLyS3j1km5vaC2AiXjunMSqHpc8AKo7KB5cibL31C
	WmTkeQbZ7b9uCMPJ3+xcXj0YGRdUERD+af3rDBbitg99B+o+7VK+WAWP0uJ97o2di
X-Received: by 2002:a05:6a00:391c:b0:781:2291:1045 with SMTP id d2e1a72fcca58-82f8c7d1002mr13029209b3a.8.1776693756106;
        Mon, 20 Apr 2026 07:02:36 -0700 (PDT)
X-Received: by 2002:a05:6a00:391c:b0:781:2291:1045 with SMTP id d2e1a72fcca58-82f8c7d1002mr13028935b3a.8.1776693753924;
        Mon, 20 Apr 2026 07:02:33 -0700 (PDT)
Received: from [10.206.105.200] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ec037e1sm13078240b3a.54.2026.04.20.07.02.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 07:02:32 -0700 (PDT)
Message-ID: <1f73fad2-1d53-dd35-2668-750eaf3fe00e@oss.qualcomm.com>
Date: Mon, 20 Apr 2026 19:32:23 +0530
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
 <26b71f52-3355-d4e9-f640-007123e3aba2@oss.qualcomm.com>
 <7bnl34zyexz4z54fmz6ymax7izfey6nyp7lenhvfp3hkfmhdia@lssovgsnas72>
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
In-Reply-To: <7bnl34zyexz4z54fmz6ymax7izfey6nyp7lenhvfp3hkfmhdia@lssovgsnas72>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: eeJlCsTUhrt22-age9a_t2D-pWGskMcr
X-Authority-Analysis: v=2.4 cv=IMgyzAvG c=1 sm=1 tr=0 ts=69e631fd cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=yYSL5V0MIfFtLobc5GMA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: eeJlCsTUhrt22-age9a_t2D-pWGskMcr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDEzNyBTYWx0ZWRfX1nUNua16Pcto
 lRm+6dcFCNRzZN5w6OdVG6uqY4HrZCwBGoHFHbn3HMGQRB/UA5/ki96iiijspe7hxBXjp9G2sPD
 8j16ZbvtkMDO1/Y83Omlnjk0Fd5LpZjB6+6AtaTVRBvMAoL+mpxsalm+l4m1PZ/mZHZoc4XkSPQ
 lHfYwJadHBxBHq09lhf03/YjosfJfbDj2g0Bsns0/P7IVlalpwCMj8D5kij3U12c+enImLDTdL6
 5Re5y5N+fsQBGnm1+TjqIxtMD2XLM3zocHlCeNEf7T6REqyXcObZNptYyGHd3oie6y5Ci5FGooq
 DV+o66EpxMLvZh2sgQj1iNWULY7OadqtCeiYQcezep/fseYf/iqvH+nfDlrflfhwznf7d/EAySR
 XMreVCUArxRiVTX6qnLTGhdNjdlJqg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_03,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2604070000 definitions=main-2604200137


On 4/17/2026 11:49 PM, Dmitry Baryshkov wrote:
> On Fri, Apr 17, 2026 at 08:29:21PM +0530, Vishnu Reddy wrote:
>> apologies for re-sending (earlier responses was rejected due to HTML format)
> Ugh.
>
>> On 4/17/2026 8:22 PM, Vishnu Reddy wrote:
>>> On 4/14/2026 8:44 PM, Dmitry Baryshkov wrote:
>>>> On Tue, Apr 14, 2026 at 10:29:58AM +0530, Vishnu Reddy wrote:
>>>>> From: Vikash Garodia<vikash.garodia@oss.qualcomm.com>
>>>>>
>>>>> Add a dedicated iris VPU bus type and register it into the iommu_buses
>>>>> list. Iris devices require their own bus so that each device can run its
>>>>> own dma_configure() logic.
>>>> This really tells nothing, unless one has full context about the Iris
>>>> needs. Start by describing the issue (that the device needs to have
>>>> multiple devices talking to describe IOMMUs / VAs for several hardware
>>>> functions), then continue by describing what is needed from the IOMMU
>>>> subsys.
>>> This series handles firmware device which do not require multiple
>>> devices part.
>>> given this device need for specific IOMMU configuration, I'll update the
>>> description
>>> accordingly.
>>>
>>>>> Signed-off-by: Vikash Garodia<vikash.garodia@oss.qualcomm.com>
>>>>> Signed-off-by: Vishnu Reddy<busanna.reddy@oss.qualcomm.com>
>>>>> ---
>>>>>   drivers/iommu/iommu.c                           |  4 ++++
>>>>>   drivers/media/platform/qcom/iris/Makefile       |  4 ++++
>>>>>   drivers/media/platform/qcom/iris/iris_vpu_bus.c | 32 +++++++++++++++++++++++++
>>>>>   include/linux/iris_vpu_bus.h                    | 13 ++++++++++
>>>> How are you supposed to merge this? Through IOMMU tree? Through venus
>>>> tree? Can we add one single bus to the IOMMU code and use it for Iris,
>>>> Venus, FastRPC, host1x and all other device drivers which require
>>>> per-device DMA configuration?
>>> Separating out the bus definition and the Iris driver handling would
>>> provide a
>>> cleaner merge path.
> Then why wasn't it done from the ground up?
>
>>>> Your colleagues from the FastRPC team posted a very similar code few
>>>> weeks ago and got exactly the same feedback. Is there a reason why your
>>>> teams don't sync on the IOMMU parts at all?
>>> I would admit that I missed to review that, thank you for bringing that
>>> discussion.
>>> FastRPC patches generalizes the handling for host1x, FastRPC and the
>>> same can be
>>> extended for Iris. I have left few comments there.
>>>
>>>>>   4 files changed, 53 insertions(+)
>>>>>
>>>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>>>> index 61c12ba78206..d8ed6ef70ecd 100644
>>>>> --- a/drivers/iommu/iommu.c
>>>>> +++ b/drivers/iommu/iommu.c
>>>>> @@ -13,6 +13,7 @@
>>>>>   #include <linux/bug.h>
>>>>>   #include <linux/types.h>
>>>>>   #include <linux/init.h>
>>>>> +#include <linux/iris_vpu_bus.h>
>>>>>   #include <linux/export.h>
>>>>>   #include <linux/slab.h>
>>>>>   #include <linux/errno.h>
>>>>> @@ -179,6 +180,9 @@ static const struct bus_type * const iommu_buses[] = {
>>>>>   #ifdef CONFIG_CDX_BUS
>>>>>   	&cdx_bus_type,
>>>>>   #endif
>>>>> +#if IS_ENABLED(CONFIG_VIDEO_QCOM_IRIS)
>>>>> +	&iris_vpu_bus_type,
>>>>> +#endif
>>>>>   };
>>>>>   /*
>>>>> diff --git a/drivers/media/platform/qcom/iris/Makefile b/drivers/media/platform/qcom/iris/Makefile
>>>>> index 2abbd3aeb4af..6f4052b98491 100644
>>>>> --- a/drivers/media/platform/qcom/iris/Makefile
>>>>> +++ b/drivers/media/platform/qcom/iris/Makefile
>>>>> @@ -31,3 +31,7 @@ qcom-iris-objs += iris_platform_gen1.o
>>>>>   endif
>>>>>   obj-$(CONFIG_VIDEO_QCOM_IRIS) += qcom-iris.o
>>>>> +
>>>>> +ifdef CONFIG_VIDEO_QCOM_IRIS
>>>>> +obj-y += iris_vpu_bus.o
>>>>> +endif
>>>>> diff --git a/drivers/media/platform/qcom/iris/iris_vpu_bus.c b/drivers/media/platform/qcom/iris/iris_vpu_bus.c
>>>>> new file mode 100644
>>>>> index 000000000000..b51bb4b82b0e
>>>>> --- /dev/null
>>>>> +++ b/drivers/media/platform/qcom/iris/iris_vpu_bus.c
>>>>> @@ -0,0 +1,32 @@
>>>>> +// SPDX-License-Identifier: GPL-2.0-only
>>>>> +/*
>>>>> + * Copyright (c) Qualcomm Innovation Center, Inc. All rights reserved.
>>>>> + */
>>>>> +
>>>>> +#include <linux/device.h>
>>>>> +#include <linux/of_device.h>
>>>>> +
>>>>> +#include "iris_platform_common.h"
>>>>> +
>>>>> +static int iris_vpu_bus_dma_configure(struct device *dev)
>>>>> +{
>>>>> +	const u32 *f_id = dev_get_drvdata(dev);
>>>>> +
>>>>> +	if (!f_id)
>>>>> +		return -ENODEV;
>>>>> +
>>>>> +	return of_dma_configure_id(dev, dev->parent->of_node, true, f_id);
>>>> I think it was discussed that this is not enough. Some of devices need
>>>> multiple function IDs.
>>> In this glymur series we are following the legacy way of handling IOMMUs
>>> and does not
>>> require multi map.
> Why can't we land the version that has multiple entries? It's as if the
> teams are totally not in sync. The corresponding version is in works, it
> has been implemented, etc.
The main idea is to introduce firmware stream ID with iommu-map, while keeping the
other stream IDs described in legacy iommus way.
or, are you suggesting that, going forward, we should have VPU stream IDs described
_only_ with iommu-map for any new dts/bindings?

Thanks,
Vishnu Reddy.

