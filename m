Return-Path: <SRS0=Pr8R=H6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9CCC433DB
	for <iommu@archiver.kernel.org>; Sun, 28 Feb 2021 06:33:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2001D64E55
	for <iommu@archiver.kernel.org>; Sun, 28 Feb 2021 06:33:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2001D64E55
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D223D4F0C8;
	Sun, 28 Feb 2021 06:33:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VzO-Vh02KXC4; Sun, 28 Feb 2021 06:33:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 266264F07D;
	Sun, 28 Feb 2021 06:33:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 04899C000E;
	Sun, 28 Feb 2021 06:33:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 07A1CC0011
 for <iommu@lists.linux-foundation.org>; Sun, 28 Feb 2021 06:33:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 78AE24F05F
 for <iommu@lists.linux-foundation.org>; Sun, 28 Feb 2021 06:33:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6b965q_isuSj for <iommu@lists.linux-foundation.org>;
 Sun, 28 Feb 2021 06:33:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 81ED64F07D
 for <iommu@lists.linux-foundation.org>; Sun, 28 Feb 2021 06:33:11 +0000 (UTC)
IronPort-SDR: l4M0aILQmpKIm+3bvlt91Of4XOj/8VW4HV1xLbzg4/1njn79YNEEZkR2OSjPwmECwErJ+mYnXd
 sg6VxdDBG0iw==
X-IronPort-AV: E=McAfee;i="6000,8403,9908"; a="183755900"
X-IronPort-AV: E=Sophos;i="5.81,211,1610438400"; d="scan'208";a="183755900"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2021 22:33:10 -0800
IronPort-SDR: MHgOuHfJlS2KWg/V5x/sQLGSEgxxMJ+t1p3cu4j1vntPUj6wt7O9UbnzIP58Qxgx/mfAFzJc/U
 5JG0VIFAigcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,211,1610438400"; d="scan'208";a="517029706"
Received: from otc-wp-03.jf.intel.com ([10.54.39.79])
 by orsmga004.jf.intel.com with ESMTP; 27 Feb 2021 22:33:09 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
 "Lu Baolu" <baolu.lu@linux.intel.com>,
 David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux-foundation.org,
 cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>,
 Li Zefan <lizefan@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
Subject: [PATCH V4 04/18] iommu/ioasid: Support setting system-wide capacity
Date: Sat, 27 Feb 2021 14:01:12 -0800
Message-Id: <1614463286-97618-5-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Raj Ashok <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Alex Williamson <alex.williamson@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Wu Hao <hao.wu@intel.com>
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

IOASID is a system-wide resource that could vary on different systems.
The default capacity is 20 bits as defined in the PCI-E specifications.
This patch adds a function to allow adjusting system IOASID capacity.
For VT-d this is set during boot as part of the Intel IOMMU
initialization. APIs also added to support runtime capacity reservation,
potentially by cgroups.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/iommu.c |  5 +++
 drivers/iommu/ioasid.c      | 70 +++++++++++++++++++++++++++++++++++++
 include/linux/ioasid.h      | 18 ++++++++++
 3 files changed, 93 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index f665322a0991..6f42ff7d171d 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -41,6 +41,7 @@
 #include <linux/dma-direct.h>
 #include <linux/crash_dump.h>
 #include <linux/numa.h>
+#include <linux/ioasid.h>
 #include <asm/irq_remapping.h>
 #include <asm/cacheflush.h>
 #include <asm/iommu.h>
@@ -3298,6 +3299,10 @@ static int __init init_dmars(void)
 	if (ret)
 		goto free_iommu;
 
+	/* PASID is needed for scalable mode irrespective to SVM */
+	if (intel_iommu_sm)
+		ioasid_install_capacity(intel_pasid_max_id);
+
 	/*
 	 * for each drhd
 	 *   enable fault log
diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
index 4eb9b3dd1b85..28681b99340b 100644
--- a/drivers/iommu/ioasid.c
+++ b/drivers/iommu/ioasid.c
@@ -10,6 +10,10 @@
 #include <linux/spinlock.h>
 #include <linux/xarray.h>
 
+/* Default to PCIe standard 20 bit PASID */
+#define PCI_PASID_MAX 0x100000
+static ioasid_t ioasid_capacity = PCI_PASID_MAX;
+static ioasid_t ioasid_capacity_avail = PCI_PASID_MAX;
 struct ioasid_data {
 	ioasid_t id;
 	struct ioasid_set *set;
@@ -258,6 +262,72 @@ void ioasid_unregister_allocator(struct ioasid_allocator_ops *ops)
 }
 EXPORT_SYMBOL_GPL(ioasid_unregister_allocator);
 
+void ioasid_install_capacity(ioasid_t total)
+{
+	spin_lock(&ioasid_allocator_lock);
+	if (ioasid_capacity && ioasid_capacity != PCI_PASID_MAX) {
+		pr_warn("IOASID capacity is already set.\n");
+		goto done_unlock;
+	}
+	ioasid_capacity = ioasid_capacity_avail = total;
+done_unlock:
+	spin_unlock(&ioasid_allocator_lock);
+}
+EXPORT_SYMBOL_GPL(ioasid_install_capacity);
+
+/**
+ * @brief Reserve capacity from the system pool
+ *
+ * @param nr_ioasid Number of IOASIDs requested to be reserved, 0 means
+ *	reserve all remaining IDs.
+ *
+ * @return the remaining capacity on success, or errno
+ */
+int ioasid_reserve_capacity(ioasid_t nr_ioasid)
+{
+	int ret = 0;
+
+	spin_lock(&ioasid_allocator_lock);
+	if (nr_ioasid > ioasid_capacity_avail) {
+		ret = -ENOSPC;
+		goto done_unlock;
+	}
+	if (!nr_ioasid)
+		nr_ioasid = ioasid_capacity_avail;
+	ioasid_capacity_avail -= nr_ioasid;
+	ret = nr_ioasid;
+done_unlock:
+	spin_unlock(&ioasid_allocator_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ioasid_reserve_capacity);
+
+/**
+ * @brief Return capacity to the system pool
+ * 	We trust the caller not to return more than it has reserved, we could
+ * 	also track reservation if needed.
+ *
+ * @param nr_ioasid Number of IOASIDs requested to be returned
+ *
+ * @return the remaining capacity on success, or errno
+ */
+int ioasid_cancel_capacity(ioasid_t nr_ioasid)
+{
+	int ret = 0;
+
+	spin_lock(&ioasid_allocator_lock);
+	if (nr_ioasid + ioasid_capacity_avail > ioasid_capacity) {
+		ret = -EINVAL;
+		goto done_unlock;
+	}
+	ioasid_capacity_avail += nr_ioasid;
+	ret = ioasid_capacity_avail;
+done_unlock:
+	spin_unlock(&ioasid_allocator_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ioasid_cancel_capacity);
+
 /**
  * ioasid_attach_data - Set private data for an allocated ioasid
  * @ioasid: the ID to set data
diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
index f6e705f832f0..2780bdc84b94 100644
--- a/include/linux/ioasid.h
+++ b/include/linux/ioasid.h
@@ -32,6 +32,10 @@ struct ioasid_allocator_ops {
 #define DECLARE_IOASID_SET(name) struct ioasid_set name = { 0 }
 
 #if IS_ENABLED(CONFIG_IOASID)
+void ioasid_install_capacity(ioasid_t total);
+int ioasid_reserve_capacity(ioasid_t nr_ioasid);
+int ioasid_cancel_capacity(ioasid_t nr_ioasid);
+
 ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
 		      void *private);
 void ioasid_get(ioasid_t ioasid);
@@ -43,6 +47,20 @@ void ioasid_unregister_allocator(struct ioasid_allocator_ops *allocator);
 int ioasid_attach_data(ioasid_t ioasid, void *data);
 void ioasid_detach_data(ioasid_t ioasid);
 #else /* !CONFIG_IOASID */
+static inline void ioasid_install_capacity(ioasid_t total)
+{
+}
+
+static inline int ioasid_reserve_capacity(ioasid_t nr_ioasid)
+{
+	return -ENOSPC;
+}
+
+static inline int ioasid_cancel_capacity(ioasid_t nr_ioasid)
+{
+	return -EINVAL;
+}
+
 static inline ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min,
 				    ioasid_t max, void *private)
 {
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
