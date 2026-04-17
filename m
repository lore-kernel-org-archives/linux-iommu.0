Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69DC313E10
	for <iommu@lists.linux.dev>; Fri, 17 Apr 2026 16:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776441864; cv=none; b=o/rtg2j0S8zmVa4K0b3sL9nJI10PwmZ3M50b3Jq/o5OW8tsGqsA+QnN+mYqjeZSCLMV0MZJ+PfDbm0SYtJlr/2WgIRIAhWpms5dA1bqn/KR+MkTjDQ2zFXU9Nqe77kL33fG+dwaZdIlN4AyxhWl/gOXVgfMIicftdk71JNIJ6oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776441864; c=relaxed/simple;
	bh=6V7eVC2GxmE1K8IKhduq2aNH59vZ52IZmutAvqabAiw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=kIp4iwTjdy6XEz+idGjA/y+nO11w6CEvInKE2pLt3ORVPwc++SvSPzJHG+Bne89rJ0WafJhOtQ94q/k3SZ3m3Pyj9YGd2Yw1u4UZFysaXN2Jl+Fol7MNJnA5hB7shhTlQF8uPtPjD+zIDmBVEphO+obzTi1Ng6CDXF1nFBLA+pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WKxIZaTR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YLzti5yF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WKxIZaTR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YLzti5yF"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63HG4Dbh1890144
	for <iommu@lists.linux.dev>; Fri, 17 Apr 2026 16:04:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	o+mn50hNqMsGQm0c8Bz+ul01zBPQIvWzZ6FGvv2HQAc=; b=WKxIZaTR5dM64kxL
	79L0Kn1ziGBMmaSnHOG3HGYiMoAguzNrAl6L/uzqfdri7edxsdEHi9PqgGzI5DrN
	KwLYUmyC1C+jN4MFvCI7uJki0R5Hozgq9bqMl3AT6G1jmS8iP/fKMFKiLNry9QoX
	EQkSh/axW7N18S90IjUmW2qiPxj86tX2BX7VBUJ8NERcazTfxMhoaHNH42zZDBvJ
	cOyFq1utGzIdV4pVhDDAuOLUrR767Rh/Vn0A74+glpkouB6m1n4zdVuA4L29uFK4
	foAsF1uTwKnVbS4ojlZg+L+g9SsLo2NFCoHjsNOTrTi0Ga2ndXwOL5gXUiVl8z5r
	kZjnVQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dkjhds9m9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 17 Apr 2026 16:04:21 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-82f7bec24fdso560017b3a.2
        for <iommu@lists.linux.dev>; Fri, 17 Apr 2026 09:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776441861; x=1777046661; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=o+mn50hNqMsGQm0c8Bz+ul01zBPQIvWzZ6FGvv2HQAc=;
        b=YLzti5yFR9WPuwKSqnLevVZ91jCzaEiy+BWjolzSZZrGCtnIkkjJOHBhtmFnqblKbX
         BiiITigt1WD9KSJENnVQ07j+jzTYRsed53h5ahiSU7FBfKZAubZxONNyzX8C7n9ZUmbq
         DfTfIQGAIT9T3ohnarPMYBHhWd2pxTl0qUVZb5HWdvuama/oIyPT7YQU+LbFaF5nC7wA
         ji93eH2yQVCpgowwvpyVhMHhzTYQyhvN5oaq33oca4PqdZm2gwsaqezB6xyV5ztm5M0i
         vxyTgv2UN5uAfbcHzXQJLVlqhyE4m/G+g3c1P74qff2L2YbKnpbb4xxdcjKaTbLRQPGx
         cOoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776441861; x=1777046661;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o+mn50hNqMsGQm0c8Bz+ul01zBPQIvWzZ6FGvv2HQAc=;
        b=eJ+TJQGWVEVpEvklcgDgEsm+j5g3yi5W6+aRv+u898PEABFK5XI3Fk1Wpp3ElunT4n
         nuAdMFuFptZmBwNP+xicIu5kzPZtG9kyVjo3EuN1Enp+Uns26tiFiuVZaw0EuHLt3gfn
         hraNmw1xE4JfmDgWq+5zXBvzSlCMjEpUEqivb8CK3mKhM7rOA5vDsQJmBdDPGGrT/kg5
         OHd15R8qMX8Xepr2UKXXGv7jYF7p2wTbZoc+M/FSJgd2+siKgXNUBF4NCiZofPqyEF7I
         rdbTgbNYCUv8h0gYI7pwHO45vuQuVrSXWr0HXoF9ZwL02pxFVBbYRQJB0O1If0xk6299
         yHNg==
X-Forwarded-Encrypted: i=1; AFNElJ+g4s/AghrTAYi86I/GMe+9dd2unixqhtJfTc1xOhUwHJ3jjo2q/++PtM7gfBDqiS0nogWonQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzH1sVCbNeGvI35OS8dtsLWtrqRm2UK5eRWdGqvfsF0YI0RgZbP
	D7J82y5vG46U+t/aI7gsM9Ib3ien+9bpgu/Zc6BXeOlroogjN9Hwlja3IsrblBn7bS8+FL05GoJ
	/+SJw792YCS8yAZGg2xgmDnGqDjAR7noiD+8GALd3F+9AlQZqjEkF+inxIw==
X-Gm-Gg: AeBDiesbmW/LDt/NplgRh4Iqa2M9SYgB9iyIeCjnrMuhLW3ItK9B6DPOK6h7bceHWoD
	zm3uRKR8k6sKJnVktw++S1tbr6bQqE0d9Pie+h0yKDA5a/BK5IOUqgxCCnIkkmBJgjJIIke9MAj
	Ew1uXQgD1NlS+krA8M6A9l67TzOfccDzARwjpEdRwnou35IRe+RjlbctyrVXrMEloTjR72288JP
	EVN72BS7OElHa3+nHHmbsOxgYWjLklewEoZN99k6q5ThriId2viVPzJJyHjCps8Z6+8RAXMm8h+
	/Gm5AzXQpzv+a18Dqj9e/mH5+COX5OSU7t3tFEw6mbyySmSMXg2fh8g2xSqIaLKHAvZPhce6g73
	c9HHc67M3QKWmwe/8dkFPsv6FiwfYbQggYu2bHRkmXDVwxSBHZp10gU8ZURJfU5dS
X-Received: by 2002:a05:6a00:4b01:b0:82f:390a:69df with SMTP id d2e1a72fcca58-82f8c8d616emr3650550b3a.35.1776441860907;
        Fri, 17 Apr 2026 09:04:20 -0700 (PDT)
X-Received: by 2002:a05:6a00:4b01:b0:82f:390a:69df with SMTP id d2e1a72fcca58-82f8c8d616emr3650474b3a.35.1776441860173;
        Fri, 17 Apr 2026 09:04:20 -0700 (PDT)
Received: from [10.206.105.200] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e9d6adbsm3256264b3a.18.2026.04.17.09.04.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2026 09:04:19 -0700 (PDT)
Message-ID: <54a670dc-4792-13eb-4240-29bc3dcdb33a@oss.qualcomm.com>
Date: Fri, 17 Apr 2026 21:34:07 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Subject: Re: [PATCH 08/11] media: iris: Add power sequence for Glymur
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bryan O'Donoghue <bod@kernel.org>,
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
        Hans Verkuil <hverkuil@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev
References: <20260414-glymur-v1-0-7d3d1cf57b16@oss.qualcomm.com>
 <20260414-glymur-v1-8-7d3d1cf57b16@oss.qualcomm.com>
 <1de1a366-a325-428e-9dcc-1333bb85ed82@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <1de1a366-a325-428e-9dcc-1333bb85ed82@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 51Y1fiu68PB7sCqIFZ9uyKYCd9S19dyZ
X-Authority-Analysis: v=2.4 cv=YpQ/gYYX c=1 sm=1 tr=0 ts=69e25a05 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=bWAOSzAfB_7jWjvagxkA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDE2MSBTYWx0ZWRfX3eJeAJ3GqWUc
 TOxL7m+ISOPKAq0exN4jtEs+DSEDfYFNjoiTUg8DOzjF0/jbIgp0kJfGr5dzJlOyIPeVonRIVPu
 TYQL9GiahojpvS1Ug/Qr/jBrY4CdFDd7ybKBqBCY3QhG2N0cYWWkjGrxILNEz5ZM7KdolKeFTXK
 OJkesqLgasimsFDSAdVQtr7TFT/0r/v1V55Z2TweVEhmYQu3cc/QVl46C5Bwot/2Ypj5XerxfKs
 AVN8coOLGRFox14T0PUckOl/i9hxyH38F2rKXOhBbeBM+RHBFFhwA4Ek3FI6o+hmh37QLgS0KuR
 XvosPcLYzd99uF0ya15dESQFs1GDSV4aQgJ01PsobLNEXlmhLPfyc8cZ68ElvWl7KFXHNXJ699U
 1XE45har0AAwtGBH808fPtblknBg5ya5ltvKyViRvHjWsINDWJ7/tJmdEFq+ZMD4xToftohyp2r
 NVDgrvBrplp3ou8u+Ng==
X-Proofpoint-ORIG-GUID: 51Y1fiu68PB7sCqIFZ9uyKYCd9S19dyZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604170161


On 4/14/2026 3:19 PM, Konrad Dybcio wrote:
> On 4/14/26 7:00 AM, Vishnu Reddy wrote:
>> Add power sequence hooks for controller, vcodec and vcodec1. reuse the
>> existing code where ever is possible. add vcodec1 power on and off code
>> separately which has different power domains and clocks.
>>
>> Signed-off-by: Vishnu Reddy<busanna.reddy@oss.qualcomm.com>
>> ---
>>   .../platform/qcom/iris/iris_platform_common.h      |   9 ++
>>   drivers/media/platform/qcom/iris/iris_vpu3x.c      | 123 +++++++++++++++++++++
>>   drivers/media/platform/qcom/iris/iris_vpu_common.h |   1 +
>>   .../platform/qcom/iris/iris_vpu_register_defines.h |   7 ++
>>   4 files changed, 140 insertions(+)
>>
>> diff --git a/drivers/media/platform/qcom/iris/iris_platform_common.h b/drivers/media/platform/qcom/iris/iris_platform_common.h
>> index 30e9d4d288c6..e3c1aff770dd 100644
>> --- a/drivers/media/platform/qcom/iris/iris_platform_common.h
>> +++ b/drivers/media/platform/qcom/iris/iris_platform_common.h
>> @@ -61,6 +61,9 @@ enum platform_clk_type {
>>   	IRIS_VPP0_HW_CLK,
>>   	IRIS_VPP1_HW_CLK,
>>   	IRIS_APV_HW_CLK,
>> +	IRIS_AXI_VCODEC1_CLK,
>> +	IRIS_VCODEC1_CLK,
>> +	IRIS_VCODEC1_FREERUN_CLK,
>>   };
>>   
>>   struct platform_clk_data {
>> @@ -208,6 +211,12 @@ enum platform_pm_domain_type {
>>   	IRIS_CTRL_POWER_DOMAIN,
>>   	IRIS_VCODEC_POWER_DOMAIN,
>>   	IRIS_VPP0_HW_POWER_DOMAIN,
>> +	/*
>> +	 * On Glymur, vcodec1 power domain is at the same index in pd_devs[]
>> +	 * as IRIS_VPP0_HW_POWER_DOMAIN. Alias it so that the Glymur power
>> +	 * domain table is indexed correctly.
>> +	 */
>> +	IRIS_VCODEC1_POWER_DOMAIN = IRIS_VPP0_HW_POWER_DOMAIN,
> This feels really fragile..

I'm thinking to add wrapper and use the power domain name to find the 
index from the
platform data instead of using the enum values. I'll try this if that works.

> [...]
>
>> +static bool iris_vpu36_hw1_power_collapsed(struct iris_core *core)
>> +{
>> +	u32 value, pwr_status;
>> +
>> +	value = readl(core->reg_base + WRAPPER_CORE_POWER_STATUS);
>> +	pwr_status = value & BIT(4);
>> +
>> +	return pwr_status ? false : true;
> return !pwr_status

Ack.

Thanks,
Vishnu Reddy.

> Konrad
