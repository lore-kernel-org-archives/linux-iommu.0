Return-Path: <SRS0=Q5U9=VI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 754BBC71142
	for <iommu@archiver.kernel.org>; Thu, 11 Jul 2019 17:29:22 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A79720863
	for <iommu@archiver.kernel.org>; Thu, 11 Jul 2019 17:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AtolKWK9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A79720863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id EDCCE54B2;
	Thu, 11 Jul 2019 17:28:54 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 360A4530E
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Jul 2019 17:19:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 2E666886
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Jul 2019 17:19:51 +0000 (UTC)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
	[217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 5F104216C8;
	Thu, 11 Jul 2019 17:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562865590;
	bh=7fitQ3IEaqo75ku4brEGrl8SP/G16afVKF8Emptm2SA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AtolKWK9OnAhHlrXgMoBvh6Msi1RyguULp4W8XvBOs0uVA2Lr1QV32+KUk+nhmy/p
	OgMiD2zSDcyrXubEcqLvZTEmto91PFZeuesGeJHJRAu4o+y8/DUXX0sFDL8RguwRJT
	mxxNRuen2uIB7kvoG822pE6REy6ulntfkIzDGHMw=
From: Will Deacon <will@kernel.org>
To: iommu@lists.linux-foundation.org
Subject: [RFC PATCH v2 06/19] iommu: Pass struct iommu_iotlb_gather to
	->unmap() and ->iotlb_sync()
Date: Thu, 11 Jul 2019 18:19:14 +0100
Message-Id: <20190711171927.28803-7-will@kernel.org>
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

To allow IOMMU drivers to batch up TLB flushing operations and postpone
them until ->iotlb_sync() is called, extend the prototypes for the
->unmap() and ->iotlb_sync() IOMMU ops callbacks to take a pointer to
the current iommu_iotlb_gather structure.

All affected IOMMU drivers are updated, but there should be no
functional change since the extra parameter is ignored for now.

Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/iommu/amd_iommu.c      | 11 +++++++++--
 drivers/iommu/arm-smmu-v3.c    |  7 ++++---
 drivers/iommu/arm-smmu.c       |  5 +++--
 drivers/iommu/exynos-iommu.c   |  3 ++-
 drivers/iommu/intel-iommu.c    |  3 ++-
 drivers/iommu/iommu.c          |  2 +-
 drivers/iommu/ipmmu-vmsa.c     | 12 +++++++++---
 drivers/iommu/msm_iommu.c      |  2 +-
 drivers/iommu/mtk_iommu.c      | 13 ++++++++++---
 drivers/iommu/mtk_iommu_v1.c   |  3 ++-
 drivers/iommu/omap-iommu.c     |  2 +-
 drivers/iommu/qcom_iommu.c     | 12 +++++++++---
 drivers/iommu/rockchip-iommu.c |  2 +-
 drivers/iommu/s390-iommu.c     |  3 ++-
 drivers/iommu/tegra-gart.c     | 12 +++++++++---
 drivers/iommu/tegra-smmu.c     |  2 +-
 include/linux/iommu.h          |  7 ++++---
 17 files changed, 70 insertions(+), 31 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 639b7ce2ba32..d068733602da 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -3055,7 +3055,8 @@ static int amd_iommu_map(struct iommu_domain *dom, unsigned long iova,
 }
 
 static size_t amd_iommu_unmap(struct iommu_domain *dom, unsigned long iova,
-			   size_t page_size)
+			      size_t page_size,
+			      struct iommu_iotlb_gather *gather)
 {
 	struct protection_domain *domain = to_pdomain(dom);
 	size_t unmap_size;
@@ -3196,6 +3197,12 @@ static void amd_iommu_flush_iotlb_all(struct iommu_domain *domain)
 	domain_flush_complete(dom);
 }
 
+static void amd_iommu_iotlb_sync(struct iommu_domain *domain,
+				 struct iommu_iotlb_gather *gather)
+{
+	amd_iommu_flush_iotlb_all(domain);
+}
+
 const struct iommu_ops amd_iommu_ops = {
 	.capable = amd_iommu_capable,
 	.domain_alloc = amd_iommu_domain_alloc,
@@ -3214,7 +3221,7 @@ const struct iommu_ops amd_iommu_ops = {
 	.is_attach_deferred = amd_iommu_is_attach_deferred,
 	.pgsize_bitmap	= AMD_IOMMU_PGSIZES,
 	.flush_iotlb_all = amd_iommu_flush_iotlb_all,
-	.iotlb_sync = amd_iommu_flush_iotlb_all,
+	.iotlb_sync = amd_iommu_iotlb_sync,
 };
 
 /*****************************************************************************
diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 33fbf0becad2..43d866c56a34 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1976,8 +1976,8 @@ static int arm_smmu_map(struct iommu_domain *domain, unsigned long iova,
 	return ops->map(ops, iova, paddr, size, prot);
 }
 
-static size_t
-arm_smmu_unmap(struct iommu_domain *domain, unsigned long iova, size_t size)
+static size_t arm_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
+			     size_t size, struct iommu_iotlb_gather *gather)
 {
 	int ret;
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
@@ -2001,7 +2001,8 @@ static void arm_smmu_flush_iotlb_all(struct iommu_domain *domain)
 		arm_smmu_tlb_inv_context(smmu_domain);
 }
 
-static void arm_smmu_iotlb_sync(struct iommu_domain *domain)
+static void arm_smmu_iotlb_sync(struct iommu_domain *domain,
+				struct iommu_iotlb_gather *gather)
 {
 	struct arm_smmu_device *smmu = to_smmu_domain(domain)->smmu;
 
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 44592d9c2ab4..7d6128a23f4d 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1304,7 +1304,7 @@ static int arm_smmu_map(struct iommu_domain *domain, unsigned long iova,
 }
 
 static size_t arm_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
-			     size_t size)
+			     size_t size, struct iommu_iotlb_gather *gather)
 {
 	struct io_pgtable_ops *ops = to_smmu_domain(domain)->pgtbl_ops;
 	struct arm_smmu_device *smmu = to_smmu_domain(domain)->smmu;
@@ -1332,7 +1332,8 @@ static void arm_smmu_flush_iotlb_all(struct iommu_domain *domain)
 	}
 }
 
-static void arm_smmu_iotlb_sync(struct iommu_domain *domain)
+static void arm_smmu_iotlb_sync(struct iommu_domain *domain,
+				struct iommu_iotlb_gather *gather)
 {
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 05c6bc099d62..1cd3502a640a 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -1133,7 +1133,8 @@ static void exynos_iommu_tlb_invalidate_entry(struct exynos_iommu_domain *domain
 }
 
 static size_t exynos_iommu_unmap(struct iommu_domain *iommu_domain,
-				 unsigned long l_iova, size_t size)
+				 unsigned long l_iova, size_t size,
+				 struct iommu_iotlb_gather *gather)
 {
 	struct exynos_iommu_domain *domain = to_exynos_domain(iommu_domain);
 	sysmmu_iova_t iova = (sysmmu_iova_t)l_iova;
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index a209199f3af6..37bc30c02f57 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5337,7 +5337,8 @@ static int intel_iommu_map(struct iommu_domain *domain,
 }
 
 static size_t intel_iommu_unmap(struct iommu_domain *domain,
-				unsigned long iova, size_t size)
+				unsigned long iova, size_t size,
+				struct iommu_iotlb_gather *gather)
 {
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
 	struct page *freelist = NULL;
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 836b320169e8..4884626703e3 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1677,7 +1677,7 @@ static size_t __iommu_unmap(struct iommu_domain *domain,
 	while (unmapped < size) {
 		size_t pgsize = iommu_pgsize(domain, iova, size - unmapped);
 
-		unmapped_page = ops->unmap(domain, iova, pgsize);
+		unmapped_page = ops->unmap(domain, iova, pgsize, iotlb_gather);
 		if (!unmapped_page)
 			break;
 
diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 207bff3ad796..6978ea8d88a0 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -719,14 +719,14 @@ static int ipmmu_map(struct iommu_domain *io_domain, unsigned long iova,
 }
 
 static size_t ipmmu_unmap(struct iommu_domain *io_domain, unsigned long iova,
-			  size_t size)
+			  size_t size, struct iommu_iotlb_gather *gather)
 {
 	struct ipmmu_vmsa_domain *domain = to_vmsa_domain(io_domain);
 
 	return domain->iop->unmap(domain->iop, iova, size);
 }
 
-static void ipmmu_iotlb_sync(struct iommu_domain *io_domain)
+static void ipmmu_flush_iotlb_all(struct iommu_domain *io_domain)
 {
 	struct ipmmu_vmsa_domain *domain = to_vmsa_domain(io_domain);
 
@@ -734,6 +734,12 @@ static void ipmmu_iotlb_sync(struct iommu_domain *io_domain)
 		ipmmu_tlb_flush_all(domain);
 }
 
+static void ipmmu_iotlb_sync(struct iommu_domain *io_domain,
+			     struct iommu_iotlb_gather *gather)
+{
+	ipmmu_flush_iotlb_all(io_domain);
+}
+
 static phys_addr_t ipmmu_iova_to_phys(struct iommu_domain *io_domain,
 				      dma_addr_t iova)
 {
@@ -933,7 +939,7 @@ static const struct iommu_ops ipmmu_ops = {
 	.detach_dev = ipmmu_detach_device,
 	.map = ipmmu_map,
 	.unmap = ipmmu_unmap,
-	.flush_iotlb_all = ipmmu_iotlb_sync,
+	.flush_iotlb_all = ipmmu_flush_iotlb_all,
 	.iotlb_sync = ipmmu_iotlb_sync,
 	.iova_to_phys = ipmmu_iova_to_phys,
 	.add_device = ipmmu_add_device,
diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 7c78b6d899c5..b56cff84332a 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -522,7 +522,7 @@ static int msm_iommu_map(struct iommu_domain *domain, unsigned long iova,
 }
 
 static size_t msm_iommu_unmap(struct iommu_domain *domain, unsigned long iova,
-			      size_t len)
+			      size_t len, struct iommu_iotlb_gather *gather)
 {
 	struct msm_priv *priv = to_msm_priv(domain);
 	unsigned long flags;
diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 2012b1655779..e9c3f49f4b13 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -379,7 +379,8 @@ static int mtk_iommu_map(struct iommu_domain *domain, unsigned long iova,
 }
 
 static size_t mtk_iommu_unmap(struct iommu_domain *domain,
-			      unsigned long iova, size_t size)
+			      unsigned long iova, size_t size,
+			      struct iommu_iotlb_gather *gather)
 {
 	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
 	unsigned long flags;
@@ -392,7 +393,13 @@ static size_t mtk_iommu_unmap(struct iommu_domain *domain,
 	return unmapsz;
 }
 
-static void mtk_iommu_iotlb_sync(struct iommu_domain *domain)
+static void mtk_iommu_flush_iotlb_all(struct iommu_domain *domain)
+{
+	mtk_iommu_tlb_sync(mtk_iommu_get_m4u_data());
+}
+
+static void mtk_iommu_iotlb_sync(struct iommu_domain *domain,
+				 struct iommu_iotlb_gather *gather)
 {
 	mtk_iommu_tlb_sync(mtk_iommu_get_m4u_data());
 }
@@ -498,7 +505,7 @@ static const struct iommu_ops mtk_iommu_ops = {
 	.detach_dev	= mtk_iommu_detach_device,
 	.map		= mtk_iommu_map,
 	.unmap		= mtk_iommu_unmap,
-	.flush_iotlb_all = mtk_iommu_iotlb_sync,
+	.flush_iotlb_all = mtk_iommu_flush_iotlb_all,
 	.iotlb_sync	= mtk_iommu_iotlb_sync,
 	.iova_to_phys	= mtk_iommu_iova_to_phys,
 	.add_device	= mtk_iommu_add_device,
diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index 52b01e3a49df..d45f7d2572a5 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -332,7 +332,8 @@ static int mtk_iommu_map(struct iommu_domain *domain, unsigned long iova,
 }
 
 static size_t mtk_iommu_unmap(struct iommu_domain *domain,
-			      unsigned long iova, size_t size)
+			      unsigned long iova, size_t size,
+			      struct iommu_iotlb_gather *gather)
 {
 	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
 	unsigned long flags;
diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index d2fb347aa4ff..9fdf29d4146d 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1153,7 +1153,7 @@ static int omap_iommu_map(struct iommu_domain *domain, unsigned long da,
 }
 
 static size_t omap_iommu_unmap(struct iommu_domain *domain, unsigned long da,
-			       size_t size)
+			       size_t size, struct iommu_iotlb_gather *gather)
 {
 	struct omap_iommu_domain *omap_domain = to_omap_domain(domain);
 	struct device *dev = omap_domain->dev;
diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/qcom_iommu.c
index c254db346732..b89d42d40678 100644
--- a/drivers/iommu/qcom_iommu.c
+++ b/drivers/iommu/qcom_iommu.c
@@ -428,7 +428,7 @@ static int qcom_iommu_map(struct iommu_domain *domain, unsigned long iova,
 }
 
 static size_t qcom_iommu_unmap(struct iommu_domain *domain, unsigned long iova,
-			       size_t size)
+			       size_t size, struct iommu_iotlb_gather *gather)
 {
 	size_t ret;
 	unsigned long flags;
@@ -452,7 +452,7 @@ static size_t qcom_iommu_unmap(struct iommu_domain *domain, unsigned long iova,
 	return ret;
 }
 
-static void qcom_iommu_iotlb_sync(struct iommu_domain *domain)
+static void qcom_iommu_flush_iotlb_all(struct iommu_domain *domain)
 {
 	struct qcom_iommu_domain *qcom_domain = to_qcom_iommu_domain(domain);
 	struct io_pgtable *pgtable = container_of(qcom_domain->pgtbl_ops,
@@ -465,6 +465,12 @@ static void qcom_iommu_iotlb_sync(struct iommu_domain *domain)
 	pm_runtime_put_sync(qcom_domain->iommu->dev);
 }
 
+static void qcom_iommu_iotlb_sync(struct iommu_domain *domain,
+				  struct iommu_iotlb_gather *gather)
+{
+	qcom_iommu_flush_iotlb_all(domain);
+}
+
 static phys_addr_t qcom_iommu_iova_to_phys(struct iommu_domain *domain,
 					   dma_addr_t iova)
 {
@@ -592,7 +598,7 @@ static const struct iommu_ops qcom_iommu_ops = {
 	.detach_dev	= qcom_iommu_detach_dev,
 	.map		= qcom_iommu_map,
 	.unmap		= qcom_iommu_unmap,
-	.flush_iotlb_all = qcom_iommu_iotlb_sync,
+	.flush_iotlb_all = qcom_iommu_flush_iotlb_all,
 	.iotlb_sync	= qcom_iommu_iotlb_sync,
 	.iova_to_phys	= qcom_iommu_iova_to_phys,
 	.add_device	= qcom_iommu_add_device,
diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 77d4bd93fe4b..3c4a6ac6378a 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -797,7 +797,7 @@ static int rk_iommu_map(struct iommu_domain *domain, unsigned long _iova,
 }
 
 static size_t rk_iommu_unmap(struct iommu_domain *domain, unsigned long _iova,
-			     size_t size)
+			     size_t size, struct iommu_iotlb_gather *gather)
 {
 	struct rk_iommu_domain *rk_domain = to_rk_domain(domain);
 	unsigned long flags;
diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index 22d4db302c1c..3b0b18e23187 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -314,7 +314,8 @@ static phys_addr_t s390_iommu_iova_to_phys(struct iommu_domain *domain,
 }
 
 static size_t s390_iommu_unmap(struct iommu_domain *domain,
-			       unsigned long iova, size_t size)
+			       unsigned long iova, size_t size,
+			       struct iommu_iotlb_gather *gather)
 {
 	struct s390_domain *s390_domain = to_s390_domain(domain);
 	int flags = ZPCI_PTE_INVALID;
diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index 4d8057916552..9925a2895ac3 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -219,7 +219,7 @@ static inline int __gart_iommu_unmap(struct gart_device *gart,
 }
 
 static size_t gart_iommu_unmap(struct iommu_domain *domain, unsigned long iova,
-			       size_t bytes)
+			       size_t bytes, struct iommu_iotlb_gather *gather)
 {
 	struct gart_device *gart = gart_handle;
 	int err;
@@ -285,11 +285,17 @@ static int gart_iommu_of_xlate(struct device *dev,
 	return 0;
 }
 
-static void gart_iommu_sync(struct iommu_domain *domain)
+static void gart_iommu_sync_map(struct iommu_domain *domain)
 {
 	FLUSH_GART_REGS(gart_handle);
 }
 
+static void gart_iommu_sync(struct iommu_domain *domain,
+			    struct iommu_iotlb_gather *gather)
+{
+	gart_iommu_sync_map(domain);
+}
+
 static const struct iommu_ops gart_iommu_ops = {
 	.capable	= gart_iommu_capable,
 	.domain_alloc	= gart_iommu_domain_alloc,
@@ -304,7 +310,7 @@ static const struct iommu_ops gart_iommu_ops = {
 	.iova_to_phys	= gart_iommu_iova_to_phys,
 	.pgsize_bitmap	= GART_IOMMU_PGSIZES,
 	.of_xlate	= gart_iommu_of_xlate,
-	.iotlb_sync_map	= gart_iommu_sync,
+	.iotlb_sync_map	= gart_iommu_sync_map,
 	.iotlb_sync	= gart_iommu_sync,
 };
 
diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 463ee08f7d3a..0378316d8622 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -683,7 +683,7 @@ static int tegra_smmu_map(struct iommu_domain *domain, unsigned long iova,
 }
 
 static size_t tegra_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
-			       size_t size)
+			       size_t size, struct iommu_iotlb_gather *gather)
 {
 	struct tegra_smmu_as *as = to_smmu_as(domain);
 	dma_addr_t pte_dma;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 95442de75a71..588a2c47a1a3 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -260,10 +260,11 @@ struct iommu_ops {
 	int (*map)(struct iommu_domain *domain, unsigned long iova,
 		   phys_addr_t paddr, size_t size, int prot);
 	size_t (*unmap)(struct iommu_domain *domain, unsigned long iova,
-		     size_t size);
+		     size_t size, struct iommu_iotlb_gather *iotlb_gather);
 	void (*flush_iotlb_all)(struct iommu_domain *domain);
 	void (*iotlb_sync_map)(struct iommu_domain *domain);
-	void (*iotlb_sync)(struct iommu_domain *domain);
+	void (*iotlb_sync)(struct iommu_domain *domain,
+			   struct iommu_iotlb_gather *iotlb_gather);
 	phys_addr_t (*iova_to_phys)(struct iommu_domain *domain, dma_addr_t iova);
 	int (*add_device)(struct device *dev);
 	void (*remove_device)(struct device *dev);
@@ -446,7 +447,7 @@ static inline void iommu_tlb_sync(struct iommu_domain *domain,
 				  struct iommu_iotlb_gather *iotlb_gather)
 {
 	if (domain->ops->iotlb_sync)
-		domain->ops->iotlb_sync(domain);
+		domain->ops->iotlb_sync(domain, iotlb_gather);
 
 	iommu_iotlb_gather_init(iotlb_gather);
 }
-- 
2.11.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
