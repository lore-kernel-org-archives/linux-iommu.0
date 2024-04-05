Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA1D178CEB
	for <iommu@lists.linux.dev>; Fri,  5 Apr 2024 22:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712356015; cv=none; b=OL2V5ZyWiavE9MqbYyUIpst3v7cm412Oyj4AVFvxOchysots/lrm8hPXjVueO4FEWzPFZ9Pw69GUPE3N+6MxgW2qFlRfBUoFakWZ5RSgPyccPeMFThWVisbd9oclAGLYFANpax9p7SU1GTwxsLRd5rInC05fA3GjKv+ZbnCBc3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712356015; c=relaxed/simple;
	bh=LkTbi44XEjcmD+H9V0/r7+1X5xEeMnDv3K3o3ANyhmw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tme879AQ8RGl/z3r3/RT9Nz21uJZ2H0mK/1sGPVwJSlkkFfhtU4SVkLwrF2elGRuW1qZqYtYTQJe1IsKAmPe9TU/G2yVbPJAXusB6IC1PYL11KvMrPXU9IiTonzA9c2ODgAklxTbAQG4sFcdM6b8zm0GvGXM7EacWM7VPGK3piw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XuC4K53N; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XuC4K53N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712356012; x=1743892012;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LkTbi44XEjcmD+H9V0/r7+1X5xEeMnDv3K3o3ANyhmw=;
  b=XuC4K53NYfb+5G1j4S6v88rWn96xuexhGSTIKfU2ss7e26WMpJgqeWv1
   Xho0t5zRGP3dk40ZJ7ae+Xo8fXVVO/s0EhAMeYzv8XlgEC+rwBQElbzq4
   4Kh5VnYCnr8Fbh6cmrsFzIBMJIrT2auXrjM3tejIXLUs1cyRQx0aSkUW4
   eHUp0osKB95EqFGtpH3O5bWO5hmcdTQ0HFYgCpj9S7oapA4aZDHcEa/A2
   xsWVROCl4WpH9KpbKBWAo5/nE2qT+J9nIUz0BJkbkoX0s1dVza/Yzk6H1
   Vz5XZwLsBX8dctExTZ9cGUNrb8b7M6GGtPPn3u35A46b7wacwAzMxDDGz
   g==;
X-CSE-ConnectionGUID: 1oB1zFozTGCUToFnvc9sOw==
X-CSE-MsgGUID: gGRlwDZkS0mFSPOONzgXZA==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="19062789"
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="19062789"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 15:26:51 -0700
X-CSE-ConnectionGUID: cOkIIhzfSXisjOEM48bJGQ==
X-CSE-MsgGUID: zH4owt0ZTBS8MP9bwG+JrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="23928332"
Received: from jacob-builder.jf.intel.com ([10.54.39.125])
  by fmviesa004.fm.intel.com with ESMTP; 05 Apr 2024 15:26:50 -0700
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
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v2 09/13] x86/irq: Factor out common code for checking pending interrupts
Date: Fri,  5 Apr 2024 15:31:06 -0700
Message-Id: <20240405223110.1609888-10-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240405223110.1609888-1-jacob.jun.pan@linux.intel.com>
References: <20240405223110.1609888-1-jacob.jun.pan@linux.intel.com>
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
index 94ce0f7c9d3a..ebf80718912d 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -499,6 +499,17 @@ static inline bool lapic_vector_set_in_irr(unsigned int vector)
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
index 8772b0a3abf6..3206d48f380d 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -480,7 +480,7 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_posted_msi_notification)
 /* A cpu has been removed from cpu_online_mask.  Reset irq affinities. */
 void fixup_irqs(void)
 {
-	unsigned int irr, vector;
+	unsigned int vector;
 	struct irq_desc *desc;
 	struct irq_data *data;
 	struct irq_chip *chip;
@@ -507,8 +507,7 @@ void fixup_irqs(void)
 		if (IS_ERR_OR_NULL(__this_cpu_read(vector_irq[vector])))
 			continue;
 
-		irr = apic_read(APIC_IRR + (vector / 32 * 0x10));
-		if (irr  & (1 << (vector % 32))) {
+		if (is_vector_pending(vector)) {
 			desc = __this_cpu_read(vector_irq[vector]);
 
 			raw_spin_lock(&desc->lock);
-- 
2.25.1

