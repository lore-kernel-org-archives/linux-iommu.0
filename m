Return-Path: <SRS0=6I1K=SK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10DFC10F13
	for <iommu@archiver.kernel.org>; Mon,  8 Apr 2019 23:57:55 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7906D20863
	for <iommu@archiver.kernel.org>; Mon,  8 Apr 2019 23:57:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7906D20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 45853D7A;
	Mon,  8 Apr 2019 23:57:14 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id AC9A8D36
	for <iommu@lists.linux-foundation.org>;
	Mon,  8 Apr 2019 23:57:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 1DF4CF4
	for <iommu@lists.linux-foundation.org>;
	Mon,  8 Apr 2019 23:57:10 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	08 Apr 2019 16:57:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,327,1549958400"; d="scan'208";a="149169963"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
	by orsmga002.jf.intel.com with ESMTP; 08 Apr 2019 16:57:07 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: [PATCH 09/18] iommu/vt-d: Enlightened PASID allocation
Date: Mon,  8 Apr 2019 16:59:24 -0700
Message-Id:
 <1554767973-30125-10-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554767973-30125-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1554767973-30125-1-git-send-email-jacob.jun.pan@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
	Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190408235924.2jgo8laCokKjznuUpWrdt5MLmQOmafn2YQPdGHIK9kY@z>

From: Lu Baolu <baolu.lu@linux.intel.com>

If Intel IOMMU runs in caching mode, a.k.a. virtual IOMMU, the
IOMMU driver should rely on the emulation software to allocate
and free PASID IDs. The Intel vt-d spec revision 3.0 defines a
register set to support this. This includes a capability register,
a virtual command register and a virtual response register. Refer
to section 10.4.42, 10.4.43, 10.4.44 for more information.

This patch adds the enlightened PASID allocation/free interfaces
via the virtual command register.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-pasid.c | 72 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/iommu/intel-pasid.h | 13 +++++++-
 include/linux/intel-iommu.h |  2 ++
 3 files changed, 86 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
index 03b12d2..a17a522 100644
--- a/drivers/iommu/intel-pasid.c
+++ b/drivers/iommu/intel-pasid.c
@@ -63,6 +63,78 @@ void *intel_pasid_lookup_id(int pasid)
 	return p;
 }
 
+int vcmd_alloc_pasid(struct intel_iommu *iommu, unsigned int *pasid)
+{
+	u64 res;
+	u64 cap;
+	u8 err_code;
+	unsigned long flags;
+	int ret = 0;
+
+	pr_debug("vcmd alloc pasid\n");
+	if (!ecap_vcs(iommu->ecap)) {
+		pr_warn("IOMMU: %s: Hardware doesn't support virtual command\n",
+			iommu->name);
+		return -ENODEV;
+	}
+
+	cap = dmar_readq(iommu->reg + DMAR_VCCAP_REG);
+	if (!(cap & DMA_VCS_PAS)) {
+		pr_warn("IOMMU: %s: Emulation software doesn't support PASID allocation\n",
+			iommu->name);
+		return -ENODEV;
+	}
+
+	raw_spin_lock_irqsave(&iommu->register_lock, flags);
+	dmar_writeq(iommu->reg + DMAR_VCMD_REG, VCMD_CMD_ALLOC);
+	IOMMU_WAIT_OP(iommu, DMAR_VCRSP_REG, dmar_readq,
+		      !(res & VCMD_VRSP_IP), res);
+	raw_spin_unlock_irqrestore(&iommu->register_lock, flags);
+
+	err_code = VCMD_VRSP_EC(res);
+	switch (err_code) {
+	case VCMD_VRSP_EC_SUCCESS:
+		*pasid = VCMD_VRSP_RESULE(res);
+		break;
+	case VCMD_VRSP_EC_UNAVAIL:
+		pr_info("IOMMU: %s: No PASID available\n", iommu->name);
+		ret = -ENOMEM;
+		break;
+	default:
+		ret = -ENODEV;
+		pr_warn("IOMMU: %s: Unkonwn error code %d\n",
+			iommu->name, err_code);
+	}
+	pr_debug("vcmd alloc pasid = %d, ret %d\n", *pasid, ret);
+
+	return ret;
+}
+
+void vcmd_free_pasid(struct intel_iommu *iommu, unsigned int pasid)
+{
+	u64 res;
+	u8 err_code;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&iommu->register_lock, flags);
+	dmar_writeq(iommu->reg + DMAR_VCMD_REG, (pasid << 8) | VCMD_CMD_FREE);
+	IOMMU_WAIT_OP(iommu, DMAR_VCRSP_REG, dmar_readq,
+		      !(res & VCMD_VRSP_IP), res);
+	raw_spin_unlock_irqrestore(&iommu->register_lock, flags);
+
+	err_code = VCMD_VRSP_EC(res);
+	switch (err_code) {
+	case VCMD_VRSP_EC_SUCCESS:
+		break;
+	case VCMD_VRSP_EC_INVAL:
+		pr_info("IOMMU: %s: Invalid PASID\n", iommu->name);
+		break;
+	default:
+		pr_warn("IOMMU: %s: Unkonwn error code %d\n",
+			iommu->name, err_code);
+	}
+}
+
 /*
  * Per device pasid table management:
  */
diff --git a/drivers/iommu/intel-pasid.h b/drivers/iommu/intel-pasid.h
index 23537b3..0999dfe 100644
--- a/drivers/iommu/intel-pasid.h
+++ b/drivers/iommu/intel-pasid.h
@@ -19,6 +19,16 @@
 #define PASID_PDE_SHIFT			6
 #define MAX_NR_PASID_BITS		20
 
+/* Virtual command interface for enlightened pasid management. */
+#define VCMD_CMD_ALLOC			0x1
+#define VCMD_CMD_FREE			0x2
+#define VCMD_VRSP_IP			0x1
+#define VCMD_VRSP_EC(e)			(((e) >> 1) & 0x3)
+#define VCMD_VRSP_EC_SUCCESS		0
+#define VCMD_VRSP_EC_UNAVAIL		1
+#define VCMD_VRSP_EC_INVAL		1
+#define VCMD_VRSP_RESULE(e)		(((e) >> 8) & 0xfffff)
+
 /*
  * Domain ID reserved for pasid entries programmed for first-level
  * only and pass-through transfer modes.
@@ -69,5 +79,6 @@ int intel_pasid_setup_pass_through(struct intel_iommu *iommu,
 				   struct device *dev, int pasid);
 void intel_pasid_tear_down_entry(struct intel_iommu *iommu,
 				 struct device *dev, int pasid);
-
+int vcmd_alloc_pasid(struct intel_iommu *iommu, unsigned int *pasid);
+void vcmd_free_pasid(struct intel_iommu *iommu, unsigned int pasid);
 #endif /* __INTEL_PASID_H */
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index fa364de..b29c85c 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -173,6 +173,7 @@
 #define ecap_smpwc(e)		(((e) >> 48) & 0x1)
 #define ecap_flts(e)		(((e) >> 47) & 0x1)
 #define ecap_slts(e)		(((e) >> 46) & 0x1)
+#define ecap_vcs(e)		(((e) >> 44) & 0x1)
 #define ecap_smts(e)		(((e) >> 43) & 0x1)
 #define ecap_dit(e)		((e >> 41) & 0x1)
 #define ecap_pasid(e)		((e >> 40) & 0x1)
@@ -289,6 +290,7 @@
 
 /* PRS_REG */
 #define DMA_PRS_PPR	((u32)1)
+#define DMA_VCS_PAS	((u64)1)
 
 #define IOMMU_WAIT_OP(iommu, offset, op, cond, sts)			\
 do {									\
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
