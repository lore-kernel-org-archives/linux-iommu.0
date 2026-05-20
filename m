Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD1B25333F
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 14:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779287265; cv=none; b=POUGywTeJueh+z6OWU4vHzlqwqwIfYwPZIzHZo2kUBXQxwRIcU5fENeDogiqXcxYsfTEGj0jrT62jzmA7n1F57sgV5DItjzXIj8ExC5pvul+LpvrGAf8L9tB+EQsG6tWKBSLSjf4wO52hm7M6AyCXKbfNka9MW+NtfWcrDJApAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779287265; c=relaxed/simple;
	bh=HhFXaI44qpPtebJLFLdgRIOE8w0ovcHLixgHIq3RmAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SauKSK/DisWBoTTvFKgxNeLS5Dk43biAfndE4idJwDl3+LC+c3vLDaqIz6iPhc7UZD6BBC1KBgb5Lltr5mNiDNtr2j01yPWchuNHsrYRRcpxWBJuibfHDwbJDeQ18HU4RCU/YHmYBau9zRg/kXmwTpjSP7+Bi7rJfzThlA04USQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IJVdwe0E; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=giO4/8CV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IJVdwe0E";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="giO4/8CV"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64K9nYQl446952
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 14:27:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=EFchA/PJgMyqdqvbr5p+Cpu2
	tYJVf4uyCXjeVVObaow=; b=IJVdwe0E9ak1iNh8XXD9rrzKn/RUEyEFg+TihlY6
	0x0kfwSksu6HayCdXDFAChikwMgdL3e8wUM0Atzfurz76tMCVidK95iSWV6cIqnG
	6F/bwCjvcC9GKTkjGx6iT/jnpaBOnkX3OR+yjFiER1R9nnaDOOYPHV+Eo4FnKRCM
	4aks3xgT098xaEVWR9hTv8+pp3Xm1POqGlIIQ8IF58ELY+HjaVV5iwCdQpuDUxuO
	1k5mZhCdgWi22xllqgMo/UolX+X0od3iXAWDRogiJhUHqi8AKuFPBQCQOYsVH9aS
	7Bd83i0RH9+7HtQU/S3XzCkBxlHhTRRDVUUN3Nc8CUD3nQ==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9anrh0ss-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 14:27:38 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-57584c23424so13195043e0c.1
        for <iommu@lists.linux.dev>; Wed, 20 May 2026 07:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779287258; x=1779892058; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EFchA/PJgMyqdqvbr5p+Cpu2tYJVf4uyCXjeVVObaow=;
        b=giO4/8CVAT3zhDqw2pBCUr5rUUzz/I0bGA6Zcv/gzabTEQ9j2qUafhJv4KWKDeR/9k
         a58VIwG5XPOqL2yV9VDZ59LJ7I+qHy3jAWze+06hd+AiyJrPXElRzyLO9xh/D4wXu5Mc
         pQrW/wUaDURs7GIyOYW7yr65dyhSdiESq2ELqDqljzMp/1OVT159JcKyLZG5dOUIfwuo
         QXMzabxNE+p9UrSYv6tNGp7g09xIGn5aMxU0RyOI5/v4dfHNC3UL0oKafKrX6viLDB3F
         +4X+vftekpDS3ak1CpLGF8W5184GIDxPY0Gu9QLjLlvNUPlxk0fyxSVuPfYRZnYLCTJ7
         UtGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779287258; x=1779892058;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EFchA/PJgMyqdqvbr5p+Cpu2tYJVf4uyCXjeVVObaow=;
        b=fo8csfZEcNNufj5mwu7TtGf83NU568oJCJV8D2nxTb2HzWaInCh0V06rOb42v8Nw0k
         CfhykbGrk8B5T9Spabxi93QkADbA6DmCUB4vIMoLh49plA2kbRb4b2CZ7QehfbGpjPH2
         4rinzXziCnFSEvG2YRgPAECZsRJe52gyYmP/SWmrTyu/8SzCoBO0nh2pjspzZD1SmTNu
         D2RXpLtyskdRo1lle2oB/TvT2Mk+MBoEP6Rm1zqWZ8yJtLGwsvaMfMKmvyBQEIHcoqzH
         mvZJHRgJXl/unKrVLQImBikKsq4dF+SwwRKmlH/cU7AXpg0C9wZee54AXEWDHoUiGf6U
         MHcw==
X-Forwarded-Encrypted: i=1; AFNElJ+ElN45/efEEPESZFh2WQzX685Qz5dY+tF95axnVckAKZu1uhWp8Ntju2Hy/CGyISnSyNqeRA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzkZtdARHUCcikFMbGZ9BpxLrpTpRf7OAyFdfdJkiffU5FUjarQ
	9qwIPNzDado8Jep3li4IKel5/WlJltoeDo2p9nXW2Ii/F/zBkeGUTZPA8N38tHXepiWK618FZ7k
	GlAMAYi76H/+B9wEPgCods7Tp9cnVnn5GftSzibhTRwZ5RczdywmioyhZzA==
X-Gm-Gg: Acq92OFPE5jWc20/p+S4bx+DOHJqSX7+8Fd30caKUDeraNjU8qeqROKbyuozMD7jDZV
	gBk8QcweE+MDQS94NAjLdjNxTwy5ti6cXwji0SyhbswMrRrH4zPZpA+fso1i1AgY9iZ7Qe/Vlgz
	GrJpzxBdHGPRNGngm9gfwUx/o5kOXlf/7HwRvOxRI9eOFB3gHTr5Rh3XMzD0VqS0PvPwCaRPQOy
	T5S7Bz+144avEdsa9fGZ3i33kIWXuNqB5FuNIz5UNY+trZ8W8vfIeRd967j5PLItM91WoNKZlpb
	ol9+N0B6WQEejmCuKsa9W+myTKT1/cpnWgiv8qnlR9wJCem3rTSFm8DcEqqoAr/pN2pDgzWo/P6
	y9BuT0cYvuzyN5MHh8AxUsSapN6SGjWl05wTovgpRNrdxsPWY+ozJ7EwaZjT6zlXGLR0LKXaImi
	E8QwvuOWa7p4MNqiAHPxby46raoyHK17u89opGFZpYRRMcSQ==
X-Received: by 2002:a05:6122:4b8c:b0:56c:ca03:b668 with SMTP id 71dfb90a1353d-5760bfb8ca9mr14235203e0c.3.1779287257980;
        Wed, 20 May 2026 07:27:37 -0700 (PDT)
X-Received: by 2002:a05:6122:4b8c:b0:56c:ca03:b668 with SMTP id 71dfb90a1353d-5760bfb8ca9mr14235127e0c.3.1779287257396;
        Wed, 20 May 2026 07:27:37 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a9164bc39fsm4991506e87.49.2026.05.20.07.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 07:27:36 -0700 (PDT)
Date: Wed, 20 May 2026 17:27:34 +0300
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
Message-ID: <a6n2qquynwzlquzqmnmjmkg6vkrldj42muuejwzln5wna2qmhi@ki2slzuyt5qw>
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
X-Proofpoint-GUID: eER4Fs696hCGNL13Lo7-DzBl1D59SGOH
X-Proofpoint-ORIG-GUID: eER4Fs696hCGNL13Lo7-DzBl1D59SGOH
X-Authority-Analysis: v=2.4 cv=UuJT8ewB c=1 sm=1 tr=0 ts=6a0dc4da cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=o1-M_76Tnwwude6v8VIA:9 a=CjuIK1q_8ugA:10 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE0MSBTYWx0ZWRfX4c3L8m5gdBOp
 VEOMP8+XrushFU7wDnwUVtAbeGdREROQSlbUta3yptsIJcue9hP4f3V5Moa89oXN/7N3O1r3k9V
 Y0RjO6ZUIjLvlGqoTMWOP2MfOaZrc8irmmOkbx+wTpygHceQsfuJpr7rGIYBuLptmK5EQiTWzdY
 oHyUHHJgn3iw95vLFMHlSQB9uEpHQ4u7q6lRh/sr8uMVuj5oZGNhjRkh7A2xf0ktibkjNf2mnW5
 RDS9Bh0lE0VXvddi9ceVRvByKxI/LWunKJKZ8kYeKJpRR7qLzlxXPInu/4ED3Eq4z4mZfDK5Rj9
 qhsYFfGvstGRykkXYXvWy+iXlhgFFT9+HaAQhu12A0P2MrH6F86LRp+640lkUq3snH79lblya5/
 K3BgpQxQjWWEuu/sPtExrwr39E8XMgInuls0OJAS7k8EOFmIEgtAmskMdP0z0dPtjx05pqkVcAX
 JIy2/P48E9tSeFT4ZWQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605200141

On Tue, May 19, 2026 at 11:45:57AM +0530, Ekansh Gupta via B4 Relay wrote:
> From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> 
> Introduce the QDA memory manager (qda_memory_manager) to track and
> manage the IOMMU devices that back each compute context bank (CB).
> 
> Each CB device registered on the qda-compute-cb bus is assigned a
> unique ID via an XArray and wrapped in a qda_iommu_device descriptor
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
> @@ -61,14 +62,20 @@ static int qda_rpmsg_probe(struct rpmsg_device *rpdev)
>  	}
>  	qdev->dsp_name = label;
>  
> +	ret = qda_init_device(qdev);
> +	if (ret)
> +		return ret;
> +
>  	ret = qda_cb_populate(qdev, rpdev->dev.of_node);
>  	if (ret) {
>  		dev_err(qdev->dev, "Failed to populate child devices: %d\n", ret);
> +		qda_deinit_device(qdev);
>  		return ret;
>  	}
>  
>  	ret = qda_register_device(qdev);
>  	if (ret) {
> +		qda_deinit_device(qdev);
>  		qda_cb_unpopulate(qdev);

No, this is not how you unwind in the error case in the kernel. Follow
the established patterns.

>  		return ret;
>  	}
> 
> -- 
> 2.34.1
> 
> 

-- 
With best wishes
Dmitry
