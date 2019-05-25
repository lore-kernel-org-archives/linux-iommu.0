Return-Path: <SRS0=lyO4=TZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0E3C28CBF
	for <iommu@archiver.kernel.org>; Sat, 25 May 2019 05:49:12 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FF6721871
	for <iommu@archiver.kernel.org>; Sat, 25 May 2019 05:49:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FF6721871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 5A4C3CD4;
	Sat, 25 May 2019 05:48:56 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id BB21FB65
	for <iommu@lists.linux-foundation.org>;
	Sat, 25 May 2019 05:48:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 5BF4CA9
	for <iommu@lists.linux-foundation.org>;
	Sat, 25 May 2019 05:48:55 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
	by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	24 May 2019 22:48:55 -0700
X-ExtLoop1: 1
Received: from allen-box.sh.intel.com ([10.239.159.136])
	by fmsmga006.fm.intel.com with ESMTP; 24 May 2019 22:48:52 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: David Woodhouse <dwmw2@infradead.org>,
	Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v4 04/15] iommu/vt-d: Enable DMA remapping after rmrr mapped
Date: Sat, 25 May 2019 13:41:25 +0800
Message-Id: <20190525054136.27810-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190525054136.27810-1-baolu.lu@linux.intel.com>
References: <20190525054136.27810-1-baolu.lu@linux.intel.com>
Cc: kevin.tian@intel.com, ashok.raj@intel.com, dima@arista.com,
	tmurphy@arista.com, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com
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

The rmrr devices require identity map of the rmrr regions before
enabling DMA remapping. Otherwise, there will be a window during
which DMA from/to the rmrr regions will be blocked. In order to
alleviate this, we move enabling DMA remapping after all rmrr
regions get mapped.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index c42317e27b0c..bac226dc8360 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3538,11 +3538,6 @@ static int __init init_dmars(void)
 		ret = dmar_set_interrupt(iommu);
 		if (ret)
 			goto free_iommu;
-
-		if (!translation_pre_enabled(iommu))
-			iommu_enable_translation(iommu);
-
-		iommu_disable_protect_mem_regions(iommu);
 	}
 
 	return 0;
@@ -4922,7 +4917,6 @@ int __init intel_iommu_init(void)
 		goto out_free_reserved_range;
 	}
 	up_write(&dmar_global_lock);
-	pr_info("Intel(R) Virtualization Technology for Directed I/O\n");
 
 #if defined(CONFIG_X86) && defined(CONFIG_SWIOTLB)
 	swiotlb = 0;
@@ -4945,6 +4939,16 @@ int __init intel_iommu_init(void)
 		register_memory_notifier(&intel_iommu_memory_nb);
 	cpuhp_setup_state(CPUHP_IOMMU_INTEL_DEAD, "iommu/intel:dead", NULL,
 			  intel_iommu_cpu_dead);
+
+	/* Finally, we enable the DMA remapping hardware. */
+	for_each_iommu(iommu, drhd) {
+		if (!translation_pre_enabled(iommu))
+			iommu_enable_translation(iommu);
+
+		iommu_disable_protect_mem_regions(iommu);
+	}
+	pr_info("Intel(R) Virtualization Technology for Directed I/O\n");
+
 	intel_iommu_enabled = 1;
 	intel_iommu_debugfs_init();
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
