Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27ED2347C5
	for <iommu@lists.linux.dev>; Sun,  5 Jul 2026 12:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783253306; cv=none; b=kMRrk33Ui82h9ECle8r6PQLqxLkz7B0QNLdi9w7YDWqLesvsg/+SZxlA2x42piSNtajooVuQYbsPpFYFqxmaDNTJ951sJE7aKUTcE21jJyVq/ELHsHIOEsjYzxeIq9W6a2Fjpq7mU4CBWxHKqN1GrQvwoa7QJxlp8aYxyXOtPL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783253306; c=relaxed/simple;
	bh=vS+gozlH8xzLoSrlTu45N+1Z/TIoHqnGVzFjee+S87M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KhY3jyyRMeayey5Gsadu8CNcItcDUJmeA6T5wsNz5w6LV3qU1IWoaQgrVusxMm+NJ4pVcEUVlRK3oujosLmPGwudDlasPHBKRX3urOXndNV/GK9Csb4WXs6M7por2ByQVLz/CYNPqt5rKvs1O5HoJRAxt8/SioLlxYjO7sXkuUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P8gyfHdU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JU81VQD6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P8gyfHdU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JU81VQD6"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6650q8Ul297726
	for <iommu@lists.linux.dev>; Sun, 5 Jul 2026 12:08:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZN8p8GVvhL0vSLM98/0aC/exCQwg55pHhJkfI+byc3Y=; b=P8gyfHdUAKSYbw5F
	ebPDrmUaIX13Jvn7JpP3n+q2E1UyjZJPvFp1eFAxNT5r9u5//qLxaHYmrmLHJ1QB
	rU6mbCndxiBnsUpoWGzNIxON+uFnzuEJjJiR/vblAOxOhgzg421bfw+xBSUNyN3v
	dECLnkLM9iGPoO0cjONObMCUB3R1zLv5WEXtgnGlOfImdbX24ZtX/2OEsrFZ+s+V
	0hlfG17GbXz4VT/5JNWGKdSV3kvOrYRizXR81CsilZXcgfVSVbmI6i+0VBalQQ7B
	owMYY3wAmNW4t7tV1dMLajYQtYISi2YPKOpvUZGFHG2ONseW1h4n4GVRtwvOiLx1
	D0HV1Q==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6td3am9m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 05 Jul 2026 12:08:24 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c9c26587e67so1881666a12.0
        for <iommu@lists.linux.dev>; Sun, 05 Jul 2026 05:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783253304; x=1783858104; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZN8p8GVvhL0vSLM98/0aC/exCQwg55pHhJkfI+byc3Y=;
        b=JU81VQD65QowuWv29BhuC/Bv3ZIwVzrPt96oxZLD9Yy09ZBkbQChig93vCG+xvRXJr
         Zc3u2ZqFKy3XitcVMpd1YQ/mI5Gb92Vrzk8vNMiqz8RQyzOpaAVrosnCdLbtPiUiIW3E
         jXxpXxddl53Xyn74gw1SSZP8ji1fLB8XwQKpcmBF6w3bgPp28GyesD/ZTgd8Prl3qf2D
         e7wXPUxZLfIWwMaXOLnpCzb1rjBqebtbn3ls7y6bVWxoN6zt5G5h6oWcirdjUpDvnSzJ
         gkXEqHAIH80dkMrwszh0qrwH5OOHpPkrP5dNqX5EZmhAuKz4O/xrI/9BMxa//m0sAH7l
         KFhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783253304; x=1783858104;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZN8p8GVvhL0vSLM98/0aC/exCQwg55pHhJkfI+byc3Y=;
        b=N+7mi2LNn2IDNl38Fwi1w3qr3refF99gx3tptJ0mpUB/zWDPPu6nZG+Hsdz3g1bkta
         G3rKlp1YYCjicJhoiOpjeJLjPXkMHJOKlLTgHHZx8PI0R5rmPQgnP97wE4QZ3iX2TapK
         cIYyiDODI7U/u1Dp5CIdh4M4/oJ22q003LgDJG6DGVaqDIAK2V76BLycVv44hcnVsea6
         jK8g3sAlmYwPIPg/5MKNXhSutREZ3+g9Mt0uZmU/afUqRVHSNBzd7dB7baJ5fniRxGRe
         N8wFW8ZzH83pUiwX1hkOcIR+Wcaszbnd08jCVrUBMn0gY2TnQYYtUo97zDrd1oXCRDm/
         m1ng==
X-Forwarded-Encrypted: i=1; AHgh+RpJW2w326Yvloz/Hx1vxw4YBR8VAGfVLIeyWscjw6p7PFMi3g22oupak0Fv78y4CLwYyzxIsw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxl+rChU4vhIZOYx/CMyPyJ51XIlEdzAL4l/uOQHcMPwEbUTm4L
	Hw2tP8XF8p4Qo6+P9fVJOdlPdO0u4f0PRyzHLkYR4Dq3WzQrHe261n6LqdqrNLML61DWdg2NZns
	HR1aUeUDYSxSCUymN+jMNcVWs0vgfB+i2McBaoeOFBIay4Tt3Lp7ZRv68vA==
X-Gm-Gg: AfdE7clMQ3VcHqY9Jd5F+Qk/YxWpvVsyPPla7s6j+u/4Q/3Wp+Zao0ocW1DxSth0xsH
	Afgrusf4m7XStj/EykLwutgVQ3o0eXZlCuLvRyF2QiIKp2YA7yanStXzilQ1oG07UGVPdwkq++m
	oumrZb6oFSPXdj6Optw4Z/usaxm7L29lGthmhzQI+94g8bvlgfQwzMG94T9KLF+jzzsTwMF7DkF
	LA4/4J6+TGZ50KeN0wVr8+gfwZs/nyEsU0C7SMEgsq/g8pHViAMv/dVdv1Hf321ftjHg+Kwm4Wn
	gGEsskpjOQQdG9wDCuV6IhRoXgh3sfxWA4jZFzDtEt+/420ya8xzJkQyE383BWZK1k4enZKS6mP
	rHgvqCzn2aZR/+ELp3LZWpvuN1n5L/zJFuA==
X-Received: by 2002:a17:90a:da83:b0:380:9052:f4b9 with SMTP id 98e67ed59e1d1-381122ebe5amr11701440a91.11.1783253303549;
        Sun, 05 Jul 2026 05:08:23 -0700 (PDT)
X-Received: by 2002:a17:90a:da83:b0:380:9052:f4b9 with SMTP id 98e67ed59e1d1-381122ebe5amr11701402a91.11.1783253303057;
        Sun, 05 Jul 2026 05:08:23 -0700 (PDT)
Received: from [192.168.1.8] ([106.222.234.78])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31151fff32fsm6354185eec.21.2026.07.05.05.08.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jul 2026 05:08:22 -0700 (PDT)
Message-ID: <81c657b0-7e61-4db3-b72c-46c213c707e9@oss.qualcomm.com>
Date: Sun, 5 Jul 2026 17:38:13 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] drm/msm/a6xx: Increase HFI GX perf level limit to
 24
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov
 <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Sean Paul <sean@poorly.run>, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20260705-kaana-gpu-dt-v2-0-6ac53de56314@oss.qualcomm.com>
 <20260705-kaana-gpu-dt-v2-1-6ac53de56314@oss.qualcomm.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260705-kaana-gpu-dt-v2-1-6ac53de56314@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDEyNyBTYWx0ZWRfX3juPX0UKJWRl
 qBWUY4uBdrx0s79KzW/Kzi5Cm4M6hS2MinDjefL3KXYty8PQNvGoi597tbaJQC5V07jqT849LjP
 PSgaXCLeCk5G/oAYXev0v7RJcc7+Fmk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDEyNyBTYWx0ZWRfXyX4gsMnQiEIF
 Cnax/iT8bdw83iefuLBaT0o1g1tnGaxVEXqnLyuzW1J6yNawizRgxV7IJMcuxQbTELDRSOX5Ybk
 quxSniztzCRh8ROaudmnfdmHGslsvIMr1kuG6Zi0Y+352JT+DzZGHn1Em7zg3iLTjXQaZcHDZcy
 0crg73ofWtiByBh0Sfb2mapiRb9dtuUW3Bn9YQQSZeTsKPO7DAuF0FH50HXGvVNwCg6sOiiva50
 Ih80zPl4BLXyAHD6A6LwyB0Vog7aE2ufFgpdADb4gGF0apVRrwdrg3KL/HR2zQDoEkjSfMe40DG
 551cFCdAp8GNQCjTzEMjxCjr3padhRF6exxBEWJJjnpAzNNCOTc98+nZEQnwm9z/igENqyaeq+X
 mh+f9+FQNubUcmhor7nW+tuaCcH9E7l3bFkJ+24Qw9nkCujtpQ1NZwKZr/iqVQidJT7Q41FbK4g
 fsJ9S2I+GxcQ2TTQykw==
X-Proofpoint-GUID: mdUfQcwqAIjs8H0ge6HDa7iiZQYNxiPo
X-Proofpoint-ORIG-GUID: mdUfQcwqAIjs8H0ge6HDa7iiZQYNxiPo
X-Authority-Analysis: v=2.4 cv=b9GCJNGx c=1 sm=1 tr=0 ts=6a4a4938 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=b2dfFiZiitoj8S2i2yzycg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=PFfvJpCOjzcRVZi79uIA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050127

On 7/5/2026 1:30 PM, Akhil P Oommen wrote:
> Newer Adreno GPUs expose more than 16 GX frequency levels. Introduce
> HFI_MAX_GX_LEVELS and use it to size the perf-table and bandwidth-table
> GX vote arrays, and to derive GMU_MAX_GX_FREQS, so these levels are not
> truncated.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.h | 2 +-
>  drivers/gpu/drm/msm/adreno/a6xx_hfi.h | 7 ++++---
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
> index 3f96b10b5f61..62e3fb230cd3 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
> @@ -20,7 +20,7 @@ struct a6xx_gmu_bo {
>  	u64 iova;
>  };
>  
> -#define GMU_MAX_GX_FREQS	32
> +#define GMU_MAX_GX_FREQS	HFI_MAX_GX_LEVELS
>  #define GMU_MAX_CX_FREQS	6
>  #define GMU_MAX_BCMS		3
>  
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_hfi.h b/drivers/gpu/drm/msm/adreno/a6xx_hfi.h
> index e10d32ce93e0..f4da73a555c6 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_hfi.h
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_hfi.h
> @@ -5,6 +5,7 @@
>  #define _A6XX_HFI_H_
>  
>  #define HFI_MAX_QUEUES 3
> +#define HFI_MAX_GX_LEVELS 24
>  
>  struct a6xx_hfi_queue_table_header {
>  	u32 version;
> @@ -119,7 +120,7 @@ struct a6xx_hfi_msg_perf_table_v1 {
>  	u32 num_gpu_levels;
>  	u32 num_gmu_levels;
>  
> -	struct perf_level gx_votes[16];
> +	struct perf_level gx_votes[HFI_MAX_GX_LEVELS];

This will break older firmwares (A7x/6x). Luckily, A8x uses
HFI_TABLE_GPU_PERF interface instead of this, which is more flexible.

Will drop this patch.

-Akhil.

>  	struct perf_level cx_votes[4];
>  } __packed;
>  
> @@ -128,7 +129,7 @@ struct a6xx_hfi_msg_perf_table {
>  	u32 num_gpu_levels;
>  	u32 num_gmu_levels;
>  
> -	struct perf_gx_level gx_votes[16];
> +	struct perf_gx_level gx_votes[HFI_MAX_GX_LEVELS];
>  	struct perf_level cx_votes[4];
>  } __packed;
>  
> @@ -144,7 +145,7 @@ struct a6xx_hfi_msg_bw_table {
>  	u32 cnoc_cmds_addrs[6];
>  	u32 cnoc_cmds_data[2][6];
>  	u32 ddr_cmds_addrs[8];
> -	u32 ddr_cmds_data[16][8];
> +	u32 ddr_cmds_data[HFI_MAX_GX_LEVELS][8];
>  } __packed;
>  
>  #define HFI_H2F_MSG_TEST 5
> 

