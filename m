Return-Path: <SRS0=A59K=AG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 571A6C433E0
	for <iommu@archiver.kernel.org>; Thu, 25 Jun 2020 13:08:52 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3326520724
	for <iommu@archiver.kernel.org>; Thu, 25 Jun 2020 13:08:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3326520724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 118E623244;
	Thu, 25 Jun 2020 13:08:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YI6apfWogwX0; Thu, 25 Jun 2020 13:08:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 200A82313B;
	Thu, 25 Jun 2020 13:08:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0DB28C016F;
	Thu, 25 Jun 2020 13:08:49 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 344C6C088E
 for <iommu@lists.linux-foundation.org>; Thu, 25 Jun 2020 13:08:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 22FFB854D7
 for <iommu@lists.linux-foundation.org>; Thu, 25 Jun 2020 13:08:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id l2hwYtpv8AFQ for <iommu@lists.linux-foundation.org>;
 Thu, 25 Jun 2020 13:08:42 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 6799E854A7
 for <iommu@lists.linux-foundation.org>; Thu, 25 Jun 2020 13:08:42 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 1D4FB391; Thu, 25 Jun 2020 15:08:38 +0200 (CEST)
From: Joerg Roedel <joro@8bytes.org>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 01/13] iommu/exynos: Use dev_iommu_priv_get/set()
Date: Thu, 25 Jun 2020 15:08:24 +0200
Message-Id: <20200625130836.1916-2-joro@8bytes.org>
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
 drivers/iommu/exynos-iommu.c                  | 20 +++++++++----------
 .../media/platform/s5p-mfc/s5p_mfc_iommu.h    |  4 +++-
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 60c8a56e4a3f..6a9b67302369 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -173,7 +173,7 @@ static u32 lv2ent_offset(sysmmu_iova_t iova)
 #define REG_V5_FAULT_AR_VA	0x070
 #define REG_V5_FAULT_AW_VA	0x080
 
-#define has_sysmmu(dev)		(dev->archdata.iommu != NULL)
+#define has_sysmmu(dev)		(dev_iommu_priv_get(dev) != NULL)
 
 static struct device *dma_dev;
 static struct kmem_cache *lv2table_kmem_cache;
@@ -226,7 +226,7 @@ static const struct sysmmu_fault_info sysmmu_v5_faults[] = {
 };
 
 /*
- * This structure is attached to dev.archdata.iommu of the master device
+ * This structure is attached to dev->iommu->priv of the master device
  * on device add, contains a list of SYSMMU controllers defined by device tree,
  * which are bound to given master device. It is usually referenced by 'owner'
  * pointer.
@@ -670,7 +670,7 @@ static int __maybe_unused exynos_sysmmu_suspend(struct device *dev)
 	struct device *master = data->master;
 
 	if (master) {
-		struct exynos_iommu_owner *owner = master->archdata.iommu;
+		struct exynos_iommu_owner *owner = dev_iommu_priv_get(master);
 
 		mutex_lock(&owner->rpm_lock);
 		if (data->domain) {
@@ -688,7 +688,7 @@ static int __maybe_unused exynos_sysmmu_resume(struct device *dev)
 	struct device *master = data->master;
 
 	if (master) {
-		struct exynos_iommu_owner *owner = master->archdata.iommu;
+		struct exynos_iommu_owner *owner = dev_iommu_priv_get(master);
 
 		mutex_lock(&owner->rpm_lock);
 		if (data->domain) {
@@ -837,8 +837,8 @@ static void exynos_iommu_domain_free(struct iommu_domain *iommu_domain)
 static void exynos_iommu_detach_device(struct iommu_domain *iommu_domain,
 				    struct device *dev)
 {
-	struct exynos_iommu_owner *owner = dev->archdata.iommu;
 	struct exynos_iommu_domain *domain = to_exynos_domain(iommu_domain);
+	struct exynos_iommu_owner *owner = dev_iommu_priv_get(dev);
 	phys_addr_t pagetable = virt_to_phys(domain->pgtable);
 	struct sysmmu_drvdata *data, *next;
 	unsigned long flags;
@@ -875,8 +875,8 @@ static void exynos_iommu_detach_device(struct iommu_domain *iommu_domain,
 static int exynos_iommu_attach_device(struct iommu_domain *iommu_domain,
 				   struct device *dev)
 {
-	struct exynos_iommu_owner *owner = dev->archdata.iommu;
 	struct exynos_iommu_domain *domain = to_exynos_domain(iommu_domain);
+	struct exynos_iommu_owner *owner = dev_iommu_priv_get(dev);
 	struct sysmmu_drvdata *data;
 	phys_addr_t pagetable = virt_to_phys(domain->pgtable);
 	unsigned long flags;
@@ -1237,7 +1237,7 @@ static phys_addr_t exynos_iommu_iova_to_phys(struct iommu_domain *iommu_domain,
 
 static struct iommu_device *exynos_iommu_probe_device(struct device *dev)
 {
-	struct exynos_iommu_owner *owner = dev->archdata.iommu;
+	struct exynos_iommu_owner *owner = dev_iommu_priv_get(dev);
 	struct sysmmu_drvdata *data;
 
 	if (!has_sysmmu(dev))
@@ -1263,7 +1263,7 @@ static struct iommu_device *exynos_iommu_probe_device(struct device *dev)
 
 static void exynos_iommu_release_device(struct device *dev)
 {
-	struct exynos_iommu_owner *owner = dev->archdata.iommu;
+	struct exynos_iommu_owner *owner = dev_iommu_priv_get(dev);
 	struct sysmmu_drvdata *data;
 
 	if (!has_sysmmu(dev))
@@ -1287,8 +1287,8 @@ static void exynos_iommu_release_device(struct device *dev)
 static int exynos_iommu_of_xlate(struct device *dev,
 				 struct of_phandle_args *spec)
 {
-	struct exynos_iommu_owner *owner = dev->archdata.iommu;
 	struct platform_device *sysmmu = of_find_device_by_node(spec->np);
+	struct exynos_iommu_owner *owner = dev_iommu_priv_get(dev);
 	struct sysmmu_drvdata *data, *entry;
 
 	if (!sysmmu)
@@ -1305,7 +1305,7 @@ static int exynos_iommu_of_xlate(struct device *dev,
 
 		INIT_LIST_HEAD(&owner->controllers);
 		mutex_init(&owner->rpm_lock);
-		dev->archdata.iommu = owner;
+		dev_iommu_priv_set(dev, owner);
 	}
 
 	list_for_each_entry(entry, &owner->controllers, owner_node)
diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_iommu.h b/drivers/media/platform/s5p-mfc/s5p_mfc_iommu.h
index 152a713fff78..1a32266b7ddc 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_iommu.h
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc_iommu.h
@@ -9,9 +9,11 @@
 
 #if defined(CONFIG_EXYNOS_IOMMU)
 
+#include <linux/iommu.h>
+
 static inline bool exynos_is_iommu_available(struct device *dev)
 {
-	return dev->archdata.iommu != NULL;
+	return dev_iommu_priv_get(dev) != NULL;
 }
 
 #else
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
