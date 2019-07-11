Return-Path: <SRS0=Q5U9=VI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47592C71142
	for <iommu@archiver.kernel.org>; Thu, 11 Jul 2019 17:29:44 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A35920863
	for <iommu@archiver.kernel.org>; Thu, 11 Jul 2019 17:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qf36/H2c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A35920863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 1F23C54BA;
	Thu, 11 Jul 2019 17:28:56 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 47CDB547A
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Jul 2019 17:20:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 37FDC886
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Jul 2019 17:20:02 +0000 (UTC)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
	[217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 9FC0A216C8;
	Thu, 11 Jul 2019 17:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562865602;
	bh=XDCtHDg0NRVe98kf2wvqDRO6eKjAiiKsPPkkf8LVgSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qf36/H2cUnYo9n830VTjmMfD5YE25Y1k96czu/ypHGWvHVf58b0M0IbTjTOEydpPq
	BEJC5w2waVPVOvgWmeOs/cvCtDyH+Q1y2MB9QG6WHqV2Hsq5JccfMT8qFnwSCIf1tF
	lsTntnYNZGykwb1ZwjUcV6HnWus28KWl00W/eDYc=
From: Will Deacon <will@kernel.org>
To: iommu@lists.linux-foundation.org
Subject: [RFC PATCH v2 10/19] iommu/io-pgtable: Replace ->tlb_add_flush() with
	->tlb_add_page()
Date: Thu, 11 Jul 2019 18:19:18 +0100
Message-Id: <20190711171927.28803-11-will@kernel.org>
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

The ->tlb_add_flush() callback in the io-pgtable API now looks a bit
silly:

  - It takes a size and a granule, which are always the same
  - It takes a 'bool leaf', which is always true
  - It only ever flushes a single page

With that in mind, replace it with an optional ->tlb_add_page() callback
that drops the useless parameters.

Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/gpu/drm/panfrost/panfrost_mmu.c |  5 --
 drivers/iommu/arm-smmu-v3.c             |  8 ++-
 drivers/iommu/arm-smmu.c                | 88 +++++++++++++++++++++------------
 drivers/iommu/io-pgtable-arm-v7s.c      | 12 ++---
 drivers/iommu/io-pgtable-arm.c          | 11 ++---
 drivers/iommu/ipmmu-vmsa.c              |  7 ---
 drivers/iommu/msm_iommu.c               |  7 ++-
 drivers/iommu/mtk_iommu.c               |  8 ++-
 drivers/iommu/qcom_iommu.c              |  8 ++-
 include/linux/io-pgtable.h              | 22 ++++-----
 10 files changed, 105 insertions(+), 71 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
index 7018ede0a90d..d2cfa0ed32b8 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -239,10 +239,6 @@ static void mmu_tlb_inv_context_s1(void *cookie)
 	mmu_hw_do_operation(pfdev, 0, 0, ~0UL, AS_COMMAND_FLUSH_MEM);
 }
 
-static void mmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
-				     size_t granule, bool leaf, void *cookie)
-{}
-
 static void mmu_tlb_sync_context(void *cookie)
 {
 	//struct panfrost_device *pfdev = cookie;
@@ -265,7 +261,6 @@ static const struct iommu_flush_ops mmu_tlb_ops = {
 	.tlb_flush_all	= mmu_tlb_inv_context_s1,
 	.tlb_flush_walk = mmu_tlb_flush_walk,
 	.tlb_flush_leaf = mmu_tlb_flush_leaf,
-	.tlb_add_flush	= mmu_tlb_inv_range_nosync,
 	.tlb_sync	= mmu_tlb_sync_context,
 };
 
diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 64141ba53a79..feea1b6ca127 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1597,6 +1597,12 @@ static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
 	} while (size -= granule);
 }
 
+static void arm_smmu_tlb_inv_page_nosync(unsigned long iova, size_t granule,
+					 void *cookie)
+{
+	arm_smmu_tlb_inv_range_nosync(iova, granule, granule, true, cookie);
+}
+
 static void arm_smmu_tlb_inv_walk(unsigned long iova, size_t size,
 				  size_t granule, void *cookie)
 {
@@ -1621,7 +1627,7 @@ static const struct iommu_flush_ops arm_smmu_flush_ops = {
 	.tlb_flush_all	= arm_smmu_tlb_inv_context,
 	.tlb_flush_walk = arm_smmu_tlb_inv_walk,
 	.tlb_flush_leaf = arm_smmu_tlb_inv_leaf,
-	.tlb_add_flush	= arm_smmu_tlb_inv_range_nosync,
+	.tlb_add_page	= arm_smmu_tlb_inv_page_nosync,
 	.tlb_sync	= arm_smmu_tlb_sync,
 };
 
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index a06dca4bb2d5..30ed97cd3993 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -251,10 +251,16 @@ enum arm_smmu_domain_stage {
 	ARM_SMMU_DOMAIN_BYPASS,
 };
 
+struct arm_smmu_flush_ops {
+	struct iommu_flush_ops		tlb;
+	void (*tlb_inv_range)(unsigned long iova, size_t size, size_t granule,
+			      bool leaf, void *cookie)
+};
+
 struct arm_smmu_domain {
 	struct arm_smmu_device		*smmu;
 	struct io_pgtable_ops		*pgtbl_ops;
-	const struct iommu_flush_ops	*tlb_ops;
+	const struct arm_smmu_flush_ops	*flush_ops;
 	struct arm_smmu_cfg		cfg;
 	enum arm_smmu_domain_stage	stage;
 	bool				non_strict;
@@ -554,42 +560,62 @@ static void arm_smmu_tlb_inv_walk(unsigned long iova, size_t size,
 				  size_t granule, void *cookie)
 {
 	struct arm_smmu_domain *smmu_domain = cookie;
+	const struct arm_smmu_flush_ops *ops = smmu_domain->flush_ops;
 
-	smmu_domain->tlb_ops->tlb_add_flush(iova, size, granule, false, cookie);
-	smmu_domain->tlb_ops->tlb_sync(cookie);
+	ops->tlb_inv_range(iova, size, granule, false, cookie);
+	ops->tlb.tlb_sync(cookie);
 }
 
 static void arm_smmu_tlb_inv_leaf(unsigned long iova, size_t size,
 				  size_t granule, void *cookie)
 {
 	struct arm_smmu_domain *smmu_domain = cookie;
+	const struct arm_smmu_flush_ops *ops = smmu_domain->flush_ops;
+
+	ops->tlb_inv_range(iova, size, granule, true, cookie);
+	ops->tlb.tlb_sync(cookie);
+}
+
+static void arm_smmu_tlb_add_page(unsigned long iova, size_t granule,
+				  void *cookie)
+{
+	struct arm_smmu_domain *smmu_domain = cookie;
+	const struct arm_smmu_flush_ops *ops = smmu_domain->flush_ops;
 
-	smmu_domain->tlb_ops->tlb_add_flush(iova, size, granule, true, cookie);
-	smmu_domain->tlb_ops->tlb_sync(cookie);
+	ops->tlb_inv_range(iova, granule, granule, true, cookie);
 }
 
-static const struct iommu_flush_ops arm_smmu_s1_tlb_ops = {
-	.tlb_flush_all	= arm_smmu_tlb_inv_context_s1,
-	.tlb_flush_walk	= arm_smmu_tlb_inv_walk,
-	.tlb_flush_leaf	= arm_smmu_tlb_inv_leaf,
-	.tlb_add_flush	= arm_smmu_tlb_inv_range_nosync,
-	.tlb_sync	= arm_smmu_tlb_sync_context,
+static const struct arm_smmu_flush_ops arm_smmu_s1_tlb_ops = {
+	.tlb = {
+		.tlb_flush_all	= arm_smmu_tlb_inv_context_s1,
+		.tlb_flush_walk	= arm_smmu_tlb_inv_walk,
+		.tlb_flush_leaf	= arm_smmu_tlb_inv_leaf,
+		.tlb_add_page	= arm_smmu_tlb_add_page,
+		.tlb_sync	= arm_smmu_tlb_sync_context,
+	},
+	.tlb_inv_range		= arm_smmu_tlb_inv_range_nosync,
 };
 
-static const struct iommu_flush_ops arm_smmu_s2_tlb_ops_v2 = {
-	.tlb_flush_all	= arm_smmu_tlb_inv_context_s2,
-	.tlb_flush_walk	= arm_smmu_tlb_inv_walk,
-	.tlb_flush_leaf	= arm_smmu_tlb_inv_leaf,
-	.tlb_add_flush	= arm_smmu_tlb_inv_range_nosync,
-	.tlb_sync	= arm_smmu_tlb_sync_context,
+static const struct arm_smmu_flush_ops arm_smmu_s2_tlb_ops_v2 = {
+	.tlb = {
+		.tlb_flush_all	= arm_smmu_tlb_inv_context_s2,
+		.tlb_flush_walk	= arm_smmu_tlb_inv_walk,
+		.tlb_flush_leaf	= arm_smmu_tlb_inv_leaf,
+		.tlb_add_page	= arm_smmu_tlb_add_page,
+		.tlb_sync	= arm_smmu_tlb_sync_context,
+	},
+	.tlb_inv_range		= arm_smmu_tlb_inv_range_nosync,
 };
 
-static const struct iommu_flush_ops arm_smmu_s2_tlb_ops_v1 = {
-	.tlb_flush_all	= arm_smmu_tlb_inv_context_s2,
-	.tlb_flush_walk	= arm_smmu_tlb_inv_walk,
-	.tlb_flush_leaf	= arm_smmu_tlb_inv_leaf,
-	.tlb_add_flush	= arm_smmu_tlb_inv_vmid_nosync,
-	.tlb_sync	= arm_smmu_tlb_sync_vmid,
+static const struct arm_smmu_flush_ops arm_smmu_s2_tlb_ops_v1 = {
+	.tlb = {
+		.tlb_flush_all	= arm_smmu_tlb_inv_context_s2,
+		.tlb_flush_walk	= arm_smmu_tlb_inv_walk,
+		.tlb_flush_leaf	= arm_smmu_tlb_inv_leaf,
+		.tlb_add_page	= arm_smmu_tlb_add_page,
+		.tlb_sync	= arm_smmu_tlb_sync_vmid,
+	},
+	.tlb_inv_range		= arm_smmu_tlb_inv_vmid_nosync,
 };
 
 static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
@@ -869,7 +895,7 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 			ias = min(ias, 32UL);
 			oas = min(oas, 32UL);
 		}
-		smmu_domain->tlb_ops = &arm_smmu_s1_tlb_ops;
+		smmu_domain->flush_ops = &arm_smmu_s1_tlb_ops;
 		break;
 	case ARM_SMMU_DOMAIN_NESTED:
 		/*
@@ -889,9 +915,9 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 			oas = min(oas, 40UL);
 		}
 		if (smmu->version == ARM_SMMU_V2)
-			smmu_domain->tlb_ops = &arm_smmu_s2_tlb_ops_v2;
+			smmu_domain->flush_ops = &arm_smmu_s2_tlb_ops_v2;
 		else
-			smmu_domain->tlb_ops = &arm_smmu_s2_tlb_ops_v1;
+			smmu_domain->flush_ops = &arm_smmu_s2_tlb_ops_v1;
 		break;
 	default:
 		ret = -EINVAL;
@@ -920,7 +946,7 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 		.ias		= ias,
 		.oas		= oas,
 		.coherent_walk	= smmu->features & ARM_SMMU_FEAT_COHERENT_WALK,
-		.tlb		= smmu_domain->tlb_ops,
+		.tlb		= &smmu_domain->flush_ops->tlb,
 		.iommu_dev	= smmu->dev,
 	};
 
@@ -1349,9 +1375,9 @@ static void arm_smmu_flush_iotlb_all(struct iommu_domain *domain)
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 
-	if (smmu_domain->tlb_ops) {
+	if (smmu_domain->flush_ops) {
 		arm_smmu_rpm_get(smmu);
-		smmu_domain->tlb_ops->tlb_flush_all(smmu_domain);
+		smmu_domain->flush_ops->tlb.tlb_flush_all(smmu_domain);
 		arm_smmu_rpm_put(smmu);
 	}
 }
@@ -1362,9 +1388,9 @@ static void arm_smmu_iotlb_sync(struct iommu_domain *domain,
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 
-	if (smmu_domain->tlb_ops) {
+	if (smmu_domain->flush_ops) {
 		arm_smmu_rpm_get(smmu);
-		smmu_domain->tlb_ops->tlb_sync(smmu_domain);
+		smmu_domain->flush_ops->tlb.tlb_sync(smmu_domain);
 		arm_smmu_rpm_put(smmu);
 	}
 }
diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index db8bd09c81a0..d94bcad49888 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -595,7 +595,7 @@ static size_t arm_v7s_split_blk_unmap(struct arm_v7s_io_pgtable *data,
 		return __arm_v7s_unmap(data, iova, size, 2, tablep);
 	}
 
-	io_pgtable_tlb_add_flush(&data->iop, iova, size, size, true);
+	io_pgtable_tlb_add_page(&data->iop, iova, size);
 	return size;
 }
 
@@ -658,8 +658,7 @@ static size_t __arm_v7s_unmap(struct arm_v7s_io_pgtable *data,
 				 */
 				smp_wmb();
 			} else {
-				io_pgtable_tlb_add_flush(iop, iova, blk_size,
-							 blk_size, true);
+				io_pgtable_tlb_add_page(iop, iova, blk_size);
 			}
 			iova += blk_size;
 		}
@@ -820,10 +819,9 @@ static void dummy_tlb_flush(unsigned long iova, size_t size, size_t granule,
 	WARN_ON(!(size & cfg_cookie->pgsize_bitmap));
 }
 
-static void dummy_tlb_add_flush(unsigned long iova, size_t size,
-				size_t granule, bool leaf, void *cookie)
+static void dummy_tlb_add_page(unsigned long iova, size_t granule, void *cookie)
 {
-	dummy_tlb_flush(iova, size, granule, cookie);
+	dummy_tlb_flush(iova, granule, granule, cookie);
 }
 
 static void dummy_tlb_sync(void *cookie)
@@ -835,7 +833,7 @@ static const struct iommu_flush_ops dummy_tlb_ops = {
 	.tlb_flush_all	= dummy_tlb_flush_all,
 	.tlb_flush_walk	= dummy_tlb_flush,
 	.tlb_flush_leaf	= dummy_tlb_flush,
-	.tlb_add_flush	= dummy_tlb_add_flush,
+	.tlb_add_page	= dummy_tlb_add_page,
 	.tlb_sync	= dummy_tlb_sync,
 };
 
diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 91b3c16d0afd..b6be7686534b 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -593,7 +593,7 @@ static size_t arm_lpae_split_blk_unmap(struct arm_lpae_io_pgtable *data,
 
 		tablep = iopte_deref(pte, data);
 	} else if (unmap_idx >= 0) {
-		io_pgtable_tlb_add_flush(&data->iop, iova, size, size, true);
+		io_pgtable_tlb_add_page(&data->iop, iova, size);
 		return size;
 	}
 
@@ -634,7 +634,7 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
 			 */
 			smp_wmb();
 		} else {
-			io_pgtable_tlb_add_flush(iop, iova, size, size, true);
+			io_pgtable_tlb_add_page(iop, iova, size);
 		}
 
 		return size;
@@ -1086,10 +1086,9 @@ static void dummy_tlb_flush(unsigned long iova, size_t size, size_t granule,
 	WARN_ON(!(size & cfg_cookie->pgsize_bitmap));
 }
 
-static void dummy_tlb_add_flush(unsigned long iova, size_t size,
-				size_t granule, bool leaf, void *cookie)
+static void dummy_tlb_add_page(unsigned long iova, size_t granule, void *cookie)
 {
-	dummy_tlb_flush(iova, size, granule, cookie);
+	dummy_tlb_flush(iova, granule, granule, cookie);
 }
 
 static void dummy_tlb_sync(void *cookie)
@@ -1101,7 +1100,7 @@ static const struct iommu_flush_ops dummy_tlb_ops __initconst = {
 	.tlb_flush_all	= dummy_tlb_flush_all,
 	.tlb_flush_walk	= dummy_tlb_flush,
 	.tlb_flush_leaf	= dummy_tlb_flush,
-	.tlb_add_flush	= dummy_tlb_add_flush,
+	.tlb_add_page	= dummy_tlb_add_page,
 	.tlb_sync	= dummy_tlb_sync,
 };
 
diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 673189d47b3d..9b961c4cd4c3 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -360,17 +360,10 @@ static void ipmmu_tlb_flush(unsigned long iova, size_t size,
 	ipmmu_tlb_flush_all(cookie);
 }
 
-static void ipmmu_tlb_add_flush(unsigned long iova, size_t size,
-				size_t granule, bool leaf, void *cookie)
-{
-	/* The hardware doesn't support selective TLB flush. */
-}
-
 static const struct iommu_flush_ops ipmmu_flush_ops = {
 	.tlb_flush_all = ipmmu_tlb_flush_all,
 	.tlb_flush_walk = ipmmu_tlb_flush,
 	.tlb_flush_leaf = ipmmu_tlb_flush,
-	.tlb_add_flush = ipmmu_tlb_add_flush,
 	.tlb_sync = ipmmu_tlb_flush_all,
 };
 
diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 752d5fa20918..b71485e98e76 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -205,11 +205,16 @@ static void __flush_iotlb_leaf(unsigned long iova, size_t size,
 	__flush_iotlb_sync(cookie);
 }
 
+static void __flush_iotlb_page(unsigned long iova, size_t granule, void *cookie)
+{
+	__flush_iotlb_range(iova, granule, granule, true, cookie);
+}
+
 static const struct iommu_flush_ops msm_iommu_flush_ops = {
 	.tlb_flush_all = __flush_iotlb,
 	.tlb_flush_walk = __flush_iotlb_walk,
 	.tlb_flush_leaf = __flush_iotlb_leaf,
-	.tlb_add_flush = __flush_iotlb_range,
+	.tlb_add_page = __flush_iotlb_page,
 	.tlb_sync = __flush_iotlb_sync,
 };
 
diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 77a4a0a651a4..639c50420fc3 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -210,11 +210,17 @@ static void mtk_iommu_tlb_flush_leaf(unsigned long iova, size_t size,
 	mtk_iommu_tlb_sync(cookie);
 }
 
+static void mtk_iommu_tlb_flush_page_nosync(unsigned long iova, size_t granule,
+					    void *cookie)
+{
+	mtk_iommu_tlb_add_flush_nosync(iova, granule, granule, true, cookie);
+}
+
 static const struct iommu_flush_ops mtk_iommu_flush_ops = {
 	.tlb_flush_all = mtk_iommu_tlb_flush_all,
 	.tlb_flush_walk = mtk_iommu_tlb_flush_walk,
 	.tlb_flush_leaf = mtk_iommu_tlb_flush_leaf,
-	.tlb_add_flush = mtk_iommu_tlb_add_flush_nosync,
+	.tlb_add_page = mtk_iommu_tlb_flush_page_nosync,
 	.tlb_sync = mtk_iommu_tlb_sync,
 };
 
diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/qcom_iommu.c
index 398bb8cb446f..ac37ced28156 100644
--- a/drivers/iommu/qcom_iommu.c
+++ b/drivers/iommu/qcom_iommu.c
@@ -189,11 +189,17 @@ static void qcom_iommu_tlb_flush_leaf(unsigned long iova, size_t size,
 	qcom_iommu_tlb_sync(cookie);
 }
 
+static void qcom_iommu_tlb_add_page(unsigned long iova, size_t granule,
+				    void *cookie)
+{
+	qcom_iommu_tlb_inv_range_nosync(iova, granule, granule, true, cookie);
+}
+
 static const struct iommu_flush_ops qcom_flush_ops = {
 	.tlb_flush_all	= qcom_iommu_tlb_inv_context,
 	.tlb_flush_walk = qcom_iommu_tlb_flush_walk,
 	.tlb_flush_leaf = qcom_iommu_tlb_flush_leaf,
-	.tlb_add_flush	= qcom_iommu_tlb_inv_range_nosync,
+	.tlb_add_page	= qcom_iommu_tlb_add_page,
 	.tlb_sync	= qcom_iommu_tlb_sync,
 };
 
diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index 0618aac59e74..99e04bd2baa1 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -25,12 +25,11 @@ enum io_pgtable_fmt {
  *                  address range.
  * @tlb_flush_leaf: Synchronously invalidate all leaf TLB state for a virtual
  *                  address range.
- * @tlb_add_flush:  Optional callback to queue up leaf TLB invalidation for a
- *                  virtual address range.  This function exists purely as an
- *                  optimisation for IOMMUs that cannot batch TLB invalidation
- *                  operations efficiently and are therefore better suited to
- *                  issuing them early rather than deferring them until
- *                  iommu_tlb_sync().
+ * @tlb_add_page:   Optional callback to queue up leaf TLB invalidation for a
+ *                  single page. This function exists purely as an optimisation
+ *                  for IOMMUs that cannot batch TLB invalidation operations
+ *                  efficiently and are therefore better suited to issuing them
+ *                  early rather than deferring them until iommu_tlb_sync().
  * @tlb_sync:       Ensure any queued TLB invalidation has taken effect, and
  *                  any corresponding page table updates are visible to the
  *                  IOMMU.
@@ -44,8 +43,7 @@ struct iommu_flush_ops {
 			       void *cookie);
 	void (*tlb_flush_leaf)(unsigned long iova, size_t size, size_t granule,
 			       void *cookie);
-	void (*tlb_add_flush)(unsigned long iova, size_t size, size_t granule,
-			      bool leaf, void *cookie);
+	void (*tlb_add_page)(unsigned long iova, size_t granule, void *cookie);
 	void (*tlb_sync)(void *cookie);
 };
 
@@ -212,10 +210,12 @@ io_pgtable_tlb_flush_leaf(struct io_pgtable *iop, unsigned long iova,
 	iop->cfg.tlb->tlb_flush_leaf(iova, size, granule, iop->cookie);
 }
 
-static inline void io_pgtable_tlb_add_flush(struct io_pgtable *iop,
-		unsigned long iova, size_t size, size_t granule, bool leaf)
+static inline void
+io_pgtable_tlb_add_page(struct io_pgtable *iop, unsigned long iova,
+			size_t granule)
 {
-	iop->cfg.tlb->tlb_add_flush(iova, size, granule, leaf, iop->cookie);
+	if (iop->cfg.tlb->tlb_add_page)
+		iop->cfg.tlb->tlb_add_page(iova, granule, iop->cookie);
 }
 
 static inline void io_pgtable_tlb_sync(struct io_pgtable *iop)
-- 
2.11.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
