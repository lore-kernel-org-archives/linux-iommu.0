Return-Path: <SRS0=wClR=S7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E76C43218
	for <iommu@archiver.kernel.org>; Mon, 29 Apr 2019 01:25:14 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA68420656
	for <iommu@archiver.kernel.org>; Mon, 29 Apr 2019 01:25:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA68420656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 65E5E1DCC;
	Mon, 29 Apr 2019 01:25:14 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 4A0491DC8
	for <iommu@lists.linux-foundation.org>;
	Mon, 29 Apr 2019 01:22:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id DC76D608
	for <iommu@lists.linux-foundation.org>;
	Mon, 29 Apr 2019 01:22:27 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
	by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	28 Apr 2019 18:22:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,407,1549958400"; d="scan'208";a="146630198"
Received: from allen-box.sh.intel.com ([10.239.159.136])
	by fmsmga007.fm.intel.com with ESMTP; 28 Apr 2019 18:22:25 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 1/1] iommu/vt-d: Cleanup: no spaces at the start of a line
Date: Mon, 29 Apr 2019 09:16:02 +0800
Message-Id: <20190429011602.17625-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Cc: iommu@lists.linux-foundation.org, David Woodhouse <dwmw2@infradead.org>,
	linux-kernel@vger.kernel.org
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
Message-ID: <20190429011602.4H3TKhTUWuQph2X8KniIp4RMhUNJoV7apUPd4YDWa7A@z>

Replace the whitespaces at the start of a line with tabs. No
functional changes.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 53 +++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 26 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index c1f2f83e25d2..e0c0febc6fa5 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2341,32 +2341,33 @@ static int __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 }
 
 static int domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
-                         struct scatterlist *sg, unsigned long phys_pfn,
-                         unsigned long nr_pages, int prot)
-{
-       int ret;
-       struct intel_iommu *iommu;
-
-       /* Do the real mapping first */
-       ret = __domain_mapping(domain, iov_pfn, sg, phys_pfn, nr_pages, prot);
-       if (ret)
-               return ret;
-
-       /* Notify about the new mapping */
-       if (domain_type_is_vm(domain)) {
-	       /* VM typed domains can have more than one IOMMUs */
-	       int iommu_id;
-	       for_each_domain_iommu(iommu_id, domain) {
-		       iommu = g_iommus[iommu_id];
-		       __mapping_notify_one(iommu, domain, iov_pfn, nr_pages);
-	       }
-       } else {
-	       /* General domains only have one IOMMU */
-	       iommu = domain_get_iommu(domain);
-	       __mapping_notify_one(iommu, domain, iov_pfn, nr_pages);
-       }
+			  struct scatterlist *sg, unsigned long phys_pfn,
+			  unsigned long nr_pages, int prot)
+{
+	int ret;
+	struct intel_iommu *iommu;
+
+	/* Do the real mapping first */
+	ret = __domain_mapping(domain, iov_pfn, sg, phys_pfn, nr_pages, prot);
+	if (ret)
+		return ret;
 
-       return 0;
+	/* Notify about the new mapping */
+	if (domain_type_is_vm(domain)) {
+		/* VM typed domains can have more than one IOMMUs */
+		int iommu_id;
+
+		for_each_domain_iommu(iommu_id, domain) {
+			iommu = g_iommus[iommu_id];
+			__mapping_notify_one(iommu, domain, iov_pfn, nr_pages);
+		}
+	} else {
+		/* General domains only have one IOMMU */
+		iommu = domain_get_iommu(domain);
+		__mapping_notify_one(iommu, domain, iov_pfn, nr_pages);
+	}
+
+	return 0;
 }
 
 static inline int domain_sg_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
@@ -4098,7 +4099,7 @@ static int init_iommu_hw(void)
 				iommu_disable_protect_mem_regions(iommu);
 			continue;
 		}
-	
+
 		iommu_flush_write_buffer(iommu);
 
 		iommu_set_root_entry(iommu);
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
