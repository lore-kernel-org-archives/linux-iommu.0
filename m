Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEB91F462C
	for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 07:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759216289; cv=none; b=oxwzcTYjuSYv3DeCRwoFr1isrhXrSAjr6xqEbTpzsoDOxykcouP56/LLW9k4XY2oyq3zDSjEbqFnKtt9/6pEWHuIgLhKLMWZCvxHNWzb5lVT4KREQccSFGqWJp94eYdHFhSJM8IWOYreMxCNS8M6Tlg9cj7pu8At1eF3UnfEv6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759216289; c=relaxed/simple;
	bh=j2N7nrmNVrvXiMj+TUS6Y8fXfzHkx71Jm8gjQ86zCIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jUXOu6M/Oq3HggII3kU8omte5Ej8cAELbkmta7ViSXGn1KzHr3n55MY5OEGUgbgjyQAl4r6RGyPbIsnQNOnO+zWaUxcePohvOZHkesE4TSnvqj6vvMKrayNuGDpDBW0bPXgP62smPj1Oy+fgRTvC6YPCC6EOGaZGM+lEjjdhYmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bWBKbjC8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bWBKbjC8"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58U4HR0m026876
	for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 07:11:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=kCgcpA/KH22QIJWR6lWCGCo8
	yAwGEj9Grr0AmK4duj8=; b=bWBKbjC8XOLZUBjxlVMArnVyMUk7L/cho3IZ8cAF
	EL5Nz+r54Fs8LIgnnKp8AbYGTg3br1F/XM8U2PrL7PYLnaxGDaTD0JL2uFUtfV50
	V3wAHWQYP4dEKJhvFclfk5q0U3mD6yu3gGTK1NwkDJEx6D9m0AqyNnA+V4M69j26
	PGzcRT+HCKxiNgdXHcMizv+fZtvCp8dSRx/J50S00rvzJlBE10zqROhY4ZkYNuFV
	3V2jA27AXp0UmNXViOWhJ/Dao3UhjAdPPKDHy7dVBl88m4i4xmnbI83xk4iHMjm1
	93jlCRiUpvFuiZjBZj3/BNHnHDUFO6ciosLCHqIIJjqCeQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49fyrf1k7a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 07:11:27 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8645d39787bso898420785a.2
        for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 00:11:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759216286; x=1759821086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kCgcpA/KH22QIJWR6lWCGCo8yAwGEj9Grr0AmK4duj8=;
        b=rzz9yBl/MkPYnXD/D7XWWS3DiH6JhK02pW87qq4O7nYsADquY62e7940WI5IuINum6
         GCR1eRYXA+UTaXU2osH7UmzAvyH91ms/Spmb0yecIEvHBx5X9SOXDKhfixPzeWmlr2A0
         aUI9h+RwzH63d2n8fgOxmopdfuvFOr+rAcYcUnoXI5iSI7Xs8VEryUkz5ooq421Aql36
         zL+SkE63kMM7NgLVu3TYYcCcDMl0cKD6Ud1i8tlpcoDnC5sln7BsrFTv5C+4HX9i2ywx
         iLAclefJE1L0R3kKpYec1pHVIOCugXZumii72WHLfiiwOr2N2+PDHs/PCEeS3G+ZSSev
         NZQg==
X-Forwarded-Encrypted: i=1; AJvYcCWiYHpk0eG1EdS6DKSe2y+Rpil4Gfk83NF7hzyZG7N69KQwJiI+ffn7LnlR4riCiFsSna+h3Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwLu/uYDLO1ZKhH+Xi7qTWVhmjODQxxZByoksei6T8DeyWyqS4h
	VdHwXpuhUra4AyOiDjr6koTuOW+HzGqvIswZDCfTyq8u15i6l0YLIRI6RF5+LyvP4b7QmaETlSd
	XV4E4Je5/y3iEeAxECySegQ4LLIq0KB9OdauxAw759i4NX2YdiRm0xB8X1w==
X-Gm-Gg: ASbGncseamhCCPIhiz0xJzPE+jJiZhhRWJUrmeN9ubIcbMaIbft6cug9NamPbrw72LJ
	s/8JjdBaeFRyS7d3hUIGZNLz0TDw9xjE4OUxveOWipddHZS4u3aO/19zrAOMKS/kbjxqFfwZ+ZC
	/jzka8/EpwSAvpXytUuE408GbNLDhsLzXw+h82fqWdxfTt6dJOsIhbXusxUrMYZoLJ+pm8HxzYQ
	QLjP3+19KO927sipzyRkOQENE4pKHPAQcYrWKT50r5k1WU3/xoqvKB8MJuluzgnBUFzKYkPHXnR
	Nl/Wnt+6ZvrNb5gisrrFgJPgw8VWObZueEpAcIbOstHnNWxXuor1Atv0nu2nwAjtpXzSSA+JN6b
	gE+LkmmLcwLBE+lQBlDfvr+k6c8tyV1KUtZU5G6E47Wjar0CPVfX7BC5F4w==
X-Received: by 2002:a05:620a:1a26:b0:858:64c:22cd with SMTP id af79cd13be357-85ae94c6f9emr2830952685a.72.1759216286532;
        Tue, 30 Sep 2025 00:11:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYRbssu3zrykdvcozSbij6HKAxVNsfP55t5zEwTHN2XSjTz6lWJykcsj3kQZuHoluEGfqVDA==
X-Received: by 2002:a05:620a:1a26:b0:858:64c:22cd with SMTP id af79cd13be357-85ae94c6f9emr2830948585a.72.1759216286049;
        Tue, 30 Sep 2025 00:11:26 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-36fb4772cb8sm31868951fa.10.2025.09.30.00.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 00:11:25 -0700 (PDT)
Date: Tue, 30 Sep 2025 10:11:23 +0300
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
Subject: Re: [PATCH 07/17] drm/msm/adreno: Move gbif_halt() to adreno_gpu_func
Message-ID: <x7segnx2v4id3qw2zna6vxxbomfcyogib734ggifggynyfsp4h@7zs7savbiz7a>
References: <20250930-kaana-gpu-support-v1-0-73530b0700ed@oss.qualcomm.com>
 <20250930-kaana-gpu-support-v1-7-73530b0700ed@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930-kaana-gpu-support-v1-7-73530b0700ed@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: W9JxmFGdxspjWty73PMFu17EJECZvFBH
X-Proofpoint-GUID: W9JxmFGdxspjWty73PMFu17EJECZvFBH
X-Authority-Analysis: v=2.4 cv=etzSD4pX c=1 sm=1 tr=0 ts=68db829f cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=scbeE0iXsUk0x8BJeo8A:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI5MDE3NSBTYWx0ZWRfX/mvlYF1EOWXJ
 qQ9TnYPtxliVZrCph4vxFeGAuO5NEynIqlRZVp8ISAmTDRkyroQTnhDqjxMNiIPCpS4mSrL0J3Q
 BGd/giQtw+bTNduhbVVBDd38nkuWjvvV9fJ6JZ51j1xJpjiPe/o1MWNuTN3hzSN5PktvMCqbdbh
 jjlSWdehHFbhZfwwQQmvlC0UAAcPDU2jSRdm+f90614seuSS3MFCYj1x3IccPjiAKgkjrB/x3f4
 FZb8nyEzsTzVM7GAvokSsyQeHhjL+HVrnf6OCfFI2anonfVvV0Ea3eQiwNz4qxjJoWoVd6QCVFN
 Se1dq3Tn5FBQVB3YHh8qiu2JOQwuB3vCD8c7gphxFMRg3CjSwyf8DYj7k5S7ZrLOANG40VVbSb3
 YFdJ1N73DFyQKAH+i8MGruewG/K5Dw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_01,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509290175

On Tue, Sep 30, 2025 at 11:18:12AM +0530, Akhil P Oommen wrote:
> Move the gbif halt fn to adreno_gpu_func so that we can call different
> implementation from common code. This will come handy when we implement
> A8x layer.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c   | 4 ++--
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c   | 7 +++++--
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h | 1 +
>  3 files changed, 8 insertions(+), 4 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
