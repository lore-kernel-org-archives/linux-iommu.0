Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95898C433FE
	for <iommu@archiver.kernel.org>; Thu, 12 May 2022 18:21:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F37B960AC1;
	Thu, 12 May 2022 18:21:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1hHeIrBollw3; Thu, 12 May 2022 18:21:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DE0156068A;
	Thu, 12 May 2022 18:21:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B0BC0C0032;
	Thu, 12 May 2022 18:21:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 94F9FC002D
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 18:21:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 760D481020
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 18:21:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tt0qs6ASLPc9 for <iommu@lists.linux-foundation.org>;
 Thu, 12 May 2022 18:21:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 462C180CF2
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 18:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652379684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=liwTgUxqAqwFiu3hiQYmfoukAO/Bb2SxBCCUw8+D2Eo=;
 b=bhlL5R1isy2UX9C6M0W4CsCZX5oDOx2H5y4elZ87gOk++WW1cenuWqRrHzHumLKA7bdlcD
 gvCmxQPhl/JUFdXsBDISsaKunVJiOykA/i9pIewBQYXDbPPz0HlgzDUWxSAFKLKjnK9jSK
 esOXLBz/oq1ZudaXyS9wywGEMCWVrZc=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-668-DlyRgRW1MnOnxHHQAMetzg-1; Thu, 12 May 2022 14:21:23 -0400
X-MC-Unique: DlyRgRW1MnOnxHHQAMetzg-1
Received: by mail-il1-f197.google.com with SMTP id
 j4-20020a92c204000000b002caad37af3fso3732496ilo.22
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 11:21:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:organization:mime-version:content-transfer-encoding;
 bh=liwTgUxqAqwFiu3hiQYmfoukAO/Bb2SxBCCUw8+D2Eo=;
 b=qa/MAO9ZenOR1ZOI2Hm4cubEvNjTnTLM/kXGTiCm8DbAuSpoGYfUJNQ2+balX0y20j
 54Q9LBFjPlZLFDh+NPRVpnBq2ehoxcvUMXImjYrnEm9mV8kf1ybyPTbQLawC2/1ZcCNl
 B06/s3SVIarJxjHsjC5Z+GDwkoXdy/9maRgbpYWX2abXXhtdeaHODQoKj/nKHh6a741Z
 IaPgC5hDvYsJ6vOLJ7kpoc6avlfyqVEZMG2uZdk6Q2UEdI5y8fN42DNRkA2Gm0uM/rx+
 p7GBNE5TO2y1VG+6ziEBB49slepEtyn2qw5BY/t1vNLD6xV2PPzoYONaJLG2dDD37G+j
 kz+Q==
X-Gm-Message-State: AOAM533R7VGq3O8BFbetPMeyat3EgQBZ4dUuiuIxxE66ITFQDe+NQRAw
 uNFq0C18tLgBCaRA0Sn52rEAhI+NVmKVSsBo0+NvOj8ITHxF/2zLYT2t9HSTTw+JbJGUckB6Lxk
 PMamDfmXl43cz2zOy9uGaFEa2UDj37g==
X-Received: by 2002:a05:6e02:2146:b0:2cf:87ae:ddb0 with SMTP id
 d6-20020a056e02214600b002cf87aeddb0mr689793ilv.188.1652379683041; 
 Thu, 12 May 2022 11:21:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxeQb/MQ5kg9HqtwVpVAaSTmnED1ANBhiXTkVXgRWmq7UXDkHZcOFHlURBKM69GaMWdymo+kw==
X-Received: by 2002:a05:6e02:2146:b0:2cf:87ae:ddb0 with SMTP id
 d6-20020a056e02214600b002cf87aeddb0mr689788ilv.188.1652379682840; 
 Thu, 12 May 2022 11:21:22 -0700 (PDT)
Received: from redhat.com ([38.15.36.239]) by smtp.gmail.com with ESMTPSA id
 g18-20020a0566380c5200b0032b3a7817b8sm57930jal.124.2022.05.12.11.21.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 May 2022 11:21:22 -0700 (PDT)
Date: Thu, 12 May 2022 12:21:21 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] vfio: Stop using iommu_present()
Message-ID: <20220512122121.348e5f82.alex.williamson@redhat.com>
In-Reply-To: <537103bbd7246574f37f2c88704d7824a3a889f2.1649160714.git.robin.murphy@arm.com>
References: <537103bbd7246574f37f2c88704d7824a3a889f2.1649160714.git.robin.murphy@arm.com>
Organization: Red Hat
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: iommu@lists.linux-foundation.org, cohuck@redhat.com,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org
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

On Tue,  5 Apr 2022 13:11:54 +0100
Robin Murphy <robin.murphy@arm.com> wrote:

> IOMMU groups have been mandatory for some time now, so a device without
> one is necessarily a device without any usable IOMMU, therefore the
> iommu_present() check is redundant (or at best unhelpful).
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/vfio/vfio.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
> index a4555014bd1e..7b0a7b85e77e 100644
> --- a/drivers/vfio/vfio.c
> +++ b/drivers/vfio/vfio.c
> @@ -745,11 +745,11 @@ static struct vfio_group *vfio_group_find_or_alloc(struct device *dev)
>  
>  	iommu_group = iommu_group_get(dev);
>  #ifdef CONFIG_VFIO_NOIOMMU
> -	if (!iommu_group && noiommu && !iommu_present(dev->bus)) {
> +	if (!iommu_group && noiommu) {
>  		/*
>  		 * With noiommu enabled, create an IOMMU group for devices that
> -		 * don't already have one and don't have an iommu_ops on their
> -		 * bus.  Taint the kernel because we're about to give a DMA
> +		 * don't already have one, implying no IOMMU hardware/driver
> +		 * exists.  Taint the kernel because we're about to give a DMA
>  		 * capable device to a user without IOMMU protection.
>  		 */
>  		group = vfio_noiommu_group_alloc(dev, VFIO_NO_IOMMU);

Applied to vfio next branch for v5.19.  Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
