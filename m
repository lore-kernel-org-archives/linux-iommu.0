Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD42321C17D
	for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 07:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759218362; cv=none; b=eN0jq1Sya13euj3ATeMmVDPAFy/mL8dHBYpcdkvaqdFu7IT+3iIKcywWikR9vbdEQZ08wpaL+rRPiz87ds8d71OzixbkoDXHqKN6WB0VXfz8v1Gl+o4GHQrQHX5gygrxJpm/SqrvHDdF5Zv1Reuh004opoD/j4FsATdRg4uQNsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759218362; c=relaxed/simple;
	bh=BefZSX9fm1ONvnB9eur1YvCHDGRIRGcUqr+hf2kx83s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L65kJeDCgzrRnc//l1fX3NExabVQkpL48EMumOt1XuvxDsw0ELr9TkgL33FZ7uFdONjOw1jBNLPmS1to4INcCSLWGT6+ZaPG124juUhH8zHm9SRg9Zyo3N70ePGVTlL8bfBBnny7Ma9QfnMyNL6lOAi2NpOpfp0GjIag30WbIFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Vw/XAKGE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Vw/XAKGE"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58U4HWMG024448
	for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 07:46:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Kji2nmZ2FEr3Raw9eE5h6cYw
	gKVR2CawlGpJNJ1zd3g=; b=Vw/XAKGE1YO/T9KY5F5Hr22nkn+F1e2vVFdW0Yk5
	HucrueTDHPW8bQKdDS7ZSJUH3pMjsUmxgjV5CwqWy22p0FkJGOSH8eDfhqa99wnu
	5vEcvfNhuri2ynbFqymBxNt7EZXstZtoGedJRH6A5Pyrm4eC0yqYDV27uLk/EqRt
	o/cXfEAV0/hfQyepZ4CuB64ceNJN5tA5Gx22Wf7at+joGv3XvywLEfUK/d6N5dI6
	tO/IDDnLwKdrQ6WtRWBlhPalt9dKwRC6wSlNQ5DSkDFSkfVTKugIaHAwexVG3Q4X
	HiJbykLLeuMB/0zcLomnZoSPDz6RSPpIlh7S9P4PFf8sqw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e59n0f0b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 07:45:59 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4dd932741cfso102243901cf.1
        for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 00:45:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759218359; x=1759823159;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kji2nmZ2FEr3Raw9eE5h6cYwgKVR2CawlGpJNJ1zd3g=;
        b=Ql/PfJGh2Pu+sBEahtQXbSLdGLl9zKdCZY8zLabRiY0c9KVQ51OEaj9mKUsHOBM+Vn
         9f9s8uyswR9Ir01byXfdveAXtnxa//cqGN5XxX9qI6vtxD4MiwKxYEzJTN2YKoy8/8v+
         RueVp6eXAfQ76usJNi9YfAiaST9KdwOCAen8tDrbYWca+GKw5laF39c8BIBzcCBVCOPG
         Qf/PUgZPXmSJW3yCUKNkMuhhGZrYwqXcUXyIcjK7Dxvrd4H91OORfgIoiPT0GJS8PmNF
         nSvhkgzbyd4T0pPG++9OCFPkgiU3ux5CJ9hEN7nwJUcSGWWrKh6sbXLxZ4CKsAjMHZ0W
         Ding==
X-Forwarded-Encrypted: i=1; AJvYcCX4sX4Qgjn4WxEunTF9garioccJb6tIMFfErxKuE56ClEHGGZ8EufeoPXDuqXu0KPDPpR3GgA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwyBB4X3j4F2pAAw1CJt/pfh18tklifbMRbyQyRN86i2hUp9BMQ
	4kqKtsWem+Bf9xHOwQmCOTwv60yEM5R0cgaBwq1rWCz4SDuPvK1C8QPdCKNc6mpIgeZ66BVcE0f
	kAkIME4MbQjoGRRdA6BrOjqkEqYm+PR26+JqMdZq6fTzYUw44Uu/6fTqZwQ==
X-Gm-Gg: ASbGncufcXn5Ppp+Ojpdz77geKu5Lt0OAhIQeG5n0YPG81B8+evuKhNLOAuu543t6t6
	Iqr2frZnmRhE6GUE4vhSIzFDyhEqKrURYYaVlpeYt5BJFggl7uVu2oHz/ejs2zzhFhgkSTY5Avd
	kQpSOa1HIwMa6YXVyg/Zx5WW61dCgOU8JbqeSedknCldjw0QxD7PHJ+GIw0BX4KuDuL1tquUndB
	vVCMJcEVCFzTZkNQ/j5N1rs/iJWTR7Jty8BhxfVcpg6FebXwfCDn8Y/kRHZrwaFmEnwWsLsBSVP
	9wUhrNBqWY8lQWZL2hzj1GEzfPIaHT8Q3ym557dChMqpOPBGPni3UAvWSMRK0hwlvPhuCraLUn8
	fJvqhZwOaPXPrMWD6jm5aGMhfcVQtouRUiwhh2u4oC9eAh5MbyQg+kYdKeQ==
X-Received: by 2002:a05:622a:408f:b0:4df:9e59:9d79 with SMTP id d75a77b69052e-4e2661da9f5mr51016161cf.35.1759218358974;
        Tue, 30 Sep 2025 00:45:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECErpsVHn/gl20DmHz+69GFvY5gifpdT4tSpKn1PuYqRHRES76ncOLU7Pd8idEKbvO7WTlFQ==
X-Received: by 2002:a05:622a:408f:b0:4df:9e59:9d79 with SMTP id d75a77b69052e-4e2661da9f5mr51015931cf.35.1759218358442;
        Tue, 30 Sep 2025 00:45:58 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37289559058sm17247361fa.2.2025.09.30.00.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 00:45:57 -0700 (PDT)
Date: Tue, 30 Sep 2025 10:45:56 +0300
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
Subject: Re: [PATCH 14/17] drm/msm/a8xx: Add support for Adreno 840 GPU
Message-ID: <r2spx7vu4sg4ydk2pvhe5gq6wxaiahmec3f5dpijvw5mseldmb@755zm7c2nv4z>
References: <20250930-kaana-gpu-support-v1-0-73530b0700ed@oss.qualcomm.com>
 <20250930-kaana-gpu-support-v1-14-73530b0700ed@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930-kaana-gpu-support-v1-14-73530b0700ed@oss.qualcomm.com>
X-Proofpoint-GUID: 7U5L-hNmR0WA_Ua8OrSNpR_wrjWhr5s6
X-Authority-Analysis: v=2.4 cv=O4g0fR9W c=1 sm=1 tr=0 ts=68db8ab7 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=90rIqVWp54D9reHQgRkA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: 7U5L-hNmR0WA_Ua8OrSNpR_wrjWhr5s6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAwMSBTYWx0ZWRfX7b9vVTycHDJy
 zGmgQ0weORGrklbFCRHgljzpniDmH6qePU9LQLvrQAUNAOOyivvBUpCoxL3ojrZA0gjFN4HWbPD
 Feda2mfXT+Wlg1JS8bTOE4AXhl7amZF8nsRgSMFiJMTJxOE2GmEJrbK8dgWilrUMZoZA7YrPeWx
 zF/wZKjrVFR49IGWTnnMp05B1m8t/4y81YPv1fGmZDiHTAsszDjZ6Wh2RhE9M/sk5JbfoHPbX1b
 rXbSQepYnOZW7B2sUsDhOEMFq2sgw5HEZxv6okAa3x4KawbyDIA7B+nDzBl4i+gAa74kG66RbCR
 +81sZuiTY/V5K8puN/1do9LLw0RW5bYR2uyVCTPMa4CVAgSQigAfaqBjmwph76qyj/TKmPCoLF9
 2Rppybd8nym2h/luDEqJeiVQw2UVhw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_01,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270001

On Tue, Sep 30, 2025 at 11:18:19AM +0530, Akhil P Oommen wrote:
> Adreno 840 present in Kaanapali SoC is the second generation GPU in
> A8x family. It comes in 2 variants with either 2 or 3 Slices. This is
> in addition to the SKUs supported based on the GPU FMAX.
> 
> Add the necessary register configurations to the catalog and enable
> support for it.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_catalog.c  | 211 +++++++++++++++++++++++++++++
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c      |   8 +-
>  drivers/gpu/drm/msm/adreno/adreno_device.c |   2 +
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h    |   5 +
>  4 files changed, 225 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
