Return-Path: <SRS0=VKv6=TW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86ED6C282DD
	for <iommu@archiver.kernel.org>; Wed, 22 May 2019 13:09:47 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E68F2184E
	for <iommu@archiver.kernel.org>; Wed, 22 May 2019 13:09:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E68F2184E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 18C7BD73;
	Wed, 22 May 2019 13:09:47 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 834A9D4A
	for <iommu@lists.linux-foundation.org>;
	Wed, 22 May 2019 13:09:45 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 1587887A
	for <iommu@lists.linux-foundation.org>;
	Wed, 22 May 2019 13:09:44 +0000 (UTC)
Received: by newverein.lst.de (Postfix, from userid 2407)
	id DC0B267358; Wed, 22 May 2019 15:09:21 +0200 (CEST)
Date: Wed, 22 May 2019 15:09:21 +0200
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] swiotlb: sync buffer when mapping FROM_DEVICE
Message-ID: <20190522130921.GA26874@lst.de>
References: <20190522072018.10660-1-horia.geanta@nxp.com>
	<20190522123243.GA26390@lst.de>
	<6cbe5470-16a6-17e9-337d-6ba18b16b6e8@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6cbe5470-16a6-17e9-337d-6ba18b16b6e8@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	linux-imx@nxp.com, Christoph Hellwig <hch@lst.de>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Wed, May 22, 2019 at 01:50:47PM +0100, Robin Murphy wrote:
> Would that work out any different from the existing DMA_ATTR_SKIP_CPU_SYNC? 
>
> If drivers are prepared to handle this issue from their end, they can 
> already do so for single mappings by using that attr along with explicit 
> partial syncs via dma_sync_single(). For page/sg mappings we'd still have 
> the problem of identifying what part of "partial" actually matters, and 
> probably having to add some additional new sync operations to cope.

Except that the same optimization we are tripping over here is also
present in dma_sync_* - dma_sync_*_to_device with DMA_FROM_DEVICE is a
no-op in swiotlb.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
