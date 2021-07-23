Return-Path: <SRS0=yZZ9=MP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E79C4320A
	for <iommu@archiver.kernel.org>; Fri, 23 Jul 2021 05:09:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EEF560E99
	for <iommu@archiver.kernel.org>; Fri, 23 Jul 2021 05:09:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7EEF560E99
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3926A608DC;
	Fri, 23 Jul 2021 05:09:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iGBGPqs-xmio; Fri, 23 Jul 2021 05:09:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 413E860646;
	Fri, 23 Jul 2021 05:09:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 18A24C001A;
	Fri, 23 Jul 2021 05:09:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DB442C000E
 for <iommu@lists.linux-foundation.org>; Fri, 23 Jul 2021 05:09:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D073B6064B
 for <iommu@lists.linux-foundation.org>; Fri, 23 Jul 2021 05:09:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OEYSbrMPcE_j for <iommu@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 05:09:09 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E9D1660646
 for <iommu@lists.linux-foundation.org>; Fri, 23 Jul 2021 05:09:08 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 1B43C68AFE; Fri, 23 Jul 2021 07:09:03 +0200 (CEST)
Date: Fri, 23 Jul 2021 07:09:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ezequiel Garcia <ezequiel@collabora.com>
Subject: Re: [PATCH] iommu/dma: Fix leak in non-contiguous API
Message-ID: <20210723050902.GA31187@lst.de>
References: <20210723010552.50969-1-ezequiel@collabora.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210723010552.50969-1-ezequiel@collabora.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: stable@vger.kernel.org, iommu@lists.linux-foundation.org,
 Ricardo Ribalda <ribalda@chromium.org>, kernel@collabora.com,
 Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-media@vger.kernel.org
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

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

> As a side note, it appears the struct dma_sgt_handle type is exposed
> to users of the DMA-API by linux/dma-map-ops.h, but is has no users
> or functions returning the type explicitly.
> 
> This may indicate it's a good idea to move the struct dma_sgt_handle type
> to drivers/iommu/dma-iommu.c. The decision is left to maintainers :-)

linux/dma-map-ops.h is a helper header for the dma_ops implementations,
not for users of the DMA API.  sgt_handle, which references
dma_sgt_handle is used in kernel/dma/mapping.c
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
