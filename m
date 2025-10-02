Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0816421348
	for <iommu@lists.linux.dev>; Thu,  2 Oct 2025 01:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759367032; cv=none; b=YjYeYHGJdj4hkLU2SRoyiPUzwkWEmSse/wDmkdISjmgzoo63acFQLsEDcbtbC+Qf+PLQZn5R7rHi+sGBM7C4lF29VcdHV45OfFYPgEPjWmvPayAf2wv5y0PIMdS1r56OLGdDiZNRP5x2lZVBSCO6di5pGS1+2uUFzEjqmuW5Ir4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759367032; c=relaxed/simple;
	bh=5Ie8hS7ySudMhvrFQ120F+fE0XrbFcZOgEC5UeBk4IU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZIZwK2zTmnOiCrUAfezE+1mLbVXolnYYD+4b41PC1ZcQ4mqt8d1bqCVB4LmNPPBHMuvYSQx6cebYSQkHV8cQCWRxA6hCaVUtHBSgcSS5THAjFpCkm9sQ56Ia/U2KTs6XXK/viZw38oBQQENNCBSxIb6gpnzYakoM41EiQFeSFvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IZphk4Nh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IZphk4Nh"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591IcNqJ006266
	for <iommu@lists.linux.dev>; Thu, 2 Oct 2025 01:03:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=fHrr65lNXuCbU7GLecWRSzb5
	A4LI0xtyUM7m4ktwrdY=; b=IZphk4Nhg0W0DaJgkAk/2l6BgMbcMbaUAmi4e2Ht
	zf19C5MX1zPKhZOFpiLyarnSwJE4FCZ2/9iUjXgoTfvUPKGQpWBO0HPZFzEhpVFm
	qd+sPnWUvm0ei5lCm/U9NXCQUiCqgiYadMkQla56TJFVuNOYiuWrHHTVk8FvpyxB
	qqaJSTm6N02CJLa6o+DbETd0IHyz/bxBFo2F65K+1bJw2ccYTc0kpMh7Yq2pFNm+
	qUbPTcbjlatp84jBLUT++FCoZDsO62ewDaBV4l1KmU4JbXrVO68H03uww+Xa+vuF
	fALG5LzZCoGY2nYVuFutQWPJ/3if8tMPbU+tmxBtHMD4iA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e8pdp2ht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 02 Oct 2025 01:03:49 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4de5fe839aeso11346721cf.3
        for <iommu@lists.linux.dev>; Wed, 01 Oct 2025 18:03:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759367028; x=1759971828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fHrr65lNXuCbU7GLecWRSzb5A4LI0xtyUM7m4ktwrdY=;
        b=LBhEq/mzS3RJYCIWjeWKQcFTaQ0LxIPo6fOBTXPqyGHtzEjtjPHmw/1mmoWo6AsnDu
         TgfPW7XCchOxpjl3C7nxfaG+eIFCZznY/QJisCAkUtPBQ0dTkOqB3LahyYI14389XFp+
         1xghpDsbpCErjR+++pOFIKVFjd8cfgJeREJe3ZFzRTW1vHR/nQWy0n2aB8EkWgDpQUZQ
         JQeEolBNb95FZ7Eo7TWF/P9+IG3gKDkVdGHwyzVRnYaGtvPd/nzzhogPVbUXq3M8SCnp
         3SZfH2iemvxaCuu6mQPC1s828i0mu+M8vfiVrq1wi7Xt3KCrsKFCBCtbU2gR95d6O7lq
         cojg==
X-Forwarded-Encrypted: i=1; AJvYcCVbwYdqgincXHlO3F4pNFdpAGbnNM2Wwx3DMCYx/9BvheABR+L0+ruS7ZBZwP7adaHOwKJUJQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxR4EeJrblkoaw+AU7Z+IVICVz+qAxknP3ASENJzWUGV9x3Z/w+
	A+herAo2Kv7DXnmPHI9jimr/ELuyboiFbCXTNiHB1Qk6c0UukhWl0av/0p0wFRuAqjky9NjDNlZ
	Dc855ws72+vSlxw3GIia87pz6s3AplQnGCqK6ZVkHXlLF5Pakr07VrMuizQ==
X-Gm-Gg: ASbGnctrP8rWZmSaocfcALV60E802l+McD8BxGh2X+Amnb7dsXneYxKouxSTyXYmjvO
	DlYsEIsibRJd6ad4pP7VZSa8Enx3jXnhnYAj3uWgMs34wHAriHl/J27qV+kXc2lF2DWKIuK9Sns
	kZqW61bbeibO/jP9t6Px8aUh1YqV4WE1kvpvSu4Pg+xt168ikyM7T1MGMwB52nqnLuSjLzoHA+9
	ZBRrX0tZVrGgpSi2oubvRRdmshvhTxMbq0btOe9cLAyKsekCimrKossBp236HzyVW4oXv3c0m8t
	a6asKyct6giMOIC6EZpYoblxOUca+4D7qnTzsdU/jqbFj/FPZaoZLkMQxuBY9iQ0sGk4V9W/klD
	OWgqxlt2W78tqdgbWNc0WS/hXTvYxwFAES6cGWA65mYC8gORuLd0YBoPvgQ==
X-Received: by 2002:a05:622a:1cca:b0:4d8:afdb:1283 with SMTP id d75a77b69052e-4e41e5453cfmr73046381cf.66.1759367028485;
        Wed, 01 Oct 2025 18:03:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+PPEgu5a9spnGcgbd8IPDdjH3CRYSnDJceqwk4HUzRW0WSjlgTwcpzIm44jNRFI2tTLMX0g==
X-Received: by 2002:a05:622a:1cca:b0:4d8:afdb:1283 with SMTP id d75a77b69052e-4e41e5453cfmr73045961cf.66.1759367028031;
        Wed, 01 Oct 2025 18:03:48 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b011b140asm337846e87.133.2025.10.01.18.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 18:03:46 -0700 (PDT)
Date: Thu, 2 Oct 2025 04:03:43 +0300
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
Subject: Re: [PATCH 10/17] drm/msm/a6xx: Rebase GMU register offsets
Message-ID: <eicw5g5ozli6tvcsvxdorvd5ymxizidodbrfitqezcezwlzdli@6koxrgnu2lj3>
References: <20250930-kaana-gpu-support-v1-0-73530b0700ed@oss.qualcomm.com>
 <20250930-kaana-gpu-support-v1-10-73530b0700ed@oss.qualcomm.com>
 <s4no2wy3yskk6l6igtx7h4vopaupc3wkmu7nhpnocv3bbs4hqi@uhie6j7xr2pt>
 <edb8b0dd-126b-4ed6-8603-119f1fd52baf@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edb8b0dd-126b-4ed6-8603-119f1fd52baf@oss.qualcomm.com>
X-Proofpoint-GUID: bUfOetasZh-yL4uM2rGohROJL_91L99M
X-Authority-Analysis: v=2.4 cv=MYZhep/f c=1 sm=1 tr=0 ts=68ddcf75 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=93h1c-cikf9FHO0Tq-gA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: bUfOetasZh-yL4uM2rGohROJL_91L99M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAzNiBTYWx0ZWRfX/enrMkFGzZ00
 3wxu304/3gy6pVMTmnMQVQo4sjEEaUvX13NtnoeXd8GL6kSX8rDEcVITz+NJogl3fZUo7NNVfVi
 JA2k69AsVf/0Ee0bvczlu5/s3hcfyovu+s4HXHJGM4D0Efa/3pujJ5Qlic9Ubj1geJ4Pushzi7+
 3lIxBXivgSQJsb75+69827qGQod9+AnsEJKaO8QB9pWDjsyk+CqWLwG/rmDx5cHPYs/VPUYjrWx
 Q7kShl6SmiMDt9Zz8DvNo2K797nPFbajkk7cLrZxUkG6Y4pTg1IgqEFYnMNXrsRGGXtSW+dr6iC
 cxCcqwAair0EjyUXE8fV8O3HpvoMaFzz8MQ7J89Kvn5m6ds8ZnkwHpYXvKovRgITeW+A83Ec32Z
 4sOjYMhXgOE5ATRQObWNJnzOWEwPiw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_07,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270036

On Thu, Oct 02, 2025 at 02:52:35AM +0530, Akhil P Oommen wrote:
> 
> 
> On 9/30/2025 12:53 PM, Dmitry Baryshkov wrote:
> > On Tue, Sep 30, 2025 at 11:18:15AM +0530, Akhil P Oommen wrote:
> > > GMU registers are always at a fixed offset from the GPU base address,
> > > a consistency maintained at least within a given architecture generation.
> > > In A8x family, the base address of the GMU has changed, but the offsets
> > > of the gmu registers remain largely the same. To enable reuse of the gmu
> > 
> > I understand the code, but I think I'd very much prefer to see it in the
> > catalog file (with the note on how to calculate it). Reading resources
> > for two different devices sounds too strange to be nice. This way you
> > can keep the offsets for a6xx / a7xx untouched and just add the non-zero
> > offset for a8xx.
> 
> It is not clear to me whether the concern is about the calculation part or
> the xml update part.
> 
> If it is about the former,I think it is okay as we have confidence on the
> layout of both devices. They are not random platform devices.

I'd say, the uncertainity that in future the offset will be the same. As
such, it's much easier (in my opinion) to introduce the variable offset
now.

> Also, we may
> have to do something similar for other gpu/gmu reg ranges too to
> conveniently collect a full coredump.

Don't we collect the full GMU register dump?

> 
> -Akhil
> 
> > 
> > > code for A8x chipsets, update the gmu register offsets to be relative
> > > to the GPU's base address instead of GMU's.
> > > 
> > > Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> > > ---
> > >   drivers/gpu/drm/msm/adreno/a6xx_gmu.c             |  44 +++-
> > >   drivers/gpu/drm/msm/adreno/a6xx_gmu.h             |  20 +-
> > >   drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml | 248 +++++++++++-----------
> > >   3 files changed, 172 insertions(+), 140 deletions(-)
> > 
> 

-- 
With best wishes
Dmitry
