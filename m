Return-Path: <SRS0=Q5U9=VI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20064C71142
	for <iommu@archiver.kernel.org>; Thu, 11 Jul 2019 17:29:34 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA4C520863
	for <iommu@archiver.kernel.org>; Thu, 11 Jul 2019 17:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yNEHZwzg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA4C520863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 7BB7054B7;
	Thu, 11 Jul 2019 17:28:55 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 4900D530E
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Jul 2019 17:19:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id A58F589B
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Jul 2019 17:19:56 +0000 (UTC)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
	[217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 18369216E3;
	Thu, 11 Jul 2019 17:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562865596;
	bh=i/l7ApQZ+SKvrEVKgy6HaD3bMZB1p7/T/CkXNGf1VV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yNEHZwzgN4BesANHRs7gl3IpT8I/Ji6liBMaH9yLIct6xvaJs3P5Yr12JmZUDjE08
	Vh/mMw/AhlJqXLKcEs4hK8IxiKd908ShEfic/MiNNjTA0kY2FnmuHZmEJDm205i7Tf
	yuoHtQrU+Ruttx6v79GH6xQ5+WKblo2xXIFtZYns=
From: Will Deacon <will@kernel.org>
To: iommu@lists.linux-foundation.org
Subject: [RFC PATCH v2 08/19] iommu/io-pgtable: Hook up ->tlb_flush_walk() and
	->tlb_flush_leaf() in drivers
Date: Thu, 11 Jul 2019 18:19:16 +0100
Message-Id: <20190711171927.28803-9-will@kernel.org>
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

Hook up ->tlb_flush_walk() and ->tlb_flush_leaf() in drivers using the
io-pgtable API so that we can start making use of them in the page-table
code. For now, they can just wrap the implementations of ->tlb_add_flush
and ->tlb_sync pending future optimisation in each driver.

Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/gpu/drm/panfrost/panfrost_mmu.c | 14 ++++++++++++++
 drivers/iommu/arm-smmu-v3.c             | 22 ++++++++++++++++++++++
 drivers/iommu/arm-smmu.c                | 24 ++++++++++++++++++++++++
 drivers/iommu/ipmmu-vmsa.c              |  8 ++++++++
 drivers/iommu/msm_iommu.c               | 16 ++++++++++++++++
 drivers/iommu/mtk_iommu.c               | 16 ++++++++++++++++
 drivers/iommu/qcom_iommu.c              | 16 ++++++++++++++++
 7 files changed, 116 insertions(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
index d25c89a3ba48..7018ede0a90d 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -249,8 +249,22 @@ static void mmu_tlb_sync_context(void *cookie)
 	// TODO: Wait 1000 GPU cycles for HW_ISSUE_6367/T60X
 }
 
+static void mmu_tlb_flush_walk(unsigned long iova, size_t size, size_t granule,
+			       void *cookie)
+{
+	mmu_tlb_sync_context(cookie);
+}
+
+static void mmu_tlb_flush_leaf(unsigned long iova, size_t size, size_t granule,
+			       void *cookie)
+{
+	mmu_tlb_sync_context(cookie);
+}
+
 static const struct iommu_flush_ops mmu_tlb_ops = {
 	.tlb_flush_all	= mmu_tlb_inv_context_s1,
+	.tlb_flush_walk = mmu_tlb_flush_walk,
+	.tlb_flush_leaf = mmu_tlb_flush_leaf,
 	.tlb_add_flush	= mmu_tlb_inv_range_nosync,
 	.tlb_sync	= mmu_tlb_sync_context,
 };
diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 43d866c56a34..64141ba53a79 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1597,8 +1597,30 @@ static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
 	} while (size -= granule);
 }
 
+static void arm_smmu_tlb_inv_walk(unsigned long iova, size_t size,
+				  size_t granule, void *cookie)
+{
+	struct arm_smmu_domain *smmu_domain = cookie;
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+
+	arm_smmu_tlb_inv_range_nosync(iova, size, granule, false, cookie);
+	arm_smmu_cmdq_issue_sync(smmu);
+}
+
+static void arm_smmu_tlb_inv_leaf(unsigned long iova, size_t size,
+				  size_t granule, void *cookie)
+{
+	struct arm_smmu_domain *smmu_domain = cookie;
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+
+	arm_smmu_tlb_inv_range_nosync(iova, size, granule, true, cookie);
+	arm_smmu_cmdq_issue_sync(smmu);
+}
+
 static const struct iommu_flush_ops arm_smmu_flush_ops = {
 	.tlb_flush_all	= arm_smmu_tlb_inv_context,
+	.tlb_flush_walk = arm_smmu_tlb_inv_walk,
+	.tlb_flush_leaf = arm_smmu_tlb_inv_leaf,
 	.tlb_add_flush	= arm_smmu_tlb_inv_range_nosync,
 	.tlb_sync	= arm_smmu_tlb_sync,
 };
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 7d6128a23f4d..a06dca4bb2d5 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -550,20 +550,44 @@ static void arm_smmu_tlb_inv_vmid_nosync(unsigned long iova, size_t size,
 	writel_relaxed(smmu_domain->cfg.vmid, base + ARM_SMMU_GR0_TLBIVMID);
 }
 
+static void arm_smmu_tlb_inv_walk(unsigned long iova, size_t size,
+				  size_t granule, void *cookie)
+{
+	struct arm_smmu_domain *smmu_domain = cookie;
+
+	smmu_domain->tlb_ops->tlb_add_flush(iova, size, granule, false, cookie);
+	smmu_domain->tlb_ops->tlb_sync(cookie);
+}
+
+static void arm_smmu_tlb_inv_leaf(unsigned long iova, size_t size,
+				  size_t granule, void *cookie)
+{
+	struct arm_smmu_domain *smmu_domain = cookie;
+
+	smmu_domain->tlb_ops->tlb_add_flush(iova, size, granule, true, cookie);
+	smmu_domain->tlb_ops->tlb_sync(cookie);
+}
+
 static const struct iommu_flush_ops arm_smmu_s1_tlb_ops = {
 	.tlb_flush_all	= arm_smmu_tlb_inv_context_s1,
+	.tlb_flush_walk	= arm_smmu_tlb_inv_walk,
+	.tlb_flush_leaf	= arm_smmu_tlb_inv_leaf,
 	.tlb_add_flush	= arm_smmu_tlb_inv_range_nosync,
 	.tlb_sync	= arm_smmu_tlb_sync_context,
 };
 
 static const struct iommu_flush_ops arm_smmu_s2_tlb_ops_v2 = {
 	.tlb_flush_all	= arm_smmu_tlb_inv_context_s2,
+	.tlb_flush_walk	= arm_smmu_tlb_inv_walk,
+	.tlb_flush_leaf	= arm_smmu_tlb_inv_leaf,
 	.tlb_add_flush	= arm_smmu_tlb_inv_range_nosync,
 	.tlb_sync	= arm_smmu_tlb_sync_context,
 };
 
 static const struct iommu_flush_ops arm_smmu_s2_tlb_ops_v1 = {
 	.tlb_flush_all	= arm_smmu_tlb_inv_context_s2,
+	.tlb_flush_walk	= arm_smmu_tlb_inv_walk,
+	.tlb_flush_leaf	= arm_smmu_tlb_inv_leaf,
 	.tlb_add_flush	= arm_smmu_tlb_inv_vmid_nosync,
 	.tlb_sync	= arm_smmu_tlb_sync_vmid,
 };
diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 6978ea8d88a0..673189d47b3d 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -354,6 +354,12 @@ static void ipmmu_tlb_flush_all(void *cookie)
 	ipmmu_tlb_invalidate(domain);
 }
 
+static void ipmmu_tlb_flush(unsigned long iova, size_t size,
+				size_t granule, void *cookie)
+{
+	ipmmu_tlb_flush_all(cookie);
+}
+
 static void ipmmu_tlb_add_flush(unsigned long iova, size_t size,
 				size_t granule, bool leaf, void *cookie)
 {
@@ -362,6 +368,8 @@ static void ipmmu_tlb_add_flush(unsigned long iova, size_t size,
 
 static const struct iommu_flush_ops ipmmu_flush_ops = {
 	.tlb_flush_all = ipmmu_tlb_flush_all,
+	.tlb_flush_walk = ipmmu_tlb_flush,
+	.tlb_flush_leaf = ipmmu_tlb_flush,
 	.tlb_add_flush = ipmmu_tlb_add_flush,
 	.tlb_sync = ipmmu_tlb_flush_all,
 };
diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index b56cff84332a..752d5fa20918 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -191,8 +191,24 @@ static void __flush_iotlb_sync(void *cookie)
 	 */
 }
 
+static void __flush_iotlb_walk(unsigned long iova, size_t size,
+			       size_t granule, void *cookie)
+{
+	__flush_iotlb_range(iova, size, granule, false, cookie);
+	__flush_iotlb_sync(cookie);
+}
+
+static void __flush_iotlb_leaf(unsigned long iova, size_t size,
+			       size_t granule, void *cookie)
+{
+	__flush_iotlb_range(iova, size, granule, true, cookie);
+	__flush_iotlb_sync(cookie);
+}
+
 static const struct iommu_flush_ops msm_iommu_flush_ops = {
 	.tlb_flush_all = __flush_iotlb,
+	.tlb_flush_walk = __flush_iotlb_walk,
+	.tlb_flush_leaf = __flush_iotlb_leaf,
 	.tlb_add_flush = __flush_iotlb_range,
 	.tlb_sync = __flush_iotlb_sync,
 };
diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index e9c3f49f4b13..77a4a0a651a4 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -196,8 +196,24 @@ static void mtk_iommu_tlb_sync(void *cookie)
 	}
 }
 
+static void mtk_iommu_tlb_flush_walk(unsigned long iova, size_t size,
+				     size_t granule, void *cookie)
+{
+	mtk_iommu_tlb_add_flush_nosync(iova, size, granule, false, cookie);
+	mtk_iommu_tlb_sync(cookie);
+}
+
+static void mtk_iommu_tlb_flush_leaf(unsigned long iova, size_t size,
+				     size_t granule, void *cookie)
+{
+	mtk_iommu_tlb_add_flush_nosync(iova, size, granule, true, cookie);
+	mtk_iommu_tlb_sync(cookie);
+}
+
 static const struct iommu_flush_ops mtk_iommu_flush_ops = {
 	.tlb_flush_all = mtk_iommu_tlb_flush_all,
+	.tlb_flush_walk = mtk_iommu_tlb_flush_walk,
+	.tlb_flush_leaf = mtk_iommu_tlb_flush_leaf,
 	.tlb_add_flush = mtk_iommu_tlb_add_flush_nosync,
 	.tlb_sync = mtk_iommu_tlb_sync,
 };
diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/qcom_iommu.c
index b89d42d40678..398bb8cb446f 100644
--- a/drivers/iommu/qcom_iommu.c
+++ b/drivers/iommu/qcom_iommu.c
@@ -175,8 +175,24 @@ static void qcom_iommu_tlb_inv_range_nosync(unsigned long iova, size_t size,
 	}
 }
 
+static void qcom_iommu_tlb_flush_walk(unsigned long iova, size_t size,
+				      size_t granule, void *cookie)
+{
+	qcom_iommu_tlb_inv_range_nosync(iova, size, granule, false, cookie);
+	qcom_iommu_tlb_sync(cookie);
+}
+
+static void qcom_iommu_tlb_flush_leaf(unsigned long iova, size_t size,
+				      size_t granule, void *cookie)
+{
+	qcom_iommu_tlb_inv_range_nosync(iova, size, granule, true, cookie);
+	qcom_iommu_tlb_sync(cookie);
+}
+
 static const struct iommu_flush_ops qcom_flush_ops = {
 	.tlb_flush_all	= qcom_iommu_tlb_inv_context,
+	.tlb_flush_walk = qcom_iommu_tlb_flush_walk,
+	.tlb_flush_leaf = qcom_iommu_tlb_flush_leaf,
 	.tlb_add_flush	= qcom_iommu_tlb_inv_range_nosync,
 	.tlb_sync	= qcom_iommu_tlb_sync,
 };
-- 
2.11.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
