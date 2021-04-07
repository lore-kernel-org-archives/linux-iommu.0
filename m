Return-Path: <SRS0=DRkM=JE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C18C433B4
	for <iommu@archiver.kernel.org>; Wed,  7 Apr 2021 10:42:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4E3E61359
	for <iommu@archiver.kernel.org>; Wed,  7 Apr 2021 10:42:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4E3E61359
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6903C60BD8;
	Wed,  7 Apr 2021 10:42:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Yy2HblC979sL; Wed,  7 Apr 2021 10:42:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4773F60A40;
	Wed,  7 Apr 2021 10:42:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2BF5AC000B;
	Wed,  7 Apr 2021 10:42:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 57873C000A
 for <iommu@lists.linux-foundation.org>; Wed,  7 Apr 2021 10:42:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3899B4145F
 for <iommu@lists.linux-foundation.org>; Wed,  7 Apr 2021 10:42:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dPIHxlIsznED for <iommu@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 10:42:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 52ECC40F50
 for <iommu@lists.linux-foundation.org>; Wed,  7 Apr 2021 10:42:19 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8D7956105A;
 Wed,  7 Apr 2021 10:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617792136;
 bh=MHbf/bQAeLgtOsJGl6XD9m82rnO4b7mz7XxYX2+FXdI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ee/zkmzr/GCO+FG8YMGgI0NnboYerBcr82gKJwWcDLJ1kKr1vO1MZzVAsGwFME/QG
 d01O+kPty36J29VHF+zo/1gWMBdMEFP3G4CvuwQ4ibUuFsOJc+2BEpLQ+XnRygLcIK
 7dL8E2fRvBphDlAB0xsks5jF1M+vb689F9jx5hTlo6bI+ixD7tYpCqYyaUKFHV8TmF
 vACTcg1DDf6MOu1de0mKSybd94Slp9c7FuXXih/3RC6kkQJ4FAW5lCE0mnXLPRjHf6
 FlzeVEEarEIrCxxVUh5XlwM+UJoq7VPttmL4wLA+O2iSBoYVhtZ+Xm1qXXV+LlY43z
 tKWHUi/i+/9iw==
Date: Wed, 7 Apr 2021 11:42:10 +0100
From: Will Deacon <will@kernel.org>
To: Sven Peter <sven@svenpeter.dev>
Subject: Re: [PATCH v2 3/3] iommu: dart: Add DART iommu driver
Message-ID: <20210407104209.GA15173@willie-the-truck>
References: <20210328074009.95932-1-sven@svenpeter.dev>
 <20210328074009.95932-4-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210328074009.95932-4-sven@svenpeter.dev>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Arnd Bergmann <arnd@kernel.org>, devicetree@vger.kernel.org,
 Marc Zyngier <maz@kernel.org>, Hector Martin <marcan@marcan.st>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>,
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

On Sun, Mar 28, 2021 at 09:40:09AM +0200, Sven Peter wrote:
> Apple's new SoCs use iommus for almost all peripherals. These Device
> Address Resolution Tables must be setup before these peripherals can
> act as DMA masters.
> 
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
>  MAINTAINERS                      |   1 +
>  drivers/iommu/Kconfig            |  14 +
>  drivers/iommu/Makefile           |   1 +
>  drivers/iommu/apple-dart-iommu.c | 858 +++++++++++++++++++++++++++++++
>  4 files changed, 874 insertions(+)
>  create mode 100644 drivers/iommu/apple-dart-iommu.c

[...]

> +/* must be called with held domain->lock */
> +static int apple_dart_attach_stream(struct apple_dart_domain *domain,
> +				    struct apple_dart *dart, u32 sid)
> +{
> +	unsigned long flags;
> +	struct apple_dart_stream *stream;
> +	struct io_pgtable_cfg *pgtbl_cfg;
> +	int ret;
> +
> +	list_for_each_entry(stream, &domain->streams, stream_head) {
> +		if (stream->dart == dart && stream->sid == sid) {
> +			stream->num_devices++;
> +			return 0;
> +		}
> +	}
> +
> +	spin_lock_irqsave(&dart->lock, flags);
> +
> +	if (WARN_ON(dart->used_sids & BIT(sid))) {
> +		ret = -EINVAL;
> +		goto error;
> +	}
> +
> +	stream = kzalloc(sizeof(*stream), GFP_KERNEL);
> +	if (!stream) {
> +		ret = -ENOMEM;
> +		goto error;
> +	}

Just in case you missed it, a cocci bot noticed that you're using GFP_KERNEL
to allocate while holding a spinlock here:

https://lore.kernel.org/r/alpine.DEB.2.22.394.2104041724340.2958@hadrien

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
