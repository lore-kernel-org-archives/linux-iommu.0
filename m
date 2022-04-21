Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DDB1C433EF
	for <iommu@archiver.kernel.org>; Thu, 21 Apr 2022 17:13:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E463240519;
	Thu, 21 Apr 2022 17:13:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0JwquEJuwiVm; Thu, 21 Apr 2022 17:13:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id AD09A409E7;
	Thu, 21 Apr 2022 17:13:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4A834C0033;
	Thu, 21 Apr 2022 17:13:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B9BF3C002C
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 17:13:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AEC1A60DCA
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 17:13:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id czI-GgaW7iWD for <iommu@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 17:13:13 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 45A8C60BB1
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 17:13:13 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 o20-20020a05600c511400b0038ebbbb2ad8so3873995wms.0
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 10:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=t9kx/kpBHIRHJF5Ta8VXVNIlkSe6PaiEDU5Ov3KqXBk=;
 b=d4B1RMfWECwtoWYYvT65Wgr5vxqjzt3ftXOaVgpq7ZkpLJIMv0UX/vF5PcCtGMmZ96
 Lcmrvhpwa17FjzkPXncVded4mGmRbYdXqGaXsML0hbLT98CzeRdb1Jg0S0Y/MaIWotdI
 AVO04YOupaanZC6EHBfjicyIUkBiqJndp+kD+UpxCm0JOuRKTSAMNHnf9hNgQmJ8ZIyS
 e1RCUqAVs0FBpVBuYTWkKcaVHk/SDcx7+d3Yy8vxy8/3+W2XFOoq3Jd+vLL8azyINu+y
 qnRxplo6Gb1esD+Gjpibu1LoahVr4bqdAMgUt9gBi1HK9CsGaSDfPRdob0gxUtf1Q08h
 85Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=t9kx/kpBHIRHJF5Ta8VXVNIlkSe6PaiEDU5Ov3KqXBk=;
 b=hRhQb6Qb0SoqIzhHFyr4wz5qGjaKbPasvgoMyXxxqVjCzgKKcsPVECEYWTWdYT6drB
 sQZRGCrcd6Ar2G6s9izKKcZ+/usX7iU2ePx+3Gvb8rne5qJa+HR/n6OI+2VidL+qTvAI
 rZbXXfifRXGzye3BP+sS4A8etqv/TMHDYWvayDNdEDUiSF0sdyo8WvJJS9SrPgaSef9g
 SBcwuHPSHm3cObaSRC8Vcnr4e/Yh+L4TNNyjOvbwIPH/ZWjU1Nul3JeWN3Gns9Q2RVD1
 uxGo+t9F/B7jhX/dkYrJcfWJXfrrKSsvvPJ/YQJ3/yHgYL1x0Q21qquy/hAQaVlZ5cKO
 +f4A==
X-Gm-Message-State: AOAM531t265qNjhq+px167LD5xki2oUxnyFsnJkZavI1Jr5pYTmAhPSX
 ni73iZC63osFDnh8LQBImKEI4Q==
X-Google-Smtp-Source: ABdhPJx94l//WJnxf1x9I9ICVu3B7WTWZyYnYQFGGftuQa3e2LPt/atN6vGk0psS2bdMi48D2aYoIg==
X-Received: by 2002:a05:600c:19cd:b0:392:1419:9d2 with SMTP id
 u13-20020a05600c19cd00b00392141909d2mr9673336wmq.64.1650561191512; 
 Thu, 21 Apr 2022 10:13:11 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168]) by smtp.gmail.com with ESMTPSA id
 b11-20020a5d45cb000000b0020a810f7726sm2674852wrs.5.2022.04.21.10.13.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Apr 2022 10:13:10 -0700 (PDT)
Date: Thu, 21 Apr 2022 18:12:45 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 12/13] iommu/virtio: Clean up bus_set_iommu()
Message-ID: <YmGQjYZMtaqSf87a@myrica>
References: <cover.1649935679.git.robin.murphy@arm.com>
 <4db34a35e07f3741a658465045b78c96a569c591.1649935679.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4db34a35e07f3741a658465045b78c96a569c591.1649935679.git.robin.murphy@arm.com>
Cc: zhang.lyra@gmail.com, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, thierry.reding@gmail.com,
 linux-arm-kernel@lists.infradead.org, gerald.schaefer@linux.ibm.com,
 will@kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Thu, Apr 14, 2022 at 01:42:41PM +0100, Robin Murphy wrote:
> Stop calling bus_set_iommu() since it's now unnecessary, and simplify
> the probe failure path accordingly.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/virtio-iommu.c | 24 ------------------------
>  1 file changed, 24 deletions(-)
> 
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 25be4b822aa0..371f8657c0ce 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -7,7 +7,6 @@
>  
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
> -#include <linux/amba/bus.h>
>  #include <linux/delay.h>
>  #include <linux/dma-iommu.h>
>  #include <linux/dma-map-ops.h>

<linux/platform_device.h> isn't needed anymore either. In any case it
looks great, thanks

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

and tested on QEMU (so only PCI for now)


> @@ -1146,26 +1145,6 @@ static int viommu_probe(struct virtio_device *vdev)
>  
>  	iommu_device_register(&viommu->iommu, &viommu_ops, parent_dev);
>  
> -#ifdef CONFIG_PCI
> -	if (pci_bus_type.iommu_ops != &viommu_ops) {
> -		ret = bus_set_iommu(&pci_bus_type, &viommu_ops);
> -		if (ret)
> -			goto err_unregister;
> -	}
> -#endif
> -#ifdef CONFIG_ARM_AMBA
> -	if (amba_bustype.iommu_ops != &viommu_ops) {
> -		ret = bus_set_iommu(&amba_bustype, &viommu_ops);
> -		if (ret)
> -			goto err_unregister;
> -	}
> -#endif
> -	if (platform_bus_type.iommu_ops != &viommu_ops) {
> -		ret = bus_set_iommu(&platform_bus_type, &viommu_ops);
> -		if (ret)
> -			goto err_unregister;
> -	}
> -
>  	vdev->priv = viommu;
>  
>  	dev_info(dev, "input address: %u bits\n",
> @@ -1174,9 +1153,6 @@ static int viommu_probe(struct virtio_device *vdev)
>  
>  	return 0;
>  
> -err_unregister:
> -	iommu_device_sysfs_remove(&viommu->iommu);
> -	iommu_device_unregister(&viommu->iommu);
>  err_free_vqs:
>  	vdev->config->del_vqs(vdev);
>  
> -- 
> 2.28.0.dirty
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
