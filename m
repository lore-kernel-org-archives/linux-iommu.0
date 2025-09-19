Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA00B2E40E
	for <iommu@lists.linux.dev>; Fri, 19 Sep 2025 05:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758260560; cv=none; b=uclea99X50Q9cJZAw742PwuRfW+Ti8BH+uw79nQQHbViI7O/fscKhAH8MpUsvpihORVq8rGCQH3UcFgd/J4gfwTxwbPuuJsuwq8qtEvKGDRJFiRGy7OctIiM/4BBYkrEcsCqCdQQzeUifPuBLHGKpkU60Hp2G7QWF5RLeYyEywA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758260560; c=relaxed/simple;
	bh=iUqj3COmeW15RDC5LUeEsbZGHpcevKH79WP9pbOzJHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gKBnFc1kgh8qv/rS4aagz+sqszVjpCYaUBgvEYMwaPOvVFp6lwBqjWI2YMLXC2nLgmVzgSI2oGpKBW6gjzPfPpgagaebLQRlqIO04J1GwYT/JIrxQGSE5kAKxXOAErf6r49gqjwHsYjsG7ZxbHPMEm03Ngua/iCeJFmToh7O8mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NS28m+HF; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NS28m+HF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758260559; x=1789796559;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iUqj3COmeW15RDC5LUeEsbZGHpcevKH79WP9pbOzJHI=;
  b=NS28m+HFR0wDSxKokrqb3n1nd2ajJnOtJ2wwZvhO1YQXDtQ8LR3hL4D+
   4z9tA6lr/9Z79pZDWAHGi7hBb4n21pmEMYdwG7yGDEAgdKhC/1DuniwL/
   8oYm5soST91NzgPlaFMwYMXTpu7OcVHzdmmVbuilN4beNj0IzqQP5owVt
   YrwNvCTO9EbX0ARnk+yeIN0AuzkFuu8ymBfDQ18Ktki6ra7Q8JLXFnbqy
   Y3opnDQ1KtpMpwbMvGmTrVIU+9xD0iAYpaEMbSSOvueWR/ieOm9L/wIbk
   f/udL2NWmDyTKBFpHJHgW1ud+5nsUg6b09O6BK4ydRhueKiBeYDKb9mxb
   A==;
X-CSE-ConnectionGUID: +P3KPXeYTJ+WFem4+ewv7Q==
X-CSE-MsgGUID: MpVb9ltjQWGhY/N+mIBB3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="63235720"
X-IronPort-AV: E=Sophos;i="6.18,277,1751266800"; 
   d="scan'208";a="63235720"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 22:42:39 -0700
X-CSE-ConnectionGUID: PjyqK40nSoqjLfkLARL2lA==
X-CSE-MsgGUID: 3Q1FXywFT9WI1HxLfRFxXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,277,1751266800"; 
   d="scan'208";a="180858570"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa005.jf.intel.com with ESMTP; 18 Sep 2025 22:42:32 -0700
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
	Yi Lai <yi1.lai@intel.com>
Cc: iommu@lists.linux.dev,
	security@kernel.org,
	x86@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v5 1/8] mm: Add a ptdesc flag to mark kernel page tables
Date: Fri, 19 Sep 2025 13:39:59 +0800
Message-ID: <20250919054007.472493-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250919054007.472493-1-baolu.lu@linux.intel.com>
References: <20250919054007.472493-1-baolu.lu@linux.intel.com>
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
---
 include/linux/page-flags.h | 46 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 8d3fa3a91ce4..1d82fb6fffe5 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -1244,6 +1244,52 @@ static inline int folio_has_private(const struct folio *folio)
 	return !!(folio->flags & PAGE_FLAGS_PRIVATE);
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
+	struct folio *folio = ptdesc_folio(ptdesc);
+
+	folio_set_referenced(folio);
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
+	struct folio *folio = ptdesc_folio(ptdesc);
+
+	/*
+	 * Note: the 'PG_referenced' bit does not strictly need to be
+	 * cleared before freeing the page. But this is nice for
+	 * symmetry.
+	 */
+	folio_clear_referenced(folio);
+}
+
+/**
+ * ptdesc_test_kernel - Check if a ptdesc is used to map the kernel
+ * @ptdesc: The ptdesc being tested
+ *
+ * Call to tell if the ptdesc used to map the kernel.
+ */
+static inline bool ptdesc_test_kernel(struct ptdesc *ptdesc)
+{
+	struct folio *folio = ptdesc_folio(ptdesc);
+
+	return folio_test_referenced(folio);
+}
+
 #undef PF_ANY
 #undef PF_HEAD
 #undef PF_NO_TAIL
-- 
2.43.0

