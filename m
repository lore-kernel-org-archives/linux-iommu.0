Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825971FBE
	for <iommu@lists.linux.dev>; Sun, 12 Nov 2023 04:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k3hMjg2b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699762331; x=1731298331;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DCQy9ziTOxUJmllg1ZKA+yDNfB6XKqM3GiK9nVcKCAU=;
  b=k3hMjg2b1PDS3EvJS9Wesfz0WXugFYJxQ3+JY8eBaeKYC277CpSKK3BT
   awk5QEld+Eu7A3J5cWeKk1K1fjXIEigVPn08uPSEyrQ+J7BY7f57JYcXx
   833qjTuN7ylMLUmR2LqvfrTTHRjn1ioyqwzjmA1NpF6+NvcWsVyedRuXQ
   TDXsFRM0WjEUjvgY/HWHusK79X/AC0z5hfNLbyJbOh4v56xR3gOPWlOP6
   WlTZsWVT1+HpxQnG3n06j+xBWUXLoeAGBy9VlOg4wkVodzmk2f7WQx0v7
   3NOc/XKl4tXnPYEEZENCevfZ6gSQsPl8JmhUca9HoY1hfeDoSt7lMOb0m
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="476533872"
X-IronPort-AV: E=Sophos;i="6.03,296,1694761200"; 
   d="scan'208";a="476533872"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2023 20:12:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="713936747"
X-IronPort-AV: E=Sophos;i="6.03,296,1694761200"; 
   d="scan'208";a="713936747"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.116])
  by orsmga003.jf.intel.com with ESMTP; 11 Nov 2023 20:12:08 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: LKML <linux-kernel@vger.kernel.org>,
	X86 Kernel <x86@kernel.org>,
	iommu@lists.linux.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	"Lu Baolu" <baolu.lu@linux.intel.com>,
	kvm@vger.kernel.org,
	Dave Hansen <dave.hansen@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Borislav Petkov" <bp@alien8.de>,
	"Ingo Molnar" <mingo@redhat.com>
Cc: Raj Ashok <ashok.raj@intel.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	maz@kernel.org,
	peterz@infradead.org,
	seanjc@google.com,
	"Robin Murphy" <robin.murphy@arm.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH RFC 04/13] iommu/vt-d: Add helper and flag to check/disable posted MSI
Date: Sat, 11 Nov 2023 20:16:34 -0800
Message-Id: <20231112041643.2868316-5-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231112041643.2868316-1-jacob.jun.pan@linux.intel.com>
References: <20231112041643.2868316-1-jacob.jun.pan@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow command line opt-out posted MSI under CONFIG_X86_POSTED_MSI=y.
And add a helper function for testing if posted MSI is supported on the
CPU side.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 arch/x86/include/asm/irq_remapping.h | 11 +++++++++++
 drivers/iommu/irq_remapping.c        | 17 +++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/arch/x86/include/asm/irq_remapping.h b/arch/x86/include/asm/irq_remapping.h
index 7a2ed154a5e1..706f58900962 100644
--- a/arch/x86/include/asm/irq_remapping.h
+++ b/arch/x86/include/asm/irq_remapping.h
@@ -50,6 +50,17 @@ static inline struct irq_domain *arch_get_ir_parent_domain(void)
 	return x86_vector_domain;
 }
 
+#ifdef CONFIG_X86_POSTED_MSI
+extern unsigned int posted_msi_off;
+
+static inline bool posted_msi_supported(void)
+{
+	return !posted_msi_off && irq_remapping_cap(IRQ_POSTING_CAP);
+}
+#else
+static inline bool posted_msi_supported(void) { return false; };
+#endif
+
 #else  /* CONFIG_IRQ_REMAP */
 
 static inline bool irq_remapping_cap(enum irq_remap_cap cap) { return 0; }
diff --git a/drivers/iommu/irq_remapping.c b/drivers/iommu/irq_remapping.c
index 83314b9d8f38..00de6963bb07 100644
--- a/drivers/iommu/irq_remapping.c
+++ b/drivers/iommu/irq_remapping.c
@@ -24,6 +24,23 @@ int no_x2apic_optout;
 
 int disable_irq_post = 0;
 
+#ifdef CONFIG_X86_POSTED_MSI
+
+unsigned int posted_msi_off;
+
+static int __init cmdl_posted_msi_off(char *str)
+{
+	int value = 0;
+
+	get_option(&str, &value);
+	posted_msi_off = value;
+
+	return 1;
+}
+
+__setup("posted_msi_off=", cmdl_posted_msi_off);
+#endif
+
 static int disable_irq_remap;
 static struct irq_remap_ops *remap_ops;
 
-- 
2.25.1

