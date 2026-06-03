Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45CF3B3BE7
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 23:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780528172; cv=none; b=NBzBLiZlwhCxuwltJfsa9DiL+wtSE1qEgQ8vHB84MUpATDnUNV4r8FxEnIQPzQsZMInN9v/fCymSd9rpxr5u3QozC7VJF2TDwLiABerTZCYf6wMQ0Nlc0RWFU1F9UypL45WiTWGXCHIgsRSef86VXbKz0iEISFKiPZz8gWAx68I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780528172; c=relaxed/simple;
	bh=s1Mm6I6p1zGUGOP+uK+6N9Du7LT2ANqM4qrHm3ub2ow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l/+Er/mcLL7nOoZC3ZCslmjluLMalTOlqq9utACtrLQYGu0yS1IHrZUSX7BsDGh4TkFYx9uf9zBy432bc61SpT9938p9uLIsvTyRDjY1JTI4Xn9ZhXQB3mvV6mNiotHtnABvHh7HJ5UWVSHFE0ZB/LxRZFkFH/4eX7EwgPWzy5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JyZjPCpX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZSb6GPbf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JyZjPCpX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZSb6GPbf"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 653HvwYa3233934
	for <iommu@lists.linux.dev>; Wed, 3 Jun 2026 23:09:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=zYQm4k/RnCbtoz4G4uzh93rP
	8MS0q/z/Jb8qOX/3f6w=; b=JyZjPCpXDV/KRX+EmGw+f9M406g2NvLbqEMngBRQ
	XxhNUldIZ8AF+mA8uAsG9nvLfvLwoFFNgP6g97jeOqhN53SaR8EyrUipQV8B75Hd
	zch5jVCBwykJTXc8GKuEREalMTM1awlQKjGE3pv34P04rIUV76BMXhhuvCZhKbUZ
	bT/QXthdYD81vitEM1c2tzPnl536tuqRprIutirK5QgytWMQQHGS6ksQVYp6PPop
	1a/NfAhqgh6kIU6m58Uip/TpKwCjMY9RbsUQFWtp+CT9QlNFi8suBGkbnKhXGBPb
	nfuJYYql8Fya0DY10Wz3cUjKPQZ1z51ilXCpkAi9rkHHsg==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejs4s133u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 23:09:30 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-6c89de84f33so126025137.0
        for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 16:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780528170; x=1781132970; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zYQm4k/RnCbtoz4G4uzh93rP8MS0q/z/Jb8qOX/3f6w=;
        b=ZSb6GPbfgWI7Fq909sVxZQ1COsr9zUp43kpP8TJb2Hz1AUnmgJ8T4PraRDkRIHd3dD
         reDx9rvqLbPmliO+GT8jZJoLWruYCMiTt+LyQCBMuapEtZ0tjvaSHuX7aOmq7FpMkCpf
         oW0yJv1mZMrcHVqt4tMzS1LO8PGaENe27TD8zSpwRhhUwMPvV3xpBbc2m7qtrIU2hJHy
         PHbgHRjLb125Vv9doFc5M1qqb/i/uNSPRvvncZQR1AMp3bZc5kprGNeFjny9+GX4tMPR
         JGy5EKoCACqm7gb+iJDNjHxZ0ffKllBh/1KbjQsT1VOFaJakZPMdLtI1/96Yes0NWvMv
         Ae6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780528170; x=1781132970;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zYQm4k/RnCbtoz4G4uzh93rP8MS0q/z/Jb8qOX/3f6w=;
        b=np1nl99Bu8Q/ijGJUiJ4W0j/bgT1MvkEhK2BiAydllqJmCjAJCbdXDwAowBtQCs+Df
         5zU35CX/8YjKh4kd0nI99DMlf7K7rxErYNZgtC7uQF8mNiW8DW7IYJ8Qh6qNddVGqs/y
         PfzHaOjLtxz3/dC1krVJUBTnRTjnijZFpSE/5QUnTHY0CJF70FB0ueCZAJqyL3F6y1r/
         zxqtEJLSZha46hEKMXSRtn3/+/Qkh+9A39VONO5IvJ/DrN7FQcerqSfNXU1/ZoMTf4oI
         fNvo4xMDRtSwkeJCWTfcPLTB+wUysHxht37djL4u8/j67b6rg309UoeS6vDVp/9x9Bq6
         tH1w==
X-Forwarded-Encrypted: i=1; AFNElJ86Pu0P1u6jp/JOMOjGMuS60Dia2MF2ogVGlQhtVitHf1vrP45yicShEAlvpbZtCzqBpctF2g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx9QMz4LMEt17+VxxLXSwkVqmwksdga9ajBPgnL/PMOWyq0cWnL
	Ii66dZhuvuqiKBGmmrP7+HZuvS0KulhwZyoRrRyaiARklOErRkGGOZuiSgI5oB8TnzOY3cNCl3+
	h+qO5sbXG3qOAP6BdK17TL9JPBxLY+dx8Eq8iByIDdLRf2y+mB16LVV/DUw==
X-Gm-Gg: Acq92OE8iLIgsy+Z8GdPlGXJCRKQNya2MzknDL+5tOmVed/OylUASLmGJtdvpQIIDeO
	NldxQrn8nR/ZQgsAA2gQW9QuFpikTw9K5mM2YyT+kAczKcEwr+/57825nrRofjO39TdSmxPuKGz
	Xb0kcButOjfa+UR07biQ8jpsmdGsUFtE1S5B2EN17h91jRFP9qCT48Wvveh+xpOWTVF5KdWag70
	0Mftp7ENr3neTCd5qF8/RQXbs6Saqh7QQe5xK2bMiy3PH0VJEpwmxljI/gnp0sTuJiyD8tJkzBK
	/5WgyvCOztKTiB0NOSapFWYPCoZKTf31YlovhDSQMf/KjqAiVkg+r9reRVuD7VoSOqWe35ASfNG
	OdpyrWoqKeKycE4UkFvBB07pN6fU9j+wooZApMwrl/X6Kleu+SJS/1+R/Ak8v8nQlTNIxQMA62I
	VMOijw9hIbm4tOnZjYXgat2Xrtcm+XLALNFG0Io0Fm9UkQLA==
X-Received: by 2002:a05:6102:f12:b0:633:c6c4:b321 with SMTP id ada2fe7eead31-6ec4710d8d3mr3972138137.18.1780528170148;
        Wed, 03 Jun 2026 16:09:30 -0700 (PDT)
X-Received: by 2002:a05:6102:f12:b0:633:c6c4:b321 with SMTP id ada2fe7eead31-6ec4710d8d3mr3972124137.18.1780528169804;
        Wed, 03 Jun 2026 16:09:29 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b9862fesm871133e87.57.2026.06.03.16.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 16:09:27 -0700 (PDT)
Date: Thu, 4 Jun 2026 02:09:25 +0300
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
Subject: Re: [PATCH 2/5] drm/msm/mdss: Add Shikra support
Message-ID: <jw4pps5xn2a6onu6fvb66cyd5jrvw2akx7zu7rtk4ejddu7czl@lmsxmbnryjyc>
References: <20260603-shikra-display-v1-0-aeac1b94faa7@oss.qualcomm.com>
 <20260603-shikra-display-v1-2-aeac1b94faa7@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603-shikra-display-v1-2-aeac1b94faa7@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: LImGdmondO1zJqAJCg-ztnIB_KM98qTq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDIyNiBTYWx0ZWRfX4dvsfQOrlESe
 2lqctY0Vo5HJOvVG92NoYGhrUE6LhZpD1PXiqaNofq4MrzS3djXutX5cQhlEE3b5xm62jHnQFTL
 6d3kC+IxLhQUuu4c3bfB7W4iWvBZ/wxk8OE+mO4KYHDBms6mKz7fWoT08HT16QvmKPZ25w71kBp
 pxlWMQoaB1zHJQQa+ByE6FRcuTBSDPYc1eJkPoTOSukl8f2PWE6AoLNF6Nj9w4kJfUl1zuA4ERp
 J7pjFiwehFcMAVfZS8y4QZixq4PNNjyOCovoAzNqoZNNCFZGsr7JqC3htMVnlVL1oftUfBsEY6T
 0z/URf8iTOmF2KBBHoUgGdXcuAiGp48PSTVlzoItXfdV82+EDh8Ma+BM0v44nR5ndhNpK4Rqwo4
 hiNPssSwVtfjfRqZj+SffC12gVhXjjkYDK+qpHFmC6tydRddty5HnYWobxtwHJ7Hfj4b/zzXxHg
 qCcxXPBSa2GvvcdoDnA==
X-Authority-Analysis: v=2.4 cv=afRRWxot c=1 sm=1 tr=0 ts=6a20b42a cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=fWyEoBxJXmLHvYXwyp0A:9 a=CjuIK1q_8ugA:10 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-GUID: LImGdmondO1zJqAJCg-ztnIB_KM98qTq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030226

On Wed, Jun 03, 2026 at 08:29:27PM +0530, Nabige Aala wrote:
> Add Mobile Display Subsystem (MDSS) support for the Shikra platform.
> Shikra uses the same MDSS and DPU 6.5 hardware as QCM2290, so it
> reuses the same AHB clock rate configuration (data_76k8) and DPU
> catalog. Register qcom,shikra-dpu in the DPU KMS match table pointing
> to dpu_qcm2290_cfg.
> 
> Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 1 +
>  drivers/gpu/drm/msm/msm_mdss.c          | 1 +
>  2 files changed, 2 insertions(+)
> 

This points out that the previous comment was correct. Drop this patch
and use compat strings.

-- 
With best wishes
Dmitry
