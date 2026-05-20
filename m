Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77083E9C19
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 14:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779287396; cv=none; b=OQmk3+yuMZEpxRHie0Npx5xBI1hTZbGzmFyWViJrboPGBN8NjcnAjLKPk3ZY5bPH/UCb3XLPyeta3bAez97JSXQdaFhNJ5o4qxXdQQf/4tyz/4jyoyTlEpX52mhNXjsQ/SnD3GKRDfPQ59ptIWujE75L4URW0hHvyWb8OPWJD/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779287396; c=relaxed/simple;
	bh=oTAaOfFsFc8YiZ5sMXWMZAs7U4u7jgj04sZm//ztqmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TACb3FXJ0V1rqlA/bG6pjT+R9jv/9yHhwlyV+E5c8jsEWoYtlsbaYdGo+O6SK06W034PzyR7UQFqaP4SYwbGCzh9eyddo/f8BzCBKui3/Q0AmHZmrV9oM+GT1aihlhFYi7OPyJzs9/p5k2DecuDitOoDZ/16CNGC6b6l9R1VV44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eZmVQFG/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NCjT4ewr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eZmVQFG/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NCjT4ewr"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64K8ud1p4115192
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 14:29:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=pxOt6IK/i3ibZ79BpGFSHKfb
	P+cfEih0yG4dCpDnkIo=; b=eZmVQFG/A3xV3qUS4A0vUqI9P0C7ARkGzo0UX+4z
	ttYkvelNRt8/3mtaxRtZiGQMTYFTeZa0qD+e+bbTtQHPMtb1q4FYEuaA+E6SpUun
	Rx865+RpRmohzVR612Om1+ptNWx/pRYRS3zumRhYDpLpUS8x9iJiLkusgJmgrPR1
	9tIDn/ZN/vkOXo416xZlg4nJ6VktEK112DGJ6p3UWQ3vbesOi1ZExRo3Nsy/p4H2
	WHiuTbU8kIvFlttlPUhPEDnlSV37cheZyCntY42NL/EsMEsbGpG+KF0imZCp9Peq
	hCYYKSLFaSysZA8ODrnuxfkbMTqKpPyj8oz87joZg74c8g==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e99w0h7qj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 14:29:52 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-577c69d3f04so5433468e0c.0
        for <iommu@lists.linux.dev>; Wed, 20 May 2026 07:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779287392; x=1779892192; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pxOt6IK/i3ibZ79BpGFSHKfbP+cfEih0yG4dCpDnkIo=;
        b=NCjT4ewrGxkjpTunBuxDIM8TEG2ZdbYmgWANaMWQrpVZwnOsVORuNQoY2B6e97xdDd
         T3rxuaZ5wEHZ++Lw+2RmGZ9bqtBTJvNEbNUde/nSGFQLfyhu7YXZ2bxTA0E90LqPNMek
         oOeKdY7DVRvgip6L2qdyVd6rclux+WgJcVvnidztcDdknaWjLPUN+HNpRS95p+YzkN1k
         20BWELKdJj1iA0aWzBTzoAWdPlEZzDaiW2mYUYfmIicQGgHxDsuraM/zXN3+joC1rmjQ
         iXoGduEVf13IkmWQdA9+zRhPKH0PjlTJtXA8KKEt2VWt1r3YsN2n6eX396YzoEiH13F9
         f1Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779287392; x=1779892192;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pxOt6IK/i3ibZ79BpGFSHKfbP+cfEih0yG4dCpDnkIo=;
        b=AduN8gOoVtih8rHF1DvhqXp3YjWvnGrXIbjwVIWGN+LZ9oshJkEE7t8Hljt1CPKZ8h
         qtfet8hGLgOZYOG7k7eHuV1mItDX+uOFQygtlQ5JYAQlfWsIwPeDlmsY1HbqHn5B2UdE
         gfKIOd38hpDR5zsncQ8+22Wto5tYsIIn0Dw0ixkwqJUmjQODtYqRUrUXo8NNbK31YPA9
         o6FAdI31KKmdj7KMR2/ZSOIJT8iFF9uMjdCZsSwgpG1vT1PFPhZyddnSS2c2jwxa7RLC
         guAW7MkTxb27H+Cm1XoMOHDl2595ZaJuP8wAciQKEbHn+buYx5yK9oEZswVtKJ+RGbp9
         Bn3w==
X-Forwarded-Encrypted: i=1; AFNElJ+zZ24hMqkU1wMr9NGQI4Z5klzAbmw5TWmGmPGEcoMiA7ehb+XIJONWLfuoz/FNqvHRAtYX/Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzz9vvi2MXH0P8IYFgi5JDPZJv+zq0K0RMFHEjnT7AB/8JqKTk1
	A8GdmUlGaKSu+YIQEQiEU1YQMTKgHz3Vk1zdHMgLbGdPpZWjwS7irj5xAnpA2H0Ioz8qf9VTGTl
	Lt7k1iy92Bo3pzvEUBOWm8ixjh3r1BvDknd3Y3+MwaLaXHBHaBY5rHVQufg==
X-Gm-Gg: Acq92OF1VDSYRhfJIcd1jCbTV4t7fmta9p6711JWIvy5q/HQOhQpv/YbPG+gfjhDUIe
	0lbw60xeh3IynsOH+t+bxnUp6poXsbcPVcMhBrY2pD1zKsWMLVUgDrCi+dAFMuOhJjd+JDB30fG
	6PnWDPqSexbuz2V5V9/BEFiPpyrtggFlbTtkSRWJWMHX5j9N9nBy7P5Ve4z3dD7XU6jOGATFW9D
	uSLSCf8ucnuVJ4UvMyABJ26KsECfTEylG8VOem0DuS+N0HXhIOXFITQVpT2pH4BJ4obgXLJRedN
	Xlqht4aXUyug35bOkXWvvGSWTpEUQnuekJI2/JVz2AmgYAr+Vc5UM/+Nd1BLGM9TfFQma4u50aQ
	mS1mNTo948oURJ6WHATiTxBOmspYATrIJ2Rs4tagP4L5nIz7iJGEzyW1vcWHJxTrBG0q9eJUng0
	+YdYWdDX8HfTaND72jSnr1Pi7w/4zt9o5NRwg=
X-Received: by 2002:a05:6122:910:b0:56e:e9cf:7134 with SMTP id 71dfb90a1353d-5760be33374mr13875385e0c.3.1779287391892;
        Wed, 20 May 2026 07:29:51 -0700 (PDT)
X-Received: by 2002:a05:6122:910:b0:56e:e9cf:7134 with SMTP id 71dfb90a1353d-5760be33374mr13875318e0c.3.1779287391196;
        Wed, 20 May 2026 07:29:51 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a9164cf0a5sm4942878e87.75.2026.05.20.07.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 07:29:50 -0700 (PDT)
Date: Wed, 20 May 2026 17:29:48 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: ekansh.gupta@oss.qualcomm.com
Cc: Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Bharath Kumar <quic_bkumar@quicinc.com>,
        Chenna Kesava Raju <quic_chennak@quicinc.com>, srini@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org,
        robin.clark@oss.qualcomm.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH 08/15] accel/qda: Add QUERY IOCTL and QDA UAPI header
Message-ID: <m4zo2nkxtl5yeyo7riuata6r5saflmdgqf37cz2g2ezrwhk53m@mnad6bb7n3ik>
References: <20260519-qda-series-v1-0-b2d984c297f8@oss.qualcomm.com>
 <20260519-qda-series-v1-8-b2d984c297f8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519-qda-series-v1-8-b2d984c297f8@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: XSpLOsxosukmS6OJ_7at-uAaYvLE1xbY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE0MSBTYWx0ZWRfX+hy5/wuqXiR8
 g4g23XPk6H/jJI1ZO7NXbjFXkjrNoZM8Z8N9S8uXTApdy6KE1WaLgkHpcPXgZxj2vX27YMZAxb/
 tAmduqxCEIZzF8oZvriiBWK6sBN+WEgjirHiXumdEpoRR+nK/y11Joxvc7pXKkOLtTi2rM2T2RJ
 OaG65ISLTp2cWfLjf3OuowK68/ohZQsivvNvgIU37Brrx14vROH37qMaqOaYdAblhNoQXnw38id
 pxh/LDoQW2mrzOw2MOdNV+MvcYN+/+1j5ZHdy4O4m+Kq2u1IZmnQ9FFvZbM0gInF91YrbKbXsuS
 wjgdhZmr1NeJDbz6Bm1bIEjuZaZ6vjEc40z/nq26/toNxzN4fpDCIXHH0QAUrB19eZWZXIC9R7C
 HjCxXNXJcyaxGYi2XEePoHKqdVAlM1EVgDaoJc9igK9lvIzISP1XNE9e2M/eISZTnei1CJ4iwh5
 +4optTRuNbC7d3rELgg==
X-Authority-Analysis: v=2.4 cv=RZigzVtv c=1 sm=1 tr=0 ts=6a0dc560 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=KrLRuONc4nWYnVYYFb0A:9 a=CjuIK1q_8ugA:10 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-GUID: XSpLOsxosukmS6OJ_7at-uAaYvLE1xbY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 impostorscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200141

On Tue, May 19, 2026 at 11:45:58AM +0530, Ekansh Gupta via B4 Relay wrote:
> From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> 
> Introduce the DRM_IOCTL_QDA_QUERY IOCTL, which allows user-space to
> identify which DSP domain a given /dev/accel/accel* node represents
> (e.g. "cdsp", "adsp").
> 
> include/uapi/drm/qda_accel.h
>   Defines the QDA IOCTL command numbers and the associated data
>   structures. The header follows the standard DRM UAPI conventions:
>   __u8/__u32 types, a C++ extern "C" guard, and GPL-2.0-only WITH
>   Linux-syscall-note licensing.
> 
> drivers/accel/qda/qda_ioctl.c / qda_ioctl.h
>   Implements qda_ioctl_query(), which copies the DSP domain name
>   stored in qda_dev.dsp_name into the user-supplied drm_qda_query
>   buffer using strscpy().
> 
> drivers/accel/qda/qda_drv.c
>   Registers the qda_ioctls[] table with the drm_driver so that the
>   DRM core dispatches DRM_IOCTL_QDA_QUERY to qda_ioctl_query().
> 
> Assisted-by: Claude:claude-4-6-sonnet
> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> ---
>  drivers/accel/qda/Makefile    |  1 +
>  drivers/accel/qda/qda_drv.c   |  8 +++++++
>  drivers/accel/qda/qda_ioctl.c | 26 +++++++++++++++++++++++
>  drivers/accel/qda/qda_ioctl.h | 13 ++++++++++++
>  include/uapi/drm/qda_accel.h  | 49 +++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 97 insertions(+)
> 
> diff --git a/drivers/accel/qda/Makefile b/drivers/accel/qda/Makefile
> index 701fad5ffb50..b658dad35fee 100644
> --- a/drivers/accel/qda/Makefile
> +++ b/drivers/accel/qda/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_DRM_ACCEL_QDA)	:= qda.o
>  qda-y := \
>  	qda_cb.o \
>  	qda_drv.o \
> +	qda_ioctl.o \
>  	qda_memory_manager.o \
>  	qda_rpmsg.o
>  
> diff --git a/drivers/accel/qda/qda_drv.c b/drivers/accel/qda/qda_drv.c
> index 0ad5d9873d7e..becd831d10be 100644
> --- a/drivers/accel/qda/qda_drv.c
> +++ b/drivers/accel/qda/qda_drv.c
> @@ -8,8 +8,10 @@
>  #include <drm/drm_gem.h>
>  #include <drm/drm_ioctl.h>
>  #include <drm/drm_print.h>
> +#include <drm/qda_accel.h>
>  
>  #include "qda_drv.h"
> +#include "qda_ioctl.h"
>  #include "qda_rpmsg.h"
>  
>  static int qda_open(struct drm_device *dev, struct drm_file *file)
> @@ -36,11 +38,17 @@ static void qda_postclose(struct drm_device *dev, struct drm_file *file)
>  
>  DEFINE_DRM_ACCEL_FOPS(qda_accel_fops);
>  
> +static const struct drm_ioctl_desc qda_ioctls[] = {
> +	DRM_IOCTL_DEF_DRV(QDA_QUERY, qda_ioctl_query, 0),
> +};
> +
>  static const struct drm_driver qda_drm_driver = {
>  	.driver_features = DRIVER_COMPUTE_ACCEL,
>  	.fops = &qda_accel_fops,
>  	.open = qda_open,
>  	.postclose = qda_postclose,
> +	.ioctls = qda_ioctls,
> +	.num_ioctls = ARRAY_SIZE(qda_ioctls),
>  	.name = QDA_DRIVER_NAME,
>  	.desc = "Qualcomm DSP Accelerator Driver",
>  };
> diff --git a/drivers/accel/qda/qda_ioctl.c b/drivers/accel/qda/qda_ioctl.c
> new file mode 100644
> index 000000000000..761d3567c33f
> --- /dev/null
> +++ b/drivers/accel/qda/qda_ioctl.c
> @@ -0,0 +1,26 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +// Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> +#include <drm/drm_ioctl.h>
> +#include <drm/qda_accel.h>
> +#include "qda_drv.h"
> +#include "qda_ioctl.h"
> +
> +/**
> + * qda_ioctl_query() - Query DSP device information
> + * @dev: DRM device structure
> + * @data: User-space data (struct drm_qda_query)
> + * @file_priv: DRM file private data
> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +int qda_ioctl_query(struct drm_device *dev, void *data, struct drm_file *file_priv)
> +{
> +	struct drm_qda_query *args = data;
> +	struct qda_dev *qdev;
> +
> +	qdev = qda_dev_from_drm(dev);
> +
> +	strscpy(args->dsp_name, qdev->dsp_name, sizeof(args->dsp_name));
> +
> +	return 0;
> +}
> diff --git a/drivers/accel/qda/qda_ioctl.h b/drivers/accel/qda/qda_ioctl.h
> new file mode 100644
> index 000000000000..b8fd536a111f
> --- /dev/null
> +++ b/drivers/accel/qda/qda_ioctl.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#ifndef __QDA_IOCTL_H__
> +#define __QDA_IOCTL_H__
> +
> +#include "qda_drv.h"
> +
> +int qda_ioctl_query(struct drm_device *dev, void *data, struct drm_file *file_priv);
> +
> +#endif /* __QDA_IOCTL_H__ */
> diff --git a/include/uapi/drm/qda_accel.h b/include/uapi/drm/qda_accel.h
> new file mode 100644
> index 000000000000..1971a4263065
> --- /dev/null
> +++ b/include/uapi/drm/qda_accel.h
> @@ -0,0 +1,49 @@
> +/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#ifndef __QDA_ACCEL_H__
> +#define __QDA_ACCEL_H__
> +
> +#include "drm.h"
> +
> +#if defined(__cplusplus)
> +extern "C" {
> +#endif
> +
> +/*
> + * QDA IOCTL command numbers
> + *
> + * These define the command numbers for QDA-specific IOCTLs.
> + * They are used with DRM_COMMAND_BASE to create the full IOCTL numbers.
> + */
> +#define DRM_QDA_QUERY		0x00
> +
> +/*
> + * QDA IOCTL definitions
> + *
> + * These macros define the actual IOCTL numbers used by userspace applications.
> + * They combine the command numbers with DRM_COMMAND_BASE and specify the
> + * data structure and direction (read/write) for each IOCTL.
> + */
> +#define DRM_IOCTL_QDA_QUERY		DRM_IOR(DRM_COMMAND_BASE + DRM_QDA_QUERY, \
> +					 struct drm_qda_query)
> +
> +/**
> + * struct drm_qda_query - Device information query structure
> + * @dsp_name: Name of DSP (e.g., "adsp", "cdsp", "cdsp1", "gdsp0", "gdsp1")
> + *
> + * This structure is used with DRM_IOCTL_QDA_QUERY to query device type,
> + * allowing userspace to identify which DSP a device node represents. The
> + * kernel provides the DSP name directly as a null-terminated string.
> + */
> +struct drm_qda_query {
> +	__u8 dsp_name[16];

Are you sure that you want to query only the name? No extra options, no
attributes, no hardware capabilities?

> +};
> +
> +#if defined(__cplusplus)
> +}
> +#endif
> +
> +#endif /* __QDA_ACCEL_H__ */
> 
> -- 
> 2.34.1
> 
> 

-- 
With best wishes
Dmitry
