Return-Path: <SRS0=wlUX=KJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E7BC433B4
	for <iommu@archiver.kernel.org>; Fri, 14 May 2021 12:34:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1797613E9
	for <iommu@archiver.kernel.org>; Fri, 14 May 2021 12:34:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1797613E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6250E60AE1;
	Fri, 14 May 2021 12:34:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lceLr3nm1P9c; Fri, 14 May 2021 12:34:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2159760ACB;
	Fri, 14 May 2021 12:34:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 089BDC000E;
	Fri, 14 May 2021 12:34:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 90D08C0001
 for <iommu@lists.linux-foundation.org>; Fri, 14 May 2021 12:34:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 716AD8339C
 for <iommu@lists.linux-foundation.org>; Fri, 14 May 2021 12:34:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oVCFRBgoR91A for <iommu@lists.linux-foundation.org>;
 Fri, 14 May 2021 12:34:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B0B2A831F8
 for <iommu@lists.linux-foundation.org>; Fri, 14 May 2021 12:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620995662;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yBw7gIpngSLTMJRgkqlTDn2EW5sfHupDmKkTQSBDQu8=;
 b=MHCYOJELwyyQYR8uLpNmdjOAmo2hX0Xl+ldVvIrWRE4eJCOnnsAsrTjrn65uMAd2JEvpPW
 wYpLUjXblOJlEcjtGfpnQvei8UJTuws0g4qEDSexZcS7JkQABGlTmQXHNeY8yoA9LYIg5z
 d7DNYgPctPscp5YoidXgk3OE5uVNldg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-aa5qm0xZM9KyZcCItUw7QA-1; Fri, 14 May 2021 08:34:19 -0400
X-MC-Unique: aa5qm0xZM9KyZcCItUw7QA-1
Received: by mail-wr1-f71.google.com with SMTP id
 67-20020adf81490000b029010756d109e6so12566337wrm.13
 for <iommu@lists.linux-foundation.org>; Fri, 14 May 2021 05:34:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=yBw7gIpngSLTMJRgkqlTDn2EW5sfHupDmKkTQSBDQu8=;
 b=qNbuM8LEX+XU8KicB3ekMnRgr2l/iIebro1U6gCwiIv4fhfTLvRG/X9t5ssSPTZcS9
 nUTvmqsRHnhpzm3HmiioecAG4U/LnM1qRw/E/7ETzANDSSQBXwN4ld5EWds9Bd3byPX4
 lUrLafyEA4SHGFgWYpb2hqPm3VSbLMH8trWV0+KGOsUlJX6+l2I20mIMM5/5RiNdHIiy
 B/hkQa7zFJGaZZJX2io8U9ESKIyTMGken5fIYbxoJeML/6nzLi8FY4sFBFosgPnxaBRb
 ZS7TxKR167mQUC9g36vNgWklub3VisN7Od3WPD5kbKJaeQ+wlwkySZVA8tuV93/xXJ3p
 yI6g==
X-Gm-Message-State: AOAM5323k8ptI+X7KbspT4k5nysoSaacVmAUjMZkM+d0ZMm1t3pCHYCx
 130QsGQV6hs7MStqoYTajgiMag41l3etFWldChA5aqaOl2docNLnPplVTU2heyQB5gwRpN5U6F+
 Kj3PbAEQvEpj0pt/cUOxvZZLUpu5Brg==
X-Received: by 2002:a1c:f30a:: with SMTP id q10mr27822635wmq.138.1620995657885; 
 Fri, 14 May 2021 05:34:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzFPlnSw9Rc/MJc1oJZloOpaijmqBpFKdogoBEFMFg1dOVUteKbEaiQtObG1YSFXWGviULp6Q==
X-Received: by 2002:a1c:f30a:: with SMTP id q10mr27822619wmq.138.1620995657750; 
 Fri, 14 May 2021 05:34:17 -0700 (PDT)
Received: from redhat.com ([2a10:800c:1fa6:0:3809:fe0c:bb87:250e])
 by smtp.gmail.com with ESMTPSA id j13sm7360302wrd.81.2021.05.14.05.34.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 May 2021 05:34:17 -0700 (PDT)
Date: Fri, 14 May 2021 08:34:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v2 6/6] iommu/virtio: Enable x86 support
Message-ID: <20210514083402-mutt-send-email-mst@kernel.org>
References: <20210423113836.3974972-1-jean-philippe@linaro.org>
 <20210423113836.3974972-7-jean-philippe@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20210423113836.3974972-7-jean-philippe@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kevin.tian@intel.com, catalin.marinas@arm.com, sudeep.holla@arm.com,
 rjw@rjwysocki.net, robin.murphy@arm.com,
 virtualization@lists.linux-foundation.org, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org, sebastien.boeuf@intel.com,
 guohanjun@huawei.com, lenb@kernel.org, will@kernel.org, dwmw2@infradead.org,
 linux-arm-kernel@lists.infradead.org
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

On Fri, Apr 23, 2021 at 01:38:37PM +0200, Jean-Philippe Brucker wrote:
> With the VIOT support in place, x86 platforms can now use the
> virtio-iommu.
> 
> Because the other x86 IOMMU drivers aren't yet ready to use the
> acpi_dma_setup() path, x86 doesn't implement arch_setup_dma_ops() at the
> moment. Similarly to Vt-d and AMD IOMMU, call iommu_setup_dma_ops() from
> probe_finalize().
> 
> Acked-by: Joerg Roedel <jroedel@suse.de>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/iommu/Kconfig        | 3 ++-
>  drivers/iommu/dma-iommu.c    | 1 +
>  drivers/iommu/virtio-iommu.c | 8 ++++++++
>  3 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index aff8a4830dd1..07b7c25cbed8 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -400,8 +400,9 @@ config HYPERV_IOMMU
>  config VIRTIO_IOMMU
>  	tristate "Virtio IOMMU driver"
>  	depends on VIRTIO
> -	depends on ARM64
> +	depends on (ARM64 || X86)
>  	select IOMMU_API
> +	select IOMMU_DMA
>  	select INTERVAL_TREE
>  	select ACPI_VIOT if ACPI
>  	help
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 175f8eaeb5b3..46ed43c400cf 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1332,6 +1332,7 @@ void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 dma_limit)
>  	 pr_warn("Failed to set up IOMMU for device %s; retaining platform DMA ops\n",
>  		 dev_name(dev));
>  }
> +EXPORT_SYMBOL_GPL(iommu_setup_dma_ops);
>  
>  static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
>  		phys_addr_t msi_addr, struct iommu_domain *domain)
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 29a397c2d12f..8be546a338e7 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -1027,6 +1027,13 @@ static struct iommu_device *viommu_probe_device(struct device *dev)
>  	return ERR_PTR(ret);
>  }
>  
> +static void viommu_probe_finalize(struct device *dev)
> +{
> +#ifndef CONFIG_ARCH_HAS_SETUP_DMA_OPS
> +	iommu_setup_dma_ops(dev, 0, U64_MAX);
> +#endif
> +}
> +
>  static void viommu_release_device(struct device *dev)
>  {
>  	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> @@ -1063,6 +1070,7 @@ static struct iommu_ops viommu_ops = {
>  	.iova_to_phys		= viommu_iova_to_phys,
>  	.iotlb_sync		= viommu_iotlb_sync,
>  	.probe_device		= viommu_probe_device,
> +	.probe_finalize		= viommu_probe_finalize,
>  	.release_device		= viommu_release_device,
>  	.device_group		= viommu_device_group,
>  	.get_resv_regions	= viommu_get_resv_regions,
> -- 
> 2.31.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
