Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831B84DD6D3
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 23:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780528123; cv=none; b=FpU6jdXEh/bHWLnM5mxRWhgmisY7DP7rYdUxjaJVd0OB2LN7/BOLMoWnB45o0hrA/ROGh8/smdqxAmwMOXsJVOmqQ7G+dfVtOVczCfwFEwc+IQOM0+btj/ctI5I8ce4mi6iQ/Dr+1OZcn2HzFpVoJf4sIMVj18MV9Yu9qFYKInw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780528123; c=relaxed/simple;
	bh=k9gdvfbRT5hx/HtCyubxxV4VnEf9J4znusxRO8Eh0lU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ex/XlLxrhr1reklm8UCdPD7sbLeeeaAuPv/9+5rDg2QBUnEYrBORhANuKr7jk95e3Rps35UzWGBEHbMOz9HEzdCcNdH0/x3tqOlopQFDvTH6ZGDjD5mUkqZkIMS7UwduOXCEfxoO1aGzwdLkubYBai2x5yIRStt4inakT7vk/d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OHI8Cmfy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FvM4jlPL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OHI8Cmfy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FvM4jlPL"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 653K6ehh2076419
	for <iommu@lists.linux.dev>; Wed, 3 Jun 2026 23:08:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=03rptgprQ5ZgED7iO7IjtRFg
	pfYYqtbYZq3I8MdIhm8=; b=OHI8CmfynVWzzqxqL+5SSZMLwT0jlY38Fwr9GT35
	BuJqId4zl17zWmew6vwc4rVG6ZbUo8rMNlmNMOUsyNrpqC6DsV3q8b/6SaF1r5jF
	R3AImzs30KGY9dkdDnY3XNjsFlL2nxy98N+BIb2vOtRNC4YBzUj5CP3EVtHAul6/
	8RPh0EiC8DriiySDx/E6l7nuWB/z+ot4+jNJxXKzYhgODIX8ULfs4XsVKDjS+vb+
	rgQ+YOcOMeWd3/GS6+JZgWDuZp+bj0nyVYl+/mpnmhmUhXk4KCOAI0ngOVoUCbsa
	qMr5DIo+w+En1jPiAQ5ZO01Sg3YsqPIQ+8pWZpguO1mvbQ==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejev1c1sw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 23:08:41 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-96395e5f46cso121195241.2
        for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 16:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780528121; x=1781132921; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=03rptgprQ5ZgED7iO7IjtRFgpfYYqtbYZq3I8MdIhm8=;
        b=FvM4jlPL7Z/bFhf6/AkKcvCeW7fL4OWPxoCzJxvHalK7jjt2X8OplZ/bDrVvmIXj4+
         cpWIR8m07bdzNVHi4DUHy/nWFGzixdvtB5m9WYRwlAn6g7tw7rupvEJR55zpv4jgfd/F
         6vgMlUrDrao0GiHIq49SEEfJV1qV/0nqK8DxvdJ6CyRz9a6i8ZEbJ612Sk2Wfhol6Ckl
         AuktsamKZ6EmG/JMAg9SbhArtgpzXkQANAzWs5mWXU3WRYIINFQMbIekJH1uXPgeUGSk
         Hpk87BTlWiew2X/O4HzX7TyOR8BFcuHF90cH+a5K9ruRL5s0xa4KtN5wknv7C1gGb1N1
         XFPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780528121; x=1781132921;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=03rptgprQ5ZgED7iO7IjtRFgpfYYqtbYZq3I8MdIhm8=;
        b=KmwMWxKxJlPXxmuDMG19l1ciWaC+FRO01FXBWXLeFKpBq8opKTzPJ/XVPOUJjnwyVh
         8pVy80JcZCXX0axDvjuomxHtKOQIjyZ6et4n+4Afon5vZCxxeZAeet3xM9TDfQDTDIEg
         rUanMQV6zsxMVC9Fll7jxkt3UF/gECnUeov5V04gHSyQL2AY24+zmEs6NejBVIlJBh9Y
         JsNaijqQDNum2WKa2YvqtYTxxDcdDXjs4wUb+A1fTyHZvRx6hzPtzUhaQY6vyRoJs7GS
         TyJZOXvVV6OJXnhmDiYUNdE36eFDCPkWYXNUeb/RDm4vYqfa/RgFRQfT1LMnoYPXuG4J
         W5tg==
X-Forwarded-Encrypted: i=1; AFNElJ9nbHREsQzkuwabClUtUhajKRLrHUXj4eemormBVgOp5U2tD7oyDsxN9s8akN7zwQhjLyBteg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzJ/IgIOkqxuPiH2e2I2w5F4I199nqIcTis69qGxF6OjGchhTml
	//RV1rgrOX4tvfTTAuii9z64pNrl2O30d+pgLkfh3vg0MaXo9VHAFhKM3J2iRYm4uLHFILUZqOW
	bSyg/U2qxBwRmeeBCHxhixs4k+M0mk5XEF8MaI9o1RCRJsPt13PoDD+CjUw==
X-Gm-Gg: Acq92OHYbBlGIzaLnV/CQiA0/33+cpvFtc87rh4H+08vyx1wzju0IL3a+YUuCPa3ggn
	jwODLS5Lt/GKMzR51qVIrMlaRgTWZpTsGb88Asd5fsrDWHh2Q+QJ/JWsnwxz6okEdLhlqrs+I5S
	iIdm7WHq1nQLuwji8JjgHPGcmXF5sSQA4SeDjjGCNLxF+0GHMg3cmml3lxK5Zbu0AeIMmkmYMUW
	3tdxjUUN6dIY8Mu3GB82XezZW5Wbd4/j5LER1E0Rzf9lK9Vw5nKRJuVPVskjCxxl+MlNctTJhSZ
	a0ZlhwEDTSo0vpX3hy6CI9XRC5/qb+fMAXrdoiyTDT0OeR+1TQfNikBzrZFz+BhjciQcxTM55N5
	dbWI8eulRXjqC/cWJeHnE9gnepgYLJzmsmSv/YipAJOW7e/2yj2ffuiDwgnzkyFbg+WscBQRG9H
	ZNvIqzkIvnceYzYaW52Z9wBG21a+5JMe7rN9fhrq712fXZmw==
X-Received: by 2002:a05:6102:6f0d:b0:6f0:3c5b:ce7a with SMTP id ada2fe7eead31-6f03c5be1bdmr2261999137.17.1780528120898;
        Wed, 03 Jun 2026 16:08:40 -0700 (PDT)
X-Received: by 2002:a05:6102:6f0d:b0:6f0:3c5b:ce7a with SMTP id ada2fe7eead31-6f03c5be1bdmr2261971137.17.1780528120532;
        Wed, 03 Jun 2026 16:08:40 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-396ac07e243sm12553661fa.12.2026.06.03.16.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 16:08:39 -0700 (PDT)
Date: Thu, 4 Jun 2026 02:08:37 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Nabige Aala <nabige.aala@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/5] dt-bindings: display: msm: qcm2290: Add Shikra MDSS
Message-ID: <4lozntipmx246uojyh5qso5kdplzyun4jzr6a6qdck7hfwoygh@tupqmauuswvg>
References: <20260603-shikra-display-v1-0-aeac1b94faa7@oss.qualcomm.com>
 <20260603-shikra-display-v1-1-aeac1b94faa7@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603-shikra-display-v1-1-aeac1b94faa7@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: HOd7l2zUC7BBEf_4MaraTRn1rSqC8eHQ
X-Authority-Analysis: v=2.4 cv=PNE/P/qC c=1 sm=1 tr=0 ts=6a20b3f9 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=irWgbQPqOsrm4l6MN8AA:9 a=CjuIK1q_8ugA:10 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-GUID: HOd7l2zUC7BBEf_4MaraTRn1rSqC8eHQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDIyNiBTYWx0ZWRfX7abAAiDXKl1E
 QyM709gWDEAw6uTb3HXC10bpcobkI95Mr8xIhmat/1BYHjDEfEb97cGt7cvjEuBlcOuSZgmg9pE
 voxSUNJycyfJHtRkwu86RV7Vyx7pTWU5iMkT6PMtMw7rRaQAJZtDCl7eNh6qxYvjfWktEUmHWcU
 xRExSjM3WW9hgdlyixma5Ff7EPCne3LaRRVPBNog6j4extrkoCHcHuEP53BT9H+PnjBvttkkcsH
 DbOdqF05RM2IMvFVefIKlXn5JiMcZYlv1GEgw/iWxkaVtL5zSNEE8GH6IulMGbvx4T/luz77aLr
 ZTA7VHmqeX0zkZgH2UnKIpc/4jNTt14ByvNTkiyWAzqhJqWNmiw+VtX5TqSvCG2MIDQFTbUqQfm
 LrsBLnFT9qOiJqu1VWJkGfPlaUH/SLmbvz0NLA7cmK59Q8qy7+RogybPzs6kHnFMd5CZcNY0EQ3
 G1gt5RSYwCuNLpew2TA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 malwarescore=0 spamscore=0
 adultscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606030226

On Wed, Jun 03, 2026 at 08:29:26PM +0530, Nabige Aala wrote:
> Shikra SoC uses the same MDSS/DPU/DSI hardware as QCM2290 (DPU 6.5),
> sharing the same register layout, DSI controller and 14nm DSI PHY.
> Add qcom,shikra-mdss to the qcm2290-mdss binding compatible enum
> rather than introducing a separate binding file.

Why are you introducing the sole compat string instead of using Agatti
one as a fallback?

> 
> Register qcom,shikra-dsi-ctrl in dsi-controller-main.yaml alongside
> qcom,qcm2290-dsi-ctrl, and update the qcm2290-mdss patternProperties
> to accept both SoC-specific DPU and DSI controller compatibles.
> 
> Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
> ---
>  .../bindings/display/msm/dsi-controller-main.yaml  |  1 +
>  .../bindings/display/msm/qcom,qcm2290-dpu.yaml     |  4 ++-
>  .../bindings/display/msm/qcom,qcm2290-mdss.yaml    | 34 +++++++++++++++++-----
>  3 files changed, 31 insertions(+), 8 deletions(-)
> 

-- 
With best wishes
Dmitry
