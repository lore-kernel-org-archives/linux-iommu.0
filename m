Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E0C37AA85
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 22:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771885505; cv=none; b=rLHY4/OBpJg7rGsZvOFdtgIiL6UAmlj/3Nzio9CDqQ1MH7IP7eSdd++ILYKpBCkbfiWd+qSZOesDZ9kB7lh5HMTQoPVigR1FXHTFfWuZCoaMK+7JwLx2la12LzEUEbnI1dHFo9uzMu1IGJ5l+akcyGc9FPlsXyWBUfGyDbFFJ3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771885505; c=relaxed/simple;
	bh=MwKJDhOjSy9TdjHhjCLJ9vblSJrwhPM7tm/CCU/Mc0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r5mcUU1xJk0JSY8MZoyLO2LWLVqU4KRdnHC3n4m3UY3vtlDcEciUNGpilgofu1FPdzsRtmWBIGZCCehqBlXIQz84ChfinxDab591zbtNW57iPn8KuyYj5xNH+QypOSZyOIrV6bvK1hmqg4r5rzZiYvjS8Vs0OgsCiTQOd/rhqig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NlNaGhn1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hTxiIiUz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NlNaGhn1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hTxiIiUz"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NHxmu0322212
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 22:25:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=4t4vMCyeh5FO8jHV4Nz0hUoW
	U7ZCESWTx0v5D054J3c=; b=NlNaGhn1KhBjgV9mj/VYdOuU5ehV1qao8RrvyFtR
	zExj38kIV0zWDm18pJGvUwLfN6wyNUWJ0IFpc1fxavo7aNESt99sIkVzsBUgJnCe
	DtmbrMykIPEaWOw3+hHEb5Zx0PRP76gidoainjQqZT8VENFUGVubnn+4YXe3Atva
	HAdUbM4MvYcDVGIhfHjgt5+W423EZIwsNzjzMyHVqyj39/ifQyrMju7P2HHNDdJQ
	G2i0gn4V72P8glMZ+V4M0OOeHcXKV8pa/ud9ZJOXhycGqtZxcfx/BLylq7WdFuOP
	p9x4sCFuEFRfdlmXYyI/WJaHS2iU7AjJ8a8MhG6T7TMt0Q==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cgn8y233c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 22:25:02 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cb706313beso688598685a.3
        for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 14:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771885501; x=1772490301; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4t4vMCyeh5FO8jHV4Nz0hUoWU7ZCESWTx0v5D054J3c=;
        b=hTxiIiUzhoFdRlODNB/hZ7KCJIc8tUpP5aFLnHCPEKlpM1a6TglDkhBZ+ilUiiCeRb
         I4vU3DqtpqSVzfmMMkDu2zYAKuF1qF7xj+z9QiyXfFhgqSw04w9+kS+ky2vUvHMsDpmP
         x8brQgiYkfgv1HKqfoffU8ztF8SoPTmoP/QDVayiW/fHTBDg/Q3rV0kheJCCuhRyNsYf
         j/ueknHt7mxjcQAXcPzpqPqaHNBc5C8oBH2qskQV0opg5KNepu0ScLubkqmyhgI0WW+F
         PXzOGGqNGQCEH8uWAiZNLwKeiSb3Ct5lozwJhIrH2ixKmuWVWeWCPzC3dmkgvC6YliQQ
         bzqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771885501; x=1772490301;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4t4vMCyeh5FO8jHV4Nz0hUoWU7ZCESWTx0v5D054J3c=;
        b=J4XHjZlt6/oTGB5Os0K6kN9nFhTMeRw86xUw5fXO3KrPQhwbWSyjVXrcaL3MMxsSKl
         IjmIIS2mJGwHa7xJ61az/3ExZpzRIWZPrRJsdXQNB7V0EcsD319GF4k08nastywJOHCR
         /mF1lDbVu/9YgjRcRVV7B0tIaCXKk0gtCp8dyuJebVeh1L5Hhs7azYBvbJxuRtaZUw2i
         E9XCUIf7KO9x2Wm7YQ2Trp5YyHTNNOZeOPsaSCnNmSHeiU05IxkOqY2LwU2U2G1vIkFj
         k1hjjHB+vBCeWLgkJ+DGgxqCZrZDq4U32mydmdRQ4aFHZXOYf+Zqal9CjMk2kwiIRlun
         3AYg==
X-Forwarded-Encrypted: i=1; AJvYcCUOFehaDWoD4gkTl+bcbsM4TN5ZxG/7P0CJchPtq4cDFcv889Esg2ilK+kuxVMk17WDg6dC7g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzf/gPAMWzDrTMl9BSQ8/5ZKb7TfzlCed/OKvJuHtoqIwgJVmKR
	GtSdkQ0SVwMVXJhs6ewxpXhA5XqqmwOEutnepr6ki8M59qEdzQnVUdeFiNn5skPcxdRB785bqZ7
	geltgTbYsvehqFsDy6C3ntMVwrIRnUUIXTo9HBeVSRhaRAmsJEyqkgYyo7vD1O6hYsA==
X-Gm-Gg: AZuq6aLWgy2DieI6j6/Ln/UmC8Qo8R2x3M/i24I62oyFPUBj+IiZa+OadmSVRLCyI5p
	ZtBXCT2+yW1pJBtX4uAfkK9KX6LVON4X3hDlZXS7pklDYb19RqN6sYCtRJG2lJspUHSvTm/4cVQ
	5wU6uLEm93mot60ioz5og24f/L3zmW5MEA54S3ccHOMbZxNf0iyTEozz0uMlam88XY4a7JnfxG6
	c4ODurLk22yOtrh34vJqZSDdutvICzIQfqoF4kuoVfExZvgbHP6eqe9STVBFy5XQ3U0uB75QxAx
	AgSqmi5AvdEed1ZhiVab5zJnk7XOmD53lR72uTj8z82Hn1Mq38Hqa100YwyE/YogP1Oxgk6k5KD
	PYheu9zwSGE9YkGqufO2yd1XUbuJAAc4a3bUL6wuhv1I0uEmASjqcm3lwaN/s3z6zEuLA8B8D/d
	TTx+cWsy7QenY+2wfBSODPfns8Q+Sx+A6rWEA=
X-Received: by 2002:a05:620a:bc2:b0:8cb:3fb3:7bee with SMTP id af79cd13be357-8cb8ca65f6emr1222850685a.51.1771885499784;
        Mon, 23 Feb 2026 14:24:59 -0800 (PST)
X-Received: by 2002:a05:620a:bc2:b0:8cb:3fb3:7bee with SMTP id af79cd13be357-8cb8ca65f6emr1222846085a.51.1771885499171;
        Mon, 23 Feb 2026 14:24:59 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a0eeb1541asm1818660e87.33.2026.02.23.14.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 14:24:58 -0800 (PST)
Date: Tue, 24 Feb 2026 00:24:56 +0200
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
Subject: Re: [PATCH RFC 09/18] accel/qda: Add QUERY IOCTL and basic QDA UAPI
 header
Message-ID: <fzfuaeninr7lfbn74reoare7y2zoflddcvvnvyifnriw26swjc@igixj73zawrv>
References: <20260224-qda-firstpost-v1-0-fe46a9c1a046@oss.qualcomm.com>
 <20260224-qda-firstpost-v1-9-fe46a9c1a046@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224-qda-firstpost-v1-9-fe46a9c1a046@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDE5NSBTYWx0ZWRfX85ivUnUsSbz5
 +9Ffi2GV+ZbkQer2p+E804SpOnD0OwzUtHnl/dieeqS6KkspvTklEFGhcAOagBY5oHes+uBKN0q
 /bHMsyAlEaWYGAEvF0GD9hd5BchPBWF/x+Y9PK9grJcvhc9NQp9+if95Gt0RH5BW1Srnz0pSt1a
 vgtevAez9KBlKAzaexlxpKFKdG0+aMALOPaUVvh3vEjeeCxPdNMnC3z4n1mtbjCaeSouWbd+qvV
 W+07GvVzuTqePBz11wQOMKazytCII5gM5sIQWd3VhQ6K1ZsehGBM/NeYF/quYemtDxXMOsZ5H8F
 SqwqLE7zkZFgpEVyGFt/D2y6fQyyY6PNwRAkOY7aMEouaWbovXiYKcSXCWRqu2SxqFF0VGoZSA0
 hwjnkOlnLo8HeDiFIvub09PAZ1nlLy8iet554k9KKnY6JTH7dRl0RuvqNpcWhXGHsew5HWQxyhk
 EFwda8w85ojluqAvi5Q==
X-Authority-Analysis: v=2.4 cv=edYwvrEH c=1 sm=1 tr=0 ts=699cd3be cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=AzVrm9-Iib0IivHGxGkA:9 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: kJuGW5iD7tG1-5lqjfKJ2ZURi63lO8E_
X-Proofpoint-ORIG-GUID: kJuGW5iD7tG1-5lqjfKJ2ZURi63lO8E_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_05,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 phishscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230195

On Tue, Feb 24, 2026 at 12:39:03AM +0530, Ekansh Gupta wrote:
> Introduce a basic UAPI for the QDA accelerator driver along with a
> DRM IOCTL handler to query DSP device identity. A new UAPI header
> include/uapi/drm/qda_accel.h defines DRM_QDA_QUERY, the corresponding
> DRM_IOCTL_QDA_QUERY command, and struct drm_qda_query, which contains
> a DSP name string.
> 
> On the kernel side, qda_ioctl_query() validates the per-file context,
> resolves the qda_dev instance from dev->dev_private, and copies the
> DSP name from qdev->dsp_name into the query structure. The new
> qda_ioctls[] table wires this IOCTL into the QDA DRM driver so
> userspace can call it through the standard DRM command interface.
> 
> This IOCTL provides a simple and stable way for userspace to discover
> which DSP a given QDA device node represents and serves as the first
> building block for a richer QDA UAPI in subsequent patches.
> 
> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> ---
>  drivers/accel/qda/Makefile    |  1 +
>  drivers/accel/qda/qda_drv.c   |  9 +++++++++
>  drivers/accel/qda/qda_ioctl.c | 45 +++++++++++++++++++++++++++++++++++++++++
>  drivers/accel/qda/qda_ioctl.h | 26 ++++++++++++++++++++++++
>  include/uapi/drm/qda_accel.h  | 47 +++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 128 insertions(+)
> 
> diff --git a/drivers/accel/qda/Makefile b/drivers/accel/qda/Makefile
> index 7e96ddc40a24..f547398e1a72 100644
> --- a/drivers/accel/qda/Makefile
> +++ b/drivers/accel/qda/Makefile
> @@ -10,5 +10,6 @@ qda-y := \
>  	qda_rpmsg.o \
>  	qda_cb.o \
>  	qda_memory_manager.o \
> +	qda_ioctl.o \

Keep the list sorted, please.

>  
>  obj-$(CONFIG_DRM_ACCEL_QDA_COMPUTE_BUS) += qda_compute_bus.o
> diff --git a/drivers/accel/qda/qda_drv.c b/drivers/accel/qda/qda_drv.c
> index bf95fc782cf8..86758a9cd982 100644
> --- a/drivers/accel/qda/qda_drv.c
> +++ b/drivers/accel/qda/qda_drv.c
> @@ -9,7 +9,10 @@
>  #include <drm/drm_file.h>
>  #include <drm/drm_gem.h>
>  #include <drm/drm_ioctl.h>
> +#include <drm/qda_accel.h>
> +
>  #include "qda_drv.h"
> +#include "qda_ioctl.h"
>  #include "qda_rpmsg.h"
>  
>  static struct qda_drm_priv *get_drm_priv_from_device(struct drm_device *dev)
> @@ -128,11 +131,17 @@ static void qda_postclose(struct drm_device *dev, struct drm_file *file)
>  
>  DEFINE_DRM_ACCEL_FOPS(qda_accel_fops);
>  
> +static const struct drm_ioctl_desc qda_ioctls[] = {
> +	DRM_IOCTL_DEF_DRV(QDA_QUERY, qda_ioctl_query, 0),
> +};
> +
>  static struct drm_driver qda_drm_driver = {
>  	.driver_features = DRIVER_COMPUTE_ACCEL,
>  	.fops			= &qda_accel_fops,
>  	.open			= qda_open,
>  	.postclose		= qda_postclose,
> +	.ioctls = qda_ioctls,

Please select one style. Either you indent all assignments or you don't.

> +	.num_ioctls = ARRAY_SIZE(qda_ioctls),
>  	.name = DRIVER_NAME,
>  	.desc = "Qualcomm DSP Accelerator Driver",
>  };
> diff --git a/drivers/accel/qda/qda_ioctl.c b/drivers/accel/qda/qda_ioctl.c
> new file mode 100644
> index 000000000000..9fa73ec2dfce
> --- /dev/null
> +++ b/drivers/accel/qda/qda_ioctl.c
> @@ -0,0 +1,45 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +// Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> +#include <drm/drm_ioctl.h>
> +#include <drm/drm_gem.h>
> +#include <drm/qda_accel.h>
> +#include "qda_drv.h"
> +#include "qda_ioctl.h"
> +
> +static int qda_validate_and_get_context(struct drm_device *dev, struct drm_file *file_priv,
> +					struct qda_dev **qdev, struct qda_user **qda_user)
> +{
> +	struct qda_drm_priv *drm_priv = dev->dev_private;
> +	struct qda_file_priv *qda_file_priv;
> +
> +	if (!drm_priv)
> +		return -EINVAL;
> +
> +	*qdev = drm_priv->qdev;
> +	if (!*qdev)
> +		return -EINVAL;

Can this actually happen or is it (un)wishful thinking?

> +
> +	qda_file_priv = (struct qda_file_priv *)file_priv->driver_priv;
> +	if (!qda_file_priv || !qda_file_priv->qda_user)
> +		return -EINVAL;

What are you protecting against?

> +
> +	*qda_user = qda_file_priv->qda_user;
> +
> +	return 0;
> +}
> +
> +int qda_ioctl_query(struct drm_device *dev, void *data, struct drm_file *file_priv)
> +{
> +	struct qda_dev *qdev;
> +	struct qda_user *qda_user;
> +	struct drm_qda_query *args = data;
> +	int ret;
> +
> +	ret = qda_validate_and_get_context(dev, file_priv, &qdev, &qda_user);
> +	if (ret)
> +		return ret;
> +
> +	strscpy(args->dsp_name, qdev->dsp_name, sizeof(args->dsp_name));
> +
> +	return 0;
> +}
> diff --git a/drivers/accel/qda/qda_ioctl.h b/drivers/accel/qda/qda_ioctl.h
> new file mode 100644
> index 000000000000..6bf3bcd28c0e
> --- /dev/null
> +++ b/drivers/accel/qda/qda_ioctl.h
> @@ -0,0 +1,26 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#ifndef _QDA_IOCTL_H
> +#define _QDA_IOCTL_H
> +
> +#include <linux/types.h>
> +#include <linux/kernel.h>
> +#include <drm/drm_ioctl.h>
> +#include "qda_drv.h"
> +
> +/**
> + * qda_ioctl_query - Query DSP device information and capabilities
> + * @dev: DRM device structure
> + * @data: User-space data containing query parameters and results
> + * @file_priv: DRM file private data
> + *
> + * This IOCTL handler queries information about the DSP device.
> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +int qda_ioctl_query(struct drm_device *dev, void *data, struct drm_file *file_priv);
> +
> +#endif /* _QDA_IOCTL_H */
> diff --git a/include/uapi/drm/qda_accel.h b/include/uapi/drm/qda_accel.h
> new file mode 100644
> index 000000000000..0aad791c4832
> --- /dev/null
> +++ b/include/uapi/drm/qda_accel.h
> @@ -0,0 +1,47 @@
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
> +#define DRM_QDA_QUERY	0x00
> +/*
> + * QDA IOCTL definitions
> + *
> + * These macros define the actual IOCTL numbers used by userspace applications.
> + * They combine the command numbers with DRM_COMMAND_BASE and specify the
> + * data structure and direction (read/write) for each IOCTL.
> + */
> +#define DRM_IOCTL_QDA_QUERY	DRM_IOR(DRM_COMMAND_BASE + DRM_QDA_QUERY, struct drm_qda_query)
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

-- 
With best wishes
Dmitry
