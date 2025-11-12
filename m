Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FEE30BF63
	for <iommu@lists.linux.dev>; Wed, 12 Nov 2025 11:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762945670; cv=none; b=tNiEU5Vo8+CyVFo6R2Sh8rap1CPAhbzmQfYb2SlL9mgrseBXeXWqYlVSDirY7fOeCqeS/nXrBG9X9SFXyPBW8BQ4C5AmkvCHlPGRhS/yXpPf0sDrMw7WayEQl5zMs9ZBxz05kkJpwRAOLMv9Oj2fdZaFaKD4uK+bvTSyvzX3MlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762945670; c=relaxed/simple;
	bh=GHAbyl4yETBScmi+Spn18VZXHiQdet69r8rooFugvlw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jn4627in+GDV9xw2G7/J5q/8vc3hDmRTOTZoVZqPDTUZEdhhDnesBdiGxazfQOn2zM1pZl1tmmZwD5JihYHaNLYBKDJYWwGE1rgSF1Oev59owDKJRhHdofXiSteN49WpLGaekrdNuvYWDKoO+2q0HvR3fjCT4QFNZdNIhLBWnoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AbFmXmBT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gv9DUPvG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AbFmXmBT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gv9DUPvG"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AC6SqqO350358
	for <iommu@lists.linux.dev>; Wed, 12 Nov 2025 11:07:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fhpeU9U5S/hGeJg9f9bTT5WPcsYN6w1Wj4PWqyqzdyc=; b=AbFmXmBTta7gKjns
	M54/EkecUo+B6cPlccmI4n5Aj9/wqRd2an+bzFJ+ms700a4OajXZeUEs0gXWQRLc
	etsB8+PdB0dKId8+lOeFMHY7TYoDx1ABopbYg7tBtpG6H6xL3S35HNvLdVM/zgAq
	yfYjYPBDelBKRb0j2yq5sVRydVg/9Wase8IyulhN4dEeUlmoH2zYiu39rd5AJymA
	5IfH9hlH087LSQuSPibn+jT/AI985QAaVn+au/GJ6aMhUMY+rDwa++KEfRyjYwxK
	dXGbWqcERW93lnoYSWvH1QxycRclRX0ECjE89dnAtVJyZcIgPp1aXQ1KNS+XJChv
	rcbN5w==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acn0nrycs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 12 Nov 2025 11:07:47 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ed6317be8cso2261371cf.0
        for <iommu@lists.linux.dev>; Wed, 12 Nov 2025 03:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762945666; x=1763550466; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fhpeU9U5S/hGeJg9f9bTT5WPcsYN6w1Wj4PWqyqzdyc=;
        b=gv9DUPvG6obvoPikSHLMAh5Wz9XSp5q7E3Rr1ryIeuibUpmo7j5f89n0dTYPdAri0N
         zXWIEQR5L91UbInLob/dKdXZMHyGnYDNm20vKUYnjkbYP0LeEhK0ifqKK+fVibaUoR8u
         hvUPFar2zjJCSr2s1KKDdawlhIhf5WkZb1WI/w5/8NQ5TjVvjbaINlupu4NkmWG+pIDf
         bDMV7cAunbEVhk9i2WXOigsnb2AIbhzoII1nwarNhnvl2g2NrPu3h4nN1efSr6+TMNjt
         2XEvb6e0pA2P/p3lh+GWrDb3hyvn2Fs6LDALl87b4hJagV4HoBwuzfo5yagV3X8YGAhG
         8t9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762945666; x=1763550466;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fhpeU9U5S/hGeJg9f9bTT5WPcsYN6w1Wj4PWqyqzdyc=;
        b=qlsGkHC28HHMTgutG0tT1LYGExsVKMhM4KbgR7Cqs4mCa+NzXAkFoBPp0661pJTzcg
         ne6LyCrH3FROkVf5G8DlzWR30n9RQqJjJaPtG/9u8ob914xQPBM10movmKWZvmaR5/CV
         Zkhz+ZYOJjOrtVxxc2DnAPF2w2+pahp0xUdXoPEXIbcaYx7zZAU1QdZCkry7pm0o2nkH
         87PYBgkE6sYmf4SbBgJKPNWlXscJ06Co7MqyYvChImS/Jx4lPIVx9vV+bKxRBswh6afJ
         xwdb7a9fX7Cka/liJdfO+0YxENw6MQPVLbGlql3WBaesQ8LhqnBOnETol7zI3ovxEHDf
         owCA==
X-Forwarded-Encrypted: i=1; AJvYcCWMI9HHi0rCMhOeJkiWaIfFvRcUm58eaT/61XVothjERta67mQNacI7gxGmOi0tM4rR68Ts3A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxOdiHbfQ8MAltjMLyrlVJvLHGWMNIWxDruIxrliAEZdsXOgCJ0
	eBskFxj+a+2sG+ZEbLsb05UX93r9Yz2pQYOCnPACPDeiv9gZsggTPujuWzv5GTO5dj8+daA0v8b
	6+UaDWrCGrqCFaVXERvGgcdvp9SMK0ty1zmUPFcXtsDcKuB37WKFI/BLZvw==
X-Gm-Gg: ASbGnctFEjODLnMgVUh2iwhIGdAifuxAMxomfrghKEFsdij7Wt1KYeE180ZgbSPHsm/
	+Teb14X3z22bm0G90CkONWZg0pV4FdmX9QIoFAjY58+r+9cPalXrmbQ6rEEHZREh/Scr9YAE9oe
	6ilP1JYDaHTVDFi2qEOyEVYMSxR42nxEGGa7LiXBi7gPNTz/lJ6MCRgjY+CsqCzcF8rKkMs9kIV
	gDscl+Y/yOSr5eizmsxskaeMBfP++8Krkl+/NPsG/Q9tTO5iHFzts2YTb/tWxL17T/qp4OBjWpX
	sPPma8WgF18QRQzfyWh6aSPn7y1rT5ICN7jIWK7xz9JKKu3QNowDGjZOPNR/S/i2tA3+Nfm/kKt
	ffMYZC7JZ5DWR0glOxilUNR0efrHcwKEexBYb1BmT0/wVJSStHJid3vue
X-Received: by 2002:a05:622a:1a9a:b0:4e8:a001:226d with SMTP id d75a77b69052e-4eddbcc8ccbmr21834761cf.7.1762945666368;
        Wed, 12 Nov 2025 03:07:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEsThee/kJ9PQlX1eMjNVcf3pwMggayYjNqOtdauF4RKz6aTdQHNiSCZ2A6kK70/XwvxAErjQ==
X-Received: by 2002:a05:622a:1a9a:b0:4e8:a001:226d with SMTP id d75a77b69052e-4eddbcc8ccbmr21834301cf.7.1762945665887;
        Wed, 12 Nov 2025 03:07:45 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64165b2aa03sm10031978a12.6.2025.11.12.03.07.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 03:07:45 -0800 (PST)
Message-ID: <1202b66c-6d4f-4909-a010-7e5e3ec7f0c7@oss.qualcomm.com>
Date: Wed, 12 Nov 2025 12:07:41 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/21] drm/msm/adreno: Support AQE engine
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
 <20251110-kaana-gpu-support-v2-14-bef18acd5e94@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251110-kaana-gpu-support-v2-14-bef18acd5e94@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: OHA2utlTJ-g8jyb1Y7hGVGMU1pwIOCwO
X-Proofpoint-ORIG-GUID: OHA2utlTJ-g8jyb1Y7hGVGMU1pwIOCwO
X-Authority-Analysis: v=2.4 cv=acRsXBot c=1 sm=1 tr=0 ts=69146a83 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=XSWwlsXGtsdNaMXbhvkA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDA4OSBTYWx0ZWRfX6DAXGGZ/nBwK
 ozmY+FcbLsJEEUPN8qbizjMjCnz/dzrOcjTRSAXJ14KbmcjAXX2LcMspjAeFCSosoT7WC/0KjOb
 GOo2quee0D6mbnx8bU6yHDquuBMXWmVmEwEYtyDhWo0cZ+j5L5RZ/XYAOGokc6yeS6lnQQfedqe
 BEkoXQwkED00si2oRSm1yF60OajvrMNRLuYoUzDcd3hDuncI2HrsbDG0gN2KW2p+f1r4q2kS7r9
 2aekoGBMx6xLW9JkPZyb+9RkyvLcuOY4Ex9UXQQJ6MuZ51uAurStYgudbeFktBVqEzve2z6qH/t
 1LbCpFhI1IWHqZ5QLduvhcE6KkUI9WIv369yaQLu+fSG0VZMvqYEjXqjVIIhmoMoI067n7c3iHZ
 g6OUXn8ekzVcY9AW4gciR7d9hgUuqg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_03,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 impostorscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511120089

On 11/10/25 5:37 PM, Akhil P Oommen wrote:
> AQE (Applicaton Qrisc Engine) is a dedicated core inside CP which aides
> in Raytracing related workloads. Add support for loading the AQE firmware
> and initialize the necessary registers.
> 
> Since AQE engine has dependency on preemption context records, expose
> Raytracing support to userspace only when preemption is enabled.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

Side question: is the AQE fully functional on any gen7 targets?
A750?

[...]

> -		adreno_gpu->has_ray_tracing =
> -			!!(fuse_val & A7XX_CX_MISC_SW_FUSE_VALUE_RAYTRACING);
> +		/*
> +		 * AQE requires preemption records, so disable raytracing
> +		 * if preemption is not supported
> +		 */
> +		if (gpu->nr_rings == 1)

"nr_rings > 1"?

> +			adreno_gpu->has_ray_tracing =
> +				!!(fuse_val & A7XX_CX_MISC_SW_FUSE_VALUE_RAYTRACING);
>  	} else if (adreno_is_a740(adreno_gpu)) {
>  		/* Raytracing is always enabled on a740 */
>  		adreno_gpu->has_ray_tracing = true;
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
> index b507ff4e1756..7921b4a68937 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
> @@ -58,6 +58,8 @@ struct a6xx_gpu {
>  
>  	struct drm_gem_object *sqe_bo;
>  	uint64_t sqe_iova;
> +	struct drm_gem_object *aqe_bo;
> +	uint64_t aqe_iova;
>  
>  	struct msm_ringbuffer *cur_ring;
>  	struct msm_ringbuffer *next_ring;
> diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> index 78dcb9bc3377..2ef69161f1d0 100644
> --- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> @@ -616,6 +616,9 @@ static int hw_init(struct msm_gpu *gpu)
>  		goto out;
>  
>  	gpu_write64(gpu, REG_A8XX_CP_SQE_INSTR_BASE, a6xx_gpu->sqe_iova);
> +	if (a6xx_gpu->aqe_iova)
> +		gpu_write64(gpu, REG_A8XX_CP_AQE_INSTR_BASE_0, a6xx_gpu->aqe_iova);

I believe you should also set CP_AQE_APRIV_CNTL per-pipe

Should we also enable AQE1 while at it, to reduce potential backwards
compatibility issues? Would that require solving the iommu woes?

Konrad
