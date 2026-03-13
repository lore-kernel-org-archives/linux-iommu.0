Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E20C3B4EAD
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 15:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773416145; cv=none; b=RufBh9KNVKZ7fsCxg2o/BHX+GVl+6o2yoIfLMXFMLHzKlBqFg26VmW+lLvx1qNV7Dk68zJW9pM+Cx/sGqTjokrUbvqf5CT9RGrcWz5MYQfjXkNijh5WYpZOjZFNfOfbZxRrvSwUVr/UxDnvcqx4aM6yTrl2cNGmqo+JnS1ByY+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773416145; c=relaxed/simple;
	bh=YJoz91c+q7in7/0KxjZs6mQ9FJ9MYdwGNxoXlFbnDBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mY0eU8X/VztNBJYMU9WRvIc62UfX9rVKv1gsTptufCDqccskyiREPbGcJXA6Ip5ElBIyNatoTsEpriuhCKIA/AuZgCVcP0l44cXBhWHeTMY33bFqVkRybNu/znOJ/M0ZBCpRXZFCtZdPw9MxlroXuR8z0hDpDo/bSh3wHNWq7ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DCe+ZMdN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=h+/KxLI2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DCe+ZMdN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="h+/KxLI2"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62DA7VUm1748804
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 15:35:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ne/tYUaqy6oEHvVkZv5Q/L0i
	cxB9L/q8cd0LTS1N8+M=; b=DCe+ZMdNBcGKvv/NoeknePIR1wruYpaEEKRPagPD
	wu9vE7e4G715qehUMlhjXIq4H9NaQp+0k7jZw+dn+gNpFyxlG6JIeemsz8nzAb1D
	JfGfEQDH17mMwrBmw4cfZtxI/h+50N+jNOcYUxJ2Jp7EE/cgjwOdH5QmTEqeB0nI
	ipSDgPxUMaxXh8Mq1vOr6dVqLog8QKKLo6x3M7DU+6RYA/voHq01QaOYP/rnOReV
	xobPe+LABk98BObYpG9s9WC2Xi0FvOefu+58G/N/9L9X/Q/WkwdmcsKsy4LWd7jG
	qhs69qyDLrXSe9nggec3hc7ebAn+HYkSWNpRzKErq5rc/Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cvgj6h336-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 15:35:41 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cd827a356aso1389807685a.3
        for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 08:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773416133; x=1774020933; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ne/tYUaqy6oEHvVkZv5Q/L0icxB9L/q8cd0LTS1N8+M=;
        b=h+/KxLI27RtjuA7idCERNWS88P4KpTQPxaRhCv1seePdYqG/qG67b+BUNeaxQvglpG
         iUlcyO1HKQ0O1RxbwSC2LQJmiKbCRUWznsehWXasbCGflV8Qimh8kEMlqWJQBTybsfCq
         ZL9XiZA5pkOHkXsz7qxYVQkn1XiRwYP/EkDA8aqpG2u+UlLos5So2yVxoRyLO5m4n9Kj
         oAgbeBplO1xqUr390GghxYVvukfRX08t8sgBUMu4Xo7I80BrHG+ZSIIAsXvV7zg9rRSV
         YbraV+A4jHAGhdNdNOiCVjAQyNCcTduD6ikBMQSCjvf3XIPk8kHiqvtCIyINA65kD0hp
         2RAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773416133; x=1774020933;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ne/tYUaqy6oEHvVkZv5Q/L0icxB9L/q8cd0LTS1N8+M=;
        b=UYmeMVZG+inrLYNpTF9uXdb1IA7E6U1hzW3GIA7QIaCdSkFy5ERt/jmWsDizG6b5fa
         NRStiw8xfBnV/7dUdBuGaGUrOx5U1VVhsun86RjFpTFwB8PsBIROraRG7/DaPB9CXCjS
         Qx1nqyHDm8dHTIz5dgJXldLRg1GftGWdV0UeX1QddKepCML2N0eocMGnNiK2o94Wd75J
         AQD+e21gvpDJzmjZonjoZBTLWj/0mKuLnlsJKPhhHtAip5EUzn03ovuAxSM/VSc6OxPo
         Yf+z5BYjrVdBTAiZGkzmv76iuTK3lKaEMV5I+GX49wBPWQU37F5PIQFamFfSyyvjDn6J
         J0vA==
X-Forwarded-Encrypted: i=1; AJvYcCVKazZ2+WokR3osuIyDVrWtjpTsDBW1RvIrhtU33xE8tfWfU3DikyirOo4NnU7pmHxKFdkIfg==@lists.linux.dev
X-Gm-Message-State: AOJu0YytTnTB/C5st4aZnlwsMRglhpqWEKHhux3y19m/z9pcf3RjYLO7
	nE2+68OEVRxGoDmll06fcN7uci9/V6ZgTgoGM+xoVZwXdZmCGS8eRmkwLVfzmU5KeNF535ZJW6m
	dTIbRyky1ymgL1JQQdkru6K8NPW1JcCARk1tqxdn+wmG86i0Tr+0+Mzwmug==
X-Gm-Gg: ATEYQzzDoBeujHION5UkN4ZVlojtiY1IY4rZm3h89A9sYcOtcbjFmuPU9q64yaqaw3i
	dd+AHxECHvHttJx0XFRg4QATNoZ/G+osaRkpgodaAxuDWhJJCJXJwDkIwCQMrHCXaPRFZFQq3bI
	7Ol8Id8yMYX0U0lbt5LA+DUDsPAUlvTI/tNugQphQdUa67cZtpiL3pZNuo3PoYFq3eaGHOyHlLs
	rvdSxESnd30inTcKh7+mVo5GCi8r8RKEpQyG20XcTNcfviaX7uaMVUwV7m9UbMrIarrL3z16/Op
	B+jlFrnBVBh5AsN3WcDXymokRqtQZVF5YUtYH4jx4Bi6jaFgi0OqOm4nMkhCUfIzgyIVoGNkSFu
	/LoMQuY0uTRgQxXOA5BJlNAtGUPBOZEcx0mh5WmA80TvTAqB61TQ2vJAT9j7X9dNtg+LIMLhuh9
	g2pBwbExSFvmnuuuMolfLPNtSA1/9BAVQe28k=
X-Received: by 2002:a05:620a:4005:b0:8cd:9938:9803 with SMTP id af79cd13be357-8cdb5a62213mr510791585a.32.1773416132789;
        Fri, 13 Mar 2026 08:35:32 -0700 (PDT)
X-Received: by 2002:a05:620a:4005:b0:8cd:9938:9803 with SMTP id af79cd13be357-8cdb5a62213mr510784585a.32.1773416132102;
        Fri, 13 Mar 2026 08:35:32 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a156366b22sm1561943e87.77.2026.03.13.08.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 08:35:30 -0700 (PDT)
Date: Fri, 13 Mar 2026 17:35:28 +0200
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
Subject: Re: [PATCH v3 3/7] media: iris: add iris vpu bus support and
 register it with iommu_buses
Message-ID: <nqsysgx3w7awyfvhiq2t5jgelpmptht3art6bsfsvjz5sq6xkj@3wpkqy4a4c3i>
References: <20260313-kaanapali-iris-v3-0-9c0d1a67af4b@oss.qualcomm.com>
 <20260313-kaanapali-iris-v3-3-9c0d1a67af4b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313-kaanapali-iris-v3-3-9c0d1a67af4b@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDEyMyBTYWx0ZWRfX9wRGj2bSmJv8
 gl5BdCwNrkyt90flnBttBa39AIfYiaBsUaxYc8CWtUGaY+3E2cBY+j05EV6CeylPJyDUKSFQ1hq
 coxAyDNJ5jRvut8g9GsI+oFm0ogQWw2apL9+r0N3LK05QoEFWvHqxQA46uVN2WkCO2ixdzbt59r
 fQQliQPyszXDuBkotpqitUOrcv3vbzSXHEBvGo8UnsQDUOvRUE00gFkvyZ64By8IKHGd/7Jmqn+
 Yzf09CYkLmGIIsB/EfvcBYAms/4rcggMAqUzFmEdyLMlzngq2tF9AbGVR2ZQLw7W6rULZKH7vmx
 ZV+iXUvX/sor4rq34jbYDQ9H79iUkVxbGEZ25fvffuiC4Cpv1Qk1JVLDmHc4aVQ+lMs1OCUt+pv
 t7Yar0aiiy0jbP+Ecl47GreBX0q+Bf3VB0cIlSjlGgJbgotZ6xwYBBeVhA5+ei+1JxKbEa1u7VE
 3pGW+tVarP2T39Y581Q==
X-Proofpoint-GUID: q-ZC7YRE1iMJSTIzkmRSN8hMvL3gYGz2
X-Proofpoint-ORIG-GUID: q-ZC7YRE1iMJSTIzkmRSN8hMvL3gYGz2
X-Authority-Analysis: v=2.4 cv=H+vWAuYi c=1 sm=1 tr=0 ts=69b42ecd cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=z0f7ToGzsUK0FFPo7AcA:9 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 malwarescore=0
 adultscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130123

On Fri, Mar 13, 2026 at 06:49:37PM +0530, Vikash Garodia wrote:
> Add iris vpu bus support and hooks the new bus into the iommu_buses
> list. Iris devices need their own bus so that they can run their own
> dma_configure() logic.
> 
> Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> ---
>  drivers/iommu/iommu.c                              |  4 +++
>  drivers/media/platform/qcom/iris/Makefile          |  4 +++
>  .../platform/qcom/iris/iris_platform_common.h      |  6 ++++
>  drivers/media/platform/qcom/iris/iris_vpu_bus.c    | 32 ++++++++++++++++++++++
>  include/linux/iris_vpu_bus.h                       | 13 +++++++++
>  5 files changed, 59 insertions(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 35db5178095404fec87cd0f18e44ea97cf354e78..fd5fb7c10da22ab548d359ca1f44504acc3d646c 100644
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
> @@ -178,6 +179,9 @@ static const struct bus_type * const iommu_buses[] = {
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
> index 2abbd3aeb4af07e52bf372a4b2f352463529c92c..6f4052b98491aeddc299669334d4c93e9a3420e4 100644
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
> diff --git a/drivers/media/platform/qcom/iris/iris_platform_common.h b/drivers/media/platform/qcom/iris/iris_platform_common.h
> index 5a489917580eb10022fdcb52f7321a915e8b239d..2273243d1a80446233dd82dcd77444aa043ad064 100644
> --- a/drivers/media/platform/qcom/iris/iris_platform_common.h
> +++ b/drivers/media/platform/qcom/iris/iris_platform_common.h
> @@ -204,6 +204,12 @@ struct icc_vote_data {
>  	u32 fps;
>  };
>  
> +struct iris_context_bank {
> +	char *name;

const

> +	u32 f_id;
> +	u32 region_mask;

Unused here

> +};
> +
>  enum platform_pm_domain_type {
>  	IRIS_CTRL_POWER_DOMAIN,
>  	IRIS_HW_POWER_DOMAIN,
> diff --git a/drivers/media/platform/qcom/iris/iris_vpu_bus.c b/drivers/media/platform/qcom/iris/iris_vpu_bus.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..9e9fdeb6e405aab26ecf5e57ca91fca6b8eda2c5
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
> +	struct iris_context_bank *cb = dev_get_drvdata(dev);
> +
> +	if (!cb)
> +		return -ENODEV;
> +
> +	return of_dma_configure_id(dev, dev->parent->of_node, true, &cb->f_id);
> +}

There is nothing Iris-specific here. Can we please turn this into a
generic code (ideally also shared with host1x)?

> +
> +const struct bus_type iris_vpu_bus_type = {
> +	.name = "iris-bus",
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
> index 0000000000000000000000000000000000000000..422898cdf2f62eb7f4583d970a01c8776dd12164
> --- /dev/null
> +++ b/include/linux/iris_vpu_bus.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0-only
> + *
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
