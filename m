Return-Path: <SRS0=VKv6=TW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22AE9C282CE
	for <iommu@archiver.kernel.org>; Wed, 22 May 2019 12:33:09 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 009F72173C
	for <iommu@archiver.kernel.org>; Wed, 22 May 2019 12:33:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 009F72173C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id BD4C7CBF;
	Wed, 22 May 2019 12:33:08 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 4FABFCA6
	for <iommu@lists.linux-foundation.org>;
	Wed, 22 May 2019 12:33:08 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id C4559102
	for <iommu@lists.linux-foundation.org>;
	Wed, 22 May 2019 12:33:07 +0000 (UTC)
Received: by newverein.lst.de (Postfix, from userid 2407)
	id 25DE967358; Wed, 22 May 2019 14:32:44 +0200 (CEST)
Date: Wed, 22 May 2019 14:32:43 +0200
From: Christoph Hellwig <hch@lst.de>
To: Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>
Subject: Re: [PATCH] swiotlb: sync buffer when mapping FROM_DEVICE
Message-ID: <20190522123243.GA26390@lst.de>
References: <20190522072018.10660-1-horia.geanta@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190522072018.10660-1-horia.geanta@nxp.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	linux-imx@nxp.com, Robin Murphy <robin.murphy@arm.com>,
	Christoph Hellwig <hch@lst.de>
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

I'm a little worried about this.  While it looks functionally correct
we have surived without it, and doing another copy for every swiotlb
dma mapping from the device looks extremely painful for the typical use
cases where we expect the device to transfer the whole mapping.

I'd be tempted to instead properl document the current behavior and
introduce a new DMA_ATTR_PARTIAL flag to allow for partial mappings.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
