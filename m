Return-Path: <SRS0=KSvG=YF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32759C47404
	for <iommu@archiver.kernel.org>; Sat, 12 Oct 2019 01:34:49 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11978206A1
	for <iommu@archiver.kernel.org>; Sat, 12 Oct 2019 01:34:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11978206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=us.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id E98DE1DDB;
	Sat, 12 Oct 2019 01:34:06 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C586F1DD3
	for <iommu@lists.linux-foundation.org>;
	Sat, 12 Oct 2019 01:26:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
	[148.163.158.5])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 2EB3D6CE
	for <iommu@lists.linux-foundation.org>;
	Sat, 12 Oct 2019 01:26:04 +0000 (UTC)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x9C1N1gf034013
	for <iommu@lists.linux-foundation.org>; Fri, 11 Oct 2019 21:26:01 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2vk1hnw8gv-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <iommu@lists.linux-foundation.org>; Fri, 11 Oct 2019 21:26:00 -0400
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <iommu@lists.linux-foundation.org> from <linuxram@us.ibm.com>;
	Sat, 12 Oct 2019 02:25:59 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
	by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Sat, 12 Oct 2019 02:25:53 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
	[9.149.105.232])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x9C1PqrE56623206
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Sat, 12 Oct 2019 01:25:52 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7E0E352052;
	Sat, 12 Oct 2019 01:25:52 +0000 (GMT)
Received: from oc0525413822.ibm.com (unknown [9.85.130.213])
	by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 0F9CF52051;
	Sat, 12 Oct 2019 01:25:47 +0000 (GMT)
From: Ram Pai <linuxram@us.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dma-mapping: Add dma_addr_is_phys_addr()
Date: Fri, 11 Oct 2019 18:25:18 -0700
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1570843519-8696-1-git-send-email-linuxram@us.ibm.com>
References: <1570843519-8696-1-git-send-email-linuxram@us.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19101201-0016-0000-0000-000002B7553B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19101201-0017-0000-0000-00003318696D
Message-Id: <1570843519-8696-2-git-send-email-linuxram@us.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-10-11_12:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1908290000 definitions=main-1910120005
Cc: andmike@us.ibm.com, sukadev@linux.vnet.ibm.com, b.zolnierkie@samsung.com,
	benh@kernel.crashing.org, jasowang@redhat.com, aik@linux.ibm.com,
	linuxram@us.ibm.com, mdroth@linux.vnet.ibm.com,
	virtualization@lists.linux-foundation.org, paulus@ozlabs.org,
	iommu@lists.linux-foundation.org, paul.burton@mips.com,
	mpe@ellerman.id.au, robin.murphy@arm.com,
	linuxppc-dev@lists.ozlabs.org, hch@lst.de, david@gibson.dropbear.id.au
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

From: Thiago Jung Bauermann <bauerman@linux.ibm.com>

In order to safely use the DMA API, virtio needs to know whether DMA
addresses are in fact physical addresses and for that purpose,
dma_addr_is_phys_addr() is introduced.

cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: David Gibson <david@gibson.dropbear.id.au>
cc: Michael Ellerman <mpe@ellerman.id.au>
cc: Paul Mackerras <paulus@ozlabs.org>
cc: Michael Roth <mdroth@linux.vnet.ibm.com>
cc: Alexey Kardashevskiy <aik@linux.ibm.com>
cc: Paul Burton <paul.burton@mips.com>
cc: Robin Murphy <robin.murphy@arm.com>
cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
cc: Marek Szyprowski <m.szyprowski@samsung.com>
cc: Christoph Hellwig <hch@lst.de>
Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 arch/powerpc/include/asm/dma-mapping.h | 21 +++++++++++++++++++++
 arch/powerpc/platforms/pseries/Kconfig |  1 +
 include/linux/dma-mapping.h            | 20 ++++++++++++++++++++
 kernel/dma/Kconfig                     |  3 +++
 4 files changed, 45 insertions(+)

diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
index 565d6f7..f92c0a4b 100644
--- a/arch/powerpc/include/asm/dma-mapping.h
+++ b/arch/powerpc/include/asm/dma-mapping.h
@@ -5,6 +5,8 @@
 #ifndef _ASM_DMA_MAPPING_H
 #define _ASM_DMA_MAPPING_H
 
+#include <asm/svm.h>
+
 static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
 	/* We don't handle the NULL dev case for ISA for now. We could
@@ -15,4 +17,23 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 	return NULL;
 }
 
+#ifdef CONFIG_ARCH_HAS_DMA_ADDR_IS_PHYS_ADDR
+/**
+ * dma_addr_is_phys_addr - check whether a device DMA address is a physical
+ *		address
+ * @dev:	device to check
+ *
+ * Returns %true if any DMA address for this device happens to also be a valid
+ * physical address (not necessarily of the same page).
+ */
+static inline bool dma_addr_is_phys_addr(struct device *dev)
+{
+	/*
+	 * Secure guests always use the SWIOTLB, therefore DMA addresses are
+	 * actually the physical address of the bounce buffer.
+	 */
+	return is_secure_guest();
+}
+#endif
+
 #endif	/* _ASM_DMA_MAPPING_H */
diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
index 9e35cdd..0108150 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -152,6 +152,7 @@ config PPC_SVM
 	select SWIOTLB
 	select ARCH_HAS_MEM_ENCRYPT
 	select ARCH_HAS_FORCE_DMA_UNENCRYPTED
+	select ARCH_HAS_DMA_ADDR_IS_PHYS_ADDR
 	help
 	 There are certain POWER platforms which support secure guests using
 	 the Protected Execution Facility, with the help of an Ultravisor
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index f7d1eea..6df5664 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -693,6 +693,26 @@ static inline bool dma_addressing_limited(struct device *dev)
 			    dma_get_required_mask(dev);
 }
 
+#ifndef CONFIG_ARCH_HAS_DMA_ADDR_IS_PHYS_ADDR
+/**
+ * dma_addr_is_phys_addr - check whether a device DMA address is a physical
+ *		address
+ * @dev:	device to check
+ *
+ * Returns %true if any DMA address for this device happens to also be a valid
+ * physical address (not necessarily of the same page).
+ */
+static inline bool dma_addr_is_phys_addr(struct device *dev)
+{
+	/*
+	 * Except in very specific setups, DMA addresses exist in a different
+	 * address space from CPU physical addresses and cannot be directly used
+	 * to reference system memory.
+	 */
+	return false;
+}
+#endif
+
 #ifdef CONFIG_ARCH_HAS_SETUP_DMA_OPS
 void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 		const struct iommu_ops *iommu, bool coherent);
diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index 9decbba..6209b46 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -51,6 +51,9 @@ config ARCH_HAS_DMA_MMAP_PGPROT
 config ARCH_HAS_FORCE_DMA_UNENCRYPTED
 	bool
 
+config ARCH_HAS_DMA_ADDR_IS_PHYS_ADDR
+	bool
+
 config DMA_NONCOHERENT_CACHE_SYNC
 	bool
 
-- 
1.8.3.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
