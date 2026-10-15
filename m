Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980CD5221D2
	for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 12:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792068258; cv=none; b=nj/5BKLjS6QO2yJtM07hz6YggN4nbZEzrDjsMwfImiI+NNycPSa6kqPNWfqmsKou1JLne8yB2ilGIIJ6m4aNvexnwHXFqbBlaF+JUwON+VOBDclzXzqc322FQ0Mxm/zQm6IGC54NCReLZ+o6zbgYWGqO+IVNNXeHOHszzD5bXf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792068258; c=relaxed/simple;
	bh=S3MW9H3wgEOvPP0uhKYDeITR4aJO7iujGxWR+LezJgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mvqV/cnQUJ8nZ33PqRv3Zp28+iCnazhcrtzanHlHgLl6oaMvDNqGk1q0k0QIlp5SXqF4TDA22omoIkjLVHfW+rpiEpPDYgzfVoScSSRcVHP/nLTg47odKNvBx7sLP7QHbdc3Fo7WTvF/hgotP+wi0sVdFfD8bZ9R2ueqAv6ygUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O+Ke54Gg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DHKbPKrW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O+Ke54Gg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DHKbPKrW"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F9jash2966471
	for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 12:44:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=w8o5JafesiRvwaLb/g8OOXSj
	6qim+o/hrusYm3HaIh8=; b=O+Ke54GgUCNZs50ieolXqxwKWZv0GIbzUBWi/mRX
	qAr6Yc9v7NGxFfNxuj1qm+mf68ZVCtMHRN/GHTRMJQiIoKc8h1h84O3NW2NiiT2R
	wLdLcB8PSbHwQqJoTa3n00fLvxuYQ1WxSTJdTbHfVACOEMIJMfTL0kI8f+cId4Uu
	Ofom2YTbY9cCqIN666IL9KBx4fbze9wANQhw2i/msJHFhBaVbRBac+rszrbYC8Kj
	3pL7HzIWeJ9b4zWstuSD75Vu3okjf8sdEngWm5Dyc+K8H69jlyzuQpNzOU38trOO
	TUb4BmS1X2z8hfsvxeljav8v/3aQ/PKwsB4izHosZsRD6w==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hae4wv2j2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 12:44:16 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93e46c120dfso188090685a.1
        for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 05:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792068256; x=1792673056; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=w8o5JafesiRvwaLb/g8OOXSj6qim+o/hrusYm3HaIh8=;
        b=DHKbPKrWCPiV66sGqjYJ4dVwvgnDLSF9FCvGXpLpDVtz+Bbsl9V5dOxA0WjEbUOUQN
         lxuhHM2WbGQtA++IKG34IjyEH4MKRtN94A1/Xuq6HDQQmpBdBALKsjxa54xQLZ7x2rcd
         qTBUd+DkuXeykc4mfQLjrmuEWcfiYQi1ALrqocTabr8qWhLy538uTg+s1PUx/P/r5gwL
         A5eaqqJ85gS3zuPcjz9ZeLeeTrET+2gdSRAywYeoOF7qVlXyVWtJ1o5/gjvkPhv0ZZcc
         rOVBaKdFoilGQIE45Dj55kmKhzZGzEPLEcowQY9BDYf4O6UcYA2oX+cZWe7v4+IIkfFl
         vPHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792068256; x=1792673056;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w8o5JafesiRvwaLb/g8OOXSj6qim+o/hrusYm3HaIh8=;
        b=TX1Xvbj8usPkSisVsFmq3aSIzN9rpYVZiVi0NPBM2oCA0gUsNOyvWIeJh98gREdWzL
         Em+Ng5/Spjsp5RAk2zLhC1iHxYARIXgRfFYS1q8QUb5WnB8o8QPoqJI2eajgVtZE/FuX
         xjYc/dWaLhsTnRcamNEivw5kqOPCP8SzXOTLcB3q2EWfBpkiOl00bsFRff5wSiEpKN6g
         Ru/IaTETJMGg9ZYxRORd6BUXQxXWtyJsObyfz8dkTenodrM2xCyyyPM2xck4peYSoZwl
         NuDCNuqYjMuxPOns/pbi3L2x1Q8Mz1b8Ykxt4WHDTxd84yRkbEwjW3MZFSzU70xcm6Dg
         2ZQw==
X-Forwarded-Encrypted: i=1; AKwUvByrrctx6uv3H/iQ3GglnVCiXoZWZsjEQv4dpKxEaMFV2OBor1QzxZjYUZk4Yu6xwuznxgy2RQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYL0iKq9ECtEO0aOWWUEFydwc6AkzHYe+upjT/G2rb/kmx3ImMtm
	+LDGpirKbNHZPJh5BjIM0rvHeeLA8e7t4QtaLOPitoJDKQzNDazmmK6TU4/YzQBP+zWoKKsXOv2
	UJrNeiXHFrHSGTlPCa7ErE9HOmxQqCpZ9ZJcTftyQbwi9W1up/paE1Lj9uQ==
X-Gm-Gg: AYBFou17WRYozjlKjK0YkhSgN2Tki+SZYax3oiuUJbpKcMy+Uh7/AeY0xBwNN94OpAr
	opjJX7xxUZCOvr1M4rqbtggGd/fm0EbHpJsGWFyLXPowfNI4CmamNFho++0Pyn+1DbImOj5sxOE
	TRuIdw9/1Moq1AdJSIOIcS8n8pOX0iWtfUipmTCqzmCuCIdSQEVyaO9OfP/kRuHO17+nhPaPjG3
	Ftjp9iGqU/M/E5IpAHGFwGH8sTbjuJHDkol059lbPpLRCpb6mFV6G5DL/G9H+zs0+R+6nJJ+nv+
	etz2tm//LVXCHkIC5ieXD4vuHR3+IXlDol+vvKfAKK7DtB1hT5oX4H2h8sKgDFNo0eEj79BVpsy
	7XvvroQQkpwlf6RlDko1aPw9Qk4At6eAm60JfzrObUal0kpRt+RyFiBD4ctZmws/rIXECzFvpbO
	7sJzegm7TPB34W
X-Received: by 2002:a05:620a:4041:b0:937:675e:2903 with SMTP id af79cd13be357-93ebd212371mr3197367185a.14.1792068255543;
        Thu, 15 Oct 2026 05:44:15 -0700 (PDT)
X-Received: by 2002:a05:620a:4041:b0:937:675e:2903 with SMTP id af79cd13be357-93ebd212371mr3197362985a.14.1792068254905;
        Thu, 15 Oct 2026 05:44:14 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3aafdf2fa18sm5761271fa.36.2026.10.15.05.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 05:44:13 -0700 (PDT)
Date: Thu, 15 Oct 2026 15:44:12 +0300
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
Subject: Re: [PATCH 07/13] drm/msm/dcp: Add DCP encoder
Message-ID: <bmtabdrtxygyubfmxgvixn5r4rosu4tepopc2ro37heeqzwzgx@mu5wk2stm7yi>
References: <20261015-jshekhar-drm-msm-dcp-v1-v1-0-48aad0fe4f72@oss.qualcomm.com>
 <20261015-jshekhar-drm-msm-dcp-v1-v1-7-48aad0fe4f72@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015-jshekhar-drm-msm-dcp-v1-v1-7-48aad0fe4f72@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA1MCBTYWx0ZWRfXzd8NDxf4YQzy
 lsu0bjmuxHKhgR4tiWcgczaOqVB3hdfXY4XuGphTriTX/TdkskwF2d+EMstHBltoKyXT29zSl9i
 bwKvyn3cM8sNsB+MUAN1RKVya5cCHPo=
X-Proofpoint-ORIG-GUID: JnjHxSy4RGCrthi2-sr_YtSHT3t19qTx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA1MCBTYWx0ZWRfXw75sC2+V7fxF
 K+SkCUNCEMScGuIqg5HA9QnROGThjF9jTsic5vpkpnfd7I4qX/HHurqqwOFt29T95ZVr21eita7
 Jxr4j8iTC9q8yv91mCTKq1rqUDoKJTuNugO9BmMyKgm3ppBEQJiX3N7+6P9yHO4uP1hIHaM4se1
 bO29afDNoUSte1gU5j9VnDcasiZc3FBilR1cre+YQi9ulbAeLxAtvsRsd5Ydj0ptbbBEpzVe8xv
 sPtGHrrk6XilBbpF17nVdFPIPxrqm2O0+SBMcMFlQYVoPjPG1EaKyzcVPh5u02r+ZqCWpZq7dNS
 2YUfqpr7Wzp7SQpgXqGmvw+E8SVTBaK9xieRdKkrF6VLHjjv8e35AGuYRJlU7WXJKsZhkLfecNZ
 hQwSLT6KUG1jABNUNylElWT/qKwxugcypdIjAFpDWETU+wVBZrRJRh5yPUDBwAvcKHhF13LHlaa
 YbkflkdA/CYuNPIOUZQ==
X-Authority-Analysis: v=2.4 cv=E8BYNqdl c=1 sm=1 tr=0 ts=6ad0caa0 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=N3-jI2xQlndCWEcerb8A:9 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: JnjHxSy4RGCrthi2-sr_YtSHT3t19qTx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150050

On Thu, Oct 15, 2026 at 01:08:27PM +0530, Jayant Shekhar wrote:
> The DCP display pipeline needs a DRM encoder to connect a CRTC to its
> firmware-backed output bridge while reusing the existing MSM DRM object
> model.
> 
> Add the DCP encoder wrapper and keep encoder allocation and DRM object
> initialization independent from bridge and KMS registration.
> 
> Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
> Assisted-by: LLM
> ---
>  drivers/gpu/drm/msm/Makefile          |  1 +
>  drivers/gpu/drm/msm/dcp/dcp_encoder.c | 31 +++++++++++++++++++++++++++++++
>  drivers/gpu/drm/msm/dcp/dcp_encoder.h | 16 ++++++++++++++++
>  3 files changed, 48 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
> index b7c1a2e9a19e..e7d24be72113 100644
> --- a/drivers/gpu/drm/msm/Makefile
> +++ b/drivers/gpu/drm/msm/Makefile
> @@ -81,6 +81,7 @@ msm-display-$(CONFIG_DRM_MSM_DCP) += \
>  	dcp/dcp_hfi_plane.o \
>  	dcp/dcp_ipcc.o \
>  	dcp/dcp_plane.o \
> +	dcp/dcp_encoder.o \
>  	dcp/hfi/hfi_packer.o \
>  	dcp/hfi/hfi_unpacker.o \
>  	dcp/hfi/hfi_utils.o
> diff --git a/drivers/gpu/drm/msm/dcp/dcp_encoder.c b/drivers/gpu/drm/msm/dcp/dcp_encoder.c
> new file mode 100644
> index 000000000000..bc173fffb325
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/dcp/dcp_encoder.c
> @@ -0,0 +1,31 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + *
> + * DCP encoder wrapper for the CRTC-to-bridge connection.
> + * Hardware programming and mode sequencing are handled by the bridge and HFI.
> + */
> +
> +#include <drm/drm_encoder.h>
> +#include <drm/drm_managed.h>
> +
> +#include "dcp_encoder.h"
> +
> +struct drm_encoder *dcp_encoder_init(struct drm_device *dev, int enc_type)
> +{
> +	struct drm_encoder *encoder;
> +	int ret;
> +
> +	encoder = drmm_kzalloc(dev, sizeof(*encoder), GFP_KERNEL);
> +	if (!encoder)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ret = drmm_encoder_init(dev, encoder, NULL, enc_type, "encoder%d",
> +				dev->mode_config.num_encoder);
> +	if (ret) {
> +		dev_err(dev->dev, "encoder init failed: %d\n", ret);

Again, ignored feedback. Use drm_foo functions instead of dev_foo().
Also, there is little point in printing an error here.

> +		return ERR_PTR(ret);
> +	}
> +
> +	return encoder;
> +}
> diff --git a/drivers/gpu/drm/msm/dcp/dcp_encoder.h b/drivers/gpu/drm/msm/dcp/dcp_encoder.h
> new file mode 100644
> index 000000000000..de40c9bca4bb
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/dcp/dcp_encoder.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + *
> + * DCP encoder interface between the CRTC and bridge chain.
> + * Hardware programming is delegated to DCP firmware.
> + */
> +
> +#ifndef __DCP_ENCODER_H__
> +#define __DCP_ENCODER_H__
> +
> +#include <drm/drm_encoder.h>
> +
> +struct drm_encoder *dcp_encoder_init(struct drm_device *dev, int enc_type);
> +
> +#endif /* __DCP_ENCODER_H__ */
> 
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry
