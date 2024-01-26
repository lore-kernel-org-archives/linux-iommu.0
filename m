Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723BE60242
	for <iommu@lists.linux.dev>; Fri, 26 Jan 2024 23:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706312251; cv=none; b=V/bWaVm8TuVvJ1G2iujW9VUAfXJL3OEzylRarzlp9T9mdXCKwSZ/nOzbK9wE9cNJ1c/k5JVaBygUd3xTSHRDHz7HhN6CYN03qFe/uc5scjkHxyN6jQ3bI2V9saup97tTOVN/CCGZAG0BP9Nh3fAEWSJ+5HcOXTe6W4uozCPxho8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706312251; c=relaxed/simple;
	bh=+q6Ng6aZ31M15sxzv7j/zcb8dlMqz5ufayt8TldTJ+8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WLaACy7xyc+/1b1++MOdzJozGpRbtJmXbTHOe+4AE+GDJwEE2rXZBg4uu7+jgQTFArDMUA6q9fQrrXMn5+Ve8f2Y8D8BTzRObs9/00vj3kIE4wCb+SRwskOofUYj+GrtoaL+F25oPcOYlX89/K+CTG7q7QkBSc0iQZWXTsWCB8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M4s1VDIq; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M4s1VDIq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706312249; x=1737848249;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+q6Ng6aZ31M15sxzv7j/zcb8dlMqz5ufayt8TldTJ+8=;
  b=M4s1VDIqwqP6kUSdbWa7Qoz84J/+HXFUW8516Uiu5TakjCG7qey8dgT9
   H5AdGmF9tw7M9fMxZH3CNZgkRWFFtkRaXu0/3qaXuW4vR+UJ/vHphsfim
   CyMCzoR7Z6cW28Gc9+yflNJwIOB460aSgDKaLrhCDMUd3+i1prK5qN2Bb
   lu8Coo6ITBW0w+z9ALHUFL23QAtlHHu+/bpQMD510aES3V7wXBfkUrTZq
   zuxK5EMPCf/HjAiMXIrh6ibDLV/XvIL2la1nXFgOK8UD/sfO0daWe1Rcz
   kWkDhiQ+bOPL3XOhMOAkAeD7WjtFa0D+SPeAVDp52Stmp30LkMNHGdXWh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="9990769"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="9990769"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 15:37:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="821290748"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="821290748"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.116])
  by orsmga001.jf.intel.com with ESMTP; 26 Jan 2024 15:37:22 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: LKML <linux-kernel@vger.kernel.org>,
	X86 Kernel <x86@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	iommu@lists.linux.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	"Lu Baolu" <baolu.lu@linux.intel.com>,
	kvm@vger.kernel.org,
	Dave Hansen <dave.hansen@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Borislav Petkov" <bp@alien8.de>,
	"Ingo Molnar" <mingo@redhat.com>
Cc: Paul Luse <paul.e.luse@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jens Axboe <axboe@kernel.dk>,
	Raj Ashok <ashok.raj@intel.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	maz@kernel.org,
	seanjc@google.com,
	"Robin Murphy" <robin.murphy@arm.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 12/15] iommu/vt-d: Make posted MSI an opt-in cmdline option
Date: Fri, 26 Jan 2024 15:42:34 -0800
Message-Id: <20240126234237.547278-13-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240126234237.547278-1-jacob.jun.pan@linux.intel.com>
References: <20240126234237.547278-1-jacob.jun.pan@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a command line opt-in option for posted MSI if CONFIG_X86_POSTED_MSI=y.

Also introduce a helper function for testing if posted MSI is supported on
the platform.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  1 +
 arch/x86/include/asm/irq_remapping.h            | 11 +++++++++++
 drivers/iommu/irq_remapping.c                   | 13 ++++++++++++-
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 31b3a25680d0..35feefc0bdb0 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2212,6 +2212,7 @@
 			no_x2apic_optout
 				BIOS x2APIC opt-out request will be ignored
 			nopost	disable Interrupt Posting
+			posted_msi enable MSIs delivered as posted interrupts
 
 	iomem=		Disable strict checking of access to MMIO memory
 		strict	regions from userspace.
diff --git a/arch/x86/include/asm/irq_remapping.h b/arch/x86/include/asm/irq_remapping.h
index 7a2ed154a5e1..e46bde61029b 100644
--- a/arch/x86/include/asm/irq_remapping.h
+++ b/arch/x86/include/asm/irq_remapping.h
@@ -50,6 +50,17 @@ static inline struct irq_domain *arch_get_ir_parent_domain(void)
 	return x86_vector_domain;
 }
 
+#ifdef CONFIG_X86_POSTED_MSI
+extern int enable_posted_msi;
+
+static inline bool posted_msi_supported(void)
+{
+	return enable_posted_msi && irq_remapping_cap(IRQ_POSTING_CAP);
+}
+#else
+static inline bool posted_msi_supported(void) { return false; };
+#endif
+
 #else  /* CONFIG_IRQ_REMAP */
 
 static inline bool irq_remapping_cap(enum irq_remap_cap cap) { return 0; }
diff --git a/drivers/iommu/irq_remapping.c b/drivers/iommu/irq_remapping.c
index 83314b9d8f38..4047ac396728 100644
--- a/drivers/iommu/irq_remapping.c
+++ b/drivers/iommu/irq_remapping.c
@@ -24,6 +24,10 @@ int no_x2apic_optout;
 
 int disable_irq_post = 0;
 
+#ifdef CONFIG_X86_POSTED_MSI
+int enable_posted_msi;
+#endif
+
 static int disable_irq_remap;
 static struct irq_remap_ops *remap_ops;
 
@@ -70,7 +74,14 @@ static __init int setup_irqremap(char *str)
 			no_x2apic_optout = 1;
 		else if (!strncmp(str, "nopost", 6))
 			disable_irq_post = 1;
-
+#ifdef CONFIG_X86_POSTED_MSI
+		else if (!strncmp(str, "posted_msi", 10)) {
+			if (disable_irq_post || disable_irq_remap)
+				pr_warn("Posted MSI not enabled due to conflicting options!");
+			else
+				enable_posted_msi = 1;
+		}
+#endif
 		str += strcspn(str, ",");
 		while (*str == ',')
 			str++;
-- 
2.25.1

