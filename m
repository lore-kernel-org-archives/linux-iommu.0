Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B3F339705
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 13:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778678988; cv=none; b=tl9qlMPvxO6piAwKJSrlxqfBjQxSEwheGgK3N4yRYnkTl5Z95bxFsCkvYtecuFPheJwVn89OaKAHWvDLHclLbT2z/P3EqZ+3NeBX83/lBgiJNfLzbKVL3vUKccVCwxFhL6WGc/Uw3a3CO4MTSBanv7DJ9qZ61/lqYgAlHpXC4ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778678988; c=relaxed/simple;
	bh=h9cHbTVyfhhkh4MZ7cuH7Nx1qQBZMTByeT7Av+06L84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RoDuhhHfZ9rZp2mIRvcPPwbO3sHkMFEBQNrucKAWv14cBY2HMaCMSBejdStLfimZb2mvdUvg04k83ySdD42kcLnzI5HMbG1gyvuSklKDtzenCQR0imgRoB+Bpmql8XtKTQ9xF+Lebm3W9x0eW4yt77Y9hGooIPTs4nzTA+9flT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mQda1NVv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XwTFY7Yr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mQda1NVv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XwTFY7Yr"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64D8n8ot2887813
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 13:29:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=GLjjvr/kpXFgzi3+oKZJpIGO
	I2o5W4/4aQXjO084tiA=; b=mQda1NVv5KwohwetVTbmGEfBIO+FzlXUzEeFfL+f
	MEuzjd2Rrxsq+j+0AIeZFf9hHP+93At7QqGJp+QctIZLHltNXqNP7AmUPAm8KWRO
	3Yt6dy4fNJtvozMCrpbtRt3jHwZstumctAZKPXD8fnd8ttnnTV+buWUU584RfYQj
	XiRA6VbTeZhFNy/TUx/K8njvSD9N2t7v76pzMY3Xzb9OwSFYBCX0yVIFX1CQbYTF
	5NxSYt7oAhC1NU2Z5A4uk9TWqaDM2OEL6mxB3wVR16q8xNSIBtyNSCncDnKCutqs
	2PSAYJP8kqDbA0Z+x8u1xCD8OAFvWw4aPMKRLL/EN1l36Q==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4p4gh115-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 13:29:45 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50edf01172bso8175661cf.2
        for <iommu@lists.linux.dev>; Wed, 13 May 2026 06:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778678985; x=1779283785; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GLjjvr/kpXFgzi3+oKZJpIGOI2o5W4/4aQXjO084tiA=;
        b=XwTFY7Yr2yIsU2ut0y2+C5OhHILOkJP4oarRvOxdZOlCtMcA72ZhHNd7dVHWrW9djk
         sv4hWl5WZR0clcErjc7TJRW+BAmZHzg0EmTeu4gnwCkvBPTx77vIxIrxmLsE6+KhPHxf
         oxh7LkLgV2OHf+qymaZPs6s2zIbBvaXBlUMITWZZUQC84tLMuGFizaWektVqgX3JTR/o
         4yOkqyOzUm3GVa3i82u5F/uJlSAFyrcLxn4uW+PHL+EwdDnIeeo2JUU+AFdNYp6Hjh0p
         LHmMWvF9AXq/K7xMlV9gixiJGg7zGQzttsigdgJmX0ZBP0V0MJXSIqXqtMOLQ2hdkVb5
         lFOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778678985; x=1779283785;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GLjjvr/kpXFgzi3+oKZJpIGOI2o5W4/4aQXjO084tiA=;
        b=JLZmbqyAdi7Z9D+O0KawVqYxjP+i3zS+TscIRWcjvjwCye2v2NXrPVckAD8zqnJNNs
         1IbLjDI8IzADUJIQxv9vKTfM8ZZNS/Hi6RqN2e/hmP6DbooTCZnSfc7GrYPaTJ2p/WFP
         qqXsXbiX6tu+5OYKklPrEKOxufSrIMSWtnHwRz6UefV48FKtuWmZ9D36jt/U67W6smpW
         /V9m7pDJaFTOyspqmU27hObGKBBchJckVBKZZJY747/QFKPmEYlDXcwuxFgOQ1lKfgJQ
         u6sgIRRgZoOtMNJu3qC6RV1VxVYImajzursVCw4Q7i742OMSXGGQKzjrREXVg3I9eZx2
         TYCw==
X-Forwarded-Encrypted: i=1; AFNElJ+BDjTmYuLjZcKj1yJMUDEjmr+HOCTKn9dogPna+OYUDbp+aTqt4Ky9lwNb4NBAd1k3euEpPA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyiyHtIb3M+/N0ocrLK4piw0OKiFlBoToFiKjVXadR+aWYbwEh3
	pmH3JD2RzFgX7cpARnBHFhIRGS8f/rSnl6YJeDA4kSjaU5hCpAQUBoAN31aqMIfZ9UOIbKjWKxl
	KAsdctoYLc4ZmIzIeOXHJutrUYopLLJinjTxEMHY85KnDeVTD3SOF+WqiAQ==
X-Gm-Gg: Acq92OEi8BX65fJylVRFe4LLqj1gPQmTU9x3zFTVd9u/+XTSp+jVTgsGBYpKU1SH42B
	1g/xvhw9ru0Y914RKVaqMQzmamsAG5JkyswLV95TmyeBTORxdqkdoegrZfYdk5ccEqCA8yQxVzB
	Ql93h2W1QRtl2es6YJKfJNuQG/owWyez3MfwubVW/BDJBUEDPLRsFxmTVZ9UBIKZXFqoqLxC2jh
	3OZx4ZciqBrEBpbSTkw250oRclmB4f2Sf8rc5gAn+hp2QXe4ZojYIwl2G6EXUBmEnMTE8PolAMr
	voeNjDSwz6NkI7p/0k4PlJfgHKMuX+diPElSAhUIfgtFJvNOyAGOsnsw4ZXPVWem8QRP0mx1x9V
	jZxgDi9e8NAW1YVzb3fKTv8zQ7bJ4vsC1eHDLQfLlNkoyJz63kGiK6D9+OZ4e4XFslOrsPBGvtD
	4WBjlZjgx60MDTjZo7aFlVVFOOAlRQtQsofYs=
X-Received: by 2002:ac8:5902:0:b0:50f:c65f:a4fb with SMTP id d75a77b69052e-5162fdcffd9mr40708781cf.11.1778678984536;
        Wed, 13 May 2026 06:29:44 -0700 (PDT)
X-Received: by 2002:ac8:5902:0:b0:50f:c65f:a4fb with SMTP id d75a77b69052e-5162fdcffd9mr40708201cf.11.1778678983983;
        Wed, 13 May 2026 06:29:43 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-393f5f18ef9sm40493991fa.8.2026.05.13.06.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 06:29:42 -0700 (PDT)
Date: Wed, 13 May 2026 16:29:41 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
        Del Regno <angelogioacchino.delregno@collabora.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 04/14] dt-bindings: media: qcom,venus: Remove clock,
 power-domain, and iommus from common schema
Message-ID: <kdbo5d2wibjfnchfw7xn3wcgcp5r6ff7pw3ibkpbqzjgfhkovp@v4er4hdiytks>
References: <20260509-glymur-v5-0-7fbb340c5dbd@oss.qualcomm.com>
 <20260509-glymur-v5-4-7fbb340c5dbd@oss.qualcomm.com>
 <35zfskmyogpazxy7wsw2jg36fvpnnc7hng23j4heq2jy5ookai@q7d2vl7nn7ck>
 <fc188af5-ec7e-bebb-2654-62312d79e60f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc188af5-ec7e-bebb-2654-62312d79e60f@oss.qualcomm.com>
X-Proofpoint-GUID: wjlOqavD3iEm8WqVZuBFDsEeeoaZOVV3
X-Authority-Analysis: v=2.4 cv=DOS/JSNb c=1 sm=1 tr=0 ts=6a047cc9 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=MFmcrfekO-K-MGbKrFsA:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: wjlOqavD3iEm8WqVZuBFDsEeeoaZOVV3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDEzOCBTYWx0ZWRfX4aXdisFzp4wc
 x0sOeYmGs9aoNKHKMflUGEX7tDeEECFwyuyMZS2xA11mak8rvm1IL4v6rhiL8GH15Z2+ZZbpJud
 +JIUclbA4zs+NvdNwzg46Q2k2neVqhcGGsUzkK7nYbcAunq6K3NKjXNOHlafsZX+OM6ED0FMbNo
 Vge9IVrf5aSd3e6iwNODaPEgQSgVI4FAhP0xrBnwT3H/iurW0xE52fqrH4BLXQTV1wKHHWA1oh3
 tIaFsaV0aru0FkxBI9cjDBvcw/PFM3y+WwgM0XnMuEIr3AYb3CBgcZVWKtkZCdviLQhAlnnHDRl
 3Ibg3C9xMl8c+spGlvuLgZflOG3LXFvNABKovqln9/9OpsCeMweLUHdcKD0HBY3322eDx17aH/D
 oCRWIwXwVNp31Ss7Co20rdOivFE/Ql8gLg6eP+trN9iNJZsF94+hjunhKarMD8OfC6VtrgfJ1Vt
 Wvk0JwiH7HffvBr0vSQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130138

On Sat, May 09, 2026 at 10:34:15PM +0530, Vishnu Reddy wrote:
> 
> On 5/9/2026 12:52 AM, Dmitry Baryshkov wrote:
> > On Sat, May 09, 2026 at 12:29:53AM +0530, Vishnu Reddy wrote:
> >> The common schema defines minItems and maxItems for clocks, power-domains,
> >> and iommus. This suggests that the number of these resources can vary,
> >> while in reality they are fixed constraints per platform.
> > It really doesn't. It provides common definitions, while individual
> > platform schemas tighten those.
> 
> If a new platform requires more resources than the current maxItems listed in
> the common-schema (e.g.,Glymur due to its dual vcodec core design), we need
> to keep bumping maxItems in the common schema every time a new platform exceeds
> the previous limit. That makes the common schema a moving target driven by
> platform specific.
> 
> I am fine with increasing maxItems in the common schema instead of removing.
> I can set it to a reasonable value (for example, up to 20) so that it
> accommodates future platforms without frequent changes. Anyway, each platform
> schema must define fixed constraints, since clocks and power-domains are
> mandatory per platform.
> 
> Could you please let me know which one you would prefer going forward?

Just touch venus-common when new platform requires bigger lists.

> 
> >> Remove these constraints from the common schema. Each platform specific
> >> schema already defines its own exact fixed constraints for these
> >> properties. Additionally, remove these from the required list and update
> >> all schemas that reference this common schema.
> >>
> >> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> >> @@ -64,10 +44,7 @@ properties:
> >>  
> >>  required:
> >>    - reg
> >> -  - clocks
> >> -  - clock-names
> >>    - interrupts
> >>    - memory-region
> >> -  - power-domains
> > Do we expect the platforms with Venus / Iris not having either clocks or
> > power domains.
> 
> All Venus / Iris platforms have clocks and power-domains. These removed from here
> and added in each platform schema.

This is a sign that this is wrong.

> 
> >>  
> >>  additionalProperties: true
> >>
> >> -- 
> >> 2.34.1
> >>

-- 
With best wishes
Dmitry
