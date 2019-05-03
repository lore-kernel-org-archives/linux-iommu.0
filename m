Return-Path: <SRS0=zl4V=TD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1ACBC43219
	for <iommu@archiver.kernel.org>; Fri,  3 May 2019 22:31:23 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC693206C1
	for <iommu@archiver.kernel.org>; Fri,  3 May 2019 22:31:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC693206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 922DC3E27;
	Fri,  3 May 2019 22:30:42 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id DFC0C3E21
	for <iommu@lists.linux-foundation.org>;
	Fri,  3 May 2019 22:29:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 1897387A
	for <iommu@lists.linux-foundation.org>;
	Fri,  3 May 2019 22:29:37 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	03 May 2019 15:29:33 -0700
X-ExtLoop1: 1
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
	by orsmga002.jf.intel.com with ESMTP; 03 May 2019 15:29:33 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>,
	Eric Auger <eric.auger@redhat.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: [PATCH v3 12/16] iommu/vt-d: Add nested translation helper function
Date: Fri,  3 May 2019 15:32:13 -0700
Message-Id: <1556922737-76313-13-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556922737-76313-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1556922737-76313-1-git-send-email-jacob.jun.pan@linux.intel.com>
Cc: Yi L <yi.l.liu@linux.intel.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Raj Ashok <ashok.raj@intel.com>, Liu@mail.linuxfoundation.org,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Nested translation mode is supported in VT-d 3.0 Spec.CH 3.8.
With PASID granular translation type set to 0x11b, translation
result from the first level(FL) also subject to a second level(SL)
page table translation. This mode is used for SVA virtualization,
where FL performs guest virtual to guest physical translation and
SL performs guest physical to host physical translation.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
---
 drivers/iommu/intel-pasid.c | 93 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/iommu/intel-pasid.h | 11 ++++++
 2 files changed, 104 insertions(+)

diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
index dde05b5..d8421f7 100644
--- a/drivers/iommu/intel-pasid.c
+++ b/drivers/iommu/intel-pasid.c
@@ -682,3 +682,96 @@ int intel_pasid_setup_pass_through(struct intel_iommu *iommu,
 
 	return 0;
 }
+
+/**
+ * intel_pasid_setup_nested() - Set up PASID entry for nested translation
+ * which is used for vSVA. The first level page tables are used for
+ * GVA-GPA translation in the guest, second level page tables are used
+ * for GPA to HPA translation.
+ *
+ * @iommu:      Iommu which the device belong to
+ * @dev:        Device to be set up for translation
+ * @gpgd:       FLPTPTR: First Level Page translation pointer in GPA
+ * @pasid:      PASID to be programmed in the device PASID table
+ * @flags:      Additional info such as supervisor PASID
+ * @domain:     Domain info for setting up second level page tables
+ * @addr_width: Address width of the first level (guest)
+ */
+int intel_pasid_setup_nested(struct intel_iommu *iommu,
+			struct device *dev, pgd_t *gpgd,
+			int pasid, int flags,
+			struct dmar_domain *domain,
+			int addr_width)
+{
+	struct pasid_entry *pte;
+	struct dma_pte *pgd;
+	u64 pgd_val;
+	int agaw;
+	u16 did;
+
+	if (!ecap_nest(iommu->ecap)) {
+		pr_err("IOMMU: %s: No nested translation support\n",
+		       iommu->name);
+		return -EINVAL;
+	}
+
+	pte = intel_pasid_get_entry(dev, pasid);
+	if (WARN_ON(!pte))
+		return -EINVAL;
+
+	pasid_clear_entry(pte);
+
+	/* Sanity checking performed by caller to make sure address
+	 * width matching in two dimensions:
+	 * 1. CPU vs. IOMMU
+	 * 2. Guest vs. Host.
+	 */
+	switch (addr_width) {
+	case 57:
+		pasid_set_flpm(pte, 1);
+		break;
+	case 48:
+		pasid_set_flpm(pte, 0);
+		break;
+	default:
+		dev_err(dev, "Invalid paging mode %d\n", addr_width);
+		return -EINVAL;
+	}
+
+	/* Setup the first level page table pointer in GPA */
+	pasid_set_flptr(pte, (u64)gpgd);
+	if (flags & PASID_FLAG_SUPERVISOR_MODE) {
+		if (!ecap_srs(iommu->ecap)) {
+			pr_err("No supervisor request support on %s\n",
+			       iommu->name);
+			return -EINVAL;
+		}
+		pasid_set_sre(pte);
+	}
+
+	/* Setup the second level based on the given domain */
+	pgd = domain->pgd;
+
+	for (agaw = domain->agaw; agaw != iommu->agaw; agaw--) {
+		pgd = phys_to_virt(dma_pte_addr(pgd));
+		if (!dma_pte_present(pgd)) {
+			dev_err(dev, "Invalid domain page table\n");
+			return -EINVAL;
+		}
+	}
+	pgd_val = virt_to_phys(pgd);
+	pasid_set_slptr(pte, pgd_val);
+	pasid_set_fault_enable(pte);
+
+	did = domain->iommu_did[iommu->seq_id];
+	pasid_set_domain_id(pte, did);
+
+	pasid_set_address_width(pte, agaw);
+	pasid_set_page_snoop(pte, !!ecap_smpwc(iommu->ecap));
+
+	pasid_set_translation_type(pte, PASID_ENTRY_PGTT_NESTED);
+	pasid_set_present(pte);
+	pasid_flush_caches(iommu, pte, pasid, did);
+
+	return 0;
+}
diff --git a/drivers/iommu/intel-pasid.h b/drivers/iommu/intel-pasid.h
index 4b26ab5..2234fd5 100644
--- a/drivers/iommu/intel-pasid.h
+++ b/drivers/iommu/intel-pasid.h
@@ -42,6 +42,7 @@
  * to vmalloc or even module mappings.
  */
 #define PASID_FLAG_SUPERVISOR_MODE	BIT(0)
+#define PASID_FLAG_NESTED		BIT(1)
 
 struct pasid_dir_entry {
 	u64 val;
@@ -51,6 +52,11 @@ struct pasid_entry {
 	u64 val[8];
 };
 
+#define PASID_ENTRY_PGTT_FL_ONLY	(1)
+#define PASID_ENTRY_PGTT_SL_ONLY	(2)
+#define PASID_ENTRY_PGTT_NESTED		(3)
+#define PASID_ENTRY_PGTT_PT		(4)
+
 /* The representative of a PASID table */
 struct pasid_table {
 	void			*table;		/* pasid table pointer */
@@ -77,6 +83,11 @@ int intel_pasid_setup_second_level(struct intel_iommu *iommu,
 int intel_pasid_setup_pass_through(struct intel_iommu *iommu,
 				   struct dmar_domain *domain,
 				   struct device *dev, int pasid);
+int intel_pasid_setup_nested(struct intel_iommu *iommu,
+			struct device *dev, pgd_t *pgd,
+			int pasid, int flags,
+			struct dmar_domain *domain,
+			int addr_width);
 void intel_pasid_tear_down_entry(struct intel_iommu *iommu,
 				 struct device *dev, int pasid);
 int vcmd_alloc_pasid(struct intel_iommu *iommu, unsigned int *pasid);
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
