Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF2C20E6E2
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 13:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778680049; cv=none; b=JZZkXyjyHQkedKz6Hd6aJMbKwFKd3NN/NF+0KpB0RpzHaxyNO5WczMRc7/wYZELN23ugjN5f3R5TtFVhxvJj6ObmZ79Uu6qF6TNXtJViorz7UmPzG6TcIaYZACg/0MGv7pvAaEFLD+L7GCK6wbj1u1345OdaCGzSLrBv+LC7uig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778680049; c=relaxed/simple;
	bh=PFMRWD1DzQUsbBzuHK/L3Y9G3Gpl6I9x5VQNYXCV6uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UwEMaNyWQMByuQeKceXgZ6lbgX1jWW9ynU3QLfe43wHX2kPzSSbgbYTeYiI/4AehV3/SpLPEmxd8Z2wWJDvkyismiiEi3SrydfO0hhQb3w9aywEROeLvNfjyKHUqOuIK4+z8c5ttoNTQOgUmwK5JtT1MCuxwclRnqRYgGAyhO28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=erl5IoFj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LIbSk0Dy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="erl5IoFj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LIbSk0Dy"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64DAVGSx3430122
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 13:47:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=gF9m9TlU439Pia82PPMay5Pd
	uiP3AVmilaTFV8rnjwc=; b=erl5IoFj7hZmKlle1t2SU1AbF7+yoZbDYxwXbYoc
	WcN7vE88IQs9T5qa0B7guptaUFApBLVZsT+3baHrTtq8jT52vl96uSK/rLCPq0WJ
	lzHUhbyg7lLerNL82KxLoIrVwy1D48aOFoQwRNiqg/kBzTdE8H7tALci44lMt43U
	cv1KUhlTw5oRGwJKGGDXFKbZ+VZg045glNAqNLORKRV2hZclcMDGJsLHSrBXgTWj
	JzNwhukw9hpl1MqT4aEw1WlK2+Kwt7UEuscfcrUffESGFLg9q5vGQZzsCxkI4Klp
	NFVTfMXdMFLeyBiZZFVnDO/s7yUJvJ+r4P+7xHRtKQmSsQ==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4qmcgpdw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 13:47:26 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-63230863010so4633609137.1
        for <iommu@lists.linux.dev>; Wed, 13 May 2026 06:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778680045; x=1779284845; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gF9m9TlU439Pia82PPMay5PduiP3AVmilaTFV8rnjwc=;
        b=LIbSk0DyXV84opqtMX6CAUfGzJaTg99Iun/ZiJ25wRyfx5D6BezHT3MmI5jbKTkDW4
         G9tEk269A6CaRFfWU4d6PvpCSeGp5Efe+yKsnmtCCv4KcW2cLDVFZZV85S7DtAZwlQlz
         Y4ClQ/UE/EwrqfqDkzPjmLj605KjqLBRdbJ38i8XT6JlbvkBQGYXbar2Vz6PwShnzfVn
         zxPAXMBrbfJszt4JP5qaHu7Vh7TCfLKpE9O0pV/jlbCJ0aFZUQDv2EFYXMOetPmHFbfM
         +2N/lgUkwfjASYGmL3kDYj0fAX36YSeNhofSLl6ZGyxou8xlexYVALkJ1wTKR1ZQ69bX
         D+yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778680045; x=1779284845;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gF9m9TlU439Pia82PPMay5PduiP3AVmilaTFV8rnjwc=;
        b=WVKdRjGkSYBjTca6J0J3JfNgo2EmyFJTrUZ6EmhNyy42Vzmi/l2W+YAPPZWvSEAlYt
         MkUpAtjTfvjc5S5UAwQsDqdmql20CMJGF8sujDNP3OJr/QQT9ZxkJ7V9zET4GMCgWMJy
         AdnPKF7MMDmniGa2uJyBgc19W6PmVMZV+eLn1D63r8RDD7Ti/L+1g+Rd0nebDuszFmmO
         2xxreFy/6SBE0aFzW9oryXhqAzOorc1kDgh4pAFfH7qwh74BvBYo6s1ZbI3j66Tn1qa3
         mnnSdtgvKcON8sbgbH+aq6bf0kspvN6W+XJ5q3wviBQ17nPzuMVrKLBTHAXJURWTabdu
         IdaQ==
X-Forwarded-Encrypted: i=1; AFNElJ/4oE0pKAVFIsL1Fy2pNJUbZ4voVIhw+bkLKu7tq2NcKnLgBUZYSOdgeGSnIO3XlSmi/0Jtsw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzdhuYiRZwmKmpJdBF89sB7QGLTD2KzhsuOWQ6dpTOGH6rhqMIz
	SKZIm8U1CqV4M/xYVNN2goDrIOlUk1HqY/Q096kq99EdVvU91Ln63GALlnV3W4TACYr/HVFZGsX
	vrMFTLxYqAnzwUx1Hpt5dy6JqesYf0v/rxkMxX70WQF35heQS+DgqXBV1ew==
X-Gm-Gg: Acq92OFR8ZlbclHQaXxv0DPXbWO8rFUzvLsF+vNbXp6M0Ry68jk6m2ZKiCIUeovFOSd
	Zx2NZCu3+xH43gOCtKM8TK0Sj+1TLmC1plcmES72JHVmiDbYkrEMSNKj9omb3pWBvkdCt6akwsx
	9PvnAo8eDRc/KB7rK5ztxlLPV4HyF57odvRGskKosShDtV0Eoxww87kbvDLd5dJ7EA8BvIiLefF
	3NV69u65QbsgKiQpdzL1pxtbmMGIHiHVMd2OgCFSdodPvghvKbNGT8VSANTiBx8yHOxsn9qCnnK
	B5KK8o/5vVBOBdL13XK/IS+l8eFE9WpJzfUQ//XjDgRlzSsduUZezs1EuwjlXNhbkG/dDljSPig
	IdrqbwmNBG+K+zuvGtm/TBVM36PzYzXoopt1RMePwbp7bG/XUk7jox8Ujl9bxVsb04012gQaiCS
	nlK4QON6XRuEWpLxaL2l0Es49EZCersm/61T0=
X-Received: by 2002:a05:6102:1512:b0:62f:3e1d:a55a with SMTP id ada2fe7eead31-637a6c28831mr1286289137.2.1778680045483;
        Wed, 13 May 2026 06:47:25 -0700 (PDT)
X-Received: by 2002:a05:6102:1512:b0:62f:3e1d:a55a with SMTP id ada2fe7eead31-637a6c28831mr1286271137.2.1778680044935;
        Wed, 13 May 2026 06:47:24 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a8a956b225sm4025242e87.83.2026.05.13.06.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 06:47:23 -0700 (PDT)
Date: Wed, 13 May 2026 16:47:20 +0300
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
Subject: Re: [PATCH v5 08/14] media: iris: Rename clock and power domain
 macros to use vcodec prefix
Message-ID: <cyjxjidbe4qpeb5pwv6u5yqwhldqffenzgp6z4irgxkloturt6@buswzuou2w7z>
References: <20260509-glymur-v5-0-7fbb340c5dbd@oss.qualcomm.com>
 <20260509-glymur-v5-8-7fbb340c5dbd@oss.qualcomm.com>
 <6hr42ins65rf6ftdmme5lok6ham67piz3343kdwxaff2acktcz@oipdhket32og>
 <4eef8b17-47b5-e8f0-4a44-87fdf1d69d18@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4eef8b17-47b5-e8f0-4a44-87fdf1d69d18@oss.qualcomm.com>
X-Proofpoint-GUID: pP2HgYldIpOr-wZJ7qmFXHYgP6P3q1GV
X-Authority-Analysis: v=2.4 cv=Hu5G3UTS c=1 sm=1 tr=0 ts=6a0480ee cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=T-6Eqvt1JYRBjGg4ocMA:9 a=CjuIK1q_8ugA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE0MiBTYWx0ZWRfX2RIQv9Mmp3Uo
 6ZOhr0F3rzxSzPwj0t6uvOvK9M8EHZkhPVMiuk3tEAI3oxS69LsjeyMfIa4i18N9nZch2giWe8W
 sz1c/5ESlz8Ka7fI5cCMC2NlVSJiVpgKJnHZuyBji22LGSnbgBdxr2/XQCOMQKr3tR68bUVj9PR
 JCZCHASIM2ZepR9S4Zk+NM0FpVNmdgcpM05TWV855Hx7ebcs/aJny2xHGaA3lXsRdZOLYLcEveD
 KwyiPYxre15kDqZEXPepxRSnr+6ae3OoBA4DGv6xw5erhtS4gGRYP6vYZKOFW4J1gjwnHp/sas3
 p+dvaaBeBMZOt+dAN9MGNRyFXAUnxFixseeCGQKgyQMCLeGLPCG/OpRffiAYciz1tHSLDXSKmyH
 AA+gkydXkRMGl8HxdxXdypJtt9f6vGHy3WONcFr38SOXmmyeO0cji3Jykbvr0gQvY0gGiqdNYz9
 g65ccs9GvWdc9ejQ0lQ==
X-Proofpoint-ORIG-GUID: pP2HgYldIpOr-wZJ7qmFXHYgP6P3q1GV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130142

On Sat, May 09, 2026 at 10:37:20PM +0530, Vishnu Reddy wrote:
> 
> On 5/9/2026 1:52 AM, Dmitry Baryshkov wrote:
> > On Sat, May 09, 2026 at 12:29:57AM +0530, Vishnu Reddy wrote:
> >> The current clock and power domain enum names are too generic. Rename
> >> them with a vcodec prefix to make the names more meaningful and to easily
> >> accommodate vcodec1 enums for the secondary core for glymur platform.
> >>
> >> No functional changes intended.
> >>
> >> Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> >> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> >> ---
> >>  .../platform/qcom/iris/iris_platform_common.h      | 12 ++++----
> >>  .../media/platform/qcom/iris/iris_platform_gen1.c  |  6 ++--
> >>  .../media/platform/qcom/iris/iris_platform_gen2.c  |  6 ++--
> >>  .../platform/qcom/iris/iris_platform_sc7280.h      | 10 +++----
> >>  .../platform/qcom/iris/iris_platform_sm8750.h      | 12 ++++----
> >>  drivers/media/platform/qcom/iris/iris_vpu3x.c      | 21 +++++++-------
> >>  drivers/media/platform/qcom/iris/iris_vpu4x.c      | 30 +++++++++++---------
> >>  drivers/media/platform/qcom/iris/iris_vpu_common.c | 33 +++++++++++-----------
> >>  8 files changed, 67 insertions(+), 63 deletions(-)
> >>
> >> diff --git a/drivers/media/platform/qcom/iris/iris_platform_common.h b/drivers/media/platform/qcom/iris/iris_platform_common.h
> >> index 55ff6137d9a9..30e9d4d288c6 100644
> >> --- a/drivers/media/platform/qcom/iris/iris_platform_common.h
> >> +++ b/drivers/media/platform/qcom/iris/iris_platform_common.h
> >> @@ -49,14 +49,14 @@ extern const struct iris_platform_data sm8650_data;
> >>  extern const struct iris_platform_data sm8750_data;
> >>  
> >>  enum platform_clk_type {
> >> -	IRIS_AXI_CLK, /* AXI0 in case of platforms with multiple AXI clocks */
> >> +	IRIS_AXI_VCODEC_CLK,
> >>  	IRIS_CTRL_CLK,
> >>  	IRIS_AHB_CLK,
> >> -	IRIS_HW_CLK,
> >> -	IRIS_HW_AHB_CLK,
> >> -	IRIS_AXI1_CLK,
> >> +	IRIS_VCODEC_CLK,
> >> +	IRIS_VCODEC_AHB_CLK,
> >> +	IRIS_AXI_CTRL_CLK,
> > Why AXI_CTRL is better than AXI1?
> 
> Glymur has 3 AXI clocks: axi_vcodec0, axi_ctrl, and axi_vcodec1. Using
> positional names like AXI0/AXI1/AXI2 doesn't convey their purpose, whereas
> naming them as AXI_VCODEC_CLK, AXI_CTRL_CLK makes the intent clearer,
> especially when platforms differ in the number of AXI clocks they expose.

=> commit message

> 
> >
> >>  	IRIS_CTRL_FREERUN_CLK,
> >> -	IRIS_HW_FREERUN_CLK,
> >> +	IRIS_VCODEC_FREERUN_CLK,
> > Can we at least group them too?
> >
> >>  	IRIS_BSE_HW_CLK,
> > Is BSE a core or a codec clock?

Unanswered

> >
> >>  	IRIS_VPP0_HW_CLK,
> >>  	IRIS_VPP1_HW_CLK,
> >> @@ -206,7 +206,7 @@ struct icc_vote_data {
> >>  
> >>  enum platform_pm_domain_type {
> >>  	IRIS_CTRL_POWER_DOMAIN,
> >> -	IRIS_HW_POWER_DOMAIN,
> >> +	IRIS_VCODEC_POWER_DOMAIN,
> >>  	IRIS_VPP0_HW_POWER_DOMAIN,
> >>  	IRIS_VPP1_HW_POWER_DOMAIN,
> >>  	IRIS_APV_HW_POWER_DOMAIN,

-- 
With best wishes
Dmitry
