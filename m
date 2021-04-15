Return-Path: <SRS0=SOau=JM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34729C433ED
	for <iommu@archiver.kernel.org>; Thu, 15 Apr 2021 13:40:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B49B2613C0
	for <iommu@archiver.kernel.org>; Thu, 15 Apr 2021 13:40:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B49B2613C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5AB3640129;
	Thu, 15 Apr 2021 13:40:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F0cCbcexZ5SY; Thu, 15 Apr 2021 13:40:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6935540228;
	Thu, 15 Apr 2021 13:40:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 518E4C000B;
	Thu, 15 Apr 2021 13:40:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 75E1EC000A
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 13:40:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 566794069D
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 13:40:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NdMEFlQ2vHke for <iommu@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 13:40:33 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B1C6540693
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 13:40:33 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 5A1C5387; Thu, 15 Apr 2021 15:40:31 +0200 (CEST)
Date: Thu, 15 Apr 2021 15:40:29 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Shaokun Zhang <zhangshaokun@hisilicon.com>
Subject: Re: [PATCH RESEND] iommu/amd: Remove duplicate check of devid
Message-ID: <YHhCTfdFR+ATH8zl@8bytes.org>
References: <1617939040-35579-1-git-send-email-zhangshaokun@hisilicon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1617939040-35579-1-git-send-email-zhangshaokun@hisilicon.com>
Cc: iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>
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

On Fri, Apr 09, 2021 at 11:30:40AM +0800, Shaokun Zhang wrote:
>  drivers/iommu/amd/iommu.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)

Applied, thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
