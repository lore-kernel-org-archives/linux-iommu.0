Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D243E3C67
	for <iommu@lists.linux.dev>; Wed, 15 Apr 2026 16:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776269167; cv=none; b=SWTxXS3K9QUcjwn5MOgRXd9M47Vr9e0LRnEWekCdciYFL7iucpIZmt/Dh+JS7tew70Z+LNKHHOx/YD04YeShAMdZo2HwBEbZIC5lSS4kZkCWi0+3YjlbX0n0OEJaPJoUiatESqqA32UGyWahFHRHghdPIu9A9yxUGXegvvDTdkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776269167; c=relaxed/simple;
	bh=aTZGaS3RCzhxhdYXeo0xMF9Um6LGF2ryflC+g+vfgHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l33CflNsb8EVfFdibM2Cj/MIF53FD9gwrQJv5ClWlYysxwbRp+DAYcdGlXX2BcllMo/GddEyL6+GnESga/xsRdlCJzURLa3Xff68CTjrhXsXXvHzHUvYHYQP1cUwVUkMFQ7rc1MaCztcMmuLGcjksX8qyGd8AYRe71+N3MKfsXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W2sBM/VG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Wkg7M9YA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W2sBM/VG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Wkg7M9YA"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63FC4iTa2772631
	for <iommu@lists.linux.dev>; Wed, 15 Apr 2026 16:05:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tQW0eEGW+Vs3+ziZBjvpnZbzVVRN9l8GWBiHRdZSINg=; b=W2sBM/VGNBFbzByu
	naOwg9ccStAEP15ZPidH60Q4Pk9z0KCJGQKvFy7h37+jvHsFHXgbelh8kxf1SEYM
	gkaSCCHccl4NU2H+QPjQBWThh76yDJIlSgSmaqS8SZGTSqGbr1Bbkg6zIhXxWCqn
	ynJ0RueGvCWojQwqoUoA3UpYz9I6Ei8AGJ16B5ueB0tyApaag65X3F7POmFGS7os
	Abqm1a3e9LvE7/wTT7tcS8elfm6bsZ3zHVv415Vi5iMSyE2Gz2TA3ilh4svcf+uM
	g94m/Nb320I3JQSDWjnzX83pJt6Z6TEbCyICgKqhVAh0hVWY/euVpMznqpQpLu0f
	2FVbXw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dj50v26wm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 15 Apr 2026 16:05:58 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-82f0e12d375so3058158b3a.1
        for <iommu@lists.linux.dev>; Wed, 15 Apr 2026 09:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776269158; x=1776873958; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tQW0eEGW+Vs3+ziZBjvpnZbzVVRN9l8GWBiHRdZSINg=;
        b=Wkg7M9YAOzsOonN4P56+QT/yYE91xw2Wl5ox8P5lphpzSvLaIrrVe3TjUvdaHS1VT2
         /5X4u2QPhclBJGIZmkfrJ7clfuz6PtiFk+mAmycoL6FO+xRQ61FnWeWpiEsl2oPYPQYy
         DZxyrCNka8foaqQmT0pCp23ZeK8FH86xGk5BJ+Nbxqc8hr099faT629nSafyYwkPq11z
         vbPSn07E2vbRA/fiKoaa20cVgJKdzonWJc7pxDCI9sXsrWV3+eGvw90QqNfhV3oCzhLk
         fWD4rKHCrGu5IE3WgZwr1jR/R71TKsJ2qfltU9275SRjXWhTO4xSuK9SUjHhgfQvh/Pg
         XT7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776269158; x=1776873958;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tQW0eEGW+Vs3+ziZBjvpnZbzVVRN9l8GWBiHRdZSINg=;
        b=pGS2+umH02UcWDJ0YKlJizkkucFLi0skwpjQnzwzXddUYIPhA1tAHrjCLEjcfVlzGz
         XNuVnwgTjZuEofQLCnaT1x+vopT+Au6xWU0idapRzjaWerup2y4SpdnGl3BU5WOePtlq
         QCw/VTvfdDFQxcjrrlOtSg12RCJlcmX3Ea4nYJHxN4S/EkxLn3PGwnaHurJjK0TfOfF0
         KjTc+A+TD5rLjVr9fFvnKY1byQQ6a5W8fNKVp1GKh1ABeip9uetuQDgAVrLg7zBKuATt
         jAn5chsh9hLZGRdWRdg5Qed/FzwDwQ8NgRvtAChK+B4MQ3beIhjMcRM4WyuzLpJIXcLD
         7LBQ==
X-Forwarded-Encrypted: i=1; AFNElJ9lAPuj8D4gnEQJ6Uqvc/L6K7Zgv0G7Ng+xhQV4TarRJSQGDsYST0wuv45LYTSPLXQy3f16dw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzfFENLE+Xv6QuAoG0Je9Jp/UloDOULgOApCxbhBTeCDG0DnrtD
	dmWEjtFgVPtmWAbLJRbY43uBH1rEpTbL3YGrkxziFNlxfSaonljyd44o0RqzvunPHUiuzvogHSA
	mjsctkCEXVbgfWLQs4ekv4A1h6tAgPvpPTJJIux8EsVToXEA9rhtIRUZPng==
X-Gm-Gg: AeBDiesT2DCyfo8y8CHLlbnG+oXw9QH8GMC1ok6DZFtPUcF+G8IjVXyxO3e8rswiqfj
	lUsCbGuWkHDpwOPV3dlk1ORZuQVp48+Npp6cs2yOpcIL4qVjJD0uIp45fO15y4SHAVUhJxhPKku
	EH93Dz9q9Heubb7/THQHXAL4pge7+BgsEgp3Sa10JjMgMDCGXONKbxPfcWsL/Ka56yPKrOJLkdy
	pmQufKU5XnCKb0cDkXxZ/+H+f5dyUWBoPjJA1lie3GeI3Ql3o9pUG0nIjSpCmCpKy3KFVJ7Khnh
	oO41p1U+uP3dV8zi0jHXudSTeOmKnaOQTFEoH2mQA9dbeYBu3fBEshHhZnK7o0A637KnB+LQo5i
	EvQRIN3viSS/ZSr5UmLQuTwZOWByutvk4tqCwDPZvBBOfBu35mrx04g==
X-Received: by 2002:a05:6a00:300c:b0:82c:7767:5bb2 with SMTP id d2e1a72fcca58-82f0c27b21amr19942937b3a.21.1776269157533;
        Wed, 15 Apr 2026 09:05:57 -0700 (PDT)
X-Received: by 2002:a05:6a00:300c:b0:82c:7767:5bb2 with SMTP id d2e1a72fcca58-82f0c27b21amr19942895b3a.21.1776269156847;
        Wed, 15 Apr 2026 09:05:56 -0700 (PDT)
Received: from [10.206.105.200] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f67476a5fsm2550003b3a.60.2026.04.15.09.05.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2026 09:05:56 -0700 (PDT)
Message-ID: <cc90c55d-c93a-2789-f313-aaa5e4090be2@oss.qualcomm.com>
Date: Wed, 15 Apr 2026 21:35:47 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 3/3] misc: fastrpc: Use context device bus for compute
 banks
Content-Language: en-US
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Thierry Reding <thierry.reding@kernel.org>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Arnd Bergmann <arnd@arndb.de>,
        Srinivas Kandagatla <srini@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bharath Kumar <quic_bkumar@quicinc.com>,
        Chenna Kesava Raju <quic_chennak@quicinc.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org
References: <20260414-computebus-v1-0-4d904d40926a@oss.qualcomm.com>
 <20260414-computebus-v1-3-4d904d40926a@oss.qualcomm.com>
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
In-Reply-To: <20260414-computebus-v1-3-4d904d40926a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 2DeFHii0gPazl5XcPIzhk8LRbzOHh2Vg
X-Authority-Analysis: v=2.4 cv=eLMjSnp1 c=1 sm=1 tr=0 ts=69dfb766 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=7CQSdrXTAAAA:8 a=eP6CfP3hHy5NNNlF4cwA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDE1MCBTYWx0ZWRfXwY+/0v6RzHFS
 P770Xv+DXEm+IwhCmkyP3ISf0tqh+zcpCUb7fDkv6jShQJvMC0ZojmPNT5Ynv7bj5aTdhQtNoCY
 XXfnzxzqTOZcVny8bBwlM7tPp9yNTPrRXdkFT8nPIk8VXnb2WCAFHaFMHJVSBzuw/6ntOpmuRvW
 zz6t3m5RycyL90LqNjSyQX483hOf0xN67MqLtG3gZEdZiiGr/6dnDdtDzfP8NzJGXlfb1QOqrns
 wQ612htVA6Ad9G2c33bq7cf7v1Y/D+e3Jspr8ZbaUEeTn5bmYLn372vrd92zkBHKp3iqmo/LrVI
 4J6SjB6HubSE/NGqtrj6EkhcxKpBpaCadujMyy5FEPg9sCVXdLjVY+vlgGB+EruHDZxTuEuZ9vi
 itDFCOv9hl2ziZKdOUDG14C2V6qPQ1YwSSz/LmgP7w/pWj9rfaqD3XALf8TySEP1Gx0o4iWKOCD
 LxTX9YTSzOaV1KKsQRA==
X-Proofpoint-ORIG-GUID: 2DeFHii0gPazl5XcPIzhk8LRbzOHh2Vg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-15_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0 impostorscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150150



On 4/14/2026 10:01 PM, Ekansh Gupta wrote:
> Replace the platform driver approach for compute bank (CB) devices
> with the generic context_device_bus_type. Compute bank devices are
> synthetic IOMMU context banks, not real platform devices, so using
> the context device bus provides a more accurate representation in
> the device model.
> 
> Currently, fastrpc used of_platform_populate() to create platform
> devices for each "qcom,fastrpc-compute-cb" DT node, with a platform
> driver (fastrpc_cb_driver) to handle probe/remove. This approach
> had a race condition: device nodes were created before channel
> resources (like spin_lock) were initialized, and probe was async,
> so applications could open the device before sessions were available.
> 
> This patch addresses the race by manually creating and configuring
> CB devices synchronously during fastrpc_rpmsg_probe(), after all
> channel resources are initialized. The approach follows the pattern
> used in host1x_memory_context_list_init().
> 
> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> ---
>   drivers/misc/Kconfig   |   1 +
>   drivers/misc/fastrpc.c | 180 ++++++++++++++++++++++++++++++++++---------------
>   2 files changed, 125 insertions(+), 56 deletions(-)
> 
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 00683bf06258..b501462a4548 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -304,6 +304,7 @@ config QCOM_FASTRPC
>   	depends on RPMSG
>   	select DMA_SHARED_BUFFER
>   	select QCOM_SCM
> +	select CONTEXT_DEVICE_BUS
>   	help
>   	  Provides a communication mechanism that allows for clients to
>   	  make remote method invocations across processor boundary to
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 1080f9acf70a..f66fd3eea5fa 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -13,9 +13,9 @@
>   #include <linux/module.h>
>   #include <linux/of_address.h>
>   #include <linux/of.h>
> -#include <linux/platform_device.h>
> +#include <linux/of_device.h>
>   #include <linux/sort.h>
> -#include <linux/of_platform.h>
> +#include <linux/context_bus.h>
>   #include <linux/rpmsg.h>
>   #include <linux/scatterlist.h>
>   #include <linux/slab.h>
> @@ -250,6 +250,18 @@ struct fastrpc_invoke_ctx {
>   	struct fastrpc_channel_ctx *cctx;
>   };
>   
> +/**
> + * struct fastrpc_cb_device - Compute bank device wrapper
> + * @dev: Device structure
> + * @sess: Back-pointer to the session context
> + */
> +struct fastrpc_cb_device {
> +	struct device dev;
> +	struct fastrpc_session_ctx *sess;
> +};
> +
> +#define to_fastrpc_cb_device(d) container_of(d, struct fastrpc_cb_device, dev)
> +
>   struct fastrpc_session_ctx {
>   	struct device *dev;
>   	int sid;
> @@ -2190,92 +2202,156 @@ static const struct file_operations fastrpc_fops = {
>   	.compat_ioctl = fastrpc_device_ioctl,
>   };
>   
> -static int fastrpc_cb_probe(struct platform_device *pdev)
> +static void fastrpc_cb_dev_release(struct device *dev)
> +{
> +	struct fastrpc_cb_device *cb_dev = to_fastrpc_cb_device(dev);
> +
> +	of_node_put(dev->of_node);
> +	kfree(cb_dev);
> +}
> +
> +static int fastrpc_create_cb_device(struct fastrpc_channel_ctx *cctx,
> +				    struct device *parent,
> +				    struct device_node *cb_node)
>   {
> -	struct fastrpc_channel_ctx *cctx;
>   	struct fastrpc_session_ctx *sess;
> -	struct device *dev = &pdev->dev;
> -	int i, sessions = 0;
> +	struct fastrpc_cb_device *cb_dev;
>   	unsigned long flags;
> -	int rc;
> -	u32 dma_bits;
> -
> -	cctx = dev_get_drvdata(dev->parent);
> -	if (!cctx)
> -		return -EINVAL;
> +	int i, sessions = 0, rc;
> +	u32 dma_bits, sid = 0;
>   
> -	of_property_read_u32(dev->of_node, "qcom,nsessions", &sessions);
> +	/* Read SID early so it can be used in the device name */
> +	of_property_read_u32(cb_node, "reg", &sid);
> +	of_property_read_u32(cb_node, "qcom,nsessions", &sessions);
>   
>   	spin_lock_irqsave(&cctx->lock, flags);
>   	if (cctx->sesscount >= FASTRPC_MAX_SESSIONS) {
> -		dev_err(&pdev->dev, "too many sessions\n");
> +		dev_err(parent, "too many sessions\n");
>   		spin_unlock_irqrestore(&cctx->lock, flags);
>   		return -ENOSPC;
>   	}
>   	dma_bits = cctx->soc_data->dma_addr_bits_default;
> +	if (cctx->domain_id == CDSP_DOMAIN_ID)
> +		dma_bits = cctx->soc_data->dma_addr_bits_cdsp;
> +
>   	sess = &cctx->session[cctx->sesscount++];
>   	sess->used = false;
>   	sess->valid = true;
> -	sess->dev = dev;
> -	dev_set_drvdata(dev, sess);
> +	sess->sid = sid;
> +	spin_unlock_irqrestore(&cctx->lock, flags);
>   
> -	if (cctx->domain_id == CDSP_DOMAIN_ID)
> -		dma_bits = cctx->soc_data->dma_addr_bits_cdsp;
> +	cb_dev = kzalloc_obj(*cb_dev);
> +	if (!cb_dev)
> +		return -ENOMEM;
>   
> -	if (of_property_read_u32(dev->of_node, "reg", &sess->sid))
> -		dev_info(dev, "FastRPC Session ID not specified in DT\n");
> +	cb_dev->sess = sess;
>   
> -	if (sessions > 0) {
> -		struct fastrpc_session_ctx *dup_sess;
> +	device_initialize(&cb_dev->dev);
> +	cb_dev->dev.parent = parent;
> +	cb_dev->dev.bus = &context_device_bus_type;
> +	cb_dev->dev.release = fastrpc_cb_dev_release;
> +	cb_dev->dev.of_node = of_node_get(cb_node);
> +	cb_dev->dev.dma_mask = &cb_dev->dev.coherent_dma_mask;
> +	cb_dev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
> +	dev_set_name(&cb_dev->dev, "%s:compute-cb@%u", dev_name(parent), sid);
>   
> +	rc = device_add(&cb_dev->dev);

device_initialize() and device_add() can be replaced with single 
device_register() call. You can refer the below patch,

https://lore.kernel.org/all/20260313-kaanapali-iris-v3-4-9c0d1a67af4b@oss.qualcomm.com/

> +	if (rc) {
> +		dev_err(parent, "failed to add CB device: %d\n", rc);
> +		goto err_put;
> +	}
> +
> +	rc = of_dma_configure(&cb_dev->dev, cb_node, true);

Specific dma configuration should be done via .dma_configure callback, 
as suggested by Robin earlier in the discussion,

https://lore.kernel.org/all/02b3d0f5-f94c-43cd-93af-97cfcf7751b1@arm.com/

> +	if (rc) {
> +		dev_err(parent, "of_dma_configure failed for CB device: %d\n", rc);
> +		goto err_del;
> +	}
> +
> +	rc = dma_set_mask(&cb_dev->dev, DMA_BIT_MASK(dma_bits));

Can this be set during device configuration and avoid explict 
dma_set_mask call?

> +	if (rc) {
> +		dev_err(parent, "%u-bit DMA enable failed\n", dma_bits);
> +		goto err_del;
> +	}
> +
> +	sess->dev = &cb_dev->dev;
> +
> +	if (sessions > 0) {
> +		spin_lock_irqsave(&cctx->lock, flags);
>   		for (i = 1; i < sessions; i++) {
> +			struct fastrpc_session_ctx *dup_sess;
> +
>   			if (cctx->sesscount >= FASTRPC_MAX_SESSIONS)
>   				break;
>   			dup_sess = &cctx->session[cctx->sesscount++];
>   			memcpy(dup_sess, sess, sizeof(*dup_sess));
>   		}
> -	}
> -	spin_unlock_irqrestore(&cctx->lock, flags);
> -	rc = dma_set_mask(dev, DMA_BIT_MASK(dma_bits));
> -	if (rc) {
> -		dev_err(dev, "%u-bit DMA enable failed\n", dma_bits);
> -		return rc;
> +		spin_unlock_irqrestore(&cctx->lock, flags);
>   	}
>   
>   	return 0;
> +
> +err_del:
> +	device_del(&cb_dev->dev);
> +err_put:
> +	of_node_put(cb_dev->dev.of_node);
> +	put_device(&cb_dev->dev);
> +	return rc;
>   }
>   
> -static void fastrpc_cb_remove(struct platform_device *pdev)
> +static void fastrpc_depopulate_cb_devices(struct fastrpc_channel_ctx *cctx)
>   {
> -	struct fastrpc_channel_ctx *cctx = dev_get_drvdata(pdev->dev.parent);
> -	struct fastrpc_session_ctx *sess = dev_get_drvdata(&pdev->dev);
>   	unsigned long flags;
> -	int i;
> +	int i, j;
>   
>   	spin_lock_irqsave(&cctx->lock, flags);
>   	for (i = 0; i < FASTRPC_MAX_SESSIONS; i++) {
> -		if (cctx->session[i].sid == sess->sid) {
> +		if (cctx->session[i].valid) {
>   			cctx->session[i].valid = false;
>   			cctx->sesscount--;
>   		}
>   	}
>   	spin_unlock_irqrestore(&cctx->lock, flags);
> +
> +	for (i = 0; i < FASTRPC_MAX_SESSIONS; i++) {
> +		struct device *dev = cctx->session[i].dev;
> +
> +		if (!dev)
> +			continue;
> +
> +		/* Unregister the device once */
> +		device_unregister(dev);
> +
> +		/* Clear this dev pointer from all sessions that share it */
> +		for (j = i; j < FASTRPC_MAX_SESSIONS; j++) {
> +			if (cctx->session[j].dev == dev)
> +				cctx->session[j].dev = NULL;
> +		}
> +	}
>   }
>   
> -static const struct of_device_id fastrpc_match_table[] = {
> -	{ .compatible = "qcom,fastrpc-compute-cb", },
> -	{}
> -};
> +static int fastrpc_populate_cb_devices(struct fastrpc_channel_ctx *cctx,
> +					struct device *parent,
> +					struct device_node *parent_node)
> +{
> +	struct device_node *child;
> +	int ret = 0;
>   
> -static struct platform_driver fastrpc_cb_driver = {
> -	.probe = fastrpc_cb_probe,
> -	.remove = fastrpc_cb_remove,
> -	.driver = {
> -		.name = "qcom,fastrpc-cb",
> -		.of_match_table = fastrpc_match_table,
> -		.suppress_bind_attrs = true,
> -	},
> -};
> +	for_each_child_of_node(parent_node, child) {
> +		if (!of_device_is_compatible(child, "qcom,fastrpc-compute-cb"))
> +			continue;
> +
> +		ret = fastrpc_create_cb_device(cctx, parent, child);
> +		if (ret) {
> +			dev_err(parent, "failed to create CB device for %s: %d\n",
> +				child->name, ret);
> +			of_node_put(child);
> +			fastrpc_depopulate_cb_devices(cctx);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
>   
>   static int fastrpc_device_register(struct device *dev, struct fastrpc_channel_ctx *cctx,
>   				   bool is_secured, const char *domain)
> @@ -2441,7 +2517,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>   	data->domain_id = domain_id;
>   	data->rpdev = rpdev;
>   
> -	err = of_platform_populate(rdev->of_node, NULL, NULL, rdev);
> +	err = fastrpc_populate_cb_devices(data, rdev, rdev->of_node);
>   	if (err)
>   		goto err_deregister_fdev;
>   
> @@ -2496,7 +2572,7 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
>   	if (cctx->remote_heap)
>   		fastrpc_buf_free(cctx->remote_heap);
>   
> -	of_platform_depopulate(&rpdev->dev);
> +	fastrpc_depopulate_cb_devices(cctx);
>   
>   	fastrpc_channel_ctx_put(cctx);
>   }
> @@ -2558,16 +2634,9 @@ static int fastrpc_init(void)
>   {
>   	int ret;
>   
> -	ret = platform_driver_register(&fastrpc_cb_driver);
> -	if (ret < 0) {
> -		pr_err("fastrpc: failed to register cb driver\n");
> -		return ret;
> -	}
> -
>   	ret = register_rpmsg_driver(&fastrpc_driver);
>   	if (ret < 0) {
>   		pr_err("fastrpc: failed to register rpmsg driver\n");
> -		platform_driver_unregister(&fastrpc_cb_driver);
>   		return ret;
>   	}
>   
> @@ -2577,7 +2646,6 @@ module_init(fastrpc_init);
>   
>   static void fastrpc_exit(void)
>   {
> -	platform_driver_unregister(&fastrpc_cb_driver);
>   	unregister_rpmsg_driver(&fastrpc_driver);
>   }
>   module_exit(fastrpc_exit);
> 
