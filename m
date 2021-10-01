Return-Path: <SRS0=Y/Kh=OV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA56C433F5
	for <iommu@archiver.kernel.org>; Fri,  1 Oct 2021 17:31:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A9BC6187D
	for <iommu@archiver.kernel.org>; Fri,  1 Oct 2021 17:31:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9A9BC6187D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6AB00425EA;
	Fri,  1 Oct 2021 17:31:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RgGHsl1Oq6jl; Fri,  1 Oct 2021 17:31:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5D568425E1;
	Fri,  1 Oct 2021 17:31:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 38C4DC000F;
	Fri,  1 Oct 2021 17:31:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3CFDEC000D
 for <iommu@lists.linux-foundation.org>; Fri,  1 Oct 2021 17:31:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1F4CE425EA
 for <iommu@lists.linux-foundation.org>; Fri,  1 Oct 2021 17:31:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 98ziGXw3Fi2t for <iommu@lists.linux-foundation.org>;
 Fri,  1 Oct 2021 17:31:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D446B425E1
 for <iommu@lists.linux-foundation.org>; Fri,  1 Oct 2021 17:31:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: alyssa) with ESMTPSA id EA7451F452CD
Date: Fri, 1 Oct 2021 13:31:48 -0400
From: Alyssa Rosenzweig <alyssa@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Subject: Re: [PATCH v2 1/5] [RFC]iommu: Add a IOMMU_DEVONLY protection flag
Message-ID: <YVdGBLTApSccrr/6@maud>
References: <20211001143427.1564786-1-boris.brezillon@collabora.com>
 <20211001143427.1564786-2-boris.brezillon@collabora.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211001143427.1564786-2-boris.brezillon@collabora.com>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, Will Deacon <will@kernel.org>,
 dri-devel@lists.freedesktop.org, Steven Price <steven.price@arm.com>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

> The IOMMU_DEVONLY flag allows the caller to flag a mappings backed by
> device-private buffers. That means other devices or CPUs are not
> expected to access the physical memory region pointed by the mapping,
> and the MMU driver can safely restrict the shareability domain to the
> device itself.
> 
> Will be used by the ARM MMU driver to flag Mali mappings accessed only
> by the GPU as Inner-shareable.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> ---
>  include/linux/iommu.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index d2f3435e7d17..db14781b522f 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -31,6 +31,13 @@
>   * if the IOMMU page table format is equivalent.
>   */
>  #define IOMMU_PRIV	(1 << 5)
> +/*
> + * Mapping is only accessed by the device behind the iommu. That means other
> + * devices or CPUs are not expected to access this physical memory region,
> + * and the MMU driver can safely restrict the shareability domain to the
> + * device itself.
> + */
> +#define IOMMU_DEVONLY	(1 << 6)
>  
>  struct iommu_ops;
>  struct iommu_group;

This seems totally reasonable to me, but it is well-known that I'm not
on good terms with the iommu subsystem. Let's wait for Robin to NAK :-P
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
