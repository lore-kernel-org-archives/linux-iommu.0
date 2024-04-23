Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB2413E3FA
	for <iommu@lists.linux.dev>; Tue, 23 Apr 2024 17:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713893819; cv=none; b=UuRYa0lnNhDcX+fvr6NK40ZSras3L/Jd2sIdkFvNGo7D0bFLALA2dmmCiNicfH4e4MwQApd+yPaZrtBeTgghPG757x8ESAPwWzwXDQ6VbrmG34ryln1mNUZKAxHPS/F7SxyARH06XCItWtqXsVzge2f63Un8J+XjTKikfaVFkcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713893819; c=relaxed/simple;
	bh=GxBLTYG+s4PclMc+/uKhnAWlwH60FRMme9HruCm3Yi0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=idYPuu5IUGAblhYa437YTdBDTSpPIuYJxSCXTIRYzxy9A7DvdmqlRpCAZMblVkb9x1xowpuxyKCYziM3T/sVRBdGTiSb7U4QeLvEX0CYPtUgPZHX0z0XScJSz1/9VqLIUWTg8ql2Nv0Kz9Hf+bvuDF7FuFs1qxo+OoqYxO+Tyu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VeuIftsQ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VeuIftsQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713893819; x=1745429819;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GxBLTYG+s4PclMc+/uKhnAWlwH60FRMme9HruCm3Yi0=;
  b=VeuIftsQaVkVJU8o6cn9nEpTnttQ25A9iOKKR/27eYprvFu9Twr0NsJE
   mwcSv0cL74RAI3lJYs+JYhl6YOjBAZGH5fEVsJZ6UzazCpBUNl1RO+2BX
   FVCpBb0pxT50b3uvj8Ve58Qd4ONvZ2gyBuw7F/UZhzJpHVMkttcQ13Nya
   0lmWVjcSsd/bXcsHurywENlFHiOOACq7cKAKxinRCT2X0GpoISeIY9sNM
   9yc+UU/Kyl7ymer2Ww2auCLbOg29PPFWWLPkSizy8Nvc/Mt7a+3ncOMeu
   01xsUoL0zVz9n7vb+0T59V2RsR7aZrAWD4lxnx3PSIXTICozo5Bfj/I1C
   w==;
X-CSE-ConnectionGUID: DzG895PXQ6uFCAQP9w4/Vw==
X-CSE-MsgGUID: b1aog/XbSkuOxJOpOKiYDA==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="9712469"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="9712469"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 10:36:46 -0700
X-CSE-ConnectionGUID: V4e9XLIFTju7Kex1holA2g==
X-CSE-MsgGUID: Q79w74fRR12lYwpupXYi5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="29097447"
Received: from jacob-builder.jf.intel.com ([10.54.39.125])
  by fmviesa004.fm.intel.com with ESMTP; 23 Apr 2024 10:36:45 -0700
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
	jim.harris@samsung.com,
	a.manzanares@samsung.com,
	"Bjorn Helgaas" <helgaas@kernel.org>,
	guang.zeng@intel.com,
	robert.hoo.linux@gmail.com,
	oliver.sang@intel.com,
	acme@kernel.org,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v3  09/12] x86/irq: Factor out common code for checking pending interrupts
Date: Tue, 23 Apr 2024 10:41:11 -0700
Message-Id: <20240423174114.526704-10-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240423174114.526704-1-jacob.jun.pan@linux.intel.com>
References: <20240423174114.526704-1-jacob.jun.pan@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a common function for checking pending interrupt vector in APIC IRR
instead of duplicated open coding them.

Additional checks for posted MSI vectors can then be contained in this
function.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 arch/x86/include/asm/apic.h   | 11 +++++++++++
 arch/x86/kernel/apic/vector.c |  5 ++---
 arch/x86/kernel/irq.c         |  5 ++---
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index e6ab0cf15ed5..50f9781fa3ed 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -500,6 +500,17 @@ static inline bool lapic_vector_set_in_irr(unsigned int vector)
 	return !!(irr & (1U << (vector % 32)));
 }
 
+static inline bool is_vector_pending(unsigned int vector)
+{
+	unsigned int irr;
+
+	irr = apic_read(APIC_IRR + (vector / 32 * 0x10));
+	if (irr  & (1 << (vector % 32)))
+		return true;
+
+	return false;
+}
+
 /*
  * Warm reset vector position:
  */
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 185738c72766..9eec52925fa3 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -965,7 +965,7 @@ static void __vector_cleanup(struct vector_cleanup *cl, bool check_irr)
 	lockdep_assert_held(&vector_lock);
 
 	hlist_for_each_entry_safe(apicd, tmp, &cl->head, clist) {
-		unsigned int irr, vector = apicd->prev_vector;
+		unsigned int vector = apicd->prev_vector;
 
 		/*
 		 * Paranoia: Check if the vector that needs to be cleaned
@@ -979,8 +979,7 @@ static void __vector_cleanup(struct vector_cleanup *cl, bool check_irr)
 		 * fixup_irqs() was just called to scan IRR for set bits and
 		 * forward them to new destination CPUs via IPIs.
 		 */
-		irr = check_irr ? apic_read(APIC_IRR + (vector / 32 * 0x10)) : 0;
-		if (irr & (1U << (vector % 32))) {
+		if (check_irr && is_vector_pending(vector)) {
 			pr_warn_once("Moved interrupt pending in old target APIC %u\n", apicd->irq);
 			rearm = true;
 			continue;
diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 578e4f6a5080..385e3a5fc304 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -484,7 +484,7 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_posted_msi_notification)
 /* A cpu has been removed from cpu_online_mask.  Reset irq affinities. */
 void fixup_irqs(void)
 {
-	unsigned int irr, vector;
+	unsigned int vector;
 	struct irq_desc *desc;
 	struct irq_data *data;
 	struct irq_chip *chip;
@@ -511,8 +511,7 @@ void fixup_irqs(void)
 		if (IS_ERR_OR_NULL(__this_cpu_read(vector_irq[vector])))
 			continue;
 
-		irr = apic_read(APIC_IRR + (vector / 32 * 0x10));
-		if (irr  & (1 << (vector % 32))) {
+		if (is_vector_pending(vector)) {
 			desc = __this_cpu_read(vector_irq[vector]);
 
 			raw_spin_lock(&desc->lock);
-- 
2.25.1

