Return-Path: <SRS0=aUVl=TX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C2DC04AAC
	for <iommu@archiver.kernel.org>; Thu, 23 May 2019 07:00:40 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B5E22133D
	for <iommu@archiver.kernel.org>; Thu, 23 May 2019 07:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GAsiZSYZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B5E22133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 8DEDDE99;
	Thu, 23 May 2019 07:00:39 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id E62B1E93
	for <iommu@lists.linux-foundation.org>;
	Thu, 23 May 2019 07:00:37 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id CEA8A6C5
	for <iommu@lists.linux-foundation.org>;
	Thu, 23 May 2019 07:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gAofSstRuBJKOBonOfNBSALVwiT+Rdgyj5l0uMZAW+0=;
	b=GAsiZSYZNBxFA9nepaYZHnFGM
	XDbvfMN0iodzffPtSz0jSDCUy/A/MpR3l7wh6jqABvtAWqK9rqZGbqCyVXH5VB+x+o9pWhJHMmZB+
	3o8ow0fZT+MRdvzy7AErKGHnl/Qn79wNGJqQmHEa1mPlnRE94c2jhBCg29RQGaeydpiHPjShrKRBI
	LNhkX1K8rROvRoejOjQB/Y+42A2jnJBgcVHBT0qZMNomh3qVcm2uqCWu5+bolCkUDbofMUjQJVmbW
	WrLhr4FiDGvGBdP4qhmWhWkIQW+frS0mofpjWCyFjA83lj77vVpZ9iP+YZCplXx5Q/gnGF5VLGxbf
	9Y742JeWQ==;
Received: from 213-225-10-46.nat.highway.a1.net ([213.225.10.46]
	helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
	id 1hThiJ-0004hB-Jm; Thu, 23 May 2019 07:00:32 +0000
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: implement generic dma_map_ops for IOMMUs v6
Date: Thu, 23 May 2019 09:00:05 +0200
Message-Id: <20190523070028.7435-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
	bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Tom Murphy <tmurphy@arista.com>, Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
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


Hi Robin and Joerg,

I think we are finally ready for the generic dma-iommu series.  I have
various DMA API changes pending, and Tom has patches ready to convert
the AMD and Intel iommu drivers over to it.  I'd love to have this
in a stable branch shared between the dma-mapping and iommu trees
the day after rc2 is released.  I volunteer to create the branch,
but I'm fine with it living in the iommu tree as well.


A git tree is also available at:

    git://git.infradead.org/users/hch/misc.git dma-iommu-ops.6

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-iommu-ops.6

Changes since v5:
 - rebased to latest linus tree and dropped a patch now merged
 - remove the now pointless __dma_iommu_mmap function
 - restore a cleanup from Robin that would have caused a conflict in
   last merge winow, but is fine now

Changes since v4:
 - rebased to 5.2-rc1

Changes since v3:
 - fold the separate patch to refactor mmap bounds checking
 - don't warn on not finding a vm_area
 - improve a commit log
 - refactor __dma_iommu_free a little differently
 - remove a minor MSI map cleanup to avoid a conflict with the
   "Split iommu_dma_map_msi_msg" series

Changes since v2:
 - address various review comments and include patches from Robin

Changes since v1:
 - only include other headers in dma-iommu.h if CONFIG_DMA_IOMMU is enabled
 - keep using a scatterlist in iommu_dma_alloc
 - split out mmap/sgtable fixes and move them early in the series
 - updated a few commit logs
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
