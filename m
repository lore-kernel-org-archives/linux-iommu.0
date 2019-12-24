Return-Path: <SRS0=A6MP=2O=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F3EAC2D0D5
	for <iommu@archiver.kernel.org>; Tue, 24 Dec 2019 07:46:16 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 000B620706
	for <iommu@archiver.kernel.org>; Tue, 24 Dec 2019 07:46:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 000B620706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id E579A20011;
	Tue, 24 Dec 2019 07:46:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uwcnDKTQL02u; Tue, 24 Dec 2019 07:46:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 2E35720520;
	Tue, 24 Dec 2019 07:46:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 19DE7C1D81;
	Tue, 24 Dec 2019 07:46:15 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 05435C1D88
 for <iommu@lists.linux-foundation.org>; Tue, 24 Dec 2019 07:46:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id DBD128535D
 for <iommu@lists.linux-foundation.org>; Tue, 24 Dec 2019 07:46:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h578Qht6WlcH for <iommu@lists.linux-foundation.org>;
 Tue, 24 Dec 2019 07:46:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 52B0F85321
 for <iommu@lists.linux-foundation.org>; Tue, 24 Dec 2019 07:46:13 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 23 Dec 2019 23:46:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,350,1571727600"; d="scan'208";a="223177059"
Received: from allen-box.sh.intel.com ([10.239.159.136])
 by fmsmga001.fm.intel.com with ESMTP; 23 Dec 2019 23:46:11 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH v5 1/9] iommu/vt-d: Identify domains using first level page
 table
Date: Tue, 24 Dec 2019 15:44:54 +0800
Message-Id: <20191224074502.5545-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191224074502.5545-1-baolu.lu@linux.intel.com>
References: <20191224074502.5545-1-baolu.lu@linux.intel.com>
Cc: kevin.tian@intel.com, ashok.raj@intel.com, kvm@vger.kernel.org,
 sanjay.k.kumar@intel.com, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, yi.y.sun@intel.com
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

This checks whether a domain should use the first level page
table for map/unmap and marks it in the domain structure.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 39 +++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 34723f6be672..71ad5e5feae2 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -307,6 +307,14 @@ static int hw_pass_through = 1;
  */
 #define DOMAIN_FLAG_LOSE_CHILDREN		BIT(1)
 
+/*
+ * When VT-d works in the scalable mode, it allows DMA translation to
+ * happen through either first level or second level page table. This
+ * bit marks that the DMA translation for the domain goes through the
+ * first level page table, otherwise, it goes through the second level.
+ */
+#define DOMAIN_FLAG_USE_FIRST_LEVEL		BIT(2)
+
 #define for_each_domain_iommu(idx, domain)			\
 	for (idx = 0; idx < g_num_of_iommus; idx++)		\
 		if (domain->iommu_refcnt[idx])
@@ -1714,6 +1722,35 @@ static void free_dmar_iommu(struct intel_iommu *iommu)
 #endif
 }
 
+/*
+ * Check and return whether first level is used by default for
+ * DMA translation. Currently, we make it off by setting
+ * first_level_support = 0, and will change it to -1 after all
+ * map/unmap paths support first level page table.
+ */
+static bool first_level_by_default(void)
+{
+	struct dmar_drhd_unit *drhd;
+	struct intel_iommu *iommu;
+	static int first_level_support = 0;
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
+	}
+	rcu_read_unlock();
+
+	return first_level_support;
+}
+
 static struct dmar_domain *alloc_domain(int flags)
 {
 	struct dmar_domain *domain;
@@ -1725,6 +1762,8 @@ static struct dmar_domain *alloc_domain(int flags)
 	memset(domain, 0, sizeof(*domain));
 	domain->nid = NUMA_NO_NODE;
 	domain->flags = flags;
+	if (first_level_by_default())
+		domain->flags |= DOMAIN_FLAG_USE_FIRST_LEVEL;
 	domain->has_iotlb_device = false;
 	INIT_LIST_HEAD(&domain->devices);
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
