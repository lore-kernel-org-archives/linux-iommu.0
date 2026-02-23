Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B061376490
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 22:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771886705; cv=none; b=WMt2lQlUN93aAyU7+p0fTrDzmdhEL5SmE7b+jb4unXh1BoPFNofkDS/yLWJ3RzZhTkYDfBgrdpkCMF0VIRgARnjDVeCl8afh5ES0gpPQps9573l9cMaZftOzyxNqBmvjeXFXQPHDPR+IdC5vWa6I8x883cuQrKlU2Rn9PLDkkmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771886705; c=relaxed/simple;
	bh=TdtJJEcR36eOIcMiT4ZO5zoHynLWdppAn7a7AhllwY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rEm3jVUJ85DG/aJE2/f+JZ+gQ6PdV6nO/aTTa/m20C/WrIRi1XAF3uEG5K/vzJ9goZDZfLQAdyjrTN5spaVoD6dTMA94Nx5KweVtwq9ltFMVg5cMQJPFXSPQjx0AaKKEsWqm72BolE6OEyWjmiPXTssslxXuBl9ddQsyxkeYHdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RxwZI8N7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ITKkIkxD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RxwZI8N7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ITKkIkxD"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NGRLjp1640663
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 22:45:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=4uwG+VSOUPiQWFQC4n/buq2e
	c1Jxta6TBA66E35NxDU=; b=RxwZI8N7h8IyqIggGJxquVH3UCDbV1q5LiSJ+ilt
	DdciWWZZ87rygoZLFTX7IFnxwhjw3a2NekubPTReBbZdvT5/4SSjyEZb+WDNYh8A
	WQ8gdZL650EWkFAtysqxYKeuW8qApHFcT2N74xuR4TKihkr/XGpCrAqdNYDAxs/1
	NT49p75lSokhEFFtzG1AVZFQmoeq3548hEiK7Iw7IhrArm4kDLXTLXWIURFHHJWi
	f4G+rooV2wwz+HpS0+nJec8gygbF88Xa8UpYvzXt/UceJ+BeoiwcqyxKG4b6W0ho
	FxvSAPylmmsj5J5FZAGJVokXdrAbR8YEUY10TUTO78Pghg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cgte8s27f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 22:45:03 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cb3ad1b81aso7091655585a.2
        for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 14:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771886702; x=1772491502; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4uwG+VSOUPiQWFQC4n/buq2ec1Jxta6TBA66E35NxDU=;
        b=ITKkIkxDhylXmhe0oMpi/UFtJbVn3uVR2GXIwtOvQrh2Bvylv3b24kv0/mZl8B9BVg
         euBxP+IYA3IwCoSfm1saZ2t9yJ1+XBkfGIkaZe19CognxaR6Dob07KFxbAkMz/21kusC
         dR7kKybwO7K5Zx1FzXmORekc0Yy7zgMXgB4mRCPtl22h8k+FlcbM6gaAODq/XzUEHLQZ
         rNd310NU65eA6benBv3qKy30Pin27VAygxrp10rfQ4ZUsb0g0FqL9nCthYtlxDfd7it7
         shd1vDtqwBwWOZ9SgtL5hjB8xdfIMtOU4gHLaUis/rDhjqf8vwXhYuTbZPmSt818P2VJ
         wkDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771886702; x=1772491502;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4uwG+VSOUPiQWFQC4n/buq2ec1Jxta6TBA66E35NxDU=;
        b=mD7mENcRT2YoD1XmdN/j0Y1p0yzT2T2U57lY4anz4EgHpaZyaKXmWXph7mUByxmRLe
         mQzqTaLaSXyYTE1tcNzPVMQAIMQWn7HkWe1dB8i8o32aUxaUJxVqyIctkYT500lor+YU
         OhMBx1mymEaWyIairntiNVtVF2soEl/gQXHByeawykaQv4FIfBWIQ1MGiRYDIMqzK8yE
         Bhd26fkgVoags2rS6XadDiWx+zw2NLT9oQYkHYgGHAvGcqJQ5+yxvroLc8Tk+uouIW5D
         PcOEuLRlRlxbv3D4lNs4Xdf3z1SY7w6l3ikkbIXSMqXrV0JexWQbUA8kslHvZ7a1tFbn
         l+jQ==
X-Forwarded-Encrypted: i=1; AJvYcCUB75bff2dCk0mVRqPPmSQetHybwD475ZTMXtzWtQqpRCsXYW8m0I5z/S2zwbR9U6Npg2/Iaw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx8peC1X8VnQ5YbJ06Nwhs7I6pHBnq0q3U4Eg00iGCUy37IXoEx
	FK/X7Z7N3jrlrdztOc5dp/b1L1JN8aGVzsHGhQg0FnoXvLO0X/puNquN9zvpmbdyvES3q8H5Aaf
	R+cjTbs8gjIEGlA/U84moVAnUn+L9DzLLIuF4hW8+MOJBEYEIX1FC4apCog==
X-Gm-Gg: AZuq6aLom2b6OyAgp/x7JiVIXzcNyO4jjPcrcg1nFrsddDNvMmNKcz27pL+/RapH2B3
	W0YTPuTHlWM/SnAZMQX7S1QehQVSTI53cyIsJ2eCHz45jzdkQfeJ6Hex/qwKDF3ofnvdV37WDZT
	RBu+AnTfqeZYXzZvvSpKCkaeEzaBzWF3JSmZJ2leMXScr7QW66PDHHYIwKiW5eFVF3toG3k7kll
	AurPT5MZUrkqh6CziDHVr7XJBmvcb/jkgds0yp6REHxILFoMuujnHVa40poIzWkvlsHr7AOvJBB
	zULCbkdNQZ0e1JF3owiFNs1hxCtOr3oINPTYht6AhPtxu2/Sp/7/9uT0e0lies8hYPKm1ng8TVp
	mB245LJgPNGaKdAiF3SyllJC0CKkx6W7x2hrUX3hRI8YQj9f4taBTLsCdWf7WRnqUiOlLu9OWne
	Be7C7Hhis2PkgriS9E5ggEViLNuDBpAeGcKWs=
X-Received: by 2002:a05:620a:4727:b0:8ca:2bab:a0f9 with SMTP id af79cd13be357-8cb8c9dfd2bmr1406786985a.1.1771886702346;
        Mon, 23 Feb 2026 14:45:02 -0800 (PST)
X-Received: by 2002:a05:620a:4727:b0:8ca:2bab:a0f9 with SMTP id af79cd13be357-8cb8c9dfd2bmr1406783685a.1.1771886701837;
        Mon, 23 Feb 2026 14:45:01 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a0eeb3e9a2sm1832057e87.55.2026.02.23.14.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 14:45:01 -0800 (PST)
Date: Tue, 24 Feb 2026 00:44:58 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Cc: Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Bharath Kumar <quic_bkumar@quicinc.com>,
        Chenna Kesava Raju <quic_chennak@quicinc.com>
Subject: Re: [PATCH RFC 04/18] accel/qda: Add built-in compute CB bus for QDA
 and integrate with IOMMU
Message-ID: <ox7jnqkjo3frhbgpp63sse7ram72obihe4qlbbn4z22wbw4szr@7pzoeecdvsyg>
References: <20260224-qda-firstpost-v1-0-fe46a9c1a046@oss.qualcomm.com>
 <20260224-qda-firstpost-v1-4-fe46a9c1a046@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224-qda-firstpost-v1-4-fe46a9c1a046@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: 0xMcy2IdaDzxV4tHfy9LDEe0fWvrNFGD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDE5NyBTYWx0ZWRfX7QV3IESVrA6L
 oNBqDpWkbJBf7OeNZhKXhPLsGXWe+eKAd17eOxZCwG+im7FqeYpibRLzohXc7Yr41ZzXFeHnv6p
 0Q3F3yGxeU3Di90dec6ppEvLFo47i+p+2l9/7axZBvpp6ZdR1e7N6blDoHFrNHVETM5Ey+ZIZZT
 iV9RuWm3lOMMIdT8ezaOPSN8nJUlsBx43jpvkE/ApIuUDig9nX5NE5rJFhVpwbB838RohK3qeTk
 qKDu9x8JbUnhpruqhPMxAo3cCkrjaSnETumjJYfBi4E3Q6gxBYc+JflcC+Mqi4BYDTr4ZCyLE5T
 DqI1Kbin1GYzLVOFotimQYKzQa5n8YZE2IXtAjMM8rCp8SldYvXkXHhDz7QYzNAfyDBVZHNGgv4
 LiA9euJClUFJCsUQcxqbMhVIHD/gevulnmaKFwl5LR8LKfTN2RQ6lKaEKHVpDG5cTOaS8dAIeUB
 BHdbIMAVlxjZntiewzw==
X-Proofpoint-GUID: 0xMcy2IdaDzxV4tHfy9LDEe0fWvrNFGD
X-Authority-Analysis: v=2.4 cv=WqQm8Nfv c=1 sm=1 tr=0 ts=699cd86f cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=m81VUDHjpZwfiQc3ckkA:9 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_05,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230197

On Tue, Feb 24, 2026 at 12:38:58AM +0530, Ekansh Gupta wrote:
> Introduce a built-in compute context-bank (CB) bus used by the Qualcomm
> DSP accelerator (QDA) driver to represent DSP CB devices that require
> IOMMU configuration. This separates the CB bus from the QDA driver and
> allows QDA to remain a loadable module while the bus is always built-in.

Why? What is the actual problem that you are trying to solve?

> 
> A new bool Kconfig symbol DRM_ACCEL_QDA_COMPUTE_BUS is added and is

Don't describe the patch contents. Please.

> selected by the main DRM_ACCEL_QDA driver. The parent accel Makefile is
> updated to descend into the QDA directory for both built-in and module
> builds so that the CB bus is compiled into vmlinux while the driver
> remains modular.
> 
> The CB bus is registered at postcore_initcall() time and is exposed to
> the IOMMU core through iommu_buses[] in the same way as the Tegra
> host1x context-bus. This enables later patches to create CB devices on
> this bus and obtain IOMMU domains for them.

Note, there is nothing QDA-specific in this patch. Please explain, why
the bus is QDA-specific? Can we generalize it?

> 
> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> ---
>  drivers/accel/Makefile              |  1 +
>  drivers/accel/qda/Kconfig           |  5 +++++
>  drivers/accel/qda/Makefile          |  2 ++
>  drivers/accel/qda/qda_compute_bus.c | 23 +++++++++++++++++++++++
>  drivers/iommu/iommu.c               |  4 ++++
>  include/linux/qda_compute_bus.h     | 22 ++++++++++++++++++++++
>  6 files changed, 57 insertions(+)
> 
> diff --git a/drivers/accel/Makefile b/drivers/accel/Makefile
> index 58c08dd5f389..9ed843cd293f 100644
> --- a/drivers/accel/Makefile
> +++ b/drivers/accel/Makefile
> @@ -6,4 +6,5 @@ obj-$(CONFIG_DRM_ACCEL_HABANALABS)	+= habanalabs/
>  obj-$(CONFIG_DRM_ACCEL_IVPU)		+= ivpu/
>  obj-$(CONFIG_DRM_ACCEL_QAIC)		+= qaic/
>  obj-$(CONFIG_DRM_ACCEL_QDA)		+= qda/
> +obj-$(CONFIG_DRM_ACCEL_QDA_COMPUTE_BUS) += qda/
>  obj-$(CONFIG_DRM_ACCEL_ROCKET)		+= rocket/
> \ No newline at end of file
> diff --git a/drivers/accel/qda/Kconfig b/drivers/accel/qda/Kconfig
> index 484d21ff1b55..ef1fa384efbe 100644
> --- a/drivers/accel/qda/Kconfig
> +++ b/drivers/accel/qda/Kconfig
> @@ -3,11 +3,16 @@
>  # Qualcomm DSP accelerator driver
>  #
>  
> +
> +config DRM_ACCEL_QDA_COMPUTE_BUS
> +	bool
> +
>  config DRM_ACCEL_QDA
>  	tristate "Qualcomm DSP accelerator"
>  	depends on DRM_ACCEL
>  	depends on ARCH_QCOM || COMPILE_TEST
>  	depends on RPMSG
> +	select DRM_ACCEL_QDA_COMPUTE_BUS
>  	help
>  	  Enables the DRM-based accelerator driver for Qualcomm's Hexagon DSPs.
>  	  This driver provides a standardized interface for offloading computational
> diff --git a/drivers/accel/qda/Makefile b/drivers/accel/qda/Makefile
> index e7f23182589b..242684ef1af7 100644
> --- a/drivers/accel/qda/Makefile
> +++ b/drivers/accel/qda/Makefile
> @@ -8,3 +8,5 @@ obj-$(CONFIG_DRM_ACCEL_QDA)	:= qda.o
>  qda-y := \
>  	qda_drv.o \
>  	qda_rpmsg.o \
> +
> +obj-$(CONFIG_DRM_ACCEL_QDA_COMPUTE_BUS) += qda_compute_bus.o
> diff --git a/drivers/accel/qda/qda_compute_bus.c b/drivers/accel/qda/qda_compute_bus.c
> new file mode 100644
> index 000000000000..1d9c39948fb5
> --- /dev/null
> +++ b/drivers/accel/qda/qda_compute_bus.c
> @@ -0,0 +1,23 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +// Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> +#include <linux/device.h>
> +#include <linux/init.h>
> +
> +struct bus_type qda_cb_bus_type = {
> +	.name = "qda-compute-cb",
> +};
> +EXPORT_SYMBOL_GPL(qda_cb_bus_type);
> +
> +static int __init qda_cb_bus_init(void)
> +{
> +	int err;
> +
> +	err = bus_register(&qda_cb_bus_type);
> +	if (err < 0) {
> +		pr_err("qda-compute-cb bus registration failed: %d\n", err);
> +		return err;
> +	}
> +	return 0;
> +}
> +
> +postcore_initcall(qda_cb_bus_init);
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 4926a43118e6..5dee912686ee 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -33,6 +33,7 @@
>  #include <trace/events/iommu.h>
>  #include <linux/sched/mm.h>
>  #include <linux/msi.h>
> +#include <linux/qda_compute_bus.h>
>  #include <uapi/linux/iommufd.h>
>  
>  #include "dma-iommu.h"
> @@ -178,6 +179,9 @@ static const struct bus_type * const iommu_buses[] = {
>  #ifdef CONFIG_CDX_BUS
>  	&cdx_bus_type,
>  #endif
> +#ifdef CONFIG_DRM_ACCEL_QDA_COMPUTE_BUS
> +	&qda_cb_bus_type,
> +#endif
>  };
>  
>  /*
> diff --git a/include/linux/qda_compute_bus.h b/include/linux/qda_compute_bus.h
> new file mode 100644
> index 000000000000..807122d84e3f
> --- /dev/null
> +++ b/include/linux/qda_compute_bus.h
> @@ -0,0 +1,22 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#ifndef __QDA_COMPUTE_BUS_H__
> +#define __QDA_COMPUTE_BUS_H__
> +
> +#include <linux/device.h>
> +
> +/*
> + * Custom bus type for QDA compute context bank (CB) devices
> + *
> + * This bus type is used for manually created CB devices that represent
> + * IOMMU context banks. The custom bus allows proper IOMMU configuration
> + * and device management for these virtual devices.
> + */
> +#ifdef CONFIG_DRM_ACCEL_QDA_COMPUTE_BUS
> +extern struct bus_type qda_cb_bus_type;
> +#endif
> +
> +#endif /* __QDA_COMPUTE_BUS_H__ */
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
