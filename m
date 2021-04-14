Return-Path: <SRS0=7Zqx=JL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D021AC43603
	for <iommu@archiver.kernel.org>; Wed, 14 Apr 2021 14:50:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 767CB6121E
	for <iommu@archiver.kernel.org>; Wed, 14 Apr 2021 14:50:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 767CB6121E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3D2DE6073A;
	Wed, 14 Apr 2021 14:50:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id msjSg3OEyhwU; Wed, 14 Apr 2021 14:50:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0835660702;
	Wed, 14 Apr 2021 14:50:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DB2C0C000B;
	Wed, 14 Apr 2021 14:50:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0B836C000A
 for <iommu@lists.linux-foundation.org>; Wed, 14 Apr 2021 14:50:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C3EC440607
 for <iommu@lists.linux-foundation.org>; Wed, 14 Apr 2021 14:50:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w4L-73QCrUej for <iommu@lists.linux-foundation.org>;
 Wed, 14 Apr 2021 14:50:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5E29440EAD
 for <iommu@lists.linux-foundation.org>; Wed, 14 Apr 2021 14:50:34 +0000 (UTC)
Received: by mail-pf1-x42f.google.com with SMTP id 10so5024212pfl.1
 for <iommu@lists.linux-foundation.org>; Wed, 14 Apr 2021 07:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BJQLwkA9W/535NLWBZWmq8i7UzFGYSRLRmzJAHK8gIA=;
 b=JeMh273MlJLiBAiimx+AK/wv4TS0pmL3eBkyQYbrrXJc1p9t/yVCYThm+LfoCsHw8b
 qc357p2ojcjzv+t66VCGbcpGh6sP5aej3NeI2NGQBx8TWlHjcVniMXHPRLSAy02Xtfj9
 QmnwrGOGhe4Phsl7n/ZircRPOOVmQ1TXqt4Avf0iGoJRapPIK9HXosZecvlfzBd5EhXH
 FDzxhyyvEEVP1UJI3OfWsiOepqSyZscMd5MY4KXWWWVrmZVVEgwSl/2MiBesqnrJ8uYs
 RB2C4rHWHp/EqEuAXdrglsAw6k/T1G14KlpgPV4Ly+ua1TDR6WZgt4jXYpCgu5UDIdgy
 /svw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BJQLwkA9W/535NLWBZWmq8i7UzFGYSRLRmzJAHK8gIA=;
 b=U4jkwcvP6Lf90qMVcBVGjR40FppdOovcYfQk7hDPw3/5lGLTfoHH40pK6hSVl9WuUh
 CWvDTqneIZL1cXQyx9yEXu7wQD8+QFPk9s69ES4WEvYs0IBGrVCgp4zOJOfZtXY+Qxz0
 9Du4uoxWdCYZgNgjpudn31VZkKPT/dfPjtOGXAyyJdJUgb30jkcTOTWfAVXJBIOsavcc
 YZ80a0jMDoH9mShPVGDznijegHiCLNDkDLEQ+aD+rE4Y76laflt4vQzu9EH7NzssueRC
 KtuIrjJ+0WEs9aUZBlwEtmEPAYaPGxe3R2bwCJirUdbJHj2fSrmtDOC+nOXEXLUzy2f9
 Peug==
X-Gm-Message-State: AOAM532pnvBoGp3OGLt9ZIrByAUYLhaFvfqLA5amt9KhkWkVI2bY76Eb
 sVftDakEJlXHKaFv692rSzg=
X-Google-Smtp-Source: ABdhPJwOhx54FmzERuqfo9qVMIzIREINFZJXuw5QLznc5Vw3o4KmCJSYx6u1IpzPG7gCSgG4YUCpkA==
X-Received: by 2002:a63:77cf:: with SMTP id
 s198mr38257555pgc.252.1618411833797; 
 Wed, 14 Apr 2021 07:50:33 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com
 ([2001:4898:80e8:35:ebad:12c1:f579:e332])
 by smtp.gmail.com with ESMTPSA id w67sm17732522pgb.87.2021.04.14.07.50.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Apr 2021 07:50:33 -0700 (PDT)
From: Tianyu Lan <ltykernel@gmail.com>
To: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
 wei.liu@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 x86@kernel.org, hpa@zytor.com, arnd@arndb.de, akpm@linux-foundation.org,
 gregkh@linuxfoundation.org, konrad.wilk@oracle.com, hch@lst.de,
 m.szyprowski@samsung.com, robin.murphy@arm.com, joro@8bytes.org,
 will@kernel.org, davem@davemloft.net, kuba@kernel.org, jejb@linux.ibm.com,
 martin.petersen@oracle.com
Subject: [Resend RFC PATCH V2 10/12] HV/IOMMU: Add Hyper-V dma ops support
Date: Wed, 14 Apr 2021 10:49:43 -0400
Message-Id: <20210414144945.3460554-11-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210414144945.3460554-1-ltykernel@gmail.com>
References: <20210414144945.3460554-1-ltykernel@gmail.com>
MIME-Version: 1.0
Cc: linux-arch@vger.kernel.org, thomas.lendacky@amd.com,
 linux-hyperv@vger.kernel.org, Tianyu Lan <Tianyu.Lan@microsoft.com>,
 linux-scsi@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, brijesh.singh@amd.com, vkuznets@redhat.com,
 sunilmut@microsoft.com
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

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

Hyper-V Isolation VM requires bounce buffer support. To use swiotlb
bounce buffer, add Hyper-V dma ops and use swiotlb functions in the
map and unmap callback.

Allocate bounce buffer in the Hyper-V code because bounce buffer
needs to be accessed via extra address space(e.g, address above 39bit)
in the AMD SEV SNP based Isolation VM.

ioremap_cache() can't use in the hyperv_iommu_swiotlb_init() which
is too early place and remap bounce buffer in the hyperv_iommu_swiotlb_
later_init().

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
 arch/x86/kernel/pci-swiotlb.c |   3 +-
 drivers/hv/vmbus_drv.c        |   3 +
 drivers/iommu/hyperv-iommu.c  | 127 ++++++++++++++++++++++++++++++++++
 3 files changed, 132 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/pci-swiotlb.c b/arch/x86/kernel/pci-swiotlb.c
index c2cfa5e7c152..caaf68c06f24 100644
--- a/arch/x86/kernel/pci-swiotlb.c
+++ b/arch/x86/kernel/pci-swiotlb.c
@@ -15,6 +15,7 @@
 #include <asm/iommu_table.h>
 
 int swiotlb __read_mostly;
+extern int hyperv_swiotlb;
 
 /*
  * pci_swiotlb_detect_override - set swiotlb to 1 if necessary
@@ -68,7 +69,7 @@ void __init pci_swiotlb_init(void)
 void __init pci_swiotlb_late_init(void)
 {
 	/* An IOMMU turned us off. */
-	if (!swiotlb)
+	if (!swiotlb && !hyperv_swiotlb)
 		swiotlb_exit();
 	else {
 		printk(KERN_INFO "PCI-DMA: "
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 10dce9f91216..0ee6ec3a5de6 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -23,6 +23,7 @@
 #include <linux/cpu.h>
 #include <linux/sched/task_stack.h>
 
+#include <linux/dma-map-ops.h>
 #include <linux/delay.h>
 #include <linux/notifier.h>
 #include <linux/ptrace.h>
@@ -2030,6 +2031,7 @@ struct hv_device *vmbus_device_create(const guid_t *type,
 	return child_device_obj;
 }
 
+static u64 vmbus_dma_mask = DMA_BIT_MASK(64);
 /*
  * vmbus_device_register - Register the child device
  */
@@ -2070,6 +2072,7 @@ int vmbus_device_register(struct hv_device *child_device_obj)
 	}
 	hv_debug_add_dev_dir(child_device_obj);
 
+	child_device_obj->device.dma_mask = &vmbus_dma_mask;
 	return 0;
 
 err_kset_unregister:
diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.c
index e285a220c913..588ba847f0cc 100644
--- a/drivers/iommu/hyperv-iommu.c
+++ b/drivers/iommu/hyperv-iommu.c
@@ -13,19 +13,28 @@
 #include <linux/irq.h>
 #include <linux/iommu.h>
 #include <linux/module.h>
+#include <linux/hyperv.h>
 
+#include <asm/io.h>
 #include <asm/apic.h>
 #include <asm/cpu.h>
 #include <asm/hw_irq.h>
 #include <asm/io_apic.h>
+#include <asm/iommu.h>
+#include <asm/iommu_table.h>
 #include <asm/irq_remapping.h>
 #include <asm/hypervisor.h>
 #include <asm/mshyperv.h>
+#include <asm/swiotlb.h>
+#include <linux/dma-map-ops.h>
+#include <linux/dma-direct.h>
 
 #include "irq_remapping.h"
 
 #ifdef CONFIG_IRQ_REMAP
 
+int hyperv_swiotlb __read_mostly;
+
 /*
  * According 82093AA IO-APIC spec , IO APIC has a 24-entry Interrupt
  * Redirection Table. Hyper-V exposes one single IO-APIC and so define
@@ -36,6 +45,10 @@
 static cpumask_t ioapic_max_cpumask = { CPU_BITS_NONE };
 static struct irq_domain *ioapic_ir_domain;
 
+static unsigned long hyperv_io_tlb_start, *hyperv_io_tlb_end; 
+static unsigned long hyperv_io_tlb_nslabs, hyperv_io_tlb_size;
+static void *hyperv_io_tlb_remap;
+
 static int hyperv_ir_set_affinity(struct irq_data *data,
 		const struct cpumask *mask, bool force)
 {
@@ -337,4 +350,118 @@ static const struct irq_domain_ops hyperv_root_ir_domain_ops = {
 	.free = hyperv_root_irq_remapping_free,
 };
 
+static dma_addr_t hyperv_map_page(struct device *dev, struct page *page,
+				  unsigned long offset, size_t size,
+				  enum dma_data_direction dir,
+				  unsigned long attrs)
+{
+	phys_addr_t map, phys = (page_to_pfn(page) << PAGE_SHIFT) + offset;
+
+	if (!hv_is_isolation_supported())
+		return phys;
+
+	map = swiotlb_tbl_map_single(dev, phys, size, HV_HYP_PAGE_SIZE, dir,
+				     attrs);
+	if (map == (phys_addr_t)DMA_MAPPING_ERROR)
+		return DMA_MAPPING_ERROR;
+
+	return map;
+}
+
+static void hyperv_unmap_page(struct device *dev, dma_addr_t dev_addr,
+		size_t size, enum dma_data_direction dir, unsigned long attrs)
+{
+	if (!hv_is_isolation_supported())
+		return;
+
+	swiotlb_tbl_unmap_single(dev, dev_addr, size, HV_HYP_PAGE_SIZE, dir,
+				attrs);
+}
+
+int __init hyperv_swiotlb_init(void)
+{
+	unsigned long bytes;
+	void *vstart = 0;
+
+	bytes = 200 * 1024 * 1024;
+	vstart = memblock_alloc_low(PAGE_ALIGN(bytes), PAGE_SIZE);
+	hyperv_io_tlb_nslabs = bytes >> IO_TLB_SHIFT;
+	hyperv_io_tlb_size = bytes;
+
+	if (!vstart) {
+		pr_warn("Fail to allocate swiotlb.\n");
+		return -ENOMEM;
+	}
+
+	hyperv_io_tlb_start = virt_to_phys(vstart);
+	if (!hyperv_io_tlb_start)
+		panic("%s: Failed to allocate %lu bytes align=0x%lx.\n",
+		      __func__, PAGE_ALIGN(bytes), PAGE_SIZE);
+
+	if (swiotlb_init_with_tbl(vstart, hyperv_io_tlb_nslabs, 1))
+		panic("%s: Cannot allocate SWIOTLB buffer.\n", __func__);
+
+	swiotlb_set_max_segment(PAGE_SIZE);
+	hyperv_io_tlb_end = hyperv_io_tlb_start + bytes;
+	return 0;
+}
+
+const struct dma_map_ops hyperv_dma_ops = {
+	.map_page = hyperv_map_page,
+	.unmap_page = hyperv_unmap_page,
+};
+
+int __init hyperv_swiotlb_detect(void)
+{
+	dma_ops = &hyperv_dma_ops;
+
+	if (hypervisor_is_type(X86_HYPER_MS_HYPERV)
+	    && hv_is_isolation_supported()) {
+		/*
+		 * Disable generic swiotlb and allocate Hyper-v swiotlb
+		 * in the hyperv_iommu_swiotlb_init().
+		 */
+		swiotlb = 0;
+		hyperv_swiotlb = 1;
+
+		return 1;
+	}
+
+	return 0;
+}
+
+void __init hyperv_iommu_swiotlb_init(void)
+{
+	hyperv_swiotlb_init();
+}
+
+void __init hyperv_iommu_swiotlb_later_init(void)
+{
+	int ret;
+
+	/* Mask bounce buffer visible to host and remap extra address. */
+	if (hv_isolation_type_snp()) {
+		ret = hv_set_mem_host_visibility(
+				phys_to_virt(hyperv_io_tlb_start),
+				hyperv_io_tlb_size,
+				VMBUS_PAGE_VISIBLE_READ_WRITE);
+		if (ret)
+			panic("%s: Fail to mark Hyper-v swiotlb buffer visible to host. err=%d\n",
+			      __func__, ret);
+
+		hyperv_io_tlb_remap = ioremap_cache(hyperv_io_tlb_start
+					    + ms_hyperv.shared_gpa_boundary,
+						    hyperv_io_tlb_size);
+		if (!hyperv_io_tlb_remap)
+			panic("%s: Fail to remap io tlb.\n", __func__);
+
+		memset(hyperv_io_tlb_remap, 0x00, hyperv_io_tlb_size);
+		swiotlb_set_bounce_remap(hyperv_io_tlb_remap);
+	}
+}
+
+IOMMU_INIT_FINISH(hyperv_swiotlb_detect,
+		  NULL, hyperv_iommu_swiotlb_init,
+		  hyperv_iommu_swiotlb_later_init);
+
 #endif
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
