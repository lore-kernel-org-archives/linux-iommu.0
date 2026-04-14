Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948FE3CA490
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 09:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776160154; cv=none; b=upM/NZundtWhMgESwQT4iyldc4aPXPZ7YlaY7mPwBfVaAODEteUP0ZZSxiTU8Svj44bW03hDJZUSbL01D3mKBW5i1xulNWa4xHA2oEh8Et3kgR1blS+J3t/2D9qT2Q/k0LX5nNiaNvPlVC5NGDcBdivBrtd44kMs8wRrG162I1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776160154; c=relaxed/simple;
	bh=wuR5JFSajf2hkwoeFulviUjvuO08ypSrDi52MURLwgg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PjVHuzGOBzmUsIY/7HY7xy29MJ3TxNyaufV7H8PxmfiZTndPR/3gbBrQnZ7VtBix8gkYwq89Uv8REqBtnIIinQl5N4pMiioIXuzMo7pMUJhRXK165eemHcsYQDnV1y8YKoC6KUy0jxvCzCF/d5wfP157x6LXmd61w4Y3OGpDVlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RN4fs6if; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KS8xc8Fd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RN4fs6if";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KS8xc8Fd"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63E6bGmI3426070
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 09:49:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MZiEsYnwchziA2wH1UdtccA4jEIltz7HwL+VNB9wT48=; b=RN4fs6ifLIv6rZsQ
	LoIAJ9rZxdiE/7u9kXiLMwxNmB8F9sODkK7wI2G4oqj2x1OV3Wueyi0HK4G42Y90
	NlKQEgtRFwCKpgCpcBngKB8OKBWlMVSStt+eEBfIrf8JRJ0KQuy7cdTNTonGNi2g
	f5tw7w6POQyJ3MyElq2NHQ1kJREiFhxeEv5JzYWg7bGXC2NZ5JMpJWVdIcDYVzxS
	/+RVVjJ/Jz2XW//wVq0ghOvm7DDFWE8HFNUpbvcv+L1s3FcwAIs+1iBcx8vrXp7A
	o1dGqWtY6BATjb8Xzu1bxudEsBJr7OecdfZzU7FU0NwUgTwSbgJ5kYfYn1jFLdEg
	EyoQXA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh87fa5sj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 09:49:12 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8a5bf7ee420so17465456d6.0
        for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 02:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776160152; x=1776764952; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MZiEsYnwchziA2wH1UdtccA4jEIltz7HwL+VNB9wT48=;
        b=KS8xc8Fd2ekvHXOzowu+7XTwd9GWQzBrLO8nW+bQNHNGTJpmk9Z90te200OPmpkQ/o
         VRZah7edg16k2zLH+z156XXyHlYarTRGa+q8qQlsdVIPwOdiUebHCObPGl6/A7cJtc0b
         PUJsIKU1svNtnhkSN/L30+HAyBXp6WjirAAui3fB1wG9+C5J9PH7pYDgeBsqRD4jfpV8
         nkYQ/gs7OPp18dQDce3zJmlbG1Xg37xMs4lp86iWb5Rh6cDKsahAwfU2PLb8fzfZpkqN
         UIAQz/PntIs3XOmyI8ZKG3N+mA6PpdkYfeI5QEw6rT0JVPZg235Ql8spPz5A7YwmmbIP
         uepg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776160152; x=1776764952;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MZiEsYnwchziA2wH1UdtccA4jEIltz7HwL+VNB9wT48=;
        b=g6wbs7xJuWK+VuM/vNAZZJQf4vLQFsP7WFSlCjzh/kSqb/OClEPI61e/aRrNMuY0EA
         Y+ewnQkwouJKdOUs0CxfkVq4B0Owk7yddQP25VpsPe84URO3BziRIFMYW9IvArPbY3Qh
         VSg9H8YxJqTu5fTHTd319R/tpqNHxvgNOBbqwlMy2mWoH+m587emE0RK8lsvHHDa6Bkq
         YBRhvSLTkDr6MXXHOonjMA8o3Rr5fjtLgHSIEtbshmnzkcALAAhE+20aMNuVowy86NVi
         t94VFd6Ofl1KFiDlFzGrDqZWWq7Oy/YpqO824StACUwtm20x9k5pWJNOvGYvIXMUwbdN
         T9ng==
X-Forwarded-Encrypted: i=1; AFNElJ+r6+XQZq8LIizjqla+KnvfW+YIzOPIYkHCqGbBpfcXNH4B7RK34TNTWgi5mhXKlxGZd/snKQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw35y+XJGcwfz2J3CaFAUyau0KU0Ai7LYqMlKQkXJFa7E+ZxXn4
	GppdKIatamIhel3hwtF9BE9GQAFz9fCEpVQW2W8EDeQkudhUPYvfunzxd0Pb78OM0HEjyfXhfeh
	Uqbhl3j9qXuxgB/j1JZw4Tf63eq/s30fLC/uq9R14Qsh7Db6HsXyQgF+dhQ==
X-Gm-Gg: AeBDietkyFpm6oSJQcU8CymoDQm+hk16RVAJScoYCe7pElFs/xoRGNpBXEVOFGQvsgz
	jjFSukjm6lha0SMx8Qv3gNxTG6ug35a11hHBrAqDsAPkTU4rdHRdlAC6zqKec8A8ROFl++tzlqw
	k1Bfkovoudfm8/t7aLdV8qfo4bd0Hpsqx0Zq8N+miH129O0373Zr8ddjOwduUyejD7ispryt10o
	AR60UmgUcF5Je271BOuTy4qaLhobTn6BLQ2wUOUym5puTJxs0RcqzamHb0ciFE3hxDormHpJzlP
	ZhprxFNNevjpkNHFlQrOpgz3yKZrLDef4PvMm/5uZWY1qwcLkhgnQVFYZmuU2moLjhM3e/CtzwD
	bfL2TWCjhxUl2YHoo0sWewhA+ye4CzWEiWdNDn1XoqwfVsesTXOI4PB7FF0svNeyToWEt++nLpt
	L+NcHTkEiFnUhRXw==
X-Received: by 2002:a05:6214:21ea:b0:89a:5129:510f with SMTP id 6a1803df08f44-8ac85f82b45mr181121286d6.0.1776160151844;
        Tue, 14 Apr 2026 02:49:11 -0700 (PDT)
X-Received: by 2002:a05:6214:21ea:b0:89a:5129:510f with SMTP id 6a1803df08f44-8ac85f82b45mr181121026d6.0.1776160151365;
        Tue, 14 Apr 2026 02:49:11 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9d6e7c8a44sm386708566b.52.2026.04.14.02.49.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 02:49:10 -0700 (PDT)
Message-ID: <1de1a366-a325-428e-9dcc-1333bb85ed82@oss.qualcomm.com>
Date: Tue, 14 Apr 2026 11:49:07 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/11] media: iris: Add power sequence for Glymur
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
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
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260414-glymur-v1-8-7d3d1cf57b16@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDA5MSBTYWx0ZWRfX8ti4YyBKM5po
 +tDZMEHJKFSgOfawOMs5N/v8vcZYbO565qcl6Zldj6lPiNx4auYBis6TezL+94/GWm/V42Q8fxq
 5o8bNBS6PlzC2srl7LwC3B3YVsCHLw6sx0bwgFwrcZ9vEcTAt/+ckDBQWExInpW/yh9CHrCOIym
 SDjxQ5JqO4jwkzhjRBIhmG3liiyLY94fQjUC7904uNPoBHw9/MmnywcIRosh+23ICR5SqvUHzNP
 /swBlod5AeOXzxePiSOhKONTnK90pond686un0td3bwjMJpCTtwRDG4BmFr++kkDFZi5tmi6krs
 92T1wTDBa1fkmymKV+ZKngakeQraieDGogNJiGFTZCGjKGMjVmIDJ2rSzPBLJsrSexIbB98EGV/
 Xe0zVPwEv5pvqXlr6Tgp92YckIu84GK6DFxI1ygsv/+YfHSGEdytwXOwETA6Uw7ptemVpAoYjqX
 XxM7R7wZjl802oq99aQ==
X-Authority-Analysis: v=2.4 cv=DaYnbPtW c=1 sm=1 tr=0 ts=69de0d98 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=wrwf7AeaGIUVrLbmntoA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: e5jbY-jdP-uNFXqFyYu_pEdRv8Q-qSvL
X-Proofpoint-ORIG-GUID: e5jbY-jdP-uNFXqFyYu_pEdRv8Q-qSvL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_02,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140091

On 4/14/26 7:00 AM, Vishnu Reddy wrote:
> Add power sequence hooks for controller, vcodec and vcodec1. reuse the
> existing code where ever is possible. add vcodec1 power on and off code
> separately which has different power domains and clocks.
> 
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> ---
>  .../platform/qcom/iris/iris_platform_common.h      |   9 ++
>  drivers/media/platform/qcom/iris/iris_vpu3x.c      | 123 +++++++++++++++++++++
>  drivers/media/platform/qcom/iris/iris_vpu_common.h |   1 +
>  .../platform/qcom/iris/iris_vpu_register_defines.h |   7 ++
>  4 files changed, 140 insertions(+)
> 
> diff --git a/drivers/media/platform/qcom/iris/iris_platform_common.h b/drivers/media/platform/qcom/iris/iris_platform_common.h
> index 30e9d4d288c6..e3c1aff770dd 100644
> --- a/drivers/media/platform/qcom/iris/iris_platform_common.h
> +++ b/drivers/media/platform/qcom/iris/iris_platform_common.h
> @@ -61,6 +61,9 @@ enum platform_clk_type {
>  	IRIS_VPP0_HW_CLK,
>  	IRIS_VPP1_HW_CLK,
>  	IRIS_APV_HW_CLK,
> +	IRIS_AXI_VCODEC1_CLK,
> +	IRIS_VCODEC1_CLK,
> +	IRIS_VCODEC1_FREERUN_CLK,
>  };
>  
>  struct platform_clk_data {
> @@ -208,6 +211,12 @@ enum platform_pm_domain_type {
>  	IRIS_CTRL_POWER_DOMAIN,
>  	IRIS_VCODEC_POWER_DOMAIN,
>  	IRIS_VPP0_HW_POWER_DOMAIN,
> +	/*
> +	 * On Glymur, vcodec1 power domain is at the same index in pd_devs[]
> +	 * as IRIS_VPP0_HW_POWER_DOMAIN. Alias it so that the Glymur power
> +	 * domain table is indexed correctly.
> +	 */
> +	IRIS_VCODEC1_POWER_DOMAIN = IRIS_VPP0_HW_POWER_DOMAIN,

This feels really fragile..

[...]

> +static bool iris_vpu36_hw1_power_collapsed(struct iris_core *core)
> +{
> +	u32 value, pwr_status;
> +
> +	value = readl(core->reg_base + WRAPPER_CORE_POWER_STATUS);
> +	pwr_status = value & BIT(4);
> +
> +	return pwr_status ? false : true;

return !pwr_status

Konrad
