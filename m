Return-Path: <SRS0=S8Y4=ZU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E49E8C432C3
	for <iommu@archiver.kernel.org>; Thu, 28 Nov 2019 02:30:03 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFD5E2166E
	for <iommu@archiver.kernel.org>; Thu, 28 Nov 2019 02:30:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFD5E2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 09C798113D;
	Thu, 28 Nov 2019 02:30:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YzVpQy37Z2RC; Thu, 28 Nov 2019 02:30:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5F50A877DD;
	Thu, 28 Nov 2019 02:30:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 45105C1DD5;
	Thu, 28 Nov 2019 02:30:02 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A559FC0881
 for <iommu@lists.linux-foundation.org>; Thu, 28 Nov 2019 02:30:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 90C60877D3
 for <iommu@lists.linux-foundation.org>; Thu, 28 Nov 2019 02:30:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EEC9fiEkQCCq for <iommu@lists.linux-foundation.org>;
 Thu, 28 Nov 2019 02:29:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 8B482877DD
 for <iommu@lists.linux-foundation.org>; Thu, 28 Nov 2019 02:29:59 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Nov 2019 18:29:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,251,1571727600"; d="scan'208";a="221176111"
Received: from allen-box.sh.intel.com ([10.239.159.136])
 by orsmga002.jf.intel.com with ESMTP; 27 Nov 2019 18:29:57 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH v2 1/8] iommu/vt-d: Add per domain page table ops
Date: Thu, 28 Nov 2019 10:25:43 +0800
Message-Id: <20191128022550.9832-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191128022550.9832-1-baolu.lu@linux.intel.com>
References: <20191128022550.9832-1-baolu.lu@linux.intel.com>
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

The Intel VT-d in scalable mode supports two types of
page talbes for DMA translation: the first level page
table and the second level page table. The IOMMU driver
is able to choose one of them for DMA remapping according
to the use case. The first level page table uses the same
format as the CPU page table, while the second level page
table keeps compatible with previous formats.

This abstracts the page tables used in Intel IOMMU driver
by defining a per domain page table ops structure which
contains callbacks for various page table operations.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/intel-iommu.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 326146a36dbf..e8bfe7466ebb 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -499,6 +499,28 @@ struct context_entry {
 	u64 hi;
 };
 
+struct dmar_domain;
+
+/*
+ * struct pgtable_ops - page table ops
+ * @map_range: map a physically contiguous memory region to iova
+ * @unmap_range: unmap a physically contiguous memory region
+ * @iova_to_phys: return the physical address mapped to @iova
+ * @flush_tlb_range: flush the tlb caches as the result of map or unmap
+ */
+struct pgtable_ops {
+	int (*map_range)(struct dmar_domain *domain,
+			 unsigned long iova, phys_addr_t paddr,
+			 size_t size, int prot);
+	struct page *(*unmap_range)(struct dmar_domain *domain,
+				    unsigned long iova, size_t size);
+	phys_addr_t (*iova_to_phys)(struct dmar_domain *domain,
+				    unsigned long iova);
+	void (*flush_tlb_range)(struct dmar_domain *domain,
+				struct intel_iommu *iommu,
+				unsigned long iova, size_t size, bool ih);
+};
+
 struct dmar_domain {
 	int	nid;			/* node id */
 
@@ -517,8 +539,10 @@ struct dmar_domain {
 	struct list_head auxd;		/* link to device's auxiliary list */
 	struct iova_domain iovad;	/* iova's that belong to this domain */
 
+	/* page table used by this domain */
 	struct dma_pte	*pgd;		/* virtual address */
 	int		gaw;		/* max guest address width */
+	const struct pgtable_ops *ops;	/* page table ops */
 
 	/* adjusted guest address width, 0 is level 2 30-bit */
 	int		agaw;
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
