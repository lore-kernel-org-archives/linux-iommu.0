Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFEB3EA961
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 14:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779287223; cv=none; b=LOw7XaNBUy4n3D5pkl1AFHLHCGIH8MTH9EbYg0Ye5cYaq7q7R9NUMAFMUQS3KSX4xMtXoBnRRgbaj8khO7Xz1/MkwMhC/ABcXpv+R2UlhJTJUQ6su9B2CkLCsAKdKv5z0jZqDy8EAnbbJXm+E2FRQYASUBT139h4S+Bq3xVmVFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779287223; c=relaxed/simple;
	bh=7Fb6Kp1p4YOXa1aH0+dExY2guUhnXJEbIbCjPr/eSkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0+TpUskBMU+rAhqHztU3NhBgEcYbFYKsM7gQKe+F1xAgUyBdKyy5bJ6zyOmmMvLxMauT5sNj3670sy9TgcA8nk/RKkNWrgB2fOwwrXg6YVVnKbutAfl0X/jFAcrlYEEvDhWH1it2oLnc/dZOnCu2asGI7HKMhEvgJB0TFymx/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nH4BkxUo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BY1n6Gaz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nH4BkxUo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BY1n6Gaz"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64K9oLS21177853
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 14:27:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=UVWE9cDv8dNKqJnEWb+COja9
	5369BrxIeUqGSeAbb1c=; b=nH4BkxUogTtNIAEqilLYHObEFJgMG/D/I6AWiKcL
	gT9NyuhjEGPJjace/hLozjlYcZwbwfFRV91CP0BVqIhyrSuMqAPCIZbA8DN4DmFf
	hPCU2ZDE10kkQJphfYXUm2hHwGa0fgb01ylh3m5ByFd7fO3pbFGfwg78Ei/yjEPx
	bEy7uXL7yQ4/2MmkCCp9OZCLGZw87F4k1zqBS7hN6HbS4XmsbpRN3vEAxPERoMfh
	kyFhQpagYlYoilMeAjBUkXjdv1eabc16L2No76klbeHFWzEMgpHjLZS52rLeiT3E
	83xZGGdUeH7D6rq+10rqZtA2QQj2bvO/QF2MgSdMzvgCqA==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9ap6s004-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 14:27:00 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-575346e50c4so7009187e0c.2
        for <iommu@lists.linux.dev>; Wed, 20 May 2026 07:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779287219; x=1779892019; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UVWE9cDv8dNKqJnEWb+COja95369BrxIeUqGSeAbb1c=;
        b=BY1n6Gazv5H/v56qv4DV+LyHLfKU+YKWGMv4peyCtL91+5/MYtvXnKMbUtEqRdR87n
         CfznZXFARveSM09cODFeRSQv1xr3jSkrpvvWaN2DC1MamK2f1wQw2/bSnrgRF69lIeEN
         cGOrCKKJTQ3txPlRGHylqOL0g8Wlit77jDYPLehh/kIyar26NPKysmKpGqo6Rh/MFjkm
         3cdygzwEyisNPts/TJ5OxK/wW+ZunjBv2uje4lP2XR5AiQIp7RRlaXd9tlern6UaTZ9f
         DWUukLGI/jE5mJYX4wj9O2pSp03YWf5FxthRQDco39uxiK4OZ7qOM1kJ+5XRx6d9nTOu
         1G3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779287219; x=1779892019;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UVWE9cDv8dNKqJnEWb+COja95369BrxIeUqGSeAbb1c=;
        b=YVf9Rg6v9OMK6nQztcksgjlqT7kmS65MBZl90znHIY9CmIbnMHVzHLGLDPVesIUV1F
         aiajmGw7L/mqVEmyYXnjZT10D8m9pZBG1ZfJmPGcbwHmiGnl0l1c7DBNWrj6aZcG2N3F
         c4B/f4a/SoYogUiOt25U0qIRD3qILM2aPy4q9WapeyogxJp476pwTCHeXE1GNscBRwta
         kkP9XS9mrJ60ZGDwSY/ZJ+m17jLHUaq9nqCO+XBcH5q4FVd0H+1qUfrNFsTuvYKtXZUA
         sGA0zwf0HSoFQfrHJckRp5dot3/e/8cVuV2yE4IkpmEImcQuoaKBWrT8PQiz/yzBRYdu
         VoQg==
X-Forwarded-Encrypted: i=1; AFNElJ9Nyn01jvwdDru5W+VhNHXNKl5klqQs0ESucb3lwH/g4ALdNA2rV8tJU0Z+ZHrfcVaxbd3w+w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyPaX0ey0X2N7Cr5naOaJm6Roki8OiHGX9xHctxJz/xc4H+wvEC
	hEsKxKEld1p+h8+YiO3uR10GuPsN7j4GNqK8r829fXZxslM3IJRrTuMtIu2g5mR7+NnUiUmtjUD
	UN+WmVRYgCaoZNQxlswPXdBW8aomzFAZIYWrPNjvj0lfr1iPSUnG377Qhew==
X-Gm-Gg: Acq92OGKg1OvJ3xXmJn/su9iWBQFJn6p/o2D7iTsJuhBfBabOUpB2VfOnMjF2ISzXkp
	3nvwfLhXLK5OExN26WxRrKTXNqAhDFn37UOlzmDFhfDSsxClb1h7y3h2xLvscI7EE7IzAsg8n8p
	elh0+1EwPRKqVHGGejTWqyFBOQfK8hmgrNFQ1gxxHIr/aYnE23wWjCchk94JcugzREuLzsT2Uok
	19o54B2H8iYkTaaWwc0qzvvJbpnL04oPeSj6CjWLA3EjxcP5WAkzlTuzmqprI6XmKdUHlCFNlLH
	EuFjWzRz4Wf3oLA6Zd+AOLte5E3WCsDZNFoHyaf7u5LI4G6hZS9ODwevWEIBR0JuGik1DovkJlT
	sePMaPqNyDpPpaoYrM8abiR2iBpbb0oHabS3FwOTV1pnEypg5kpiokqjGA5xpc5dKfYx9Fk7Iv+
	Mf6meeoVm3zgq+Q07hrzFShpHM/9PBB7v6ofs=
X-Received: by 2002:a05:6122:4d0d:b0:56e:e80c:bb25 with SMTP id 71dfb90a1353d-5760c0a673cmr14617927e0c.13.1779287219198;
        Wed, 20 May 2026 07:26:59 -0700 (PDT)
X-Received: by 2002:a05:6122:4d0d:b0:56e:e80c:bb25 with SMTP id 71dfb90a1353d-5760c0a673cmr14617821e0c.13.1779287218313;
        Wed, 20 May 2026 07:26:58 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a9164c5a28sm4950743e87.61.2026.05.20.07.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 07:26:57 -0700 (PDT)
Date: Wed, 20 May 2026 17:26:55 +0300
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
Subject: Re: [PATCH 07/15] accel/qda: Add memory manager for CB devices
Message-ID: <sbktzorprxvo5625zkqwjgsaj723xtbsgzyypbnbgdbbxdgnnh@do5rprsx4oxr>
References: <20260519-qda-series-v1-0-b2d984c297f8@oss.qualcomm.com>
 <20260519-qda-series-v1-7-b2d984c297f8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519-qda-series-v1-7-b2d984c297f8@oss.qualcomm.com>
X-Proofpoint-GUID: R1xFF52WOwfrFbFrESRjVNyTALXN5Cz8
X-Proofpoint-ORIG-GUID: R1xFF52WOwfrFbFrESRjVNyTALXN5Cz8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE0MSBTYWx0ZWRfX4DYqpsz7q3LQ
 JFCaV4DnPswUpxJaPqdhgIydpBoU/kAIteEkSL6Slpen2jR5mmiyc6xjHcEzWRqUppiFoZ1SLHD
 b6r0IBOJ7O+vha5HY5W3pBB7Hq5hZRFj5vtYd4Hb4EPzs/UKolDJHc4d42O1F8pEPHqT231xDyI
 4ScDLF7aXHiTsZRtwSK/mR7KkUi8xnu5Ia/NLcALGq3GvvuNq6uC1jG70e8fHuOKiom0sqMOX9Y
 GIN48KdiHftzHFKBNqIvje1Dv1BrN3nGKMZU2a2+l0foVYvxARgbtU78DPtPcohoEKr3qP+3IaP
 nPl0I9eWyltfvwGwcZkxHmKqLAhjGzRagfiKz1YQlqO+xiIrQMQzYyz9PE6G/xcg9bzwY1+KuUE
 2M24dOwbntMhAezD16rOLc+Y2juOewvq3kCBS+zoUHlVydG45aWsKFkrc5dTOx/FaJJM9eKuLRg
 9trA0rxz0KaTV1nvUxw==
X-Authority-Analysis: v=2.4 cv=FesHAp+6 c=1 sm=1 tr=0 ts=6a0dc4b4 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=U7MGAyCTa2LO6tN26UQA:9 a=CjuIK1q_8ugA:10 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200141

On Tue, May 19, 2026 at 11:45:57AM +0530, Ekansh Gupta via B4 Relay wrote:
> From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> 
> Introduce the QDA memory manager (qda_memory_manager) to track and
> manage the IOMMU devices that back each compute context bank (CB).
> 
> Each CB device registered on the qda-compute-cb bus is assigned a
> unique ID via an XArray and wrapped in a qda_iommu_device descriptor

Why do you need an XArray? The number of devices is (more or less)
fixed. You can use a normal array, allocated in the probe function after
counting OF children nodes.

> that records the device pointer and its stream ID. This registry
> allows the driver to look up the correct IOMMU domain for a given
> session when mapping DSP buffers.
> 
> The memory manager is initialised in qda_init_device() before CB
> devices are populated and torn down in qda_deinit_device() after they
> are destroyed, ensuring no dangling references remain in the XArray.
> 
> qda_cb.c is extended with qda_cb_setup_device(), which is called
> immediately after a CB device is registered on the bus. It allocates
> a qda_iommu_device, registers it with the memory manager, and stores
> it as the CB device's driver data so that qda_destroy_cb_device() can
> retrieve and unregister it during teardown.
> 
> Assisted-by: Claude:claude-4-6-sonnet
> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> ---
>  drivers/accel/qda/Makefile             |   1 +
>  drivers/accel/qda/qda_cb.c             |  47 ++++++++++++++
>  drivers/accel/qda/qda_drv.c            |  34 ++++++++++
>  drivers/accel/qda/qda_drv.h            |   5 ++
>  drivers/accel/qda/qda_memory_manager.c | 111 +++++++++++++++++++++++++++++++++
>  drivers/accel/qda/qda_memory_manager.h |  49 +++++++++++++++
>  drivers/accel/qda/qda_rpmsg.c          |   7 +++
>  7 files changed, 254 insertions(+)
> 
> diff --git a/drivers/accel/qda/Makefile b/drivers/accel/qda/Makefile
> index 143c9e4e789e..701fad5ffb50 100644
> --- a/drivers/accel/qda/Makefile
> +++ b/drivers/accel/qda/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_DRM_ACCEL_QDA)	:= qda.o
>  qda-y := \
>  	qda_cb.o \
>  	qda_drv.o \
> +	qda_memory_manager.o \
>  	qda_rpmsg.o
>  
>  obj-$(CONFIG_DRM_ACCEL_QDA_COMPUTE_BUS) += qda_compute_bus.o
> diff --git a/drivers/accel/qda/qda_cb.c b/drivers/accel/qda/qda_cb.c
> index 77caf8438c67..6d540bb0ec7b 100644
> --- a/drivers/accel/qda/qda_cb.c
> +++ b/drivers/accel/qda/qda_cb.c
> @@ -8,11 +8,42 @@
>  #include <linux/slab.h>
>  #include <drm/drm_print.h>
>  #include "qda_drv.h"
> +#include "qda_memory_manager.h"
>  #include "qda_cb.h"
>  
> +static int qda_cb_setup_device(struct qda_dev *qdev, struct device *cb_dev, u32 sid)
> +{
> +	struct qda_iommu_device *iommu_dev;
> +	int rc;
> +
> +	drm_dbg_driver(&qdev->drm_dev, "Setting up CB device %s\n", dev_name(cb_dev));
> +
> +	iommu_dev = kzalloc_obj(*iommu_dev);
> +	if (!iommu_dev)
> +		return -ENOMEM;
> +
> +	iommu_dev->dev = cb_dev;
> +	iommu_dev->qdev = qdev;
> +	iommu_dev->sid = sid;
> +
> +	rc = qda_memory_manager_register_device(qdev->iommu_mgr, iommu_dev);
> +	if (rc) {
> +		drm_err(&qdev->drm_dev, "Failed to register IOMMU device: %d\n", rc);
> +		kfree(iommu_dev);
> +		return rc;
> +	}
> +
> +	dev_set_drvdata(cb_dev, iommu_dev);
> +
> +	drm_dbg_driver(&qdev->drm_dev, "CB device setup complete - SID: %u\n", sid);
> +
> +	return 0;
> +}
> +
>  int qda_create_cb_device(struct qda_dev *qdev, struct device_node *cb_node)
>  {
>  	struct device *cb_dev;
> +	int ret;
>  	u32 sid = 0;
>  	char name[64];
>  	struct qda_cb_dev *entry;
> @@ -30,6 +61,13 @@ int qda_create_cb_device(struct qda_dev *qdev, struct device_node *cb_node)
>  		return PTR_ERR(cb_dev);
>  	}
>  
> +	ret = qda_cb_setup_device(qdev, cb_dev, sid);
> +	if (ret) {
> +		drm_err(&qdev->drm_dev, "CB device setup failed: %d\n", ret);
> +		device_unregister(cb_dev);
> +		return ret;
> +	}
> +
>  	entry = kzalloc_obj(*entry);
>  	if (!entry) {
>  		device_unregister(cb_dev);
> @@ -80,6 +118,7 @@ int qda_cb_populate(struct qda_dev *qdev, struct device_node *parent_node)
>  void qda_destroy_cb_device(struct device *cb_dev)
>  {
>  	struct iommu_group *group;
> +	struct qda_iommu_device *iommu_dev;
>  
>  	if (!cb_dev) {
>  		pr_debug("qda: NULL CB device passed to destroy\n");
> @@ -88,6 +127,14 @@ void qda_destroy_cb_device(struct device *cb_dev)
>  
>  	dev_dbg(cb_dev, "Destroying CB device %s\n", dev_name(cb_dev));
>  
> +	iommu_dev = dev_get_drvdata(cb_dev);
> +	if (iommu_dev && iommu_dev->qdev && iommu_dev->qdev->iommu_mgr) {
> +		dev_dbg(cb_dev, "Unregistering IOMMU device for %s\n",
> +			dev_name(cb_dev));
> +		qda_memory_manager_unregister_device(iommu_dev->qdev->iommu_mgr,
> +						     iommu_dev);
> +	}
> +
>  	group = iommu_group_get(cb_dev);
>  	if (group) {
>  		dev_dbg(cb_dev, "Removing %s from IOMMU group\n", dev_name(cb_dev));
> diff --git a/drivers/accel/qda/qda_drv.c b/drivers/accel/qda/qda_drv.c
> index 6c20d6a2fc47..0ad5d9873d7e 100644
> --- a/drivers/accel/qda/qda_drv.c
> +++ b/drivers/accel/qda/qda_drv.c
> @@ -57,6 +57,40 @@ struct qda_dev *qda_alloc_device(struct device *dev)
>  	return qdev;
>  }
>  
> +static void cleanup_memory_manager(struct qda_dev *qdev)

Prefixes...

> +{
> +	if (qdev->iommu_mgr) {
> +		qda_memory_manager_exit(qdev->iommu_mgr);
> +		kfree(qdev->iommu_mgr);
> +		qdev->iommu_mgr = NULL;
> +	}
> +}
> +
> +static int init_memory_manager(struct qda_dev *qdev)
> +{
> +	qdev->iommu_mgr = kzalloc_obj(*qdev->iommu_mgr);
> +	if (!qdev->iommu_mgr)
> +		return -ENOMEM;
> +
> +	return qda_memory_manager_init(qdev->iommu_mgr);
> +}
> +
> +void qda_deinit_device(struct qda_dev *qdev)
> +{
> +	cleanup_memory_manager(qdev);

Ugh, inline all your one-line wrappers.

> +}
> +
> +int qda_init_device(struct qda_dev *qdev)
> +{
> +	int ret;
> +
> +	ret = init_memory_manager(qdev);
> +	if (ret)
> +		drm_err(&qdev->drm_dev, "Failed to initialize memory manager: %d\n", ret);
> +
> +	return ret;
> +}
> +
>  void qda_unregister_device(struct qda_dev *qdev)
>  {
>  	drm_dev_unregister(&qdev->drm_dev);
> diff --git a/drivers/accel/qda/qda_drv.h b/drivers/accel/qda/qda_drv.h
> index 2715f378775d..eb089e586b17 100644
> --- a/drivers/accel/qda/qda_drv.h
> +++ b/drivers/accel/qda/qda_drv.h
> @@ -13,6 +13,7 @@
>  #include <drm/drm_device.h>
>  #include <drm/drm_drv.h>
>  #include <drm/drm_file.h>
> +#include "qda_memory_manager.h"
>  
>  /* Driver identification */
>  #define QDA_DRIVER_NAME "qda"
> @@ -40,6 +41,8 @@ struct qda_dev {
>  	struct device *dev;
>  	/** @cb_devs: Compute context-bank (CB) child devices */
>  	struct list_head cb_devs;
> +	/** @iommu_mgr: IOMMU/memory manager instance */
> +	struct qda_memory_manager *iommu_mgr;
>  	/** @dsp_name: Name of the DSP domain (e.g. "cdsp", "adsp") */
>  	const char *dsp_name;
>  };
> @@ -59,6 +62,8 @@ static inline struct qda_dev *qda_dev_from_drm(struct drm_device *dev)
>  struct qda_dev *qda_alloc_device(struct device *dev);
>  
>  /* Core device lifecycle */
> +int qda_init_device(struct qda_dev *qdev);
> +void qda_deinit_device(struct qda_dev *qdev);
>  int qda_register_device(struct qda_dev *qdev);
>  void qda_unregister_device(struct qda_dev *qdev);
>  
> diff --git a/drivers/accel/qda/qda_memory_manager.c b/drivers/accel/qda/qda_memory_manager.c
> new file mode 100644
> index 000000000000..00a9c0ae4224
> --- /dev/null
> +++ b/drivers/accel/qda/qda_memory_manager.c
> @@ -0,0 +1,111 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +// Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> +
> +#include <linux/refcount.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/xarray.h>
> +#include <drm/drm_file.h>
> +#include "qda_drv.h"
> +#include "qda_memory_manager.h"
> +
> +static void cleanup_all_memory_devices(struct qda_memory_manager *mem_mgr)
> +{
> +	unsigned long index;
> +	void *entry;
> +
> +	pr_debug("qda: Starting cleanup of all memory devices\n");

pr_debug is a third way to debug. Stop it, please.

> +
> +	xa_for_each(&mem_mgr->device_xa, index, entry) {
> +		struct qda_iommu_device *iommu_dev = entry;
> +
> +		pr_debug("qda: Cleaning up device id=%lu\n", index);
> +
> +		xa_erase(&mem_mgr->device_xa, index);
> +		kfree(iommu_dev);
> +	}
> +
> +	pr_debug("qda: Completed cleanup of all memory devices\n");
> +}
> +

-- 
With best wishes
Dmitry
