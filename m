Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A793E35B63F
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 15:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773416798; cv=none; b=R/lAcNVaKT8H4xBdDrcRGBbcNU0sB/80in3oTM4jhRP/Bf7OOb8b8CgFOY5OWPpSyvmmGheuWo77XUmkGSABCpZPJSEYPQ6jENCATbBOk/xrwAc0LvRtZPKyKV+mCEJYfFstECI2Zu7c2EVmtD1HQ+kLI9TmEGyuj1aziWIWKYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773416798; c=relaxed/simple;
	bh=cKb7iIDUhdsATRBtJidymi9RdOckv1OVQnn6HVmDnf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+S1mw4opWLRfCJFc0OlAFbORCynJoQONJj/hOCYll541ah0qXh4je9jiA8OR8Sfw5toHkug54iK9WSXuCs2xBNP8cBDpbW8+ASarVdPg9l6R5RaKbtBKy0HLa6YBesa2s1Qvhrpj5EKyHANrkquaHPt5tndc6gXpJGAG9ceuA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EuXAYKaM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KDFe7Ukn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EuXAYKaM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KDFe7Ukn"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62DC9b3W3229721
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 15:46:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=tH0wgKb0HurOox7bL5ptdkXW
	HS3fEbajVfibpkUu0kM=; b=EuXAYKaMC/Dre8YvJI6B/b2OR7G8UlUExqUolKeI
	IipFLYyGO9EU/oFWUO9Ra+5LxRi0sJEPjR+LxZdbV1vbTYO8EJ5wJ7p2kzicvFDX
	lkYEqY9YR/2vsj6lMNY5o68qYVqjrV4S/jzzk0Ay2oRQLIJBGFxbIKSzsP0OJPLp
	pK65PUCmzVjLTMyHkHRpTWl4MpmyPY6PDRgtY1qzU2h2/RML8wx095djidin0/A9
	peIUWOsu/QdWHz2YMiKRu9OeIbsYbZpBm8UFH7x4AC54+MlPbkONV7Ka3+HCunKa
	zP7nqGNyvhu88Mp2jaA3ApVsnXPoDxntMBJaaON1M2Se9Q==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cv8n7jt6x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 15:46:36 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-509044f54aaso164339121cf.1
        for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 08:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773416796; x=1774021596; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tH0wgKb0HurOox7bL5ptdkXWHS3fEbajVfibpkUu0kM=;
        b=KDFe7UknAsnbv8jl9mkLw2uK9WUSS9Isqt6uO8yeyI6+6KlXFs7eNlcB7fYconCs3f
         RuukqnXZ3WkeK7owoZOEoKdpNglh5cuaWb9X26DbUHJId7IsTGchV2mT3TTuQKEuP327
         uifuea4FkGT0KevOoKWrhT3Ynk1RkoIJKcbzMhIEBCt1QUKdAlO2ds7Atzg7L9FHl3H1
         uy6whFiwwnN635iRjENOUyDSnmNcftZUm6IB8hpUmEV1uhWRUzHH/Fiq8hfjY9w0XUq7
         5iLJ/E91iBslUCr9PFPhlwpshCa0xZBYQNiH5I4hvOmMxxm03HiOUo5QXn/bEVL8gBfc
         UW6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773416796; x=1774021596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tH0wgKb0HurOox7bL5ptdkXWHS3fEbajVfibpkUu0kM=;
        b=N5LBUpMYrlFZA+OSgSDzcE+CdqVNLCCsXFVQ1VQm/7NfJ3F7ZTK3EFYHKuBedMogGd
         3AsHlcrPa/fcgEIsGHx349ozAZfy3pkz7RFMXDyie+mL14fROVfkUuF9hSEXqUE15xkW
         ByCdJ6tSkrB0kHfpxww1SLlkGoEEwlhg/VijeCdNeE9NCygNVZNLHkGUW8GM2kbcJcPn
         ow8Wy/qbAM9gK/CshHJmXgqIQbRwPbcKdVBF9svL+pLA8nBejz3BmVgQJDZWsE98AhmI
         a8rO/IwQnPHxdvweFgvp9uiSZG++ocJJmDaAXA7dZEqnaWtjcHPIWS/Vkj218H+mcihF
         iENQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsNbuWKAd+v1peeHCB6tuOVp7k/NXRNPB5MKY5FnYxUiR7MbRAu9q9HO2oemcu318/yJVljg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxu/SjF54mWxf9+ci2p7FR2UWti52QMHbUFYBehuprHYBDsQZr0
	r+aYClgoa2U8E3MfOrAgTW2ETjlzrp7qUHJ1oIoYAVthBIVvGJB4IHDdaih18vyMS7CKGsNG846
	qNQT4W4Tp+MzjiDHRFSvdHZA2lWnO34JpaRTGAePArhIajgwHEQ98cAzILQ==
X-Gm-Gg: ATEYQzwEQoZQUKVcjkGIB2+SSnNuMrMeMhVBzDPTreprO2hqeagnef6oShY/wAcyEOP
	8tLBzp2IJVOvgMoUAhZI05kmbJtjyrtfeVXdCCsvr62ezRXccvzFARVEjX2h+FLlvRlzsNfoPQY
	yzLmKTEshBA4jgNdKFpkeRbQ1Sn6ao6oxyfVSfhaj8AoxCz/RyGXNzXhysVU8gWMCyC7VUe4y5a
	/K6UWAVmgg8Xk9jMq46luCjNq7B0bjBuVDqaep4Hjb3orDqmMmct3Db2D5hqEpnwhhtPlwSPndA
	uC7IP7XylxMstnPXxAhQ1yqtCOCVutmUn/B63uGkzlIVfmi9fIE8LKSKuF53tvletW5ilDeEdYB
	dpLg0nEPSWl8k4TsUaYAaL+x+sSkIT/rddegPGU5f4C4fvUUpmSbXzx44aejAzEUDip8QKBIM1m
	CvgWC4Whluwk4Tm9fL450Bt8v5zPAcDgYbPhQ=
X-Received: by 2002:a05:622a:3c8:b0:509:31bd:3dec with SMTP id d75a77b69052e-50957ebce44mr50157351cf.70.1773416795996;
        Fri, 13 Mar 2026 08:46:35 -0700 (PDT)
X-Received: by 2002:a05:622a:3c8:b0:509:31bd:3dec with SMTP id d75a77b69052e-50957ebce44mr50156891cf.70.1773416795456;
        Fri, 13 Mar 2026 08:46:35 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a156162baesm1669034e87.42.2026.03.13.08.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 08:46:34 -0700 (PDT)
Date: Fri, 13 Mar 2026 17:46:32 +0200
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
Subject: Re: [PATCH v3 7/7] media: iris: add platform data for kaanapali
Message-ID: <5t3bke2sjkxahn4pjhdpyznbrdmu67u7cfgdfwqgjcgo7cbg2e@4wr2jadk6b7i>
References: <20260313-kaanapali-iris-v3-0-9c0d1a67af4b@oss.qualcomm.com>
 <20260313-kaanapali-iris-v3-7-9c0d1a67af4b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313-kaanapali-iris-v3-7-9c0d1a67af4b@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: FdIgmTNwW42TQQn7PkhLmAd7d2qsTE3-
X-Proofpoint-GUID: FdIgmTNwW42TQQn7PkhLmAd7d2qsTE3-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDEyNSBTYWx0ZWRfX9EKFP1/iP5cd
 6YbKqxgYjuRq5GTYhvigVwl/iMf6kkuZb5ebNdBR98Pnm4eSN+bcqyr44XIn10WG+wHm+KXnafd
 pGIVzRgH9VRBZ9CMxbKeiBTtTaCemkG+h/tmtGWlNfmcPBKB9jFBj6yW0djUX4zmFeczc5U8Kg6
 exMERhLKjpLnqFkfs/zhGNMPGqxCBROHNlvOg7hnabga9weoPrDQWrUWok743S+cY/l3ugn1tWu
 /u8+DeG35VhlgSeiVbRSIH7NzT93jE4Bn+MwNFM91qaw4lK5Cr+0s7cj+7kGFluuve9841KcutT
 3+jDqXaNbZVlZ7h7f9uMkpzCfpJur0UhwMqd6hGu4Qw+oItA8irZnSJp1vA9CScaaKIuaMQub7T
 lKACqbYZfxNl3FhAFQWNukMwZBeWUyEM+T/a4iymXHPqCeVCe6T7MaWnQLzWc+K/eTn8Tqs8cGT
 NjzqVgvZiikBbfr5F3w==
X-Authority-Analysis: v=2.4 cv=CpCys34D c=1 sm=1 tr=0 ts=69b4315d cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=IruxtDKsvQMgliTLv4gA:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130125

On Fri, Mar 13, 2026 at 06:49:41PM +0530, Vikash Garodia wrote:
> Add support for the kaanapali platform by re-using the SM8550
> definitions and using the vpu4 ops.
> Move the configurations that differs in a per-SoC platform header, that
> will contain SoC specific data.
> 
> Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> ---
>  .../platform/qcom/iris/iris_platform_common.h      |  1 +
>  .../media/platform/qcom/iris/iris_platform_gen2.c  | 90 ++++++++++++++++++++++
>  .../platform/qcom/iris/iris_platform_kaanapali.h   | 83 ++++++++++++++++++++
>  drivers/media/platform/qcom/iris/iris_probe.c      |  4 +
>  4 files changed, 178 insertions(+)
> 

> diff --git a/drivers/media/platform/qcom/iris/iris_platform_kaanapali.h b/drivers/media/platform/qcom/iris/iris_platform_kaanapali.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..bdca1e5bf673353862c1554fb0420f73b3f519cb
> --- /dev/null
> +++ b/drivers/media/platform/qcom/iris/iris_platform_kaanapali.h
> @@ -0,0 +1,83 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#ifndef __IRIS_PLATFORM_KAANAPALI_H__
> +#define __IRIS_PLATFORM_KAANAPALI_H__
> +
> +#include <dt-bindings/media/qcom,kaanapali-iris.h>

So, you are including the bindings here, from the header, which gets
included from the C source file including headers for all the platforms.
What if Kaanapali+1 (or +3) defines different sets of regions?

> +
> +#define VIDEO_REGION_VM0_SECURE_NP_ID		1
> +#define VIDEO_REGION_VM0_NONSECURE_NP_ID	5
> +
> +static const char *const kaanapali_clk_reset_table[] = {
> +	"bus0",
> +	"bus1",
> +	"core",
> +	"vcodec0_core",
> +};
> +
> +static const char *const kaanapali_pmdomain_table[] = {
> +	"venus",
> +	"vcodec0",
> +	"vpp0",
> +	"vpp1",
> +	"apv",
> +};
> +
> +static const struct platform_clk_data kaanapali_clk_table[] = {
> +	{ IRIS_AXI_CLK, "iface" },
> +	{ IRIS_CTRL_CLK, "core" },
> +	{ IRIS_HW_CLK, "vcodec0_core" },
> +	{ IRIS_AXI1_CLK, "iface1" },
> +	{ IRIS_CTRL_FREERUN_CLK, "core_freerun" },
> +	{ IRIS_HW_FREERUN_CLK, "vcodec0_core_freerun" },
> +	{ IRIS_BSE_HW_CLK, "vcodec_bse" },
> +	{ IRIS_VPP0_HW_CLK, "vcodec_vpp0" },
> +	{ IRIS_VPP1_HW_CLK, "vcodec_vpp1" },
> +	{ IRIS_APV_HW_CLK, "vcodec_apv" },
> +};
> +
> +static const char *const kaanapali_opp_clk_table[] = {
> +	"vcodec0_core",
> +	"vcodec_apv",
> +	"vcodec_bse",
> +	"core",
> +	NULL,
> +};
> +
> +static struct tz_cp_config tz_cp_config_kaanapali[] = {
> +	{
> +		.cp_start = VIDEO_REGION_VM0_SECURE_NP_ID,
> +		.cp_size = 0,
> +		.cp_nonpixel_start = 0x01000000,
> +		.cp_nonpixel_size = 0x24800000,
> +	},
> +	{
> +		.cp_start = VIDEO_REGION_VM0_NONSECURE_NP_ID,
> +		.cp_size = 0,
> +		.cp_nonpixel_start = 0x25800000,
> +		.cp_nonpixel_size = 0xda400000,
> +	},
> +};
> +
> +static struct iris_context_bank kaanapali_cb_data[] = {
> +	{
> +		.name = "iris_bitstream",
> +		.f_id = IRIS_BITSTREAM,
> +		.region_mask = BIT(IRIS_BITSTREAM_REGION),

I'd say, it's really easy to mix IRIS_BITSTREAM and
IRIS_BITSTREAM_REGION when looking at the code, which might be bad
because they are not equal.

> +	},
> +	{
> +		.name = "iris_non_pixel",
> +		.f_id = IRIS_NON_PIXEL,
> +		.region_mask = BIT(IRIS_NON_PIXEL_REGION),
> +	},
> +	{
> +		.name = "iris_pixel",
> +		.f_id = IRIS_PIXEL,
> +		.region_mask = BIT(IRIS_PIXEL_REGION),
> +	},
> +};
> +
> +#endif /* __IRIS_PLATFORM_KAANAPALI_H__ */
> diff --git a/drivers/media/platform/qcom/iris/iris_probe.c b/drivers/media/platform/qcom/iris/iris_probe.c
> index 439e6e0fe8adf8287f81d26257ef2a7e9f21e53d..f6d8761daf0471d3aabec21c708445ee7698487b 100644
> --- a/drivers/media/platform/qcom/iris/iris_probe.c
> +++ b/drivers/media/platform/qcom/iris/iris_probe.c
> @@ -406,6 +406,10 @@ static const struct dev_pm_ops iris_pm_ops = {
>  };
>  
>  static const struct of_device_id iris_dt_match[] = {
> +	{
> +		.compatible = "qcom,kaanapali-iris",
> +		.data = &kaanapali_data,
> +	},
>  	{
>  		.compatible = "qcom,qcs8300-iris",
>  		.data = &qcs8300_data,
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
