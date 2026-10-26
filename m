Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793009264;
	b=dy/unPj7dpSK3kfbLrDcx0lwWdSCb0oYeWa9Eol5GtpDi2b1vaLOpBGYv1j0IIPXH8WN
	 oN93c1+8+vPRZkcM6JhV94CZ5W2x5rN8nQaFY9HLlkhJFM29Okt4zEv7VYiGtHFDwiH1h
	 uyxB7kSw+MPj3RryflKK8z5oawvioWz6TmCU2NnK3/mepdvhkBMZPLqdfEjqRbg076VAO
	 RaK6YBVLHs5I/w5KOIY9WZ5+ut2pyJLH5h5KFqdKaluv5KrHciqdO/snh2LsJjm7/WVgd
	 DabN4NjnLyhJe+E89t7I3n00sqGepqQuLtTN4IOC3sScIm0HB3u1DHE+2Z8Lw4T6ZLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793009264;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=GnGg3CwhR38uGbReDQYTDKY/Dc4Njz+sxG9mC0bWH/s=;
	b=iMFYrDF7NFCj0Ze69KsfzJUZPF0PVqBg7dW/iycswmlbxTlan6kQozf40f33tG3eV+Gs
	 nmL+UdwTm6+vZ6/imUXwhGYk9ivY/u8RwmQTz6bXeHHvNzm31BlO0VE2pvtJC9kDOnVnq
	 vn+gA7MPvEyoPqeM3IUCgebf99G8faOb46ayjcRn21Gu94V1J3jM75KW3iKCt6YORw6AO
	 6+ZgvjA1ejaKqLt82pMwVwxXJrANE9Ghaeb5abOL5/lbFyV+5Zwhd3N9QFTvPOPeWeiOe
	 yukXIAZH6EsGAnHdaSUxwePjjthECiCaICLGRD9hxueKqr0ru0lLoRS31sEZzOihYKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RermaiNu;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Y+smY9yO;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B544D606A320
	for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 10:07:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B544D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RermaiNu;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Y+smY9yO
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69Q4arT73303602
	for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 10:07:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=GnGg3CwhR38uGbReDQYTDKY/
	Dc4Njz+sxG9mC0bWH/s=; b=RermaiNumI6rQUJ4BUBComPJBEVniwoJh0VMlc6L
	zi8lY4wo4UkHn1tu94EH1c2wE/7KGgmysAno4bo/lleCg63U8CmjHFLWK9QouH1O
	YqwLJQKjvKHHKyn/QDBQvxD5RMNH0RRPk6f+b541i3J5cDRx23yunhFNdcOJHUUl
	BhjjLC2wqsPkZ9lXYJ1SeV8LnyOWq1ZuuK7KZxf7xu6Qbq0HPN6yrB5I3LHs44Qs
	WSwK9lOVPsbzYhLFRb50iRgeRrew+XmBUFPw5vrkxUpcwTSJD5B5l5qNHtlXx13d
	GE4mUhKllt4PYqyf5veLfeemSRlQ7vWnM9rW8wlISiPNfA==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgkmsdx7d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 10:07:42 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-988b86c66e5so3206808241.0
        for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 03:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793009262; x=1793614062; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GnGg3CwhR38uGbReDQYTDKY/Dc4Njz+sxG9mC0bWH/s=;
        b=Y+smY9yOchAHRuR4d5MNiikKxdmRVRWNGPXqm3gRmVfh7z0W6Rh+7jKHpyt02K1H6H
         QiEgbloxjGpVfEb+ff0uFhCXHJOsCvOynmXzHUuLKhKglut/XXrJg7T42np/ZXS2y5tG
         bxPLCKFtX903o7khmhaGvxHPR/AnXXkNWsJ05mZsUNJOiEloHiuiPNQbO+e1k4NL+VP1
         P/PgnKrEIpckMqQUP0RkMxBruE8zW9PeqOBbKR65ZRGzpzkQjHZI5NiaiwN0uhC/2NTe
         9Dqziyr4Zn9ZsHUFBGM66iJEzVj0xcHx7dJFjL82DF9UmcpgJI/uCziBVJHKhOZo7KLW
         p1Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793009262; x=1793614062;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GnGg3CwhR38uGbReDQYTDKY/Dc4Njz+sxG9mC0bWH/s=;
        b=eXWJLQi6BH2nSQcL4clVPwUlDsIGfactXnk1Cp4dKnu6Wa3Ico4pmxIYrAOvTokIv5
         nv+kdpbsyfXRgZ8SY96AVlQDF8Q5hIcdKdFTMYJ/3+LKvfzf0Gtn/ngnI2pCN7saTKGu
         J8KZ+62k4nvQYnsOIx+xSSxyvZS/bCkgvV9r8ZbhS03uMrqbqDArlT99QKgf3W4hT2uf
         6fLFwppDGNiI7PHNje1VVozlhf5b5Z7NLM/LHQYVY/ozkpQ9Jwv/fPBRu0WaM/tJkkJo
         DIT/hitJ/H7Fg8R0KxfbS3BJ9s3I/Ty60vSnlRFVHZi5BtU/kG1l0/TrtvX9nURGnVkE
         YEQg==
X-Forwarded-Encrypted: i=1; AKwUvBxrgu58k/bw2aGkIsMMeqZeHIcgO/DUZ3ek+Wb/GL6R+hPR/rO3cBSqbfeluWq9oNlCIZ1HyA==@lists.linux.dev
X-Gm-Message-State: AFq9FYKYJS4uVwWoM6oHPL7yS9b+bJeow1REZxixw5YG70woUyxY8cRq
	y+TgQYoIzVrDruOe9jx/MyVlqXNHWMeM5sR4hP8ufnU3QNYSY1JuMoR+yXlxrfU9rQWGD4Jcgy0
	/kZflz+MejfgeNG0SjRYw2HKZYP5u60W/Hv7553boW/Vc9aNxETOf2xFh9g==
X-Gm-Gg: AYBFou2FPbHMIZfzwRxs6ylctZxwf0lfXheBQlbu06tH5Gf91uQobK1dL8XyWc9abf8
	pzAged3j5tXseBWVHBA3twhncrVRcsqSjibFLqtFG4dX9ygNnZ2qfKStYe18rfWLcA/qAEeynLv
	2+LT87m3tjakWwjU1ZHNf8jtKc6K8o1+KBTfDfyNID2gVk9X8B2sgOnX2Y/fnz6h1QwjR93Zh7w
	ORzWwcpo120XcK1ZLv9l0wG4jsBNoHv52f2eaqM6UTZVrsYedbzSKKkEi9vGYgXTOEMnCDlXsBe
	+bX5kOldhvFOUBJfa8xIIdtg9R0rXLIdEYCPZofVhtBebYdXfq6/LuTZyltx7u6X5L4F21ImhBT
	5NrQ0TZMlCIWAIkpHKH/7I2rSEh0KbHu78oIsdMwPzlbQ1iKe3M8/KJCv6M2vnsa4pDBNwsZBEJ
	ThLLYutmMNmpGN
X-Received: by 2002:a05:6102:2ad2:b0:7cc:148f:c531 with SMTP id ada2fe7eead31-7ce5cd9e89cmr1435472137.26.1793009261608;
        Mon, 26 Oct 2026 03:07:41 -0700 (PDT)
X-Received: by 2002:a05:6102:2ad2:b0:7cc:148f:c531 with SMTP id ada2fe7eead31-7ce5cd9e89cmr1435438137.26.1793009261000;
        Mon, 26 Oct 2026 03:07:41 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ac70a463f5sm16498211fa.36.2026.10.26.03.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 03:07:39 -0700 (PDT)
Date: Mon, 26 Oct 2026 12:07:38 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowangio@gmail.com>,
        Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Philipp Stanner <phasta@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Flemin Jose <flemin.jose@oss.qualcomm.com>,
        Mahadevan P <mahap@oss.qualcomm.com>, virtualization@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev
Subject: Re: [PATCH v2 19/23] drm/msm/dcp: Add Qualcomm VirtIO transport
 wrapper
Message-ID: <ib5ts37i4f7qx4wqoscawrwnpeld3pcnarb4w7y3z4b3kolgkf@5avoy2fyp22l>
References: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
 <20261026-jshekhar-dcp-hlos-v2-19-7cf014efdee1@oss.qualcomm.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261026-jshekhar-dcp-hlos-v2-19-7cf014efdee1@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: rcm3gE3sX8_LkS6LXKrJAnQ6NzfBdYig
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA0MCBTYWx0ZWRfXysNQK4UavXGt
 JlJkPTinncP/Ydi5XAQtCsiWPErWghNuc2HPWWUUZxuotbzOFUXbtv/YFb+9cFYtyIF07ryERio
 Cn4QQEOl0N6L1xEOPGUFBTrpzSTuHDlG/S+Nm46SUVaS8JdK1fl5Ij3gFRiJuulvnjoYvbOPJY4
 36NadkSDPNwY4fRw8gUyWUFZt6Yn5MDwjiT1SGmi46PFs+r7DOp2oRIWBlj5XWj2cqcU93cnOYu
 CcIsQQr9w7E633AFYklDIIIfCJ+sFLNS+QIIbj0Scq6L2/Z0rUA7CKMmtVlNQ7quIPrt2EcQuTu
 lIZpbDDIzj6wgJX/GdmJBs5arVHFXWeURnK1W+fwP++qF+WGJMk1/TM5xFbNAUPGU5uBxe84TeX
 4xG/ZThe/rBKpqBQK3JeHYyRprUyjG0yQAX0FtiQ2fX98CApdFbwBumQWF3lKHGcZM7aA0F85eG
 DvfujPlY3AOrnwxEqBQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA0MCBTYWx0ZWRfX7a+BatuYWeFO
 gXoNT0xdLM4dx3o+CEkDEo9pKl9+xmQTZTzv6qhZdk32VgszzLLZ+DguQVgM8+g0l4QrhTvK98F
 hVTBmcjRzIl+TPP030DFkA19OIStg/w=
X-Authority-Analysis: v=2.4 cv=UqX2pOwB c=1 sm=1 tr=0 ts=6adf266e cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=zJVDlABOU36UOg3UFKQA:9 a=CjuIK1q_8ugA:10 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-GUID: rcm3gE3sX8_LkS6LXKrJAnQ6NzfBdYig
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260040

On Mon, Oct 26, 2026 at 11:51:29AM +0530, Jayant Shekhar wrote:
> Add the Qualcomm-specific VirtIO transport required by DCP firmware.
> 
> The transport sends an IPCC power notification before accessing the
> VirtIO MMIO registers, then registers a VirtIO device directly.
> 
> Implement MMIO configuration access, feature negotiation, virtqueue
> setup, interrupt handling, reset, DMA setup, and suspend/resume
> sequencing in the transport. Keep power-management ordering in the
> transport so VirtIO queues are quiesced before DCP power changes.
> 
> Assisted-by: LLM
> Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/Makefile                   |   1 +
>  drivers/gpu/drm/msm/dcp/dcp_virtio.h           |  23 +
>  drivers/gpu/drm/msm/dcp/dcp_virtio_transport.c | 643 +++++++++++++++++++++++++

This is a separate VirtIO host driver. Please move it to drivers/virtio
like the rest of the VirtIO hosts. It has nothing to do with the drm
subsystem now.

>  3 files changed, 667 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
> index 9f0a9bfeb2a7..e1a995a8c980 100644
> --- a/drivers/gpu/drm/msm/Makefile
> +++ b/drivers/gpu/drm/msm/Makefile
> @@ -85,6 +85,7 @@ msm-display-$(CONFIG_DRM_MSM_DCP) += \
>  	dcp/dcp_hfi_plane.o \
>  	dcp/dcp_ipcc.o \
>  	dcp/dcp_encoder.o \
> +	dcp/dcp_virtio_transport.o \
>  	dcp/hfi/hfi_packer.o \
>  	dcp/hfi/hfi_unpacker.o \
>  	dcp/hfi/hfi_utils.o
> diff --git a/drivers/gpu/drm/msm/dcp/dcp_virtio.h b/drivers/gpu/drm/msm/dcp/dcp_virtio.h
> new file mode 100644
> index 000000000000..a9c3b9aff61d
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/dcp/dcp_virtio.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#ifndef __DCP_VIRTIO_H__
> +#define __DCP_VIRTIO_H__
> +
> +#include <linux/device.h>
> +#include <linux/virtio.h>
> +
> +struct dcp_drv;
> +struct dcp_ipcc;
> +
> +struct dcp_ipcc *dcp_virtio_get_ipcc(struct virtio_device *vdev);

What is the use for it? The DCP driver should not communicate to the
IPCC, it's a part of the underlying VirtIO mechanism. If we export DCP
to the VM there will be no IPCC anymore.

> +
> +int dcp_virtio_transport_register(void);
> +void dcp_virtio_transport_unregister(void);
> +
> +int dcp_virtio_register(void);
> +void dcp_virtio_unregister(void);

Unused, remove these two.

> +
> +#endif /* __DCP_VIRTIO_H__ */
> diff --git a/drivers/gpu/drm/msm/dcp/dcp_virtio_transport.c b/drivers/gpu/drm/msm/dcp/dcp_virtio_transport.c
> new file mode 100644
> index 000000000000..02c0e2a9fafe
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/dcp/dcp_virtio_transport.c
> @@ -0,0 +1,643 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + *
> + * Qualcomm DCP VirtIO transport.
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/delay.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/highmem.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm.h>
> +#include <linux/slab.h>
> +#include <linux/virtio.h>
> +#include <linux/virtio_config.h>
> +#include <uapi/linux/virtio_mmio.h>
> +#include <linux/virtio_ring.h>
> +
> +#include "dcp_ipcc.h"
> +#include "dcp_virtio.h"
> +
> +#define VIRTIO_MMIO_VRING_ALIGN		PAGE_SIZE
> +
> +#define to_dcp_virtio_transport(_plat_dev) \
> +	container_of(_plat_dev, struct dcp_virtio_transport, vdev)
> +
> +struct dcp_virtio_transport {
> +	struct virtio_device vdev;
> +	struct platform_device *pdev;
> +
> +	void __iomem *base;
> +	unsigned long version;
> +
> +	bool wake_irq_enabled;
> +	struct dcp_ipcc ipcc;
> +};
> +
> +static u64 dcp_virtio_get_features(struct virtio_device *vdev)
> +{
> +	struct dcp_virtio_transport *transport = to_dcp_virtio_transport(vdev);
> +	u64 features;
> +
> +	writel(1, transport->base + VIRTIO_MMIO_DEVICE_FEATURES_SEL);
> +	features = readl(transport->base + VIRTIO_MMIO_DEVICE_FEATURES);
> +	features <<= 32;
> +
> +	writel(0, transport->base + VIRTIO_MMIO_DEVICE_FEATURES_SEL);
> +	features |= readl(transport->base + VIRTIO_MMIO_DEVICE_FEATURES);

Can we turn virtio-mmio into the library code instead of copy-pasting
everything here?

> +
> +	return features;
> +}
> +

[...]

> +
> +	magic = readl(transport->base + VIRTIO_MMIO_MAGIC_VALUE);
> +	if (magic != ('v' | 'i' << 8 | 'r' << 16 | 't' << 24)) {

Is it really a correct magic here? should it be a different magic as you
are not just a virtio-mmio?

> +		dev_warn(&pdev->dev, "Wrong magic value 0x%08lx!\n", magic);
> +		ret = -ENODEV;
> +		goto err_node;
> +	}
> +
> +	transport->version = readl(transport->base + VIRTIO_MMIO_VERSION);
> +	if (transport->version < 1 || transport->version > 3) {

Isn't transport version fixed for the DCP purposes? Why do we need to
determine it again at the runtime?

> +		dev_err(&pdev->dev, "Version %ld not supported!\n",
> +			transport->version);
> +		ret = -ENXIO;
> +		goto err_node;
> +	}
> +
> +	transport->vdev.id.device =
> +		readl(transport->base + VIRTIO_MMIO_DEVICE_ID);
> +	if (!transport->vdev.id.device) {
> +		ret = -ENODEV;
> +		goto err_node;
> +	}
> +	transport->vdev.id.vendor =
> +		readl(transport->base + VIRTIO_MMIO_VENDOR_ID);
> +
> +	if (transport->version == 1) {
> +		writel(PAGE_SIZE,
> +		       transport->base + VIRTIO_MMIO_GUEST_PAGE_SIZE);
> +		ret = dma_set_mask(&pdev->dev, DMA_BIT_MASK(64));
> +		if (!ret)
> +			ret = dma_set_coherent_mask(&pdev->dev,
> +						    DMA_BIT_MASK(32 + PAGE_SHIFT));
> +	} else {
> +		ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
> +	}
> +	if (ret)
> +		ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
> +	if (ret)
> +		dev_warn(&pdev->dev,
> +			 "Failed to enable 64-bit or 32-bit DMA. Trying to continue, but this might not work.\n");
> +
> +	ret = register_virtio_device(&transport->vdev);
> +	if (ret) {
> +		put_device(&transport->vdev.dev);
> +		dcp_ipcc_deinit(&transport->ipcc);
> +		platform_set_drvdata(pdev, NULL);
> +		return ret;
> +	}
> +
> +	return 0;
> +
> +err_node:
> +err_ipcc:
> +	dcp_ipcc_deinit(&transport->ipcc);
> +err_free:
> +	platform_set_drvdata(pdev, NULL);
> +	return ret;
> +}
> +
> +static void dcp_virtio_transport_remove(struct platform_device *pdev)
> +{
> +	struct dcp_virtio_transport *transport = platform_get_drvdata(pdev);
> +
> +	unregister_virtio_device(&transport->vdev);
> +	platform_set_drvdata(pdev, NULL);
> +	dcp_ipcc_deinit(&transport->ipcc);
> +}
> +
> +static int dcp_virtio_transport_suspend(struct device *dev)
> +{
> +	struct dcp_virtio_transport *transport = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = virtio_device_freeze(&transport->vdev);
> +	if (ret)
> +		return ret;
> +
> +	ret = dcp_ipcc_enable_irq_wake(&transport->ipcc);
> +	if (ret)
> +		goto err_restore;
> +
> +	ret = dcp_ipcc_send_power_notify(&transport->ipcc);
> +	if (ret) {
> +		dcp_ipcc_disable_irq_wake(&transport->ipcc);
> +		goto err_restore;
> +	}
> +
> +	return 0;
> +
> +err_restore:
> +	virtio_device_restore(&transport->vdev);
> +	return ret;
> +}
> +
> +static int dcp_virtio_transport_resume(struct device *dev)
> +{
> +	struct dcp_virtio_transport *transport = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = dcp_ipcc_send_power_notify(&transport->ipcc);
> +	if (ret)
> +		return ret;
> +
> +	dcp_ipcc_disable_irq_wake(&transport->ipcc);
> +	if (transport->version == 1)
> +		writel(PAGE_SIZE,
> +		       transport->base + VIRTIO_MMIO_GUEST_PAGE_SIZE);
> +
> +	return virtio_device_restore(&transport->vdev);
> +}
> +
> +static const struct dev_pm_ops dcp_virtio_transport_pm_ops = {
> +	.suspend = dcp_virtio_transport_suspend,
> +	.resume = dcp_virtio_transport_resume,
> +};
> +
> +static const struct of_device_id dcp_virtio_transport_of_match[] = {
> +	{ .compatible = "qcom,dcp-virtio" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, dcp_virtio_transport_of_match);
> +
> +static struct platform_driver dcp_virtio_transport_driver = {
> +	.probe = dcp_virtio_transport_probe,
> +	.remove = dcp_virtio_transport_remove,
> +	.driver = {
> +		.name = "qcom-dcp-virtio",
> +		.of_match_table = dcp_virtio_transport_of_match,
> +		.pm = &dcp_virtio_transport_pm_ops,
> +	},
> +};
> +
> +int dcp_virtio_transport_register(void)
> +{
> +	return platform_driver_register(&dcp_virtio_transport_driver);
> +}
> +
> +void dcp_virtio_transport_unregister(void)
> +{
> +	platform_driver_unregister(&dcp_virtio_transport_driver);
> +}

Turn it into a separate driver, use module_platform_driver().

-- 
With best wishes
Dmitry
