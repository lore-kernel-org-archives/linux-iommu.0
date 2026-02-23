Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A9F37A49D
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 22:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771886392; cv=none; b=biWq6J0PrPEmfI7TbBgRqOxZlNcIoYUviGqlSwOFYgh46F+RIFFli5MveRjaEcjR0b/LQFZy/sKG8l/BiRHN3+xiam2Py/cgGk5oPUTXv00agH7nJ6iI1/D7go+NuT+Xi+UaDmyWfVOF518z/ZD/PY4OVix2V34R6pZ0Sa0HU1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771886392; c=relaxed/simple;
	bh=weupwFoIWkaFS/BOYuMucpezIPPWMRGr1EVbfFr6I50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GfTDqC6GEOFLqZuzKysbIGd6ud4hW6xwMgesA2y3HNXWlwbMRlabwDIuac8ouc7kvIoa/clDMNLm9yy4dsKkq5N6DS3pmWxKsmwSNGuV9COHXZmA7ztcN8NzvXy12IhYXsdP+LFcX33W+h6lMG0rFw5HoCXvPnFPcJmvfUWmdQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kqvDym6x; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Gec9ialH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kqvDym6x";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Gec9ialH"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NIoCoT3409247
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 22:39:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=nUK32uPvxI2Vc2NAUq76VwMY
	c+Ah6Xyt+D23oW/zCfs=; b=kqvDym6xN5iYKhCrRoJnOe6QhUMEQmbDb5Q7Jt7G
	Nvp9xvYWF6ojiRHfKtEW3cbRLt/YsX0zowxZRSJBZnv1nqbeZuspdihEvi00mnu6
	Z9QkZNNmd/hUGeNWgthr0Qeahc7w9POljWOVqi5QDdmfcKREpryPqTyMqV6ifblK
	1BAE9zpA+zD8PNCTFr/vHaYa3QDy370T0uMnoLyMASd+AO0WM5X76QYcdJ9S2BM+
	U83C5vsR7m15pFs3KYJBntr/YxlhlApsKfA3KcniUk5kU/NfeAgQVCXCfWW/cfxw
	E9GfEazeVJ6kB4F1KY+H18iAQJ6Cj7nBeVSqTj6WjTzGRA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cgn8tt412-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 22:39:50 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c71156fe09so4092222285a.0
        for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 14:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771886390; x=1772491190; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nUK32uPvxI2Vc2NAUq76VwMYc+Ah6Xyt+D23oW/zCfs=;
        b=Gec9ialHRzKZ1rComio0tD9/tVTXQbcLqSTNvkoCNlJ3QmBSNNEe9KRjhjwh8J23jX
         j5Z7Y6njINnEw00pdKXR4VuVA02tjr1+LUnC/l6Pq9MCllurcuJRQlEqBjBgPlbBZzTy
         X/uP1srl/gQchLxFqojelM2ijh3G05Ep5pAA7kM67fkb1cwQISvCXihcBgtM7fcr7j4r
         fhzkS/XcmSPBOgafjZLR7yjgeZUbIzkkONU4xcMHxxhmw+QTjk4GxumHNtZu7J7zpPw6
         n/uccu0F8Y+QRf8woc37uNsKU07UzMmjQaWicaLGUnscJOKvNJT5p9Hm91xEydRyybg9
         9mpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771886390; x=1772491190;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nUK32uPvxI2Vc2NAUq76VwMYc+Ah6Xyt+D23oW/zCfs=;
        b=ekG/caBxeRhhVQzjIUTAgsQH3zwQXD8MnKvjZWWlEkj0N7+WXodJJyYfyUNTvmqpFi
         1IISz55bh0Ed4Ua8jpMVDx8tt0ajixVm88rGyxXlTsuB5nJ594aqWpu2cX9jJX9BoA5h
         Z4yfN+27CokQiotFFSq+N2r5/0ipxf6BVXYaZeF8g1pMSBfIfAtLb1zUlpA6AQxKdjmS
         ovPLxApJKQ/KJ+RfYv4j+smdaQ38Hw0hPjYz+e9YS2mtWlnPqhcAc9135mia+daOMcuE
         AT2gI62ljUft4mUOwqJoUJ1FJdte65MC4XjJsmV3E74oqvnjv73Q2+00+81ab0prf2o+
         CgdA==
X-Forwarded-Encrypted: i=1; AJvYcCW8F283eoudOVF9hhk59PO/tUVpzEZkYg+/DsjOXF7QOpcyvW4EmVADXoJ9Z7nqYtnIKvAIjw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwKhp4z2zFXf5VtFQeQJXbVAekOgCAps3+uhSrSb7x3zQIxTN5T
	OBKoQqYHCh3g6Z0Wi75/r7G2nDzJ+CP5yLtW6PCY8JsIgsGMjI2juMGs6SXNK94i+YH6DrciHFn
	K5f86EXUAeETz2qIrSWT0+GphoqlNi5Q6/bCHOWwP3HEjFxEziT3u62QqlA==
X-Gm-Gg: AZuq6aI3HDpNxUAYh4v7Sl3JOGwz5c44Y256/dtrxFAZbdOdEUbPbSE+wYjqlVdxiu+
	PY5jKdu38loq28S9o9gYjfjL9Grx5hnI8s2wVZrUzj1Dp85ZoBd6kv+aLWfk/n6hSi+kmb6IIKZ
	xlXvpUO6nM/lxomDvv+PZuyQicgHRxqeojFDNPKU3/L1foxNq30iOUs5B5e7yV3mEntbLzPChLT
	diVZ6DNytKLyIw6Bd6qpM6/BRd5LBHzxANNWyWCuYAETT/9/OJm80WS6j6vCC5cE+9Q2AI0RAWr
	YIgKeOccdfKIYhwU4KIU5Ckj90XuyptgihzroMJNrvagt1kwb3tx4i3FiP0XkJSpHtcRg8cTRYO
	2E3hLNX/Lmfx0YS0H7w+Ojkbs2JyjlbY32aPr2CNRLXWefUwNdlDb5E+KmbmkHlXGwKkaKiUmXi
	OjpcFYsQ/aaeaFUbAR5Z/A8wxyHMaAaLk8Lyg=
X-Received: by 2002:a05:620a:319a:b0:8cb:4c79:b44f with SMTP id af79cd13be357-8cb8ca72048mr1249894285a.51.1771886389558;
        Mon, 23 Feb 2026 14:39:49 -0800 (PST)
X-Received: by 2002:a05:620a:319a:b0:8cb:4c79:b44f with SMTP id af79cd13be357-8cb8ca72048mr1249890085a.51.1771886389013;
        Mon, 23 Feb 2026 14:39:49 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a0eeb13873sm1823833e87.22.2026.02.23.14.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 14:39:47 -0800 (PST)
Date: Tue, 24 Feb 2026 00:39:45 +0200
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
Subject: Re: [PATCH RFC 11/18] accel/qda: Add GEM_CREATE and GEM_MMAP_OFFSET
 IOCTLs
Message-ID: <mkrwav44qxt66ojxvs2mh5jsjqirrm4sk653uglha3cjefevk6@fobon6vj7fhr>
References: <20260224-qda-firstpost-v1-0-fe46a9c1a046@oss.qualcomm.com>
 <20260224-qda-firstpost-v1-11-fe46a9c1a046@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224-qda-firstpost-v1-11-fe46a9c1a046@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=X7Jf6WTe c=1 sm=1 tr=0 ts=699cd736 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=03G4QXms81HB9-bpn8QA:9 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: PXNc8bh00WfDQnUdlSy2nW1mnbmtByOX
X-Proofpoint-GUID: PXNc8bh00WfDQnUdlSy2nW1mnbmtByOX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDE5NyBTYWx0ZWRfX3GwkDyo2AJV8
 RWtBjDPEnoiDtpA91ErQDGtbCiIxUiXc6T/OUYZssR0ff3ch6POgDPdafmb4SxD0d7apwDHtZ5E
 Kk86LHq77LlHE4b7qByTTuGGks4mhsm9eQuQsjeXD25vMCfdX2pRjax3fwf4C0g+a8eRpdA9XvC
 nuQ9TOvm+/CCFJGkYYZWybRUaldllWsUtJa+IZldWUF8ZUTl80hN9hiC5n6rt7URu+r2xeDdTl3
 OfdgOXYb/gG3W+UVq/k2O+Ps+ptP3ZWlr8kR0591EsoXkLCuAemxOoE8L2DMbq5uUgtFrMFjGoB
 2nEGGC64Lj9/aMeN6lMJhkYDXaQCoIDwKN77LQzqazW62z8UOfx14FKNWbzctiBLowuPGOF7+QC
 pnTBzfiFdywSs4x8jDeYK5S6Qm2zvJ4ObHjlvJN/yBBoVEPKg0DbEA8GI6nXC8zfcNbZD/bNjdn
 /BgS9mxBPnAm4cJbJng==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_05,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 adultscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230197

On Tue, Feb 24, 2026 at 12:39:05AM +0530, Ekansh Gupta wrote:
> Add two GEM-related IOCTLs for the QDA accelerator driver and hook
> them into the DRM accel driver. DRM_IOCTL_QDA_GEM_CREATE allocates
> a DMA-backed GEM buffer object via qda_gem_create_object() and
> returns a GEM handle to userspace, while
> DRM_IOCTL_QDA_GEM_MMAP_OFFSET returns a valid mmap offset for a
> given GEM handle using drm_gem_create_mmap_offset() and the
> vma_node in the GEM object.
> 
> The QDA driver is updated to advertise DRIVER_GEM in its
> driver_features, and the new IOCTLs are wired through the QDA
> GEM and memory-manager backend. These IOCTLs allow userspace to
> allocate buffers and map them into its address space as a first
> step toward full compute buffer management and integration with
> DSP workloads.
> 
> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> ---
>  drivers/accel/qda/qda_drv.c   |  5 ++++-
>  drivers/accel/qda/qda_gem.h   | 30 ++++++++++++++++++++++++++++++
>  drivers/accel/qda/qda_ioctl.c | 35 +++++++++++++++++++++++++++++++++++
>  include/uapi/drm/qda_accel.h  | 36 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 105 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/accel/qda/qda_drv.c b/drivers/accel/qda/qda_drv.c
> index 19798359b14e..0dd0e2bb2c0f 100644
> --- a/drivers/accel/qda/qda_drv.c
> +++ b/drivers/accel/qda/qda_drv.c
> @@ -12,6 +12,7 @@
>  #include <drm/qda_accel.h>
>  
>  #include "qda_drv.h"
> +#include "qda_gem.h"
>  #include "qda_ioctl.h"
>  #include "qda_rpmsg.h"
>  
> @@ -154,10 +155,12 @@ DEFINE_DRM_ACCEL_FOPS(qda_accel_fops);
>  
>  static const struct drm_ioctl_desc qda_ioctls[] = {
>  	DRM_IOCTL_DEF_DRV(QDA_QUERY, qda_ioctl_query, 0),
> +	DRM_IOCTL_DEF_DRV(QDA_GEM_CREATE, qda_ioctl_gem_create, 0),
> +	DRM_IOCTL_DEF_DRV(QDA_GEM_MMAP_OFFSET, qda_ioctl_gem_mmap_offset, 0),
>  };
>  
>  static struct drm_driver qda_drm_driver = {
> -	.driver_features = DRIVER_COMPUTE_ACCEL,
> +	.driver_features = DRIVER_GEM | DRIVER_COMPUTE_ACCEL,
>  	.fops			= &qda_accel_fops,
>  	.open			= qda_open,
>  	.postclose		= qda_postclose,
> diff --git a/drivers/accel/qda/qda_gem.h b/drivers/accel/qda/qda_gem.h
> index caae9cda5363..cbd5d0a58fa4 100644
> --- a/drivers/accel/qda/qda_gem.h
> +++ b/drivers/accel/qda/qda_gem.h
> @@ -47,6 +47,36 @@ struct drm_gem_object *qda_gem_create_object(struct drm_device *drm_dev,
>  void qda_gem_free_object(struct drm_gem_object *gem_obj);
>  int qda_gem_mmap_obj(struct drm_gem_object *gem_obj, struct vm_area_struct *vma);
>  
> +/*
> + * GEM IOCTL handlers
> + */
> +
> +/**
> + * qda_ioctl_gem_create - Create a GEM buffer object
> + * @dev: DRM device structure
> + * @data: User-space data containing buffer creation parameters
> + * @file_priv: DRM file private data
> + *
> + * This IOCTL handler creates a new GEM buffer object with the specified
> + * size and returns a handle to the created buffer.
> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +int qda_ioctl_gem_create(struct drm_device *dev, void *data, struct drm_file *file_priv);
> +
> +/**
> + * qda_ioctl_gem_mmap_offset - Get mmap offset for a GEM buffer object
> + * @dev: DRM device structure
> + * @data: User-space data containing buffer handle and offset result
> + * @file_priv: DRM file private data
> + *
> + * This IOCTL handler retrieves the mmap offset for a GEM buffer object,
> + * which can be used to map the buffer into user-space memory.
> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +int qda_ioctl_gem_mmap_offset(struct drm_device *dev, void *data, struct drm_file *file_priv);
> +
>  /*
>   * Helper functions for GEM object allocation and cleanup
>   * These are used internally and by the PRIME import code
> diff --git a/drivers/accel/qda/qda_ioctl.c b/drivers/accel/qda/qda_ioctl.c
> index 9fa73ec2dfce..ef3c9c691cb7 100644
> --- a/drivers/accel/qda/qda_ioctl.c
> +++ b/drivers/accel/qda/qda_ioctl.c
> @@ -43,3 +43,38 @@ int qda_ioctl_query(struct drm_device *dev, void *data, struct drm_file *file_pr
>  
>  	return 0;
>  }
> +
> +int qda_ioctl_gem_create(struct drm_device *dev, void *data, struct drm_file *file_priv)
> +{
> +	struct drm_qda_gem_create *args = data;
> +	struct drm_gem_object *gem_obj;
> +	struct qda_drm_priv *drm_priv;
> +
> +	drm_priv = get_drm_priv_from_device(dev);
> +	if (!drm_priv || !drm_priv->iommu_mgr)
> +		return -EINVAL;
> +
> +	gem_obj = qda_gem_create_object(dev, drm_priv->iommu_mgr, args->size, file_priv);
> +	if (IS_ERR(gem_obj))
> +		return PTR_ERR(gem_obj);
> +
> +	return qda_gem_create_handle(file_priv, gem_obj, &args->handle);
> +}
> +
> +int qda_ioctl_gem_mmap_offset(struct drm_device *dev, void *data, struct drm_file *file_priv)
> +{
> +	struct drm_qda_gem_mmap_offset *args = data;
> +	struct drm_gem_object *gem_obj;
> +	int ret;
> +
> +	gem_obj = qda_gem_lookup_object(file_priv, args->handle);
> +	if (IS_ERR(gem_obj))
> +		return PTR_ERR(gem_obj);
> +
> +	ret = drm_gem_create_mmap_offset(gem_obj);
> +	if (ret == 0)
> +		args->offset = drm_vma_node_offset_addr(&gem_obj->vma_node);
> +
> +	drm_gem_object_put(gem_obj);
> +	return ret;
> +}
> diff --git a/include/uapi/drm/qda_accel.h b/include/uapi/drm/qda_accel.h
> index 0aad791c4832..ed24a7f5637e 100644
> --- a/include/uapi/drm/qda_accel.h
> +++ b/include/uapi/drm/qda_accel.h
> @@ -19,6 +19,8 @@ extern "C" {
>   * They are used with DRM_COMMAND_BASE to create the full IOCTL numbers.
>   */
>  #define DRM_QDA_QUERY	0x00
> +#define DRM_QDA_GEM_CREATE		0x01
> +#define DRM_QDA_GEM_MMAP_OFFSET	0x02
>  /*
>   * QDA IOCTL definitions
>   *
> @@ -27,6 +29,10 @@ extern "C" {
>   * data structure and direction (read/write) for each IOCTL.
>   */
>  #define DRM_IOCTL_QDA_QUERY	DRM_IOR(DRM_COMMAND_BASE + DRM_QDA_QUERY, struct drm_qda_query)
> +#define DRM_IOCTL_QDA_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_QDA_GEM_CREATE, \
> +						 struct drm_qda_gem_create)
> +#define DRM_IOCTL_QDA_GEM_MMAP_OFFSET	DRM_IOWR(DRM_COMMAND_BASE + DRM_QDA_GEM_MMAP_OFFSET, \
> +						 struct drm_qda_gem_mmap_offset)
>  
>  /**
>   * struct drm_qda_query - Device information query structure
> @@ -40,6 +46,36 @@ struct drm_qda_query {
>  	__u8 dsp_name[16];
>  };
>  
> +/**
> + * struct drm_qda_gem_create - GEM buffer object creation parameters
> + * @size: Size of the GEM object to create in bytes (input)
> + * @handle: Allocated GEM handle (output)
> + *
> + * This structure is used with DRM_IOCTL_QDA_GEM_CREATE to allocate
> + * a new GEM buffer object.
> + */
> +struct drm_qda_gem_create {
> +	__u32 handle;
> +	__u32 pad;
> +	__u64 size;

If you put size before handle, you would not need padding.

> +};
> +
> +/**
> + * struct drm_qda_gem_mmap_offset - GEM object mmap offset query
> + * @handle: GEM handle (input)
> + * @pad: Padding for 64-bit alignment
> + * @offset: mmap offset for the GEM object (output)
> + *
> + * This structure is used with DRM_IOCTL_QDA_GEM_MMAP_OFFSET to retrieve
> + * the mmap offset that can be used with mmap() to map the GEM object into
> + * user space.
> + */
> +struct drm_qda_gem_mmap_offset {
> +	__u32 handle;
> +	__u32 pad;
> +	__u64 offset;

I'm really not a fan of the pad field in the middle of the structure.

> +};
> +
>  #if defined(__cplusplus)
>  }
>  #endif
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
