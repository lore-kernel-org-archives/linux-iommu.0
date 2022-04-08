Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C3C8C433F5
	for <iommu@archiver.kernel.org>; Fri,  8 Apr 2022 15:48:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2EE8E41813;
	Fri,  8 Apr 2022 15:48:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NIvL4UAuRmZp; Fri,  8 Apr 2022 15:48:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E4C1E4186E;
	Fri,  8 Apr 2022 15:48:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CC356C0084;
	Fri,  8 Apr 2022 15:48:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9AAFDC002C
 for <iommu@lists.linux-foundation.org>; Fri,  8 Apr 2022 15:48:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 96BA141994
 for <iommu@lists.linux-foundation.org>; Fri,  8 Apr 2022 15:48:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Mj4-Y7LdE4j0 for <iommu@lists.linux-foundation.org>;
 Fri,  8 Apr 2022 15:48:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 20D764186E
 for <iommu@lists.linux-foundation.org>; Fri,  8 Apr 2022 15:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649432891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z2gRxBOdknfQRB1cfkYgPAkXYqIEl2oL9VEfdnAyBSA=;
 b=Wk3FXkw0TfA5Wt6zlgVb6YMRwhvURhVH2bv6VL9KsTmOMIkeYzyzh6S4xQlno8e+Rv7J1z
 5EjJYGCn4vpl/8fw0dtyvlAsIU10TQrjf3rmdIS8c1CMBVkvlnJki/tD43eRmjd9K1xerH
 +8xd/q7Dq1u139qKLwPkyuzR2fzSBH0=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-170-f4snqPAfNB-lgLecjDghYA-1; Fri, 08 Apr 2022 11:48:10 -0400
X-MC-Unique: f4snqPAfNB-lgLecjDghYA-1
Received: by mail-io1-f69.google.com with SMTP id
 f11-20020a056602070b00b00645d08010fcso5970766iox.15
 for <iommu@lists.linux-foundation.org>; Fri, 08 Apr 2022 08:48:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:organization:mime-version:content-transfer-encoding;
 bh=Z2gRxBOdknfQRB1cfkYgPAkXYqIEl2oL9VEfdnAyBSA=;
 b=2n/SJmhiAaV9K7RVvePN6zBZifuGY4CCWxaZctyb8s8JYUWgpm4ORQPt/IPwxvIt6I
 ZnjUz7CbKp9reP5eY5J4jcmw7RcdjYzMnBjuwUMP3Yyco5s4w/cqebvwROYWHNkdn8Uh
 czvWiqMxvZc4ys9KJ90XehbA+sUyeXGYDZWMwhqhxLnwc2y1oklHJTFZfIuSyI4m8CDi
 mHm0GXAFC9AHYy6lDQ6ZDqjHZgpV0M/SeKNUHDemB2IHtiKoO1CDT2WcUHfsYFOlCaX3
 nm65h4YAVBy795H4xgulzkYDZXbKaPNdRZHf0g7+Veg3xS+uULzRc5DktBeWRd181psO
 sxcg==
X-Gm-Message-State: AOAM531V1pBIct20nyZd/yUf5dyXNvsPasX6C2pwh0myxSIsAWytOh4A
 kQrAvMBzd8rAUYnK2sjx+hW9aK/Hwwmk6Z0Edhsny8X4NhJZKguF2RR9/GfpG/+NPodXEBnawBU
 zC0624YHVJbXDy24WA6nKV8RQqHpHUQ==
X-Received: by 2002:a5d:83d2:0:b0:64c:fbd3:e792 with SMTP id
 u18-20020a5d83d2000000b0064cfbd3e792mr8822814ior.59.1649432889362; 
 Fri, 08 Apr 2022 08:48:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxSsMMZZYBKun0PwziD43XZEzOU56NhBOAs7fTRTG7WAh5PRmK8HA5dCAy3y2jLRWrDmaoiZg==
X-Received: by 2002:a5d:83d2:0:b0:64c:fbd3:e792 with SMTP id
 u18-20020a5d83d2000000b0064cfbd3e792mr8822794ior.59.1649432889160; 
 Fri, 08 Apr 2022 08:48:09 -0700 (PDT)
Received: from redhat.com ([98.55.18.59]) by smtp.gmail.com with ESMTPSA id
 i12-20020a92c94c000000b002ca56c2cf67sm7104166ilq.28.2022.04.08.08.48.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Apr 2022 08:48:08 -0700 (PDT)
Date: Fri, 8 Apr 2022 09:48:07 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v2 4/4] vfio: Require that devices support DMA cache
 coherence
Message-ID: <20220408094807.53f178c5.alex.williamson@redhat.com>
In-Reply-To: <4-v2-f090ae795824+6ad-intel_no_snoop_jgg@nvidia.com>
References: <0-v2-f090ae795824+6ad-intel_no_snoop_jgg@nvidia.com>
 <4-v2-f090ae795824+6ad-intel_no_snoop_jgg@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Tian, Kevin" <kevin.tian@intel.com>, kvm@vger.kernel.org,
 Will Deacon <will@kernel.org>, Cornelia Huck <cohuck@redhat.com>,
 Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org,
 David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@lst.de>
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

On Thu,  7 Apr 2022 12:23:47 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> IOMMU_CACHE means that normal DMAs do not require any additional coherency
> mechanism and is the basic uAPI that VFIO exposes to userspace. For
> instance VFIO applications like DPDK will not work if additional coherency
> operations are required.
> 
> Therefore check IOMMU_CAP_CACHE_COHERENCY like vdpa & usnic do before
> allowing an IOMMU backed VFIO device to be created.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/vfio/vfio.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
> index a4555014bd1e72..9edad767cfdad3 100644
> --- a/drivers/vfio/vfio.c
> +++ b/drivers/vfio/vfio.c
> @@ -815,6 +815,13 @@ static int __vfio_register_dev(struct vfio_device *device,
>  
>  int vfio_register_group_dev(struct vfio_device *device)
>  {
> +	/*
> +	 * VFIO always sets IOMMU_CACHE because we offer no way for userspace to
> +	 * restore cache coherency.
> +	 */
> +	if (!iommu_capable(device->dev->bus, IOMMU_CAP_CACHE_COHERENCY))
> +		return -EINVAL;
> +
>  	return __vfio_register_dev(device,
>  		vfio_group_find_or_alloc(device->dev));
>  }

Acked-by: Alex Williamson <alex.williamson@redhat.com>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
