Return-Path: <SRS0=gZYu=WK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96754C433FF
	for <iommu@archiver.kernel.org>; Wed, 14 Aug 2019 18:05:18 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 790452084F
	for <iommu@archiver.kernel.org>; Wed, 14 Aug 2019 18:05:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 790452084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 8303FE36;
	Wed, 14 Aug 2019 18:04:13 +0000 (UTC)
Received: from smtp2.linuxfoundation.org (smtp2.linux-foundation.org
	[172.17.192.36])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 13BD3E18
	for <iommu@lists.linux-foundation.org>;
	Wed, 14 Aug 2019 18:04:09 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp2.linuxfoundation.org (Postfix) with ESMTP id 0D3211DCF0
	for <iommu@lists.linux-foundation.org>;
	Wed, 14 Aug 2019 18:04:08 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D2DB16A3;
	Wed, 14 Aug 2019 10:57:10 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
	[10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8B2263F694; 
	Wed, 14 Aug 2019 10:57:08 -0700 (PDT)
From: Will Deacon <will@kernel.org>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 13/13] iommu/io-pgtable: Pass struct iommu_iotlb_gather to
	->tlb_add_page()
Date: Wed, 14 Aug 2019 18:56:34 +0100
Message-Id: <20190814175634.21081-14-will@kernel.org>
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

With all the pieces in place, we can finally propagate the
iommu_iotlb_gather structure from the call to unmap() down to the IOMMU
drivers' implementation of ->tlb_add_page(). Currently everybody ignores
it, but the machinery is now there to defer invalidation.

Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/iommu/arm-smmu-v3.c        |  3 ++-
 drivers/iommu/arm-smmu.c           |  3 ++-
 drivers/iommu/io-pgtable-arm-v7s.c | 23 ++++++++++++++---------
 drivers/iommu/io-pgtable-arm.c     | 22 ++++++++++++++--------
 drivers/iommu/msm_iommu.c          |  3 ++-
 drivers/iommu/mtk_iommu.c          |  3 ++-
 drivers/iommu/qcom_iommu.c         |  3 ++-
 include/linux/io-pgtable.h         | 16 +++++++++-------
 8 files changed, 47 insertions(+), 29 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 8e2e53079f48..d1ebc7103065 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1596,7 +1596,8 @@ static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
 	} while (size -= granule);
 }
 
-static void arm_smmu_tlb_inv_page_nosync(unsigned long iova, size_t granule,
+static void arm_smmu_tlb_inv_page_nosync(struct iommu_iotlb_gather *gather,
+					 unsigned long iova, size_t granule,
 					 void *cookie)
 {
 	arm_smmu_tlb_inv_range_nosync(iova, granule, granule, true, cookie);
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index f6689956ab6e..5598d0ff71a8 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -574,7 +574,8 @@ static void arm_smmu_tlb_inv_leaf(unsigned long iova, size_t size,
 	ops->tlb_sync(cookie);
 }
 
-static void arm_smmu_tlb_add_page(unsigned long iova, size_t granule,
+static void arm_smmu_tlb_add_page(struct iommu_iotlb_gather *gather,
+				  unsigned long iova, size_t granule,
 				  void *cookie)
 {
 	struct arm_smmu_domain *smmu_domain = cookie;
diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index a7776e982b6c..18e7d212c7de 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -362,7 +362,8 @@ static bool arm_v7s_pte_is_cont(arm_v7s_iopte pte, int lvl)
 	return false;
 }
 
-static size_t __arm_v7s_unmap(struct arm_v7s_io_pgtable *, unsigned long,
+static size_t __arm_v7s_unmap(struct arm_v7s_io_pgtable *,
+			      struct iommu_iotlb_gather *, unsigned long,
 			      size_t, int, arm_v7s_iopte *);
 
 static int arm_v7s_init_pte(struct arm_v7s_io_pgtable *data,
@@ -383,7 +384,7 @@ static int arm_v7s_init_pte(struct arm_v7s_io_pgtable *data,
 			size_t sz = ARM_V7S_BLOCK_SIZE(lvl);
 
 			tblp = ptep - ARM_V7S_LVL_IDX(iova, lvl);
-			if (WARN_ON(__arm_v7s_unmap(data, iova + i * sz,
+			if (WARN_ON(__arm_v7s_unmap(data, NULL, iova + i * sz,
 						    sz, lvl, tblp) != sz))
 				return -EINVAL;
 		} else if (ptep[i]) {
@@ -545,6 +546,7 @@ static arm_v7s_iopte arm_v7s_split_cont(struct arm_v7s_io_pgtable *data,
 }
 
 static size_t arm_v7s_split_blk_unmap(struct arm_v7s_io_pgtable *data,
+				      struct iommu_iotlb_gather *gather,
 				      unsigned long iova, size_t size,
 				      arm_v7s_iopte blk_pte,
 				      arm_v7s_iopte *ptep)
@@ -581,14 +583,15 @@ static size_t arm_v7s_split_blk_unmap(struct arm_v7s_io_pgtable *data,
 			return 0;
 
 		tablep = iopte_deref(pte, 1);
-		return __arm_v7s_unmap(data, iova, size, 2, tablep);
+		return __arm_v7s_unmap(data, gather, iova, size, 2, tablep);
 	}
 
-	io_pgtable_tlb_add_page(&data->iop, iova, size);
+	io_pgtable_tlb_add_page(&data->iop, gather, iova, size);
 	return size;
 }
 
 static size_t __arm_v7s_unmap(struct arm_v7s_io_pgtable *data,
+			      struct iommu_iotlb_gather *gather,
 			      unsigned long iova, size_t size, int lvl,
 			      arm_v7s_iopte *ptep)
 {
@@ -647,7 +650,7 @@ static size_t __arm_v7s_unmap(struct arm_v7s_io_pgtable *data,
 				 */
 				smp_wmb();
 			} else {
-				io_pgtable_tlb_add_page(iop, iova, blk_size);
+				io_pgtable_tlb_add_page(iop, gather, iova, blk_size);
 			}
 			iova += blk_size;
 		}
@@ -657,12 +660,13 @@ static size_t __arm_v7s_unmap(struct arm_v7s_io_pgtable *data,
 		 * Insert a table at the next level to map the old region,
 		 * minus the part we want to unmap
 		 */
-		return arm_v7s_split_blk_unmap(data, iova, size, pte[0], ptep);
+		return arm_v7s_split_blk_unmap(data, gather, iova, size, pte[0],
+					       ptep);
 	}
 
 	/* Keep on walkin' */
 	ptep = iopte_deref(pte[0], lvl);
-	return __arm_v7s_unmap(data, iova, size, lvl + 1, ptep);
+	return __arm_v7s_unmap(data, gather, iova, size, lvl + 1, ptep);
 }
 
 static size_t arm_v7s_unmap(struct io_pgtable_ops *ops, unsigned long iova,
@@ -673,7 +677,7 @@ static size_t arm_v7s_unmap(struct io_pgtable_ops *ops, unsigned long iova,
 	if (WARN_ON(upper_32_bits(iova)))
 		return 0;
 
-	return __arm_v7s_unmap(data, iova, size, 1, data->pgd);
+	return __arm_v7s_unmap(data, gather, iova, size, 1, data->pgd);
 }
 
 static phys_addr_t arm_v7s_iova_to_phys(struct io_pgtable_ops *ops,
@@ -808,7 +812,8 @@ static void dummy_tlb_flush(unsigned long iova, size_t size, size_t granule,
 	WARN_ON(!(size & cfg_cookie->pgsize_bitmap));
 }
 
-static void dummy_tlb_add_page(unsigned long iova, size_t granule, void *cookie)
+static void dummy_tlb_add_page(struct iommu_iotlb_gather *gather,
+			       unsigned long iova, size_t granule, void *cookie)
 {
 	dummy_tlb_flush(iova, granule, granule, cookie);
 }
diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 325430f8a0a1..4c91359057c5 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -289,6 +289,7 @@ static void __arm_lpae_set_pte(arm_lpae_iopte *ptep, arm_lpae_iopte pte,
 }
 
 static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
+			       struct iommu_iotlb_gather *gather,
 			       unsigned long iova, size_t size, int lvl,
 			       arm_lpae_iopte *ptep);
 
@@ -334,8 +335,10 @@ static int arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
 		size_t sz = ARM_LPAE_BLOCK_SIZE(lvl, data);
 
 		tblp = ptep - ARM_LPAE_LVL_IDX(iova, lvl, data);
-		if (WARN_ON(__arm_lpae_unmap(data, iova, sz, lvl, tblp) != sz))
+		if (__arm_lpae_unmap(data, NULL, iova, sz, lvl, tblp) != sz) {
+			WARN_ON(1);
 			return -EINVAL;
+		}
 	}
 
 	__arm_lpae_init_pte(data, paddr, prot, lvl, ptep);
@@ -536,6 +539,7 @@ static void arm_lpae_free_pgtable(struct io_pgtable *iop)
 }
 
 static size_t arm_lpae_split_blk_unmap(struct arm_lpae_io_pgtable *data,
+				       struct iommu_iotlb_gather *gather,
 				       unsigned long iova, size_t size,
 				       arm_lpae_iopte blk_pte, int lvl,
 				       arm_lpae_iopte *ptep)
@@ -581,14 +585,15 @@ static size_t arm_lpae_split_blk_unmap(struct arm_lpae_io_pgtable *data,
 
 		tablep = iopte_deref(pte, data);
 	} else if (unmap_idx >= 0) {
-		io_pgtable_tlb_add_page(&data->iop, iova, size);
+		io_pgtable_tlb_add_page(&data->iop, gather, iova, size);
 		return size;
 	}
 
-	return __arm_lpae_unmap(data, iova, size, lvl, tablep);
+	return __arm_lpae_unmap(data, gather, iova, size, lvl, tablep);
 }
 
 static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
+			       struct iommu_iotlb_gather *gather,
 			       unsigned long iova, size_t size, int lvl,
 			       arm_lpae_iopte *ptep)
 {
@@ -622,7 +627,7 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
 			 */
 			smp_wmb();
 		} else {
-			io_pgtable_tlb_add_page(iop, iova, size);
+			io_pgtable_tlb_add_page(iop, gather, iova, size);
 		}
 
 		return size;
@@ -631,13 +636,13 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
 		 * Insert a table at the next level to map the old region,
 		 * minus the part we want to unmap
 		 */
-		return arm_lpae_split_blk_unmap(data, iova, size, pte,
+		return arm_lpae_split_blk_unmap(data, gather, iova, size, pte,
 						lvl + 1, ptep);
 	}
 
 	/* Keep on walkin' */
 	ptep = iopte_deref(pte, data);
-	return __arm_lpae_unmap(data, iova, size, lvl + 1, ptep);
+	return __arm_lpae_unmap(data, gather, iova, size, lvl + 1, ptep);
 }
 
 static size_t arm_lpae_unmap(struct io_pgtable_ops *ops, unsigned long iova,
@@ -650,7 +655,7 @@ static size_t arm_lpae_unmap(struct io_pgtable_ops *ops, unsigned long iova,
 	if (WARN_ON(iova >= (1ULL << data->iop.cfg.ias)))
 		return 0;
 
-	return __arm_lpae_unmap(data, iova, size, lvl, ptep);
+	return __arm_lpae_unmap(data, gather, iova, size, lvl, ptep);
 }
 
 static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
@@ -1074,7 +1079,8 @@ static void dummy_tlb_flush(unsigned long iova, size_t size, size_t granule,
 	WARN_ON(!(size & cfg_cookie->pgsize_bitmap));
 }
 
-static void dummy_tlb_add_page(unsigned long iova, size_t granule, void *cookie)
+static void dummy_tlb_add_page(struct iommu_iotlb_gather *gather,
+			       unsigned long iova, size_t granule, void *cookie)
 {
 	dummy_tlb_flush(iova, granule, granule, cookie);
 }
diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 8a0dcaf0a9e9..4c0be5b75c28 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -180,7 +180,8 @@ static void __flush_iotlb_leaf(unsigned long iova, size_t size,
 	__flush_iotlb_range(iova, size, granule, true, cookie);
 }
 
-static void __flush_iotlb_page(unsigned long iova, size_t granule, void *cookie)
+static void __flush_iotlb_page(struct iommu_iotlb_gather *gather,
+			       unsigned long iova, size_t granule, void *cookie)
 {
 	__flush_iotlb_range(iova, granule, granule, true, cookie);
 }
diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index b73cffd63262..0827d51936fa 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -202,7 +202,8 @@ static void mtk_iommu_tlb_flush_leaf(unsigned long iova, size_t size,
 	mtk_iommu_tlb_sync(cookie);
 }
 
-static void mtk_iommu_tlb_flush_page_nosync(unsigned long iova, size_t granule,
+static void mtk_iommu_tlb_flush_page_nosync(struct iommu_iotlb_gather *gather,
+					    unsigned long iova, size_t granule,
 					    void *cookie)
 {
 	mtk_iommu_tlb_add_flush_nosync(iova, granule, granule, true, cookie);
diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/qcom_iommu.c
index 48b288ef74b4..eac760cdbb28 100644
--- a/drivers/iommu/qcom_iommu.c
+++ b/drivers/iommu/qcom_iommu.c
@@ -178,7 +178,8 @@ static void qcom_iommu_tlb_flush_leaf(unsigned long iova, size_t size,
 	qcom_iommu_tlb_sync(cookie);
 }
 
-static void qcom_iommu_tlb_add_page(unsigned long iova, size_t granule,
+static void qcom_iommu_tlb_add_page(struct iommu_iotlb_gather *gather,
+				    unsigned long iova, size_t granule,
 				    void *cookie)
 {
 	qcom_iommu_tlb_inv_range_nosync(iova, granule, granule, true, cookie);
diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index fe27d93c8ad9..6b1b8be3ebec 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -28,10 +28,10 @@ enum io_pgtable_fmt {
  * @tlb_flush_leaf: Synchronously invalidate all leaf TLB state for a virtual
  *                  address range.
  * @tlb_add_page:   Optional callback to queue up leaf TLB invalidation for a
- *                  single page. This function exists purely as an optimisation
- *                  for IOMMUs that cannot batch TLB invalidation operations
- *                  efficiently and are therefore better suited to issuing them
- *                  early rather than deferring them until iommu_tlb_sync().
+ *                  single page.  IOMMUs that cannot batch TLB invalidation
+ *                  operations efficiently will typically issue them here, but
+ *                  others may decide to update the iommu_iotlb_gather structure
+ *                  and defer the invalidation until iommu_tlb_sync() instead.
  *
  * Note that these can all be called in atomic context and must therefore
  * not block.
@@ -42,7 +42,8 @@ struct iommu_flush_ops {
 			       void *cookie);
 	void (*tlb_flush_leaf)(unsigned long iova, size_t size, size_t granule,
 			       void *cookie);
-	void (*tlb_add_page)(unsigned long iova, size_t granule, void *cookie);
+	void (*tlb_add_page)(struct iommu_iotlb_gather *gather,
+			     unsigned long iova, size_t granule, void *cookie);
 };
 
 /**
@@ -209,11 +210,12 @@ io_pgtable_tlb_flush_leaf(struct io_pgtable *iop, unsigned long iova,
 }
 
 static inline void
-io_pgtable_tlb_add_page(struct io_pgtable *iop, unsigned long iova,
+io_pgtable_tlb_add_page(struct io_pgtable *iop,
+			struct iommu_iotlb_gather * gather, unsigned long iova,
 			size_t granule)
 {
 	if (iop->cfg.tlb->tlb_add_page)
-		iop->cfg.tlb->tlb_add_page(iova, granule, iop->cookie);
+		iop->cfg.tlb->tlb_add_page(gather, iova, granule, iop->cookie);
 }
 
 /**
-- 
2.11.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
