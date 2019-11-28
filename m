Return-Path: <SRS0=S8Y4=ZU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0BFC43215
	for <iommu@archiver.kernel.org>; Thu, 28 Nov 2019 02:30:25 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF7422166E
	for <iommu@archiver.kernel.org>; Thu, 28 Nov 2019 02:30:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF7422166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id B68CF877F2;
	Thu, 28 Nov 2019 02:30:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ksxvzh7VMR2I; Thu, 28 Nov 2019 02:30:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 62F58877EA;
	Thu, 28 Nov 2019 02:30:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5E0CBC1DD5;
	Thu, 28 Nov 2019 02:30:23 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8CC8FC0881
 for <iommu@lists.linux-foundation.org>; Thu, 28 Nov 2019 02:30:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 722AF877E3
 for <iommu@lists.linux-foundation.org>; Thu, 28 Nov 2019 02:30:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gvY8USxw65Os for <iommu@lists.linux-foundation.org>;
 Thu, 28 Nov 2019 02:30:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 387F5877FC
 for <iommu@lists.linux-foundation.org>; Thu, 28 Nov 2019 02:30:15 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Nov 2019 18:30:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,251,1571727600"; d="scan'208";a="221176239"
Received: from allen-box.sh.intel.com ([10.239.159.136])
 by orsmga002.jf.intel.com with ESMTP; 27 Nov 2019 18:30:12 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH v2 7/8] iommu/vt-d: Identify domains using first level page
 table
Date: Thu, 28 Nov 2019 10:25:49 +0800
Message-Id: <20191128022550.9832-8-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191128022550.9832-1-baolu.lu@linux.intel.com>
References: <20191128022550.9832-1-baolu.lu@linux.intel.com>
Cc: kevin.tian@intel.com, Yi Sun <yi.y.sun@linux.intel.com>,
 ashok.raj@intel.com, kvm@vger.kernel.org, sanjay.k.kumar@intel.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 yi.y.sun@intel.com
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

This checks whether a domain should use first level page table
for map/unmap. And if so, we should attach the domain to the
device in first level translation mode.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Liu Yi L <yi.l.liu@intel.com>
Cc: Yi Sun <yi.y.sun@linux.intel.com>
Cc: Sanjay Kumar <sanjay.k.kumar@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 63 +++++++++++++++++++++++++++++++++++--
 1 file changed, 60 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 695a7a5fbe8e..68b2f98ecd65 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -417,6 +417,11 @@ const struct iommu_ops intel_iommu_ops;
 static const struct pgtable_ops first_lvl_pgtable_ops;
 static const struct pgtable_ops second_lvl_pgtable_ops;
 
+static inline bool domain_pgtable_first_lvl(struct dmar_domain *domain)
+{
+	return domain->ops == &first_lvl_pgtable_ops;
+}
+
 static bool translation_pre_enabled(struct intel_iommu *iommu)
 {
 	return (iommu->flags & VTD_FLAG_TRANS_PRE_ENABLED);
@@ -1702,6 +1707,44 @@ static bool first_lvl_5lp_support(void)
 	return first_level_5lp_supported;
 }
 
+/*
+ * Check and return whether first level is used by default for
+ * DMA translation.
+ */
+static bool first_level_by_default(void)
+{
+	struct dmar_drhd_unit *drhd;
+	struct intel_iommu *iommu;
+	static int first_level_support = -1;
+
+	if (likely(first_level_support != -1))
+		return first_level_support;
+
+	first_level_support = 1;
+
+	rcu_read_lock();
+	for_each_active_iommu(iommu, drhd) {
+		if (!sm_supported(iommu) || !ecap_flts(iommu->ecap)) {
+			first_level_support = 0;
+			break;
+		}
+#ifdef CONFIG_X86
+		/*
+		 * Currently we don't support paging mode missmatching.
+		 * Could be turned on later if there is a case.
+		 */
+		if (cpu_feature_enabled(X86_FEATURE_LA57) &&
+		    !cap_5lp_support(iommu->cap)) {
+			first_level_support = 0;
+			break;
+		}
+#endif /* #ifdef CONFIG_X86 */
+	}
+	rcu_read_unlock();
+
+	return first_level_support;
+}
+
 static struct dmar_domain *alloc_domain(int flags)
 {
 	struct dmar_domain *domain;
@@ -1714,7 +1757,10 @@ static struct dmar_domain *alloc_domain(int flags)
 	domain->nid = NUMA_NO_NODE;
 	domain->flags = flags;
 	domain->has_iotlb_device = false;
-	domain->ops = &second_lvl_pgtable_ops;
+	if (first_level_by_default())
+		domain->ops = &first_lvl_pgtable_ops;
+	else
+		domain->ops = &second_lvl_pgtable_ops;
 	domain->first_lvl_5lp = first_lvl_5lp_support();
 	spin_lock_init(&domain->page_table_lock);
 	INIT_LIST_HEAD(&domain->devices);
@@ -2710,6 +2756,11 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 		if (hw_pass_through && domain_type_is_si(domain))
 			ret = intel_pasid_setup_pass_through(iommu, domain,
 					dev, PASID_RID2PASID);
+		else if (domain_pgtable_first_lvl(domain))
+			ret = intel_pasid_setup_first_level(iommu, dev,
+					domain->pgd, PASID_RID2PASID,
+					domain->iommu_did[iommu->seq_id],
+					PASID_FLAG_SUPERVISOR_MODE);
 		else
 			ret = intel_pasid_setup_second_level(iommu, domain,
 					dev, PASID_RID2PASID);
@@ -5597,8 +5648,14 @@ static int aux_domain_add_dev(struct dmar_domain *domain,
 		goto attach_failed;
 
 	/* Setup the PASID entry for mediated devices: */
-	ret = intel_pasid_setup_second_level(iommu, domain, dev,
-					     domain->default_pasid);
+	if (domain_pgtable_first_lvl(domain))
+		ret = intel_pasid_setup_first_level(iommu, dev,
+				domain->pgd, domain->default_pasid,
+				domain->iommu_did[iommu->seq_id],
+				PASID_FLAG_SUPERVISOR_MODE);
+	else
+		ret = intel_pasid_setup_second_level(iommu, domain, dev,
+						     domain->default_pasid);
 	if (ret)
 		goto table_failed;
 	spin_unlock(&iommu->lock);
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
