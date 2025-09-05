Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DE62741DF
	for <iommu@lists.linux.dev>; Fri,  5 Sep 2025 05:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757051601; cv=none; b=ChTUM83GqeF0yMXOtZ1MM1sPX7RuPsgIZyWkxGl1VVsKBtYmw17Ju9VPiTYv4S/+fspt4cs4khjOcF+FGJyGXRtGc5R23Qzg31/zb1SyUNqlm921/853JXzK2YgFRLRu/wACwO1t9105xjCRhMlwCCKz2IFlZMfQPFrIxJUh2Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757051601; c=relaxed/simple;
	bh=e07SUJfJdnVfwTtPizWKn8B7rgkmxlj3AGPVkk4pWN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ViMrveVDOZ/6xtDlVI+CQvjMwiq7rcpgTyGc9zm/h59iDH+FwZootT4sXbXUp9f3+VT85+h8ecHAxbWpZOA50xcf8EY/KXH2djVTwg1OR+MlN1xU0naGkNiZoIRTXn+RMDjiz9ZoaG1K0Gtoj/jrJwyM3aXK6h70oNLovZfl6bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n7YnCoKj; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n7YnCoKj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757051598; x=1788587598;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e07SUJfJdnVfwTtPizWKn8B7rgkmxlj3AGPVkk4pWN8=;
  b=n7YnCoKjyXlAAYRfxHx95l47io1BCJt1U8xg63BnGOCFIQXESWIcWo28
   rF5eSNfPIRsPWeAyr/pQdIGLz0LEh0GOPP085PItZFnPq6nZSX/ydh183
   RavH8Nm8RDCqPXWv8VNR/P32CbZ6QRLh/+h4zcxcY5NLS1I/1buTLEfCk
   XPDzmKbwwYcectvx8cCVNfoa3gxl6LVqsmZqTRlMdgyCdNOFPcXuZBLaN
   6jb34vLo7esyWX9m07A90VOhpSYgXv51s4ybA/qUyJWn4i0HqsEXbHOq9
   K8Ee67oGA9hkUKvhUGl1yyIc6NryfuiPRi/LMB3tFRuDmgMG0VShNEjg9
   Q==;
X-CSE-ConnectionGUID: IhVo8h2SRrOpwEbtAZ3tKA==
X-CSE-MsgGUID: cf4mkU43QrWi5p01di4nSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11543"; a="70015080"
X-IronPort-AV: E=Sophos;i="6.18,240,1751266800"; 
   d="scan'208";a="70015080"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 22:53:18 -0700
X-CSE-ConnectionGUID: 9hP1zDSlTCmSB37HRHReMw==
X-CSE-MsgGUID: UN/lG1XESRa+bkRZ5OzzJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,240,1751266800"; 
   d="scan'208";a="209257682"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa001.jf.intel.com with ESMTP; 04 Sep 2025 22:53:14 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Jann Horn <jannh@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Dave Hansen <dave.hansen@intel.com>,
	Alistair Popple <apopple@nvidia.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Andy Lutomirski <luto@kernel.org>,
	Yi Lai <yi1.lai@intel.com>
Cc: iommu@lists.linux.dev,
	security@kernel.org,
	linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v4 1/8] mm: Add a ptdesc flag to mark kernel page tables
Date: Fri,  5 Sep 2025 13:50:56 +0800
Message-ID: <20250905055103.3821518-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250905055103.3821518-1-baolu.lu@linux.intel.com>
References: <20250905055103.3821518-1-baolu.lu@linux.intel.com>
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
---
 include/linux/page-flags.h | 51 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 8d3fa3a91ce4..d1a9ee0a5337 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -1244,6 +1244,57 @@ static inline int folio_has_private(const struct folio *folio)
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
+	/*
+	 * Note: the 'PG_referenced' bit does not strictly need to be
+	 * tested before freeing the page. But this is nice for
+	 * symmetry.
+	 */
+	return folio_test_referenced(folio);
+}
+
 #undef PF_ANY
 #undef PF_HEAD
 #undef PF_NO_TAIL
-- 
2.43.0

