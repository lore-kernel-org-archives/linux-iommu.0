Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B3D4A262C
	for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 13:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792069607; cv=none; b=g6zaC7OoltYHcG2uTGY6YZ0WUF0MLIomj/En+f/sssWYAWhEGlYv1Xni6mff7uFol/7Rj51/5A3fqyP2MCbX0CPkF8det3oK7NxrnIjIN0LNFt25EKSaOXD50kKaPpngqJL+SZFsbJeuj9cvjUZ+4/aTRoE7MKpAFqagTnxEvLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792069607; c=relaxed/simple;
	bh=FgYjLtr7lTVOy3hpwD0+k8mP1nayW9MiiKQC/xlWnPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=idEBAVjwFP0AhPk530q3WpHCgCQbCfEQbRChOsZa1tzEJw3c6C+ak8/gZJoDJ4MO8ozpCJmwAOOLYaRMlK3vTa/3avtZqUS7ITHujOb13GxHYh3li/S5ejux5nII6nhPDumDGSwXRIeWM1zYx3MROW1Xr44nacfjjI9Af4nb568=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iVICmAu1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hmZ3jMol; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iVICmAu1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hmZ3jMol"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F9je8O1955639
	for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 13:06:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nUrRKow716VLDkdUtBEZdLpuUza6F3nodlWQImDHgE8=; b=iVICmAu1oWEE9d4y
	4Z7NDQdxANtuzADVuyeyyMY0KPy5nkDV/E0rDMZLSv2xKWCPSyeo5vYZCYFTeZo1
	1V3/gylNDFX9MJLxijPOVsZrxvM6pKK2Xb9dBCURhSOKrDbZ79Ih+EaiYRLINkpM
	rJPnD73nNu7SflcV/zMNvwrOSqA6Az/q5ZPORDnwJDJWCSnb5ucyWDf4vwRIq0xa
	GXSfWDnlK6Q+XJJXyMmw2BRkWray+HDnm2kVVpsit2QFTMSTwoYPmdT3oSyCzaEW
	fAFCUTjekoHYTuawJQZIQ8pU0KG+hy9nVDaunAbNQw98zQ9mITuR6+uh7wUx0dS8
	AxqkVA==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hakdeu104-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 13:06:43 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5e9b3a3b849so780154e0c.0
        for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 06:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792069603; x=1792674403; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nUrRKow716VLDkdUtBEZdLpuUza6F3nodlWQImDHgE8=;
        b=hmZ3jMolnf10BkkZm7sm2yrWWZMdiU6BqenCGuSrQ176f4S0i6zD60OH+fQoJHryFM
         M57HI+mPpPtxZrCJX7QL99Pg7s+oNYtcxnQ5LZ8qcGaMWDlb/De/ldl9WFYKmTTBCYr2
         KqeQd0emJoLpfzZoSU7lPCXc9GGa2ufKUtZJI3coaqSaLZyDriadxQb+gcAz5Q36ZwMC
         uD7e6pVtLvxq1sjWVeRU5nYvxa7Zcy8mFeotxFUiEMeLjGSA7YMoCb1zbfKCtSg/9pi4
         thWknNWzcQSmzCalJ15OaTX7OxRNAbHLtPl8B5W3Junic67EXZp31r50C3j1Q07TX0nd
         cbfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792069603; x=1792674403;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nUrRKow716VLDkdUtBEZdLpuUza6F3nodlWQImDHgE8=;
        b=ORCWTM55g9rVVbwCXrzKp+aQnyBAlg4qHvms6l5tMxFBcabEHD9Y5TqsfjRm7+1QCu
         7bqzoiocPzG00Ok2rivTzzSDzUdduXRJ4oyu1Uu01bYHnZ6wWvsegIQgpreHhHfrjoqj
         pPE4abh9R6SmRVYM05fUjkCIylnw1waJ7EKznvotW/5nSAIkMRt5Lh5tzvYFLC2t7Jbg
         Rdnd0LVJO3gxIUvEyKOwur9kGzdAzB2yzbTFaFqdz44s/3G/0JodA3kN1O9PyHhiltvg
         5J88lm8d6eAseUacT79fgNAsf4ZAtxE9JjwBJ28VywUeK+XwE0lsC3jgXi8uMVk9egyB
         aclQ==
X-Forwarded-Encrypted: i=1; AKwUvBxIV47p9k294/3pmlQYASBDm1ySEOzaD4eivR0Y4vCVl0TIsQHgbxXaqxj7nf6i2Q6TIgm+gg==@lists.linux.dev
X-Gm-Message-State: AFq9FYLRL5TKPUA7Db7I3b20nM+Ctc3eqNmqMiberXGhgxRsLqWhix88
	eALe+RMVAYAxftxZSWLBTs6goqzNIfk6vPcyNpxp5Rlt0s/4JNCdenOoXSjSB+GdrEtNgXwJDI7
	dnI0tEqqRl1b/vMVIn8Jm3StKMsKASnlUg/HFMdu+DrQtCB5fFe46IDLdPQ==
X-Gm-Gg: AYBFou0BxlJyV2nRHN+8tLbx7S2fp8ZRpL6F7AGhrX+6GuHDtzUcee9pqJ5IVrLPUxb
	+tuI7jfq+/OHym8WvbbLOdWuw6DgKJL4WpL4iv75OKMXA5brUvozEQUd52kkj5QcWgzdH40022n
	2dvk9q/xRXX8b8x7ofKZ3u9cjwzVqeIO/UqRcZqivoH/AcayJIwBzGMX3QUw4IpwwnKqYYGxzLI
	IPlKI9H2QHEN0kIkRyq5RrV3UCccCmVC+my4Akf7djxZlkPjqtVTbIdl8OrfcKxJBBVZyX6BagT
	aJz2f7sMOfayj+3NRC2h2lUkYbxbT8WdNXZ4PWjKEyS3ZYyk+v8UJegrpDFWvC2mCZSx3jqyLZZ
	g9RKEd+fUIZe/PXPPanlYFyg4VxeAH9ztiT9uni971xW9MOcSgye3rV8GhB2xRrj64MjfhKZgrX
	g3YWnKdclIRawa
X-Received: by 2002:a05:6122:180c:b0:5ea:8f37:3063 with SMTP id 71dfb90a1353d-5ea8f37349dmr372367e0c.17.1792069602964;
        Thu, 15 Oct 2026 06:06:42 -0700 (PDT)
X-Received: by 2002:a05:6122:180c:b0:5ea:8f37:3063 with SMTP id 71dfb90a1353d-5ea8f37349dmr372301e0c.17.1792069602282;
        Thu, 15 Oct 2026 06:06:42 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5be420bbbf0sm225187e87.79.2026.10.15.06.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 06:06:40 -0700 (PDT)
Date: Thu, 15 Oct 2026 16:06:38 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Philipp Stanner <phasta@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        iommu@lists.linux.dev
Subject: Re: [PATCH 10/13] drm/msm/dcp: Add VirtIO transport and platform
 driver
Message-ID: <gegmh2qb7odywjesxlvrm6knjjwsx6g2xfif2s6wq5zn7y33q4@gpdwz2ajlm4i>
References: <20261015-jshekhar-drm-msm-dcp-v1-v1-0-48aad0fe4f72@oss.qualcomm.com>
 <20261015-jshekhar-drm-msm-dcp-v1-v1-10-48aad0fe4f72@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261015-jshekhar-drm-msm-dcp-v1-v1-10-48aad0fe4f72@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=OdENnRTY c=1 sm=1 tr=0 ts=6ad0cfe3 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=8UvxyRjR-zxYBsYGV0wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-ORIG-GUID: Y-ZyHucc_Dc64tFuWYPRePpkISMW1v3n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA1MiBTYWx0ZWRfX7joJc5XzlrB2
 0Xo5VTyhYOvWsGX6u1iLWkoALxYjrgHcOfUSBohlJVtJ1oOt8GuU4b2fI0cf422ZxMq60mJ6mZH
 dlLMdEdnAsSiicKVrU9VQn66JirmpHDw/QnK8M4FRs7aLOtFtjoiRvhXVJcUpPj6PHi6GEVwoaP
 unhWYW95x6TpKohBMWV0jtplBFvbQuuTicWtlYKJ8omszgpXAvpbEOiQeYI3+gTit1FnEZXlsaH
 b+APU2W02O8VMnYfZE2vKMgjjhRp1uWd7lF1hYSmHHO5h7fac/o8TUDuKaYTBQXIviuk7PByOax
 QYRaIkEYZqCzEUTGLVNYBBgoh9fiHx7ZthBuvmgYymlImoUHK8IuIHK2cjm5TDHfGunvoz7kZZ0
 i7Jy9rWMkiY0YtKe853XNH0pB/qS4p06qBVblYrksCyoPy2aIEEDQiNVI07Kuav/q9s2Co9dJMV
 QtsHBUCxu3pCa8+Tpmg==
X-Proofpoint-GUID: Y-ZyHucc_Dc64tFuWYPRePpkISMW1v3n
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA1MiBTYWx0ZWRfX9FHZGPxo1UFt
 cIRP3yP/rpjKCUXxcUkknkIlYuojQIGXzu/fqAGevYpRug8J39b0FDt2PDjalr/EVkLyrWFvcJ3
 MUeWE7rwQki5TPK4IxCyN/7xMgmUkcU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150052

On Thu, Oct 15, 2026 at 01:08:30PM +0530, Jayant Shekhar wrote:
> DCP display hardware is controlled by firmware and exposed to Linux as a
> VirtIO function. The MSM DRM driver needs a platform driver to establish
> the transport, DMA/IOMMU address spaces, power-notify path, and display
> component.
> 
> Add the VirtIO-MMIO transport and DCP platform-function driver. Set up the
> DMA/IOMMU identity, IPCC client, VirtIO queues, HFI transport, firmware
> capability handling, and MSM DRM registration. Synchronize suspend, resume,
> remove, and shutdown with in-flight HFI activity.
> 
> Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
> Assisted-by: LLM
> ---
>  drivers/gpu/drm/msm/Makefile         |   2 +
>  drivers/gpu/drm/msm/dcp/dcp_drv.c    | 245 ++++++++++++++++++++++++++++
>  drivers/gpu/drm/msm/dcp/dcp_drv.h    |  19 +++
>  drivers/gpu/drm/msm/dcp/dcp_virtio.c | 302 +++++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/msm/dcp/dcp_virtio.h |  22 +++
>  5 files changed, 590 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
> index 9910bd4f306d..e57aee483137 100644
> --- a/drivers/gpu/drm/msm/Makefile
> +++ b/drivers/gpu/drm/msm/Makefile
> @@ -83,6 +83,8 @@ msm-display-$(CONFIG_DRM_MSM_DCP) += \
>  	dcp/dcp_ipcc.o \
>  	dcp/dcp_plane.o \
>  	dcp/dcp_encoder.o \
> +	dcp/dcp_drv.o \
> +	dcp/dcp_virtio.o \
>  	dcp/hfi/hfi_packer.o \
>  	dcp/hfi/hfi_unpacker.o \
>  	dcp/hfi/hfi_utils.o
> diff --git a/drivers/gpu/drm/msm/dcp/dcp_drv.c b/drivers/gpu/drm/msm/dcp/dcp_drv.c
> new file mode 100644
> index 000000000000..e7016937a028
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/dcp/dcp_drv.c
> @@ -0,0 +1,245 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + * DCP VirtIO driver.
> + */
> +
> +#include <linux/component.h>
> +#include <linux/device.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/panic_notifier.h>
> +#include <linux/pm_runtime.h>
> +
> +#define DCP_DPU_AUTOSUSPEND_DELAY_MS	5000
> +
> +#include "dcp_drv.h"
> +#include "dcp_hfi.h"
> +#include "dcp_ipcc.h"
> +#include "dcp_virtio.h"
> +#include "msm_drv.h"
> +#include "msm_kms.h"
> +
> +int dcp_subsystem_dev_init(struct dcp_drv *drv)
> +{
> +	struct virtio_device *vdev = drv->vdev;
> +	struct device_node *dcp_subsystem_node;
> +	struct platform_device *pdev;
> +	struct device *dev;
> +	char busid[32];
> +	int ret;
> +
> +	dcp_subsystem_node = of_get_child_by_name(vdev->dev.parent->of_node,
> +						  "dcp-subsystem");
> +	if (!dcp_subsystem_node) {
> +		dev_err(&vdev->dev, "no dcp-subsystem DT node\n");
> +		return -ENODEV;
> +	}
> +
> +	snprintf(busid, sizeof(busid), "dcp-subsystem.%s", dev_name(vdev->dev.parent));
> +
> +	/*
> +	 * DCP is discovered through VirtIO, but display/HFI buffers must be
> +	 * mapped through the dcp-subsystem node's DMA/IOMMU identity. Create a
> +	 * platform device for that DT node so DMA API and msm_kms_init_vm() use
> +	 * the display function's IOMMU domain.
> +	 */
> +	pdev = of_platform_device_create(dcp_subsystem_node, busid, vdev->dev.parent);
> +	if (!pdev) {
> +		dev_err(&vdev->dev, "dcp_subsystem_dev creation failed\n");
> +		of_node_put(dcp_subsystem_node);
> +		return -ENODEV;
> +	}
> +	dev = &pdev->dev;
> +
> +	dev->dma_parms = &drv->dcp_subsystem_dma_parms;
> +	dma_set_max_seg_size(dev, UINT_MAX);
> +
> +	ret = of_dma_configure_id(dev, dcp_subsystem_node, true, NULL);
> +	if (ret) {
> +		dev_err(dev, "of_dma_configure_id failed: %d\n", ret);
> +		goto err_destroy;
> +	}
> +
> +	if (!device_iommu_mapped(dev)) {
> +		dev_err(dev, "no IOMMU group attached\n");
> +		ret = -ENODEV;
> +		goto err_destroy;
> +	}
> +
> +	dev_dbg(dev, "dcp-subsystem: iommu_mapped=%d iommu_group=%d\n",
> +		device_iommu_mapped(dev),
> +		 dev->iommu_group ? iommu_group_id(dev->iommu_group) : -1);
> +
> +	pm_runtime_set_active(dev);
> +	pm_runtime_enable(dev);
> +	pm_runtime_set_autosuspend_delay(dev, DCP_DPU_AUTOSUSPEND_DELAY_MS);
> +	pm_runtime_use_autosuspend(dev);
> +
> +	drv->dcp_subsystem_dev = pdev;
> +	drv->dcp_subsystem_node = dcp_subsystem_node;
> +
> +	return 0;
> +
> +err_destroy:
> +	of_platform_device_destroy(dev, NULL);
> +	of_node_put(dcp_subsystem_node);
> +	return ret;
> +}
> +
> +void dcp_subsystem_dev_deinit(struct dcp_drv *drv)
> +{
> +	if (!drv->dcp_subsystem_dev)
> +		return;
> +
> +	pm_runtime_disable(&drv->dcp_subsystem_dev->dev);
> +	of_platform_device_destroy(&drv->dcp_subsystem_dev->dev, NULL);
> +	of_node_put(drv->dcp_subsystem_node);
> +	drv->dcp_subsystem_dev = NULL;
> +}
> +
> +int dcp_pm_prepare(struct device *vdev_dev)
> +{
> +	struct dcp_drv *drv = vdev_dev ? ((struct virtio_device *)
> +					  dev_to_virtio(vdev_dev))->priv : NULL;
> +
> +	if (!drv || !drv->dcp_subsystem_dev)
> +		return 0;
> +
> +	return msm_kms_pm_prepare(&drv->dcp_subsystem_dev->dev);
> +}
> +
> +void dcp_pm_complete(struct device *vdev_dev)
> +{
> +	struct dcp_drv *drv = vdev_dev ? ((struct virtio_device *)
> +					  dev_to_virtio(vdev_dev))->priv : NULL;
> +
> +	if (!drv || !drv->dcp_subsystem_dev)
> +		return;
> +
> +	msm_kms_pm_complete(&drv->dcp_subsystem_dev->dev);
> +}
> +
> +static int dcp_pm_ipcc_notify(struct dcp_drv *drv)
> +{
> +	int ret;
> +
> +	if (!drv->ipcc_valid)
> +		return 0;
> +
> +	ret = dcp_ipcc_send_power_notify(&drv->ipcc);

An indirection just for the sake of indirection? Can we drop one-line
wrappers?

> +	if (ret)
> +		dev_warn(&drv->vdev->dev,
> +			 "IPCC power notification failed during PM: %d\n", ret);
> +
> +	return ret;
> +}
> +
> +int dcp_pm_suspend(struct device *vdev_dev)
> +{
> +	struct dcp_drv *drv = vdev_dev ? ((struct virtio_device *)
> +					  dev_to_virtio(vdev_dev))->priv : NULL;
> +
> +	if (!drv || !drv->dcp_subsystem_dev)
> +		return 0;
> +
> +	return dcp_pm_ipcc_notify(drv);
> +}
> +
> +int dcp_pm_resume(struct device *vdev_dev)
> +{
> +	struct dcp_drv *drv = vdev_dev ? ((struct virtio_device *)
> +					  dev_to_virtio(vdev_dev))->priv : NULL;
> +
> +	if (!drv || !drv->dcp_subsystem_dev)
> +		return 0;
> +
> +	return dcp_pm_ipcc_notify(drv);
> +}
> +
> +static int dcp_self_bind(struct device *master, struct device *dev, void *data)
> +{
> +	return 0;
> +}
> +
> +static void dcp_self_unbind(struct device *master, struct device *dev,
> +			    void *data)
> +{
> +}
> +
> +static const struct component_ops dcp_self_ops = {
> +	.bind   = dcp_self_bind,
> +	.unbind = dcp_self_unbind,
> +};
> +
> +int dcp_component_register(struct dcp_drv *drv)
> +{
> +	struct device *dev = &drv->dcp_subsystem_dev->dev;
> +	struct component_match *match = NULL;
> +	int ret;
> +
> +	/*
> +	 * DCP has no host-visible display subcomponents: firmware owns the
> +	 * underlying display blocks. The self component is only the minimal shim
> +	 * needed to enter the existing MSM DRM component-master init path without
> +	 * adding a DCP-specific entry point to common MSM DRM code.
> +	 */

And how does that work with the DSI probing sequences? The panel driver
might be not (yet) available when you probe the DCP. The driver should
register the DSI host, create DSI devices, but the DRM device
registration is only possible when the panel / bridge has attached to
the DSI host. See how it's handled by the mdp4/mdp5/dpu drivers.

> +	ret = component_add(dev, &dcp_self_ops);
> +	if (ret) {
> +		dev_err(dev, "component_add failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	component_match_add(dev, &match, component_compare_dev, dev);

Missing optional GPU match. I think I wrote that before...

> +
> +	ret = component_master_add_with_match(dev, &msm_drm_ops, match);
> +	if (ret) {
> +		dev_err(dev, "component_master_add_with_match failed: %d\n",
> +			ret);
> +		component_del(dev, &dcp_self_ops);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +void dcp_component_unregister(struct dcp_drv *drv)
> +{
> +	struct device *dev = &drv->dcp_subsystem_dev->dev;
> +
> +	component_master_del(dev, &msm_drm_ops);
> +	component_del(dev, &dcp_self_ops);
> +}
> +
> +static int dcp_panic_notifier_cb(struct notifier_block *nb,
> +				 unsigned long action, void *data)
> +{
> +	struct dcp_drv *drv = container_of(nb, struct dcp_drv, panic_notifier);
> +
> +	if (drv->hfi)
> +		atomic_set(&drv->hfi->shutdown_in_progress, 1);
> +
> +	return NOTIFY_OK;
> +}
> +
> +void dcp_panic_notifier_register(struct dcp_drv *drv)
> +{
> +	drv->panic_notifier.notifier_call = dcp_panic_notifier_cb;
> +	atomic_notifier_chain_register(&panic_notifier_list, &drv->panic_notifier);
> +}
> +
> +void dcp_panic_notifier_unregister(struct dcp_drv *drv)
> +{
> +	atomic_notifier_chain_unregister(&panic_notifier_list, &drv->panic_notifier);
> +}
> +
> +void __init msm_dcp_register(void)
> +{
> +	dcp_virtio_register();
> +}
> +
> +void __exit msm_dcp_unregister(void)
> +{
> +	dcp_virtio_unregister();
> +}
> diff --git a/drivers/gpu/drm/msm/dcp/dcp_drv.h b/drivers/gpu/drm/msm/dcp/dcp_drv.h
> index af2db3cf9066..ca8e5bd284e0 100644
> --- a/drivers/gpu/drm/msm/dcp/dcp_drv.h
> +++ b/drivers/gpu/drm/msm/dcp/dcp_drv.h
> @@ -26,6 +26,25 @@ struct dcp_drv {
>  	struct dcp_dpu_kms	*kms;
>  	struct dcp_caps		 caps;
>  	struct notifier_block	 panic_notifier;
> +	struct dcp_ipcc		 ipcc;
> +	bool			 ipcc_valid;
>  };
>  
> +int dcp_subsystem_dev_init(struct dcp_drv *drv);
> +void dcp_subsystem_dev_deinit(struct dcp_drv *drv);
> +
> +int dcp_component_register(struct dcp_drv *drv);
> +void dcp_component_unregister(struct dcp_drv *drv);
> +
> +int dcp_pm_prepare(struct device *vdev_dev);
> +void dcp_pm_complete(struct device *vdev_dev);
> +int dcp_pm_suspend(struct device *vdev_dev);
> +int dcp_pm_resume(struct device *vdev_dev);
> +
> +void dcp_panic_notifier_register(struct dcp_drv *drv);
> +void dcp_panic_notifier_unregister(struct dcp_drv *drv);
> +
> +void __init msm_dcp_register(void);
> +void __exit msm_dcp_unregister(void);
> +
>  #endif /* __DCP_DRV_H__ */
> diff --git a/drivers/gpu/drm/msm/dcp/dcp_virtio.c b/drivers/gpu/drm/msm/dcp/dcp_virtio.c
> new file mode 100644
> index 000000000000..b2aeb03688c9
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/dcp/dcp_virtio.c
> @@ -0,0 +1,302 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + * DCP VirtIO device driver.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/err.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/virtio.h>
> +#include <linux/virtio_config.h>
> +#include <linux/scatterlist.h>
> +#include <linux/slab.h>
> +
> +#include "dcp_drv.h"
> +#include "dcp_dpu_kms.h"
> +#include "dcp_hfi.h"
> +#include "dcp_ipcc.h"
> +#include "dcp_virtio.h"
> +#include "msm_drv.h"
> +#include "msm_kms.h"
> +
> +static void dcp_virtio_hfi_cleanup(struct dcp_drv *drv);
> +
> +static const unsigned int dcp_virtio_features[] = {
> +	VIRTIO_F_VERSION_1,
> +	VIRTIO_F_NOTIFICATION_DATA,
> +	VIRTIO_F_RING_RESET,
> +	VIRTIO_F_ACCESS_PLATFORM,
> +};
> +
> +/*
> + * The VirtIO core owns transport discovery. This driver owns HFI setup and
> + * creates the DRM component only after firmware capabilities are available.
> + */
> +static int dcp_virtio_probe(struct virtio_device *vdev)
> +{
> +	struct dcp_drv *drv;
> +	struct virtqueue *vqs[DCP_NUM_VQS];
> +	struct virtqueue_info vqs_info[DCP_NUM_VQS] = {
> +		[DCP_VQ_CMD]  = { .name = "cmd",  .callback = dcp_hfi_cmd_callback },
> +		[DCP_VQ_RESP] = { .name = "resp", .callback = dcp_hfi_resp_callback },
> +	};
> +	struct dcp_dpu_kms *dpu_kms;
> +	struct msm_drm_private *priv;
> +	int ret;
> +
> +	dev_dbg(&vdev->dev, "DCP VirtIO probe started\n");
> +
> +	drv = devm_kzalloc(&vdev->dev, sizeof(*drv), GFP_KERNEL);
> +	if (!drv)
> +		return -ENOMEM;
> +
> +	drv->vdev = vdev;
> +	vdev->priv = drv;
> +
> +	if (!virtio_has_feature(vdev, VIRTIO_F_VERSION_1)) {
> +		dev_err(&vdev->dev, "VIRTIO_F_VERSION_1 not negotiated\n");
> +		return -ENODEV;
> +	}
> +	/* Access-platform is required for the firmware-visible IOVA mappings. */
> +	if (!virtio_has_feature(vdev, VIRTIO_F_ACCESS_PLATFORM)) {
> +		dev_err(&vdev->dev, "VIRTIO_F_ACCESS_PLATFORM not negotiated\n");
> +		return -ENODEV;
> +	}
> +
> +	ret = dcp_subsystem_dev_init(drv);
> +	if (ret)
> +		return ret;
> +
> +	ret = dcp_ipcc_init(&drv->ipcc, vdev->dev.parent);
> +	if (ret) {
> +		if (ret == -EPROBE_DEFER)
> +			dev_err_probe(&vdev->dev, ret,
> +				      "IPCC not ready, deferring probe\n");
> +		else
> +			dev_err(&vdev->dev, "IPCC init failed: %d\n", ret);
> +		goto err_fn_dev;
> +	}
> +	drv->ipcc_valid = !!drv->ipcc.power_chan;
> +
> +	ret = virtio_find_vqs(vdev, DCP_NUM_VQS, vqs, vqs_info, NULL);
> +	if (ret) {
> +		dev_err(&vdev->dev, "virtqueue allocation failed: %d\n", ret);
> +		goto err_ipcc;
> +	}
> +
> +	ret = dcp_hfi_init(drv, vdev, vqs[DCP_VQ_CMD], vqs[DCP_VQ_RESP],
> +			   vdev->dev.parent);
> +	if (ret) {
> +		dev_err(&vdev->dev, "HFI init failed: %d\n", ret);
> +		goto err_del_vqs;
> +	}
> +
> +	if (drv->ipcc_valid)
> +		dcp_ipcc_set_resp_vq(&drv->ipcc, vqs[DCP_VQ_RESP]);
> +
> +	/*
> +	 * Keep the device unready until HFI state and virtqueues are initialized.
> +	 * KMS registration below depends on synchronous firmware initialization.
> +	 */
> +	virtio_device_ready(vdev);
> +	virtqueue_kick(drv->hfi->resp_vq);
> +
> +	ret = dcp_hfi_send_device_init(drv->hfi);
> +	if (ret) {
> +		dev_err(&vdev->dev, "HFI DEVICE_INIT failed: %d\n", ret);
> +		goto err_hfi_deinit;
> +	}
> +
> +	ret = dcp_hfi_get_capabilities(drv->hfi, &drv->caps);
> +	if (ret) {
> +		dev_err(&vdev->dev, "HFI GET_CAPS failed: %d\n", ret);
> +		goto err_hfi_deinit;
> +	}
> +
> +	/* Register the display resources before exposing the DRM component. */
> +	ret = dcp_hfi_send_resource_register(drv->hfi);
> +	if (ret) {
> +		dev_err(&vdev->dev, "HFI RESOURCE_REGISTER failed: %d\n", ret);
> +		goto err_hfi_deinit;
> +	}
> +
> +	dev_dbg(&vdev->dev,
> +		"DCP caps: %u displays, max %ux%u, %u planes, features=0x%x\n",
> +		 drv->caps.num_crtcs, drv->caps.max_width, drv->caps.max_height,
> +		 drv->caps.max_planes, drv->caps.features);
> +
> +	dpu_kms = devm_kzalloc(&drv->dcp_subsystem_dev->dev, sizeof(*dpu_kms), GFP_KERNEL);
> +	if (!dpu_kms) {
> +		ret = -ENOMEM;
> +		goto err_hfi_deinit;
> +	}
> +
> +	dpu_kms->drv       = drv;
> +	dpu_kms->pm_dev    = &drv->dcp_subsystem_dev->dev;
> +	dpu_kms->hfi       = drv->hfi;
> +	dpu_kms->caps      = &drv->caps;
> +	dpu_kms->dpus_np   = drv->dcp_subsystem_node;
> +	dpu_kms->iommu_dev = &drv->dcp_subsystem_dev->dev;
> +
> +	ret = msm_kms_init(&dpu_kms->base, &dcp_dpu_kms_funcs);
> +	if (ret) {
> +		dev_err(&vdev->dev, "msm_kms_init failed: %d\n", ret);
> +		goto err_hfi_deinit;
> +	}
> +
> +	priv = devm_kzalloc(&drv->dcp_subsystem_dev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv) {
> +		ret = -ENOMEM;
> +		goto err_hfi_deinit;
> +	}
> +
> +	priv->kms      = &dpu_kms->base;
> +	priv->kms_init = dcp_kms_init;
> +	dev_set_drvdata(&drv->dcp_subsystem_dev->dev, priv);
> +	dpu_kms->rpm_enabled = true;
> +
> +	/* Component binding now sees initialized HFI, capabilities, and IOMMU state. */
> +	ret = dcp_component_register(drv);
> +	if (ret) {
> +		dev_err(&vdev->dev, "component register failed: %d\n", ret);
> +		goto err_hfi_deinit;
> +	}
> +
> +	dcp_panic_notifier_register(drv);
> +
> +	dev_dbg(&vdev->dev, "DCP VirtIO probe complete\n");
> +	return 0;
> +
> +err_hfi_deinit:
> +	dcp_virtio_hfi_cleanup(drv);
> +	goto err_ipcc;
> +err_del_vqs:
> +	virtio_reset_device(vdev);
> +	vdev->config->del_vqs(vdev);
> +err_ipcc:
> +	if (drv->ipcc_valid) {
> +		dcp_ipcc_deinit(&drv->ipcc);
> +		drv->ipcc_valid = false;
> +	}
> +err_fn_dev:
> +	dcp_subsystem_dev_deinit(drv);
> +	return ret;
> +}
> +
> +static void dcp_virtio_hfi_cleanup(struct dcp_drv *drv)
> +{
> +	struct virtio_device *vdev = drv->vdev;
> +
> +	if (!drv->hfi)
> +		return;
> +
> +	dcp_hfi_stop(drv->hfi);
> +	virtio_reset_device(vdev);
> +	virtio_synchronize_cbs(vdev);
> +	vdev->priv = NULL;
> +	dcp_hfi_quiesce_queues(drv->hfi);
> +	vdev->config->del_vqs(vdev);
> +	dcp_hfi_deinit(drv->hfi);
> +	drv->hfi = NULL;

What's the point of setting pointers to NULL? Won't this memory be
kfree()'d soon?

> +}
> +
> +/*
> + * Remove DRM users before tearing down HFI, IPCC, or the VirtIO queues.
> + */
> +static void dcp_virtio_remove(struct virtio_device *vdev)
> +{
> +	struct dcp_drv *drv = vdev->priv;
> +
> +	dev_dbg(&vdev->dev, "DCP VirtIO remove\n");
> +
> +	if (!drv)
> +		return;
> +
> +	dcp_component_unregister(drv);
> +	dcp_panic_notifier_unregister(drv);
> +
> +	dcp_virtio_hfi_cleanup(drv);
> +
> +	if (drv->ipcc_valid) {
> +		dcp_ipcc_deinit(&drv->ipcc);
> +		drv->ipcc_valid = false;
> +	}
> +
> +	dcp_subsystem_dev_deinit(drv);
> +}
> +
> +/* KMS shutdown must complete while the firmware transport is available. */
> +static void dcp_virtio_shutdown(struct virtio_device *vdev)
> +{
> +	struct dcp_drv *drv = vdev->priv;
> +
> +	if (!drv || !drv->dcp_subsystem_dev)
> +		return;
> +
> +	pm_runtime_get_sync(&drv->dcp_subsystem_dev->dev);
> +	msm_kms_shutdown(drv->dcp_subsystem_dev);
> +	pm_runtime_put_noidle(&drv->dcp_subsystem_dev->dev);
> +}
> +
> +/*
> + * Firmware capabilities may change independently of the VirtIO transport;
> + * refresh them without rebuilding the DRM device.

And what does that mean? How can they change?

> + */
> +static void dcp_virtio_config_changed(struct virtio_device *vdev)
> +{
> +	struct dcp_drv *drv = vdev->priv;
> +	int ret;
> +
> +	dev_dbg(&vdev->dev, "VirtIO config changed — re-querying DCP capabilities\n");
> +
> +	if (!drv || !drv->hfi)
> +		return;
> +
> +	ret = dcp_hfi_get_capabilities(drv->hfi, &drv->caps);
> +	if (ret)
> +		dev_err(&vdev->dev,
> +			"config_changed: capability re-query failed: %d\n", ret);
> +	else
> +		dev_dbg(&vdev->dev,
> +			"config_changed: DCP caps updated: %u displays, features=0x%x\n",
> +			 drv->caps.num_crtcs, drv->caps.features);
> +}
> +

[...]

> diff --git a/drivers/gpu/drm/msm/dcp/dcp_virtio.h b/drivers/gpu/drm/msm/dcp/dcp_virtio.h
> new file mode 100644
> index 000000000000..fe244bc5b51a
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/dcp/dcp_virtio.h
> @@ -0,0 +1,22 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + * DCP VirtIO driver interface.
> + */
> +
> +#ifndef __DCP_VIRTIO_H__
> +#define __DCP_VIRTIO_H__
> +
> +#include <linux/device.h>
> +#include <linux/virtio.h>
> +#include <linux/virtio_ids.h>
> +
> +struct dcp_drv;
> +
> +#define VIRTIO_ID_QPSFI		                52
> +#define VIRTIO_VENDOR_ID_DCP_HFI		    1

I think this was questioned by Bjorn. Is it described somewhere? Is it a
part of the VirtIO spec? If so, add these ids to the VirtIO headers. If
not... then it's squatting. We can't just randomly settle on the ID.

> +
> +int dcp_virtio_register(void);
> +void dcp_virtio_unregister(void);
> +
> +#endif /* __DCP_VIRTIO_H__ */
> 
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry
