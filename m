Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55112F8EB8
	for <iommu@lists.linux.dev>; Fri,  8 May 2026 19:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778267787; cv=none; b=nD3JDj3MCmb3DZt0JrUTzshcaFEEY6Pt0bncIm6IuxUMi4lzvOy1zdnpUqbQaKCDYluIXYUUlVzp7tyJz5YBi6U9Zx8qfvLX0oSvBcOk8xj11dBRx/wK7Eh9lkC0qxe3dCat33Qc8PJtS4T5KdgyfmZG0yucyYntA3ZyMR+2wus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778267787; c=relaxed/simple;
	bh=8BmL+CWOecwAJ530xbi5ghoHg+OfAxe8bxaz1uRjde8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qqvnZYV/ZRteWY1YvgtsXrjGgB1C3mLPlq7ARJJE9zHem6vFzWicu1XKc+d3AW1ylyKzAau845yY66YPh5ifk5+1N17DnB/wNrUzO5KResNbtahsx46z1ZYkZgo/23HxnD/ItB1On+bxtOKeAc8zxufSdKrKjJdMuQqHbgHhkNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ClFrJTdu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=evKiZsSv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ClFrJTdu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="evKiZsSv"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 648CGlWB852131
	for <iommu@lists.linux.dev>; Fri, 8 May 2026 19:16:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=sVlipysOkBuAV8gAYceMqlYw
	RvO7SmJQFQT+Lf3VYoc=; b=ClFrJTduf/AGwgBQNiSB07zBanK5DmhZ8zKq7Ci1
	0eLDZcWPp0c0IMQexFI4rKvvTgy2YveLru9UPZkW5UTl9AVX9lZrzfJJAO2R0nGV
	GG9Z3OcuLv+ywcUuiBccd+uTYT1VSCP7JKHpOcbTysXNH97329IpUXyhoxLWhShU
	ALFCgxrZR370tZvuFOBmMQUHR63LqzzoVnRCM1l//SM0KapM33fj9mWEJfbayIr1
	qKsq8Y6ZYDuTw8s5olbA20p/muWhYyjZHMl5iOgTatOILO+y3C09HHJHMcbNQ7ZV
	GnaxW+pGi9zRgzUhpsunAOPlulejlPoHvZ8DJNxTEuA8Tw==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1fpthmr7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 08 May 2026 19:16:24 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-6313385ca1bso960925137.1
        for <iommu@lists.linux.dev>; Fri, 08 May 2026 12:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778267784; x=1778872584; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sVlipysOkBuAV8gAYceMqlYwRvO7SmJQFQT+Lf3VYoc=;
        b=evKiZsSvbB9YvvaA6/jNgggwWi+11U7EcSzuvykSysN+kHcWBrY+TeZLSTpYY6igvo
         +MjFJFFCj/VHBaUX0lPZGLlR9h9Ag2s5+3Qf4sLAWwHeuLdZT9vEexm39H/vq4M2NSdd
         I1ZbSxNsq2YFKlVBOS5C6OEJPlj+QwWk+s6nw5sQdz2tAysCt6w4a5IQl7C0GnsAXmSv
         zVyIXqHQaKJjjYB5uAKH6EIzUiKLt+sjoHq1SKWJ14M8g3SBxehseTvPq6SgCCibE++1
         hZi3IZbcQsafSuDLxAIFLab+0shSnDcDkDhkSE86dv5sJERTgZ32zG3WBJFjIY8Keldl
         /Q0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778267784; x=1778872584;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sVlipysOkBuAV8gAYceMqlYwRvO7SmJQFQT+Lf3VYoc=;
        b=cAgXfyC7Dpii22z76p356pY0DrOTcfigSQFKASTzS8iu6MA8mueEJG42EI/h8ZQQO9
         Z4Yac7uSQI4ZtZa4SGHLG6pTR41FPXF+/4xn8QPZVmANJv/3qtNyROExSibWcidMAoVG
         if4cGFFUB+t3xoq1vjP5E38Kp0NQUYuvd/P5v/deE07xzdQTjO+ti43FOUjyknbT7zgR
         Bpxt70FvvXKvyQosvMqoXl92QEpbZUPhAepQ1JAEkKz6R7wRoRNd+UHE+S0AJgAhzqsT
         NhuWS3HtsAzymZUlSzCvL3UczIQFj6YGk83I4u5/sdZtyEzF4pEtuFjp158eXe44T4T/
         9Kzg==
X-Forwarded-Encrypted: i=1; AFNElJ+FpKRerfPM3uGZP0G7eZ8u8C06IutS/1yKLNCVWJBf8G948KUv7VE4+pY382MkAIVFwmf+NA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwDfW38hxfq5hEf0hkxHoUrTf3YTWQZiZn88pIvxWovevznLK7j
	8lwAj0tukVMLrg5LqwtZ/tRpmKfYw1VVxZ0J8xpNewjtY/ncF/52ocrJsjIuNMyxXcFK3VnJmXI
	Q/nskExCun4a5mgCiswrkJpLqWEAd1peubXzLGfRPFohFjeF3+3oDRBuBKg==
X-Gm-Gg: Acq92OGqWnEAnspI4r54Tu1uu56J8aSSDmGYm16GAbZow1R4Qj1bbVIvZae2j0m9cU+
	3i0IW9UXx7U2jXJVKpYcM9Z9bu2+TX4xf8sgJ7eTq0u6GgrqM+w87BvBYlHcfTslleXHgO2AFGm
	K17mOCy7tJRjhVs6UqgnTmEO7ZPkOMcIOArIBWkZX5xTtYLihr76i7ibKvL292ztZW1HirNoGrI
	2hXoCmLLsvYcpaQJq5JdfmbrvyRxfTVNh2/FYoMdVnEKIm6yPTECu1DxDJWkyOh8osyKBsRBmaX
	9cEPXcHZZ8XLEF1xHXDjA6MQFHS+mOcowQfI2/+psYm5Lsr18apLb3jVz/79id2egOSV1HSNKp7
	GThZ1HMfhqdrg6WqTi/23b51y1Lojem6B/Lz8Jr7smY6ACSRqvhDUKyRUkeKI3DbUXnEQikQ0Ae
	KqdEvSjZGlZYqtCcCoagQpat+Y80QzGvvE5d4=
X-Received: by 2002:a05:6102:5813:b0:62f:3713:92bd with SMTP id ada2fe7eead31-630f901b14fmr6997751137.6.1778267781890;
        Fri, 08 May 2026 12:16:21 -0700 (PDT)
X-Received: by 2002:a05:6102:5813:b0:62f:3713:92bd with SMTP id ada2fe7eead31-630f901b14fmr6997639137.6.1778267781168;
        Fri, 08 May 2026 12:16:21 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a8a9515444sm723771e87.9.2026.05.08.12.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 12:16:19 -0700 (PDT)
Date: Fri, 8 May 2026 22:16:17 +0300
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
Subject: Re: [PATCH v5 01/14] media: iris: Add iris vpu bus support
Message-ID: <brt5t4b2eaudpb76rfdutfpe2p3rgjjyyrezcpsarqvuzsvvru@fgf22ttmijfs>
References: <20260509-glymur-v5-0-7fbb340c5dbd@oss.qualcomm.com>
 <20260509-glymur-v5-1-7fbb340c5dbd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260509-glymur-v5-1-7fbb340c5dbd@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: rkF4UjVTcsqvU4_0Jj7x6J_hCRk1KaB9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDE5MiBTYWx0ZWRfX6j9M8lXB+iOm
 Go+IeWdiwGutEGh1gWTZ8MSO/b1ofEOZiLEUNQFt9IjvrA5cjYEbUma8YiwuvAvfysZCyrgAQAn
 uFfIju6U+m2MYvr5l2XkuGGU2hvKYUTjdu95AK65GHz/PrA28O77+bDQbs71ZZrXTe04rYOzlIb
 oXShPyjDmc8OHBbrGTpMnpDVr6MkC/+F6cEKeVfn1HBV55H0lASZHLJA9CQqLdUHzd5+21Vj6ss
 8JGm+9ksY0ao5vPJV/CSqSKk20VNJCoZuUM8b8y9JPz8E2Pqsr1AisC9yBqxxwJo6fxph/HLr+P
 EQUvLCuUpm0m61UfutRvT2jZ4y/CcifG70W0Wk/jvsosDeiYFfi6gb+ZC7ni5ppjQ7w6MFQjGm+
 LM2pXmP/lo5PJ4KJ5oRI7L9xKIuy+yPsIVOxq23K/b8iBavzRviZTzsEl7hRZp6Y5qo+7wcuHJP
 /sqJlfAWT3GTmYwCutg==
X-Proofpoint-GUID: rkF4UjVTcsqvU4_0Jj7x6J_hCRk1KaB9
X-Authority-Analysis: v=2.4 cv=IYi3n2qa c=1 sm=1 tr=0 ts=69fe3688 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=9yz3bF2usBS2VQdoGnQA:9 a=CjuIK1q_8ugA:10 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080192

On Sat, May 09, 2026 at 12:29:50AM +0530, Vishnu Reddy wrote:
> From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> 
> On glymur platform, firmware loading needs a separate IOMMU mapping with
> its own stream ID. This stream ID is defined in the device tree with the
> assosiated firmware function ID in the iommu-map property. To create this
> mapping, a separate child device is needed so the firmware memory can be
> isolated in its own IOMMU context.
> 
> Introduced a new bus called iris-vpu-bus. This creates a dynamic device,
> and its dma_configure() callback calls of_dma_configure_id() with the
> function ID provided by the client to map the corresponding stream ID.
> This sets up a dedicated IOMMU context for the child device.
> 
> Reviewed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> ---
>  drivers/media/platform/qcom/iris/Kconfig        |  4 ++
>  drivers/media/platform/qcom/iris/Makefile       |  1 +
>  drivers/media/platform/qcom/iris/iris_vpu_bus.c | 69 +++++++++++++++++++++++++
>  include/linux/iris_vpu_bus.h                    | 25 +++++++++
>  4 files changed, 99 insertions(+)
> 
> diff --git a/drivers/media/platform/qcom/iris/Kconfig b/drivers/media/platform/qcom/iris/Kconfig
> index 5498f48362d1..025280ef1221 100644
> --- a/drivers/media/platform/qcom/iris/Kconfig
> +++ b/drivers/media/platform/qcom/iris/Kconfig
> @@ -1,3 +1,6 @@
> +config QCOM_IRIS_VPU_BUS
> +        bool
> +
>  config VIDEO_QCOM_IRIS
>          tristate "Qualcomm iris V4L2 decoder driver"
>          depends on VIDEO_DEV
> @@ -6,6 +9,7 @@ config VIDEO_QCOM_IRIS
>          select QCOM_MDT_LOADER
>          select QCOM_SCM
>          select VIDEOBUF2_DMA_CONTIG
> +        select QCOM_IRIS_VPU_BUS
>          help
>            This is a V4L2 driver for Qualcomm iris video accelerator
>            hardware. It accelerates decoding operations on various
> diff --git a/drivers/media/platform/qcom/iris/Makefile b/drivers/media/platform/qcom/iris/Makefile
> index 2abbd3aeb4af..79bc67980339 100644
> --- a/drivers/media/platform/qcom/iris/Makefile
> +++ b/drivers/media/platform/qcom/iris/Makefile
> @@ -31,3 +31,4 @@ qcom-iris-objs += iris_platform_gen1.o
>  endif
>  
>  obj-$(CONFIG_VIDEO_QCOM_IRIS) += qcom-iris.o
> +obj-$(CONFIG_QCOM_IRIS_VPU_BUS) += iris_vpu_bus.o
> diff --git a/drivers/media/platform/qcom/iris/iris_vpu_bus.c b/drivers/media/platform/qcom/iris/iris_vpu_bus.c
> new file mode 100644
> index 000000000000..15ba4d9c563e
> --- /dev/null
> +++ b/drivers/media/platform/qcom/iris/iris_vpu_bus.c
> @@ -0,0 +1,69 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/iris_vpu_bus.h>
> +#include <linux/of_device.h>
> +
> +static int iris_vpu_bus_dma_configure(struct device *dev)
> +{
> +	const u32 *iommu_fid = dev_get_drvdata(dev);

This should be drm_get_platdata() rather than _drvdata().

> +
> +	return of_dma_configure_id(dev, dev->parent->of_node, true, iommu_fid);
> +}
> +
> +const struct bus_type iris_vpu_bus_type = {
> +	.name = "iris-vpu-bus",
> +	.dma_configure = iris_vpu_bus_dma_configure,
> +};
> +EXPORT_SYMBOL_GPL(iris_vpu_bus_type);
> +
> +static void release_iris_vpu_bus_device(struct device *dev)
> +{
> +	kfree(dev);
> +}
> +
> +struct device *create_iris_vpu_bus_device(struct device *parent_device, const char *name,
> +					  u64 dma_mask, const u32 *iommu_fid)
> +{
> +	struct device *dev;
> +	int ret;
> +
> +	dev = kzalloc_obj(*dev);
> +	if (!dev)
> +		return ERR_PTR(-ENOMEM);
> +
> +	dev->release = release_iris_vpu_bus_device;
> +	dev->bus = &iris_vpu_bus_type;
> +	dev->parent = parent_device;
> +	dev->coherent_dma_mask = dma_mask;
> +	dev->dma_mask = &dev->coherent_dma_mask;
> +
> +	dev_set_name(dev, "%s", name);
> +	dev_set_drvdata(dev, (void *)iommu_fid);
> +
> +	ret = device_register(dev);
> +	if (ret) {
> +		put_device(dev);
> +		return ERR_PTR(ret);
> +	}
> +
> +	return dev;
> +}
> +EXPORT_SYMBOL_GPL(create_iris_vpu_bus_device);
> +
> +static int __init iris_vpu_bus_init(void)
> +{
> +	int ret;
> +
> +	ret = bus_register(&iris_vpu_bus_type);
> +	if (ret) {
> +		pr_err("iris-vpu-bus registration failed: %d\n", ret);

Just 'return bus_register();'

> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +postcore_initcall(iris_vpu_bus_init);
> diff --git a/include/linux/iris_vpu_bus.h b/include/linux/iris_vpu_bus.h
> new file mode 100644
> index 000000000000..7437a2ba411c
> --- /dev/null
> +++ b/include/linux/iris_vpu_bus.h
> @@ -0,0 +1,25 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#ifndef _LINUX_IRIS_VPU_BUS_H
> +#define _LINUX_IRIS_VPU_BUS_H
> +
> +#include <linux/device.h>
> +
> +#ifdef CONFIG_QCOM_IRIS_VPU_BUS
> +extern const struct bus_type iris_vpu_bus_type;
> +
> +struct device *create_iris_vpu_bus_device(struct device *parent_device, const char *name,
> +					  u64 dma_mask, const u32 *iommu_fid);
> +#else
> +static inline struct device *create_iris_vpu_bus_device(struct device *parent_device,

You are adding globally visible API without _any_ sensible prefix. It
should be named other way: iris_vpu_bus_create_device().

> +							const char *name, u64 dma_mask,
> +							const u32 *iommu_fid)
> +{
> +	return ERR_PTR(-ENODEV);
> +}
> +#endif
> +
> +#endif /* _LINUX_IRIS_VPU_BUS_H */
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
