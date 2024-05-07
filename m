Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C108C6D1C8
	for <iommu@lists.linux.dev>; Tue,  7 May 2024 06:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715062819; cv=none; b=tkmMvZ9IpzLlXCFAY8WcyJFcA4sYjkxRqBB7y+O/QIkOayqLxSMVhgjZR1rftpGGQEp7Yf/bt2p2z5wfY7ii92LL41ni3Mp5dKU+iuHP/7H3Ni8BB9AwuSnF7LhsO1vVXeI07xoXaYgs7S1M7LmdcKwEQxutDgT84vhRaYxt0d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715062819; c=relaxed/simple;
	bh=mSaRASfGQY8AR8D1WEG7ksj0ddXO2afJXERqBKb8+K0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=atT3/hynWliohLFUHz24bz+SYfHfCAuNCpUl8K3Gtd55ZxsdHfn944la+8slkVnIPoXRbtrqUC4berDJ6i80mZPd4J1z5y7Sk7T0VwFJ3e2TK8hhjpKXVsetuDnJ5pQ6I9jkRTtsurSybNKpySxeXf4tJIy/HWPBfPmflHB3zj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z1SjWqrr; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z1SjWqrr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715062817; x=1746598817;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=mSaRASfGQY8AR8D1WEG7ksj0ddXO2afJXERqBKb8+K0=;
  b=Z1SjWqrr1/J7A/7jDUahemLkC4I9IRYgakWRj3bLTmumGcgOPXxyqUEm
   ey8swK5yIDJhExjxFY69xIJgBl4cijsvn1qz99g++9CJ/R4MXDuDQP9rX
   wjWAN6Qfla4D0j3l/C48ZwuPBX3mf91D2VPekONMDZ2MY24GVK5OCJnp7
   vlgKRjUScRtCZ5FYYwyxOgR0zT/btVG0oIunu2PSUZkCULgGOEmGadcid
   ARBcJPhfiZ6575q/yBEUqJaiWHgyz2SkttoRg7AoSz1PEyybnbsrPFG3L
   7vneJrELgAyB0BTwtkWMjZBzQJ/GJQ+Gp8G6swqcTVv5oL9SRZsgukV4H
   A==;
X-CSE-ConnectionGUID: q2PTg6bUQUeBPeWoVT6rvQ==
X-CSE-MsgGUID: r2yv5WXYTMO7O++aAdh4xA==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="10672817"
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; 
   d="scan'208";a="10672817"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 23:20:17 -0700
X-CSE-ConnectionGUID: mo9MOEQOR7OgE5r5/VzEQg==
X-CSE-MsgGUID: 03sqDDM8Sde46PMnyPlv4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; 
   d="scan'208";a="33081907"
Received: from yzhao56-desk.sh.intel.com ([10.239.159.62])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 23:20:11 -0700
From: Yan Zhao <yan.y.zhao@intel.com>
To: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	alex.williamson@redhat.com,
	jgg@nvidia.com,
	kevin.tian@intel.com
Cc: iommu@lists.linux.dev,
	pbonzini@redhat.com,
	seanjc@google.com,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	hpa@zytor.com,
	corbet@lwn.net,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	baolu.lu@linux.intel.com,
	yi.l.liu@intel.com,
	Yan Zhao <yan.y.zhao@intel.com>
Subject: [PATCH 1/5] x86/pat: Let pat_pfn_immune_to_uc_mtrr() check MTRR for untracked PAT range
Date: Tue,  7 May 2024 14:19:24 +0800
Message-Id: <20240507061924.20251-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240507061802.20184-1-yan.y.zhao@intel.com>
References: <20240507061802.20184-1-yan.y.zhao@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

Let pat_pfn_immune_to_uc_mtrr() check MTRR type for PFNs in untracked PAT
range.

pat_pfn_immune_to_uc_mtrr() is used by KVM to distinguish MMIO PFNs and
give them UC memory type in the EPT page tables.
When pat_pfn_immune_to_uc_mtrr() identifies a PFN as having a PAT type of
UC/WC/UC-, it indicates that the PFN should be accessed using an
uncacheable memory type. Consequently, KVM maps it with UC in the EPT to
ensure that the guest's memory access is uncacheable.

Internally, pat_pfn_immune_to_uc_mtrr() utilizes lookup_memtype() to
determine PAT type for a PFN. For a PFN outside untracked PAT range, the
returned PAT type is either
- The type set by memtype_reserve()
  (which, in turn, calls pat_x_mtrr_type() to adjust the requested type to
   UC- if the requested type is WB but the MTRR type does not match WB),
- Or UC-, if memtype_reserve() has not yet been invoked for this PFN.

However, lookup_memtype() defaults to returning WB for PFNs within the
untracked PAT range, regardless of their actual MTRR type. This behavior
could lead KVM to misclassify the PFN as non-MMIO, permitting cacheable
guest access. Such access might result in MCE on certain platforms, (e.g.
clflush on VGA range (0xA0000-0xBFFFF) triggers MCE on some platforms).

Hence, invoke pat_x_mtrr_type() for PFNs within the untracked PAT range so
as to take MTRR type into account to mitigate potential MCEs.

Fixes: b8d7044bcff7 ("x86/mm: add a function to check if a pfn is UC/UC-/WC")
Cc: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
 arch/x86/mm/pat/memtype.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index 36b603d0cdde..e85e8c5737ad 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -705,7 +705,17 @@ static enum page_cache_mode lookup_memtype(u64 paddr)
  */
 bool pat_pfn_immune_to_uc_mtrr(unsigned long pfn)
 {
-	enum page_cache_mode cm = lookup_memtype(PFN_PHYS(pfn));
+	u64 paddr = PFN_PHYS(pfn);
+	enum page_cache_mode cm;
+
+	/*
+	 * Check MTRR type for untracked pat range since lookup_memtype() always
+	 * returns WB for this range.
+	 */
+	if (x86_platform.is_untracked_pat_range(paddr, paddr + PAGE_SIZE))
+		cm = pat_x_mtrr_type(paddr, paddr + PAGE_SIZE, _PAGE_CACHE_MODE_WB);
+	else
+		cm = lookup_memtype(paddr);
 
 	return cm == _PAGE_CACHE_MODE_UC ||
 	       cm == _PAGE_CACHE_MODE_UC_MINUS ||
-- 
2.17.1

