Return-Path: <SRS0=A59K=AG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7EB3C433E1
	for <iommu@archiver.kernel.org>; Thu, 25 Jun 2020 13:08:46 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8868320702
	for <iommu@archiver.kernel.org>; Thu, 25 Jun 2020 13:08:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8868320702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7BD1B87AB6;
	Thu, 25 Jun 2020 13:08:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0VDBZ+G-9Boa; Thu, 25 Jun 2020 13:08:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1648D879E9;
	Thu, 25 Jun 2020 13:08:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 09E3FC08A5;
	Thu, 25 Jun 2020 13:08:45 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0C0FBC016F
 for <iommu@lists.linux-foundation.org>; Thu, 25 Jun 2020 13:08:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id EF7B085751
 for <iommu@lists.linux-foundation.org>; Thu, 25 Jun 2020 13:08:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nexBG7xjL1DQ for <iommu@lists.linux-foundation.org>;
 Thu, 25 Jun 2020 13:08:42 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 83BDA854D7
 for <iommu@lists.linux-foundation.org>; Thu, 25 Jun 2020 13:08:42 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 3A7BB261; Thu, 25 Jun 2020 15:08:38 +0200 (CEST)
From: Joerg Roedel <joro@8bytes.org>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 02/13] iommu/vt-d: Use dev_iommu_priv_get/set()
Date: Thu, 25 Jun 2020 15:08:25 +0200
Message-Id: <20200625130836.1916-3-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200625130836.1916-1-joro@8bytes.org>
References: <20200625130836.1916-1-joro@8bytes.org>
Cc: linux-ia64@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
 David Airlie <airlied@linux.ie>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Thierry Reding <thierry.reding@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Will Deacon <will@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 x86@kernel.org, Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Joerg Roedel <jroedel@suse.de>, intel-gfx@lists.freedesktop.org,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org, Tony Luck <tony.luck@intel.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Daniel Vetter <daniel@ffwll.ch>, David Woodhouse <dwmw2@infradead.org>
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

From: Joerg Roedel <jroedel@suse.de>

Remove the use of dev->archdata.iommu and use the private per-device
pointer provided by IOMMU core code instead.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 .../gpu/drm/i915/selftests/mock_gem_device.c   | 10 ++++++++--
 drivers/iommu/intel/iommu.c                    | 18 +++++++++---------
 2 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/i915/selftests/mock_gem_device.c b/drivers/gpu/drm/i915/selftests/mock_gem_device.c
index 9b105b811f1f..e08601905a64 100644
--- a/drivers/gpu/drm/i915/selftests/mock_gem_device.c
+++ b/drivers/gpu/drm/i915/selftests/mock_gem_device.c
@@ -24,6 +24,7 @@
 
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
+#include <linux/iommu.h>
 
 #include <drm/drm_managed.h>
 
@@ -118,6 +119,9 @@ struct drm_i915_private *mock_gem_device(void)
 {
 	struct drm_i915_private *i915;
 	struct pci_dev *pdev;
+#if IS_ENABLED(CONFIG_IOMMU_API) && defined(CONFIG_INTEL_IOMMU)
+	struct dev_iommu iommu;
+#endif
 	int err;
 
 	pdev = kzalloc(sizeof(*pdev), GFP_KERNEL);
@@ -136,8 +140,10 @@ struct drm_i915_private *mock_gem_device(void)
 	dma_coerce_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
 
 #if IS_ENABLED(CONFIG_IOMMU_API) && defined(CONFIG_INTEL_IOMMU)
-	/* hack to disable iommu for the fake device; force identity mapping */
-	pdev->dev.archdata.iommu = (void *)-1;
+	/* HACK HACK HACK to disable iommu for the fake device; force identity mapping */
+	memset(&iommu, 0, sizeof(iommu));
+	iommu.priv = (void *)-1;
+	pdev->dev.iommu = &iommu;
 #endif
 
 	pci_set_drvdata(pdev, i915);
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index d759e7234e98..2ce490c2eab8 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -372,7 +372,7 @@ struct device_domain_info *get_domain_info(struct device *dev)
 	if (!dev)
 		return NULL;
 
-	info = dev->archdata.iommu;
+	info = dev_iommu_priv_get(dev);
 	if (unlikely(info == DUMMY_DEVICE_DOMAIN_INFO ||
 		     info == DEFER_DEVICE_DOMAIN_INFO))
 		return NULL;
@@ -743,12 +743,12 @@ struct context_entry *iommu_context_addr(struct intel_iommu *iommu, u8 bus,
 
 static int iommu_dummy(struct device *dev)
 {
-	return dev->archdata.iommu == DUMMY_DEVICE_DOMAIN_INFO;
+	return dev_iommu_priv_get(dev) == DUMMY_DEVICE_DOMAIN_INFO;
 }
 
 static bool attach_deferred(struct device *dev)
 {
-	return dev->archdata.iommu == DEFER_DEVICE_DOMAIN_INFO;
+	return dev_iommu_priv_get(dev) == DEFER_DEVICE_DOMAIN_INFO;
 }
 
 /**
@@ -2420,7 +2420,7 @@ static inline void unlink_domain_info(struct device_domain_info *info)
 	list_del(&info->link);
 	list_del(&info->global);
 	if (info->dev)
-		info->dev->archdata.iommu = NULL;
+		dev_iommu_priv_set(info->dev, NULL);
 }
 
 static void domain_remove_dev_info(struct dmar_domain *domain)
@@ -2453,7 +2453,7 @@ static void do_deferred_attach(struct device *dev)
 {
 	struct iommu_domain *domain;
 
-	dev->archdata.iommu = NULL;
+	dev_iommu_priv_set(dev, NULL);
 	domain = iommu_get_domain_for_dev(dev);
 	if (domain)
 		intel_iommu_attach_device(domain, dev);
@@ -2599,7 +2599,7 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 	list_add(&info->link, &domain->devices);
 	list_add(&info->global, &device_domain_list);
 	if (dev)
-		dev->archdata.iommu = info;
+		dev_iommu_priv_set(dev, info);
 	spin_unlock_irqrestore(&device_domain_lock, flags);
 
 	/* PASID table is mandatory for a PCI device in scalable mode. */
@@ -4004,7 +4004,7 @@ static void quirk_ioat_snb_local_iommu(struct pci_dev *pdev)
 	if (!drhd || drhd->reg_base_addr - vtbar != 0xa000) {
 		pr_warn_once(FW_BUG "BIOS assigned incorrect VT-d unit for Intel(R) QuickData Technology device\n");
 		add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_STILL_OK);
-		pdev->dev.archdata.iommu = DUMMY_DEVICE_DOMAIN_INFO;
+		dev_iommu_priv_set(&pdev->dev, DUMMY_DEVICE_DOMAIN_INFO);
 	}
 }
 DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_IOAT_SNB, quirk_ioat_snb_local_iommu);
@@ -4043,7 +4043,7 @@ static void __init init_no_remapping_devices(void)
 			drhd->ignored = 1;
 			for_each_active_dev_scope(drhd->devices,
 						  drhd->devices_cnt, i, dev)
-				dev->archdata.iommu = DUMMY_DEVICE_DOMAIN_INFO;
+				dev_iommu_priv_set(dev, DUMMY_DEVICE_DOMAIN_INFO);
 		}
 	}
 }
@@ -5665,7 +5665,7 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 		return ERR_PTR(-ENODEV);
 
 	if (translation_pre_enabled(iommu))
-		dev->archdata.iommu = DEFER_DEVICE_DOMAIN_INFO;
+		dev_iommu_priv_set(dev, DEFER_DEVICE_DOMAIN_INFO);
 
 	return &iommu->iommu;
 }
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
