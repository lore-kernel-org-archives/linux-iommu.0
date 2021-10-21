Return-Path: <SRS0=0R9D=PJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30DD5C433EF
	for <iommu@archiver.kernel.org>; Thu, 21 Oct 2021 09:06:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 884DF60F56
	for <iommu@archiver.kernel.org>; Thu, 21 Oct 2021 09:06:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 884DF60F56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4871D83B3B;
	Thu, 21 Oct 2021 09:06:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MQ_EXkL1mgxC; Thu, 21 Oct 2021 09:06:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4415483B39;
	Thu, 21 Oct 2021 09:06:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 252EFC001C;
	Thu, 21 Oct 2021 09:06:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0B438C0011
 for <iommu@lists.linux-foundation.org>; Thu, 21 Oct 2021 09:06:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 00F91407C2
 for <iommu@lists.linux-foundation.org>; Thu, 21 Oct 2021 09:06:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8AXe1Ksc1Nv2 for <iommu@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 09:06:16 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F0BA540591
 for <iommu@lists.linux-foundation.org>; Thu, 21 Oct 2021 09:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=J9K/rlL1yDmS7NQkZ4o7xWkAF/BR+axUwaO8XmqLYb0=; b=nWd3dCkAEe2bY7NKqXWLM5s3Rp
 glzCHs67sYLPI9UM5uCuxwGNyieI1718RNxlWTJU5pVoCgD3I72I35FCC4+FbE8WirnIfie3w1Clz
 mVPQ2ShvIbRjcLV6qvX6RRL9ZWLRJQNAYjItvt9dnEbHd4KxTK3XKmrrVAQkSZ/7134ld7bUCwN6Z
 STa6aJKl8A1UIVl4YI7B5ETRQRv4Tnr/P1OsU2uz5ay4hpbQtBw4+RL5142WImJ3D4tBUCOnI07jF
 C6OcxIOtBgu7KPrriKSjEApg7OIwo9hhARPdExnOiKi/azpGNaGsM/syuFH8pSL0fcG0IkUp8c9zJ
 ib9g85jg==;
Received: from [2001:4bb8:180:8777:7df0:a8d8:40cc:3310] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mdU1e-006xtM-Cb; Thu, 21 Oct 2021 09:06:14 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Subject: dma-direct fixes and cleanups v2
Date: Thu, 21 Oct 2021 11:06:01 +0200
Message-Id: <20211021090611.488281-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Robin Murphy <robin.murphy@arm.com>, David Rientjes <rientjes@google.com>
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

Hi all,

Linus complained about the complex flow in dma_direct_alloc, so this
tries to simplify it a bit, and while I was at it I also made sure that
unencrypted pages never leak back into the page allocator.

Changes since v1:
 - fix a missing return
 - add a new patch to fix a pre-existing missing unmap
 - various additional cleanups
 
Diffstat:
 direct.c |  234 +++++++++++++++++++++++++++++++++++++--------------------------
 1 file changed, 138 insertions(+), 96 deletions(-)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
