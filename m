Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B271C6B2
	for <iommu@lists.linux.dev>; Thu, 29 Aug 2024 02:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724896935; cv=none; b=SyCES2phjojMWVPZ1qbS1I6tefDm7G00WdpZuZo+v/fuuW6rXIWLPKOdK/TcbAVm/JsfQTCJ+M93hk/pIJ4IDza/tfSI9wYAytkxXEP/2ut6C/+4qhXTecHcBxjuePuWsJKvoPnrE9g4ngVuVrjtY+bhquB0Nv0zxxAvPio04Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724896935; c=relaxed/simple;
	bh=PuH7o9wtgobXDolgCEjHLS3wi6KOhxEJdMNpv+1m/g8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pXfRnuoYxZJscsUwD8jmryeM3zWmB23k9UgowFZLZWkxZspuUtcPQ/bP+zfdw7I/GNZqvxXDQyy/4bWweVp1nqmdiAdntVvgwOxzXwtxFWofgG7H3YHBKpwcPvbMbIXpDJde50BCC0Jy2jOLF+u+2kkNU1YS9ft21HqrCrkDHWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WvPZx21Wcz1HHJy;
	Thu, 29 Aug 2024 09:58:49 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id B7E5D1400FD;
	Thu, 29 Aug 2024 10:02:09 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 29 Aug
 2024 10:02:09 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <joro@8bytes.org>,
	<will@kernel.org>, <robin.murphy@arm.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next] iommu/vt-d: Use PCI_DEVID() macro
Date: Thu, 29 Aug 2024 10:10:11 +0800
Message-ID: <20240829021011.4135618-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemh500013.china.huawei.com (7.202.181.146)

The macro PCI_DEVID() can be used instead of compose it manually.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/iommu/intel/iommu.c         | 4 ++--
 drivers/iommu/intel/irq_remapping.c | 4 ++--
 drivers/iommu/intel/pasid.c         | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 71e934c75034..27652daa143c 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1677,7 +1677,7 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 
 		if (did_old < cap_ndoms(iommu->cap)) {
 			iommu->flush.flush_context(iommu, did_old,
-						   (((u16)bus) << 8) | devfn,
+						   PCI_DEVID(bus, devfn),
 						   DMA_CCMD_MASK_NOBIT,
 						   DMA_CCMD_DEVICE_INVL);
 			iommu->flush.flush_iotlb(iommu, did_old, 0, 0,
@@ -1732,7 +1732,7 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 	 */
 	if (cap_caching_mode(iommu->cap)) {
 		iommu->flush.flush_context(iommu, 0,
-					   (((u16)bus) << 8) | devfn,
+					   PCI_DEVID(bus, devfn),
 					   DMA_CCMD_MASK_NOBIT,
 					   DMA_CCMD_DEVICE_INVL);
 		iommu->flush.flush_iotlb(iommu, did, 0, 0, DMA_TLB_DSI_FLUSH);
diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index 7a6d188e3bea..466c1412dd45 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -312,7 +312,7 @@ static int set_ioapic_sid(struct irte *irte, int apic)
 
 	for (i = 0; i < MAX_IO_APICS; i++) {
 		if (ir_ioapic[i].iommu && ir_ioapic[i].id == apic) {
-			sid = (ir_ioapic[i].bus << 8) | ir_ioapic[i].devfn;
+			sid = PCI_DEVID(ir_ioapic[i].bus, ir_ioapic[i].devfn);
 			break;
 		}
 	}
@@ -337,7 +337,7 @@ static int set_hpet_sid(struct irte *irte, u8 id)
 
 	for (i = 0; i < MAX_HPET_TBS; i++) {
 		if (ir_hpet[i].iommu && ir_hpet[i].id == id) {
-			sid = (ir_hpet[i].bus << 8) | ir_hpet[i].devfn;
+			sid = PCI_DEVID(ir_hpet[i].bus, ir_hpet[i].devfn);
 			break;
 		}
 	}
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index b51fc268dc84..c206c0eac97c 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -220,7 +220,7 @@ devtlb_invalidation_with_pasid(struct intel_iommu *iommu,
 	if (pci_dev_is_disconnected(to_pci_dev(dev)))
 		return;
 
-	sid = info->bus << 8 | info->devfn;
+	sid = PCI_DEVID(info->bus, info->devfn);
 	qdep = info->ats_qdep;
 	pfsid = info->pfsid;
 
-- 
2.34.1

