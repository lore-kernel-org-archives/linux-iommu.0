Return-Path: <SRS0=Ybkk=5L=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E899C2D0EC
	for <iommu@archiver.kernel.org>; Thu, 26 Mar 2020 16:51:57 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31DC020719
	for <iommu@archiver.kernel.org>; Thu, 26 Mar 2020 16:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="M8vUVFQq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31DC020719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DBE1A8720A;
	Thu, 26 Mar 2020 16:51:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Svzykd72dsFz; Thu, 26 Mar 2020 16:51:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 242978712F;
	Thu, 26 Mar 2020 16:51:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0AC87C1D7C;
	Thu, 26 Mar 2020 16:51:56 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A9DB5C0177
 for <iommu@lists.linux-foundation.org>; Thu, 26 Mar 2020 16:29:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A45C386A7C
 for <iommu@lists.linux-foundation.org>; Thu, 26 Mar 2020 16:29:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z6sygisjICEC for <iommu@lists.linux-foundation.org>;
 Thu, 26 Mar 2020 16:29:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 2DD1A86AB6
 for <iommu@lists.linux-foundation.org>; Thu, 26 Mar 2020 16:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1585240192; x=1616776192;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=r+xjheFg90V4UFzgZ0rM14eOyfYQV2OU8fVkinKNWrk=;
 b=M8vUVFQqDFAZ7/j2O7E3JzkC987Kja1QPz4jXZUPPnCNysJJuzrRU6UY
 Bigj6asV3BSiQZC6z/EmVHg1+YK+RuVxjh2DAWfH0Kr1nB1gxonJR/p6E
 sEEW5bxb+vWgoE08IxgH4uvctH+5Qji0y5pnXkKkkEkXj864n2e0YtXDt Q=;
IronPort-SDR: Vqc8XNR/nV6kC9BOFdWbPaGMpkEdd1pl+T+7DbBuXMBpUvH2T424C97nNzoPhE2D6VOBjXzaU3
 iyqtUxndPETw==
X-IronPort-AV: E=Sophos;i="5.72,309,1580774400"; d="scan'208";a="22863346"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO
 email-inbound-relay-1a-821c648d.us-east-1.amazon.com) ([10.43.8.6])
 by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP;
 26 Mar 2020 16:29:37 +0000
Received: from EX13MTAUWC001.ant.amazon.com
 (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
 by email-inbound-relay-1a-821c648d.us-east-1.amazon.com (Postfix) with ESMTPS
 id 7C0CEA2A22; Thu, 26 Mar 2020 16:29:34 +0000 (UTC)
Received: from EX13D20UWC001.ant.amazon.com (10.43.162.244) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 26 Mar 2020 16:29:33 +0000
Received: from u79c5a0a55de558.ant.amazon.com (10.43.162.173) by
 EX13D20UWC001.ant.amazon.com (10.43.162.244) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 26 Mar 2020 16:29:29 +0000
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH] swiotlb: Allow swiotlb to live at pre-defined address
Date: Thu, 26 Mar 2020 17:29:22 +0100
Message-ID: <20200326162922.27085-1-graf@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.43.162.173]
X-ClientProxiedBy: EX13D03UWC003.ant.amazon.com (10.43.162.79) To
 EX13D20UWC001.ant.amazon.com (10.43.162.244)
X-Mailman-Approved-At: Thu, 26 Mar 2020 16:51:54 +0000
Cc: Mark Rutland <mark.rutland@arm.com>, benh@amazon.com,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-doc@vger.kernel.org,
 Jan Kiszka <jan.kiszka@siemens.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, aggh@amazon.com, alcioa@amazon.com,
 aagch@amazon.com, dhr@amazon.com, dwmw@amazon.com,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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
From: Alexander Graf via iommu <iommu@lists.linux-foundation.org>
Reply-To: Alexander Graf <graf@amazon.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

The swiotlb is a very convenient fallback mechanism for bounce buffering of
DMAable data. It is usually used for the compatibility case where devices
can only DMA to a "low region".

However, in some scenarios this "low region" may be bound even more
heavily. For example, there are embedded system where only an SRAM region
is shared between device and CPU. There are also heterogeneous computing
scenarios where only a subset of RAM is cache coherent between the
components of the system. There are partitioning hypervisors, where
a "control VM" that implements device emulation has limited view into a
partition's memory for DMA capabilities due to safety concerns.

This patch adds a command line driven mechanism to move all DMA memory into
a predefined shared memory region which may or may not be part of the
physical address layout of the Operating System.

Ideally, the typical path to set this configuration would be through Device
Tree or ACPI, but neither of the two mechanisms is standardized yet. Also,
in the x86 MicroVM use case, we have neither ACPI nor Device Tree, but
instead configure the system purely through kernel command line options.

I'm sure other people will find the functionality useful going forward
though and extend it to be triggered by DT/ACPI in the future.

Signed-off-by: Alexander Graf <graf@amazon.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  3 +-
 Documentation/x86/x86_64/boot-options.rst       |  4 ++-
 kernel/dma/swiotlb.c                            | 46 +++++++++++++++++++++++--
 3 files changed, 49 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index c07815d230bc..d085d55c3cbe 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4785,11 +4785,12 @@
 			it if 0 is given (See Documentation/admin-guide/cgroup-v1/memory.rst)
 
 	swiotlb=	[ARM,IA-64,PPC,MIPS,X86]
-			Format: { <int> | force | noforce }
+			Format: { <int> | force | noforce | addr=<phys addr> }
 			<int> -- Number of I/O TLB slabs
 			force -- force using of bounce buffers even if they
 			         wouldn't be automatically used by the kernel
 			noforce -- Never use bounce buffers (for debugging)
+			addr=<phys addr> -- Try to allocate SWIOTLB at defined address
 
 	switches=	[HW,M68k]
 
diff --git a/Documentation/x86/x86_64/boot-options.rst b/Documentation/x86/x86_64/boot-options.rst
index 2b98efb5ba7f..ca46c57b68c9 100644
--- a/Documentation/x86/x86_64/boot-options.rst
+++ b/Documentation/x86/x86_64/boot-options.rst
@@ -297,11 +297,13 @@ iommu options only relevant to the AMD GART hardware IOMMU:
 iommu options only relevant to the software bounce buffering (SWIOTLB) IOMMU
 implementation:
 
-    swiotlb=<pages>[,force]
+    swiotlb=<pages>[,force][,addr=<phys addr>]
       <pages>
         Prereserve that many 128K pages for the software IO bounce buffering.
       force
         Force all IO through the software TLB.
+      addr=<phys addr>
+        Try to allocate SWIOTLB at defined address
 
 Settings for the IBM Calgary hardware IOMMU currently found in IBM
 pSeries and xSeries machines
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index c19379fabd20..83da0caa2f93 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -46,6 +46,7 @@
 #include <linux/init.h>
 #include <linux/memblock.h>
 #include <linux/iommu-helper.h>
+#include <linux/io.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/swiotlb.h>
@@ -102,6 +103,12 @@ unsigned int max_segment;
 #define INVALID_PHYS_ADDR (~(phys_addr_t)0)
 static phys_addr_t *io_tlb_orig_addr;
 
+/*
+ * The TLB phys addr may be defined on the command line. Store it here if it is.
+ */
+static phys_addr_t io_tlb_addr = INVALID_PHYS_ADDR;
+
+
 /*
  * Protect the above data structures in the map and unmap calls
  */
@@ -119,11 +126,23 @@ setup_io_tlb_npages(char *str)
 	}
 	if (*str == ',')
 		++str;
-	if (!strcmp(str, "force")) {
+	if (!strncmp(str, "force", 5)) {
 		swiotlb_force = SWIOTLB_FORCE;
-	} else if (!strcmp(str, "noforce")) {
+		str += 5;
+	} else if (!strncmp(str, "noforce", 7)) {
 		swiotlb_force = SWIOTLB_NO_FORCE;
 		io_tlb_nslabs = 1;
+		str += 7;
+	}
+
+	if (*str == ',')
+		++str;
+	if (!strncmp(str, "addr=", 5)) {
+		char *addrstr = str + 5;
+
+		io_tlb_addr = kstrtoul(addrstr, 0, &str);
+		if (addrstr == str)
+			io_tlb_addr = INVALID_PHYS_ADDR;
 	}
 
 	return 0;
@@ -239,6 +258,25 @@ int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
 	return 0;
 }
 
+static int __init swiotlb_init_io(int verbose, unsigned long bytes)
+{
+	unsigned __iomem char *vstart;
+
+	if (io_tlb_addr == INVALID_PHYS_ADDR)
+		return -EINVAL;
+
+	vstart = memremap(io_tlb_addr, bytes, MEMREMAP_WB);
+	if (!vstart)
+		return -EINVAL;
+
+	if (swiotlb_init_with_tbl(vstart, io_tlb_nslabs, verbose)) {
+		memunmap(vstart);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 /*
  * Statically reserve bounce buffer space and initialize bounce buffer data
  * structures for the software IO TLB used to implement the DMA API.
@@ -257,6 +295,10 @@ swiotlb_init(int verbose)
 
 	bytes = io_tlb_nslabs << IO_TLB_SHIFT;
 
+	/* Map IO TLB from device memory */
+	if (!swiotlb_init_io(verbose, bytes))
+		return;
+
 	/* Get IO TLB memory from the low pages */
 	vstart = memblock_alloc_low(PAGE_ALIGN(bytes), PAGE_SIZE);
 	if (vstart && !swiotlb_init_with_tbl(vstart, io_tlb_nslabs, verbose))
-- 
2.16.4




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
