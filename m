Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58413332907
	for <iommu@lists.linux.dev>; Mon, 17 Nov 2025 14:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763388191; cv=none; b=tUU3pjpyVpZIwtMsIS7aUwV9IxO2KJa3Tzeo0th/OmjuYf6M0STjqNwFqof4RdxcJ4VWA/jt/XlZAraA1SGiDAEqHtiDSmbAMEG/jYqZ67IIgLEB/KCTiv7pMumB8ibbxikgy4CTMjH7cHT3vEuU1s14u8JJCh1OlEpqlSYneKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763388191; c=relaxed/simple;
	bh=zBQN61tksf2025UCtOB0ANMv1Fzpi+dfcrv4CPkZ9hc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VfNuLjQm8rFL3q8z2E0KUawjKXECHCHFP0eLjZrqQjugrAlfD9ns09ZOEfcVB2xnPTQ6qwA6IW4oUewSxftakCuTNcy26o6kuv5Yl6m8iw5O4W1ls5Mw5FBwSE+52j3vyM8liOt62sUi7lDzB9imiSXdarzSAkurP8rL1K4MmCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fDTM5GSl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jYUSs05Q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fDTM5GSl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jYUSs05Q"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AHB2kZJ3670909
	for <iommu@lists.linux.dev>; Mon, 17 Nov 2025 14:03:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	A4gh/KiDMiXP6GtsBD0jV44i4prQwi2UZjkTQnAGpfo=; b=fDTM5GSlpZlpE+F/
	Yll2WAWkbz5B8FIvh+LLqnK1wha3+V5evOq5StyQ7/yXVwQT99HwrK/QQ4DYrHib
	YtYZPmUrhDwQm775l1eMYeL7T7GtlcSFk7oBYn7+4zKsHI6uYcAVX9OQxSwoefKf
	GjtudtcbJIo83ojArDZNAUoHitTo40vVyCMMoa7qn+VvQ+tsj/XAetXK1E39DJGe
	347eDqJ2DEZjLYzsHIsLIm15nbZSeUeOoQMsLTF8ZU1pYIgtJZXDewAui6xuE33p
	LG63nW6tGf1brkpBHO8HJtDS6ySSN5V9rFmrd2bcDUCkKiSzLN/dM+qUNgsYgVAp
	t+ki2Q==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ag2g58fjb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 17 Nov 2025 14:03:09 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5568b21ddddso228363e0c.2
        for <iommu@lists.linux.dev>; Mon, 17 Nov 2025 06:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763388188; x=1763992988; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A4gh/KiDMiXP6GtsBD0jV44i4prQwi2UZjkTQnAGpfo=;
        b=jYUSs05QMKF7c3FZW7gpojjYLBsVzCFK2oWDpiD02AfOTgBcZJnvZcgbkU7hiAwg3M
         R5b+U3m/nU2oe13znDLvigi4MYdELRDLglJF3zOtN7qwFnHkoKGZDLIR3C1W21ZRAbPU
         u9UjJp6spxnltWHm68DlKfLuyCbFyRsRhbBpEi6u8/pUyNMcRx+WiSR7dQpR1tAGvN7O
         GkKFuGt2FCDJdUmCMvCnsVpXih3690/ACymzkhtoOcUlcJ9iMarwdQhhyB9CzJqutSyh
         ZiTaH/Mk1k77wyyEi/fiN2l1AfNRjQeXCDwp83T5bJki6LI5LNTw3DYMbrncO3FDbQGA
         0s/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763388188; x=1763992988;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A4gh/KiDMiXP6GtsBD0jV44i4prQwi2UZjkTQnAGpfo=;
        b=ZLAUESSbdNGFJFhsf5ShB5/fDT/Y3KViJ/ZcL7uy+4Xv7F6Cl5x0KztKjH3ZEvOpOo
         Pur1Lwcpjkzh+Di2pIb0iDVuvkXxSf1psOQw+YV588K9MGpXykkEIuVok0sKlVnkHpng
         eFgi4LLM4dt+kmPc0qdf0b7terl8UyZCEb5037Q4D3pLyzSNIXYVyq75cxLeqonbzLcg
         EZFAfx0SGE8coZyhpXvj8Kw5VRIjTbVfNdHQ53uxb3fTWYrB+JGmQuy6IaewSysCyoFC
         QKyf5ex9Ch2tKtYUVhtwc30MI9dBbXV8O+FEiJzEELqxxAzcI4pdx6FVkS1SMNHfyaL2
         Sz2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWtW/J+M4GPUkjz2egpYOen1CmRYGTJP1rvVl3pjmwuw3qmIyLCEC+r8IwvXVgM3u0dfuLApA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzn1ii+2XjnkbGFKvZmruQm6NtokppFjRAoq9vXeidj3gTQdBbe
	axW3nhIBre/TDftHGvkb+kG8qC9aNyukRqsKxq8bPFpg5gFG2+059jToUWPq0nGb97BzcMhyu+e
	PVryv/4hK6UJE3d6U7kSort+U8rF/1/9Cc7p4L8gKgJ6RWNLICB7AlRj91A==
X-Gm-Gg: ASbGncvyJDNeUylNrrO6E5htQbjwcvjAznVxh14/Jgn+5T4anCe+Y5hBmFesr7u5MmT
	QU+peSWkF+9hrNLBI2emz3oGyoPLnsVUZOTMI1Gv3vg84BH6AfWDhLXHhFuBa8R152XV3gdo3xH
	KuMp3hVVdOP7IwxkBJr4zQcharf83dbNizHZC36YF+Pca1fu8C8l5/GRwqTibJSJon/J1ftmARK
	9kczFvE3C3fly+faPrgj8Kmu1Y3KDWC2ebKVQheCvUnERyvPpkRd6e5Sp8o5yBBNEBD2HyKFJcS
	NHj2qhXpx29+n29JX1xcpTwoaiIapNjEm8bsdyCr+oRkPDYtLglFx2M2OL7qGG+Gorn+mriqOyS
	aJpmfUrVih0vIXSgCnSzsFnESVZpP7yqwlAL/qAVztpWOlf+lkhzYpaIL
X-Received: by 2002:ac5:c5ad:0:b0:55b:1668:8a76 with SMTP id 71dfb90a1353d-55b1ebefba4mr1296478e0c.2.1763388188160;
        Mon, 17 Nov 2025 06:03:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEZZTHOOdfEqa9ER8hemxiu6HJtbROxsxg4EQg/rySnc9YSfY+WhVEbc35EghFcBXcleB9lbg==
X-Received: by 2002:ac5:c5ad:0:b0:55b:1668:8a76 with SMTP id 71dfb90a1353d-55b1ebefba4mr1296341e0c.2.1763388186109;
        Mon, 17 Nov 2025 06:03:06 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6433a3f961bsm10428680a12.14.2025.11.17.06.03.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Nov 2025 06:03:04 -0800 (PST)
Message-ID: <922abf06-c75f-45b6-9653-492a00d414bd@oss.qualcomm.com>
Date: Mon, 17 Nov 2025 15:03:01 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/20] drm/msm/adreno: Support AQE engine
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
References: <20251114-kaana-gpu-support-v3-0-92300c7ec8ff@oss.qualcomm.com>
 <20251114-kaana-gpu-support-v3-14-92300c7ec8ff@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251114-kaana-gpu-support-v3-14-92300c7ec8ff@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=F7Vat6hN c=1 sm=1 tr=0 ts=691b2b1d cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=Vi7wF31NLlcTFLqBoF4A:9
 a=QEXdDO2ut3YA:10 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-GUID: JX1lRHCCWQnE67RhPgCUOfn4PBnprKCj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE3MDExOSBTYWx0ZWRfX1JTyjZs6RkXy
 pokopb9Y+qXVfbkvnnjPZYw35PFqtBE1fdRI78Teg/n4u5T7fH6sOLm8r/duo/fJu1/XQn6mb9B
 EZGtm7WrkD2G+2bGU9Y5MYvRbnKKFCeRN5oINcUnSxuczlb7DSHVCmOUkU2bIwiiTZk4p1Jou6B
 vZEhzSKYvEPECKZFqvI6k5BCJQaptGAwe3sYMmrXVo5Lvw67YNcs4OkTWTp8ken+t6bymDnOA5U
 QWjl8yH78dIc2p7ikPULD+Pvh/xcE8sM6m41LmZIvRnTiQrr59NvnKjb8hXKvTppE/eE5DCfueR
 LeKYSFVfyURZ7pij9b+WuAlVm7zE4jy2wqpCmHsXzfmCWIyedwFr53TdgGTYOJPJTDveGTHgQrr
 LbW4ymCWThalDCR3Bs4Qwg9RjsZ/Gg==
X-Proofpoint-ORIG-GUID: JX1lRHCCWQnE67RhPgCUOfn4PBnprKCj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_03,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 spamscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511170119

On 11/14/25 12:29 AM, Akhil P Oommen wrote:
> AQE (Applicaton Qrisc Engine) is a dedicated core inside CP which aides
> in Raytracing related workloads. Add support for loading the AQE firmware
> and initialize the necessary registers.
> 
> Since AQE engine has dependency on preemption context records, expose
> Raytracing support to userspace only when preemption is enabled.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c   | 17 +++++++++++++++++
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.h   |  2 ++
>  drivers/gpu/drm/msm/adreno/a8xx_gpu.c   |  3 +++
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h |  1 +
>  4 files changed, 23 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index 20dbdad6e2e8..ef79f4cfb80b 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -1104,6 +1104,23 @@ static int a6xx_ucode_load(struct msm_gpu *gpu)
>  		}
>  	}
>  
> +	if (!a6xx_gpu->aqe_bo && adreno_gpu->fw[ADRENO_FW_AQE]) {
> +		a6xx_gpu->aqe_bo = adreno_fw_create_bo(gpu,
> +			adreno_gpu->fw[ADRENO_FW_AQE], &a6xx_gpu->aqe_iova);
> +
> +		if (IS_ERR(a6xx_gpu->aqe_bo)) {
> +			int ret = PTR_ERR(a6xx_gpu->aqe_bo);
> +
> +			a6xx_gpu->aqe_bo = NULL;
> +			DRM_DEV_ERROR(&gpu->pdev->dev,
> +				"Could not allocate AQE ucode: %d\n", ret);
> +
> +			return ret;
> +		}
> +
> +		msm_gem_object_set_name(a6xx_gpu->aqe_bo, "aqefw");

You need to unpin and _put this in a6xx_destroy()

Konrad
