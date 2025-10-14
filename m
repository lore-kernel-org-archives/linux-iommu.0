Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F9931618A
	for <iommu@lists.linux.dev>; Tue, 14 Oct 2025 13:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760447264; cv=none; b=SGqeAvAX72PMWscu/k/WU6Ywv+FguXKDaTLizk0wpJ75arZ6p4ix2gdispBzTv4OZQMjrN7/LdtIVDWP/gBKyJnfqXIStnXP1b1LAgg3IzJfAHAbmlJ02hPCtmPZxd3KbEhl2+FpXG0UK7Hyb5pKo055g5samoiPSl5hohxqCAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760447264; c=relaxed/simple;
	bh=lfUFBXUxo+w4vJ46hfUjKQJDAze+72p1E8gLDcEic/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oeN3M2ZXaTKbLP7T3ghO0JH0hpNWE4hA4jvtmzVqtE7D0cszFLjWGqd+jC/B1PRS4x3posSXWaTn0VVpLqg6sgwIk6HxRUd2z2yhO/mN/kjyaxBlxqe1S8Cc1j5PfS30RZzgTZu5+aoQEHBiI8RgXvw544cKDJ50WcGDJaSc2M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=emHwBVz8; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="emHwBVz8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760447263; x=1791983263;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lfUFBXUxo+w4vJ46hfUjKQJDAze+72p1E8gLDcEic/g=;
  b=emHwBVz8h4pPFbCol/v7IQM2wzOC+SfrVWgFhfx4X++aaOEcrMn22gED
   SnxJ04tSL2VkKuamDR92y5P510fSKJBkM6Iehr3hkZaUGQ2YMTtgSf6iD
   A9IwU06nfc5KrBk4/t/nz1PEXA7hN6F0RV/pT8Hu8tGFghirtqgigUibe
   E5BbNUvmJgXOBzsL14+uKOWpx/urAf2y44b3kBYchqKP9GStJJhFd3Ed7
   E1QLHY0Nbn+t6hcxNpWZPAIiNMbi4XSorc0cfeN6T7p+j97ZwFITwoU9P
   23vbF+/IUzIOW7M1sH616lxTxrmMf5+wQpuEp8rSvuUtOVpcCWy6UrP+T
   g==;
X-CSE-ConnectionGUID: Gc+BVEBZRkWxyVZzBib3Og==
X-CSE-MsgGUID: whXncrC0Ra+9RAbTCtbVCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62515359"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62515359"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 06:07:43 -0700
X-CSE-ConnectionGUID: fEakTVjhQOicHC7aB8RVkQ==
X-CSE-MsgGUID: Aj7IYaXoRgOL4s+gZknpVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; 
   d="scan'208";a="182675578"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa010.fm.intel.com with ESMTP; 14 Oct 2025 06:07:32 -0700
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
	Matthew Wilcox <willy@infradead.org>
Cc: iommu@lists.linux.dev,
	security@kernel.org,
	x86@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v6 2/7] mm: Actually mark kernel page table pages
Date: Tue, 14 Oct 2025 21:04:32 +0800
Message-ID: <20251014130437.1090448-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251014130437.1090448-1-baolu.lu@linux.intel.com>
References: <20251014130437.1090448-1-baolu.lu@linux.intel.com>
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
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
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
index 9741affc574e..15ce0c415d36 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3035,6 +3035,9 @@ static inline void pagetable_free(struct ptdesc *pt)
 {
 	struct page *page = ptdesc_page(pt);
 
+	if (ptdesc_test_kernel(pt))
+		ptdesc_clear_kernel(pt);
+
 	__free_pages(page, compound_order(page));
 }
 
-- 
2.43.0

