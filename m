Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2E46C433EF
	for <iommu@archiver.kernel.org>; Mon, 28 Feb 2022 22:06:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 57CA760E66;
	Mon, 28 Feb 2022 22:06:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NaqGgwJ1fqtV; Mon, 28 Feb 2022 22:06:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2C2BA60E5A;
	Mon, 28 Feb 2022 22:06:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0D9C0C0077;
	Mon, 28 Feb 2022 22:06:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C46F3C001A
 for <iommu@lists.linux-foundation.org>; Mon, 28 Feb 2022 22:06:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AC2A060E66
 for <iommu@lists.linux-foundation.org>; Mon, 28 Feb 2022 22:06:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 37cS4oAOXqjQ for <iommu@lists.linux-foundation.org>;
 Mon, 28 Feb 2022 22:06:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0952760E5A
 for <iommu@lists.linux-foundation.org>; Mon, 28 Feb 2022 22:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646085982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6g76Q1f7wfMD5s0Iq9NnNAaHx7TEHAaZl0n65azkoF4=;
 b=H3evcegnpuHA2tFn0WlhRJzlGiAL1tBZEzVjhikGwLSK0tdVSAt4MceNPiYYugyeL8AbvT
 Nl9YAX/WcgJXaR6/pqv9pGJTA5lLyxoIPTtxMhR6fx6bBFz//Mx6OqXLrT/KEOCaozFR9f
 vpKlv5n9RBvMbYSyV9L41AUjdLhNKQY=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-L_PkwpPbNKOkmbBTJ-PF8A-1; Mon, 28 Feb 2022 17:06:19 -0500
X-MC-Unique: L_PkwpPbNKOkmbBTJ-PF8A-1
Received: by mail-oo1-f69.google.com with SMTP id
 t72-20020a4a3e4b000000b0031af9ab8cc6so9362834oot.18
 for <iommu@lists.linux-foundation.org>; Mon, 28 Feb 2022 14:06:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6g76Q1f7wfMD5s0Iq9NnNAaHx7TEHAaZl0n65azkoF4=;
 b=Zwa8cwHxcEl8w5Qoj3mXauNoj1xkw5TaNPI5Pc0eWjssvWLl8/LVVq4hKJCj8Dgzvo
 Xm4i/bIyXwgNo1f+vwHRHwszZra1+bVTy5G33edYygP/2xfJ5A3Fd2vm1u9+nf8u+KY8
 gNCSzCCkfAqbmDYGEt5lrYQ9jbiFUN/YjMXpD6HyGVtu55hHCKfuOgN14KZczX9KrknG
 R7ZyPm0vcrAXRvUcH7tOtst6mWPmGkYBlVyrfUGuHID/A4VXIAHH57d5VAFJq7AArUHh
 NSl5vT8V+6U48LUp7BIE/C5V9w4TUFuJalsj3S7pl/GKpuNo0L1z9kH+O2qXRcKJm5vT
 M5NQ==
X-Gm-Message-State: AOAM53007eQaeHlkfNEGE6Jq2KjJas5P4myK/3hY8zyBraIBzwv+Cm6q
 wyNmLop/f4HxWkLmkMrxjkpBJA7plKSv9DuYhvdsm+H7irGg+FwWKiEkilbVXi1ir+KY64lo4eH
 7MBWm5DcL61OEOQSr/XGDsBEH0RlVag==
X-Received: by 2002:a05:6808:1a28:b0:2d7:3c61:e0d6 with SMTP id
 bk40-20020a0568081a2800b002d73c61e0d6mr12441297oib.32.1646085978581; 
 Mon, 28 Feb 2022 14:06:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyqktaI7nRschXFm6WIqpt/NJToJOLyZXiuWVFpjpKCqY9bZVPBmjxyvo/DJelsgeXDszQizg==
X-Received: by 2002:a05:6808:1a28:b0:2d7:3c61:e0d6 with SMTP id
 bk40-20020a0568081a2800b002d73c61e0d6mr12441258oib.32.1646085978346; 
 Mon, 28 Feb 2022 14:06:18 -0800 (PST)
Received: from redhat.com ([38.15.36.239]) by smtp.gmail.com with ESMTPSA id
 y2-20020a056808130200b002d542a72882sm7034767oiv.3.2022.02.28.14.06.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Feb 2022 14:06:17 -0800 (PST)
Date: Mon, 28 Feb 2022 15:06:15 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v7 07/11] vfio: Set DMA ownership for VFIO devices
Message-ID: <20220228150615.7026b3ae.alex.williamson@redhat.com>
In-Reply-To: <20220228005056.599595-8-baolu.lu@linux.intel.com>
References: <20220228005056.599595-1-baolu.lu@linux.intel.com>
 <20220228005056.599595-8-baolu.lu@linux.intel.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Stuart Yoder <stuyoder@gmail.com>, rafael@kernel.org,
 David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, kvm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 Li Yang <leoyang.li@nxp.com>, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Daniel Vetter <daniel@ffwll.ch>,
 Robin Murphy <robin.murphy@arm.com>
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

On Mon, 28 Feb 2022 08:50:52 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> Claim group dma ownership when an IOMMU group is set to a container,
> and release the dma ownership once the iommu group is unset from the
> container.
> 
> This change disallows some unsafe bridge drivers to bind to non-ACS
> bridges while devices under them are assigned to user space. This is an
> intentional enhancement and possibly breaks some existing
> configurations. The recommendation to such an affected user would be
> that the previously allowed host bridge driver was unsafe for this use
> case and to continue to enable assignment of devices within that group,
> the driver should be unbound from the bridge device or replaced with the
> pci-stub driver.
> 
> For any bridge driver, we consider it unsafe if it satisfies any of the
> following conditions:
> 
>   1) The bridge driver uses DMA. Calling pci_set_master() or calling any
>      kernel DMA API (dma_map_*() and etc.) is an indicate that the
>      driver is doing DMA.
> 
>   2) If the bridge driver uses MMIO, it should be tolerant to hostile
>      userspace also touching the same MMIO registers via P2P DMA
>      attacks.
> 
> If the bridge driver turns out to be a safe one, it could be used as
> before by setting the driver's .driver_managed_dma field, just like what
> we have done in the pcieport driver.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/vfio/fsl-mc/vfio_fsl_mc.c     |  1 +
>  drivers/vfio/pci/vfio_pci.c           |  1 +
>  drivers/vfio/platform/vfio_amba.c     |  1 +
>  drivers/vfio/platform/vfio_platform.c |  1 +
>  drivers/vfio/vfio.c                   | 10 +++++++++-
>  5 files changed, 13 insertions(+), 1 deletion(-)

Acked-by: Alex Williamson <alex.williamson@redhat.com>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
