Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF46A2100
	for <iommu@lists.linux.dev>; Sun, 12 Nov 2023 04:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j1L6ZhVz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699762337; x=1731298337;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nMrBMNqKNmE7TkVKdlJ7grKzLWcWZpw3D0RMZ2QEFQQ=;
  b=j1L6ZhVzDwPR++axvWsZq6In5n4HIguwPHnvL+zyER4wO2L3ykLEOvC+
   Ilq9Ad7GgnnF/1D2E2KvLDzcpzqvSr12urM4YXBmitMQmrSfiPNyXMr4R
   6gIvOstKCwHxp/SuD8euEpM/Yi4KlM61DnzXiSCCwrFYHwE5yiXN/IdkV
   OIZbYRhyKOFlSMF6YsBOyPhtPuD1vjUcK0SChIeM8nGQ9h+nLLA0LKKVE
   iokjrI0deWdSRC/R7qvjjR+rXQ0kQOuSIB7MdCU6I3SkOrgr9qsWGg9+s
   d8QeIJSQ2IFVGRlHmxpb/T/u+kfSv4faWhXQ6Ek66OShub4P6eicu5Vf3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="476533905"
X-IronPort-AV: E=Sophos;i="6.03,296,1694761200"; 
   d="scan'208";a="476533905"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2023 20:12:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="713936757"
X-IronPort-AV: E=Sophos;i="6.03,296,1694761200"; 
   d="scan'208";a="713936757"
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
Subject: [PATCH RFC 07/13] x86/irq: Add helpers for checking Intel PID
Date: Sat, 11 Nov 2023 20:16:37 -0800
Message-Id: <20231112041643.2868316-8-jacob.jun.pan@linux.intel.com>
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

Intel posted interrupt descriptor (PID) stores pending interrupts in its
posted interrupt requests (PIR) bitmap.

Add helper functions to check individual vector status and the entire bitmap.

They are used for interrupt migration and runtime demultiplexing posted MSI
vectors.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 arch/x86/include/asm/posted_intr.h | 31 ++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/x86/include/asm/posted_intr.h b/arch/x86/include/asm/posted_intr.h
index 3af00f5395e4..12a4fa3ff60e 100644
--- a/arch/x86/include/asm/posted_intr.h
+++ b/arch/x86/include/asm/posted_intr.h
@@ -98,9 +98,40 @@ static inline bool pi_test_sn(struct pi_desc *pi_desc)
 }
 
 #ifdef CONFIG_X86_POSTED_MSI
+/*
+ * Not all external vectors are subject to interrupt remapping, e.g. IOMMU's
+ * own interrupts. Here we do not distinguish them since those vector bits in
+ * PIR will always be zero.
+ */
+static inline bool is_pi_pending_this_cpu(unsigned int vector)
+{
+	struct pi_desc *pid;
+
+	if (WARN_ON(vector > NR_VECTORS || vector < FIRST_EXTERNAL_VECTOR))
+		return false;
+
+	pid = this_cpu_ptr(&posted_interrupt_desc);
+
+	return (pid->pir[vector >> 5] & (1 << (vector % 32)));
+}
+
+static inline bool is_pir_pending(struct pi_desc *pid)
+{
+	int i;
+
+	for (i = 0; i < 4; i++) {
+		if (pid->pir_l[i])
+			return true;
+	}
+
+	return false;
+}
+
 extern void intel_posted_msi_init(void);
 
 #else
+static inline bool is_pi_pending_this_cpu(unsigned int vector) {return false; }
+
 static inline void intel_posted_msi_init(void) {};
 
 #endif /* X86_POSTED_MSI */
-- 
2.25.1

