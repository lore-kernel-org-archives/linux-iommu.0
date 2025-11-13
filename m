Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD8D352931
	for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 13:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763039443; cv=none; b=k4n88NqOTQpcuhbkISo83VpbU3aYIEcqdm/QdwbClC7y1I0SbVNXVlY+2EvT5xDIKceaEhl7UK5Q5EYw20SakvSabwoTV3B5EJY3kwJmwHJFEvagYuhsaKPySLX4L/wyX+M51U/2/aLZPn+Ak09vWQb9GDQoAMD7W5qCfXC4lwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763039443; c=relaxed/simple;
	bh=8kfWf5AV71bNUbNyq1hAQQ+knwZPGvXuTtRDrcAWJM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iH9aHIAKN69pWTboiZf73PUs8F+/+rCX9/ITbmsmLDbRFOE1D0PaGSHVYtKhMUVP6L40sNgAlxsHUEHtw4JlvKg3TfAXazaszwRDNwk6cKg/hsBg8dMusHKMbES5Hn8AbvU4GMfEgZq1LrnQo+U0q5YgFbQdzp/4oB2bXipBiQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e6t/0V3j; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=I9PrjeuN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e6t/0V3j";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I9PrjeuN"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ADAHHnD4097079
	for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 13:10:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CZXY1ifhV8YPSwfeBFCqHJXWN9yVpsAT+ynQZq3WMfE=; b=e6t/0V3jRvOdUIEy
	YRTECo2K6P5WJYru25zm1auvl0mq3RCtZe/UIkecg0hG16qNXrdYsyIY9LZXIhhF
	vuxlvBXs0nZspcbsY/gitVt1xqTuCwzYsB7x6qdYII5p9fHL1LxRn+CSLIGfSXHr
	OOZB4RnyvDTNlxJD5zL0n1RV0NURlFwidrpfiWcPfRh0IEQOae6/u+gNFU/LzFnL
	Nng3Y5QtIikk08st4WV2moVIFE3kPUnp7SMIM73FuvwoDoVkFn1Xok6QB360OOex
	iT7gID2V3UWRd2FoEAxAbgWxHKfXaJ9vLCUs8vlNMj/Ive2zE1miA7cd9U0jnWdo
	0OPRsQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4addetrer2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 13:10:40 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ed861df509so2825951cf.1
        for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 05:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763039440; x=1763644240; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CZXY1ifhV8YPSwfeBFCqHJXWN9yVpsAT+ynQZq3WMfE=;
        b=I9PrjeuNl64Uxokx9S16HeRoDXuAY7nhTHCmZ3hvjNJF5+zZtADiacPhp/1DcDVpK3
         NwXY12ayiCk9TxzKH9D6mTndQWEh3vqGD/wJOQPoPsYl75n+SssIbMjgxCdlKwCfToJw
         ysvNV012MRDyOmy24fNnAAfhZNHi1zIHvLdcBMUG6IyWtE7mXy5D8nWT4MFcWM41Qszk
         6Fo78FFdhvFjqqIzf8ijqQEZuWWRBt1DBj1yH0GT/yiNYUh4sWyXuNLX5U0TwF5UvAmW
         /zkHh+Djmi7LYE3rVbZfcuDWrC9xQH5voiPON/ODJZSXrAVd2/4WyLLXYVfAtfwxwacM
         V2Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763039440; x=1763644240;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CZXY1ifhV8YPSwfeBFCqHJXWN9yVpsAT+ynQZq3WMfE=;
        b=O3Dh5rJ+cw/RfuzRcOkVJqtkxgojRWIq8q32tVTY5Cc8KPR90f1m9toD93snEU+BO9
         JJMosCRLzlCzcz4KWT8eDt74GuTrRS8alWQ/PN3q3JthdOEW7xTvErS4Z87FUDPBTY0E
         kuTlykBx11eaL6bKRV1ZjYKui0gakbOfuOOnm5U+Ds7ou/cP4LM8+tTAo4rjd9ISVqHJ
         FFTIWxBUw1uTti20Bt+kzV5ujN1paSv2vx6wrqFP3AnwxMPw0MBfoXYiRO8+ECXA/r1v
         sdIbmfbzWF4+RG5KbkXUUNWXKWbs7pbibvXHCY1ZejaJNoelVVk5+9ioVxpsDvbcE2dW
         VUjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMzhQ++nyzJb4hFFdJWSP37bzNb3xaJ7NZ4BuN+HkdVCWudbEhhaBkhdD0pYlWgu8kwAStKg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwcMTR3xXV7Fgac6ws/M6BnwsiQNakQlHaFPXGSuBIfyq2Kz4Zm
	qJcgaqJ9xP+g0syYcdAQOLXrlSw9EujdkxBkfYcroAa3RHUaxAvPl5WrOLVxoZSdyAHSbIgugcA
	16pTLfzFWVBsV6DMbRv/7eOIZBsfFm74SL5aTQz7iZR2oxAiB+iUD3otm9w==
X-Gm-Gg: ASbGncvNinawU34TNAif9l8yxo4frlDtwxT/rYRe4OfAayO8ol7Q9fIi9Bn1NHFDmJo
	Twa/SKQoFSlfOz0mKLRJoDa34HXGN/PE0pyYYsBgjwkuUcLHeUYHPj71nXr4sP45ULc0dUCswPQ
	8KAWvIkkzZqJIkMHDJaFxieMgHCSU8iaq7vE2uwcv/NKnBsPEXi0I5v8vCRdWunVz97IMluwxsu
	QcfJHWuiZAm4inyI9QD44rUb6jtW+SMXefktONsYRpp5LCSo8ctVJoXYwEl4cbNKL0vpVFh1eMl
	TnP/g01Fei938HAtKDMWqi7fTXAaV4w/ZdSMal6VoZqcR0PSSH/KCIUnIxMkOvS8NZJvow6zKLM
	DcjQBZMBqy/pj4FjJdb0ESUUS4BZBfPVsp1WM6NArjYKLAhOyLCJ3yLK9
X-Received: by 2002:a05:622a:1316:b0:4ed:b409:ca27 with SMTP id d75a77b69052e-4eddbd65605mr59626121cf.10.1763039440314;
        Thu, 13 Nov 2025 05:10:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IESawNQFUeHeMbh5CviAuecEDsSSa2Db0tmz9JN9G7A61f/DAwZOVKGgRG2h1xYO5nZjtsMBA==
X-Received: by 2002:a05:622a:1316:b0:4ed:b409:ca27 with SMTP id d75a77b69052e-4eddbd65605mr59625541cf.10.1763039439747;
        Thu, 13 Nov 2025 05:10:39 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6433a4b28bbsm1396845a12.28.2025.11.13.05.10.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 05:10:39 -0800 (PST)
Message-ID: <f7e204ac-28b6-46a7-903d-30b7f31dff8b@oss.qualcomm.com>
Date: Thu, 13 Nov 2025 14:10:34 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/21] drm/msm/a8xx: Add support for A8x GMU
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse
 <jordan@cosmicpenguin.net>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Connor Abbott <cwabbott0@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org
References: <20251110-kaana-gpu-support-v2-0-bef18acd5e94@oss.qualcomm.com>
 <20251110-kaana-gpu-support-v2-10-bef18acd5e94@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251110-kaana-gpu-support-v2-10-bef18acd5e94@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: mJEYtvkgVFJ_yT2QtYfCzJEp4Vja56YS
X-Proofpoint-ORIG-GUID: mJEYtvkgVFJ_yT2QtYfCzJEp4Vja56YS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDA5OSBTYWx0ZWRfXzZKnkw/xm5Zc
 8MzJY3PKCH5bqOJu2ConI3aWJqEvm1kY1LfJ8YlFoiqrvU2Raq+GUvKliSwN2sdBcJltjR+4O88
 k1nGcFOfAXWuZlOnBupTLvfRPVpsq38E8pW64UXjXHoF2eLt5CitO5bx6pLQHfrSza2QaPX4vHG
 r2yLtmC21rcEdqQh/vZGLYESR0GPeKZ5FKrTVvgEbfjgOY4LDEr6s7XL+5ATIefGKMEkQ10GORS
 0ef2HE9xJk1sc2/5GgMI5NqqJi+4kY7PUOOwMTVDSsRFq7DDfx2+H3+Ms9WEnE75j4o2b5rdj1C
 wauK/+0j+8jJGAZhkCyx8792U0qRfwWq6NzK0S5PxGSVWbvQCVdj72InOrBBDI/tACvf+HAxYwg
 Ic5iZIW/FEHOh5LJtG0Ixrv6umQsqQ==
X-Authority-Analysis: v=2.4 cv=QZNrf8bv c=1 sm=1 tr=0 ts=6915d8d0 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=XMd9o5LtjS6KuIBsTZQA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_02,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511130099

On 11/10/25 5:37 PM, Akhil P Oommen wrote:
> A8x GMU configuration are very similar to A7x. Unfortunately, there are
> minor shuffling in the register offsets in the GMU CX register region.
> Apart from that, there is a new HFI message support to pass table like
> data. This patch adds support for  perf table using this new HFI
> message.
> 
> Apart from that, there is a minor rework in a6xx_gmu_rpmh_arc_votes_init()
> to simplify handling of MxG to MxA fallback along with the additional
> calculations for the new dependency vote.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

[...]

>  	/* Make sure there are no outstanding RPMh votes */
> @@ -990,7 +1022,8 @@ static void a6xx_gmu_rpmh_off(struct a6xx_gmu *gmu)
>  	gmu_poll_timeout_rscc(gmu, REG_A6XX_RSCC_TCS3_DRV0_STATUS + seqmem_off,
>  		val, (val & 1), 100, 1000);
>  
> -	if (!adreno_is_a740_family(adreno_gpu))
> +
> +	if (!adreno_is_a740_family(adreno_gpu) && !adreno_is_a8xx(adreno_gpu))

stray double \n above

[...]

>  	/* Check to see if we are doing a cold or warm boot */
> -	if (adreno_is_a7xx(adreno_gpu)) {
> +	if (adreno_is_a7xx(adreno_gpu) || adreno_is_a8xx(adreno_gpu)) {
>  		status = a6xx_llc_read(a6xx_gpu, REG_A7XX_CX_MISC_TCM_RET_CNTL) == 1 ?

You skipped writing to this register above - can we count on it
always being in the right state?

Do we need to map VRB, or is that a topic for the future?

Konrad
