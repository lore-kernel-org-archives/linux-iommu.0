Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD03E3C9ED3
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 19:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773429991; cv=none; b=psVNopfptXTH1FO/6uCka1joxtu0voQj03eM5MeblnyrT+0ORu8vg6QguPuN/3piZ4qhgU2CkBrzVN2n+2Aw/V+SN7JqafGdAcohiuXNvOFECPG8oCPGLTsfbKFwACzZtO9lgPTiXv5E1rkuCytbrzu4hmHeENndKbGvlwngZmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773429991; c=relaxed/simple;
	bh=8qklSwhkzcL2i0FUcmPEuAOaEBNcOlNKtMbVnRnlnh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kn3kdqXYRcrb1OEzBU8dEqm+8aIWfE118binfu4kIqHNWn7vrbFNnx1FjELWt7iSJAVmBfcUJD72dUzB/GwvS+98x9RY2DvFKHe488yXngEFNnnrD3gysWBC5w6NcflZlAqDnYC1EcJm6T34gicVhnHCWMIz+WQcNmqEFEqEHw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L2MEXNLp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CqN4E7lq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L2MEXNLp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CqN4E7lq"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62DC4Khx4140660
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 19:26:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Gu4i8EY5jRW+kuyiSAZMPIOl
	Ib5K+fyqNexYKEDD+ZM=; b=L2MEXNLpL8yi4Fm0iGveqBBoZ/ddtzANVo4reVIZ
	N055goNW9gTp6ccKvM3PchEEs9Pp4Qo52iFrP2k0zCX3dEhmaNmF/A+HUqtZZF3x
	7cfxcrkD3JO5Q+X1hHVJ6BgsWkgEgKrEHaOX3AixdOcZTev2pDCTsBulXHtphaTW
	8RDmRuhhE0fv4MgBw9qXNb0GnVdAK7ECf3yV4X4P0/BoLGQ86hixHa0EXWn4WDTb
	p9YYgJM5ijne0+gkHGtoZXnCJwEpZSqR+bZHuLaVLqrmm58PM3NUVAT66qb2P8Q8
	mhFnTVdH37UuIrPEu3tgSFMgHrhL4/av1lOaYW1jmJ8o+g==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cvbn2aybu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 19:26:29 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-5ffaf5b522eso19645187137.1
        for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 12:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773429988; x=1774034788; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gu4i8EY5jRW+kuyiSAZMPIOlIb5K+fyqNexYKEDD+ZM=;
        b=CqN4E7lqtphqBmsc/tTrmrL4/FOjEYRjSgXtBRMFMHQfiDZFRiA991oKB518/FKRwW
         /40mQ6kJR7QD68M7eGK8oqeX36X+plR6Kg0uJbznfm16Edt3vAFooeEbkWp/PuCgi81v
         RUyij+lWHqzo4r9R4o/0AGu26FXnAeniOJkeZhPJatEq46uI6l30+bsY7+oeGdIdlyri
         wpUpCRLu3Ug9REPPNfKIGh8Ks6IHZN+kRdXkGO2Q1ko01pr101Qht1+WLjMdOLRc69T2
         nRX/fEn0A57UiwyfhkjM4qzTlE5lUfMtXF2i8V/fhn3iFh+kRosFojOdWYUzWl3Mkp39
         kFhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773429988; x=1774034788;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gu4i8EY5jRW+kuyiSAZMPIOlIb5K+fyqNexYKEDD+ZM=;
        b=P8VhMDTOqznEkyoQQdaLRvZ+bepiHAzlLO+HVq0sdnX9vEVmYIFugSzit+Ho6SmgkQ
         9FNO2NAlmQ9GP2JlcRC2VuDs3R69J6mKbiivU0+tRiMlla0AnlWTHCyGUh44kYn8ik8L
         /w5xqLt7VdPRWQG1RllquKmv03KHFye2MZtw2Ky8B00TV5F9nFAa8OqumbSVqRGiwXzt
         wNGjaxY/Qo0VpKWoQw+mEo/dedBA9FL9wpkVSMI44gSRJOMnacOlNlYOZKZF+NF/pC/L
         xuEDEOji9PMRoqTqAuIqN41DST5qRyFf4trzwaeZ/Uz5lwqvSCXK4QOtkR5XlFkUBFE4
         TJZg==
X-Forwarded-Encrypted: i=1; AJvYcCXqWh6Dncklcfx0pQd/XGw8h3fy3ajQfA98Q6fJPXDYVgk2c4Er6Jv4lJw/PuCFedP5mZeDow==@lists.linux.dev
X-Gm-Message-State: AOJu0YzeglwHUInkYuBBbQ3mQ0mfTRvexrRirCxlfcRSOV7sbV5fqJSt
	wrz9yzJVW1HYACtJL3BdNK1niAliVvb6gkYoAAJBRQAlN2s54LB3bpV7mdc+Ih3tInlP20E7vOe
	oaK4ALGM6l4ZSCgzDbbGCvs/Ham445i3veKnfoONcZKc0ao/DZYNKEg+Nug==
X-Gm-Gg: ATEYQzwHN9ZDROFs6NRMyuRuRAkx7DbJJclKcdmDYiqOV2adS4+PkEElV5hgq9rNhbL
	CZHfJvhVUN0c50vRc1+cstwF/AR3GdWlUMgeIxcBJASyUqllyx5AFXc78rH69E/Ie2fZr9jMwA/
	o8zx2kJ+ldrqrpGofRk7wrKRJQPpOTIKBhC6edKL+xuCGMHLxfBCYpzuBhcgbKi8Y+5L/xGkXUK
	WFwGemtfT87sH4xjz8RBQ7ubySmvQIFb+eOhbklwagTVslxQAkW+4XuLRnXSTep6qRYpp3/i+PP
	WVzzihKwv0qnC9enNutMG1HTEF1g54AgGQHZr4E54NKUDpWXqHxqtKf7M/hGd6WsKgxf2ZNqeID
	eSiDEYkmL5sCEgruUYkoQFWLEjNw+ZrpPIO1dN03lsM0Psbk0TN9hdP2w3JyZqK1qK8EAPFjl6B
	ZTBSLXMn9Tj+r4JljyFTcUkcEdHbklPh32CPM=
X-Received: by 2002:a05:6102:442c:b0:5ff:b684:f7c5 with SMTP id ada2fe7eead31-6020e209c34mr2211730137.8.1773429988048;
        Fri, 13 Mar 2026 12:26:28 -0700 (PDT)
X-Received: by 2002:a05:6102:442c:b0:5ff:b684:f7c5 with SMTP id ada2fe7eead31-6020e209c34mr2211704137.8.1773429987480;
        Fri, 13 Mar 2026 12:26:27 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38a67d617e1sm15780241fa.9.2026.03.13.12.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 12:26:26 -0700 (PDT)
Date: Fri, 13 Mar 2026 21:26:24 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Hans Verkuil <hverkuil+cisco@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: Re: [PATCH v2 4/7] media: iris: add context bank devices using
 iommu-map
Message-ID: <yohjrtv6tkqy7ezcfeheoddsap2r2rmvp52fbpiyxvei3t7g3q@c6xdashllwom>
References: <20260227-kaanapali-iris-v2-0-850043ac3933@oss.qualcomm.com>
 <20260227-kaanapali-iris-v2-4-850043ac3933@oss.qualcomm.com>
 <rzi7qmzsofocwcqxhsqz3f3tl4ahqnwn34of6qcc54odpben5d@7okuqabxgdqh>
 <e12da06d-cad5-4967-af07-64c7c6e540f4@oss.qualcomm.com>
 <vi5v5bczg2wx2adfpr6ppqcad76oecitoyc7zd2i4lahla4buw@mqnppboxcyrs>
 <6553cfcb-9399-4d17-a529-b07b421ed7e8@oss.qualcomm.com>
 <mqyg7cebyahkrngvnxcrenkdd3dybpnkecago4lqonfwqzize7@yawbtcsli3vi>
 <1d2b55d9-42e3-4459-971b-e276a87fb843@oss.qualcomm.com>
 <7wvdcjajf7ro3c4y7jq6tmbxfg7kfvdpmyfzqm4vgjw5wly4zu@jcjqudf7vrgd>
 <9d5aab4c-86be-46cb-8c2c-154f87e3eeba@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d5aab4c-86be-46cb-8c2c-154f87e3eeba@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: 4Yxfh3fHBiZo_6cWpXn4hSEvbtSoJAKl
X-Proofpoint-GUID: 4Yxfh3fHBiZo_6cWpXn4hSEvbtSoJAKl
X-Authority-Analysis: v=2.4 cv=ZKfaWH7b c=1 sm=1 tr=0 ts=69b464e5 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=keo7-XgEt2IHayEatcwA:9 a=CjuIK1q_8ugA:10 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDE1NCBTYWx0ZWRfX2j1oA0K7jprl
 G0DHCpt6mJYdiNYl0ZWG49ETVOrGo1Bd6rggb3+LST8NDJAWKJh26/xxklVIRa4/W//EUEfZlud
 WDi3uV9FYm3l8EqRJBR0zfZoB+iOWOsM+b4RR3y/juwv6Zu6t5FEouR+9p2KkzsaoYIo+MP08/Q
 YjzQIPo5E5Pkc/AP/MvcVJw1drYxDNfPH4M999TDoZ3ZW6a47FWU0rx3lFfHFpCc+K0HLdtEv3U
 HzHI+j+vlyY+reuldU/ms/fH7PYVwF4X9UIysuGeMYkX4WHAcvbCS2I8RJCB5PLbqRKH6qli5ch
 EmqvEFMQd5ZHTRPOnTzB2/Ms0CUvfWNJI6IjGSbP1zLFl1/qdJpo4b6msRM8Hlc1sN+l+x2nbUJ
 sIFf7xlRF8PO9czIMv/y77+fFyqz9UU04xmPF4bF1XsOco5+hyNLi1QsCYeL8wsSQjx7k7CZEdC
 Cf0/PgyJNH2KdsOCR8Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_03,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130154

On Fri, Mar 06, 2026 at 03:04:04AM +0530, Vikash Garodia wrote:
> 
> On 3/6/2026 12:02 AM, Dmitry Baryshkov wrote:
> > On Thu, Mar 05, 2026 at 10:56:40PM +0530, Vikash Garodia wrote:
> > > 
> > > On 3/5/2026 7:51 PM, Dmitry Baryshkov wrote:
> > > > On Thu, Mar 05, 2026 at 06:19:52PM +0530, Vikash Garodia wrote:
> > > > > 
> > > > > On 3/4/2026 3:55 AM, Dmitry Baryshkov wrote:
> > > > > > On Wed, Mar 04, 2026 at 12:16:50AM +0530, Vikash Garodia wrote:
> > > > > > > 
> > > > > > > On 2/28/2026 1:50 AM, Dmitry Baryshkov wrote:
> > > > > > > > On Fri, Feb 27, 2026 at 07:41:20PM +0530, Vikash Garodia wrote:
> > > > > > > > > Introduce different context banks(CB) and the associated buffer region.
> > > > > > > > > Different stream IDs from VPU would be associated to one of these CB.
> > > > > > > > > Multiple CBs are needed to increase the IOVA for the video usecases like
> > > > > > > > > higher concurrent sessions.
> > > > > > > > > 
> > > > > > > > > Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> > > > > > > > > Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> > > > > > > > > Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> > > > > > > > > ---
> > > > > > > > >      .../platform/qcom/iris/iris_platform_common.h      | 18 +++++++
> > > > > > > > >      drivers/media/platform/qcom/iris/iris_probe.c      | 60 ++++++++++++++++++++--
> > > > > > > > >      drivers/media/platform/qcom/iris/iris_resources.c  | 36 +++++++++++++
> > > > > > > > >      drivers/media/platform/qcom/iris/iris_resources.h  |  1 +
> > > > > > > > >      4 files changed, 111 insertions(+), 4 deletions(-)
> > > > > > > > > 
> > > > > > > > > diff --git a/drivers/media/platform/qcom/iris/iris_platform_common.h b/drivers/media/platform/qcom/iris/iris_platform_common.h
> > > > > > > > > index 5a489917580eb10022fdcb52f7321a915e8b239d..03c50d6e54853fca34d7d32f65d09eb80945fcdd 100644
> > > > > > > > > --- a/drivers/media/platform/qcom/iris/iris_platform_common.h
> > > > > > > > > +++ b/drivers/media/platform/qcom/iris/iris_platform_common.h
> > > > > > > > > @@ -204,6 +204,22 @@ struct icc_vote_data {
> > > > > > > > >      	u32 fps;
> > > > > > > > >      };
> > > > > > > > > +enum iris_buffer_region {
> > > > > > > > > +	IRIS_BITSTREAM_REGION		= BIT(0),
> > > > > > > > > +	IRIS_NON_PIXEL_REGION		= BIT(1),
> > > > > > > > > +	IRIS_PIXEL_REGION		= BIT(2),
> > > > > > > > > +	IRIS_SECURE_BITSTREAM_REGION	= BIT(3),
> > > > > > > > > +	IRIS_SECURE_NON_PIXEL_REGION	= BIT(4),
> > > > > > > > > +	IRIS_SECURE_PIXEL_REGION	= BIT(5),
> > > > > > > > 
> > > > > > > > Can a context bank belong to multiple regions at the same time?
> > > > > > > 
> > > > > > > yes, they would.
> > > > > > 
> > > > > > How? Each set of CBs is defined by a separate function in the DT. How
> > > > > > can CB belong to multiple regions? Could you please provide an example?
> > > > > 
> > > > > SM8550 would have same stream id for VPU hardwares (tensilica and vcodec)
> > > > > accessing bitstream and non pixel regions. Thereby non_pixel and bitstream
> > > > > regions would map to one CB.
> > > > 
> > > > In my opinion it means only one thing: you will have two CBs (one for
> > > > non_pixel and one for bitstream) having the same SIDs. An alternative
> > > > would be to define fallback rules (if CB foo doesn't exist, use CB bar).
> > > > 
> > > > > While kaanapali would have different stream id for tensilica accessing non
> > > > > pixel region and vcodec accessing bitstream region, thereby having different
> > > > > CB.
> > > > > 
> > > > > > 
> > > > > > > 
> > > > > > > > 
> > > > > > > > > +};
> > > > > > > > > +
> > > > > > > > > +struct iris_context_bank {
> > > > > > > > > +	struct device *dev;
> > > > > > > > 
> > > > > > > > Separate data and the actual device. Define a wrapper around struct
> > > > > > > > device for the actual runtime usage.
> > > > > > > 
> > > > > > > we still have to store the list of dynamically created device. Name can be
> > > > > > > used to fetch the device from the list, i think the existing approach is
> > > > > > > simpler ?
> > > > > > 
> > > > > > You don't need a list. You have an array of the size, which is known and
> > > > > > fixed. You have at most 9 functions, which means less than 9 devices.
> > > > > > 
> > > > > 
> > > > > as mentioned above, its not the same for all platforms to have one to one
> > > > > mapping between CBs and buffer region. Thereby indexing based on array would
> > > > > be an issue here
> > > > > It would end up something like this, considering [dev region] array,
> > > > > 
> > > > > SM8550
> > > > > non_pixel_device  non_pixel_region
> > > > > non_pixel_device  bitstream_region
> > > > > pixel_device      pixel_region
> > > > > 
> > > > > kaanapali
> > > > > non_pixel_device  non_pixel_region
> > > > > bitstream_device  bitstream_region
> > > > > pixel_device      pixel_region
> > > > 
> > > > I'm sorry, I'm not sure I follow here. Could you please explain? Maybe
> > > > by explititly mapping DT function values to iris_buffer_region values?
> > > > 
> > > 
> > > Kaanapali
> > > IRIS_BITSTREAM IRIS_BITSTREAM_REGION
> > > IRIS_NON_PIXEL IRIS_NON_PIXEL_REGION	
> > > IRIS_PIXEL     IRIS_PIXEL_REGION
> > > 
> > > SM8550
> > > IRIS_NON_PIXEL IRIS_NON_PIXEL_REGION | IRIS_BITSTREAM_REGION
> > > IRIS_PIXEL     IRIS_PIXEL_REGION
> > 
> > So, why not:
> > 
> > Kaanapali:
> > 
> > iris_cb_dev_bs = iris_cb_dev_alloc(IRIS_BITSTREAM];
> > iris_cb_dev_np = iris_cb_dev_alloc(IRIS_NON_PIXEL];
> > iris_cb_dev_px = iris_cb_dev_alloc(IRIS_PIXEL];
> > 
> > core->cb_devs = {
> > 	[IRIS_BITSTREAM_REGION] = iris_cb_dev_bs,
> > 	[IRIS_NON_PIXEL_REGION] = iris_cb_dev_np,
> > 	[IRIS_PIXEL_REGION] = iris_cb_dev_px;
> > };
> > 
> > SM8550:
> > 
> > iris_cb_dev_np = iris_cb_dev_alloc(IRIS_NON_PIXEL];
> > iris_cb_dev_px = iris_cb_dev_alloc(IRIS_PIXEL];
> > 
> > core->cb_devs = {
> > 	[IRIS_BITSTREAM_REGION] = iris_cb_dev_np,
> > 	[IRIS_NON_PIXEL_REGION] = iris_cb_dev_np,
> > 	[IRIS_PIXEL_REGION] = iris_cb_dev_px;
> > };
> > 
> > 
> > Yes, it would require coding of those functions, however afterwards you
> > can access necessary CB device simply by doing core->cb_devs[region].
> > 
> > I think current code is overcomplicated for the sake of having the
> > platform flexibility expressed as data.
> > 
> > > 
> > > > > 
> > > > > 
> > > > > > > 
> > > > > > > > 
> > > > > > > > > +	const char *name;
> > > > > > > > > +	const u32 f_id;
> > > > > > > > > +	const enum iris_buffer_region region;
> > > > > > > > > +};
> > > > > > > > > +
> > > > > > > > >      enum platform_pm_domain_type {
> > > > > > > > >      	IRIS_CTRL_POWER_DOMAIN,
> > > > > > > > >      	IRIS_HW_POWER_DOMAIN,
> > > > > > > > > @@ -246,6 +262,8 @@ struct iris_platform_data {
> > > > > > > > >      	u32 inst_fw_caps_enc_size;
> > > > > > > > >      	const struct tz_cp_config *tz_cp_config_data;
> > > > > > > > >      	u32 tz_cp_config_data_size;
> > > > > > > > > +	struct iris_context_bank *cb_data;
> > > > > > > > > +	u32 cb_data_size;
> > > > > > > > 
> > > > > > > > Do they differ from platform to platform?
> > > > > > > Yes
> > > > > > > 
> > > > > > > > Mark them as const, it should be data only.
> > > > > > > 
> > > > > > > cb_data_size can be marked as const
> > > > > > 
> > > > > > Why is cb_data non-const?
> > > > > 
> > > > > dev is being updated once created dynamically.
> > > > 
> > > > That's a bad idea. Please make the platform description constant.
> > > > 
> > > 
> > > I can give it a try to move CBs in core struct out of platform data and have
> > > a buffer region based lookup array to fetch the device.
> > 
> > It might be easier to express that as a callback, filling core->cb_devs
> > with struct device pointers, as I wrote above.
> 
> IIUC, introduce an ops like below and fill ore->cb_devs[] in SOC specific
> data i.e sm8550_data ?
> 
> struct iris_platform_ops {
>     int (*populate_cb_devs)(struct iris_core *core);
> };
> struct iris_platform_data {
>     const struct iris_platform_ops *ops;
>     /* ... other pdata fields ... */
> };
> 
> At present lemans shares the platform data of sm8550, with the above ops
> approach, that commonality leverage would be lost ?
> 
> Please correct if your proposal is different than what i interpreted.

Yes, it was just about the callback. You've coded it again as a loop of
bitmasks. My opinion would be to just have platform-specific easy
callbacks without extra generalization.

> 
> > 
> > > 
> > > Regards,
> > > Vikash
> > 
> 

-- 
With best wishes
Dmitry
