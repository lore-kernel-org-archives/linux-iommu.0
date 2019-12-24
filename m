Return-Path: <SRS0=A6MP=2O=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB0A0C2D0D2
	for <iommu@archiver.kernel.org>; Tue, 24 Dec 2019 07:46:32 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BABC220706
	for <iommu@archiver.kernel.org>; Tue, 24 Dec 2019 07:46:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BABC220706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 81F5587807;
	Tue, 24 Dec 2019 07:46:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VvAgan6toxNL; Tue, 24 Dec 2019 07:46:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 95E03877B5;
	Tue, 24 Dec 2019 07:46:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 83F98C1D81;
	Tue, 24 Dec 2019 07:46:30 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 88D29C0881
 for <iommu@lists.linux-foundation.org>; Tue, 24 Dec 2019 07:46:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 78888856E9
 for <iommu@lists.linux-foundation.org>; Tue, 24 Dec 2019 07:46:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RWztbRGywtC7 for <iommu@lists.linux-foundation.org>;
 Tue, 24 Dec 2019 07:46:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 0B95B85321
 for <iommu@lists.linux-foundation.org>; Tue, 24 Dec 2019 07:46:29 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 23 Dec 2019 23:46:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,350,1571727600"; d="scan'208";a="223177100"
Received: from allen-box.sh.intel.com ([10.239.159.136])
 by fmsmga001.fm.intel.com with ESMTP; 23 Dec 2019 23:46:26 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH v5 8/9] iommu/vt-d: Use iova over first level
Date: Tue, 24 Dec 2019 15:45:01 +0800
Message-Id: <20191224074502.5545-9-baolu.lu@linux.intel.com>
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

After we make all map/unmap paths support first level page table.
Let's turn it on if hardware supports scalable mode.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 34e619318f64..51d60bad0b1d 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1770,15 +1770,13 @@ static void free_dmar_iommu(struct intel_iommu *iommu)
 
 /*
  * Check and return whether first level is used by default for
- * DMA translation. Currently, we make it off by setting
- * first_level_support = 0, and will change it to -1 after all
- * map/unmap paths support first level page table.
+ * DMA translation.
  */
 static bool first_level_by_default(void)
 {
 	struct dmar_drhd_unit *drhd;
 	struct intel_iommu *iommu;
-	static int first_level_support = 0;
+	static int first_level_support = -1;
 
 	if (likely(first_level_support != -1))
 		return first_level_support;
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
