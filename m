Return-Path: <SRS0=Q5U9=VI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A1EC74A5B
	for <iommu@archiver.kernel.org>; Thu, 11 Jul 2019 17:29:39 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD27120863
	for <iommu@archiver.kernel.org>; Thu, 11 Jul 2019 17:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XtH4suVR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD27120863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id CB66A5473;
	Thu, 11 Jul 2019 17:28:55 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id CA603530E
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Jul 2019 17:19:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 565CB886
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Jul 2019 17:19:59 +0000 (UTC)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
	[217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id D615D20872;
	Thu, 11 Jul 2019 17:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562865599;
	bh=Bm5WvZoNx8rZEL4v4bTVmdWg8YP8awS1RW9fPqWbIe8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XtH4suVRbqWW/v3nZefwIrZHICYYGrt7hGmxLuYFW+EEV2wJp/Q2bsmRQCA9OLu0B
	D9Ijz4X3TsAF6RaOgxW73sEQRMhIYtSYGo/uIY92NzW2+CVFS+PyYWmTYVMVjoYsEm
	ReUuO4gRisa/VJShGgDOchQY+OxSWsliALHqrKF8=
From: Will Deacon <will@kernel.org>
To: iommu@lists.linux-foundation.org
Subject: [RFC PATCH v2 09/19] iommu/io-pgtable-arm: Call ->tlb_flush_walk()
	and ->tlb_flush_leaf()
Date: Thu, 11 Jul 2019 18:19:17 +0100
Message-Id: <20190711171927.28803-10-will@kernel.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190711171927.28803-1-will@kernel.org>
References: <20190711171927.28803-1-will@kernel.org>
Cc: Vijay Kilary <vkilari@codeaurora.org>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	Will Deacon <will@kernel.org>, Jan Glauber <jglauber@marvell.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Jayachandran Chandrasekharan Nair <jnair@marvell.com>,
	Jon Masters <jcm@redhat.com>, Robin Murphy <robin.murphy@arm.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Now that all IOMMU drivers using the io-pgtable API implement the
->tlb_flush_walk() and ->tlb_flush_leaf() callbacks, we can use them in
the io-pgtable code instead of ->tlb_add_flush() immediately followed by
->tlb_sync().

Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/iommu/io-pgtable-arm-v7s.c | 25 +++++++++++++++----------
 drivers/iommu/io-pgtable-arm.c     | 17 ++++++++++++-----
 include/linux/io-pgtable.h         | 14 ++++++++++++++
 3 files changed, 41 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index c0b352ce37a6..db8bd09c81a0 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -504,9 +504,8 @@ static int arm_v7s_map(struct io_pgtable_ops *ops, unsigned long iova,
 	 * a chance for anything to kick off a table walk for the new iova.
 	 */
 	if (iop->cfg.quirks & IO_PGTABLE_QUIRK_TLBI_ON_MAP) {
-		io_pgtable_tlb_add_flush(iop, iova, size,
-					 ARM_V7S_BLOCK_SIZE(2), false);
-		io_pgtable_tlb_sync(iop);
+		io_pgtable_tlb_flush_walk(iop, iova, size,
+					  ARM_V7S_BLOCK_SIZE(2));
 	} else {
 		wmb();
 	}
@@ -552,8 +551,7 @@ static arm_v7s_iopte arm_v7s_split_cont(struct arm_v7s_io_pgtable *data,
 	__arm_v7s_pte_sync(ptep, ARM_V7S_CONT_PAGES, &iop->cfg);
 
 	size *= ARM_V7S_CONT_PAGES;
-	io_pgtable_tlb_add_flush(iop, iova, size, size, true);
-	io_pgtable_tlb_sync(iop);
+	io_pgtable_tlb_flush_leaf(iop, iova, size, size);
 	return pte;
 }
 
@@ -648,9 +646,8 @@ static size_t __arm_v7s_unmap(struct arm_v7s_io_pgtable *data,
 		for (i = 0; i < num_entries; i++) {
 			if (ARM_V7S_PTE_IS_TABLE(pte[i], lvl)) {
 				/* Also flush any partial walks */
-				io_pgtable_tlb_add_flush(iop, iova, blk_size,
-					ARM_V7S_BLOCK_SIZE(lvl + 1), false);
-				io_pgtable_tlb_sync(iop);
+				io_pgtable_tlb_flush_walk(iop, iova, blk_size,
+						ARM_V7S_BLOCK_SIZE(lvl + 1));
 				ptep = iopte_deref(pte[i], lvl);
 				__arm_v7s_free_table(ptep, lvl + 1, data);
 			} else if (iop->cfg.quirks & IO_PGTABLE_QUIRK_NON_STRICT) {
@@ -816,13 +813,19 @@ static void dummy_tlb_flush_all(void *cookie)
 	WARN_ON(cookie != cfg_cookie);
 }
 
-static void dummy_tlb_add_flush(unsigned long iova, size_t size,
-				size_t granule, bool leaf, void *cookie)
+static void dummy_tlb_flush(unsigned long iova, size_t size, size_t granule,
+			    void *cookie)
 {
 	WARN_ON(cookie != cfg_cookie);
 	WARN_ON(!(size & cfg_cookie->pgsize_bitmap));
 }
 
+static void dummy_tlb_add_flush(unsigned long iova, size_t size,
+				size_t granule, bool leaf, void *cookie)
+{
+	dummy_tlb_flush(iova, size, granule, cookie);
+}
+
 static void dummy_tlb_sync(void *cookie)
 {
 	WARN_ON(cookie != cfg_cookie);
@@ -830,6 +833,8 @@ static void dummy_tlb_sync(void *cookie)
 
 static const struct iommu_flush_ops dummy_tlb_ops = {
 	.tlb_flush_all	= dummy_tlb_flush_all,
+	.tlb_flush_walk	= dummy_tlb_flush,
+	.tlb_flush_leaf	= dummy_tlb_flush,
 	.tlb_add_flush	= dummy_tlb_add_flush,
 	.tlb_sync	= dummy_tlb_sync,
 };
diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 8587622afecd..91b3c16d0afd 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -622,9 +622,8 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
 
 		if (!iopte_leaf(pte, lvl, iop->fmt)) {
 			/* Also flush any partial walks */
-			io_pgtable_tlb_add_flush(iop, iova, size,
-						ARM_LPAE_GRANULE(data), false);
-			io_pgtable_tlb_sync(iop);
+			io_pgtable_tlb_flush_walk(iop, iova, size,
+						  ARM_LPAE_GRANULE(data));
 			ptep = iopte_deref(pte, data);
 			__arm_lpae_free_pgtable(data, lvl + 1, ptep);
 		} else if (iop->cfg.quirks & IO_PGTABLE_QUIRK_NON_STRICT) {
@@ -1080,13 +1079,19 @@ static void dummy_tlb_flush_all(void *cookie)
 	WARN_ON(cookie != cfg_cookie);
 }
 
-static void dummy_tlb_add_flush(unsigned long iova, size_t size,
-				size_t granule, bool leaf, void *cookie)
+static void dummy_tlb_flush(unsigned long iova, size_t size, size_t granule,
+			    void *cookie)
 {
 	WARN_ON(cookie != cfg_cookie);
 	WARN_ON(!(size & cfg_cookie->pgsize_bitmap));
 }
 
+static void dummy_tlb_add_flush(unsigned long iova, size_t size,
+				size_t granule, bool leaf, void *cookie)
+{
+	dummy_tlb_flush(iova, size, granule, cookie);
+}
+
 static void dummy_tlb_sync(void *cookie)
 {
 	WARN_ON(cookie != cfg_cookie);
@@ -1094,6 +1099,8 @@ static void dummy_tlb_sync(void *cookie)
 
 static const struct iommu_flush_ops dummy_tlb_ops __initconst = {
 	.tlb_flush_all	= dummy_tlb_flush_all,
+	.tlb_flush_walk	= dummy_tlb_flush,
+	.tlb_flush_leaf	= dummy_tlb_flush,
 	.tlb_add_flush	= dummy_tlb_add_flush,
 	.tlb_sync	= dummy_tlb_sync,
 };
diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index 27275575b305..0618aac59e74 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -198,6 +198,20 @@ static inline void io_pgtable_tlb_flush_all(struct io_pgtable *iop)
 	iop->cfg.tlb->tlb_flush_all(iop->cookie);
 }
 
+static inline void
+io_pgtable_tlb_flush_walk(struct io_pgtable *iop, unsigned long iova,
+			  size_t size, size_t granule)
+{
+	iop->cfg.tlb->tlb_flush_walk(iova, size, granule, iop->cookie);
+}
+
+static inline void
+io_pgtable_tlb_flush_leaf(struct io_pgtable *iop, unsigned long iova,
+			  size_t size, size_t granule)
+{
+	iop->cfg.tlb->tlb_flush_leaf(iova, size, granule, iop->cookie);
+}
+
 static inline void io_pgtable_tlb_add_flush(struct io_pgtable *iop,
 		unsigned long iova, size_t size, size_t granule, bool leaf)
 {
-- 
2.11.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
