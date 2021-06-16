Return-Path: <SRS0=eGnl=LK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED39EC48BE5
	for <iommu@archiver.kernel.org>; Wed, 16 Jun 2021 11:09:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B88B26128C
	for <iommu@archiver.kernel.org>; Wed, 16 Jun 2021 11:09:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B88B26128C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 97B6483A99;
	Wed, 16 Jun 2021 11:09:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DkULMlc3WbYB; Wed, 16 Jun 2021 11:09:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8FAF582865;
	Wed, 16 Jun 2021 11:09:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 54D4AC000D;
	Wed, 16 Jun 2021 11:09:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E9728C000B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 11:09:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D8C6B83B84
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 11:09:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Oa3EB4r0trL4 for <iommu@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 11:09:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EFAB083B80
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 11:08:59 +0000 (UTC)
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.206])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G4htZ6PGVz6JBBn;
 Wed, 16 Jun 2021 18:55:50 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 16 Jun 2021 13:08:58 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 16 Jun 2021 12:08:54 +0100
From: John Garry <john.garry@huawei.com>
To: <joro@8bytes.org>, <will@kernel.org>, <dwmw2@infradead.org>,
 <baolu.lu@linux.intel.com>, <robin.murphy@arm.com>, <corbet@lwn.net>
Subject: [PATCH v13 6/6] iommu: Remove mode argument from
 iommu_set_dma_strict()
Date: Wed, 16 Jun 2021 19:03:57 +0800
Message-ID: <1623841437-211832-7-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1623841437-211832-1-git-send-email-john.garry@huawei.com>
References: <1623841437-211832-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxarm@huawei.com, iommu@lists.linux-foundation.org
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

We only ever now set strict mode enabled in iommu_set_dma_strict(), so
just remove the argument.

Signed-off-by: John Garry <john.garry@huawei.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/amd/init.c    | 2 +-
 drivers/iommu/intel/iommu.c | 6 +++---
 drivers/iommu/iommu.c       | 5 ++---
 include/linux/iommu.h       | 2 +-
 4 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index fb3618af643b..7bc460052678 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3099,7 +3099,7 @@ static int __init parse_amd_iommu_options(char *str)
 	for (; *str; ++str) {
 		if (strncmp(str, "fullflush", 9) == 0) {
 			pr_warn("amd_iommu=fullflush deprecated; use iommu.strict instead\n");
-			iommu_set_dma_strict(true);
+			iommu_set_dma_strict();
 		}
 		if (strncmp(str, "force_enable", 12) == 0)
 			amd_iommu_force_enable = true;
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index d586990fa751..0618c35cfb51 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -454,7 +454,7 @@ static int __init intel_iommu_setup(char *str)
 			iommu_dma_forcedac = true;
 		} else if (!strncmp(str, "strict", 6)) {
 			pr_warn("intel_iommu=strict deprecated; use iommu.strict instead\n");
-			iommu_set_dma_strict(true);
+			iommu_set_dma_strict();
 		} else if (!strncmp(str, "sp_off", 6)) {
 			pr_info("Disable supported super page\n");
 			intel_iommu_superpage = 0;
@@ -4382,7 +4382,7 @@ int __init intel_iommu_init(void)
 		 */
 		if (cap_caching_mode(iommu->cap)) {
 			pr_warn("IOMMU batching disallowed due to virtualization\n");
-			iommu_set_dma_strict(true);
+			iommu_set_dma_strict();
 		}
 		iommu_device_sysfs_add(&iommu->iommu, NULL,
 				       intel_iommu_groups,
@@ -5699,7 +5699,7 @@ static void quirk_calpella_no_shadow_gtt(struct pci_dev *dev)
 	} else if (dmar_map_gfx) {
 		/* we have to ensure the gfx device is idle before we flush */
 		pci_info(dev, "Disabling batched IOTLB flush on Ironlake\n");
-		iommu_set_dma_strict(true);
+		iommu_set_dma_strict();
 	}
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x0040, quirk_calpella_no_shadow_gtt);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 60b1ec42e73b..ff221d3ddcbc 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -349,10 +349,9 @@ static int __init iommu_dma_setup(char *str)
 }
 early_param("iommu.strict", iommu_dma_setup);
 
-void iommu_set_dma_strict(bool strict)
+void iommu_set_dma_strict(void)
 {
-	if (strict || !(iommu_cmd_line & IOMMU_CMD_LINE_STRICT))
-		iommu_dma_strict = strict;
+	iommu_dma_strict = true;
 }
 
 bool iommu_get_dma_strict(struct iommu_domain *domain)
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 32d448050bf7..754f67d6dd90 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -476,7 +476,7 @@ int iommu_enable_nesting(struct iommu_domain *domain);
 int iommu_set_pgtable_quirks(struct iommu_domain *domain,
 		unsigned long quirks);
 
-void iommu_set_dma_strict(bool val);
+void iommu_set_dma_strict(void);
 bool iommu_get_dma_strict(struct iommu_domain *domain);
 
 extern int report_iommu_fault(struct iommu_domain *domain, struct device *dev,
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
