Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1C32AD10
	for <iommu@lists.linux.dev>; Sun, 19 Apr 2026 00:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776557789; cv=none; b=WbmbyZy2p6Lo/qA2BERsGEyJerPBqq6Xq2JCJY01qI+YhP+9XIT1jVTnhVIkDD+w+Kemr0wpQAeh1DO11A8/BvcXLwCDhElOd/AvjgZMZp5kIVTepY1EiRpA602tgwp40yUQuCs2VP/mX6ljcSxD9JYPz9Axf3LZ6toVk1vFqmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776557789; c=relaxed/simple;
	bh=Us0ndhO033kkFDcL/Ol+YYJaL5GcvP1KfFlzvNH0qnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a1ONqhBZGnAVDzB+KiSO0x+xcqQfn9ZbGlSDf2dpIfP58kLnUrIhrEFptZXYDkMUeq+DzE/WZam82rGBf43K3AO5mu5+mopj4KBO6S2K3Ynca5UhSsLXlq8gfNcI9yDOagqUNP/Gj33QP0GO5sM8S35PwtED7akjvs9Czk0VOfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gR697kqo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JDbOWtQl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gR697kqo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JDbOWtQl"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63IM07es3390214
	for <iommu@lists.linux.dev>; Sun, 19 Apr 2026 00:16:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=krtkKxe19pMn4PJwb0xqRCTx
	s6eIr+De+hcmkYF9q48=; b=gR697kqo80AfHPSVffaSyFYnY6aqjhi5knRMEcry
	pUTuAf6jP8zXHkkY2KJEWhJfCS9zAU1Vcz86eE6qwoHoU2HtpPtG5fudRj7dOyhf
	lAiR7LAsOR5T5ankj4p4/rHYlEJIpW8iC225aFk5K5YLMBtSdpGdNwZwzGRhdQmF
	23lq2V6dzPnpj3lwWiG8sv1ULnN+bO1GLkWcM0uIED9vacHlgShdQYmSeHgvcAV+
	4f+6eBdTLlcNvwin8N9iKAePe1bjK6NqACqnfVbtT0gTjGHv2gm0cpjq0+imp05d
	COD+qz1rDaBlio8vkaV2wGdbVJpSp5CooJp2SJapHEtjnw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dm19fsr25-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 19 Apr 2026 00:16:26 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cfdc479f68so208873685a.1
        for <iommu@lists.linux.dev>; Sat, 18 Apr 2026 17:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776557786; x=1777162586; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=krtkKxe19pMn4PJwb0xqRCTxs6eIr+De+hcmkYF9q48=;
        b=JDbOWtQlZ+UBL88HPPG91Ird/eknRFvSLOSKIn3RMO8mFmHegeMcWoNN/f0AYLZpVN
         LPUoUxQ6GtKim0FeF7uiK3yyp7Rn8JOkZZYHM6e8msmrXaC9unX74viRn/C7tXOLofoG
         eNtyyJvzdCmAWdcSidVyI/Zc3NHkb3Ra/UosYMusNzC913c1ISa8jOG73p2NyJxqC1NS
         tR6dvRdNDnJY4y0oCkWVUvGsjQHNA1imTo6OdTtSZ/Yl1Ui1yq/j13E/SGcxohO+GsxD
         oOxTCcOE/Ai7WL1Ga/VwaT5ztetqNfe5wJX24fGmoJgmfTtJHX+azYB1Ui6QbdQawmw+
         FI3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776557786; x=1777162586;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=krtkKxe19pMn4PJwb0xqRCTxs6eIr+De+hcmkYF9q48=;
        b=CRBdVdNZ2fD6drvaqbd0+cw6Lhqv1R15Mf6P+41e+SORCHgLDc4Hb95oabpmU5uajK
         eNbZQBpY3YZWeocHu47gDOlhIbn9pODtyHWZpwJC1s1Io5f9RrDjV1wPzzdAa2p9Lk2o
         077or2491ah37QbWVnfePbMqgenUjsLfd2QfE15kVI1kuXZtQHZAxKA6QGltMmtByaZf
         MCxaF79uMQaBOpti18b5AOQ4eJtztClmLsVCabRyd2KhDoSUNmn1vxSQHNVr9pThb76E
         oikQhYWRnPE58ej1pojYiNpPI/wn96C/ro0jIvuX61KScqT4GMGHRmc6ERTuo6qOmZqt
         Xz/w==
X-Forwarded-Encrypted: i=1; AFNElJ/SEyYrS4NXv8D00ttvuBmg+a3rA6116Nn+F/UV5Md1X01BrsAFuL4n18LcR5nAxgIFxsFQrQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy77+wJZ+Typ5eo6MTRpBrQOGOZKg/j1sJj1fSz+iERbMxyuqs+
	ojVV183e8yreKaEUj+QYV1bYjudPz8Z8Pl3uid5W9VX+ZVv20V0jZQw7hyxTUZkrdI1TLaE2+GK
	4z4lEGFRmzQFEokYWK3L3Iulpty11jv3KOnhOwVtJmCkjCp13/AmNxYEYhg==
X-Gm-Gg: AeBDievm8fTf457RAAM7sgCJaXTLAQtbDVwGehmxKDPm1Qwl1FMaQPmoMP36Ff+yV42
	Gf96Ij0n+TqsFOX3g1x5OQ/92hqNkqzFtRBzaI9iQK1KhoT1G0WKxO8eDlnOzcYHaFvlYN2g6Fe
	jwudeuTdiUzbxgS53RUJz+gSVmUWwz1bseCFJLGdrvsyvhztwfqlGFHBSgDPIIuta7XFEsUyfjO
	WBnXRFp4sJPX8IuB0RVgQs+Ik0ISxzzMUgLLecxf2pg130PVfnpkr9EfYj2RnMkwZ+4VSqSK4S2
	/4xRJmfHOYXMqMgWqLMgz1bGA8j/3FbXNs4UGLfu+dm3ohiNRlF6nf8K0Il6kgrFddrDXWaLZSx
	vSsFHLDipzdIVSTwgSJ71/p3FeTXMmK2JTx2T23e6eT1LFSwztEKjaNKvKFRzOiGFBN/hcp1+Bc
	Iypwhrp6LKbSovNZQUuoL7SxdDKrWEaPuTap7Hk2RtDxBWTw==
X-Received: by 2002:a05:622a:1f8a:b0:50d:9e69:8099 with SMTP id d75a77b69052e-50e36833221mr139255301cf.19.1776557785941;
        Sat, 18 Apr 2026 17:16:25 -0700 (PDT)
X-Received: by 2002:a05:622a:1f8a:b0:50d:9e69:8099 with SMTP id d75a77b69052e-50e36833221mr139254881cf.19.1776557785464;
        Sat, 18 Apr 2026 17:16:25 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a4185ad343sm1729076e87.2.2026.04.18.17.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 17:16:23 -0700 (PDT)
Date: Sun, 19 Apr 2026 03:16:21 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Cc: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Thierry Reding <thierry.reding@kernel.org>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Arnd Bergmann <arnd@arndb.de>,
        Srinivas Kandagatla <srini@kernel.org>,
        Bharath Kumar <quic_bkumar@quicinc.com>,
        Chenna Kesava Raju <quic_chennak@quicinc.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 3/3] misc: fastrpc: Use context device bus for compute
 banks
Message-ID: <r25ibbsw3flfashrp4x2cqy6thckgez5k3gtfqp46dcpbjniev@s4ngoa46ekvj>
References: <20260414-computebus-v1-0-4d904d40926a@oss.qualcomm.com>
 <20260414-computebus-v1-3-4d904d40926a@oss.qualcomm.com>
 <cc90c55d-c93a-2789-f313-aaa5e4090be2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc90c55d-c93a-2789-f313-aaa5e4090be2@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE5MDAwMSBTYWx0ZWRfX3anCAkhlKENz
 +uko+5S8KbyxJI/XbnfpKII/Nh6cGjquOjMOu3UiN3axtMZIsr4VSa2unrnAIFEZWxGTMpWecg4
 Y6ALzBq7iMhDRfWKj6wsR2YB0Rb1frovE4Fh34rBbyXyAetHuZPSaPR2mmFoW8lYqkVoYqXzZ8Q
 0xtCeeC2IRfCmcF8YdBJMXB4QO0n+hgxmGufWr428IDWurgXlz+7iiVmWQl6dAqE0gZ7o/laP0x
 JKhEgknVsQ67OtYdytlnfKHr4k3geP713zudsLWHgzFR+mkNjgOBp6q5Q/l8lvev7Qy2ucg4O3r
 BbLzWVx7fnkdsL/SiT7O/9zOEIFsvct7fTG1xBajYVw9LNmf+RQ2TVjMMCu6GyLKNJnVMSw+fjS
 8FNEOCJemOFuVTktQQP8KERdnLiG+To9ZWxk4ISaSnzkHBGIzdaJGTiVx75+6X+qy79ltxfMGOO
 rJGKO0qTBVFLNs0okkw==
X-Proofpoint-ORIG-GUID: a3SaHexTVtP4X7s8jjXBrIPRJhJxsV24
X-Proofpoint-GUID: a3SaHexTVtP4X7s8jjXBrIPRJhJxsV24
X-Authority-Analysis: v=2.4 cv=FMorAeos c=1 sm=1 tr=0 ts=69e41eda cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=tB70rH4wX7YjnKcxG8sA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-18_07,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604190001

On Wed, Apr 15, 2026 at 09:35:47PM +0530, Vishnu Reddy wrote:
> 
> 
> On 4/14/2026 10:01 PM, Ekansh Gupta wrote:
> > Replace the platform driver approach for compute bank (CB) devices
> > with the generic context_device_bus_type. Compute bank devices are
> > synthetic IOMMU context banks, not real platform devices, so using
> > the context device bus provides a more accurate representation in
> > the device model.
> > 
> > Currently, fastrpc used of_platform_populate() to create platform
> > devices for each "qcom,fastrpc-compute-cb" DT node, with a platform
> > driver (fastrpc_cb_driver) to handle probe/remove. This approach
> > had a race condition: device nodes were created before channel
> > resources (like spin_lock) were initialized, and probe was async,
> > so applications could open the device before sessions were available.
> > 
> > This patch addresses the race by manually creating and configuring
> > CB devices synchronously during fastrpc_rpmsg_probe(), after all
> > channel resources are initialized. The approach follows the pattern
> > used in host1x_memory_context_list_init().
> > 
> > Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> > ---
> >   drivers/misc/Kconfig   |   1 +
> >   drivers/misc/fastrpc.c | 180 ++++++++++++++++++++++++++++++++++---------------
> >   2 files changed, 125 insertions(+), 56 deletions(-)
> > 
> >   	}
> >   	dma_bits = cctx->soc_data->dma_addr_bits_default;
> > +	if (cctx->domain_id == CDSP_DOMAIN_ID)
> > +		dma_bits = cctx->soc_data->dma_addr_bits_cdsp;
> > +
> >   	sess = &cctx->session[cctx->sesscount++];
> >   	sess->used = false;
> >   	sess->valid = true;
> > -	sess->dev = dev;
> > -	dev_set_drvdata(dev, sess);
> > +	sess->sid = sid;
> > +	spin_unlock_irqrestore(&cctx->lock, flags);
> > -	if (cctx->domain_id == CDSP_DOMAIN_ID)
> > -		dma_bits = cctx->soc_data->dma_addr_bits_cdsp;
> > +	cb_dev = kzalloc_obj(*cb_dev);
> > +	if (!cb_dev)
> > +		return -ENOMEM;
> > -	if (of_property_read_u32(dev->of_node, "reg", &sess->sid))
> > -		dev_info(dev, "FastRPC Session ID not specified in DT\n");
> > +	cb_dev->sess = sess;
> > -	if (sessions > 0) {
> > -		struct fastrpc_session_ctx *dup_sess;
> > +	device_initialize(&cb_dev->dev);
> > +	cb_dev->dev.parent = parent;
> > +	cb_dev->dev.bus = &context_device_bus_type;
> > +	cb_dev->dev.release = fastrpc_cb_dev_release;
> > +	cb_dev->dev.of_node = of_node_get(cb_node);
> > +	cb_dev->dev.dma_mask = &cb_dev->dev.coherent_dma_mask;
> > +	cb_dev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
> > +	dev_set_name(&cb_dev->dev, "%s:compute-cb@%u", dev_name(parent), sid);
> > +	rc = device_add(&cb_dev->dev);
> 
> device_initialize() and device_add() can be replaced with single
> device_register() call. You can refer the below patch,

Keep in mind that for several arches device_initialize() sets the
coherent_dma_mask. So one should set coherent_dma_mask (as it's done
here) after calling device_initialize().

> 
> https://lore.kernel.org/all/20260313-kaanapali-iris-v3-4-9c0d1a67af4b@oss.qualcomm.com/
> 

-- 
With best wishes
Dmitry
