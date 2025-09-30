Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB900222587
	for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 07:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759216204; cv=none; b=FFXI+3VTBfG7pZKLnKoPxcJlwlnXNVVVvnDEjYO6i+8VYm7uplzwM0wCBpjPap1qbg2i1tVEK+WMoSIcAC8p79wmafkwxYyYIvyD4DXt76XEfDPFd8OMABFcTQDALnhMGGIX/fG+XPvr3g4GnhFD6Gd+tEThU2z0d/Chl8q46Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759216204; c=relaxed/simple;
	bh=cKThLw0NHU6Wc+n3bczOyNlGGspAuEG7VB62WabHm6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GdkerRi15M5DB+rsRlOcAVPDe8onxPgBw4XuRpS++OKpL4SbnTOYjzgOpm4TxYqPSrv1/qe1QwHVc2wqLIZ3Pm4jYJYkKbogYD6lKp01cmS/oKOVOVc5ptSy0Pb9klVaSK6mOR4CjKsFAKo32LLZj/VnZ4MmfTvdG3306Zuqjv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kMRR12IS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kMRR12IS"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58U4HRxi026876
	for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 07:10:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=mWB5st6dCk5SY60IEgGtzAA+
	H2jR/8jDg8gNG+7YCGs=; b=kMRR12IS8enm8CrZ8x9ZiNOF+G75w47cVG7mJiT0
	4MJCbnIMoifsmQJF6Qw1/CexJ1LSiBRaQp9oqReXZnznbu9/QH112t/NEIx+Krud
	5vN+2sk+w002UwpGj8tjqEZgh/c96L4wMX3RZ8Jwj8fCSpfnC5/ZZQX7ymP00+X8
	4VWnT5zGFBv2d7SVA9PiTWaA4ENPUYV/KhGo9XBZqbAQq78ZG2h2OwQK1UaYGDUY
	NRs9rGVEq4wiN9orST9RFK3banvnqwa1y2Pdd0qgyaXPNfQhj0/Hvd+q1GVuiaCF
	TZ9wz+TV2siD6SMBEZ68Gs2AbLvGi/p1X8n25Cr184U9Kw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49fyrf1k1n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 07:10:01 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4d6a41b5b66so138768751cf.1
        for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 00:10:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759216201; x=1759821001;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mWB5st6dCk5SY60IEgGtzAA+H2jR/8jDg8gNG+7YCGs=;
        b=G6Lu1v/93RbyH+465qI2UIh8zhrVCeN6II2Y4x2beZCz1pbyrreg1zGyuJNn/+pLVV
         Q9ewo8YO4px4kDVdiI6vVxXxT8N01mpVHE1sJCStxZ/QuQ3A67tai/brMFmiAECL3jZt
         DqMng3L/YzXj770JYF2p64mf2+qIJGkKXZDJKT4JRvxPUrs7HQhtyN8812+VWIsk8wyE
         1eIYmuEV85HFAYQTR2xI7+ohB737LmLHCpV7IlmwGW0kdIpwQZkYzsv7X4ennSAxTAFO
         5G5/dMdGlyMKqZfqeKbUAHY8W8IEmUASAN2G+HFDRLwo5yZEJUm20azzCpS05Yu0Vepy
         XvqA==
X-Forwarded-Encrypted: i=1; AJvYcCUlnW9pP4MfATzH5evY7ORLtSaulGYtuUOOck3c78i74Jose295zX0hHe5vEaxgAjmq4LT13Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxoeoROC46Eh1FlLelpWI3iR9mFoZ7N2ysYjDcGBq+BtPVvO51i
	PIXxFKwFDZwXbKCwv4O1NMzcHC+RaEF1/SbYKpTFOkQPlR9ZT19OznnJWnD1DkHcKyKXYbU4H/x
	3EtJzMhzJAzVWbN9/YGt3BY8+U0RREcbbSqoruRLbsjepeXye40T2wCJuBQ==
X-Gm-Gg: ASbGncsNucFUXp04TgekzV/pwD39pa2biubvG+iPjl0LlPoQexgnEh63p+79mDzft9p
	k/sJYndxKGPJAF3UukOOvrJj4AH0ldwCm5RjAtJjCwaKUNS3GGZN/xLb0XqvsnNCZCuyE3ZEsPh
	UlHCjYcK6VvLEGdZZ6VYgYC/L54hmIBYMT97yR6/5cE5fcwAr5hSnq72MDie9pzCxx51V9Hiwe7
	cb7Ca0fQqrFHOG6taW5y7bcGCSXAJwEUM9GzAsxJAxYszh64JiMcWCNfGQsGBGJdFn8ZttAJUZL
	h7b9kNy/I2cV7CyeF2/BTr06oFDVvixaHfzqWy2CT5FMSwsmyejr5nIPuiuvGfsORXwGXSOxp6S
	Pjnpbx57v6PsgCKSkrkSRUjzM9Ob0mG7PpkZ7uGHDl7KvR+7etHpueC5niQ==
X-Received: by 2002:ac8:7d10:0:b0:4c9:3d38:1107 with SMTP id d75a77b69052e-4da4b13ee9amr205820101cf.48.1759216200608;
        Tue, 30 Sep 2025 00:10:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqfXjb8BDoz0OLkhbqOSkOjFYvwz8YqZOgVTFVVpG1nTKdQgXBzxVthwYLzYpdiitvJ/C4Vg==
X-Received: by 2002:ac8:7d10:0:b0:4c9:3d38:1107 with SMTP id d75a77b69052e-4da4b13ee9amr205819771cf.48.1759216200128;
        Tue, 30 Sep 2025 00:10:00 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-36fb7710256sm31171981fa.45.2025.09.30.00.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 00:09:59 -0700 (PDT)
Date: Tue, 30 Sep 2025 10:09:57 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH 06/17] drm/msm/adreno: Move adreno_gpu_func to catalogue
Message-ID: <cp7djnezyp4whhfqcnsfpes5kxfbyvqvc2ceimdrnrl7s7agyk@z7ozx6oihezd>
References: <20250930-kaana-gpu-support-v1-0-73530b0700ed@oss.qualcomm.com>
 <20250930-kaana-gpu-support-v1-6-73530b0700ed@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930-kaana-gpu-support-v1-6-73530b0700ed@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: AscDBRC29O6xjZcPF_6TJq2h6aV4DeTt
X-Proofpoint-GUID: AscDBRC29O6xjZcPF_6TJq2h6aV4DeTt
X-Authority-Analysis: v=2.4 cv=etzSD4pX c=1 sm=1 tr=0 ts=68db8249 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=KsGV-J2CeG6-G7wVncMA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI5MDE3NSBTYWx0ZWRfXw5E4iYjXAY14
 Bjdk2ftjxgUMipdZXd6JrMTp5GtFKRjQMF/0k1XYzAkVYLaOoUDlXCC81RimlrlERavvsGicGpM
 S8M2VdQmavIMHGxe9VjUJkCmOOxZjjMKCeFdy4EgZKS/pojSOsQW3lzApURvucm1g69j4HVZffQ
 dH29u0n1iIcxq5Ls4gvfDJWb58tvZBaJG7VBpPoDa3nBRGWgtM37FQjqR8Y4alL+9S0SM3Z2wXr
 Uu0gVaGJlk8wVTDXLuJlPSnPE69XwBDqOEjA7NCjukNSk5X/kWXVDp61UWKtAtlTniqQduNnO0m
 gNsYWAQE4pcLqO1LmGHqApauVL9K40u7cg0XRH+SAlgDdnttuRfzGO+U8HNvKLhJRri8ktuhfFx
 7obfbDnXxEswV1epfg1/UMl8BOjyng==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_01,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509290175

On Tue, Sep 30, 2025 at 11:18:11AM +0530, Akhil P Oommen wrote:
> In A6x family (which is a pretty big one), there are separate
> adreno_func definitions for each sub-generations. To streamline the
> identification of the correct struct for a gpu, move it to the
> catalogue and move the gpu_init routine to struct adreno_gpu_funcs.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a2xx_catalog.c  |   8 +-
>  drivers/gpu/drm/msm/adreno/a2xx_gpu.c      |  50 +++----
>  drivers/gpu/drm/msm/adreno/a3xx_catalog.c  |  14 +-
>  drivers/gpu/drm/msm/adreno/a3xx_gpu.c      |  52 +++----
>  drivers/gpu/drm/msm/adreno/a4xx_catalog.c  |   8 +-
>  drivers/gpu/drm/msm/adreno/a4xx_gpu.c      |  54 ++++----
>  drivers/gpu/drm/msm/adreno/a5xx_catalog.c  |  18 +--
>  drivers/gpu/drm/msm/adreno/a5xx_gpu.c      |  61 ++++-----
>  drivers/gpu/drm/msm/adreno/a6xx_catalog.c  |  50 +++----
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c      | 209 ++++++++++++++---------------
>  drivers/gpu/drm/msm/adreno/adreno_device.c |   2 +-
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h    |  11 +-
>  12 files changed, 275 insertions(+), 262 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a2xx_catalog.c b/drivers/gpu/drm/msm/adreno/a2xx_catalog.c
> index 5ddd015f930d9a7dd04e2d2035daa0b2f5ff3f27..af3e4cceadd11d4e0ec4ba75f75e405af276cb7e 100644
> --- a/drivers/gpu/drm/msm/adreno/a2xx_catalog.c
> +++ b/drivers/gpu/drm/msm/adreno/a2xx_catalog.c
> @@ -8,6 +8,8 @@
>  
>  #include "adreno_gpu.h"
>  
> +extern const struct adreno_gpu_funcs a2xx_gpu_funcs;

Please move these definitions to aNxx_gpu.h (a2xx_gpu.h, etc). LGTM
otherwise.

-- 
With best wishes
Dmitry
