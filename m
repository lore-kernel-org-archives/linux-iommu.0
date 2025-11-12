Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCCF2F39D4
	for <iommu@lists.linux.dev>; Wed, 12 Nov 2025 10:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762943856; cv=none; b=gaJMtc4nFacI/S8wHjoVYk1zhMMtOFrUOZHAFnpeaPK2fSUuBNTFUFwyrmSJxTOzjbk/HOtV20OpWhRIvqpOIpUTwh7vISXS2X6NWEEFdLzuUnnLD7mTLSfRxQoyCI/tAGw8ms1eXoTj52Z0PuQiaJc9eYjkVvNMdfZ7PoLMU5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762943856; c=relaxed/simple;
	bh=dx6zm7iYDFsu+uW4HxvS1RA6sCHD+I68rch7mq06/pw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UmYwPtMtWDSbN5heU+To8YR332r3V+sI9T2cw0WqHVSpDuwUsYytRJiUajNsB5oaWJT5ZzLr6zqJjc3O1UDiQWWa+uHRUrejzGQfb4SZ7g3SQlUljxTnM7KEVCN2UuqtjsNzYZe271KV2QIIcJi9ZWktn14SIQdkQDxU5QIiGbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=p0Oz30K3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Hs7YgN8+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="p0Oz30K3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Hs7YgN8+"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AC9csAP4077274
	for <iommu@lists.linux.dev>; Wed, 12 Nov 2025 10:37:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yEvEVaysBiDJvqu7zSpO/ven4wuPjiUA9FzLjPjO1Lk=; b=p0Oz30K3ZkEWwuzp
	iqiim70ICP+vQQno+zYJnXP3FiLNW/NqOujPtIY2anc++sqN5gaDBPycS0NGFyFX
	dpaoAHlUUwgvFGRmEFlte6Q8mA+lKrD9UJkcg1RWWZA4pZpilpZt69WCHX9kZaoz
	3iG3mxKT/mv/TWO1givhucRFRitwKYp92KbL6yeP7RnsGST1HSYK6DeJ8D2z78pf
	fLH8OFRFwugXCRlNnTYSgmUaLMsZMHKuIBbKB7GCEQEYfqshTC+LviPVOOA7SKdX
	CXobtf7q7JlojXQJW4Mn8oAhLcQ+baKjrmDIsLWcCpZC6lJXo78vrDERvDKQ13HS
	/bV64Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acguahgu3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 12 Nov 2025 10:37:33 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8b25c5dc2c3so20175285a.3
        for <iommu@lists.linux.dev>; Wed, 12 Nov 2025 02:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762943852; x=1763548652; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yEvEVaysBiDJvqu7zSpO/ven4wuPjiUA9FzLjPjO1Lk=;
        b=Hs7YgN8+4GqBAEzqq09zcQXV2Y77pCdFIT1ezyqsIUiVdoxuJGr7OUTcMk4ZNYg47T
         MC1Zdm6VDa7CS5UMfPUwV7Ekqj1km7jOxoxzOeqVeKq/m/Y5InHRVGUclW94iqDMS6wY
         qFB1Gq+aP3Ozo3IJp/sE+uOnLzqnqgCyNKVWa80e4RcZXCy1vtBiB0BfSIpJlDMvHb1i
         EH/6pA73exXZ6BThJiP6in5w9QJClBRPi241bZPhLsQyo8lsA3h4lS6rmv2IVxY7R0l1
         m4VG5Y1FGEuCFBHILVuHXbqkTA/v90CAJNbKlFfgsnCyx5q2L46htivtx3VbIKLVQt6o
         WfTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762943852; x=1763548652;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yEvEVaysBiDJvqu7zSpO/ven4wuPjiUA9FzLjPjO1Lk=;
        b=gyoWCFL3mNSStdr0W3GYmask+Q1WL3y/u/9aBmeluk9X2HXvcos5C9cTvtZjpS48De
         09VRM87rNXdS65OqV3qIVFY574QHo+hfTY2SwDX/6k2Z7n5rB4V1T6R+N4LQjxlMMR4m
         3q3FOL8kDPy7HkXSCoxbnkc3C7blZY2akYdEnTVWZL0y4ZOESuwEe/Ej6JCNwPhafSh+
         69++LtjDVgFRF8WLrX4eWHO43CZEiRgs4FVjQKPMW0LeP2G9VhXXB6xvMPjCKg5D7qFn
         Ygieg0fLJb7e59clH6f4v/2RfdUJbeU6sTOcKVckah0Hcwdk9i+2tH4QRhhdJNZinBKj
         0KNw==
X-Forwarded-Encrypted: i=1; AJvYcCUvvtSU/Z3OIl9vLDbOn2OFA+97J3NedQeiJIc6cxzy4CP/Srv4DpyZB2J3FtX+XJaEu9JiIw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyeHJhGf9+3B+tvD3toR844QTh+hrnOyBQQd607+ltEVRXbqokO
	h6+dNd4gOzN99zNvEjcX34TOxH5y5foR2lyFeMxTrEK9xYmGNU5eQb49eOfsKv2j1pZ2KWD+bx0
	5CXLFTym13yTr7pKBoGN3W36zltTUiwgLSSO8opKbw0KM2edzMt6W+wcfwQ==
X-Gm-Gg: ASbGncuKUPdonSRQACBDhpodYUgDVBPwXyUH+equRMLDauqCmHUYWDU3D3SLP/zqWZH
	Mq8Giv3vQ19B8iVCPm1Tz1OtgcnuWnCO8A09Wu1nmYZVOvi1SZUMfCw6SgcoZFFx16Qz4qHd2jB
	IZ1Nnu7SMV3uYc7BQLMvZZuHQxqAIn5QrUpmvs2qz5iWXLYtEuhKlfL4D6RsvNpYK9+9Wf2Gy49
	lC5OuOdQdcYBvJXHWa8zym78e6GollgDKxELuQMDbXcsALKMNzZyNxp9XyFKPGdz4jCbRVWS12D
	nv64p/hEIOf0xJUV+fcfV0yRPwXNZ8ars1Yyz/a2+6Xzk+KvM6qyHMu5qBuOX5O+daa7mGnPqH9
	99rwE4tY092fIvguuAfJPD8mdO9/iYa0VJtKdJbgPmOSz8o7/+/++6lFX
X-Received: by 2002:a05:620a:c44:b0:8a2:eb35:8df9 with SMTP id af79cd13be357-8b29b96bfacmr174328485a.11.1762943852360;
        Wed, 12 Nov 2025 02:37:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHnodYPH8G4uSHNNb8nQWE1cE1kx1PmZfPb6CE/gBIDzIV9Um7jRFbvxAfRziignE7KgxTdXA==
X-Received: by 2002:a05:620a:c44:b0:8a2:eb35:8df9 with SMTP id af79cd13be357-8b29b96bfacmr174327385a.11.1762943851866;
        Wed, 12 Nov 2025 02:37:31 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bfa0f37csm1559184066b.64.2025.11.12.02.37.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 02:37:31 -0800 (PST)
Message-ID: <ae21a963-696a-48f3-af91-ee72aef4b60d@oss.qualcomm.com>
Date: Wed, 12 Nov 2025 11:37:27 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/21] drm/msm/adreno: Do CX GBIF config before GMU
 start
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
 <20251110-kaana-gpu-support-v2-16-bef18acd5e94@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251110-kaana-gpu-support-v2-16-bef18acd5e94@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: GOZZQALLsTPPNZVApxFzhYUvr3F8eIm1
X-Authority-Analysis: v=2.4 cv=ao2/yCZV c=1 sm=1 tr=0 ts=6914636d cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=XltbfQAJAwjtl7jyp1EA:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: GOZZQALLsTPPNZVApxFzhYUvr3F8eIm1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDA4NSBTYWx0ZWRfX67NcWWjKbpo+
 Hr4ZSB+h1NOQVVsQsGvB+Ki9svan2UoD1OCaaBvEIVK5zg2I9wEsTWxqdY3TiAh0WIRF/+gVlkR
 reNR+ljfJ3ZA1YplCUW6Ce5ftYfpv1e2tFQyUzbxtH4y7CgDY6g/9Z4lHC0JBidyHT32JC5LcXB
 Zls5U5JnYRot4FEzt0kUNaYl0Cvs7igQdN2hxbjDLQomi0q1W7HdfA8V9Q+EVX+3zhc7krw9Eci
 3a2j8/kzjfTdSL1cxyioM95OvVucfXxIsXKDZ9g8Oxm0I3sNBuL5h/dl1hih9ytwwiihXUOjBwz
 BjpkKfDVO06Mt8rJrMGWdxjJjFDKqhNcav9V3lGKuttBO1NA8OjYHj0jxnKJ4MTmim7sMNnPsfK
 HWVwGqIVS+RucSd+/yd6kD52+X9i6A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_03,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 phishscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120085

On 11/10/25 5:37 PM, Akhil P Oommen wrote:
> GMU lies on the CX domain and accesses CX GBIF. So do CX GBIF
> configurations before GMU wakes up. This was not a problem so far, but
> A840 GPU is very sensitive to this requirement. Also, move these
> registers to the catalog.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

[...]

> +	/* For A7x and newer, do the CX GBIF configurations before GMU wake up */
> +	for (int i = 0; (gbif_cx && gbif_cx[i].offset); i++)
> +		gpu_write(gpu, gbif_cx[i].offset, gbif_cx[i].value);

We haven't been doing this a lot in the GPU driver, but adding a
.num_entries-like field is both more memory efficient and less error-prone

> +
> +	/* For A7x and newer, do the CX GBIF configurations before GMU wake up */

duplicate comment

> +	if (adreno_is_a8xx(adreno_gpu)) {
> +		gpu_write(gpu, REG_A8XX_GBIF_CX_CONFIG, 0x20023000);
> +		gmu_write(gmu, REG_A6XX_GMU_MRC_GBIF_QOS_CTRL, 0x33);

Either set this prio value here, or in a8xx_gpu.c

> +	}
> +
>  	/* Set up the lowest idle level on the GMU */
>  	a6xx_gmu_power_config(gmu);
>  
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index 029f7bd25baf..66771958edb2 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -1265,17 +1265,20 @@ static int hw_init(struct msm_gpu *gpu)
>  	/* enable hardware clockgating */
>  	a6xx_set_hwcg(gpu, true);
>  
> -	/* VBIF/GBIF start*/
> -	if (adreno_is_a610_family(adreno_gpu) ||
> -	    adreno_is_a640_family(adreno_gpu) ||
> -	    adreno_is_a650_family(adreno_gpu) ||
> -	    adreno_is_a7xx(adreno_gpu)) {
> +	/* For gmuwrapper implementations, do the VBIF/GBIF CX configuration here */
> +	if (adreno_is_a610_family(adreno_gpu)) {
>  		gpu_write(gpu, REG_A6XX_GBIF_QSB_SIDE0, 0x00071620);

a640/650 family GPUs didn't receive a .gbif_cx addition in the catalog to match

>  		gpu_write(gpu, REG_A6XX_GBIF_QSB_SIDE1, 0x00071620);
>  		gpu_write(gpu, REG_A6XX_GBIF_QSB_SIDE2, 0x00071620);
>  		gpu_write(gpu, REG_A6XX_GBIF_QSB_SIDE3, 0x00071620);
> -		gpu_write(gpu, REG_A6XX_RBBM_GBIF_CLIENT_QOS_CNTL,
> -			  adreno_is_a7xx(adreno_gpu) ? 0x2120212 : 0x3);
> +	}
> +
> +	if (adreno_is_a610_family(adreno_gpu) ||
> +	    adreno_is_a640_family(adreno_gpu) ||
> +	    adreno_is_a650_family(adreno_gpu)) {
> +		gpu_write(gpu, REG_A6XX_RBBM_GBIF_CLIENT_QOS_CNTL, 0x3);
> +	} else if (adreno_is_a7xx(adreno_gpu)) {
> +		gpu_write(gpu, REG_A6XX_RBBM_GBIF_CLIENT_QOS_CNTL, 0x2120212);
>  	} else {
>  		gpu_write(gpu, REG_A6XX_RBBM_VBIF_CLIENT_QOS_CNTL, 0x3);

Downstream seems to set QOS_CNTL at the same time as QSB_SIDEn for
these targets


>  	}
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
> index 031ca0e4b689..cf700f7de09b 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
> @@ -46,6 +46,7 @@ struct a6xx_info {
>  	const struct adreno_protect *protect;
>  	const struct adreno_reglist_list *pwrup_reglist;
>  	const struct adreno_reglist_list *ifpc_reglist;
> +	const struct adreno_reglist *gbif_cx;
>  	const struct adreno_reglist_pipe *nonctxt_reglist;
>  	u32 gmu_chipid;
>  	u32 gmu_cgc_mode;
> diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> index 2ef69161f1d0..ad140b0d641d 100644
> --- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
> @@ -500,6 +500,9 @@ static int hw_init(struct msm_gpu *gpu)
>  
>  	gpu_write(gpu, REG_A6XX_RBBM_SECVID_TSB_CNTL, 0);
>  
> +	/* Increase priority of GMU traffic over GPU traffic */
> +	gmu_write(gmu, REG_A6XX_GMU_MRC_GBIF_QOS_CTRL, 0x33);

Kgsl (later) added this for A740 too - would it be beneficial to enable
unconditionally on gen7+?

Konrad
