Received: from pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com [50.112.246.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586C332B126
	for <iommu@lists.linux.dev>; Tue,  9 Jun 2026 14:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.112.246.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781015902; cv=none; b=im2syLTjC6AIgRyzRrwp4zFvW5lFAISs+jAowvcicXiw3qV1XCApIo0jEOUE5qmrUzbXhKnLRbzbCJpAoJSDFDgKToxdfgApKq+NC1KcaAb2Aj4j4r5cicPnKfCbfBQKq9bmHPolhmYakGbs8cuJA71plDEEO/rT6NEB113QwZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781015902; c=relaxed/simple;
	bh=fGZdfV443xZ0rmCD2u6DNSY8eqZeMqIX1mRQdL5h6A8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rZ9eC/w8kO5quTY2KFUXIvpWMHxAHdOp3YztmocJ1BAtMHxDyv+vP2oH/2TJggpnGJMSUKJfsHwM2UWzU4cueCpdV/ifjRbuXaYpGWxmtK7T7DXzIHDZgseVYW9Zdq+Xbx2De2UcXscYipMv4qht1+uYNrIxMY63J/1O6AIg4VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=g8f4e0ps; arc=none smtp.client-ip=50.112.246.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="g8f4e0ps"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1781015901; x=1812551901;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BBjZPbNaSisUm/wByxwrCqk7wBHMbCoX8PBhpFvmoUc=;
  b=g8f4e0ps49r+1uDSDgMqhaYKMlkumMVw7gVvSteXUkZxNHeJEaB4ognW
   lfXApoD8TKn8kQyMVABLD9+QNA3cxXaFWAW4PEmx43K2n/UC8x/m4fwCs
   Mkqbj2Jt9GlcwH/XK2oovnGBIcR3tHLP0yJqxeeyX2cAR1ydL6Ld/6DSc
   1cG3JCE6CVoatbvwVGivs7Xd9RYuMZi8Y/maWnOK4QnX4QTWhvap6Y3vy
   hDyw2v58Vdpm/t+mmwg7yRzuVTvraO8PDiHiVXkrELX/VAszF1CuCljXx
   zrz1VWoS8opQ+mpuHAD4mhwu+M/uwpoFufngxSbFWGy/PUj07DoYHeKeS
   A==;
X-CSE-ConnectionGUID: 62R0+7UoTDq4QqXJIz5Gfg==
X-CSE-MsgGUID: D1VSAX60QnaAS5P1eK3Jcg==
X-IronPort-AV: E=Sophos;i="6.24,196,1774310400"; 
   d="scan'208";a="21211664"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 14:38:18 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:20973]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.226:2525] with esmtp (Farcaster)
 id 008b3bdd-8535-4bf3-9185-dc16399fa4ea; Tue, 9 Jun 2026 14:38:18 +0000 (UTC)
X-Farcaster-Flow-ID: 008b3bdd-8535-4bf3-9185-dc16399fa4ea
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 9 Jun 2026 14:38:18 +0000
Received: from dev-dsk-araoof-1b-23e02486.eu-west-1.amazon.com (10.253.65.187)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 9 Jun 2026 14:38:16 +0000
From: Ahmed Abdelraoof <araoof@amazon.de>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu
	<baolu.lu@linux.intel.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Ahmed
 Abdelraoof" <araoof@amazon.com>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] iommu/vt-d: Make DMA-fault page-table dump user-selectable
Date: Tue, 9 Jun 2026 14:37:59 +0000
Message-ID: <20260609143806.69403-1-araoof@amazon.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D042UWA003.ant.amazon.com (10.13.139.44) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Ahmed Abdelraoof <araoof@amazon.com>

The page-table dump was gated behind the hidden CONFIG_DMAR_DEBUG
symbol, only reachable by enabling the full INTEL_IOMMU_DEBUGFS
interface. That interface is explicitly flagged as not for production
and exposes far more IOMMU internals than a fault dump needs, so there
was no way to get this diagnostic from menuconfig on production kernel
without taking on the rest.

This patch renames it to CONFIG_DMAR_FAULT_DEBUG with a prompt and help
text so the fault dump can be enabled on its own, and updates all
references in iommu.c and dmar.h. INTEL_IOMMU_DEBUGFS still selects it,
so existing configs are unaffected; no functional change otherwise.

Signed-off-by: Ahmed Abdelraoof <araoof@amazon.com>
---
 drivers/iommu/intel/Kconfig | 11 ++++++++---
 drivers/iommu/intel/iommu.c |  2 +-
 include/linux/dmar.h        |  2 +-
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
index 5471f814e073..59a05cefa728 100644
--- a/drivers/iommu/intel/Kconfig
+++ b/drivers/iommu/intel/Kconfig
@@ -6,8 +6,13 @@ config DMAR_TABLE
 config DMAR_PERF
 	bool
 
-config DMAR_DEBUG
-	bool
+config DMAR_FAULT_DEBUG
+	bool "Dump Intel IOMMU page tables on DMA fault"
+	depends on INTEL_IOMMU
+	help
+	  On a DMA Remapping (DMAR) fault, walk the Root / Context /
+	  PASID / second-level page-table entries for the faulting
+	  source-id and IOVA and emit them via pr_info.
 
 config INTEL_IOMMU
 	bool "Support for Intel IOMMU using DMA Remapping Devices"
@@ -39,7 +44,7 @@ config INTEL_IOMMU_DEBUGFS
 	bool "Export Intel IOMMU internals in Debugfs"
 	depends on IOMMU_DEBUGFS
 	select DMAR_PERF
-	select DMAR_DEBUG
+	select DMAR_FAULT_DEBUG
 	help
 	  !!!WARNING!!!
 
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 4d0e65bc131d..7c28ef700dda 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -549,7 +549,7 @@ static void free_context_table(struct intel_iommu *iommu)
 	iommu->root_entry = NULL;
 }
 
-#ifdef CONFIG_DMAR_DEBUG
+#ifdef CONFIG_DMAR_FAULT_DEBUG
 static void pgtable_walk(struct intel_iommu *iommu, unsigned long pfn,
 			 u8 bus, u8 devfn, struct dma_pte *parent, int level)
 {
diff --git a/include/linux/dmar.h b/include/linux/dmar.h
index 692b2b445761..199cf01284fe 100644
--- a/include/linux/dmar.h
+++ b/include/linux/dmar.h
@@ -126,7 +126,7 @@ static inline int dmar_res_noop(struct acpi_dmar_header *hdr, void *arg)
 	return 0;
 }
 
-#ifdef CONFIG_DMAR_DEBUG
+#ifdef CONFIG_DMAR_FAULT_DEBUG
 void dmar_fault_dump_ptes(struct intel_iommu *iommu, u16 source_id,
 			  unsigned long long addr, u32 pasid);
 #else
-- 
2.47.3




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597

