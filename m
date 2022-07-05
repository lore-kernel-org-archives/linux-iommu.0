Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13F5EC433EF
	for <iommu@archiver.kernel.org>; Tue,  5 Jul 2022 06:31:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8A8F64048B;
	Tue,  5 Jul 2022 06:31:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8A8F64048B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b8-u-KPMui_S; Tue,  5 Jul 2022 06:31:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 16C4540139;
	Tue,  5 Jul 2022 06:31:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 16C4540139
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C9F01C0032;
	Tue,  5 Jul 2022 06:31:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D5D4C002D
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jul 2022 06:31:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6461460EB9
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jul 2022 06:31:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6461460EB9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oM9SRcEZ7bWE for <iommu@lists.linux-foundation.org>;
 Tue,  5 Jul 2022 06:31:42 +0000 (UTC)
X-Greylist: delayed 00:09:01 by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 811A160EAB
Received: from ozlabs.ru (ozlabs.ru [107.174.27.60])
 by smtp3.osuosl.org (Postfix) with ESMTP id 811A160EAB
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jul 2022 06:31:42 +0000 (UTC)
Received: from fstn1-p1.ozlabs.ibm.com. (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id 31B65804D3;
 Tue,  5 Jul 2022 02:22:37 -0400 (EDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel] powerpc/iommu: Add simple iommu_ops to report
 capabilities
Date: Tue,  5 Jul 2022 16:22:35 +1000
Message-Id: <20220705062235.2276125-1-aik@ozlabs.ru>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <jroedel@suse.de>,
 kvm@vger.kernel.org, Fabiano Rosas <farosas@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 iommu@lists.linux-foundation.org, kvm-ppc@vger.kernel.org,
 Jason Gunthorpe <jgg@ziepe.ca>, Alex Williamson <alex.williamson@redhat.com>,
 Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 Robin Murphy <robin.murphy@arm.com>
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

Historically PPC64 managed to avoid using iommu_ops. The VFIO driver
uses a SPAPR TCE sub-driver and all iommu_ops uses were kept in
the Type1 VFIO driver. Recent development though has added a coherency
capability check to the generic part of VFIO and essentially disabled
VFIO on PPC64.

This adds a simple iommu_ops stub which reports support for cache
coherency. Because bus_set_iommu() triggers IOMMU probing of PCI devices,
this provides minimum code for the probing to not crash.

The previous discussion is here:
https://patchwork.ozlabs.org/project/kvm-ppc/patch/20220701061751.1955857-1-aik@ozlabs.ru/

Fixes: e8ae0e140c05 ("vfio: Require that devices support DMA cache coherence")
Fixes: 70693f470848 ("vfio: Set DMA ownership for VFIO devices")
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

I have not looked into the domains for ages, what is missing here? With this
on top of 5.19-rc1 VFIO works again on my POWER9 box. Thanks,

---
 arch/powerpc/include/asm/iommu.h |  2 +
 arch/powerpc/kernel/iommu.c      | 70 ++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/pci_64.c     |  3 ++
 3 files changed, 75 insertions(+)

diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index 7e29c73e3dd4..4bdae0ee29d0 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -215,6 +215,8 @@ extern long iommu_tce_xchg_no_kill(struct mm_struct *mm,
 		enum dma_data_direction *direction);
 extern void iommu_tce_kill(struct iommu_table *tbl,
 		unsigned long entry, unsigned long pages);
+
+extern const struct iommu_ops spapr_tce_iommu_ops;
 #else
 static inline void iommu_register_group(struct iommu_table_group *table_group,
 					int pci_domain_number,
diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index 7e56ddb3e0b9..2205b448f7d5 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -1176,4 +1176,74 @@ void iommu_del_device(struct device *dev)
 	iommu_group_remove_device(dev);
 }
 EXPORT_SYMBOL_GPL(iommu_del_device);
+
+/*
+ * A simple iommu_ops to allow less cruft in generic VFIO code.
+ */
+static bool spapr_tce_iommu_capable(enum iommu_cap cap)
+{
+	switch (cap) {
+	case IOMMU_CAP_CACHE_COHERENCY:
+		return true;
+	default:
+		break;
+	}
+
+	return false;
+}
+
+static struct iommu_domain *spapr_tce_iommu_domain_alloc(unsigned int type)
+{
+	struct iommu_domain *domain = kzalloc(sizeof(*domain), GFP_KERNEL);
+
+	if (!domain)
+		return NULL;
+
+	domain->geometry.aperture_start = 0;
+	domain->geometry.aperture_end = ~0ULL;
+	domain->geometry.force_aperture = true;
+
+	return domain;
+}
+
+static struct iommu_device *spapr_tce_iommu_probe_device(struct device *dev)
+{
+	struct iommu_device *iommu_dev = kzalloc(sizeof(struct iommu_device), GFP_KERNEL);
+
+	iommu_dev->dev = dev;
+	iommu_dev->ops = &spapr_tce_iommu_ops;
+
+	return iommu_dev;
+}
+
+static void spapr_tce_iommu_release_device(struct device *dev)
+{
+}
+
+static int spapr_tce_iommu_attach_dev(struct iommu_domain *dom,
+				      struct device *dev)
+{
+	return 0;
+}
+
+static struct iommu_group *spapr_tce_iommu_device_group(struct device *dev)
+{
+	struct iommu_group *grp = dev->iommu_group;
+
+	if (!grp)
+		grp = ERR_PTR(-ENODEV);
+	return grp;
+}
+
+const struct iommu_ops spapr_tce_iommu_ops = {
+	.capable = spapr_tce_iommu_capable,
+	.domain_alloc = spapr_tce_iommu_domain_alloc,
+	.probe_device = spapr_tce_iommu_probe_device,
+	.release_device = spapr_tce_iommu_release_device,
+	.device_group = spapr_tce_iommu_device_group,
+	.default_domain_ops = &(const struct iommu_domain_ops) {
+		.attach_dev = spapr_tce_iommu_attach_dev,
+	}
+};
+
 #endif /* CONFIG_IOMMU_API */
diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index 19b03ddf5631..04bc0c52e45c 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -20,6 +20,7 @@
 #include <linux/irq.h>
 #include <linux/vmalloc.h>
 #include <linux/of.h>
+#include <linux/iommu.h>
 
 #include <asm/processor.h>
 #include <asm/io.h>
@@ -27,6 +28,7 @@
 #include <asm/byteorder.h>
 #include <asm/machdep.h>
 #include <asm/ppc-pci.h>
+#include <asm/iommu.h>
 
 /* pci_io_base -- the base address from which io bars are offsets.
  * This is the lowest I/O base address (so bar values are always positive),
@@ -69,6 +71,7 @@ static int __init pcibios_init(void)
 		ppc_md.pcibios_fixup();
 
 	printk(KERN_DEBUG "PCI: Probing PCI hardware done\n");
+	bus_set_iommu(&pci_bus_type, &spapr_tce_iommu_ops);
 
 	return 0;
 }
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
