Return-Path: <SRS0=tixU=6C=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB91C3A5A9
	for <iommu@archiver.kernel.org>; Sat, 18 Apr 2020 14:09:41 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E8D322202
	for <iommu@archiver.kernel.org>; Sat, 18 Apr 2020 14:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ns9lN1Wg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E8D322202
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 10BFB8683A;
	Sat, 18 Apr 2020 14:09:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aY8Iy7yb4xoK; Sat, 18 Apr 2020 14:09:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 81DD28773E;
	Sat, 18 Apr 2020 14:09:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6705AC1D8A;
	Sat, 18 Apr 2020 14:09:40 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5C58BC0172
 for <iommu@lists.linux-foundation.org>; Sat, 18 Apr 2020 14:09:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 492D020133
 for <iommu@lists.linux-foundation.org>; Sat, 18 Apr 2020 14:09:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qb3sKtY8Nb2s for <iommu@lists.linux-foundation.org>;
 Sat, 18 Apr 2020 14:09:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id AA9362010C
 for <iommu@lists.linux-foundation.org>; Sat, 18 Apr 2020 14:09:38 +0000 (UTC)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DA5C12224F;
 Sat, 18 Apr 2020 14:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1587218978;
 bh=ncBNWmIN+p01sKE/CXGoQTUf+xcaqNfhGJqhi7zYLoo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Ns9lN1Wgo7M7YG3jMrmfEHGw1W1nVh7RyP6M+tvyPvW08kntIzclVIAu+PufO1cVA
 MdCauvNI+XD19q8/ghgysdleF4etXC2wmVT5kRzlk2TcmnUBwGnX8wJtAm0/Kv2kCP
 LU8EOeEmQlBPapnG/OKgZSmVLfRObAL9RBbrX2ik=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 23/75] dma-direct: fix data truncation in
 dma_direct_get_required_mask()
Date: Sat, 18 Apr 2020 10:08:18 -0400
Message-Id: <20200418140910.8280-23-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418140910.8280-1-sashal@kernel.org>
References: <20200418140910.8280-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Cc: Sasha Levin <sashal@kernel.org>, iommu@lists.linux-foundation.org,
 Christoph Hellwig <hch@lst.de>, Kishon Vijay Abraham I <kishon@ti.com>
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

From: Kishon Vijay Abraham I <kishon@ti.com>

[ Upstream commit cdcda0d1f8f4ab84efe7cd9921c98364398aefd7 ]

The upper 32-bit physical address gets truncated inadvertently
when dma_direct_get_required_mask() invokes phys_to_dma_direct().
This results in dma_addressing_limited() return incorrect value
when used in platforms with LPAE enabled.
Fix it here by explicitly type casting 'max_pfn' to phys_addr_t
in order to prevent overflow of intermediate value while evaluating
'(max_pfn - 1) << PAGE_SHIFT'.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/dma/direct.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 32ec69cdba544..310d96197d494 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -51,7 +51,8 @@ static inline struct page *dma_direct_to_page(struct device *dev,
 
 u64 dma_direct_get_required_mask(struct device *dev)
 {
-	u64 max_dma = phys_to_dma_direct(dev, (max_pfn - 1) << PAGE_SHIFT);
+	phys_addr_t phys = (phys_addr_t)(max_pfn - 1) << PAGE_SHIFT;
+	u64 max_dma = phys_to_dma_direct(dev, phys);
 
 	return (1ULL << (fls64(max_dma) - 1)) * 2 - 1;
 }
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
