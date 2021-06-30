Return-Path: <SRS0=eogA=LY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45A2C11F65
	for <iommu@archiver.kernel.org>; Wed, 30 Jun 2021 14:07:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9267C61437
	for <iommu@archiver.kernel.org>; Wed, 30 Jun 2021 14:07:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9267C61437
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0C79D415B5;
	Wed, 30 Jun 2021 14:07:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W2coXzwkmXmi; Wed, 30 Jun 2021 14:07:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 12FC2415B2;
	Wed, 30 Jun 2021 14:07:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C71BBC001C;
	Wed, 30 Jun 2021 14:07:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 49FB8C000E
 for <iommu@lists.linux-foundation.org>; Wed, 30 Jun 2021 13:49:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 37E7D40568
 for <iommu@lists.linux-foundation.org>; Wed, 30 Jun 2021 13:49:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CMjOxRDB6uKJ for <iommu@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 13:49:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 097F8404F6
 for <iommu@lists.linux-foundation.org>; Wed, 30 Jun 2021 13:49:21 +0000 (UTC)
Received: from maud (unknown [IPv6:2600:8800:8c04:8c00::912b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: alyssa)
 by bhuna.collabora.co.uk (Postfix) with ESMTPSA id EF5171F43548;
 Wed, 30 Jun 2021 14:49:13 +0100 (BST)
Date: Wed, 30 Jun 2021 09:49:07 -0400
From: Alyssa Rosenzweig <alyssa@collabora.com>
To: Sven Peter <sven@svenpeter.dev>
Subject: Re: [PATCH v4 3/3] iommu: dart: Add DART iommu driver
Message-ID: <YNx2U4GPoKxV3PWd@maud>
References: <20210627143405.77298-1-sven@svenpeter.dev>
 <20210627143405.77298-4-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210627143405.77298-4-sven@svenpeter.dev>
X-Mailman-Approved-At: Wed, 30 Jun 2021 14:07:16 +0000
Cc: devicetree@vger.kernel.org, r.czerwinski@pengutronix.de,
 Arnd Bergmann <arnd@kernel.org>, Will Deacon <will@kernel.org>,
 Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 Alexander Graf <graf@amazon.com>,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Marc Zyngier <maz@kernel.org>,
 Mohamed Mediouni <mohamed.mediouni@caramail.com>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org, Stan Skowronek <stan@corellium.com>
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

Looks really good! Just a few minor comments. With them addressed,

	Reviewed-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>

> +	  Say Y here if you are using an Apple SoC with a DART IOMMU.

Nit: Do we need to spell out "with a DART IOMMU"? Don't all the apple
socs need DART?

> +/*
> + * This structure is used to identify a single stream attached to a domain.
> + * It's used as a list inside that domain to be able to attach multiple
> + * streams to a single domain. Since multiple devices can use a single stream
> + * it additionally keeps track of how many devices are represented by this
> + * stream. Once that number reaches zero it is detached from the IOMMU domain
> + * and all translations from this stream are disabled.
> + *
> + * @dart: DART instance to which this stream belongs
> + * @sid: stream id within the DART instance
> + * @num_devices: count of devices attached to this stream
> + * @stream_head: list head for the next stream
> + */
> +struct apple_dart_stream {
> +	struct apple_dart *dart;
> +	u32 sid;
> +
> +	u32 num_devices;
> +
> +	struct list_head stream_head;
> +};

It wasn't obvious to me why we can get away without reference counting.
Looking ahead it looks like we assert locks in each case. Maybe add
that to the comment?

```
> +static void apple_dart_hw_set_ttbr(struct apple_dart *dart, u16 sid, u16 idx,
> +				   phys_addr_t paddr)
> +{
> +	writel(DART_TTBR_VALID | (paddr >> DART_TTBR_SHIFT),
> +	       dart->regs + DART_TTBR(sid, idx));
> +}
```

Should we be checking alignment here? Something like

    BUG_ON(paddr & ((1 << DART_TTBR_SHIFT) - 1));
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
