Return-Path: <SRS0=o7oR=M5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 288ECC4338F
	for <iommu@archiver.kernel.org>; Fri,  6 Aug 2021 14:11:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC13060EE5
	for <iommu@archiver.kernel.org>; Fri,  6 Aug 2021 14:11:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CC13060EE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 90382405B8;
	Fri,  6 Aug 2021 14:11:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TC_MyvNvviO5; Fri,  6 Aug 2021 14:11:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 220FE40581;
	Fri,  6 Aug 2021 14:11:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 080DCC001A;
	Fri,  6 Aug 2021 14:11:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 05C10C000E
 for <iommu@lists.linux-foundation.org>; Fri,  6 Aug 2021 14:11:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E8E34606CC
 for <iommu@lists.linux-foundation.org>; Fri,  6 Aug 2021 14:11:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RizLsA8s-05p for <iommu@lists.linux-foundation.org>;
 Fri,  6 Aug 2021 14:11:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CAC6160617
 for <iommu@lists.linux-foundation.org>; Fri,  6 Aug 2021 14:11:44 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5F121611C6
 for <iommu@lists.linux-foundation.org>; Fri,  6 Aug 2021 14:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628259104;
 bh=CSbLfRVE2UUWpruHwkg8Uj8Y4BhMu1P18wZvcPO6wpo=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=NjbxXJRLfzOCZp/OsanZtKa0LYJmDvliEHis1OXyMPWXO5f7DC1LsIedH1xOOTmdq
 LYrLKU1u2fD/w2/tQxOPQ0aVv0hqOfu/h2HynCrM8b7ralpEdpdGMAtgDCAPqTQC30
 d9Ljf/Ffd4LumowMEv886W/09GGFGcNZp2VJ+NkL7EzB5qz/We243LRuMZ+V86PKxE
 uZ7p1GLaaZoOf+4U+YEdwlIpcmbKvho8osS8UzH7wRG0L4aq0FN0szRecGJeKA0r3p
 jC/MPaEhIqnKp9ELYIOkWYt52b7iaeoI3WXeRLL0KcXgnfzqCG9dq8IKieehuJErZg
 gAumwMZcALE3g==
Received: by mail-ej1-f48.google.com with SMTP id gs8so15190875ejc.13
 for <iommu@lists.linux-foundation.org>; Fri, 06 Aug 2021 07:11:44 -0700 (PDT)
X-Gm-Message-State: AOAM5339FKsiY0+EATu79g/DEWTCJ9x6lR4WTGaMXe8MmEAC4iZ37bBy
 TilGsUFms4TeYFst657piAWqQ55VNU4bFFUbCg==
X-Google-Smtp-Source: ABdhPJz2aB9W+k5EFME8idlFEFePLvrE7JvKCrPX4gmCiv3PpMHVunwV0NzEcLofGEPyHNTiQyH37b4B3lAcTf8hS2o=
X-Received: by 2002:a17:906:d287:: with SMTP id
 ay7mr9680139ejb.360.1628259102955; 
 Fri, 06 Aug 2021 07:11:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210805094736.902-1-will@kernel.org>
In-Reply-To: <20210805094736.902-1-will@kernel.org>
From: Rob Herring <robh+dt@kernel.org>
Date: Fri, 6 Aug 2021 08:11:31 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ7ROWWJX84x2kEex9NQ8G+2=ybRuNOobX+j8bjZzSemQ@mail.gmail.com>
Message-ID: <CAL_JsqJ7ROWWJX84x2kEex9NQ8G+2=ybRuNOobX+j8bjZzSemQ@mail.gmail.com>
Subject: Re: [PATCH] of: restricted dma: Don't fail device probe on rmem init
 failure
To: Will Deacon <will@kernel.org>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 Claire Chang <tientzu@chromium.org>, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>
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

On Thu, Aug 5, 2021 at 3:47 AM Will Deacon <will@kernel.org> wrote:
>
> If CONFIG_DMA_RESTRICTED_POOL=n then probing a device with a reference
> to a "restricted-dma-pool" will fail with a reasonably cryptic error:

I'm left wondering why of_dma_set_restricted_buffer() is even enabled
with CONFIG_DMA_RESTRICTED_POOL=n.

of_dma_set_restricted_buffer() should use IS_ENABLED and it should
also be moved to of/device.c. There's no reason for it to be in
of/address.c. It has nothing to do with address parsing.

>   | pci-host-generic: probe of 10000.pci failed with error -22
>
> Print a more helpful message in this case and try to continue probing
> the device as we do if the kernel doesn't have the restricted DMA patches
> applied or either CONFIG_OF_ADDRESS or CONFIG_HAS_DMA =n.

I think you'd have to work pretty hard to hit this code path with
either of the above config options off.

> Cc: Claire Chang <tientzu@chromium.org>
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  drivers/of/address.c    | 8 ++++----
>  drivers/of/device.c     | 2 +-
>  drivers/of/of_private.h | 8 +++-----
>  3 files changed, 8 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/of/address.c b/drivers/of/address.c
> index 973257434398..f6bf4b423c2a 100644
> --- a/drivers/of/address.c
> +++ b/drivers/of/address.c
> @@ -997,7 +997,7 @@ int of_dma_get_range(struct device_node *np, const struct bus_dma_region **map)
>         return ret;
>  }
>
> -int of_dma_set_restricted_buffer(struct device *dev, struct device_node *np)
> +void of_dma_set_restricted_buffer(struct device *dev, struct device_node *np)
>  {
>         struct device_node *node, *of_node = dev->of_node;
>         int count, i;
> @@ -1022,11 +1022,11 @@ int of_dma_set_restricted_buffer(struct device *dev, struct device_node *np)
>                  */
>                 if (of_device_is_compatible(node, "restricted-dma-pool") &&
>                     of_device_is_available(node))
> -                       return of_reserved_mem_device_init_by_idx(dev, of_node,
> -                                                                 i);
> +                       break;
>         }
>
> -       return 0;
> +       if (i != count && of_reserved_mem_device_init_by_idx(dev, of_node, i))
> +               dev_warn(dev, "failed to initialise \"restricted-dma-pool\" memory node\n");
>  }
>  #endif /* CONFIG_HAS_DMA */
>
> diff --git a/drivers/of/device.c b/drivers/of/device.c
> index 2defdca418ec..258a2b099410 100644
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -166,7 +166,7 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
>         arch_setup_dma_ops(dev, dma_start, size, iommu, coherent);
>
>         if (!iommu)
> -               return of_dma_set_restricted_buffer(dev, np);
> +               of_dma_set_restricted_buffer(dev, np);
>
>         return 0;
>  }
> diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
> index f557bd22b0cf..bc883f69496b 100644
> --- a/drivers/of/of_private.h
> +++ b/drivers/of/of_private.h
> @@ -163,18 +163,16 @@ struct bus_dma_region;
>  #if defined(CONFIG_OF_ADDRESS) && defined(CONFIG_HAS_DMA)
>  int of_dma_get_range(struct device_node *np,
>                 const struct bus_dma_region **map);
> -int of_dma_set_restricted_buffer(struct device *dev, struct device_node *np);
> +void of_dma_set_restricted_buffer(struct device *dev, struct device_node *np);
>  #else
>  static inline int of_dma_get_range(struct device_node *np,
>                 const struct bus_dma_region **map)
>  {
>         return -ENODEV;
>  }
> -static inline int of_dma_set_restricted_buffer(struct device *dev,
> -                                              struct device_node *np)
> +static inline void of_dma_set_restricted_buffer(struct device *dev,
> +                                               struct device_node *np)
>  {
> -       /* Do nothing, successfully. */
> -       return 0;
>  }
>  #endif
>
> --
> 2.32.0.605.g8dce9f2422-goog
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
