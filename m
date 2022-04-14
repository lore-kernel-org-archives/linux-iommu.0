Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEAF3C4332F
	for <iommu@archiver.kernel.org>; Thu, 14 Apr 2022 12:42:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8D77241918;
	Thu, 14 Apr 2022 12:42:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N9arO1UGsbdV; Thu, 14 Apr 2022 12:42:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 41BC94190B;
	Thu, 14 Apr 2022 12:42:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 28F90C0082;
	Thu, 14 Apr 2022 12:42:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B0DC8C002C
 for <iommu@lists.linux-foundation.org>; Thu, 14 Apr 2022 12:42:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9F90E84175
 for <iommu@lists.linux-foundation.org>; Thu, 14 Apr 2022 12:42:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rLZXXiAo_c3c for <iommu@lists.linux-foundation.org>;
 Thu, 14 Apr 2022 12:42:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id EEE5984172
 for <iommu@lists.linux-foundation.org>; Thu, 14 Apr 2022 12:42:54 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 556F31424;
 Thu, 14 Apr 2022 05:42:54 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com
 [10.1.196.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5A88B3F70D;
 Thu, 14 Apr 2022 05:42:52 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Subject: [PATCH 03/13] iommu/amd: Clean up bus_set_iommu()
Date: Thu, 14 Apr 2022 13:42:32 +0100
Message-Id: <0ca792523ac9ca1a6ca63a7712aa8b9454f17e3d.1649935679.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.28.0.dirty
In-Reply-To: <cover.1649935679.git.robin.murphy@arm.com>
References: <cover.1649935679.git.robin.murphy@arm.com>
MIME-Version: 1.0
Cc: jean-philippe@linaro.org, zhang.lyra@gmail.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 thierry.reding@gmail.com, linux-arm-kernel@lists.infradead.org,
 gerald.schaefer@linux.ibm.com
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

Stop calling bus_set_iommu() since it's now unnecessary, and
garbage-collect the last remnants of amd_iommu_init_api().

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/amd/amd_iommu.h |  1 -
 drivers/iommu/amd/init.c      |  9 +--------
 drivers/iommu/amd/iommu.c     | 21 ---------------------
 3 files changed, 1 insertion(+), 30 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 1ab31074f5b3..384393ce57fb 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -18,7 +18,6 @@ extern void amd_iommu_restart_event_logging(struct amd_iommu *iommu);
 extern int amd_iommu_init_devices(void);
 extern void amd_iommu_uninit_devices(void);
 extern void amd_iommu_init_notifier(void);
-extern int amd_iommu_init_api(void);
 
 #ifdef CONFIG_AMD_IOMMU_DEBUGFS
 void amd_iommu_debugfs_setup(struct amd_iommu *iommu);
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 0467918bf7fd..1cb10d8b0df4 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1970,20 +1970,13 @@ static int __init amd_iommu_init_pci(void)
 	/*
 	 * Order is important here to make sure any unity map requirements are
 	 * fulfilled. The unity mappings are created and written to the device
-	 * table during the amd_iommu_init_api() call.
+	 * table during the iommu_init_pci() call.
 	 *
 	 * After that we call init_device_table_dma() to make sure any
 	 * uninitialized DTE will block DMA, and in the end we flush the caches
 	 * of all IOMMUs to make sure the changes to the device table are
 	 * active.
 	 */
-	ret = amd_iommu_init_api();
-	if (ret) {
-		pr_err("IOMMU: Failed to initialize IOMMU-API interface (error=%d)!\n",
-		       ret);
-		goto out;
-	}
-
 	init_device_table_dma();
 
 	for_each_iommu(iommu)
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 6366a473ef0d..c0f8a541a7d6 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -11,8 +11,6 @@
 #include <linux/ratelimit.h>
 #include <linux/pci.h>
 #include <linux/acpi.h>
-#include <linux/amba/bus.h>
-#include <linux/platform_device.h>
 #include <linux/pci-ats.h>
 #include <linux/bitmap.h>
 #include <linux/slab.h>
@@ -1838,25 +1836,6 @@ void amd_iommu_domain_update(struct protection_domain *domain)
 	amd_iommu_domain_flush_complete(domain);
 }
 
-int __init amd_iommu_init_api(void)
-{
-	int err;
-
-	err = bus_set_iommu(&pci_bus_type, &amd_iommu_ops);
-	if (err)
-		return err;
-#ifdef CONFIG_ARM_AMBA
-	err = bus_set_iommu(&amba_bustype, &amd_iommu_ops);
-	if (err)
-		return err;
-#endif
-	err = bus_set_iommu(&platform_bus_type, &amd_iommu_ops);
-	if (err)
-		return err;
-
-	return 0;
-}
-
 /*****************************************************************************
  *
  * The following functions belong to the exported interface of AMD IOMMU
-- 
2.28.0.dirty

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
