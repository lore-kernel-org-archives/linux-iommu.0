Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3E9288D2
	for <iommu@lists.linux.dev>; Wed, 12 Nov 2025 14:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762959256; cv=none; b=LypavWLeD7wn/gHqs6++mSvIg7lnukg6nfpLXH6LCaLPZBWwnWI+59cJIRe9HCgd2gqHJyOoAi8u3Vhr+8nLLASYK5Ft8nj26qN6MFs3ZUmJgdVxkCUFgmbq/7v7WkvWGJhWf4tj6giJ5fxrQ7N/2ltwuOsxH/u99YFrOIupFHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762959256; c=relaxed/simple;
	bh=9JqFN+lUh03KH6OhyiZLi7QPccTtindegh7DAZCJnH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jlmKGcEtxpx9/vGKa3O69wLK53VLV5x0tfIVRuTwSFoPVXAVrE3iz8zKfVjM33R82eIeqilJZ7AoJ/RtHpvcfsOdl7FPy5kyyartNmuK5cq7sCqeu1nfpm1mfWMew33eKgtFyhnZI8pOdnaYycmlnYcdXTqcapiQ84vsVdZBcSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bmUxz52/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VvCLWr23; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bmUxz52/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VvCLWr23"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AC9fTWC721947
	for <iommu@lists.linux.dev>; Wed, 12 Nov 2025 14:54:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UD4Gbr1H+DyzPCYqHbTvNAKVexCnZ/nezzgxwkeMezY=; b=bmUxz52/Iw9SLV8Q
	cDUdlkCUELernVB3ZD4vXVxAzAyfyjHPRV4xCAJlngjnNUtOc6Byq2KNxi/tStqf
	CUjtiJ4fgX8eoTQr8IhP2KGRNEbmNq9E0TB84wQeSeq/XADx+e2QFXlfG84dcuKP
	S59yKXRaZnAY8alRrsu5X6zO7UPeoknhBNj1DtSAvUVoynzuEYF1Uho/cnPF5fpr
	8g9KVjP22Xq1igkVAhGzApngqZH3YVbgg743xPFI5G9v4SD0h47Xd6ujpigal5he
	jsAHEPMCgLDJXPhTBBNZvtId/HyXLidtmdlWv/KeeBvaA2aD2zBv3FQT65VSG2Nz
	My7pdw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acqu1rxue-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 12 Nov 2025 14:54:14 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7abb04253faso180014b3a.0
        for <iommu@lists.linux.dev>; Wed, 12 Nov 2025 06:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762959254; x=1763564054; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UD4Gbr1H+DyzPCYqHbTvNAKVexCnZ/nezzgxwkeMezY=;
        b=VvCLWr23sv0d1oPfFuEPYwXt7EdnVBZm/ncuzQ6Sl2t+lRU3c6EEEPun1EmsZJQP0G
         VwmNs6+qiE4bbWcIhp5Yl8GjfMWCmVHwfTKVqp7cYOgunAAWsOlLzPg16SypoxzV2qEz
         2oJ/dOL7daMkI5naS6Mli8jCj7EMO7mLrzeyDTU5ACWSoITwuy0TOQqOvYVlzUUxcrtg
         y9jW646nwygUPBSbMXbSIknrXLmCrZnpxChJ2vQGGVUOKH9ar/zZwcFghjX9SDgPIbeq
         izhtgs5vRjS6292/ClCnP6Wje6rdzECtfawgkXp2UdhYo1sjpEAJhHyWpCPI6qnk3Ufy
         B48A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762959254; x=1763564054;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UD4Gbr1H+DyzPCYqHbTvNAKVexCnZ/nezzgxwkeMezY=;
        b=EIvfd2meIXvTHMAHsJHnxjUa1gytXUUcu771YiOsOAixhnfuKFbUEfAm4e5RmqnxMG
         cEEMvJznxcBZmrYlzUFgOQ7ALLjzMCzt/iDocXrc/WUz6xaFQxzMgNeev52E7PoUijPt
         grLlQsSSX0FX5Y2XUvwE6kll0kTrWCqT3+zdKA+pJXiIvy9A9gCOQXRJZe4FVuMmpDjX
         OjMu+yCS7+M/qf+WzQ2GYMzUxggM4EgU6u593y1kIOUsc4VBZ9nofy8Ou2jD8N9lHMmH
         KtY5w/VwpKFGORm2lujQhnQ1Ce+TYvNyGfSl1efY/c4tK+BwhKZbFepEIxtnc9RviQF2
         ey1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUtFlSP2aSiusmnoWTLeshbzuEBIRJnw+v1+RjfBLOmnWIC2V3I36CekuOHuIQQ5hdOfYmBHw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyESnNnLYUtgdMYhf+g5hhk4ccOCLQDJHxGAjAx7RaTqgq/xqva
	RtpSH4V0kqDYITH+B6H8ZfILrBL8k8x5O9ozHREQvNlL3v4nNfeyMWDJBxogO2aJF1f91o1VKKd
	9o4XB9BafMlDcElhPRZOfoNRwgiB6RhZ5nA0cb9aBWeHS3SBuwdD4T4WBAA==
X-Gm-Gg: ASbGncvIM8ZmG0INeSNbk485k/iytw0vSu2WoZDA8aOkUogsW5Mlu/0Tx3EMNOHRhVu
	0WkfG6nrNqv3wdyH1sBHO5ezz21mjHuJTNI1CWaP+6Vo6hwfQHU7ZNYFeRm/Ea0OvN4zIUH3Uih
	rhr2T3mY5T5fHzJxl/5jhuXiv++sRySSssW3dLxvVLq+XydR5HMBKJwXtebmp0rhT9ymmHSEStx
	6hFNxphqcc7T5dD8OF2nlSp4q98vl4avKPPyXfT86FsG3U4JKW9DPOBdZAiNzsS33l0jm9OlA99
	nWnxuGMevpavtKkux3fnQcjtNXpyJ04G0xU3d2RlE2TlRIj/06eVaugQQ1dD3y2jNjsdMIL9SmT
	ndJgiKFqzOLWX0GeQB4Z+fxzbMz0VvogKPH3q0iAfdyFIk6XYwvUy+wMZ
X-Received: by 2002:a05:622a:728c:b0:4ed:e2dc:dae4 with SMTP id d75a77b69052e-4ede2dceb1emr8250791cf.0.1762958473432;
        Wed, 12 Nov 2025 06:41:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGXNVu4MbvjBQmXxL3FDdcuNjCm2cJCAQ1jZODPaFYu8y34KljTh9u/VDha9brFuHl1b+1Ffg==
X-Received: by 2002:a05:622a:728c:b0:4ed:e2dc:dae4 with SMTP id d75a77b69052e-4ede2dceb1emr8250331cf.0.1762958472880;
        Wed, 12 Nov 2025 06:41:12 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64169852018sm9952464a12.16.2025.11.12.06.41.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 06:41:12 -0800 (PST)
Message-ID: <f9aafd73-fe4a-4399-a0c8-0da1c109283a@oss.qualcomm.com>
Date: Wed, 12 Nov 2025 15:41:08 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/21] drm/msm/a8xx: Add support for Adreno X2-85 GPU
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
 <20251110-kaana-gpu-support-v2-17-bef18acd5e94@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251110-kaana-gpu-support-v2-17-bef18acd5e94@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: yeaDkEktbrPIXLdQw7Zar7CDjYROaBkq
X-Authority-Analysis: v=2.4 cv=Hpl72kTS c=1 sm=1 tr=0 ts=69149f96 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=BrXyDZ9iCYK2Fy0JuVIA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: yeaDkEktbrPIXLdQw7Zar7CDjYROaBkq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDEyMCBTYWx0ZWRfX86N10GEPnUCc
 5/WGCSy7AWjVowcsg8e9jjDklFTH4a7WUKl+MQljoeSS6J6pZxixrnyyZnWF7WK5ijY6ZBFP6co
 BgpWA49e29Qh0raH1JIp81sy4AZ8CvC9XRYuDe/fdNVlxFpZ2W8jDlv7FwGD5oVVn38iRDMQaI1
 Adj+cXQm6qEeV69huvrdtevWpgVod13NkZL/0yQ5jPbHY6aUOjUuEttmb0cxSP8gE0gW2JdATko
 f5uI+8MT66HCV+DZIMreWHY7D3P7XyX3hmw4hxLaHpx+p25ZfSIeL1si7kpHR1Ueclb3vR3eopH
 k0Ruzjqov2eiwzKt1Q6hk7/6FLg3Vc/BURD6hvnN3bxHDgulBSwTcJ/w820ukm++j9C+Mw+RBEu
 paK0aoVt4A1/c8Z9xAVQE2ofu76ZAg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_04,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120120

On 11/10/25 5:37 PM, Akhil P Oommen wrote:
> Adreno X2-85 GPU is found in the next generation of Qualcomm's compute
> series chipset called Snapdragon X2 Elite (a.k.a Glymur). It is based
> on the new A8x slice architecture and features up to 4 slices. Due to
> the wider 12 channel DDR support, there is higher DDR bandwidth available
> than previous generation to improve performance.
> 
> Add a new entry in the catalog along with the necessary register
> configurations to enable support for it.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

[...]

>  drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 131 ++++++++++++++++++++++++++++++
>  drivers/gpu/drm/msm/adreno/a8xx_gpu.c     |   3 +
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h   |   5 ++
>  3 files changed, 139 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> index fa3ae725f389..2e5b0573c212 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> @@ -1625,6 +1625,108 @@ static const struct adreno_info a7xx_gpus[] = {
>  };
>  DECLARE_ADRENO_GPULIST(a7xx);
>  
> +static const struct adreno_reglist_pipe x285_nonctxt_regs[] = {

It's certainly not the same silicon, but a830 sets a bunch more regs
here and has a lot more comments in kgsl. Could you check if any of
these settings are required/beneficial?


> +static const u32 x285_protect_regs[] = {
> +	A6XX_PROTECT_RDONLY(0x00008, 0x039b),

In case anyone asks, there are simply no registers before 0x8<<2

> +	A6XX_PROTECT_RDONLY(0x003b4, 0x008b),
> +	A6XX_PROTECT_NORDWR(0x00440, 0x001f),
> +	A6XX_PROTECT_RDONLY(0x00580, 0x005f),
> +	A6XX_PROTECT_NORDWR(0x005e0, 0x011f),
> +	A6XX_PROTECT_RDONLY(0x0074a, 0x0005),
> +	A6XX_PROTECT_RDONLY(0x00759, 0x0026),
> +	A6XX_PROTECT_RDONLY(0x00789, 0x0000),
> +	A6XX_PROTECT_RDONLY(0x0078c, 0x0013),
> +	A6XX_PROTECT_NORDWR(0x00800, 0x0029),
> +	A6XX_PROTECT_NORDWR(0x0082c, 0x0000),
> +	A6XX_PROTECT_NORDWR(0x00837, 0x00af),
> +	A6XX_PROTECT_RDONLY(0x008e7, 0x00c9),
> +	A6XX_PROTECT_NORDWR(0x008ec, 0x00c3),
> +	A6XX_PROTECT_NORDWR(0x009b1, 0x0250),
> +	A6XX_PROTECT_RDONLY(0x00ce0, 0x0001),
> +	A6XX_PROTECT_RDONLY(0x00df0, 0x0000),
> +	A6XX_PROTECT_NORDWR(0x00df1, 0x0000),
> +	A6XX_PROTECT_NORDWR(0x00e01, 0x0000),
> +	A6XX_PROTECT_NORDWR(0x00e03, 0x1fff),
> +	A6XX_PROTECT_NORDWR(0x03c00, 0x00c5),
> +	A6XX_PROTECT_RDONLY(0x03cc6, 0x0039),

830 has start=0x03cc6 len=0x1fff but that must be a bug unless a lot of
registers have shifted from there.. I see there's perf counters so perhaps
perfetto-proofing?

> +	A6XX_PROTECT_NORDWR(0x03d00, 0x1fff),
> +	A6XX_PROTECT_NORDWR(0x08600, 0x01ff),
> +	A6XX_PROTECT_NORDWR(0x08e00, 0x00ff),
> +	A6XX_PROTECT_RDONLY(0x08f00, 0x0000),
> +	A6XX_PROTECT_NORDWR(0x08f01, 0x01be),
> +	A6XX_PROTECT_NORDWR(0x09600, 0x01ff),
> +	A6XX_PROTECT_RDONLY(0x0981a, 0x02e5),
> +	A6XX_PROTECT_NORDWR(0x09e00, 0x01ff),
> +	A6XX_PROTECT_NORDWR(0x0a600, 0x01ff),
> +	A6XX_PROTECT_NORDWR(0x0a82e, 0x0000),
> +	A6XX_PROTECT_NORDWR(0x0ae00, 0x0006),

830 has len=4 here, with len=6 you can't write to GEN8_SP_NC_MODE_CNTL_2
which I think may be useful for UMD

> +	A6XX_PROTECT_NORDWR(0x0ae08, 0x0006),
> +	A6XX_PROTECT_NORDWR(0x0ae10, 0x00bf),
> +	A6XX_PROTECT_RDONLY(0x0aed0, 0x002f),
> +	A6XX_PROTECT_NORDWR(0x0af00, 0x027f),
> +	A6XX_PROTECT_NORDWR(0x0b600, 0x1fff),

This carveout differs slightly vs 830 but I think that's mandated

> +	A6XX_PROTECT_NORDWR(0x0dc00, 0x1fff),
> +	A6XX_PROTECT_RDONLY(0x0fc00, 0x1fff),
> +	A6XX_PROTECT_NORDWR(0x18400, 0x003f),
> +	A6XX_PROTECT_RDONLY(0x18440, 0x013f),
> +	A6XX_PROTECT_NORDWR(0x18580, 0x1fff),
> +	A6XX_PROTECT_NORDWR(0x1b400, 0x1fff),
> +	A6XX_PROTECT_NORDWR(0x1f400, 0x0477),
> +	A6XX_PROTECT_RDONLY(0x1f878, 0x0507),

This differs vs a830 but it's kgsl that has a harmless? logic bug:

{ GEN8_CP_PROTECT_REG_GLOBAL + 40, 0x1f400, 0x1f877, 1 },
{ GEN8_CP_PROTECT_REG_GLOBAL + 41, 0x1f878, 0x1ffff, 0 },
{ GEN8_CP_PROTECT_REG_GLOBAL + 42, 0x1f930, 0x1fc59, 1 },

(0x1f930 is overwritten)

> +	A6XX_PROTECT_NORDWR(0x1f930, 0x0329),
> +	A6XX_PROTECT_NORDWR(0x1fd80, 0x1fff),
> +	A6XX_PROTECT_NORDWR(0x27800, 0x007f),
> +	A6XX_PROTECT_RDONLY(0x27880, 0x0385),
> +	A6XX_PROTECT_NORDWR(0x27882, 0x000a),

These 2 seem to have been changed vs 830 for counters (all good)

> +	A6XX_PROTECT_NORDWR(0x27c06, 0x0000),
> +};
> +
> +DECLARE_ADRENO_PROTECT(x285_protect, 64);
> +
>  static const uint32_t a840_pwrup_reglist_regs[] = {
>  	REG_A7XX_SP_HLSQ_TIMEOUT_THRESHOLD_DP,
>  	REG_A7XX_SP_READ_SEL,
> @@ -1809,6 +1911,35 @@ static const struct adreno_reglist a840_gbif[] = {
>  
>  static const struct adreno_info a8xx_gpus[] = {
>  	{
> +		.chip_ids = ADRENO_CHIP_IDS(0x44070041),
> +		.family = ADRENO_8XX_GEN1,
> +		.fw = {
> +			[ADRENO_FW_SQE] = "gen80100_sqe.fw",
> +			[ADRENO_FW_GMU] = "gen80100_gmu.bin",
> +		},
> +		.gmem = 21 * SZ_1M,
> +		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
> +		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
> +			  ADRENO_QUIRK_HAS_HW_APRIV,

No preemption and IFPC - I supopose the smart thing to do before we
know things are stable

> +		.funcs = &a8xx_gpu_funcs,
> +		.a6xx = &(const struct a6xx_info) {
> +			.protect = &x285_protect,
> +			.nonctxt_reglist = x285_nonctxt_regs,
> +			.gbif_cx = a840_gbif,
> +			.gmu_chipid = 0x8010100,

Is this the chip id for the final revision silicon?

[...]

> diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> index ad140b0d641d..d283d0b55623 100644
> --- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> @@ -175,6 +175,9 @@ static void a8xx_set_hwcg(struct msm_gpu *gpu, bool state)
>  	struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
>  	u32 val;
>  
> +	if (adreno_is_x285(adreno_gpu))
> +		gpu_write(gpu, REG_A8XX_RBBM_CGC_0_PC, 0x00000702);

kgsl sets this only when turning on hwcg (bool state in this func) and
on a830 family - should we turn this into an A8XX_GEN1 check?

Konrad
