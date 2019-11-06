Return-Path: <SRS0=/wjm=Y6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D32C5DF63
	for <iommu@archiver.kernel.org>; Wed,  6 Nov 2019 13:05:30 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DA952187F
	for <iommu@archiver.kernel.org>; Wed,  6 Nov 2019 13:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lI3v298d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DA952187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id E55EECAE;
	Wed,  6 Nov 2019 13:03:59 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id CC105B2F
	for <iommu@lists.linux-foundation.org>;
	Wed,  6 Nov 2019 13:03:58 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 7FF4E67F
	for <iommu@lists.linux-foundation.org>;
	Wed,  6 Nov 2019 13:03:58 +0000 (UTC)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
	[217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 51F62217F4;
	Wed,  6 Nov 2019 13:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573045438;
	bh=6WaCVDc7pfRWRO9QZ070Q1q5hzzHRBDNhxzTPhdW8P4=;
	h=From:To:Cc:Subject:Date:From;
	b=lI3v298diJ07G4ZqSbKvZgy79OwfBKcusuJkPT6DZpn4YHpaZT65Pff8K3IatTNS+
	8QH7JytyH099Pj18ArgJsTe6ph9h9u7NKRgSfjDsnLFgmRipIw6OSeEbHCH1OfKr+k
	5WK++iikcT09n1YgcQMAoIyQy2HmQvW6vxdML5Fg=
From: Will Deacon <will@kernel.org>
To: iommu@lists.linux-foundation.org
Subject: [PATCH] iommu/io-pgtable-arm: Rename IOMMU_QCOM_SYS_CACHE and improve
	doc
Date: Wed,  6 Nov 2019 13:03:52 +0000
Message-Id: <20191106130352.6457-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: isaacm@codeaurora.org, Will Deacon <will@kernel.org>, robin.murphy@arm.com
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

The 'IOMMU_QCOM_SYS_CACHE' IOMMU protection flag is exposed to all
users of the IOMMU API. Despite its name, the idea behind it isn't
especially tied to Qualcomm implementations and could conceivably be
used by other systems.

Rename it to 'IOMMU_SYS_CACHE_ONLY' and update the comment to describe
a bit better the idea behind it.

Signed-off-by: Will Deacon <will@kernel.org>
---

I'll remove this entirely if we don't grow a user in 5.6, but for now
let's make it a bit more generic.

 drivers/iommu/io-pgtable-arm.c | 2 +-
 include/linux/iommu.h          | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index ca51036aa53c..602ecac84645 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -464,7 +464,7 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
 		else if (prot & IOMMU_CACHE)
 			pte |= (ARM_LPAE_MAIR_ATTR_IDX_CACHE
 				<< ARM_LPAE_PTE_ATTRINDX_SHIFT);
-		else if (prot & IOMMU_QCOM_SYS_CACHE)
+		else if (prot & IOMMU_SYS_CACHE_ONLY)
 			pte |= (ARM_LPAE_MAIR_ATTR_IDX_INC_OCACHE
 				<< ARM_LPAE_PTE_ATTRINDX_SHIFT);
 	}
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 29bac5345563..a86bd21d08a9 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -31,11 +31,11 @@
  */
 #define IOMMU_PRIV	(1 << 5)
 /*
- * Non-coherent masters on few Qualcomm SoCs can use this page protection flag
- * to set correct cacheability attributes to use an outer level of cache -
- * last level cache, aka system cache.
+ * Non-coherent masters can use this page protection flag to set cacheable
+ * memory attributes for only a transparent outer level of cache, also known as
+ * the last-level or system cache.
  */
-#define IOMMU_QCOM_SYS_CACHE	(1 << 6)
+#define IOMMU_SYS_CACHE_ONLY	(1 << 6)
 
 struct iommu_ops;
 struct iommu_group;
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
