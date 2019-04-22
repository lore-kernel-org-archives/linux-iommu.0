Return-Path: <SRS0=kOFq=SY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F2A5C10F11
	for <iommu@archiver.kernel.org>; Mon, 22 Apr 2019 18:25:05 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5E6A214AE
	for <iommu@archiver.kernel.org>; Mon, 22 Apr 2019 18:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SVfnibJk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5E6A214AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id D6A0FD7F;
	Mon, 22 Apr 2019 18:25:03 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 80332CC7
	for <iommu@lists.linux-foundation.org>;
	Mon, 22 Apr 2019 18:25:02 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 17A21829
	for <iommu@lists.linux-foundation.org>;
	Mon, 22 Apr 2019 18:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7VRDIL83+ypRClRgxnOrRjLEIAVbztTq6oqvp65Upks=;
	b=SVfnibJkgbARoq4wnaPhDwDo5O
	fwEflU6bHrb4q+DucDWJFo837R+RC/HYIGO9zoe1bWAj3pRNa2nlJ2zHnA8RhLV/1Ig1uSeT4Sgta
	jXFQCHoxL+Z0kT8An5dCx6NeIxJfyWrdNSfRiCcZpGraj93tz6PY+o8y3j15Pq3OXlb+5cHar3Lcz
	vhDEdRO0veFWUowzij8ZbVBn6Tr6goStk+UrabJ/i+imOg/w+pYJhpvwiFMKGKXdmRnIIiqrBxA4q
	t9TuImAX7onBUAHnK0hy0WTdbFc+kMV2U7Af8FWwwBshOx+NSvT9S/MvhlnGqSwKfFI5Ceq9mKpNm
	S/d3r0Lw==;
Received: from 213-225-37-80.nat.highway.a1.net ([213.225.37.80]
	helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
	id 1hIdFi-0002kn-D6; Mon, 22 Apr 2019 18:01:15 +0000
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 25/26] arm64: switch copyright boilerplace to SPDX in
	dma-mapping.c
Date: Mon, 22 Apr 2019 19:59:41 +0200
Message-Id: <20190422175942.18788-26-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190422175942.18788-1-hch@lst.de>
References: <20190422175942.18788-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
	bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, Mukesh Ojha <mojha@codeaurora.org>,
	linux-arm-kernel@lists.infradead.org
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
Message-ID: <20190422175941.3_jPiBLl0z2qpCFPjoEvLykBhUKVgJ4O8qphgkTY9G4@z>

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
---
 arch/arm64/mm/dma-mapping.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index d1661f78eb4d..184ef9ccd69d 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -1,20 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * SWIOTLB-based DMA API implementation
- *
  * Copyright (C) 2012 ARM Ltd.
  * Author: Catalin Marinas <catalin.marinas@arm.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <linux/gfp.h>
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
