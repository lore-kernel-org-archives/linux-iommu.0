Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9773D309EFB
	for <iommu@lists.linux.dev>; Wed, 22 Oct 2025 08:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761121782; cv=none; b=d17eKuM9yRF1dpShoocR2FLAI0Z26DLqOZ9lKoLtRmLyIoAW3sWAMGq0VpORBdJuqT5JPlS/omeASWRarZH1AFbH3OUdPQjzc5q2eGArbepTwsGjKnzzX/AQPifitoxQg+D5bB9bZrw4fStxqFOzHccelknjOBWgYXZSBWBSavM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761121782; c=relaxed/simple;
	bh=on6Ag9NJz0vk1kj+5aoSFuQQtRI0JdB9JVEfIv+bEQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u9saP6uz3W3UIuTHX9WH4jmx6XgngyJ/e82QmnLldq48R3c7wgs6LquuCtEjljpOPB1Sj+6JhaeHvS3l3VJ1QkRanoUyAb3MmiYnY6igjG4HSqjxDjTsVVfHPfnNribe9Ls3DG9sf/qjUAlQidHCb+Y3yQf7CYJWJ9qB+qBDRfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d2VxwsUz; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d2VxwsUz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761121780; x=1792657780;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=on6Ag9NJz0vk1kj+5aoSFuQQtRI0JdB9JVEfIv+bEQw=;
  b=d2VxwsUzF9lNLFgCo7Grpm8JzDGclfFXSHoA3viK5bdxUFI8vaktgzSr
   Zr3pkyhr+xJVhO/kUloJY5pPHe2Dc+0FTxooNPeEGJh1qGnhSPIqFzsdK
   OtDXaTaMgawtL2zttxZr0i0+i8V1MJAx9/q2PGJxthaLlvSqbE2JhR2pB
   9NwvluxTuGwuqV0Wtd11BecCuKbRlJr+DYGfP/fvM2NFsOtjOMa1S5Uci
   wu93OltOakt5PAOqCVjzkcRLn61R2Pf6/0KMcWKiBmbwXOBczqoD+iwsK
   M86yqfiej6Ze4CYKeR1oslzTsfRkz2O+qvCQJdalpMieE+rkHT6blVQhR
   w==;
X-CSE-ConnectionGUID: KlTvCMt8Qmq6Uqh2xRAclg==
X-CSE-MsgGUID: iWPbg4ttRViP+B3qNrq6hA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="65879178"
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="65879178"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 01:29:40 -0700
X-CSE-ConnectionGUID: Sa3UKoJgTC6E3excfo+Q9w==
X-CSE-MsgGUID: /pRj0LcbRHm0dwuta+OIPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="183516346"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa007.fm.intel.com with ESMTP; 22 Oct 2025 01:29:33 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Jann Horn <jannh@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@intel.com>,
	Alistair Popple <apopple@nvidia.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Andy Lutomirski <luto@kernel.org>,
	Yi Lai <yi1.lai@intel.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Michal Hocko <mhocko@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: iommu@lists.linux.dev,
	security@kernel.org,
	x86@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v7 4/8] x86/mm: Use 'ptdesc' when freeing PMD pages
Date: Wed, 22 Oct 2025 16:26:30 +0800
Message-ID: <20251022082635.2462433-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251022082635.2462433-1-baolu.lu@linux.intel.com>
References: <20251022082635.2462433-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Hansen <dave.hansen@linux.intel.com>

There are a billion ways to refer to a physical memory address.
One of the x86 PMD freeing code location chooses to use a 'pte_t *' to
point to a PMD page and then call a PTE-specific freeing function for
it.  That's a bit wonky.

Just use a 'struct ptdesc *' instead. Its entire purpose is to refer
to page table pages. It also means being able to remove an explicit
cast.

Right now, pte_free_kernel() is a one-liner that calls
pagetable_dtor_free(). Effectively, all this patch does is
remove one superfluous __pa(__va(paddr)) conversion and then
call pagetable_dtor_free() directly instead of through a helper.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 arch/x86/mm/pgtable.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index ddf248c3ee7d..2e5ecfdce73c 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -729,7 +729,7 @@ int pmd_clear_huge(pmd_t *pmd)
 int pud_free_pmd_page(pud_t *pud, unsigned long addr)
 {
 	pmd_t *pmd, *pmd_sv;
-	pte_t *pte;
+	struct ptdesc *pt;
 	int i;
 
 	pmd = pud_pgtable(*pud);
@@ -750,8 +750,8 @@ int pud_free_pmd_page(pud_t *pud, unsigned long addr)
 
 	for (i = 0; i < PTRS_PER_PMD; i++) {
 		if (!pmd_none(pmd_sv[i])) {
-			pte = (pte_t *)pmd_page_vaddr(pmd_sv[i]);
-			pte_free_kernel(&init_mm, pte);
+			pt = page_ptdesc(pmd_page(pmd_sv[i]));
+			pagetable_dtor_free(pt);
 		}
 	}
 
@@ -772,15 +772,15 @@ int pud_free_pmd_page(pud_t *pud, unsigned long addr)
  */
 int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
 {
-	pte_t *pte;
+	struct ptdesc *pt;
 
-	pte = (pte_t *)pmd_page_vaddr(*pmd);
+	pt = page_ptdesc(pmd_page(*pmd));
 	pmd_clear(pmd);
 
 	/* INVLPG to clear all paging-structure caches */
 	flush_tlb_kernel_range(addr, addr + PAGE_SIZE-1);
 
-	pte_free_kernel(&init_mm, pte);
+	pagetable_dtor_free(pt);
 
 	return 1;
 }
-- 
2.43.0

