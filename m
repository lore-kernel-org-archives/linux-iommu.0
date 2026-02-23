Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB49378D74
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 22:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771885008; cv=none; b=mxPgtnKOcZ3RLYqmztTuJAwnkNRFb3gfh16v5eEXiaZlQau+m//3zGhQiwy1pbO/Q2dGMldylPk40YQh6FGrSFgDAuljpuLzgCy/T3pA82dKrdhxyL81Qu76i9msjEZ5rp4+a7dmI0e2LaosPSausXAh+67jO0TDy8pJe6w+3rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771885008; c=relaxed/simple;
	bh=a0/cmVtRZ98vLBBm8zUIs6Z5aLpkKikYYYf94CmUDXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VoXsY7uxdBemfqGOVnO/lkKxZeij1FIS2InTPZxhbATM/485SFnPcn4B+jz7P5HiRMtsbk5vnJKieKMhk6R1l+DL+x+q22ok4pcMCwMSzGSnm4BWB+Rtbidb4fla2YO/VEPcvFnxoqGvJn2bm9sF9rK0EEcr+tsj5XjqYzj1iww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jqnUO0Vn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HSWAvm7T; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jqnUO0Vn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HSWAvm7T"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NDsZsT185772
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 22:16:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=7va14BLOKUzsh75bZFAJzVRf
	4H4OIi1hkRGWKQdCG8M=; b=jqnUO0VnxouOlpzyWXInGXYr5DzwjgLFsroPbF5L
	Y0uoJUmnyV5M2ebDEF9jFaAzcqGMmDXMi2Ohsu20iMPwfpDmIdUTMOFAAgDKtBQt
	v/ts8dQ60FWd1poWlN+DFr+gn3yGafMurNmYJIw92t7RCQH285CcZgQv5cez/sT8
	VWnJ85O2ICGQg4ZkIKgufVgnrINPgeBw3GU9yWrUuMHZ/JJlCxlQyWwen6wjJ66E
	eQ7M9Md1c7UA5Rph+FUvX7GTWrN00BKrospt32O2f2oD5UQ3RZaM+5hbAwg3nyIJ
	/j3XInLOdijzH51ateYwHoXJQmd0zI1kbwm+bRoSxuI0Gg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cgr69hftj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 22:16:44 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-896fa0fcf27so627072226d6.1
        for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 14:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771885004; x=1772489804; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7va14BLOKUzsh75bZFAJzVRf4H4OIi1hkRGWKQdCG8M=;
        b=HSWAvm7TCRqaPDCGOcF+J6yh1/BCUdQHSqSg7SJHPFgymuP5aK/vX1J/U7USzDDSd5
         n3MCmDcEcHFgO1+K7SOGfwU1woXcESjP6/czARjedNfgnD7bQVKDfuWl2tYFp9GlE9Ol
         s0mO26oUDvqD6S1KPoMLvwyskjXIXjT4xK0CqHkK/IiURsngzwzHpVqAYl2vZyMugZ5B
         zbPQRY/t+fmTtXKaFvH9dgoui4Ro0lRkJNzKzS81oT6X5UtdlCVn0h1hoyfrIDZJNZ9X
         m3uFAViMAf6PtdqlDWGjOeTfBbdM1BuQ1tHQ7ok4iWKbLTUlbjM7GOsIiOIEsSciON9f
         n1GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771885004; x=1772489804;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7va14BLOKUzsh75bZFAJzVRf4H4OIi1hkRGWKQdCG8M=;
        b=su9avasRNtQU00580gaD8XgOJm4Z4I5zY+qS4sqW0voxrSJThdaFNYi01Q9g+CiJh7
         VsPDt7C3sv4qqcDa8Ts3D2HNcU8MiOBsEXqv7cSQw0SJibhbxOOICqSNSe+SX9gP9ytF
         dX9VLTk+U7oKd/4zew8+7G2YgLjY5dtKtfwqkmT3HzjVlVhKXSQYi7mOFLfgMCOPloPB
         dblUjVln0Q/+0ZeZ3BA34SnqVShEDlmBvLfVad6a6JSEVLRyhn4EBr2uTC8pEz1ESufE
         9YgeVWI8M6Ehk69Xo9CEgr0bFBsmtd148ELRKkkiieD9jhOL9AvAYWPUpaVarL3ZLyYc
         VFSg==
X-Forwarded-Encrypted: i=1; AJvYcCUuBfqFKzretrTRc2hy/qrU9G7FmWnk9PDW/Iki8OGxcv8a1MfhANZQ6AJCj5R09xn/0k+ZWw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwQG0uxtl0SHfoNp1f6KsWM/hurZyeuN6pOXI+tK0DfqpOneMXV
	QVb3d+E7yIGQpKAEl8Tx+QLs7DBhmTg69cYekhE9IR5sy5KMQaQphl8trB12ivgPDzRhKWAWvIi
	yhGx8YGGSyNxc/WnQLQ8ZYlEM0vJyqDPJyVc//m1OMtsZLLOyQRSA709qaA==
X-Gm-Gg: AZuq6aK5aMEWR3YVsUEHY15HYxQfiBfDnUsEmgdj3YCzwinlz6khHZUVgcQ8hn0KllE
	XJl4q0Qs9aV/bNWTxH00GpTKsWnwR4oD2N6uCgJ7ZCwEVb27GjaaYAx3OcKbd9V7JlyBMwkCFEx
	SavZjKK51YYbNfbPJ0SkWHfrBbubZ45yUsb7fzrI/bPV9l+1e7rahZE2kgAI7D6V62cC9K/MIwm
	0GRs3U8p2f3XLum+kNkTKSnDssBq8qca6lHkTrVsGrciG+Tq20Pe5SUdCxMWVzrv39tqRl420So
	uIYZAuFS37f5UaWzcNQd/3Cl0hDZQy6/eplRgrBeJhJo9azkyRGWPz32YnlCfR3VW7ep3OOfLZh
	4WC4uAadV3z8l1M9HVan98dME6DfUrphiSTeYkn0a8xUfpwuH2PfrVsIQnzEvR7Vh89TT+ttF8p
	FG0r6J6SIVVRocL0iNoiI6mgNKrymzDLXpCMg=
X-Received: by 2002:a05:620a:4482:b0:8c6:f414:3ba8 with SMTP id af79cd13be357-8cb8ca65b37mr1186747085a.49.1771885003354;
        Mon, 23 Feb 2026 14:16:43 -0800 (PST)
X-Received: by 2002:a05:620a:4482:b0:8c6:f414:3ba8 with SMTP id af79cd13be357-8cb8ca65b37mr1186742585a.49.1771885002701;
        Mon, 23 Feb 2026 14:16:42 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a0eeb3eaa4sm1837408e87.46.2026.02.23.14.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 14:16:41 -0800 (PST)
Date: Tue, 24 Feb 2026 00:16:40 +0200
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
Subject: Re: [PATCH RFC 07/18] accel/qda: Add DRM accel device registration
 for QDA driver
Message-ID: <jjj5b2says6y2sk4lokcxslzcwlsg3gj7rme34lqmhufqc7eam@x256mqlsuvet>
References: <20260224-qda-firstpost-v1-0-fe46a9c1a046@oss.qualcomm.com>
 <20260224-qda-firstpost-v1-7-fe46a9c1a046@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224-qda-firstpost-v1-7-fe46a9c1a046@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=O6A0fR9W c=1 sm=1 tr=0 ts=699cd1cc cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=2N0wBCc5_LywspELBZUA:9 a=CjuIK1q_8ugA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: Erob3kreNAGJK6HQbJzWMNy_rR0OLsJq
X-Proofpoint-GUID: Erob3kreNAGJK6HQbJzWMNy_rR0OLsJq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDE5NCBTYWx0ZWRfX3VH37d48Q04x
 bSAkdfYP5tnmcowSZwpl1dCAIt2cRv/i9Xh7CjDFTtKDnwcxDz84qbdSe1AkyPC5af7zpUTW74v
 VxI7lFjZBpKBjjpF5aqrHI3BX+Kh/Fu/rfPtMagxGl5O+PZ9q7bIjskmxjLUjze2EfAdPTPr69y
 X3wtlidtfJJJhztxntOKUmctia0RDyD2zmX/crqxEZMczG4BFg161xZ202Q050S0DEY8J9/4mar
 N/89n6//PmquZH8pzre0T/80vAQIWZSMJqdU5mkByaE1jqFqLKm+8fvFnwTybyUSOb2MDHgA3xg
 BEVLF1WRksDFouxzzbvwOaop63XjBRb95duXamHoMQn3k1wp/FZZA/6tT8r6fs941YBNZ31Q8S/
 MOZoBBpEzbgwzp8SWTVIbl11DVCAITE72uvynDZZBsg04n94a2+ZdlmaTCKqgFmgLApFKMVI20D
 l4SBKmmsU+ZchYs6ovg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_05,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230194

On Tue, Feb 24, 2026 at 12:39:01AM +0530, Ekansh Gupta wrote:
> Add DRM accel integration for the QDA DSP accelerator driver. A new
> qda_drm_priv structure is introduced to hold per-device DRM state,
> including a pointer to the memory manager and the parent qda_dev
> instance. The driver now allocates a drm_device, initializes
> driver-private state, and registers the device via the DRM accel
> infrastructure.
> 
> qda_register_device() performs allocation and registration of the DRM
> device, while qda_unregister_device() handles device teardown and
> releases references using drm_dev_unregister() and drm_dev_put().
> Initialization and teardown paths are updated so DRM resources are
> allocated after IOMMU/memory-manager setup and cleaned during RPMsg
> remove.
> 
> This patch lays the foundation for adding GEM buffer support and IOCTL
> handling in later patches as part of the compute accelerator interface.
> 
> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> ---
>  drivers/accel/qda/qda_drv.c   | 103 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/accel/qda/qda_drv.h   |  33 +++++++++++++-
>  drivers/accel/qda/qda_rpmsg.c |   8 ++++
>  3 files changed, 142 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/accel/qda/qda_drv.c b/drivers/accel/qda/qda_drv.c
> index 69132737f964..a9113ec78fa2 100644
> --- a/drivers/accel/qda/qda_drv.c
> +++ b/drivers/accel/qda/qda_drv.c
> @@ -4,9 +4,31 @@
>  #include <linux/kernel.h>
>  #include <linux/atomic.h>
>  #include <linux/slab.h>
> +#include <drm/drm_accel.h>
> +#include <drm/drm_drv.h>
> +#include <drm/drm_file.h>
> +#include <drm/drm_gem.h>
> +#include <drm/drm_ioctl.h>
>  #include "qda_drv.h"
>  #include "qda_rpmsg.h"
>  
> +DEFINE_DRM_ACCEL_FOPS(qda_accel_fops);
> +
> +static struct drm_driver qda_drm_driver = {
> +	.driver_features = DRIVER_COMPUTE_ACCEL,
> +	.fops			= &qda_accel_fops,

Strange indentation in the middle. Please drop it.

> +	.name = DRIVER_NAME,
> +	.desc = "Qualcomm DSP Accelerator Driver",
> +};
> +
> +static void cleanup_drm_private(struct qda_dev *qdev)
> +{
> +	if (qdev->drm_priv) {
> +		qda_dbg(qdev, "Cleaning up DRM private data\n");
> +		kfree(qdev->drm_priv);
> +	}
> +}
> +
>  static void cleanup_iommu_manager(struct qda_dev *qdev)
>  {
>  	if (qdev->iommu_mgr) {
> @@ -24,6 +46,7 @@ static void cleanup_device_resources(struct qda_dev *qdev)
>  
>  void qda_deinit_device(struct qda_dev *qdev)
>  {
> +	cleanup_drm_private(qdev);
>  	cleanup_iommu_manager(qdev);
>  	cleanup_device_resources(qdev);
>  }
> @@ -59,6 +82,18 @@ static int init_memory_manager(struct qda_dev *qdev)
>  	return 0;
>  }
>  
> +static int init_drm_private(struct qda_dev *qdev)
> +{
> +	qda_dbg(qdev, "Initializing DRM private data\n");
> +
> +	qdev->drm_priv = kzalloc_obj(*qdev->drm_priv, GFP_KERNEL);
> +	if (!qdev->drm_priv)
> +		return -ENOMEM;
> +
> +	qda_dbg(qdev, "DRM private data initialized successfully\n");
> +	return 0;
> +}
> +
>  int qda_init_device(struct qda_dev *qdev)
>  {
>  	int ret;
> @@ -71,14 +106,82 @@ int qda_init_device(struct qda_dev *qdev)
>  		goto err_cleanup_resources;
>  	}
>  
> +	ret = init_drm_private(qdev);
> +	if (ret) {
> +		qda_err(qdev, "DRM private data initialization failed: %d\n", ret);
> +		goto err_cleanup_iommu;
> +	}
> +
>  	qda_dbg(qdev, "QDA device initialized successfully\n");
>  	return 0;
>  
> +err_cleanup_iommu:
> +	cleanup_iommu_manager(qdev);
>  err_cleanup_resources:
>  	cleanup_device_resources(qdev);
>  	return ret;
>  }
>  
> +static int setup_and_register_drm_device(struct qda_dev *qdev)
> +{
> +	struct drm_device *ddev;
> +	int ret;
> +
> +	qda_dbg(qdev, "Setting up and registering DRM device\n");
> +
> +	ddev = drm_dev_alloc(&qda_drm_driver, qdev->dev);

devm_drm_dev_alloc() please. Move this patch to the front of the series,
making everything else depend on the allocated data structure.

> +	if (IS_ERR(ddev)) {
> +		ret = PTR_ERR(ddev);
> +		qda_err(qdev, "Failed to allocate DRM device: %d\n", ret);
> +		return ret;
> +	}
> +
> +	qdev->drm_priv->drm_dev = ddev;
> +	qdev->drm_priv->iommu_mgr = qdev->iommu_mgr;
> +	qdev->drm_priv->qdev = qdev;
> +
> +	ddev->dev_private = qdev->drm_priv;
> +	qdev->drm_dev = ddev;
> +
> +	ret = drm_dev_register(ddev, 0);
> +	if (ret) {
> +		qda_err(qdev, "Failed to register DRM device: %d\n", ret);
> +		drm_dev_put(ddev);
> +		return ret;
> +	}
> +
> +	qda_dbg(qdev, "DRM device registered successfully\n");
> +	return 0;
> +}
> +
> +int qda_register_device(struct qda_dev *qdev)
> +{
> +	int ret;
> +
> +	ret = setup_and_register_drm_device(qdev);
> +	if (ret) {
> +		qda_err(qdev, "DRM device setup failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	qda_dbg(qdev, "QDA device registered successfully\n");
> +	return 0;
> +}
> +
> +void qda_unregister_device(struct qda_dev *qdev)
> +{
> +	qda_info(qdev, "Unregistering QDA device\n");
> +
> +	if (qdev->drm_dev) {
> +		qda_dbg(qdev, "Unregistering DRM device\n");
> +		drm_dev_unregister(qdev->drm_dev);
> +		drm_dev_put(qdev->drm_dev);
> +		qdev->drm_dev = NULL;
> +	}
> +
> +	qda_dbg(qdev, "QDA device unregistered successfully\n");
> +}
> +
>  static int __init qda_core_init(void)
>  {
>  	int ret;
> diff --git a/drivers/accel/qda/qda_drv.h b/drivers/accel/qda/qda_drv.h
> index 2cb97e4eafbf..2b80401a3741 100644
> --- a/drivers/accel/qda/qda_drv.h
> +++ b/drivers/accel/qda/qda_drv.h
> @@ -11,13 +11,35 @@
>  #include <linux/mutex.h>
>  #include <linux/rpmsg.h>
>  #include <linux/xarray.h>
> +#include <drm/drm_drv.h>
> +#include <drm/drm_file.h>
> +#include <drm/drm_device.h>
> +#include <drm/drm_accel.h>
>  #include "qda_memory_manager.h"
>  
>  /* Driver identification */
>  #define DRIVER_NAME "qda"
>  
> +/**
> + * struct qda_drm_priv - DRM device private data for QDA device
> + *
> + * This structure serves as the DRM device private data (stored in dev_private),
> + * bridging the DRM device context with the QDA device and providing access to
> + * shared resources like the memory manager during buffer operations.
> + */
> +struct qda_drm_priv {

Shared between what and what? Why do you need a separate structure
instead of using qda_dev?

> +	/* DRM device structure */
> +	struct drm_device *drm_dev;
> +	/* Global memory/IOMMU manager */
> +	struct qda_memory_manager *iommu_mgr;
> +	/* Back-pointer to qda_dev */
> +	struct qda_dev *qdev;
> +};
> +
>  /* struct qda_dev - Main device structure for QDA driver */
>  struct qda_dev {
> +	/* DRM device for accelerator interface */
> +	struct drm_device *drm_dev;

Drop the pointer here.

>  	/* RPMsg device for communication with remote processor */
>  	struct rpmsg_device *rpdev;
>  	/* Underlying device structure */
> @@ -26,6 +48,8 @@ struct qda_dev {
>  	struct mutex lock;
>  	/* IOMMU/memory manager */
>  	struct qda_memory_manager *iommu_mgr;
> +	/* DRM device private data */
> +	struct qda_drm_priv *drm_priv;
>  	/* Flag indicating device removal in progress */
>  	atomic_t removing;
>  	/* Name of the DSP (e.g., "cdsp", "adsp") */
> @@ -39,8 +63,8 @@ struct qda_dev {
>   * @qdev: QDA device structure
>   *
>   * Returns the most appropriate device structure for logging messages.
> - * Prefers qdev->dev, or returns NULL if the device is being removed
> - * or invalid.
> + * Prefers qdev->dev, falls back to qdev->drm_dev->dev, or returns NULL
> + * if the device is being removed or invalid.
>   */
>  static inline struct device *qda_get_log_device(struct qda_dev *qdev)
>  {
> @@ -50,6 +74,9 @@ static inline struct device *qda_get_log_device(struct qda_dev *qdev)
>  	if (qdev->dev)
>  		return qdev->dev;
>  
> +	if (qdev->drm_dev)
> +		return qdev->drm_dev->dev;
> +
>  	return NULL;
>  }
>  
> @@ -93,5 +120,7 @@ static inline struct device *qda_get_log_device(struct qda_dev *qdev)
>   */
>  int qda_init_device(struct qda_dev *qdev);
>  void qda_deinit_device(struct qda_dev *qdev);
> +int qda_register_device(struct qda_dev *qdev);
> +void qda_unregister_device(struct qda_dev *qdev);
>  
>  #endif /* __QDA_DRV_H__ */
> diff --git a/drivers/accel/qda/qda_rpmsg.c b/drivers/accel/qda/qda_rpmsg.c
> index 5a57384de6a2..b2b44b4d3ca8 100644
> --- a/drivers/accel/qda/qda_rpmsg.c
> +++ b/drivers/accel/qda/qda_rpmsg.c
> @@ -80,6 +80,7 @@ static void qda_rpmsg_remove(struct rpmsg_device *rpdev)
>  	qdev->rpdev = NULL;
>  	mutex_unlock(&qdev->lock);
>  
> +	qda_unregister_device(qdev);
>  	qda_unpopulate_child_devices(qdev);
>  	qda_deinit_device(qdev);
>  
> @@ -123,6 +124,13 @@ static int qda_rpmsg_probe(struct rpmsg_device *rpdev)
>  		return ret;
>  	}
>  
> +	ret = qda_register_device(qdev);
> +	if (ret) {
> +		qda_deinit_device(qdev);
> +		qda_unpopulate_child_devices(qdev);
> +		return ret;
> +	}
> +
>  	qda_info(qdev, "QDA RPMsg probe completed successfully for %s\n", qdev->dsp_name);
>  	return 0;
>  }
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
