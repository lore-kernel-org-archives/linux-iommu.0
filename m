Return-Path: <SRS0=A6MP=2O=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82203C2D0CF
	for <iommu@archiver.kernel.org>; Tue, 24 Dec 2019 07:46:19 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ED0220706
	for <iommu@archiver.kernel.org>; Tue, 24 Dec 2019 07:46:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ED0220706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 32EE8859C2;
	Tue, 24 Dec 2019 07:46:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ww299kOr969o; Tue, 24 Dec 2019 07:46:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 56CCE855D9;
	Tue, 24 Dec 2019 07:46:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 47C94C1D81;
	Tue, 24 Dec 2019 07:46:18 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8BD07C0881
 for <iommu@lists.linux-foundation.org>; Tue, 24 Dec 2019 07:46:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 72A0785650
 for <iommu@lists.linux-foundation.org>; Tue, 24 Dec 2019 07:46:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tSbaAl0KAuUC for <iommu@lists.linux-foundation.org>;
 Tue, 24 Dec 2019 07:46:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id A4A65856E9
 for <iommu@lists.linux-foundation.org>; Tue, 24 Dec 2019 07:46:15 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 23 Dec 2019 23:46:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,350,1571727600"; d="scan'208";a="223177066"
Received: from allen-box.sh.intel.com ([10.239.159.136])
 by fmsmga001.fm.intel.com with ESMTP; 23 Dec 2019 23:46:13 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH v5 2/9] iommu/vt-d: Add set domain DOMAIN_ATTR_NESTING attr
Date: Tue, 24 Dec 2019 15:44:55 +0800
Message-Id: <20191224074502.5545-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191224074502.5545-1-baolu.lu@linux.intel.com>
References: <20191224074502.5545-1-baolu.lu@linux.intel.com>
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

This adds the Intel VT-d specific callback of setting
DOMAIN_ATTR_NESTING domain attribution. It is necessary
to let the VT-d driver know that the domain represents
a virtual machine which requires the IOMMU hardware to
support nested translation mode. Return success if the
IOMMU hardware suports nested mode, otherwise failure.

Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 56 +++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 71ad5e5feae2..35f65628202c 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -315,6 +315,12 @@ static int hw_pass_through = 1;
  */
 #define DOMAIN_FLAG_USE_FIRST_LEVEL		BIT(2)
 
+/*
+ * Domain represents a virtual machine which demands iommu nested
+ * translation mode support.
+ */
+#define DOMAIN_FLAG_NESTING_MODE		BIT(3)
+
 #define for_each_domain_iommu(idx, domain)			\
 	for (idx = 0; idx < g_num_of_iommus; idx++)		\
 		if (domain->iommu_refcnt[idx])
@@ -5640,6 +5646,24 @@ static inline bool iommu_pasid_support(void)
 	return ret;
 }
 
+static inline bool nested_mode_support(void)
+{
+	struct dmar_drhd_unit *drhd;
+	struct intel_iommu *iommu;
+	bool ret = true;
+
+	rcu_read_lock();
+	for_each_active_iommu(iommu, drhd) {
+		if (!sm_supported(iommu) || !ecap_nest(iommu->ecap)) {
+			ret = false;
+			break;
+		}
+	}
+	rcu_read_unlock();
+
+	return ret;
+}
+
 static bool intel_iommu_capable(enum iommu_cap cap)
 {
 	if (cap == IOMMU_CAP_CACHE_COHERENCY)
@@ -6018,10 +6042,42 @@ static bool intel_iommu_is_attach_deferred(struct iommu_domain *domain,
 	return dev->archdata.iommu == DEFER_DEVICE_DOMAIN_INFO;
 }
 
+static int
+intel_iommu_domain_set_attr(struct iommu_domain *domain,
+			    enum iommu_attr attr, void *data)
+{
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+	unsigned long flags;
+	int ret = 0;
+
+	if (domain->type != IOMMU_DOMAIN_UNMANAGED)
+		return -EINVAL;
+
+	switch (attr) {
+	case DOMAIN_ATTR_NESTING:
+		spin_lock_irqsave(&device_domain_lock, flags);
+		if (nested_mode_support() &&
+		    list_empty(&dmar_domain->devices)) {
+			dmar_domain->flags |= DOMAIN_FLAG_NESTING_MODE;
+			dmar_domain->flags &= ~DOMAIN_FLAG_USE_FIRST_LEVEL;
+		} else {
+			ret = -ENODEV;
+		}
+		spin_unlock_irqrestore(&device_domain_lock, flags);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
 const struct iommu_ops intel_iommu_ops = {
 	.capable		= intel_iommu_capable,
 	.domain_alloc		= intel_iommu_domain_alloc,
 	.domain_free		= intel_iommu_domain_free,
+	.domain_set_attr	= intel_iommu_domain_set_attr,
 	.attach_dev		= intel_iommu_attach_device,
 	.detach_dev		= intel_iommu_detach_device,
 	.aux_attach_dev		= intel_iommu_aux_attach_device,
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
