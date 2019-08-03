Return-Path: <SRS0=gcAa=V7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B73C31E40
	for <iommu@archiver.kernel.org>; Sat,  3 Aug 2019 06:26:20 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E12852087C
	for <iommu@archiver.kernel.org>; Sat,  3 Aug 2019 06:26:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E12852087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 9572A181F;
	Sat,  3 Aug 2019 06:26:19 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C292DDB3
	for <iommu@lists.linux-foundation.org>;
	Sat,  3 Aug 2019 06:23:37 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 5E74B712
	for <iommu@lists.linux-foundation.org>;
	Sat,  3 Aug 2019 06:23:37 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0D4EA68C4E; Sat,  3 Aug 2019 08:23:33 +0200 (CEST)
Date: Sat, 3 Aug 2019 08:23:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: gavinli@thegavinli.com
Subject: Re: [PATCH v1] dma-mapping: normal memory for mmap() on coherent
	architectures
Message-ID: <20190803062333.GC29348@lst.de>
References: <20190802180758.9691-1-gavinli@thegavinli.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190802180758.9691-1-gavinli@thegavinli.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Gavin Li <git@thegavinli.com>, iommu@lists.linux-foundation.org,
	Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

See the discussion at:

https://lists.linuxfoundation.org/pipermail/iommu/2019-August/037716.html

Just curious, what driver do you use that uses dma_mmap_coherent on
x86?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
