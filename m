Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0D2274B5F
	for <iommu@lists.linux.dev>; Fri,  5 Sep 2025 05:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757051604; cv=none; b=A28nYtZxov6kqO/EZg0Sl8ouW+RLUF19hRNkVT4VTYdA4LRlEtwENiX5ylWrD7TXX8QP9MEOhzvkFb+XHIxPgnwZUdF0wSjGETD7esc44YCZkOjkG0Zl/Ca3ZyaiiJ8KmWjfZlkoM+yUoIx6v2J3TC1N+gkcmlMyKuAvUgk+VCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757051604; c=relaxed/simple;
	bh=GYX9rMbG7jw0lb6wQwchmzz63c3QWvRMesttoXwPWoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g7heW50lr1MKWaQGLdXannJQXlGtxy3ZaDSkETExdzN5blZ2r7hVxBIv4kfZRUG2TmkAB8kbfUGfYz6mdEw3pSAZOGqWmsyM9mag+6Jh6MrkE2h2u9ZWl5z27b1ZPADidjMl+MZ+o9hSsibi4GKPalN59ZUKbfASa2xnMjFpOJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kdo/6clr; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kdo/6clr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757051603; x=1788587603;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GYX9rMbG7jw0lb6wQwchmzz63c3QWvRMesttoXwPWoU=;
  b=Kdo/6clrIz7byADfahcHod4CSo3qRSxf9iQceTep9zY3ZOV2dF92BO8O
   rFNNYBcLU0k7JybKvgA4lO7u5DYHxVJS76pWSCrFDFvlKKPyb+467Soyf
   YNBXiOKIhCDqZAhmKhfsz3vY+HsCNjEtiscGdKRT70qv6as5Qsc/X4wCC
   udtMHKImj1eEZTHbxOLFwz531csGIl0LLPBT/pW8y/MahI91lbQFgmnZQ
   0BZMuvk8k765IdWUvBcajV22dl+A5hmLAnmbqsi/p7l9AFg/X1O+1b3j0
   bJ3RhtpVZlXcU8rkxirZvfT8cVcrdjga4JugELJxq46mtZIfK6OQOjUwZ
   A==;
X-CSE-ConnectionGUID: Dgmnfh0rQGe5bNm/RhT2AQ==
X-CSE-MsgGUID: 8btOsVKYRr2Gw1/TBDV+NA==
X-IronPort-AV: E=McAfee;i="6800,10657,11543"; a="70015093"
X-IronPort-AV: E=Sophos;i="6.18,240,1751266800"; 
   d="scan'208";a="70015093"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 22:53:23 -0700
X-CSE-ConnectionGUID: 6jXvNGUvQ7O0gS6SvSoMDA==
X-CSE-MsgGUID: GVkJdZKWT3qzAVZ2QZkTMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,240,1751266800"; 
   d="scan'208";a="209257709"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa001.jf.intel.com with ESMTP; 04 Sep 2025 22:53:18 -0700
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
Subject: [PATCH v4 2/8] mm: Actually mark kernel page table pages
Date: Fri,  5 Sep 2025 13:50:57 +0800
Message-ID: <20250905055103.3821518-3-baolu.lu@linux.intel.com>
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

Now that the API is in place, mark kernel page table pages just
after they are allocated. Unmark them just before they are freed.

Note: Unconditionally clearing the 'kernel' marking (via
ptdesc_clear_kernel()) would be functionally identical to what
is here. But having the if() makes it logically clear that this
function can be used for kernel and non-kernel page tables.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/asm-generic/pgalloc.h | 18 ++++++++++++++++++
 include/linux/mm.h            |  3 +++
 2 files changed, 21 insertions(+)

diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
index 3c8ec3bfea44..b9d2a7c79b93 100644
--- a/include/asm-generic/pgalloc.h
+++ b/include/asm-generic/pgalloc.h
@@ -28,6 +28,8 @@ static inline pte_t *__pte_alloc_one_kernel_noprof(struct mm_struct *mm)
 		return NULL;
 	}
 
+	ptdesc_set_kernel(ptdesc);
+
 	return ptdesc_address(ptdesc);
 }
 #define __pte_alloc_one_kernel(...)	alloc_hooks(__pte_alloc_one_kernel_noprof(__VA_ARGS__))
@@ -146,6 +148,10 @@ static inline pmd_t *pmd_alloc_one_noprof(struct mm_struct *mm, unsigned long ad
 		pagetable_free(ptdesc);
 		return NULL;
 	}
+
+	if (mm == &init_mm)
+		ptdesc_set_kernel(ptdesc);
+
 	return ptdesc_address(ptdesc);
 }
 #define pmd_alloc_one(...)	alloc_hooks(pmd_alloc_one_noprof(__VA_ARGS__))
@@ -179,6 +185,10 @@ static inline pud_t *__pud_alloc_one_noprof(struct mm_struct *mm, unsigned long
 		return NULL;
 
 	pagetable_pud_ctor(ptdesc);
+
+	if (mm == &init_mm)
+		ptdesc_set_kernel(ptdesc);
+
 	return ptdesc_address(ptdesc);
 }
 #define __pud_alloc_one(...)	alloc_hooks(__pud_alloc_one_noprof(__VA_ARGS__))
@@ -233,6 +243,10 @@ static inline p4d_t *__p4d_alloc_one_noprof(struct mm_struct *mm, unsigned long
 		return NULL;
 
 	pagetable_p4d_ctor(ptdesc);
+
+	if (mm == &init_mm)
+		ptdesc_set_kernel(ptdesc);
+
 	return ptdesc_address(ptdesc);
 }
 #define __p4d_alloc_one(...)	alloc_hooks(__p4d_alloc_one_noprof(__VA_ARGS__))
@@ -277,6 +291,10 @@ static inline pgd_t *__pgd_alloc_noprof(struct mm_struct *mm, unsigned int order
 		return NULL;
 
 	pagetable_pgd_ctor(ptdesc);
+
+	if (mm == &init_mm)
+		ptdesc_set_kernel(ptdesc);
+
 	return ptdesc_address(ptdesc);
 }
 #define __pgd_alloc(...)	alloc_hooks(__pgd_alloc_noprof(__VA_ARGS__))
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1ae97a0b8ec7..f3db3a5ebefe 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2895,6 +2895,9 @@ static inline void pagetable_free(struct ptdesc *pt)
 {
 	struct page *page = ptdesc_page(pt);
 
+	if (ptdesc_test_kernel(pt))
+		ptdesc_clear_kernel(pt);
+
 	__free_pages(page, compound_order(page));
 }
 
-- 
2.43.0

