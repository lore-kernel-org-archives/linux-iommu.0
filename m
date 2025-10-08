Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812752F60CC
	for <iommu@lists.linux.dev>; Wed,  8 Oct 2025 12:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759924873; cv=none; b=lXlIV3LVeixgOj2KPrXHdXcWf5lyfdxfQinqeLSS3/bQtwRaR8b06XBj7FEKioZpzscmF834bhjBfykLocfQ8tHca0XCTe5SJPf5swRwgXifhZiNPZv/ITln0VKa9qzW7fgKVkDZ9WrQaZptCX8ZbRUwUQyXYJl75+qnKhIAwDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759924873; c=relaxed/simple;
	bh=QfUT1DtV9d+QVs0WgbumZs0pdJWkf14RDIdQPku/mm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=momoolIL37fULkqc2wtZWJ78PNl45YsUMAW6fUS6MvVydRcZJIwqbydwBpz/kLLYtLXN4t1yNoEx2hd5J192E40hRp9YZttGhedUrgD3lCoF7Q4pRcKGI7pm1ON/dEIGRsUBYyGF9tPss/vwHL2FthQNKL+uauXhZLa5J/5fAcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eIMRSor3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eIMRSor3"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59890OZL028852
	for <iommu@lists.linux.dev>; Wed, 8 Oct 2025 12:01:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YUe30woE5xEimZOnT9raXvhiVzii7F5/lJXV/+rQmpU=; b=eIMRSor3s8f0HqdA
	pkeP+CNNNqq715YMCOKDIEvIXhzK21rEAyE8AKxeGV11sFtZfcRSEWqiWYOV6l31
	CLFJOgcKqXCKvLzgnXLH0MLaL1IiJjrT58mDzQvQZWYfiOmU1MSSdWVsnCF/0GmF
	24SSvVe5dkZRObBoMxoeoc6XnfDZJoTq5N5OC7hOgDuV2LrGeLjqslpcpdvtsSBv
	PaXMMVUSqf8eH7v6YNIhQ2uNOdysGj8ioXnzOt1TGs6jNoNQNQnjGVfPLyCMnGdk
	V1EDZok9m9WVpHqCc8TtZuOo+U/kvJtxr0J1HRlQ2GVaXM6DoXflM1gj63gLWR/X
	j5vGwg==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49js9e2gkt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 08 Oct 2025 12:01:11 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-54a38d9819fso56878e0c.0
        for <iommu@lists.linux.dev>; Wed, 08 Oct 2025 05:01:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759924870; x=1760529670;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YUe30woE5xEimZOnT9raXvhiVzii7F5/lJXV/+rQmpU=;
        b=HDL4ZMGjQRh3O6LIP63Qg2s41uo11WzOFBUf7KEKk7IbpBQ69IxdpAyKnHTYxwoD+h
         FrYxuPHFzwfQ4cVenRZ6BCVwPAaF/VkDGBa6eumLlcrMMSmzb1kViGlKNGNki+cA7Y00
         I3mL3FR4QjegOLgPFeqmWxMCbQNshotkCl7K/B+2kxHIZc3053OH5JXtkJpKlVEFXNVu
         uidRgtS/AWKfX91e5P092ubyds/t5KUlgtFzR8JxQ/ZAdiFmaMlgzIgONe691vUfZzgL
         mQbjMOoE1zBWlJlyJKiGYH7BnnoF7jrjMzekN9MY1g7rykfz1LIQ/SM5g1H5nmgPgrnZ
         EWTA==
X-Forwarded-Encrypted: i=1; AJvYcCWFGaeS6oriUZ+63v8S8WaX12AxBkXEhNu9XwG7gAv1g4tuv+Tfk96gpNXwLgQP7iSIwiAQFg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxsks6/GnrVCao3RZi94LHb9xDn5mEs5zKBymbAG5ORP3FxPkis
	iHI8FmWj1ReFUEbuLaTU5tZPEsAP6o2NKZmfJKt+0AQDvK8NeLuJ/wol2GNxVUY3mN5LTLq9eTm
	CxjrWOjFkqItv5F9+77qIPutws4BFOC7OMQTOpGybupv3mQ9UYbG8ZMoMsQ==
X-Gm-Gg: ASbGnctH1y/bLRjwIGT8tXUWTd3uonUjEj6+W887hqmAOct6Gs0Lbva57VfazGsP/cr
	KVUVIpEj3itsKFUJYrXwOYGr2DFntUBOR8pRxceLyfgDZgxWh8+870NcQJNNJUhVK/KuvYE1RuS
	7PJh0+Wu4KrS0181JlyYdKEdZcAwpxRmQUS4apDO6RPwlUD2Xe1pE5M3yY0ejB0jk6RMuqf/5yT
	A80g7lNq2EIhN7yCgW3np0m6Z5PoYOOTY4wXEI9L8aLAjD7ePfIWfA+wXqKwQL5ngMl0DJ36xyH
	Ll4V11M9ZpBn9V0FK6s/YhBbhveTTqghvp1aNMRTdz0v8US7PR6LSU8kiYUlt86dkNSnIzO2JgD
	QckW1bnp/+iEMGhhK38tSmU3aIq0=
X-Received: by 2002:a05:6122:6c01:b0:544:6d56:eef1 with SMTP id 71dfb90a1353d-554b8b9dafcmr382780e0c.2.1759924869679;
        Wed, 08 Oct 2025 05:01:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFT9kYombhVn9vLwV8HVqDP5rHDdMKek8m1Ph8xI5IlH4fvXAiDJcCahZY6sxIbEptqVVlYDA==
X-Received: by 2002:a05:6122:6c01:b0:544:6d56:eef1 with SMTP id 71dfb90a1353d-554b8b9dafcmr382725e0c.2.1759924868891;
        Wed, 08 Oct 2025 05:01:08 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b48652aa040sm1634050866b.20.2025.10.08.05.01.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 05:01:08 -0700 (PDT)
Message-ID: <f7f2189b-b182-4616-bba3-ad1a0af3e4da@oss.qualcomm.com>
Date: Wed, 8 Oct 2025 14:01:02 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/17] drm/msm/adreno: Introduce A8x GPU Support
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
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
        Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org
References: <20250930-kaana-gpu-support-v1-0-73530b0700ed@oss.qualcomm.com>
 <20250930-kaana-gpu-support-v1-12-73530b0700ed@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250930-kaana-gpu-support-v1-12-73530b0700ed@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Hrl72kTS c=1 sm=1 tr=0 ts=68e65287 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=C_0j-PAzlxBuy3Ei6pAA:9
 a=QEXdDO2ut3YA:10 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-GUID: hgVc7iC-Wkp95MSpjuranJirC5bS-mfl
X-Proofpoint-ORIG-GUID: hgVc7iC-Wkp95MSpjuranJirC5bS-mfl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAwNCBTYWx0ZWRfXxnU/b0bCLZIK
 ScFWe8a/hXAhHythf6ydoOVtlBKGh5MfgNeFDZ8Qy/boPeEA2ODytEbCBhPakqYTzGNpAcOREfe
 oNWUU8ayNDYziIUMWDugREeL+aGdRZUufFefQJXxpJmAAKB5anzMRr0WdfTKqQ7prMR0N9dty2W
 X1WjdcU3zwRKtaouNWcsdpS7y5OpuFiKN8vjQQKk8l6BEssiEejtB+Jp3amhVf4di18t3aJVT31
 jpFPf0JI09cuCIZXmvr46lhgxUWYWPFZAMotEcj2Uhe+eghNzOkBdHvIAsEV12Ge5Hb6yhYVaEZ
 34JfmMRLQPb0MC3pBwvmJ0/eyVjNxLceJW5FUDr+JF0Lj190HSrHKWc+uwoRQSvB5s59agTUkGB
 WbbYu7REsJKeVc1vUaAvcegrdPwvmA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040004

On 9/30/25 7:48 AM, Akhil P Oommen wrote:
> A8x is the next generation of Adreno GPUs, featuring a significant
> hardware design change. A major update to the design is the introduction
> of Slice architecture. Slices are sort of mini-GPUs within the GPU which
> are more independent in processing Graphics and compute workloads. Also,
> in addition to the BV and BR pipe we saw in A7x, CP has more concurrency
> with additional pipes.
> 
> From a software interface perspective, these changes have a significant
> impact on the KMD side. First, the GPU register space has been extensively
> reorganized. Second, to avoid  a register space explosion caused by the
> new slice architecture and additional pipes, many registers are now
> virtualized, instead of duplicated as in A7x. KMD must configure an
> aperture register with the appropriate slice and pipe ID before accessing
> these virtualized registers.
> 
> This patch adds only a skeleton support for the A8x family. An A8x GPU
> support will be added in an upcoming patch.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

[...]

> +static void a8xx_aperture_slice_set(struct msm_gpu *gpu, enum adreno_pipe pipe, u32 slice)
> +{
> +	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
> +	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
> +	u32 val;
> +
> +	val = A8XX_CP_APERTURE_CNTL_HOST_PIPEID(pipe) | A8XX_CP_APERTURE_CNTL_HOST_SLICEID(slice);
> +
> +	if (a6xx_gpu->cached_aperture == val)
> +		return;
> +
> +	gpu_write(gpu, REG_A8XX_CP_APERTURE_CNTL_HOST, val);

unless the effect is instantenous, this needs a readback

[...]

> +static u32 a8xx_get_first_slice(struct a6xx_gpu *a6xx_gpu)
> +{
> +	return ffs(a6xx_gpu->slice_mask) - 1;
> +}

#define instead?

Perhaps also move it closer to the user


> +static void a8xx_set_ubwc_config(struct msm_gpu *gpu)

You modified a6xx_calc_ubwc_config() earlier in the patch

is one of them unnecessary?

[...]

> +static int a8xx_zap_shader_init(struct msm_gpu *gpu)

You can borrow this from a6xx_gpu

Perhaps moving such common functions to a separate file would be
even better, I glanced over the change and there is probably some
potential to commonize

Konrad
