Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9993E95BF
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 15:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776179909; cv=none; b=CRdX9rH6ssQYgFF4OO8pyMYAEvYhVi8udiN6L6SpaGsSny2LyRjM0Hch1TvkIFJitFY2tvwmvoVKkGn2LWySMfFMsOwyCOu2+dFPrQBBfVsLZcd6I0BI+oT7e1Rh0vguX8dby2vGh0/rdho/LYLZbQyVDIZ56FE8vGLInPdcH9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776179909; c=relaxed/simple;
	bh=2EOQF9ttSq+4MnxdWLanaI1sYlDTKHzBDOT+agrRp+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P1Qqg21WfeHbmM5et8CRRvlFV07mG5kS5uDTGz3KcfpB1+H7dsZcRGmNVrK3DzSxi+RMk8qKx4B4m2ws5sr/XalSU4VBkHerhXb77nW6z34CRikhw936hCOpGoQhhSw+Vf0qWIEk5vAUQz6oLudydaFHbXKAyMfMiCRb8H49l04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FeyO6dhP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Jmo+4Dn4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FeyO6dhP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Jmo+4Dn4"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63EBd7VI3425578
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 15:18:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=zXTVOR1fAway+PAlPPuH62Ma
	1nkGyHlMAEO3cz5Hay8=; b=FeyO6dhPAg0s3hdrZ3hhl0w3keCcTWbP1G0rpgkj
	8ELBS2kwj0Fra6e4WLxV/fTiaAoOBASKRyFT4T3ns5cFVZZxEV+aDH3NGkkda8Vr
	DMXCABYwBGwvRl6jiANbjvy8LIZj2IBDjlMSkhVwah/7wWHgtXdOw49E5QJMxJRv
	DNi8jGSkTb8vD4xtkYgdIkUX0XPebzg47uuRG8i7PM8q4lOlfHrM7gvsfMztDtgZ
	30wYzGgtWFmE2Qrh1bR5kRWTsJIdBBpnM/fyirC2hjLJAO3+a5CNYIOpw8vietMR
	OixXLpIhhqJM4bP1ZWLQ13+0KHpnTgTFX6VOedI4z8Qmcg==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh87fbaj9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 15:18:27 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-6058280770fso1768654137.1
        for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 08:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776179906; x=1776784706; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zXTVOR1fAway+PAlPPuH62Ma1nkGyHlMAEO3cz5Hay8=;
        b=Jmo+4Dn4eGyIQI3d1IGBWu9FBrxG66mEUQ1HAWhc/zx5HL9CLCGAAq02BRQWY+JBGe
         La/XXKjDLzkgQ9AeFH2F2VwHBIQp5cbskrgM88BxJJ5/6tlVcGtAnvUFQaK0fsdtf4za
         D4epgq1YiHDnDyn0xsadfh7iZ4SjTNT3xbTMEP5SyR8Bq5kdTbKYMhodqiOpQe/PGJBx
         x5gXigZWLcyjJCnGk4piWqyBo1Ss3HVFf5KNMf3GH+yeiO6NMK50K5mdyS+hDmKBM2ZC
         76uCojp9lAxSP6CSWnM5phBZiO2pmtzF1G4bhbPs/XhCeZ4NkrVubzmk3iNzcxltXLZk
         gQ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776179906; x=1776784706;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zXTVOR1fAway+PAlPPuH62Ma1nkGyHlMAEO3cz5Hay8=;
        b=RZ/NnfmHGT3+Qk1u/5SZs4lq8xI0oIDG3hbsy2xt3khSxByWQLDVAWT/sfsxbpIXVJ
         zsUoppbowe9LB/DsQyY+6FcwXoJriWckv5wbdZBtVkH/XWttoSXarGgDxhQbApUro7Tn
         NGVWEfYfASCRcJU0mFiaIEnilvaVhi2clChwbpu1fmRL/962/IUFx5pHuyvvCvW1eMwq
         CPSNbeXmRocSfa9vUFp5KgPkJmr5NSacXR3CNEB1rZdCBkvhuXJT0c8quoBOx7wo8gE7
         V41IghaJWvOUomaJIp8dhWZ+j3JAm/Xuqk7kcPi5tbUGkWIxaS33BIvoiU7KeDl5DKTr
         o37g==
X-Forwarded-Encrypted: i=1; AFNElJ+DEuUohunQka3S7B50laJbIiRvWNfO/5x+STNzUlQ6hrMLof28EO2W1/lfIHt5GvSprbJgYg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzTZCiyDTFK//UhUukELDyoXd1UObMokFGyDW3a/kJo8DpUPa8v
	O04qT2o3TcUtTJGphSd2DWoYHfZkv60UvBFQlE+q1xXYe4FSU7hWtih407ozNKVpqVJ9g6dCXIN
	4lI7ONIGsySFZ2ZjNTTsJm/Xqji8VowPIQN4Z93ZuEcQ9HzeA41Yg2Whf+w==
X-Gm-Gg: AeBDiesj0Ia+Ti/3Os0ZZ6ghuk3tSqv0z9HsF3k8796JaEqo7aS/yHCyIo7ESfuLSBs
	fDYCR/t1CxYC4FfovxMLIKY6tI9kB1Ce2jIZ9zBf5zt81D1AumCmZILMp18GkPMjWwyVR+qzd7k
	Nk7uUcDvpZZg4Us1vUxFdbRj3kOfCnQJy63Q4K3AP9Xxl/vSkQPezV/g2f2DQjw2QwDddBSbmQM
	UMLjtot34/X1XiefC7eyEJyzt1zA4nqYqS0L0UD9zlZUO0wR9c1EEzOHhAwRzf50j/WxszmpWQz
	VojCRq9znMV+w8ic3vZ4e+cF0zUpkNcWvDwARIKGE+60b2tTATfK9HN00sxCMC1FU8xseuEsr2f
	OfrlgxRmEPb8X4IeQBsQ0y6RIO0eohKfsZQG9PIcsjjdZHBuz2YKNsWKLiELyAyhweBw4d0p3Jx
	wjTXiPW7dNST5Xa5sQQm+lVmqbokyGdh1/ewZ+Wx+D6cb3TQ==
X-Received: by 2002:a05:6102:2c0a:b0:602:6784:3eef with SMTP id ada2fe7eead31-60a0167fc4amr7881196137.28.1776179906357;
        Tue, 14 Apr 2026 08:18:26 -0700 (PDT)
X-Received: by 2002:a05:6102:2c0a:b0:602:6784:3eef with SMTP id ada2fe7eead31-60a0167fc4amr7881140137.28.1776179905900;
        Tue, 14 Apr 2026 08:18:25 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a3eef08c10sm3331197e87.83.2026.04.14.08.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 08:18:24 -0700 (PDT)
Date: Tue, 14 Apr 2026 18:18:22 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Cc: Bryan O'Donoghue <bod@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH 04/11] media: iris: Add helper to create a context bank
 device on iris vpu bus
Message-ID: <ie6dad3xewm25gdrqqne2fsroopu3jwgrqmu54sfzjliis6mo5@6qsgagvyynwx>
References: <20260414-glymur-v1-0-7d3d1cf57b16@oss.qualcomm.com>
 <20260414-glymur-v1-4-7d3d1cf57b16@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414-glymur-v1-4-7d3d1cf57b16@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDE0MyBTYWx0ZWRfX5dnVIef4l/Df
 4zTLhwDJkK66lmoqnPKsQzA9LPpbSxXosLMEA2TteZjU8BkVH+nRtHhokH5WIPp0H3bPXIwGy5i
 UOYCdQlJTOqqO8CL4wPhhNuIIolZzZwX1jQ7XNAekN2LzCtmCJH5urMOqAqctK87jbqa6hmH07p
 RNyAYAoC/MiNe2vlW0WBLdRgsdYtplu7B3ToAu4lAl+29grESdSE3XNVsbM4U3/hz5n/fj6qsjx
 ljRw0XCd311isa3JjHGJkW/y9WuZSjmxSyYjBwoZNPRfkS1cr4P1FvwidbVYOabUUjdsRITkZtV
 f9ti+r/UP7desGODSD6OnLQ3Zb93Zz8pSV+kTolz7NxpLqwADZ4rR1wFydXkyfHMd2RQ8ekny3x
 t5yWuBehNkj4cwef0wnIhQze39c0CxCUn9zegz0tBhXI4hEsvjlX3MW2IlSXWv2TLE+xQLxzgm9
 CP9ml6ZyBnOErS29jpA==
X-Authority-Analysis: v=2.4 cv=DaYnbPtW c=1 sm=1 tr=0 ts=69de5ac3 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=xV2MR2JlQ2IntpQF-B8A:9 a=CjuIK1q_8ugA:10 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-GUID: xURWUvKtdA3zBmCOLrGbuC6cwsO7aN1d
X-Proofpoint-ORIG-GUID: xURWUvKtdA3zBmCOLrGbuC6cwsO7aN1d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140143

On Tue, Apr 14, 2026 at 10:30:00AM +0530, Vishnu Reddy wrote:
> From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> 
> Add a helper function to allocate and register context bank (CB) device
> on the iris vpu bus. The function ID associated with the CB is specified
> from the platform data, allowing the bus dma_configure callback to apply
> correct stream ID mapping when device is registered.
> 
> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> ---
>  drivers/media/platform/qcom/iris/iris_resources.c | 33 +++++++++++++++++++++++
>  drivers/media/platform/qcom/iris/iris_resources.h |  1 +
>  2 files changed, 34 insertions(+)
> 
> diff --git a/drivers/media/platform/qcom/iris/iris_resources.c b/drivers/media/platform/qcom/iris/iris_resources.c
> index 773f6548370a..a25e0f2e9d26 100644
> --- a/drivers/media/platform/qcom/iris/iris_resources.c
> +++ b/drivers/media/platform/qcom/iris/iris_resources.c
> @@ -6,6 +6,7 @@
>  #include <linux/clk.h>
>  #include <linux/devfreq.h>
>  #include <linux/interconnect.h>
> +#include <linux/iris_vpu_bus.h>
>  #include <linux/pm_domain.h>
>  #include <linux/pm_opp.h>
>  #include <linux/pm_runtime.h>
> @@ -141,3 +142,35 @@ int iris_disable_unprepare_clock(struct iris_core *core, enum platform_clk_type
>  
>  	return 0;
>  }
> +
> +static void iris_release_cb_dev(struct device *dev)
> +{
> +	kfree(dev);
> +}
> +
> +struct device *iris_create_cb_dev(struct iris_core *core, const char *name, const u32 *f_id)

Please move into the bus code and make it generic enough.

> +{
> +	struct device *dev;
> +	int ret;
> +
> +	dev = kzalloc_obj(*dev);
> +	if (!dev)
> +		return ERR_PTR(-ENOMEM);
> +
> +	dev->release = iris_release_cb_dev;
> +	dev->bus = &iris_vpu_bus_type;
> +	dev->parent = core->dev;
> +	dev->coherent_dma_mask = core->iris_platform_data->dma_mask;
> +	dev->dma_mask = &dev->coherent_dma_mask;

Would you also need to set the of_node? See
device_set_of_node_from_dev()

> +
> +	dev_set_name(dev, "%s", name);
> +	dev_set_drvdata(dev, (void *)f_id);
> +
> +	ret = device_register(dev);
> +	if (ret) {
> +		put_device(dev);
> +		return ERR_PTR(ret);
> +	}
> +
> +	return dev;
> +}
> diff --git a/drivers/media/platform/qcom/iris/iris_resources.h b/drivers/media/platform/qcom/iris/iris_resources.h
> index 6bfbd2dc6db0..4a494627ff23 100644
> --- a/drivers/media/platform/qcom/iris/iris_resources.h
> +++ b/drivers/media/platform/qcom/iris/iris_resources.h
> @@ -15,5 +15,6 @@ int iris_unset_icc_bw(struct iris_core *core);
>  int iris_set_icc_bw(struct iris_core *core, unsigned long icc_bw);
>  int iris_disable_unprepare_clock(struct iris_core *core, enum platform_clk_type clk_type);
>  int iris_prepare_enable_clock(struct iris_core *core, enum platform_clk_type clk_type);
> +struct device *iris_create_cb_dev(struct iris_core *core, const char *name, const u32 *f_id);
>  
>  #endif
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
