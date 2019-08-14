Return-Path: <SRS0=gZYu=WK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E2EC433FF
	for <iommu@archiver.kernel.org>; Wed, 14 Aug 2019 18:04:16 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18BD02084F
	for <iommu@archiver.kernel.org>; Wed, 14 Aug 2019 18:04:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18BD02084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id D63DEE04;
	Wed, 14 Aug 2019 18:04:08 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 5717ADC9
	for <iommu@lists.linux-foundation.org>;
	Wed, 14 Aug 2019 18:04:07 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 4C50587E
	for <iommu@lists.linux-foundation.org>;
	Wed, 14 Aug 2019 18:04:05 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9BAC81682;
	Wed, 14 Aug 2019 10:57:01 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
	[10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9975F3F694; 
	Wed, 14 Aug 2019 10:56:59 -0700 (PDT)
From: Will Deacon <will@kernel.org>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 09/13] iommu/io-pgtable-arm: Call ->tlb_flush_walk() and
	->tlb_flush_leaf()
Date: Wed, 14 Aug 2019 18:56:30 +0100
Message-Id: <20190814175634.21081-10-will@kernel.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190814175634.21081-1-will@kernel.org>
References: <20190814175634.21081-1-will@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Vijay Kilary <vkilari@codeaurora.org>, Robin Murphy <robin.murphy@arm.com>,
	Jan Glauber <jglauber@marvell.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Jayachandran Chandrasekharan Nair <jnair@marvell.com>,
	Jon Masters <jcm@redhat.com>, David Woodhouse <dwmw2@infradead.org>,
	Will Deacon <will@kernel.org>
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
index 116f97ee991e..8d4914fe73bc 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -493,9 +493,8 @@ static int arm_v7s_map(struct io_pgtable_ops *ops, unsigned long iova,
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
@@ -541,8 +540,7 @@ static arm_v7s_iopte arm_v7s_split_cont(struct arm_v7s_io_pgtable *data,
 	__arm_v7s_pte_sync(ptep, ARM_V7S_CONT_PAGES, &iop->cfg);
 
 	size *= ARM_V7S_CONT_PAGES;
-	io_pgtable_tlb_add_flush(iop, iova, size, size, true);
-	io_pgtable_tlb_sync(iop);
+	io_pgtable_tlb_flush_leaf(iop, iova, size, size);
 	return pte;
 }
 
@@ -637,9 +635,8 @@ static size_t __arm_v7s_unmap(struct arm_v7s_io_pgtable *data,
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
@@ -805,13 +802,19 @@ static void dummy_tlb_flush_all(void *cookie)
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
@@ -819,6 +822,8 @@ static void dummy_tlb_sync(void *cookie)
 
 static const struct iommu_flush_ops dummy_tlb_ops = {
 	.tlb_flush_all	= dummy_tlb_flush_all,
+	.tlb_flush_walk	= dummy_tlb_flush,
+	.tlb_flush_leaf	= dummy_tlb_flush,
 	.tlb_add_flush	= dummy_tlb_add_flush,
 	.tlb_sync	= dummy_tlb_sync,
 };
diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 402f913b6f6d..b58338c86323 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -611,9 +611,8 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
 
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
@@ -1069,13 +1068,19 @@ static void dummy_tlb_flush_all(void *cookie)
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
@@ -1083,6 +1088,8 @@ static void dummy_tlb_sync(void *cookie)
 
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
