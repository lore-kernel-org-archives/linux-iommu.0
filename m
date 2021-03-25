Return-Path: <SRS0=Fh/M=IX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8453C433C1
	for <iommu@archiver.kernel.org>; Thu, 25 Mar 2021 12:34:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3833761A1A
	for <iommu@archiver.kernel.org>; Thu, 25 Mar 2021 12:34:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3833761A1A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E18FB40E4E;
	Thu, 25 Mar 2021 12:34:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0Iarskoy2MCG; Thu, 25 Mar 2021 12:34:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id AB20A40F14;
	Thu, 25 Mar 2021 12:34:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 924C6C0016;
	Thu, 25 Mar 2021 12:34:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 52D27C000A
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 12:34:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 39DBB40E4E
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 12:34:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iPzAceT8oTu1 for <iommu@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 12:34:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1157F40F14
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 12:34:22 +0000 (UTC)
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F5kxV6zFgzPlmL;
 Thu, 25 Mar 2021 20:31:42 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Thu, 25 Mar 2021 20:34:07 +0800
From: John Garry <john.garry@huawei.com>
To: <joro@8bytes.org>, <will@kernel.org>, <dwmw2@infradead.org>,
 <baolu.lu@linux.intel.com>, <robin.murphy@arm.com>
Subject: [PATCH v2 2/4] iommu/vt-d: Remove IOVA domain rcache flushing for CPU
 offlining
Date: Thu, 25 Mar 2021 20:29:59 +0800
Message-ID: <1616675401-151997-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1616675401-151997-1-git-send-email-john.garry@huawei.com>
References: <1616675401-151997-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 linuxarm@huawei.com
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

Now that the core code handles flushing per-IOVA domain CPU rcaches,
remove the handling here.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/iommu/intel/iommu.c | 31 -------------------------------
 include/linux/cpuhotplug.h  |  1 -
 2 files changed, 32 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index ee0932307d64..d1e66e1b07b8 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4065,35 +4065,6 @@ static struct notifier_block intel_iommu_memory_nb = {
 	.priority = 0
 };
 
-static void free_all_cpu_cached_iovas(unsigned int cpu)
-{
-	int i;
-
-	for (i = 0; i < g_num_of_iommus; i++) {
-		struct intel_iommu *iommu = g_iommus[i];
-		struct dmar_domain *domain;
-		int did;
-
-		if (!iommu)
-			continue;
-
-		for (did = 0; did < cap_ndoms(iommu->cap); did++) {
-			domain = get_iommu_domain(iommu, (u16)did);
-
-			if (!domain || domain->domain.type != IOMMU_DOMAIN_DMA)
-				continue;
-
-			iommu_dma_free_cpu_cached_iovas(cpu, &domain->domain);
-		}
-	}
-}
-
-static int intel_iommu_cpu_dead(unsigned int cpu)
-{
-	free_all_cpu_cached_iovas(cpu);
-	return 0;
-}
-
 static void intel_disable_iommus(void)
 {
 	struct intel_iommu *iommu = NULL;
@@ -4388,8 +4359,6 @@ int __init intel_iommu_init(void)
 	bus_set_iommu(&pci_bus_type, &intel_iommu_ops);
 	if (si_domain && !hw_pass_through)
 		register_memory_notifier(&intel_iommu_memory_nb);
-	cpuhp_setup_state(CPUHP_IOMMU_INTEL_DEAD, "iommu/intel:dead", NULL,
-			  intel_iommu_cpu_dead);
 
 	down_read(&dmar_global_lock);
 	if (probe_acpi_namespace_devices())
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index cedac9986557..85996494bec1 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -57,7 +57,6 @@ enum cpuhp_state {
 	CPUHP_PAGE_ALLOC_DEAD,
 	CPUHP_NET_DEV_DEAD,
 	CPUHP_PCI_XGENE_DEAD,
-	CPUHP_IOMMU_INTEL_DEAD,
 	CPUHP_IOMMU_IOVA_DEAD,
 	CPUHP_LUSTRE_CFS_DEAD,
 	CPUHP_AP_ARM_CACHE_B15_RAC_DEAD,
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
