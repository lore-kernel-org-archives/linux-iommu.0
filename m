Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909B113DBA0
	for <iommu@lists.linux.dev>; Sat, 28 Mar 2026 11:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774697876; cv=none; b=eMeLYoeP/DkLlt9dfRq6PwpH+erflvsAca5q2Ekehc96Rr4h/ONL4W9o8D5N3B4qGJfPT31xm6LUPgcBH4BdkDozkc93DFzsg5QyYcQ7IYqgP/TxBErWeRG2THlojTMnx0TYTWEW0vynCKRaZiu8tnny+sNygeiCSVAFUrWvYow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774697876; c=relaxed/simple;
	bh=OjgkSIO2ad2NibMyUFh+sgUj3CG69zp0K+DcVr3S4Lk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mC4dIyo8EQmAmGnNOWbIfcwM0/cdFPnR3CNLRS/vXU4dX4/VLglDAk8knOtfiQSRmNFmRZUxG0bJXBBV/naa3yNdQvuY0+TrO2kr7SFQYjITkdNj7L0MD4tqmSC8L8lr7y8G27MzvZgs0vblHoy+SYmfW5zzUzFJSLTLCrXJeuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eDrGyPgh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZA8mqvzc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eDrGyPgh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZA8mqvzc"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62S3Ygcl348488
	for <iommu@lists.linux.dev>; Sat, 28 Mar 2026 11:37:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pFKLV1uuPMHuCXFEpJEzKwAbPMuwARFQ2NoKMHcpKbM=; b=eDrGyPghCbNIvNWD
	OqIVjLta3TwepWb8VuiM/5uj0WSxSyxci7QALthAEW6iO/k4n4YGOBbRJn+VssNM
	VjdHt7RdNlg4KGNVqFu8CKmrUfz56KQdiHFwOZk8YE55fiE8MGfjLrzCdwXgdTmS
	K+7gJbl07JuWoet3a9kmR5pUkHcmYsdRXBWlLy+JecaQtmJp3HocK++GLtOZPEe+
	s5OOVm1xMzMaC9yvbwUHMJlZC/hNnCodNFyYWKYL3aoVjMH+8QCDdmBDgoaWmmsE
	HoQLFjHPOXlZKhpBLtmAysjaipwv0yzSJEfomanTX1BzZ79LdzEXyqigR+hBoOho
	5ZoDcg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d67710pqb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sat, 28 Mar 2026 11:37:53 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b249541063so174015ad.3
        for <iommu@lists.linux.dev>; Sat, 28 Mar 2026 04:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774697873; x=1775302673; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pFKLV1uuPMHuCXFEpJEzKwAbPMuwARFQ2NoKMHcpKbM=;
        b=ZA8mqvzczqQSy3X9xUes9baUNM2TPI2N42C75SyN6QI/enyWjhMbIbHoQc4crKHQXS
         17RGpmu2wcqkR3ogpBd0et2hiH5KfEku4RdGymlBtXKb/fg9vne06Ex5w1XQ+3ARGMpW
         sTklbJxtV2EKROlXrhzDPyitiCQmaltDWwfNhxIGfYlFELblUozR0KAMnqRK7YQ86Pak
         uAXPwWTDoLXaoyc8ENdCKU2mfJQ++YMhRkEvgjE34GtiDLQahF/1CS/vINq025CaEUfz
         aDoY6StB5y7oAkJmpeZwXT/m27axyPRv/1SoIpsyInyk/YsRVLk1imU3VOWlUIHDG5ew
         g9Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774697873; x=1775302673;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pFKLV1uuPMHuCXFEpJEzKwAbPMuwARFQ2NoKMHcpKbM=;
        b=e+m9+R0JHkqS6aaLEGGjUSXh8wTq9h4VxZ294vKGW7v3BM7EypRpuCOwyISdMiO8VU
         PMJeb4okKrHzgiab2+/VkGjQ2TW3JSeG3UxFvRor9wkzoBn4mp0+Tszzx41+QbwFsys9
         nUv5GHCTsfBUkNReNZ7P0ERFI2PpsUMc1an84Yh6C1PXtleq3289EU1KSFgITHV0di8z
         dBQFDwbAuDVG0OzIj0XdbkGkK+PZs6e9JctcptSQCgdre8KqZDZnRjhkVHyrgpdAvsN8
         FDRA6KdViiE68bUURb9ZevOWeoYv5aseTiDNtrEH8YJcVhxtd9Pbm70Q89sYwt3lArQW
         CqDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUluiTbxgqTlIBIhorgMSpPj9RO6CoQT0Y/jwgo54yNfISilDnyoYpbU0fuvC18oDYdNuw4BA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxg0CMgF7qgf8tlzWffCF3WjoZhDtM/vfY8g/O+qpfTYvRAqeaS
	GR5Vc+kKhNiUBDdpote9AcdQdLSXPXE1b2JW/WHDF4/XGXepq+jx27WZ6X+pKl0fhiSOGr/xTnE
	cVA6OvkYdYJC//zJwICs+mm9RToq78XRjE1lb/vpWzsl+YyhkT5Gbbp5qYQ==
X-Gm-Gg: ATEYQzyUnOkTn3Qn0P9jiKVyZWfu4qi4bXtV8aFOuah/jSv5tvsMBNLcaLONX5rjOee
	Ym1BCJmprolbxaisTo+mE3dYSez6lqBFMSNp+gPBW/arxeQn+qXRHMZ0oEdLbEGvlTWRL/nl79U
	/erKbKgOSb1Y8rKw6R1d3GaLulZa344s3en1caS6Vk6g6JHoLLoQmGCpmZpNqwvN1l9f9rZCDoJ
	ObvVZcrgJQCHkAJNbpQWGjLGGxjRHg0Z7xbNkYZz7X5PZ7D+6TGWoSTt5w8sK6yYZeO6HT3Z5Wk
	G989iWGE/YtVvBNNymR/fzFTVzWiyVnp3dhM7qZWMBarrP+TyTPcGUbNypp8X1hNfXikSV4fEDn
	GFoD7oqnXrR2vgIoV1+UIOrxcM/lPCcsfWFpSr8RHkjVapjIgNpRBxHA=
X-Received: by 2002:a17:903:3d0f:b0:2b0:7e4d:f390 with SMTP id d9443c01a7336-2b0cdcf14d2mr63227175ad.41.1774697872975;
        Sat, 28 Mar 2026 04:37:52 -0700 (PDT)
X-Received: by 2002:a17:903:3d0f:b0:2b0:7e4d:f390 with SMTP id d9443c01a7336-2b0cdcf14d2mr63226925ad.41.1774697872472;
        Sat, 28 Mar 2026 04:37:52 -0700 (PDT)
Received: from [192.168.0.172] ([49.205.250.68])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2427b3bfdsm26195065ad.75.2026.03.28.04.37.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Mar 2026 04:37:51 -0700 (PDT)
Message-ID: <aa78d904-1c46-4fa4-b06f-f130aae145aa@oss.qualcomm.com>
Date: Sat, 28 Mar 2026 17:07:43 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] media: iris: add platform data for kaanapali
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
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
        Hans Verkuil <hverkuil+cisco@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, Bryan O'Donoghue <bryan.odonoghue@linaro.org>
References: <20260313-kaanapali-iris-v3-0-9c0d1a67af4b@oss.qualcomm.com>
 <20260313-kaanapali-iris-v3-7-9c0d1a67af4b@oss.qualcomm.com>
 <5t3bke2sjkxahn4pjhdpyznbrdmu67u7cfgdfwqgjcgo7cbg2e@4wr2jadk6b7i>
 <cb50d35f-840d-4732-bf86-4e96f69fef35@kernel.org>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <cb50d35f-840d-4732-bf86-4e96f69fef35@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: yN87e3bCPpjRklsqWdbRcQPQ3Hqq4XnL
X-Authority-Analysis: v=2.4 cv=efYwvrEH c=1 sm=1 tr=0 ts=69c7bd91 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=yLWmkx75ThOYqhw51wEqsw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=WznVFTgscVg43mOb2l8A:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: yN87e3bCPpjRklsqWdbRcQPQ3Hqq4XnL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI4MDA4NCBTYWx0ZWRfX1TaOcqiXV2u7
 QbVLYkYrMjwQzcN3n8XG541QU5dimbitOeV/HGfF8pjegIENaTxtpRfjHtE0p2jyKVTKySJw+fy
 bt8aAsI8HDTBb4fowRO4zUCOAU6IE6ZXBT+E5vLNRONqT8hOdxtbfMVMgsI5aRiT/kjryOm8mxZ
 74ZfIFDvGGy9yFBg7U2RZ9dtlwvIa6FbxYjs2W8NmKRL9PpYGCKI+W+BKoyo6/mwl2IUrtTVUZZ
 8fmDIni7GO13jHE0JJA8XULeM+ZpszS8CEgL+tAH1EbIKJDlZUuUbmQSyGhlrcJnEpLkQQxTb++
 j14HF8HACowqbl+qjk10Y0zdFmpioR6OWelwNCM87cvH7uN5+2JM2LSf7S4D8O3NiG38vsuRtcG
 SaxXOEKHeTYYCJ34mu/UehU8syHfdIkCB5T8F3eozwFHXUGDPkRRtxRqE2ZYthUhNMsdePO4wSe
 HF9NIxzSV1UB1CSibGw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-27_02,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 adultscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603280084


On 3/13/2026 9:25 PM, Krzysztof Kozlowski wrote:
> On 13/03/2026 16:46, Dmitry Baryshkov wrote:
>> On Fri, Mar 13, 2026 at 06:49:41PM +0530, Vikash Garodia wrote:
>>> Add support for the kaanapali platform by re-using the SM8550
>>> definitions and using the vpu4 ops.
>>> Move the configurations that differs in a per-SoC platform header, that
>>> will contain SoC specific data.
>>>
>>> Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>>> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>>> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
>>> ---
>>>   .../platform/qcom/iris/iris_platform_common.h      |  1 +
>>>   .../media/platform/qcom/iris/iris_platform_gen2.c  | 90 ++++++++++++++++++++++
>>>   .../platform/qcom/iris/iris_platform_kaanapali.h   | 83 ++++++++++++++++++++
>>>   drivers/media/platform/qcom/iris/iris_probe.c      |  4 +
>>>   4 files changed, 178 insertions(+)
>>>
>>
>>> diff --git a/drivers/media/platform/qcom/iris/iris_platform_kaanapali.h b/drivers/media/platform/qcom/iris/iris_platform_kaanapali.h
>>> new file mode 100644
>>> index 0000000000000000000000000000000000000000..bdca1e5bf673353862c1554fb0420f73b3f519cb
>>> --- /dev/null
>>> +++ b/drivers/media/platform/qcom/iris/iris_platform_kaanapali.h
>>> @@ -0,0 +1,83 @@
>>> +/* SPDX-License-Identifier: GPL-2.0-only */
>>> +/*
>>> + * Copyright (c) Qualcomm Innovation Center, Inc. All rights reserved.
>>> + */
>>> +
>>> +#ifndef __IRIS_PLATFORM_KAANAPALI_H__
>>> +#define __IRIS_PLATFORM_KAANAPALI_H__
>>> +
>>> +#include <dt-bindings/media/qcom,kaanapali-iris.h>
>>
>> So, you are including the bindings here, from the header, which gets
>> included from the C source file including headers for all the platforms.
>> What if Kaanapali+1 (or +3) defines different sets of regions?
> 
> Different problem - header file MUST NOT have data definitions.
> 
> That's basic of C, we don't write such code. First because it leads to
> multiplied, redundant data. Second, that's not C coding style.

Ack, will define in c and extern in header approach

> 
> This pattern in Qualcomm Iris is terrible and I could accept variations
> of existing data like below:
> 
>>
>>> +
>>> +#define VIDEO_REGION_VM0_SECURE_NP_ID		1
>>> +#define VIDEO_REGION_VM0_NONSECURE_NP_ID	5
>>> +
>>> +static const char *const kaanapali_clk_reset_table[] = {
>>> +	"bus0",
>>> +	"bus1",
>>> +	"core",
>>> +	"vcodec0_core",
>>> +};
>>> +
>>> +static const char *const kaanapali_pmdomain_table[] = {
>>> +	"venus",
>>> +	"vcodec0",
>>> +	"vpp0",
>>> +	"vpp1",
>>> +	"apv",
>>> +};
>>> +
>>> +static const struct platform_clk_data kaanapali_clk_table[] = {
>>> +	{ IRIS_AXI_CLK, "iface" },
>>> +	{ IRIS_CTRL_CLK, "core" },
>>> +	{ IRIS_HW_CLK, "vcodec0_core" },
>>> +	{ IRIS_AXI1_CLK, "iface1" },
>>> +	{ IRIS_CTRL_FREERUN_CLK, "core_freerun" },
>>> +	{ IRIS_HW_FREERUN_CLK, "vcodec0_core_freerun" },
>>> +	{ IRIS_BSE_HW_CLK, "vcodec_bse" },
>>> +	{ IRIS_VPP0_HW_CLK, "vcodec_vpp0" },
>>> +	{ IRIS_VPP1_HW_CLK, "vcodec_vpp1" },
>>> +	{ IRIS_APV_HW_CLK, "vcodec_apv" },
>>> +};
>>> +
>>> +static const char *const kaanapali_opp_clk_table[] = {
>>> +	"vcodec0_core",
>>> +	"vcodec_apv",
>>> +	"vcodec_bse",
>>> +	"core",
>>> +	NULL,
>>> +};
>>> +
>>> +static struct tz_cp_config tz_cp_config_kaanapali[] = {
> 
> But this is new thus NAK.
> 
> Don't grow this broken pattern. There is no single reason data
> definition should be placed in a header. No single one.
> 
> Best regards,
> Krzysztof

