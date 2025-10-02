Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B352D1A285
	for <iommu@lists.linux.dev>; Thu,  2 Oct 2025 01:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759366915; cv=none; b=Ff1Ta2XBas1ScTZvMKamMdemKHb3gsDMJO9i5EwpJuP84UIB7WbKtf5vMM1M3v96c5dhJRaPiSqegVQNEOO9DulXd4GBV7V5C8QuKU6D39UoPRyosNPy9XeS2ezvyfkbVp3bh78b35othgCdPnS3gLDJcfjaQgP+oVmdoE4MmL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759366915; c=relaxed/simple;
	bh=HCZdNAoMBnXI97RBUrQ9js+GcawBirknDeCnyIBfdF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=czs9m8HrVY1w9fLJr0YY3HZRFuGPrKvzxLnZDe2vV79nzGGAxARy8NTSlSIPY04dgRNxMrifm7qAX8gJrMnplrU1HmZ8V6x5ORBzoPl3WKCS/lG1XDgFOxZPvg+i0Td345bIM7dMGFgYJkU1ePaekmRAIuF8MSqDEiVf+FnEWX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pzJAo28G; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pzJAo28G"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591Ic5mO005972
	for <iommu@lists.linux.dev>; Thu, 2 Oct 2025 01:01:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=+uuV+cAEUShNKUExukS8Sgyd
	D6777ETGVMv3jAdKCJQ=; b=pzJAo28GyVqZx1sMk+eBu2npT920kGL71Izeb9ie
	5Sv1dzeXKseKZQpR6MRLHAUdZTQhn9lZI1VA2Tr1CG/guG4ptPbv/EqNjdbZ3lBI
	YS2+vGtRN/g1FHQ8A4vvoHJVpYXOo6BWE5NE3Cpq/joefc9THzWLWwERRU4TzW+O
	aU3+Qqn1/Ww3pk6dJoz1LNFZ/b+SrxJEhks3p3a/vxYFJqGXT/5ARVCMZBk+WTeP
	Hmt2YUjhWVZDtdpfjHfbcwsEvCQyHDsUncpSkhBSRjpcee/3ZFTVM4QGPyksrPOI
	9RUUmlmKcRQakxMFYTFiIG9oNgZG035AY3j1TEyNGLCeYg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e8pdp2e7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 02 Oct 2025 01:01:49 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4de2c597a6eso18013991cf.1
        for <iommu@lists.linux.dev>; Wed, 01 Oct 2025 18:01:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759366908; x=1759971708;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+uuV+cAEUShNKUExukS8SgydD6777ETGVMv3jAdKCJQ=;
        b=f/QDmIyfx2tco7fj/Hf36YySiqkM6eXvfvnFFFz2LkKUj0sfsejI/KpeErQV0y7pjd
         J7NWDlm+RWKJfC9x+RhUtvXoTY18fauW27EDOIxckV9TQBd0Gt4EHORa06+zE6IUOsA0
         YkINkRWy4+rPejmPwPkRGhsmOwS0PaAqgn+nV8pNl5au0aRq7WMzIVcyK85Qz5kt1Fin
         zy6DqGF6ser0FUZfUN2Nt5sAqcmJ5C9675oGZCv13IYPrm4v4YxVMEh7aN9E/31zlkxu
         YwJ+lLmNhcyhN7Xnv40zFR5vNueEOOpkP6A85Jvn1HtDtNxBuEB6GqaRkODCcdJ+wjSJ
         TeZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdnezkoDLfRc+HADDRStxzhZ2XGdyEn/qZhKVElx1XFtelClg3s/Aw0Ba94wwQpNT/QjeVEA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwbQ9pI60vi/rXrDEX6VN5rY71tZ/pgebYQ9a442EgffLCZ0J+m
	+heU2Cp4rjtj0fqbpf3FJU7ZyXpI5zN4gHG2LY1teWFDXM3yaTontA5BPKLTsEhABzxlay+NaFN
	9nbzd6/W7F4/bI/N3TEqAVtKrgkKFHtQ0l7YgDjCdJ9e15vSGoIyYep/fWA==
X-Gm-Gg: ASbGncvPuIdIJ0m9C9I04tYUP6OmPORozW4/0rgtUJw1Rrbk6E7xinlz6DKQLehYdN4
	MHtxinz19W6LWDBvlkrki0CQXh/IVqRIbUAUkNEJQ6oxCdpCMAbi8cr4bNHFxCpllae8nQwYoWS
	2xswhi2+U3IYAi6kFsiW980LEHmfogauaYzyYxDYTOw120EbVb75bm39R4+GkmuvEctU3UhANCY
	2q8UQtiAMq4nPPYkq+uoZGntK4MY/TvbZwe/cVv75tTGbLiID8gvgawN9Opl2TBTglDP6lFac8z
	UT926cgaaw489Hj93J8npw3RvXBLeH5neb7jgw7lga778f7IW1FEDpe8vQmDOUPGHfMKVTU36uc
	marELCaxxegacbLQ+XxaIAAxcTq1f489XvGbYn6qrTSYgIvrJKdK7xWWQVg==
X-Received: by 2002:a05:622a:7c0d:b0:4e5:c50:54c9 with SMTP id d75a77b69052e-4e50c505d71mr35071961cf.14.1759366908201;
        Wed, 01 Oct 2025 18:01:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFn+cgowdIyCiT+tSd84oPTNAKVxBzdxq8x33fvDr8hPGJVsiMB7AsHFEUbdO1IdCvcYvE2oQ==
X-Received: by 2002:a05:622a:7c0d:b0:4e5:c50:54c9 with SMTP id d75a77b69052e-4e50c505d71mr35071211cf.14.1759366907553;
        Wed, 01 Oct 2025 18:01:47 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b0113f3ddsm344791e87.52.2025.10.01.18.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 18:01:45 -0700 (PDT)
Date: Thu, 2 Oct 2025 04:01:43 +0300
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
Message-ID: <edfc7ke5ktoah7ftjbwk7dzihsgh2mq7tatfy6a5oxbn6yt7d6@yf6nz7b7jrmx>
References: <20250930-kaana-gpu-support-v1-0-73530b0700ed@oss.qualcomm.com>
 <20250930-kaana-gpu-support-v1-6-73530b0700ed@oss.qualcomm.com>
 <cp7djnezyp4whhfqcnsfpes5kxfbyvqvc2ceimdrnrl7s7agyk@z7ozx6oihezd>
 <82cd8782-b2ee-46ce-9964-e564ab6a0199@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82cd8782-b2ee-46ce-9964-e564ab6a0199@oss.qualcomm.com>
X-Proofpoint-GUID: xFMRTadOdrWkKp0-RJq1-f3Jn9r3uqoy
X-Authority-Analysis: v=2.4 cv=MYZhep/f c=1 sm=1 tr=0 ts=68ddcefd cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=RvmDfw1ThOOzoc4muVMA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: xFMRTadOdrWkKp0-RJq1-f3Jn9r3uqoy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAzNiBTYWx0ZWRfXwuPMQ17bU4kV
 EXqI2pqoFOSIp1K5wA+tLTz77obzXi3tI7fdgAiZpKIqLxQrdJQ31RtDqVUs26aePdIevjPORYk
 dKRujilavlRvZqZnYtT/U9OsY+MG/b4weK/VZcc/qRQ1+SbhAbcrKBx5ywmNBv/Xnslw5Qj7kVR
 K671TYr8bGFSmfdawZcmimenNvLOYGNvzFK4GwMLWhN2w3jGyLKJbtCroTtNwOOak63uNByo2LN
 VDTT3bYM4m0MYaxAxUqYj5XRXfOCDCQhrdEy9o5+GxCB7xcz/YSo09lb2NZLshYoglTpGUXGBEp
 dGqvpwSBCIUMSkl2DVn6zy/7KxfjnZrYGP1tc2nV7nFgjZHKFiKN+nBACJLiwEPrBEJy3BtQPpX
 L1tZFot+MDQnD6iWR0QLRygJfXl7bw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_07,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270036

On Thu, Oct 02, 2025 at 01:24:36AM +0530, Akhil P Oommen wrote:
> On 9/30/2025 12:39 PM, Dmitry Baryshkov wrote:
> > On Tue, Sep 30, 2025 at 11:18:11AM +0530, Akhil P Oommen wrote:
> >> In A6x family (which is a pretty big one), there are separate
> >> adreno_func definitions for each sub-generations. To streamline the
> >> identification of the correct struct for a gpu, move it to the
> >> catalogue and move the gpu_init routine to struct adreno_gpu_funcs.
> >>
> >> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> >> ---
> >>  drivers/gpu/drm/msm/adreno/a2xx_catalog.c  |   8 +-
> >>  drivers/gpu/drm/msm/adreno/a2xx_gpu.c      |  50 +++----
> >>  drivers/gpu/drm/msm/adreno/a3xx_catalog.c  |  14 +-
> >>  drivers/gpu/drm/msm/adreno/a3xx_gpu.c      |  52 +++----
> >>  drivers/gpu/drm/msm/adreno/a4xx_catalog.c  |   8 +-
> >>  drivers/gpu/drm/msm/adreno/a4xx_gpu.c      |  54 ++++----
> >>  drivers/gpu/drm/msm/adreno/a5xx_catalog.c  |  18 +--
> >>  drivers/gpu/drm/msm/adreno/a5xx_gpu.c      |  61 ++++-----
> >>  drivers/gpu/drm/msm/adreno/a6xx_catalog.c  |  50 +++----
> >>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c      | 209 ++++++++++++++---------------
> >>  drivers/gpu/drm/msm/adreno/adreno_device.c |   2 +-
> >>  drivers/gpu/drm/msm/adreno/adreno_gpu.h    |  11 +-
> >>  12 files changed, 275 insertions(+), 262 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/msm/adreno/a2xx_catalog.c b/drivers/gpu/drm/msm/adreno/a2xx_catalog.c
> >> index 5ddd015f930d9a7dd04e2d2035daa0b2f5ff3f27..af3e4cceadd11d4e0ec4ba75f75e405af276cb7e 100644
> >> --- a/drivers/gpu/drm/msm/adreno/a2xx_catalog.c
> >> +++ b/drivers/gpu/drm/msm/adreno/a2xx_catalog.c
> >> @@ -8,6 +8,8 @@
> >>  
> >>  #include "adreno_gpu.h"
> >>  
> >> +extern const struct adreno_gpu_funcs a2xx_gpu_funcs;
> > 
> > Please move these definitions to aNxx_gpu.h (a2xx_gpu.h, etc). LGTM
> > otherwise.
> 
> This is a special case. These symbols needs to be visible only here.

Why? They also need to be visible at the point of the actual definition.
As such, I think they should be a part of the common gen-specific
header.

-- 
With best wishes
Dmitry
