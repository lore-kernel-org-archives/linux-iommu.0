Return-Path: <SRS0=Kg+4=TA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 536ADC04AA8
	for <iommu@archiver.kernel.org>; Tue, 30 Apr 2019 10:53:48 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2383C21707
	for <iommu@archiver.kernel.org>; Tue, 30 Apr 2019 10:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="t8/xdPkL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2383C21707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 86406F51;
	Tue, 30 Apr 2019 10:53:33 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 50743F09
	for <iommu@lists.linux-foundation.org>;
	Tue, 30 Apr 2019 10:52:59 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 39BF05F4
	for <iommu@lists.linux-foundation.org>;
	Tue, 30 Apr 2019 10:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=NSdqCv71ScTLfp+L8DoOcIv8z0/qhRPKt5mb1BYMk/s=;
	b=t8/xdPkLuMODEclDwrkXgZG6i
	jd28Y4ll3XEIXyENP0Lp2V5CG7LB9jmVnVkEoKIPanOxnfZM9jwqXX6+f19EeyA4Sz6mGmxSNc9XJ
	J9UaH9G3JTHE0uM+6NldNrZsEFQLPzhMIUmeN+TTejqv3LWCWB1ck9wu3A6GvvhzGr28uQG4v9PVR
	qlPQ8Dn3UHCaW6mFhdgtUfQwZ3dafOYshE1x45BCFMjMUQGgrL6b2YmV/sgqYqXOwf6bGe5LT8lu7
	trbe57rg26xkdVh3HyL5QcVRRZfpUQaZ2stm0RyEnb8M9taCl5uS2z/EDhuMbnTbXDH3j/+uhcnCU
	qDTA0Otvg==;
Received: from adsl-173-228-226-134.prtc.net ([173.228.226.134] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
	id 1hLQNX-0007JR-UQ; Tue, 30 Apr 2019 10:52:52 +0000
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: implement generic dma_map_ops for IOMMUs v4
Date: Tue, 30 Apr 2019 06:51:49 -0400
Message-Id: <20190430105214.24628-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
	bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190430105149.O1_ar7X3TbtuJVbN1DeiIoB45TKHqPwG3HQShcUTpDI@z>

Hi Robin,

please take a look at this series, which implements a completely generic
set of dma_map_ops for IOMMU drivers.  This is done by taking the
existing arm64 code, moving it to drivers/iommu and then massaging it
so that it can also work for architectures with DMA remapping.  This
should help future ports to support IOMMUs more easily, and also allow
to remove various custom IOMMU dma_map_ops implementations, like Tom
was planning to for the AMD one.

A git tree is also available at:

    git://git.infradead.org/users/hch/misc.git dma-iommu-ops.3

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-iommu-ops.3

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
