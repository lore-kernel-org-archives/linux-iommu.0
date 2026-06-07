Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B25F2DAFB0
	for <iommu@lists.linux.dev>; Sun,  7 Jun 2026 21:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780868324; cv=none; b=TPHmjVTMtMK+/8UGqmVI60YRCmpFdoD7KOYv2F47Dn1KhZrL/nCeEKU3h1Fz+NIXiSbUGvuw5Kc4DrUW3We44FSk36R2zkJNL0kKBVStjRsInc5BzycrPeWTaL07deBSlYtcmjvw8i9Wx34o5bZvUq0xz0rAqiKgJTjSU+EGtMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780868324; c=relaxed/simple;
	bh=VAgBwjDSeNlnZ4qckfBu5Y1PBlob+5OYl4nU7oWlIok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mZKYmKwS2Wk/QVOe3qwTqX03y07Gd68XLpKFEXm0rxVcMnbH3xliin024+KR1TVbPo2507t0YdGF3OFrxJ5vhtBnFbn2qg5AOsJ4r14LdBydvaRBL+7NRXRT2ojLkZI0yQmQIi7c6KKkmDu9NL6VWnZxp1iNV/naw+ugA+mL4zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g4CVZ1tY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LTzKthny; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g4CVZ1tY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LTzKthny"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 657EkuUk847154
	for <iommu@lists.linux.dev>; Sun, 7 Jun 2026 21:38:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=92I4yuoS22Z9HO3EyiCCTVSZ
	iS8+EKZGlOF800tslZs=; b=g4CVZ1tYnf18m/FzTun8nLzBWNZ8weQeE2NaPEIq
	F7ZUCjB7roM0/g7YcSURCGSxbZVUUeaOZ7SIY/knkn+7Fq3hiu4RVJH8PzWnTRcy
	Wja6yNcnIBDLE2dhJ7nCCOg8tWbwgwkeJQXm4B3rYK/49AmjqJ+Af4TnmV80gfM8
	+8ONUWSmeFeZrbZBRRRZGSBaVXLpoXVfzvIp37kIIEpXu/uYFpulfMnSUpLscSDM
	uvWRabQGM7R/TWt0kz8JRrGKaaYZTQ++iTpMasWy1I3SPh7FeEBruIiK6qZ25Jou
	fjVbnFXfdWnfUlESk0Btt7VlWPq3BTTjJIArA6moBnghug==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4em9k3n7dw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 07 Jun 2026 21:38:41 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5a94a743521so2906002e0c.2
        for <iommu@lists.linux.dev>; Sun, 07 Jun 2026 14:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780868321; x=1781473121; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=92I4yuoS22Z9HO3EyiCCTVSZiS8+EKZGlOF800tslZs=;
        b=LTzKthnyHV75BIhowltu1JNQiMCITq1xwJDbmPwxcrYqnXYsJFfi2LugSO45MJ8KLY
         P925RZ178XB7IcWhKk0r1ZiTTDMSHDHOaf36+xX1nfL9pyoIznWadyIrGwA0SCnyhyVt
         ZNavoAXWcMGgYZyvh/KJ/7VTR6QgMUU0el/jpUyyygiPoTDrx2NKN2IbdEpUY6814Iz9
         803hnEqtnGxqoEguKHW4wW8ypPfuMVJAm9nberjza1PJeaPgqdp200DVQEbEwpahD4XR
         xg3e9vt7JYSXUxmpmXEpsICI+lpy/YeWzbFrbur9dX8Iv0TuvNUvuKIlNTwccQdvQSCo
         VJ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780868321; x=1781473121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=92I4yuoS22Z9HO3EyiCCTVSZiS8+EKZGlOF800tslZs=;
        b=Qfb1TbiWyH4YDwVBc+nWn3zgCV2jhavBbLD7rVKChx2YmoLBLkxumk17qwawjvhI7A
         2Vuj6HuDtfim1/x3gaL6OrK3Vigo5IWGgxU9luSH0l87V2yI7mA9J1wJ7KUJinL6UFOz
         q6eODLfmVSaDcCTvy69GagP+qm9HALOqbdgDxcBZBapIqjSQygKD/hf88Ut9ZDZX0HEl
         +10mgV6hP4SOTsLiwJ6NTpisctvtDkBxN9ll8YyAphnGsNEdnqQWk+p7g07Ux6GOhvT2
         g+rhoTmv8q0bfcDJUVSoxaGeXYJaagoWC0rPdtO+qKqUkm3U9yjlGCEXym81OFtG85Sn
         dECA==
X-Forwarded-Encrypted: i=1; AFNElJ81PJZH/DllMWR0zb7jzOSyPVqGjs+G6phKL+bE0vedkr/vlEcYa3ZOYK4+hFIof3as4ZRKPQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwAFZbaRBtV7nhkoCgJlimbYmOWabA5NmmyVufGzyYySBLR881D
	Oo2RmNOGY+48KpoxvaAyJYv/y/BiyB42jcjNB2+L0VRkgTxcnnwVk0DX8fsmRW7RarZX3/2vEuh
	vXSv2JwbNCr030bha9Qgy32zRBcnpYByGkfPZBZaCCgJjUyPnugIKqCFXKw==
X-Gm-Gg: Acq92OFGTySIV8Oy35yrscJqRTnvQKIxYIReZRG5RZ0LT/68J2UaWQrXscNOsB468Yc
	Ferxba8i92zcvUJTX2HgMrZoCyd8bLM+sXl9EmUwxkx+Dp7KhcLZ3n65sobMs0zoV0gzfzhcZXi
	XdF8QzFmTMZxge89KZ7uhCqY7NksDvACivK/Wj9jBOl1YSUJu0QX5wqO5X5wQUew33FBCkz/P4H
	lQTL/yTaCbZago35HNscDSvk8BPX2hzRwnlw42ku+Daoj5WrqLVwQarv8XXTQ1oiL/hoqXWMddQ
	yM0QxrVIzGSuBI6aRh6qNIZ6GmMbutu//gKBCeO6EI2YxN5U9w+fVeKCoP3HeduhJW2H5LkCVvf
	VpXaa9x4HO3qNoN7OgRXcuBzXzEjYyqgEK4KwGgxDfDtz7A5gGvpTTIONpXceX7/HYA8BV8azw+
	5v4OB5RTeRqivlHwNAkFv7H0ULV6xTbDK46WkaC+CnGjBjdw==
X-Received: by 2002:a05:6122:54a:b0:5a1:edab:f216 with SMTP id 71dfb90a1353d-5ac5197b908mr5984175e0c.11.1780868321396;
        Sun, 07 Jun 2026 14:38:41 -0700 (PDT)
X-Received: by 2002:a05:6122:54a:b0:5a1:edab:f216 with SMTP id 71dfb90a1353d-5ac5197b908mr5984169e0c.11.1780868320935;
        Sun, 07 Jun 2026 14:38:40 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b8fdc6bsm3299246e87.29.2026.06.07.14.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 14:38:39 -0700 (PDT)
Date: Mon, 8 Jun 2026 00:38:36 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: Re: [PATCH v7 05/12] media: iris: Enable Secure PAS support with
 IOMMU managed by Linux
Message-ID: <7jqvyudwdngiln4mv5752qpv37zc7fu3donqrzzpjt4olug427@5lcbz27qzumu>
References: <20260603-glymur-v7-0-afaa55d11fe0@oss.qualcomm.com>
 <20260603-glymur-v7-5-afaa55d11fe0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603-glymur-v7-5-afaa55d11fe0@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA3MDIxNyBTYWx0ZWRfX22MaUko4lWt6
 Ch8Vuj3TImSnHBdvuB6/LDil2PVflj3wYP7kLhY3YVkYUuBhXTO4f66+QQWfVkSXYsyGZgVIbmD
 53kqDXPW7CHaA1KPbmOdWiGlWXK8ctSAlZHE06yasqXJIt2AqebpzNwcB23OYC7jFrkZEzNCSpU
 rmeesgrVACJ4CBdYVgmdx9jR1sHzz4w2bx0nKHU3P7K9KCVBZNu7UoSA5I3NDk9xvTSRIVHNjb7
 fokUSRuFvAk6yeXrEIddCuwX7McEvGYiqX/d4Uv0dpN3ocVafXC+leNKeQsRO0O43BbWXSgAq6H
 L/BjJNOnR9b1+DcFR/qeYgT6E5QRFYj9MKrEXxCeHPAQzJSineoaEPiu4R1FOe2rexceJKfV9kW
 Wmq8B7NXy+vDYY7JAz6M7rl0m2Ylv4l6PINyZpPOcMZhcpX/ErufVXVtRJGPsJdAimBH7D+miGm
 UrwuT41CmQo7T9zkGng==
X-Proofpoint-ORIG-GUID: PbKKAtTA9TQFZYdN8NFt2SgperCvnCHF
X-Proofpoint-GUID: PbKKAtTA9TQFZYdN8NFt2SgperCvnCHF
X-Authority-Analysis: v=2.4 cv=TIB1jVla c=1 sm=1 tr=0 ts=6a25e4e1 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=hsWotPrWWJX8LXFSPeoA:9 a=CjuIK1q_8ugA:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-07_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606070217

On Wed, Jun 03, 2026 at 07:48:43PM +0530, Vishnu Reddy wrote:
> From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> 
> On platforms where a hypervisor is present, all Secure Monitor Calls
> (SMC) are intercepted. For qcom_scm_pas_auth_and_reset(), the hypervisor
> registers a Shared Memory (SHM) bridge over the Peripheral Image Loader
> (PIL) memory region so that TrustZone (TZ) can access it, forwards the
> authentication SMC to TZ, and upon return maps the PIL region and
> triggers the co-processor bring-up sequence:
> 
> HLOS -> Hypervisor(SHM setup) -> TZ(auth) -> Hypervisor(map+reset) -> IRIS
> 
> On platforms without a hypervisor, Linux drives these steps directly.
> The SHM bridge infrastructure required for this is already upstream [1].
> 
> To isolate firmware memory in its own Input-Output Memory Management
> Unit (IOMMU) context, a dedicated stream ID (SID) is required, tied to
> the firmware function ID. This SID is specified via the iommu-map
> property in the device tree using the firmware function ID as the lookup
> key. A firmware device is created and mapped to this SID.
> 
> The presence of a SID mapped to the firmware device via iommu-map is
> used to detect whether a hypervisor is absent: when the firmware device
> has a SID mapped, Linux manages the IOMMU directly; when no SID is
> mapped, a hypervisor is assumed to be present and these steps are
> skipped.
> 
> Extend the Iris driver to support Secure Peripheral Authentication
> Service (PAS) on platforms where Linux manages the IOMMU, by creating
> the firmware context device and performing the necessary IOMMU mapping
> when the firmware device SID is present.
> 
> [1] https://lore.kernel.org/lkml/20260105-kvmrprocv10-v10-0-022e96815380
> @oss.qualcomm.com/
> 
> Reviewed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Co-developed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> ---
>  drivers/media/platform/qcom/iris/iris_core.h     |  4 ++
>  drivers/media/platform/qcom/iris/iris_firmware.c | 73 ++++++++++++++++++++----
>  2 files changed, 67 insertions(+), 10 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
