Return-Path: <SRS0=DOhO=I7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A16C433ED
	for <iommu@archiver.kernel.org>; Fri,  2 Apr 2021 14:41:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE65460200
	for <iommu@archiver.kernel.org>; Fri,  2 Apr 2021 14:41:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE65460200
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A283B60607;
	Fri,  2 Apr 2021 14:41:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1Zu7vhv_4-ek; Fri,  2 Apr 2021 14:41:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id B7FF26068F;
	Fri,  2 Apr 2021 14:41:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 97F4BC000B;
	Fri,  2 Apr 2021 14:41:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5CA77C000A
 for <iommu@lists.linux-foundation.org>; Fri,  2 Apr 2021 14:41:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5913084C89
 for <iommu@lists.linux-foundation.org>; Fri,  2 Apr 2021 14:41:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JpGugpmoGHVh for <iommu@lists.linux-foundation.org>;
 Fri,  2 Apr 2021 14:41:47 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8DF5384C86
 for <iommu@lists.linux-foundation.org>; Fri,  2 Apr 2021 14:41:47 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 1758968BEB; Fri,  2 Apr 2021 16:41:42 +0200 (CEST)
Date: Fri, 2 Apr 2021 16:41:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: chenxiang <chenxiang66@hisilicon.com>
Subject: Re: [PATCH] dma-mapping: benchmark: Add support for multi-pages
 map/unmap
Message-ID: <20210402144142.GA19219@lst.de>
References: <1616059770-194515-1-git-send-email-chenxiang66@hisilicon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1616059770-194515-1-git-send-email-chenxiang66@hisilicon.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: linuxarm@openeuler.org, iommu@lists.linux-foundation.org,
 linux-kselftest@vger.kernel.org, robin.murphy@arm.com, hch@lst.de
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

Thanks, applied.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
