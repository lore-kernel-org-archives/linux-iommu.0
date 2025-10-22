Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F4D309F1E
	for <iommu@lists.linux.dev>; Wed, 22 Oct 2025 08:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761121768; cv=none; b=eso5ClN5hjg/XxJDQJ8yLVUAd1SNxG3vtDFUMd7XOlFxZ8WOdu87t0JxW16EIoqXdNPPTfQMN/m1e8bBj9OwypHVZ2wURnc8pNE27kxIhyGRWl7mjpJo/cQ2P+VdK0UnqySboxxBJlFvG1+Vxo24spUGus+mttwMtEu5Mq4ljl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761121768; c=relaxed/simple;
	bh=PamdCW5SIExW2MSTVmRrUvcUix6foLzr9uopaA+M2pw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k+53NN4Wf7KpqLx0t4HaIZnhZZEdTA99m9bhUVWqY72BiAPwBidKwFvhw+RI9IJCpLfQk+TIY9MGl9Eqv0lHSj+ZGv7YXBFrm3MyqFDlRSxuxxlSepMR7sZSzunRk7TgEyW9U6Tgep3KRfaAiVfL+M6sfiUdwebHCGe5IA7NrD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZDKSeZy1; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZDKSeZy1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761121764; x=1792657764;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PamdCW5SIExW2MSTVmRrUvcUix6foLzr9uopaA+M2pw=;
  b=ZDKSeZy1I96XoZa2meLhEPOy2QN24JU5UDN+195hbvbqWflQ/T87RH7E
   djryqrySNklZIaV7BGAY0Aiqz7IUVPFAwFFC6cTRCizuW7XTgnINzDSNV
   /4QuLO9Rjd4aampgJQ4BOTuxEhuhctB24ER40CsgOc0EVGHywzbNZUqNj
   UhqNH13Sg8VsYcv2a4mzlsmAXcsAdB/O3XABxWPaFTZdQDXYZSJlUva6R
   Uax9oxjrPEYClUjuvox/XZ8x6pDpioABc6k0FMNLQGKktEzHiDdLLON0P
   itv491yLo2bRmNTzSjqbXNj0klFv333Lkbn3ID06bNelj5d+N66OvsJZq
   A==;
X-CSE-ConnectionGUID: tWWwiMgPSFut+nDwNt1utA==
X-CSE-MsgGUID: jFIEpD6OTJuTuqm7YwlWfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74700862"
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="74700862"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 01:29:24 -0700
X-CSE-ConnectionGUID: uYNe54tGQT2jRkTDg8M2GQ==
X-CSE-MsgGUID: 96m6+PNSSlueQgOErfr6UA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="183516242"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa007.fm.intel.com with ESMTP; 22 Oct 2025 01:29:17 -0700
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
Subject: [PATCH v7 2/8] mm: Add a ptdesc flag to mark kernel page tables
Date: Wed, 22 Oct 2025 16:26:28 +0800
Message-ID: <20251022082635.2462433-3-baolu.lu@linux.intel.com>
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

The page tables used to map the kernel and userspace often have very
different handling rules. There are frequently *_kernel() variants of
functions just for kernel page tables. That's not great and has lead
to code duplication.

Instead of having completely separate call paths, allow a 'ptdesc' to
be marked as being for kernel mappings. Introduce helpers to set and
clear this status.

Note: this uses the PG_referenced bit. Page flags are a great fit for
this since it is truly a single bit of information.  Use PG_referenced
itself because it's a fairly benign flag (as opposed to things like
PG_lock). It's also (according to Willy) unlikely to go away any time
soon.

PG_referenced is not in PAGE_FLAGS_CHECK_AT_FREE. It does not need to
be cleared before freeing the page, and pages coming out of the
allocator should have it cleared. Regardless, introduce an API to
clear it anyway. Having symmetry in the API makes it easier to change
the underlying implementation later, like if there was a need to move
to a PAGE_FLAGS_CHECK_AT_FREE bit.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index d16b33bacc32..354d7925bf77 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2940,6 +2940,7 @@ static inline pmd_t *pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long a
 #endif /* CONFIG_MMU */
 
 enum pt_flags {
+	PT_kernel = PG_referenced,
 	PT_reserved = PG_reserved,
 	/* High bits are used for zone/node/section */
 };
@@ -2965,6 +2966,46 @@ static inline bool pagetable_is_reserved(struct ptdesc *pt)
 	return test_bit(PT_reserved, &pt->pt_flags.f);
 }
 
+/**
+ * ptdesc_set_kernel - Mark a ptdesc used to map the kernel
+ * @ptdesc: The ptdesc to be marked
+ *
+ * Kernel page tables often need special handling. Set a flag so that
+ * the handling code knows this ptdesc will not be used for userspace.
+ */
+static inline void ptdesc_set_kernel(struct ptdesc *ptdesc)
+{
+	set_bit(PT_kernel, &ptdesc->pt_flags.f);
+}
+
+/**
+ * ptdesc_clear_kernel - Mark a ptdesc as no longer used to map the kernel
+ * @ptdesc: The ptdesc to be unmarked
+ *
+ * Use when the ptdesc is no longer used to map the kernel and no longer
+ * needs special handling.
+ */
+static inline void ptdesc_clear_kernel(struct ptdesc *ptdesc)
+{
+	/*
+	 * Note: the 'PG_referenced' bit does not strictly need to be
+	 * cleared before freeing the page. But this is nice for
+	 * symmetry.
+	 */
+	clear_bit(PT_kernel, &ptdesc->pt_flags.f);
+}
+
+/**
+ * ptdesc_test_kernel - Check if a ptdesc is used to map the kernel
+ * @ptdesc: The ptdesc being tested
+ *
+ * Call to tell if the ptdesc used to map the kernel.
+ */
+static inline bool ptdesc_test_kernel(const struct ptdesc *ptdesc)
+{
+	return test_bit(PT_kernel, &ptdesc->pt_flags.f);
+}
+
 /**
  * pagetable_alloc - Allocate pagetables
  * @gfp:    GFP flags
-- 
2.43.0

