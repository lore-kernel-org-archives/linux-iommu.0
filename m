Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB612DBF73
	for <iommu@lists.linux.dev>; Tue, 17 Jun 2025 09:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750153894; cv=none; b=uQa2nMpx0cay07wzbLjnwJItepg/J+XH4s6gpFteN0amSz/Qrkx6X9YT0mmBSwWRGJdHCda2L3Vzo2WfGMil8uqldMO+F3HbkHhjYxLQaCNLLk4xRknAHrUsZ5qIn/JycLIXYi44Y/g0EGhM7oToCicsoYOBTOYVG+ZpncN4X3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750153894; c=relaxed/simple;
	bh=i/RC7w7SIukP0reEqSf0TuoW4olsTf8kWiDHI+cmm14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U0N0fzeliS8eFAq7yQqS+qdFYdJGptMSHXm0oURG+xk7khvcXtZJRX3S6kV+RePzfStGnhrsygVlBd655KzIRgcJ9C2MVxG8ExpfUI9UHhL4vEZEdW6RiIXw9OarA/0TQsFoNcttmABSRn31pvSGMIrQp44B1kk96QHpklmSdm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0171A22EE;
	Tue, 17 Jun 2025 02:51:11 -0700 (PDT)
Received: from mazurka.cambridge.arm.com (mazurka.cambridge.arm.com [10.2.80.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A8D463F58B;
	Tue, 17 Jun 2025 02:51:28 -0700 (PDT)
From: =?UTF-8?q?Miko=C5=82aj=20Lenczewski?= <miko.lenczewski@arm.com>
To: ryan.roberts@arm.com,
	yang@os.amperecomputing.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	jean-philippe@linaro.org,
	robin.murphy@arm.com,
	joro@8bytes.org,
	maz@kernel.org,
	oliver.upton@linux.dev,
	joey.gouly@arm.com,
	james.morse@arm.com,
	broonie@kernel.org,
	ardb@kernel.org,
	baohua@kernel.org,
	suzuki.poulose@arm.com,
	david@redhat.com,
	jgg@ziepe.ca,
	nicolinc@nvidia.com,
	jsnitsel@redhat.com,
	mshavit@google.com,
	kevin.tian@intel.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Cc: =?UTF-8?q?Miko=C5=82aj=20Lenczewski?= <miko.lenczewski@arm.com>
Subject: [PATCH v7 4/4] arm64/mm: Elide tlbi in contpte_convert() under BBML2
Date: Tue, 17 Jun 2025 09:51:04 +0000
Message-ID: <20250617095104.6772-5-miko.lenczewski@arm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617095104.6772-1-miko.lenczewski@arm.com>
References: <20250617095104.6772-1-miko.lenczewski@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When converting a region via contpte_convert() to use mTHP, we have two
different goals. We have to mark each entry as contiguous, and we would
like to smear the dirty and young (access) bits across all entries in
the contiguous block. Currently, we do this by first accumulating the
dirty and young bits in the block, using an atomic
__ptep_get_and_clear() and the relevant pte_{dirty,young}() calls,
performing a tlbi, and finally smearing the correct bits across the
block using __set_ptes().

This approach works fine for BBM level 0, but with support for BBM level
2 we are allowed to reorder the tlbi to after setting the pagetable
entries. We expect the time cost of a tlbi to be much greater than the
cost of clearing and resetting the PTEs. As such, this reordering of the
tlbi outside the window where our PTEs are invalid greatly reduces the
duration the PTE are visibly invalid for other threads. This reduces the
likelyhood of a concurrent page walk finding an invalid PTE, reducing
the likelyhood of a fault in other threads, and improving performance
(more so when there are more threads).

Because we support via allowlist only bbml2 implementations that never
raise conflict aborts and instead invalidate the tlb entries
automatically in hardware, we can avoid the final flush altogether.

However, avoiding the intermediate tlbi+dsb must be carefully considered
to ensure that we remain both correct and performant. We document our
reasoning and the expected interactions further in the contpte_convert()
source. To do so we rely on the aarch64 spec (DDI 0487L.a D8.7.1.1)
requirements RNGLXZ and RJQQTC to provide guarantees that the elision is
correct.

Signed-off-by: Mikołaj Lenczewski <miko.lenczewski@arm.com>
Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
---
 arch/arm64/mm/contpte.c | 139 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 138 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
index bcac4f55f9c1..203357061d0a 100644
--- a/arch/arm64/mm/contpte.c
+++ b/arch/arm64/mm/contpte.c
@@ -68,7 +68,144 @@ static void contpte_convert(struct mm_struct *mm, unsigned long addr,
 			pte = pte_mkyoung(pte);
 	}
 
-	__flush_tlb_range(&vma, start_addr, addr, PAGE_SIZE, true, 3);
+	/*
+	 * On eliding the __tlb_flush_range() under BBML2+noabort:
+	 *
+	 * NOTE: Instead of using N=16 as the contiguous block length, we use
+	 *       N=4 for clarity.
+	 *
+	 * NOTE: 'n' and 'c' are used to denote the "contiguous bit" being
+	 *       unset and set, respectively.
+	 *
+	 * We worry about two cases where contiguous bit is used:
+	 *  - When folding N smaller non-contiguous ptes as 1 contiguous block.
+	 *  - When unfolding a contiguous block into N smaller non-contiguous ptes.
+	 *
+	 * Currently, the BBML0 folding case looks as follows:
+	 *
+	 *  0) Initial page-table layout:
+	 *
+	 *   +----+----+----+----+
+	 *   |RO,n|RO,n|RO,n|RW,n| <--- last page being set as RO
+	 *   +----+----+----+----+
+	 *
+	 *  1) Aggregate AF + dirty flags using __ptep_get_and_clear():
+	 *
+	 *   +----+----+----+----+
+	 *   |  0 |  0 |  0 |  0 |
+	 *   +----+----+----+----+
+	 *
+	 *  2) __flush_tlb_range():
+	 *
+	 *   |____ tlbi + dsb ____|
+	 *
+	 *  3) __set_ptes() to repaint contiguous block:
+	 *
+	 *   +----+----+----+----+
+	 *   |RO,c|RO,c|RO,c|RO,c|
+	 *   +----+----+----+----+
+	 *
+	 *  4) The kernel will eventually __flush_tlb() for changed page:
+	 *
+	 *                  |____| <--- tlbi + dsb
+	 *
+	 * As expected, the intermediate tlbi+dsb ensures that other PEs
+	 * only ever see an invalid (0) entry, or the new contiguous TLB entry.
+	 * The final tlbi+dsb will always throw away the newly installed
+	 * contiguous TLB entry, which is a micro-optimisation opportunity,
+	 * but does not affect correctness.
+	 *
+	 * In the BBML2 case, the change is avoiding the intermediate tlbi+dsb.
+	 * This means a few things, but notably other PEs will still "see" any
+	 * stale cached TLB entries. This could lead to a "contiguous bit
+	 * misprogramming" issue until the final tlbi+dsb of the changed page,
+	 * which would clear out both the stale (RW,n) entry and the new (RO,c)
+	 * contiguous entry installed in its place.
+	 *
+	 * What this is saying, is the following:
+	 *
+	 *  +----+----+----+----+
+	 *  |RO,n|RO,n|RO,n|RW,n| <--- old page tables, all non-contiguous
+	 *  +----+----+----+----+
+	 *
+	 *  +----+----+----+----+
+	 *  |RO,c|RO,c|RO,c|RO,c| <--- new page tables, all contiguous
+	 *  +----+----+----+----+
+	 *   /\
+	 *   ||
+	 *
+	 *  If both the old single (RW,n) and new contiguous (RO,c) TLB entries
+	 *  are present, and a write is made to this address, do we fault or
+	 *  is the write permitted (via amalgamation)?
+	 *
+	 * The relevant Arm ARM DDI 0487L.a requirements are RNGLXZ and RJQQTC,
+	 * and together state that when BBML1 or BBML2 are implemented, either
+	 * a TLB conflict abort is raised (which we expressly forbid), or will
+	 * "produce an OA, access permissions, and memory attributes that are
+	 * consistent with any of the programmed translation table values".
+	 *
+	 * That is to say, will either raise a TLB conflict, or produce one of
+	 * the cached TLB entries, but never amalgamate.
+	 *
+	 * Thus, as the page tables are only considered "consistent" after
+	 * the final tlbi+dsb (which evicts both the single stale (RW,n) TLB
+	 * entry as well as the new contiguous (RO,c) TLB entry), omitting the
+	 * initial tlbi+dsb is correct.
+	 *
+	 * It is also important to note that at the end of the BBML2 folding
+	 * case, we are still left with potentially all N TLB entries still
+	 * cached (the N-1 non-contiguous ptes, and the single contiguous
+	 * block). However, over time, natural TLB pressure will cause the
+	 * non-contiguous pte TLB entries to be flushed, leaving only the
+	 * contiguous block TLB entry. This means that omitting the tlbi+dsb is
+	 * not only correct, but also keeps our eventual performance benefits.
+	 *
+	 * For the unfolding case, BBML0 looks as follows:
+	 *
+	 *  0) Initial page-table layout:
+	 *
+	 *   +----+----+----+----+
+	 *   |RW,c|RW,c|RW,c|RW,c| <--- last page being set as RO
+	 *   +----+----+----+----+
+	 *
+	 *  1) Aggregate AF + dirty flags using __ptep_get_and_clear():
+	 *
+	 *   +----+----+----+----+
+	 *   |  0 |  0 |  0 |  0 |
+	 *   +----+----+----+----+
+	 *
+	 *  2) __flush_tlb_range():
+	 *
+	 *   |____ tlbi + dsb ____|
+	 *
+	 *  3) __set_ptes() to repaint as non-contiguous:
+	 *
+	 *   +----+----+----+----+
+	 *   |RW,n|RW,n|RW,n|RW,n|
+	 *   +----+----+----+----+
+	 *
+	 *  4) Update changed page permissions:
+	 *
+	 *   +----+----+----+----+
+	 *   |RW,n|RW,n|RW,n|RO,n| <--- last page permissions set
+	 *   +----+----+----+----+
+	 *
+	 *  5) The kernel will eventually __flush_tlb() for changed page:
+	 *
+	 *                  |____| <--- tlbi + dsb
+	 *
+	 * For BBML2, we again remove the intermediate tlbi+dsb. Here, there
+	 * are no issues, as the final tlbi+dsb covering the changed page is
+	 * guaranteed to remove the original large contiguous (RW,c) TLB entry,
+	 * as well as the intermediate (RW,n) TLB entry; the next access will
+	 * install the new (RO,n) TLB entry and the page tables are only
+	 * considered "consistent" after the final tlbi+dsb, so software must
+	 * be prepared for this inconsistency prior to finishing the mm dance
+	 * regardless.
+	 */
+
+	if (!system_supports_bbml2_noabort())
+		__flush_tlb_range(&vma, start_addr, addr, PAGE_SIZE, true, 3);
 
 	__set_ptes(mm, start_addr, start_ptep, pte, CONT_PTES);
 }
-- 
2.49.0

