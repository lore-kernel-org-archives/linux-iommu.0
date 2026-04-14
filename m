Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF82B3E715C
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 15:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776179685; cv=none; b=VExYAZ1EVdAvG0lzGVNE9Wu1akiX1cT6X9CQlUyd3+4sxzC8esC3+Dv3anpIULC7FHr+cOai87zxJxzLQ+fhal5+RpQesXHu229LHHcT65rbUGnGGqmHmSlsjtMPKP3BSihTx4g3m0XujPBXuOuqGIhxJ1XTacAitlZBbISA3r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776179685; c=relaxed/simple;
	bh=kz5rVB37M5fxScKGUAVyVpMiRJhrFFk1kH1C6GoH3mM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f/EqhvjFiipWtahyPy4swe/o6bFGw9EEzsNs0IGBqTkP2910/xR7cNytSxU16PCBzLaI/oMJs3OhHZCOIt4IREuzESO7/pkyv4eaoVjb2h6gZCsxXybM9urtbNYldWpokFSqyjStZ2F6obk05SKymK0x2XRL/9r5cQnd/5SVybA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BVigGB5D; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NOG5s8F2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BVigGB5D";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NOG5s8F2"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63EBUJrF2386374
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 15:14:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=G4aks4H+FpBEhHapfREL4acD
	uXkNuXLZB9iHD5QRayk=; b=BVigGB5DQCUAuMqT9N8E7MhX51L6Wpm34hRvStzt
	589YH7R1IhsGrQaDAu5OSwdVorLtvYLlEhb4n+hVbo+D67SB8f1Q337qvxM/3xMA
	wqakA9SLntF3lCYj4Y84QT9nKrSSDo5/rJpSLRL7MdexfE3T9ju51Z1DbWg1I2kr
	i8LBKfG2EZJobaPtrXcnAuEm4ODWqIbmzHJ3t8/LH8Pn5zj+MeAtnmxbxVwovATY
	K0Xj8WEZSkFReiDDmGHLP16QDW/mGMArrntaV31Wlk1Y8+795ERgxnKo+HgZ6umc
	1qLUTVrMiDCjVrLvR1ZYona1CoGDvfg4I7Zz4Gr4I2dnRg==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh86w3au2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 15:14:42 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-605c1beb746so4396486137.2
        for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 08:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776179682; x=1776784482; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G4aks4H+FpBEhHapfREL4acDuXkNuXLZB9iHD5QRayk=;
        b=NOG5s8F2Rl1HUDltR7HXxmpfxHxrosya7sPYmoAA0Ss7PrOK7/T6i0mDEbJXlZvp93
         WV0QknaPky4iRbITVbGva5NMMjEO0DPg74DiVIDngl/wheATwJOaCnIFvXsleQc+FnvX
         e4tFgN3Eo8Ce6Y9MdNNUHjF5Eeb6c+Nq1Go7UGIEDlyY4gOz/LQV0KIGSeqqltd7qqHv
         UXZk+E4HAjSh6nMVIBMb++iF5hGz1rzNy9x3ZGCWVK/e7C8Pn32eCmaB7+Jset+WEjbM
         3zcuvoflWqeCYSnDw5oE5T2RhJUNBNSBoh/vmpZn4i4FMokXXkdPjsVM1db/80XWjtIl
         W7tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776179682; x=1776784482;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G4aks4H+FpBEhHapfREL4acDuXkNuXLZB9iHD5QRayk=;
        b=hkpIXzbOu85dnf7wHvptqGenO2YN3q/6sQlse7edyUuXvN/o+cHnundsN0O8qDH2oz
         8lCt5EwbPXdnDlBDGmHL89puKg047hENv24gkXHgxCqHhcvJ8b5n73HAFEMMLUhhj/Sg
         lF4h9vVp/hko6L3yI7aKy153lrqED4h6SSixIXuVmka5QJuO7ztPmp0EOwZpbrIr37Ah
         a7Bnxap1qTtmEuHKmWcFj5lXj7wgRZRiwmLj0kOqxHGEzsNOTAajBaDO2/rX90JNpXP8
         vTWCG6lLiT6noD1ocd6YHUwYeYEC2OLtae6687vQAGVoz83bYB6Nx4os1jR9RnAbd7E8
         6AFg==
X-Forwarded-Encrypted: i=1; AFNElJ+JVj4KZnMkaKYIQ6ooXvGPHaDgFOAKpLeeelI1si/ZDg+EY/bEsX4em3VRcIMzyYBhT5580Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywv1kPkc1iprxq9h/qYgEBoy8LsBF+ZD7oUd3aTO6+0CE2EsEqG
	//mHWwZalGyDON3ASShVmDDxAkUL0ttH6f5MevuiGEEULo8DRtm83MAAyCQF8qlL+uzKurpuQkg
	17ZdR8rAknaORW5L1bi4nxKSEdImqbxyjxjn/3LhiOlyQjI/uAbIqc7DB2g==
X-Gm-Gg: AeBDieuXiPhKradGGXUoCoih2J6+wnCvuJ2FzNspljIIFZSNxf6RNcbPdrg/lZZyobh
	4WlLfL+SQWvx6T4Ga5sMuUoMiBFhDd/36zUQHvKN9ILF4nYrO1XeJNuKC0Chqv335fpxjkfiJhX
	yhhx0tK5FECxll80CINb9JSkSI2q0NstMoTB9Krjvq2wXsfUEpXW0Z9OeS40qyUw9SBL6CCPLBf
	nH/ZGlycswFu/XIX5Lbey1wSfEV0iT4ow6HrmllidCp+hJCB8HxWj01cL4ohQ2MN4EYG1IOdLLU
	A2pS/jwNVJH7l512Fbvn8wULEIaBg74STGyL8e3Jcm3zC7KpTO4wopwvhctKWFedpiIirwHEqxs
	6UQii/i1SecWj0bmRfRpihNXcuk77iZyCaMVl56gfpPIhNmj80e1FSStukvtTDGia53T72r4O3O
	P/RAMQrefVbOKUTGHu0Z2h7eJUQAkZAZK7B3EPIkU5IEd1hA==
X-Received: by 2002:a05:6102:441b:b0:609:4d86:77b with SMTP id ada2fe7eead31-60a00f39005mr8189076137.24.1776179681659;
        Tue, 14 Apr 2026 08:14:41 -0700 (PDT)
X-Received: by 2002:a05:6102:441b:b0:609:4d86:77b with SMTP id ada2fe7eead31-60a00f39005mr8189005137.24.1776179681134;
        Tue, 14 Apr 2026 08:14:41 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38e492702f7sm31782441fa.9.2026.04.14.08.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 08:14:39 -0700 (PDT)
Date: Tue, 14 Apr 2026 18:14:38 +0300
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
Subject: Re: [PATCH 02/11] media: iris: Add iris vpu bus support and register
 it with iommu_buses
Message-ID: <eqxeib5ci42ox4o7l45yjwgsjwjyhekojiigpxj6s5npjw5cwq@ggbtohqh3pip>
References: <20260414-glymur-v1-0-7d3d1cf57b16@oss.qualcomm.com>
 <20260414-glymur-v1-2-7d3d1cf57b16@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414-glymur-v1-2-7d3d1cf57b16@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: Q3f2QXhuJF77SbqvNi14j2wbcuBL1NWS
X-Authority-Analysis: v=2.4 cv=HKfz0Itv c=1 sm=1 tr=0 ts=69de59e2 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=A7GDoH_M6FUROJucG8cA:9 a=CjuIK1q_8ugA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDE0MyBTYWx0ZWRfXzlATDKaun7N/
 BMiZkajN6IXKNVHVCgqekNTa0SgTpjiIPJ7roMqbjZ3ArTo+PHV2bpWY63gOGKE9mo4XBuPAIsU
 i43RjBwUDiluctaxxM1eQCQS+wEW8z7HHn2R7mYUgDFskblY/5r3SiMqloV/bHfB96PzlkB4660
 FDkAQPzMvDW3WAZpDTaOfCKHhtx4d6V5SaAw2BwBRB1a58cubPLBUxBTN9Mg+YfLS2CfWfiELBj
 WEzig9/cQYHGfIBycROLcp7IWo4oBim66uUKfxvMd0g0jh9oNLwMR39okCQjHW/OKAIR+cDGc0d
 xVgFrNj7pEF92HI4i11ryTLVPbjB1i1GvqM4KR2/sdC/C0rMRMfCwSF29nrvQ6Cy/aGZ4db+FiX
 rz5P+VPuhEEeDLj5RG+zR6Z/gKqMQZjU2KMtooJpYv6rJt/zPdZkDxsFXEWtSW1aiN2hqKWBuA5
 AbWhKkdHCdkeHafU9hQ==
X-Proofpoint-GUID: Q3f2QXhuJF77SbqvNi14j2wbcuBL1NWS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 clxscore=1015 bulkscore=0 phishscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140143

On Tue, Apr 14, 2026 at 10:29:58AM +0530, Vishnu Reddy wrote:
> From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> 
> Add a dedicated iris VPU bus type and register it into the iommu_buses
> list. Iris devices require their own bus so that each device can run its
> own dma_configure() logic.

This really tells nothing, unless one has full context about the Iris
needs. Start by describing the issue (that the device needs to have
multiple devices talking to describe IOMMUs / VAs for several hardware
functions), then continue by describing what is needed from the IOMMU
subsys.

> 
> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> ---
>  drivers/iommu/iommu.c                           |  4 ++++
>  drivers/media/platform/qcom/iris/Makefile       |  4 ++++
>  drivers/media/platform/qcom/iris/iris_vpu_bus.c | 32 +++++++++++++++++++++++++
>  include/linux/iris_vpu_bus.h                    | 13 ++++++++++

How are you supposed to merge this? Through IOMMU tree? Through venus
tree? Can we add one single bus to the IOMMU code and use it for Iris,
Venus, FastRPC, host1x and all other device drivers which require
per-device DMA configuration?

Your colleagues from the FastRPC team posted a very similar code few
weeks ago and got exactly the same feedback. Is there a reason why your
teams don't sync on the IOMMU parts at all?

>  4 files changed, 53 insertions(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 61c12ba78206..d8ed6ef70ecd 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -13,6 +13,7 @@
>  #include <linux/bug.h>
>  #include <linux/types.h>
>  #include <linux/init.h>
> +#include <linux/iris_vpu_bus.h>
>  #include <linux/export.h>
>  #include <linux/slab.h>
>  #include <linux/errno.h>
> @@ -179,6 +180,9 @@ static const struct bus_type * const iommu_buses[] = {
>  #ifdef CONFIG_CDX_BUS
>  	&cdx_bus_type,
>  #endif
> +#if IS_ENABLED(CONFIG_VIDEO_QCOM_IRIS)
> +	&iris_vpu_bus_type,
> +#endif
>  };
>  
>  /*
> diff --git a/drivers/media/platform/qcom/iris/Makefile b/drivers/media/platform/qcom/iris/Makefile
> index 2abbd3aeb4af..6f4052b98491 100644
> --- a/drivers/media/platform/qcom/iris/Makefile
> +++ b/drivers/media/platform/qcom/iris/Makefile
> @@ -31,3 +31,7 @@ qcom-iris-objs += iris_platform_gen1.o
>  endif
>  
>  obj-$(CONFIG_VIDEO_QCOM_IRIS) += qcom-iris.o
> +
> +ifdef CONFIG_VIDEO_QCOM_IRIS
> +obj-y += iris_vpu_bus.o
> +endif
> diff --git a/drivers/media/platform/qcom/iris/iris_vpu_bus.c b/drivers/media/platform/qcom/iris/iris_vpu_bus.c
> new file mode 100644
> index 000000000000..b51bb4b82b0e
> --- /dev/null
> +++ b/drivers/media/platform/qcom/iris/iris_vpu_bus.c
> @@ -0,0 +1,32 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/of_device.h>
> +
> +#include "iris_platform_common.h"
> +
> +static int iris_vpu_bus_dma_configure(struct device *dev)
> +{
> +	const u32 *f_id = dev_get_drvdata(dev);
> +
> +	if (!f_id)
> +		return -ENODEV;
> +
> +	return of_dma_configure_id(dev, dev->parent->of_node, true, f_id);

I think it was discussed that this is not enough. Some of devices need
multiple function IDs.

> +}
> +
> +const struct bus_type iris_vpu_bus_type = {
> +	.name = "iris-vpu-bus",
> +	.dma_configure = iris_vpu_bus_dma_configure,
> +};
> +EXPORT_SYMBOL_GPL(iris_vpu_bus_type);
> +
> +static int __init iris_vpu_bus_init(void)
> +{
> +	return bus_register(&iris_vpu_bus_type);
> +}
> +
> +postcore_initcall(iris_vpu_bus_init);
> diff --git a/include/linux/iris_vpu_bus.h b/include/linux/iris_vpu_bus.h
> new file mode 100644
> index 000000000000..5704b226f7d6
> --- /dev/null
> +++ b/include/linux/iris_vpu_bus.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#ifndef __IRIS_VPU_BUS_H__
> +#define __IRIS_VPU_BUS_H__
> +
> +#if IS_ENABLED(CONFIG_VIDEO_QCOM_IRIS)
> +extern const struct bus_type iris_vpu_bus_type;
> +#endif
> +
> +#endif /* __IRIS_VPU_BUS_H__ */
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
