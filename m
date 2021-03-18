Return-Path: <SRS0=56b4=IQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB9CAC433DB
	for <iommu@archiver.kernel.org>; Thu, 18 Mar 2021 18:28:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C18364F1F
	for <iommu@archiver.kernel.org>; Thu, 18 Mar 2021 18:28:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C18364F1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B6CF960605;
	Thu, 18 Mar 2021 18:28:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aE-yNrBWb4kw; Thu, 18 Mar 2021 18:28:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9FE09606D8;
	Thu, 18 Mar 2021 18:28:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 65A00C000C;
	Thu, 18 Mar 2021 18:28:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 47E1BC0001
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 18:28:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 25E3C8429A
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 18:28:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GovskvisnCI6 for <iommu@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 18:28:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 748808428F
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 18:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1616092089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tnHnMyJqosN4g4HqZoYksr2OdNUO3XXErmR0Dj0ujns=;
 b=OdDrUtOAV+9YYzdDbaB+r1l7UC57E8R27wPY8zv3fNuCKBBvbE3HVA9f9+udATHYH0JHuj
 1dAuKB3vG3WXCKcCtT0G8Ao3Ikcq4dnb6CEMN87rObkdqoy2K+VH6+jwO0xA7HmI3ymNyc
 hELCLsy3uaVmE2f3g3ArNm4fpo5vWqw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-OZNXU_QMO1OGAWfmSn8Xgw-1; Thu, 18 Mar 2021 14:28:07 -0400
X-MC-Unique: OZNXU_QMO1OGAWfmSn8Xgw-1
Received: by mail-wr1-f69.google.com with SMTP id m9so20543087wrx.6
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 11:28:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=tnHnMyJqosN4g4HqZoYksr2OdNUO3XXErmR0Dj0ujns=;
 b=cqB3yAOdE59HCRLVFlOonxDr7p+vj8LkksKoiqGo5ET3PUB+IgsXWNJFFmQnolTDRN
 KCVSnonpxehaur+PzZN2Bvi9eas5aTUSJJJ3I+eICwK2iRTl7KaZ+wEioiSh/z22AsQ3
 X67JRvDrmMD1ZGaKQUPCeTbsNIee5diAnViLLhSoJa6grre0Jiu77EZOKKwm12sQCQmv
 f61MUtKWcIuzDgZpPPu909PRFRcF0X0rfkBsjBQK/9uiFGxNr3FDhihKyX2mq1l190bq
 8xxWiAl5qwRGvz+sHGZgWYceoVPSEvPIW/EK4OWamEt9uNtycwV0xpQ37VfWG1Zeedki
 TPGw==
X-Gm-Message-State: AOAM5327fylYM29c/GTXB1IRBShcoCKTBIFjMt/oKc4fWK3y1vd8lnuz
 fiXny0IsRrYW3wYSqdSs4ZtAeTl2DJjnHxNSJQEtL/xxF+cy87HZTuXzA2hH02lLpbyFioE4gyj
 4nqRjLYFbavg6rxjGBOzc60pGpU5dVw==
X-Received: by 2002:a1c:4e07:: with SMTP id g7mr445905wmh.29.1616092086286;
 Thu, 18 Mar 2021 11:28:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzAhfnko6xreV0Aev/lGLY50U+s9V+kNR5evCF+1y99zRAKKI8v26JTFwGZ8CX5kgIkHS1h+g==
X-Received: by 2002:a1c:4e07:: with SMTP id g7mr445882wmh.29.1616092086000;
 Thu, 18 Mar 2021 11:28:06 -0700 (PDT)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
 by smtp.gmail.com with ESMTPSA id z7sm4007814wrt.70.2021.03.18.11.28.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Mar 2021 11:28:05 -0700 (PDT)
Date: Thu, 18 Mar 2021 14:28:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH 3/3] iommu/virtio: Enable x86 support
Message-ID: <20210318142709-mutt-send-email-mst@kernel.org>
References: <20210316191652.3401335-1-jean-philippe@linaro.org>
 <20210316191652.3401335-4-jean-philippe@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20210316191652.3401335-4-jean-philippe@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kevin.tian@intel.com, robin.murphy@arm.com, rjw@rjwysocki.net,
 virtualization@lists.linux-foundation.org, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org, sebastien.boeuf@intel.com, will@kernel.org,
 lenb@kernel.org
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

On Tue, Mar 16, 2021 at 08:16:54PM +0100, Jean-Philippe Brucker wrote:
> With the VIOT support in place, x86 platforms can now use the
> virtio-iommu.
> 
> The arm64 Kconfig selects IOMMU_DMA, while x86 IOMMU drivers select it
> themselves.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/iommu/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 2819b5c8ec30..ccca83ef2f06 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -400,8 +400,9 @@ config HYPERV_IOMMU
>  config VIRTIO_IOMMU
>  	tristate "Virtio IOMMU driver"
>  	depends on VIRTIO
> -	depends on ARM64
> +	depends on (ARM64 || X86)
>  	select IOMMU_API
> +	select IOMMU_DMA if X86

Would it hurt to just select unconditionally? Seems a bit cleaner
...

>  	select INTERVAL_TREE
>  	select ACPI_VIOT if ACPI
>  	help
> -- 
> 2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
