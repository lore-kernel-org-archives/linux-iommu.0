Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F9E5BAC0
	for <iommu@lists.linux.dev>; Fri, 26 Jan 2024 23:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706312248; cv=none; b=bFguG/rcomEZq4sG2oSitEr20vQXD3dwYIZLULLyRgZPPqiSJJhKi+AZmMaU3K1u45zwMfH5ZJ9izDQ9oMNhU72XXYZ0wPX2NEUKtf1/VN5ABIxm8iPj4JRf/d4t2YxaSe/9dfMzZakHNkRs3KxuXZznwCG/1mdM8Xo8YkzHbg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706312248; c=relaxed/simple;
	bh=KVXuQfj6u+U1cGUQ3TC+vIVsCaW1LZRHuP8dLBZSJDg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OJrwMewnQzfBe6FzCp+2W0tRIq1FNRGAkIryDXmFMatcIb9YXQWiiFXBUPO7sfJmsRITyIp4pDx1h852KzR29FOaagAhMvV+JaRgnUFM7x3jcBl33em3Gih8yVKC15Y5zWTQ2XXdIFT61vmFyVRetGw3E+4N/gcDv3lkMvwsG2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C29OPemK; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C29OPemK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706312247; x=1737848247;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KVXuQfj6u+U1cGUQ3TC+vIVsCaW1LZRHuP8dLBZSJDg=;
  b=C29OPemK69sUEqZ5YqG1SPKtJ6oq7BI/i4/iEI8MpbixrHi0PBZl/esW
   6UBK+DpCQvaKTa5uCt6vSYK/TouECldQ0Wi5Ht27mKi6XRXiQ4G+Na0+b
   zXFob5a0XUnTEhaJ8wY+gbtb0E/i2URzSxRXWBbZqRMAwnfzzWo55Kmpq
   L0iynktu+yxOn63kNiwinuz1d3Qx8cjDoHRfPRBjpr9AdyCSHrB/DfGBP
   jBu7uO+n9Q8ruMG8QrsxDst40ke5uJX9hQ173RaW2GJMT6BfoCSUlN3wl
   T0KpNmV+2Ufaa2xQyqM+ww0CuuRZEUkf6LHIUUgjTI9Q/gL+tcB4SlN/X
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="9990722"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="9990722"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 15:37:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="821290734"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="821290734"
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
Subject: [PATCH 08/15] x86/irq: Factor out calling ISR from common_interrupt
Date: Fri, 26 Jan 2024 15:42:30 -0800
Message-Id: <20240126234237.547278-9-jacob.jun.pan@linux.intel.com>
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

Prepare for calling external IRQ handlers directly from the posted MSI
demultiplexing loop. Extract the common code with common interrupt to
avoid code duplication.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 arch/x86/kernel/irq.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index f6546f83d616..1a1762baf85f 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -242,18 +242,10 @@ static __always_inline void handle_irq(struct irq_desc *desc,
 		__handle_irq(desc, regs);
 }
 
-/*
- * common_interrupt() handles all normal device IRQ's (the special SMP
- * cross-CPU interrupts have their own entry points).
- */
-DEFINE_IDTENTRY_IRQ(common_interrupt)
+static __always_inline void call_irq_handler(int vector, struct pt_regs *regs)
 {
-	struct pt_regs *old_regs = set_irq_regs(regs);
 	struct irq_desc *desc;
 
-	/* entry code tells RCU that we're not quiescent.  Check it. */
-	RCU_LOCKDEP_WARN(!rcu_is_watching(), "IRQ failed to wake up RCU");
-
 	desc = __this_cpu_read(vector_irq[vector]);
 	if (likely(!IS_ERR_OR_NULL(desc))) {
 		handle_irq(desc, regs);
@@ -268,7 +260,20 @@ DEFINE_IDTENTRY_IRQ(common_interrupt)
 			__this_cpu_write(vector_irq[vector], VECTOR_UNUSED);
 		}
 	}
+}
+
+/*
+ * common_interrupt() handles all normal device IRQ's (the special SMP
+ * cross-CPU interrupts have their own entry points).
+ */
+DEFINE_IDTENTRY_IRQ(common_interrupt)
+{
+	struct pt_regs *old_regs = set_irq_regs(regs);
+
+	/* entry code tells RCU that we're not quiescent.  Check it. */
+	RCU_LOCKDEP_WARN(!rcu_is_watching(), "IRQ failed to wake up RCU");
 
+	call_irq_handler(vector, regs);
 	set_irq_regs(old_regs);
 }
 
-- 
2.25.1

