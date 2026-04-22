Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704A52DE6E3
	for <iommu@lists.linux.dev>; Wed, 22 Apr 2026 18:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776883945; cv=none; b=Vne34ZaryebElFkQpo+iEXRIwujLqpmzrG5A99a5dBMh52oON8Q7KZDyRUAbAP9fXkGNDQgeWn4U5z8ICQ1f4QFBgi/P0WpLznwFAS9ni+89m27QReR1hcC6igbXkkWwx3mhz7+QKBSGbu4LciVtS7QAkqYnXtAt6r6NfSGp+84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776883945; c=relaxed/simple;
	bh=Q8s8HLfNZMNG3AkuzxK5uKeoajf3h+3aKwK+66dmIAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R5HMSBcbxSIa0QtRH4ANdZD8m/92M5h3DdOHUzGLbtysjpO0ZiPmscUG/WmmbwUv8UJIkDr0mFVO1UM+1HSKSeoPPHOCQ5GWvFqnJq+MjA/4g5T5ioIV/TMWXbZUjlwP+wtCtm3BUKJt1PGpfPR1an+FjDkwb+W2BK8ikbfhcIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jJfFq0zd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YLI9g+CX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jJfFq0zd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YLI9g+CX"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63MG9qjW3173021
	for <iommu@lists.linux.dev>; Wed, 22 Apr 2026 18:52:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Wotz04H8l5tgEEsb1NU3qjTk
	74Z9j+pDdwYuMESGV4w=; b=jJfFq0zdZy9ICHfrkQe/sXmomxTWDzPHZ4u4KnUZ
	3oh4PgAAn3MQFDjtXs3g5lFj/raVAAfcKw9RZhObgTW539TD4NAAngbB3beQm3Q/
	zgJgVQo5cEwac491XG+iYAqlyJMzRWIeb05E5x5IbXu8iV0X9XjHcTp+3E7fQFm7
	ch2yT5FSKeRX2f7JqARtAWA4Y/wfHzdhWk/s4ZIZlj9Rq/QfskVgCjWR71qFRQc9
	kWeh8gNpPKmx06CEmNOLKye+MAD4037Swbj6XggBcfGhAkk2xJEKzfpKg22/PuLJ
	+smX/Ebe9BOuvNuXKAgvqOCzYFwCHMUiAwmbSqEbWWRY4Q==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dq1m30j82-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 22 Apr 2026 18:52:23 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50d812c898cso157548091cf.1
        for <iommu@lists.linux.dev>; Wed, 22 Apr 2026 11:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776883943; x=1777488743; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wotz04H8l5tgEEsb1NU3qjTk74Z9j+pDdwYuMESGV4w=;
        b=YLI9g+CXW3u6/f/mu6DpOQEVn/hobRggltlBr3+TSPuxJcgeo8YzvzOcfeslmpPqLD
         x4SiF8np+bJl4Uf2Brt47fyRCYNVxD5Ob4jMfPRPwLSEeIfd/qIVcYX/Ga3nZml00fF2
         IWIJe7bemy4jWZbUB4TfHsGWuv3CxqDOfM+ysK76kiqOQVKLb14RTm5WZlD4/B/nn959
         BowKdlKjp8oF6nizv082+HJpaVWQkm60L3SPKhxpxRkjcpyjOywnsEoJtFomWBQ/gq0D
         MiLBfr3s99ve+WbImlunQrsFjwF5rAsCigqHpRUmRcRVzb5nIlmARFv/XaHffn4UEM7O
         8k6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776883943; x=1777488743;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wotz04H8l5tgEEsb1NU3qjTk74Z9j+pDdwYuMESGV4w=;
        b=lewq7GalWyN+ID3VHpScTyh4FqeD4k9kKawZTFahMenkRnCSQ6ETHjq3pfAN1dsfqJ
         rqT8RtB1HgWhx/xB86GWi1Jj9YMpBqRc75zV0vBaXzILvlIu3daAYLIvaYAI5rFClVHU
         kO4Ih2WRz4GyK22X2bRQmpi+oJhNkHkxjfrlTUkSnR6ImtalI1Ng2Obhx2zi+N2uM9Hc
         j4X/QbqeohLIKclS4yb1UhPua3JUhWQFfryWM/1vBmjelvpJFwUXVAN+igI5Eetf8JFG
         jQwfSfVZvzbGEgy10Eo8ogaiILA9JW8YrCe63KdjdbdtxDDQhxxSyYZ4j42A9ELutz65
         FZmg==
X-Forwarded-Encrypted: i=1; AFNElJ/o0r9i9xrCkBh8UfFohPL4J9y/QYP1mnJrfC7J832NdwX/CS3MTxzugtvl0N//GwMIcYcuhA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw9u4v3hPl6dxgJQJtQ6+RGmThVhYmK7Z2Bm+9lOi76xri2lcvr
	5IWEXqqoO8ueGw7qvgYyvnhYjaiQ1Vi9lK9CV/qomy3D9J89jCdBILVkefBpi+zAqdkA7bmDdPP
	FdPWMPZOod83dPifbQ/OnBqgcLgm9RNdj28IvYF40IBaOdouL6AGFufLAIw==
X-Gm-Gg: AeBDietPA9q097d8sdfSjlvD6JG00OIKnQSgVRQQC/VapD/Z3PZgQSoM38Q5E4E1Olx
	C6R/QRJHB5i+AMfrk64arBU6rkCj8vnJTWxyhGcCsiAGiGF+YLAdmzAeaffduUPNeLr5uWg/Np/
	EcJ3/Z4mlMkE4/chZ+iG1zn7V404s7PVaAZmCpFQ/Lh4DcfzKWiEvLmfnuaoZXPLQv2Z6r2T+9v
	dIBsgvSpcIqq6BiY6XDXlKS4o7ZHUWcOHHSnR9YrbmQ6Wl1VEAvpk9pjfMatE85uIiqZ8e5GZw/
	lDjeUfRRC0S0KRRx8+lIHQGIukyOL6aZ7SB6cIeKNu7BtBKmNyarHoaDpBlhLsF4oWfsg9CGoJU
	E4IEjJzDuqIKuWKLEhaiNpEsHmAeFOYpJyzALAJdbu1L5mryRYv6K34Ra5qqknO7GY0GufnimRN
	huLaa9nVMDgud9WbnetzRiSRdvFG+daNgDRyMI3Xt4gX9faw==
X-Received: by 2002:ac8:5749:0:b0:50f:c36a:3828 with SMTP id d75a77b69052e-50fc36a3c77mr44950681cf.58.1776883942665;
        Wed, 22 Apr 2026 11:52:22 -0700 (PDT)
X-Received: by 2002:ac8:5749:0:b0:50f:c36a:3828 with SMTP id d75a77b69052e-50fc36a3c77mr44950111cf.58.1776883942194;
        Wed, 22 Apr 2026 11:52:22 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a4187e7dfesm4584470e87.71.2026.04.22.11.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 11:52:21 -0700 (PDT)
Date: Wed, 22 Apr 2026 21:52:19 +0300
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
Message-ID: <cdhqirgdwr6mfwqlhyq7apem4tfuu45adejqg5hse5bvte3vqe@i4uoqa5rpfv2>
References: <20260414-computebus-v1-0-4d904d40926a@oss.qualcomm.com>
 <20260414-computebus-v1-3-4d904d40926a@oss.qualcomm.com>
 <cc90c55d-c93a-2789-f313-aaa5e4090be2@oss.qualcomm.com>
 <r25ibbsw3flfashrp4x2cqy6thckgez5k3gtfqp46dcpbjniev@s4ngoa46ekvj>
 <077a99c2-c954-c5e6-3699-cd0360e8b9f6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <077a99c2-c954-c5e6-3699-cd0360e8b9f6@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: q3Lumvfbmus9A9r5-7lCh2DfFxm1M6_L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDE4MyBTYWx0ZWRfX/124e5Gu1M7d
 otJIND/ndLVRUlpB/uk1DG7K9cfIJ0LrGLr7ADAG/w2Gdoa0mrk69yUeDHe3zoVPafY2glfmC8x
 4DLP8jvxGuMAptdAmGxEUpFUDGsbWdo9of+6Ys37gGkcB/j/GXQxWJKkRnMMxyYixzhdd4zsKvQ
 Vf4jMIu+MevI61N/w+7PtZ4FK+GGhnfVk81yEX9I5zt8Fdly0MdY8me8LBF3Xz75ftf8+RO4ZCz
 3QXNQgOMkHy6L3ZkIIjEWoFAeTtWwppNhh0tL1PJyoZ/hKNNGfapwnyYf3lc6U1/DoGY5uhNyqc
 d97Pkbw1HHErhYvnMPDGENuxGxt/LITS2AQSHQbLSQ3LMZ/MCj0guXuJxBHO4ElnzSXmWDynjqv
 pw50oJw5o0rKXgpgmybRQgRh3WYxNdp9HQbcNyog9M4cRbKwmST5FwyJ+0hPaEEcIF/Zlgu96GL
 TFMBZk11dSU4WpwnwZg==
X-Authority-Analysis: v=2.4 cv=PsOjqQM3 c=1 sm=1 tr=0 ts=69e918e7 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=Dnkel8P2kxSv_apQI-kA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: q3Lumvfbmus9A9r5-7lCh2DfFxm1M6_L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604220183

On Wed, Apr 22, 2026 at 12:31:18PM +0530, Vishnu Reddy wrote:
> 
> On 4/19/2026 5:46 AM, Dmitry Baryshkov wrote:
> > On Wed, Apr 15, 2026 at 09:35:47PM +0530, Vishnu Reddy wrote:
> >>
> >> On 4/14/2026 10:01 PM, Ekansh Gupta wrote:
> >>> Replace the platform driver approach for compute bank (CB) devices
> >>> with the generic context_device_bus_type. Compute bank devices are
> >>> synthetic IOMMU context banks, not real platform devices, so using
> >>> the context device bus provides a more accurate representation in
> >>> the device model.
> >>>
> >>> Currently, fastrpc used of_platform_populate() to create platform
> >>> devices for each "qcom,fastrpc-compute-cb" DT node, with a platform
> >>> driver (fastrpc_cb_driver) to handle probe/remove. This approach
> >>> had a race condition: device nodes were created before channel
> >>> resources (like spin_lock) were initialized, and probe was async,
> >>> so applications could open the device before sessions were available.
> >>>
> >>> This patch addresses the race by manually creating and configuring
> >>> CB devices synchronously during fastrpc_rpmsg_probe(), after all
> >>> channel resources are initialized. The approach follows the pattern
> >>> used in host1x_memory_context_list_init().
> >>>
> >>> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> >>> ---
> >>>   drivers/misc/Kconfig   |   1 +
> >>>   drivers/misc/fastrpc.c | 180 ++++++++++++++++++++++++++++++++++---------------
> >>>   2 files changed, 125 insertions(+), 56 deletions(-)
> >>>
> >>>   	}
> >>>   	dma_bits = cctx->soc_data->dma_addr_bits_default;
> >>> +	if (cctx->domain_id == CDSP_DOMAIN_ID)
> >>> +		dma_bits = cctx->soc_data->dma_addr_bits_cdsp;
> >>> +
> >>>   	sess = &cctx->session[cctx->sesscount++];
> >>>   	sess->used = false;
> >>>   	sess->valid = true;
> >>> -	sess->dev = dev;
> >>> -	dev_set_drvdata(dev, sess);
> >>> +	sess->sid = sid;
> >>> +	spin_unlock_irqrestore(&cctx->lock, flags);
> >>> -	if (cctx->domain_id == CDSP_DOMAIN_ID)
> >>> -		dma_bits = cctx->soc_data->dma_addr_bits_cdsp;
> >>> +	cb_dev = kzalloc_obj(*cb_dev);
> >>> +	if (!cb_dev)
> >>> +		return -ENOMEM;
> >>> -	if (of_property_read_u32(dev->of_node, "reg", &sess->sid))
> >>> -		dev_info(dev, "FastRPC Session ID not specified in DT\n");
> >>> +	cb_dev->sess = sess;
> >>> -	if (sessions > 0) {
> >>> -		struct fastrpc_session_ctx *dup_sess;
> >>> +	device_initialize(&cb_dev->dev);
> >>> +	cb_dev->dev.parent = parent;
> >>> +	cb_dev->dev.bus = &context_device_bus_type;
> >>> +	cb_dev->dev.release = fastrpc_cb_dev_release;
> >>> +	cb_dev->dev.of_node = of_node_get(cb_node);
> >>> +	cb_dev->dev.dma_mask = &cb_dev->dev.coherent_dma_mask;
> >>> +	cb_dev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
> >>> +	dev_set_name(&cb_dev->dev, "%s:compute-cb@%u", dev_name(parent), sid);
> >>> +	rc = device_add(&cb_dev->dev);
> >> device_initialize() and device_add() can be replaced with single
> >> device_register() call. You can refer the below patch,
> > Keep in mind that for several arches device_initialize() sets the
> > coherent_dma_mask. So one should set coherent_dma_mask (as it's done
> > here) after calling device_initialize().
> 
> I can see that device_initialize() sets dma_coherent flag for several arches,
> not the coherent_dma_mask. The final dma_coherent flag value is updated later
> in of_dma_configure_id() based on the dt dma-coherent property.
> 
> Setting the coherent_dma_mask here and calling device_register() which will
> call the device_initialize() won't change the coherent_dma_mask value.
> Please correct me if I'm wrong?

I should get better glasses. I agree with you here.

> 
> >> https://lore.kernel.org/all/20260313-kaanapali-iris-v3-4-9c0d1a67af4b@oss.qualcomm.com/
> >>

-- 
With best wishes
Dmitry
