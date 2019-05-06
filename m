Return-Path: <SRS0=Zlue=TG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 301D9C04A6B
	for <iommu@archiver.kernel.org>; Mon,  6 May 2019 15:34:13 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1D06205ED
	for <iommu@archiver.kernel.org>; Mon,  6 May 2019 15:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=arista.com header.i=@arista.com header.b="h0Qs3cb1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1D06205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C521C490E;
	Mon,  6 May 2019 15:34:12 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C63A8488A
	for <iommu@lists.linux-foundation.org>;
	Mon,  6 May 2019 15:32:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
	[209.85.221.68])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 2469BFD
	for <iommu@lists.linux-foundation.org>;
	Mon,  6 May 2019 15:32:28 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id a12so7717852wrn.4
	for <iommu@lists.linux-foundation.org>;
	Mon, 06 May 2019 08:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=arista.com; s=googlenew;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=QoUlLUoustH5Kyyuv8cjzxtarKz9Yt28dcTG37LlDQc=;
	b=h0Qs3cb1N9VZYPv8SKIXGev/EpRRT057Mw/+lwEKRU0wLYa49RxNQR0uhiGXWaVaSx
	dkKmTbNYMXhRNk4HA7BIPXCKtbIX/jm4GDAJoXsD/R2kcPitxoAt+t5L4rQQEIHvi5Ua
	ANUWozNt8ZLo/qmWjlyIjWRwN1SwZ1Z1ESS5zGv8tyt1mng2cpH2XbxcUoA6N4reddWS
	P0unyNYp8+08m1j2eV09L82wnCZqSQBxhNmQztthHtmUCuc/rwkM2vL0hhXAlXvKcULu
	4u2vKXoEtfk2F/KOq3aZnG3XTlEpboZi7drQ7BN/ngoo0ojPwBsqhn9oIdr+oJF2CWUd
	86MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=QoUlLUoustH5Kyyuv8cjzxtarKz9Yt28dcTG37LlDQc=;
	b=YV6XYc5foEqUStYFJiVTU6wvbFlz5daR72ISneup8I8Ff9ZVQ/siLYcsrDhXhN6n5N
	IH0DHxzYOWFx5FZG/LY5azCIasyAIdlVhw+CLvATVzoadQG2ZguXjGNS9uAfNQV8XIxp
	xNIq+P7lATiC9Xo2ZfxGxL55o7EoUYMgAR8aTEvnOMUkl4qAS9SZ9BtVTNJ3xQv7+O8L
	tLDZGyRicsSTk+zNlx53z4y5yj1bTcWsTK8t1+iBZTjxbLHVL83wO4LUl3Y3rQcWb6tM
	10coyXwbrjKKnnBr1RSaP/+SC4/Fmx5EoBQ1gxJ2pWRFEB0J5REEWuKod4bIM/eHlrfu
	ET0w==
X-Gm-Message-State: APjAAAUNya61TZMLYSRDsFdsG2OSL5fXqL8XhW+FrHx3bGzzpAogIm+Z
	GsAhknQ13QLOIWXuYPeZ1B7xV7Z0wFBm/2AvyWZC+g==
X-Google-Smtp-Source: APXvYqytW0qHXUrR+10+PwAXQ3sa1dgLOTzgAB8CEL88CNxDnMKajzkJZIFB1K5SBaebS6V4BbioAAjynh76NIYsJSs=
X-Received: by 2002:a5d:5551:: with SMTP id g17mr20101431wrw.50.1557156746670; 
	Mon, 06 May 2019 08:32:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190429020925.18136-1-baolu.lu@linux.intel.com>
	<20190429020925.18136-2-baolu.lu@linux.intel.com>
In-Reply-To: <20190429020925.18136-2-baolu.lu@linux.intel.com>
Date: Mon, 6 May 2019 16:32:15 +0100
Message-ID: <CAPL0++4Q7p7gWRUF5vG5sazLNCmSR--Px-=OEtj6vm_gEpB_ng@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] iommu: Add ops entry for supported default domain
	type
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
	Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com,
	David Woodhouse <dwmw2@infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
From: Tom Murphy via iommu <iommu@lists.linux-foundation.org>
Reply-To: Tom Murphy <tmurphy@arista.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

The AMD driver already solves this problem and uses the generic
iommu_request_dm_for_dev function. It seems like both drivers have the
same problem and could use the same solution. Is there any reason we
can't have use the same solution for the intel and amd driver?

Could we just  copy the implementation of the AMD driver? It would be
nice to have the same behavior across both drivers especially as we
move to make both drivers use more generic code.

On Mon, Apr 29, 2019 at 3:16 AM Lu Baolu <baolu.lu@linux.intel.com> wrote:
>
> This adds an optional ops entry to query the default domain
> types supported by the iommu driver for  a specific device.
> This is necessary in cases where the iommu driver can only
> support a specific type of default domain for a device. In
> normal cases, this ops will return IOMMU_DOMAIN_ANY which
> indicates that the iommu driver supports both IOMMU_DOMAIN_DMA
> and IOMMU_DOMAIN_IDENTITY, hence the static default domain
> type will be used.
>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/iommu.c | 13 ++++++++++---
>  include/linux/iommu.h | 11 +++++++++++
>  2 files changed, 21 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index acd6830e6e9b..1ad9a1f2e078 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1097,15 +1097,22 @@ struct iommu_group *iommu_group_get_for_dev(struct device *dev)
>          * IOMMU driver.
>          */
>         if (!group->default_domain) {
> +               unsigned int domain_type = IOMMU_DOMAIN_ANY;
>                 struct iommu_domain *dom;
>
> -               dom = __iommu_domain_alloc(dev->bus, iommu_def_domain_type);
> -               if (!dom && iommu_def_domain_type != IOMMU_DOMAIN_DMA) {
> +               if (ops->def_domain_type)
> +                       domain_type = ops->def_domain_type(dev);
> +
> +               if (domain_type == IOMMU_DOMAIN_ANY)
> +                       domain_type = iommu_def_domain_type;
> +
> +               dom = __iommu_domain_alloc(dev->bus, domain_type);
> +               if (!dom && domain_type != IOMMU_DOMAIN_DMA) {
>                         dom = __iommu_domain_alloc(dev->bus, IOMMU_DOMAIN_DMA);
>                         if (dom) {
>                                 dev_warn(dev,
>                                          "failed to allocate default IOMMU domain of type %u; falling back to IOMMU_DOMAIN_DMA",
> -                                        iommu_def_domain_type);
> +                                        domain_type);
>                         }
>                 }
>
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 8239ece9fdfc..ba9a5b996a63 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -79,12 +79,16 @@ struct iommu_domain_geometry {
>   *     IOMMU_DOMAIN_DMA        - Internally used for DMA-API implementations.
>   *                               This flag allows IOMMU drivers to implement
>   *                               certain optimizations for these domains
> + *     IOMMU_DOMAIN_ANY        - All domain types defined here
>   */
>  #define IOMMU_DOMAIN_BLOCKED   (0U)
>  #define IOMMU_DOMAIN_IDENTITY  (__IOMMU_DOMAIN_PT)
>  #define IOMMU_DOMAIN_UNMANAGED (__IOMMU_DOMAIN_PAGING)
>  #define IOMMU_DOMAIN_DMA       (__IOMMU_DOMAIN_PAGING |        \
>                                  __IOMMU_DOMAIN_DMA_API)
> +#define IOMMU_DOMAIN_ANY       (IOMMU_DOMAIN_IDENTITY |        \
> +                                IOMMU_DOMAIN_UNMANAGED |       \
> +                                IOMMU_DOMAIN_DMA)
>
>  struct iommu_domain {
>         unsigned type;
> @@ -196,6 +200,11 @@ enum iommu_dev_features {
>   * @dev_feat_enabled: check enabled feature
>   * @aux_attach/detach_dev: aux-domain specific attach/detach entries.
>   * @aux_get_pasid: get the pasid given an aux-domain
> + * @def_domain_type: get per-device default domain type that the IOMMU
> + *             driver is able to support. Valid returns values:
> + *             - IOMMU_DOMAIN_DMA: only suports non-identity domain
> + *             - IOMMU_DOMAIN_IDENTITY: only supports identity domain
> + *             - IOMMU_DOMAIN_ANY: supports all
>   * @pgsize_bitmap: bitmap of all possible supported page sizes
>   */
>  struct iommu_ops {
> @@ -251,6 +260,8 @@ struct iommu_ops {
>         void (*aux_detach_dev)(struct iommu_domain *domain, struct device *dev);
>         int (*aux_get_pasid)(struct iommu_domain *domain, struct device *dev);
>
> +       int (*def_domain_type)(struct device *dev);
> +
>         unsigned long pgsize_bitmap;
>  };
>
> --
> 2.17.1
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
