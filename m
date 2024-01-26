Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2635B20C
	for <iommu@lists.linux.dev>; Fri, 26 Jan 2024 23:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706312247; cv=none; b=U64inpSf/l1OoA0buk6wfi4+evwA94VF49zuMcSi5LucSedt1363hiPjcnStW960XEoDFz7aDBwiiHBdHj08WUjkUvVwu0cx/XVHB0pGbsNhhlrgHf2LjM22FgcQWXUwzgh1fr/CDurtr5ZS4g+XlKa+Hg+y7UMEXzlm0CpRgL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706312247; c=relaxed/simple;
	bh=MqzYCPV34vdfoVMKAgtS0juqP6fLnnDqzn4F90K69Xk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IwGnumhqUV8qyXaKCrojVb9AsHYEMtaUW/8x1E+UGN13LosEbtGP2RRekFMV2gp0/XebvthZpgKaUsGFCBw7XhMvsPKf48ap6FVxAPWO7zT+QkXtlycC4jjqoismxGZO+RJvysIXotOhaIBAG6+DTghx0zld1bAjWL4e0iweoVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=St21S41b; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="St21S41b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706312246; x=1737848246;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MqzYCPV34vdfoVMKAgtS0juqP6fLnnDqzn4F90K69Xk=;
  b=St21S41btEPMxtTBxralZWC6YIhDPetPhBMp7zDBzbhuOpUMr8X1zsnI
   TVRW20+1IEPPbmprKElYCD6atqMEyWOR3VNXXnO/gGlI35+Wa8UlDR6zl
   QMG6xMJUslUr0/QFzBfjkvodJ5CjncH2OJb78uhVyFALbyUKbER1Dgyw7
   FRfSLbsuGidgt9w5skQr1sYYzhwgZAoErKYx/wfn7qtc0HgSyXL9Lzy3N
   YXmMq0/7KfhcILLK1F7/y8BE53oQPBpxuvBf0ydQb3lK4F5FWog35WosJ
   /De1gyBCNfSxusHcoxxSlGWYNhTJzmBSMzDs4tzO/EfPoRYlvdxsH2cFW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="9990705"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="9990705"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 15:37:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="821290731"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="821290731"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.116])
  by orsmga001.jf.intel.com with ESMTP; 26 Jan 2024 15:37:21 -0800
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
Subject: [PATCH 07/15] x86/irq: Add accessors for posted interrupt descriptors
Date: Fri, 26 Jan 2024 15:42:29 -0800
Message-Id: <20240126234237.547278-8-jacob.jun.pan@linux.intel.com>
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

Posted interrupts are controlled by and pending interrupts are marked in
the posted interrupt descriptor. The upcoming support for host side posted
interrupts requires accessors to check for pending vectors.

This patch adds a helper function to check individual vector status.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 arch/x86/include/asm/posted_intr.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/x86/include/asm/posted_intr.h b/arch/x86/include/asm/posted_intr.h
index a36cc971ea13..eb939f630b02 100644
--- a/arch/x86/include/asm/posted_intr.h
+++ b/arch/x86/include/asm/posted_intr.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _X86_POSTED_INTR_H
 #define _X86_POSTED_INTR_H
+#include <asm/irq_vectors.h>
 
 #define POSTED_INTR_ON  0
 #define POSTED_INTR_SN  1
@@ -89,9 +90,26 @@ static inline bool pi_test_sn(struct pi_desc *pi_desc)
 }
 
 #ifdef CONFIG_X86_POSTED_MSI
+/*
+ * Not all external vectors are subject to interrupt remapping, e.g. IOMMU's
+ * own interrupts. Here we do not distinguish them since those vector bits in
+ * PIR will always be zero.
+ */
+static inline bool pi_pending_this_cpu(unsigned int vector)
+{
+	struct pi_desc *pid = this_cpu_ptr(&posted_interrupt_desc);
+
+	if (WARN_ON_ONCE(vector > NR_VECTORS || vector < FIRST_EXTERNAL_VECTOR))
+		return false;
+
+	return test_bit(vector, (unsigned long *)pid->pir);
+}
+
 extern void intel_posted_msi_init(void);
 
 #else
+static inline bool pi_pending_this_cpu(unsigned int vector) { return false; }
+
 static inline void intel_posted_msi_init(void) {};
 
 #endif /* X86_POSTED_MSI */
-- 
2.25.1

