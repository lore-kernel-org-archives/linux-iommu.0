Return-Path: <SRS0=eAvY=NW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1C3C432BE
	for <iommu@archiver.kernel.org>; Tue, 31 Aug 2021 23:11:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCEE960F6B
	for <iommu@archiver.kernel.org>; Tue, 31 Aug 2021 23:11:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DCEE960F6B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rosenzweig.io
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B8C7F81AF4;
	Tue, 31 Aug 2021 23:11:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C_ThXVxj0mqP; Tue, 31 Aug 2021 23:11:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 404D781AC4;
	Tue, 31 Aug 2021 23:11:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 35146C0028;
	Tue, 31 Aug 2021 23:11:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9B787C000E
 for <iommu@lists.linux-foundation.org>; Tue, 31 Aug 2021 23:11:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7B5C54015D
 for <iommu@lists.linux-foundation.org>; Tue, 31 Aug 2021 23:11:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VKS8Tbl73CLE for <iommu@lists.linux-foundation.org>;
 Tue, 31 Aug 2021 23:10:57 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from rosenzweig.io (rosenzweig.io [138.197.143.207])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 40C0840111
 for <iommu@lists.linux-foundation.org>; Tue, 31 Aug 2021 23:10:57 +0000 (UTC)
Date: Tue, 31 Aug 2021 17:40:32 -0400
From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
To: Sven Peter <sven@svenpeter.dev>
Subject: Re: [PATCH v2 8/8] iommu/dart: Remove force_bypass logic
Message-ID: <YS6h0E1lM5owyLWp@sunset>
References: <20210828153642.19396-1-sven@svenpeter.dev>
 <20210828153642.19396-9-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210828153642.19396-9-sven@svenpeter.dev>
Cc: Arnd Bergmann <arnd@kernel.org>, Will Deacon <will@kernel.org>,
 Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Alexander Graf <graf@amazon.com>,
 Mohamed Mediouni <mohamed.mediouni@caramail.com>,
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

> Now that the dma-iommu API supports IOMMU granules which are larger than
> the CPU page size and that the kernel no longer runs into a BUG_ON when
> devices are attached to a domain with such a granule there's no need to
> force bypass mode anymore.
> 
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
>  drivers/iommu/apple-dart.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)

This was such an ugly hack, glad to see it go. This patch is

	Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
