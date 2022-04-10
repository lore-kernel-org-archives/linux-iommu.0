Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89AFEC433FE
	for <iommu@archiver.kernel.org>; Sun, 10 Apr 2022 10:27:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4E8068423F;
	Sun, 10 Apr 2022 10:27:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zpQi1M5zRxtg; Sun, 10 Apr 2022 10:27:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0BDEF80B87;
	Sun, 10 Apr 2022 10:27:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C4103C0084;
	Sun, 10 Apr 2022 10:27:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 313E7C002C
 for <iommu@lists.linux-foundation.org>; Sun, 10 Apr 2022 10:27:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0AFF1417C6
 for <iommu@lists.linux-foundation.org>; Sun, 10 Apr 2022 10:27:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Vefbkmse0QWF for <iommu@lists.linux-foundation.org>;
 Sun, 10 Apr 2022 10:27:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2DD8A41760
 for <iommu@lists.linux-foundation.org>; Sun, 10 Apr 2022 10:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1649586455; x=1681122455;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XEvCo8vc7HyGtJNWT/dzX6msN51mZr6s4VKvbdupNm4=;
 b=NC+04dZhFoB/Lgq9xFGaH9t55JofmHXRy2UO58I21YhWnElktSmHxH1U
 f50cs7BL7cTaG7k/OP9lhWHzpgvxeD6osPy/imTu2UFlLkZwcWcxlj0yl
 a4keLox2HWfqDmh5fbRS9ENmzYxkXbpBkfbb41JeBi5K6/9qVIPqwC2im
 GiRQmLQ4Fz7w1X764UciLh9aZ+3w8awPqQEd5bYDSdRs4uc1updHVR9n6
 BRlyazWEaCh8Z1l77+LPiL2CMLyhKrxfB47VL+6VTqdw3mK/kP8AC7sBG
 Sz6zVkF1JHdpIPgwvLZEgsdn30kEeOwMFSX8zuZif8xrN/BpH04Zhyd+Q A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10312"; a="249238478"
X-IronPort-AV: E=Sophos;i="5.90,249,1643702400"; d="scan'208";a="249238478"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Apr 2022 03:27:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,249,1643702400"; d="scan'208";a="699019629"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by fmsmga001.fm.intel.com with ESMTP; 10 Apr 2022 03:27:31 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
Subject: [PATCH RFC v3 07/12] arm-smmu-v3/sva: Add SVA domain support
Date: Sun, 10 Apr 2022 18:24:38 +0800
Message-Id: <20220410102443.294128-8-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220410102443.294128-1-baolu.lu@linux.intel.com>
References: <20220410102443.294128-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Add support for SVA domain allocation and provide an SVA-specific
iommu_domain_ops.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   | 14 +++++++
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 42 +++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 21 ++++++++++
 3 files changed, 77 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index cd48590ada30..7631c00fdcbd 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -759,6 +759,10 @@ struct iommu_sva *arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm,
 void arm_smmu_sva_unbind(struct iommu_sva *handle);
 u32 arm_smmu_sva_get_pasid(struct iommu_sva *handle);
 void arm_smmu_sva_notifier_synchronize(void);
+int arm_smmu_sva_attach_dev_pasid(struct iommu_domain *domain,
+				  struct device *dev, ioasid_t id);
+void arm_smmu_sva_detach_dev_pasid(struct iommu_domain *domain,
+				   struct device *dev, ioasid_t id);
 #else /* CONFIG_ARM_SMMU_V3_SVA */
 static inline bool arm_smmu_sva_supported(struct arm_smmu_device *smmu)
 {
@@ -804,5 +808,15 @@ static inline u32 arm_smmu_sva_get_pasid(struct iommu_sva *handle)
 }
 
 static inline void arm_smmu_sva_notifier_synchronize(void) {}
+
+static inline int arm_smmu_sva_attach_dev_pasid(struct iommu_domain *domain,
+						struct device *dev, ioasid_t id)
+{
+	return -ENODEV;
+}
+
+static inline void arm_smmu_sva_detach_dev_pasid(struct iommu_domain *domain,
+						 struct device *dev,
+						 ioasid_t id) {}
 #endif /* CONFIG_ARM_SMMU_V3_SVA */
 #endif /* _ARM_SMMU_V3_H */
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 22ddd05bbdcd..ce229820086d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -534,3 +534,45 @@ void arm_smmu_sva_notifier_synchronize(void)
 	 */
 	mmu_notifier_synchronize();
 }
+
+int arm_smmu_sva_attach_dev_pasid(struct iommu_domain *domain,
+				  struct device *dev, ioasid_t id)
+{
+	int ret = 0;
+	struct iommu_sva *handle;
+	struct mm_struct *mm = iommu_sva_domain_mm(domain);
+
+	if (domain->type != IOMMU_DOMAIN_SVA || !mm)
+		return -EINVAL;
+
+	mutex_lock(&sva_lock);
+	handle = __arm_smmu_sva_bind(dev, mm);
+	if (IS_ERR(handle))
+		ret = PTR_ERR(handle);
+	mutex_unlock(&sva_lock);
+
+	return ret;
+}
+
+void arm_smmu_sva_detach_dev_pasid(struct iommu_domain *domain,
+				   struct device *dev, ioasid_t id)
+{
+	struct arm_smmu_bond *bond = NULL, *t;
+	struct mm_struct *mm = iommu_sva_domain_mm(domain);
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+
+	mutex_lock(&sva_lock);
+	list_for_each_entry(t, &master->bonds, list) {
+		if (t->mm == mm) {
+			bond = t;
+			break;
+		}
+	}
+
+	if (!WARN_ON(!bond) && refcount_dec_and_test(&bond->refs)) {
+		list_del(&bond->list);
+		arm_smmu_mmu_notifier_put(bond->smmu_mn);
+		kfree(bond);
+	}
+	mutex_unlock(&sva_lock);
+}
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index afc63fce6107..bd80de0bad98 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1995,10 +1995,31 @@ static bool arm_smmu_capable(enum iommu_cap cap)
 	}
 }
 
+static void arm_smmu_sva_domain_free(struct iommu_domain *domain)
+{
+	kfree(domain);
+}
+
+static const struct iommu_domain_ops arm_smmu_sva_domain_ops = {
+	.attach_dev_pasid	= arm_smmu_sva_attach_dev_pasid,
+	.detach_dev_pasid	= arm_smmu_sva_detach_dev_pasid,
+	.free			= arm_smmu_sva_domain_free,
+};
+
 static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 {
 	struct arm_smmu_domain *smmu_domain;
 
+	if (type == IOMMU_DOMAIN_SVA) {
+		struct iommu_domain *domain;
+
+		domain = kzalloc(sizeof(*domain), GFP_KERNEL);
+		if (domain)
+			domain->ops = &arm_smmu_sva_domain_ops;
+
+		return domain;
+	}
+
 	if (type != IOMMU_DOMAIN_UNMANAGED &&
 	    type != IOMMU_DOMAIN_DMA &&
 	    type != IOMMU_DOMAIN_DMA_FQ &&
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
