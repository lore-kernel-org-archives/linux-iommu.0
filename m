Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2683264C2
	for <iommu@lists.linux.dev>; Wed,  6 May 2026 15:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778080552; cv=none; b=NkW1FFSmPjUnWL0IUuwB2mHbVdXMz9qR3FnA3RzkoHxAVP26NL4Fpwn6KaOGKHSOX2QeJXQroCucvSzk1JZoKK+lUsmLHMqRO6bepPPImwp59NlNgYlLqpSvV5WHVk2TdbNlnzhE8eFXcTeFyu4cTBBkIWz/gRX+Cmrx13g5RC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778080552; c=relaxed/simple;
	bh=RhXRCgMNScIf77wnkS151xUmWJL1ppbZupG/e8th0Wo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z2943Nx3cz26Q088Vq1PFGCHSBbgQlZtxYn5vo7xevt2/QzpBIJ3mMYxxBj4k1oYA4EBxzxVDHhUK32vW3Ez/N10Bb/ubvztI3waYEIINIrNx1c4EkcpfEh/TIj88us7NWOAOpGGpZTJYmhW1Ee4Je2rTqjm7P0cIwcZ3s0v3DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n/VwO3gu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WTg/Brhc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n/VwO3gu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WTg/Brhc"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 646D4UDI1514900
	for <iommu@lists.linux.dev>; Wed, 6 May 2026 15:15:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	l/4qDhc3xqA5oi78owxsgPypqoMvOhzYxv2FjuGz/0A=; b=n/VwO3guoR+gbKM1
	vb0fnDr6mJk5eh7Iu4Pb2rehc1/6B0SVyZwPzmokdVjmrT8XUkkGo1LD2LUHZ04Q
	tG22UnrMqoEzNOZApoH3mapGqv5Hwee9CyqQpytgakTfwbG0E+whoET0gqlMKs3s
	mO4SRSIPPrKdkw7EbeZRx3Ux744J6zKBgWNIqNq1/QTcrvDfBQ8+NCukHkeiGaIT
	kTCgHg/Gxc0+jtAASUiSJaDqXNiCYxQTu1P8B6VDmSyD/TRPbwHzl5OjVx1oSLlr
	dLOwLeqlm3Wa3ldEbRcqqdmHu5amea0mG1rREAEc3q+ePIZY7VH0yw+/+5839/Md
	Oly30Q==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e00v1t0rf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 06 May 2026 15:15:48 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-35845fcf0f5so963277a91.0
        for <iommu@lists.linux.dev>; Wed, 06 May 2026 08:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778080548; x=1778685348; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l/4qDhc3xqA5oi78owxsgPypqoMvOhzYxv2FjuGz/0A=;
        b=WTg/BrhcPPNoOPFi6Gcdlu79PbfXkNuDNZf7CV5mqVz0RKTtztr0K6W6p3gBggBnBd
         cvL5GfjJ+m3OffZ06pRpB4cFPOkzQLuozuZfMUyYPh1A6YALJQ3cP9SBENg58tvEh8sZ
         r08ySlVWrEWAI+zdjEuvUd6GnrMTCylvnvPdtJf6MKFFdTuOiiG/D1Ox6GL/IdNzWEhA
         e0DEKf0Wi5kWaJQAZfrJMatccZElQfToEF9LcGb9ly8PiD4U1o8MLS37BtbLFTkgERnC
         PXfUjU7xeHeXreFKEgLgpG1rZ886SUQB7ThjBUfg4YSwrvgYlyIsi4po0ORtLXXe1baN
         5dMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778080548; x=1778685348;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l/4qDhc3xqA5oi78owxsgPypqoMvOhzYxv2FjuGz/0A=;
        b=U7MrhvTh6dp4AWGCRsvHkhRVxvw49oLKaXv5GV5L1cA/NcKAXxxyAgJja7wAUQ73NN
         6dAK2w6dIcLQ8MbNi1C9mnv8yQighVFxA+2dIdPX+YIcyiIbGW0qtcgtp1BUx61bsiXT
         +JyMWXsfTRN6MPqMRb2/wE1UztlpB+9ZqO89uLqPt8dt4apLFXednWLqtsiWpS9ghgFk
         mdvIEhfWkWXpo/1plf/OVyhkSS9nv+xHdlnruPrZ9rFZV97Ja6TCspqeO7pm8d0dm+YV
         tb+st1LB2+EFMKFR5MYmTdcDCAbNk3huTlKW5PbwS2YfOV9DGnj/k6SLhtET4wAj7WEl
         Hi0g==
X-Forwarded-Encrypted: i=1; AFNElJ9aXlx19oChvHa6iWXrJUzOuTrOs+HISff/3OISjYE12K9pbjOr8DzebxbXQ67zapa8ESjH2A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxlnqupzY/Blchc06bK/uLkFCQsqwXFVODlDJz3dZAIfhIwKVXg
	YHVJD1IR/1GoVNd7Hzs1WKHOGs0D/iyZpbHZlQrIonkaVJOoIrNM6Qcu9dC/kry4brIRiV+YmLJ
	3WZU4l6XHPqirAfFHZCI73YuUy9Kun880Al4vPU8hbJKHSvp2GMzf2ymj8A==
X-Gm-Gg: AeBDiestAuVm52a0A3ZUkFt3F30uF9HDg1Vjjx+QlosJFsxKBgYdxZiVTlva9vOm60k
	l3m4PkQoU4ObRW9+VUelsnlOzYEd5ppcp8/q/8aHnSZpjQ1ADy2qh0a94k84/myE45SZV/E1Pfh
	Nug9BSav7ljtWYgGdIgFrqc0VN04NV/oygd7kBnAd17oN16vqU9xs3T5lFwcFfVTT/vlO7At2z4
	jImbRFCpLFoirtLtE0eNABHAD92O25fbTWkQQVT5VqXusncn0Jd9c6eQ2kOkl0PLjzWtRR+1JD9
	CSxwdXj+t8KwsI4y1GILLVGDC8hr+883RhIQS2N9XsLCUXRLhP/wtZt9NOlfb4ZjG8AzpPXKULC
	ml+0z5b73nYQfuqP3sgj9LwlOKRleDWUWGxX3ZS5ejC0t6Ew5v6L7b/zdY05pSxio
X-Received: by 2002:a17:90a:e7d1:b0:35f:bc9f:e1b6 with SMTP id 98e67ed59e1d1-365a96b6eb6mr2734361a91.1.1778080547418;
        Wed, 06 May 2026 08:15:47 -0700 (PDT)
X-Received: by 2002:a17:90a:e7d1:b0:35f:bc9f:e1b6 with SMTP id 98e67ed59e1d1-365a96b6eb6mr2734310a91.1.1778080546676;
        Wed, 06 May 2026 08:15:46 -0700 (PDT)
Received: from [10.204.101.47] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-365b4f70e8asm4011790a91.11.2026.05.06.08.15.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 08:15:46 -0700 (PDT)
Message-ID: <734e8ad0-54e0-4fcd-a3b4-8e99fb521ea1@oss.qualcomm.com>
Date: Wed, 6 May 2026 20:45:38 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/13] media: iris: Add power sequence for Glymur
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux.dev
References: <20260505-glymur-v4-0-17571dbd1caa@oss.qualcomm.com>
 <20260505-glymur-v4-10-17571dbd1caa@oss.qualcomm.com>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <20260505-glymur-v4-10-17571dbd1caa@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: EJEMb0LJCJnK2smMumdoExZc4h4bIaU3
X-Proofpoint-GUID: EJEMb0LJCJnK2smMumdoExZc4h4bIaU3
X-Authority-Analysis: v=2.4 cv=cKXQdFeN c=1 sm=1 tr=0 ts=69fb5b24 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=4ZKAssT4AknkAVwkBooA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDE1MCBTYWx0ZWRfX5P/qZLlBF8U4
 arYuyKVdc+KnS/zm04MymXKTLEaEOKU7eQjabJIGq8ryZToFHAqBHcj2mKuv9foSOglzVItev6E
 /4DCvbruTrMnuvLu5S7IhuPe9bJTmnGqaoy43sxaPBC7UfROqg3IP/IOQysBDYp/1JKd2Zop1+z
 RweEj6jxq6ob29oAgSUk3vFmhzi1FnfvKK8FKEAcL3ORuJgT66ihUATbyNyZ1c+yL7+dW7ZeSXu
 uWz07/T12poqV46olX5/nM1KWoETS3165jIzegd3Z9LOWKG86AfgBudwbyF/wfDTvVUIMnrhA0R
 u4GolImagxtm8udUAUYwlFX3No9acvO+bDoaVOHz9qDG3DokLBiNyknP+0oA9QKqpBALXdXog1L
 r+KLeAXwAWKaTG2kP6Ngc07XqMW3Pt1SYKp+OxKdmWn2JASjf343fasmbhIUWZbFIEbfLHg3x/g
 J8GjpF896/HuxRJHWpA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060150



On 5/5/2026 12:29 PM, Vishnu Reddy wrote:
> Glymur has a secondary video codec core (vcodec1), equivalent to the
> primary core (vcodec0), but with independent power domains, clocks,
> and reset lines. Reuse the existing code wherever possible and add
> power sequence for vcodec1.
> 
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> ---
>   .../platform/qcom/iris/iris_platform_common.h      |   4 +
>   drivers/media/platform/qcom/iris/iris_vpu3x.c      | 137 +++++++++++++++++++++
>   drivers/media/platform/qcom/iris/iris_vpu_common.h |   1 +
>   .../platform/qcom/iris/iris_vpu_register_defines.h |   7 ++
>   4 files changed, 149 insertions(+)
> 
> diff --git a/drivers/media/platform/qcom/iris/iris_platform_common.h b/drivers/media/platform/qcom/iris/iris_platform_common.h
> index 7d59e6364e9d..8995136ad29e 100644
> --- a/drivers/media/platform/qcom/iris/iris_platform_common.h
> +++ b/drivers/media/platform/qcom/iris/iris_platform_common.h
> @@ -61,6 +61,9 @@ enum platform_clk_type {
>   	IRIS_VPP0_HW_CLK,
>   	IRIS_VPP1_HW_CLK,
>   	IRIS_APV_HW_CLK,
> +	IRIS_AXI_VCODEC1_CLK,
> +	IRIS_VCODEC1_CLK,
> +	IRIS_VCODEC1_FREERUN_CLK,
>   };
>   
>   struct platform_clk_data {
> @@ -210,6 +213,7 @@ enum platform_pm_domain_type {
>   	IRIS_VPP0_HW_POWER_DOMAIN,
>   	IRIS_VPP1_HW_POWER_DOMAIN,
>   	IRIS_APV_HW_POWER_DOMAIN,
> +	IRIS_VCODEC1_POWER_DOMAIN,
>   };
>   
>   struct platform_pd_data {
> diff --git a/drivers/media/platform/qcom/iris/iris_vpu3x.c b/drivers/media/platform/qcom/iris/iris_vpu3x.c
> index 13fbb21c2182..0d0a239f9feb 100644
> --- a/drivers/media/platform/qcom/iris/iris_vpu3x.c
> +++ b/drivers/media/platform/qcom/iris/iris_vpu3x.c
> @@ -27,6 +27,16 @@ static bool iris_vpu3x_hw_power_collapsed(struct iris_core *core)
>   	return pwr_status ? false : true;
>   }
>   
> +static bool iris_vpu36_hw1_power_collapsed(struct iris_core *core)
> +{
> +	u32 value, pwr_status;
> +
> +	value = readl(core->reg_base + WRAPPER_CORE_POWER_STATUS);
> +	pwr_status = value & BIT(4);

define these bits position

#define VCODEC0_POWER_STATUS BIT(1)
#define VCODEC1_POWER_STATUS BIT(4)

with this,

Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
