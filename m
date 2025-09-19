Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100262566F2
	for <iommu@lists.linux.dev>; Fri, 19 Sep 2025 05:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758260566; cv=none; b=ceHGy9rXkqiPMxd61zPujcLbILoEnmJscnictSZffhUzCpwW19+Q6aJCCkv61+YAt/mEw0k7xZf1pv2ngYpaUfmer3jRXJpvBPMetqfIsmftbBpoWrrwbAKNhj2uU1KH2XR5s4J8ThUvKmerVYBHZvvsy06z70XASZAuIXcwrPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758260566; c=relaxed/simple;
	bh=Dg5FMFxijPdUqcW/Tef7765KtNVvQQKVcrGVoDEOYaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AkNxiBcGoRD+TU5XaeElPayxYii/wSV05VVCsURP1dAnt8SICKV+KYYAlxzH+WcO4IxLn15LpZoIjNDNL6Yfy2mr9a4/iI1fl1gTM0dGsJv9XvAq1Mj7zQ8Ozei3EkIhDJUhu6YYwWsyXAjvyeNJBaLIJuxd28LVWwqKLXB4KlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EDCbuFfg; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EDCbuFfg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758260565; x=1789796565;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Dg5FMFxijPdUqcW/Tef7765KtNVvQQKVcrGVoDEOYaA=;
  b=EDCbuFfgNGumufU3ql2fYJprgEfZYQPQyfeHuI5b6NMmARcwdmnOjRyv
   UJmkj4iYIMeluA3QmIva3uHzt9/Vtb+4oRLF/W0TcgqGjmTb32ElzkCpD
   Ap5v20eQsCmwIuuTXzAkabVhNkuVo88/p2XiVu0m3Lg0K+9/3JyBBjLrq
   caE7yFaUGagK3cKFFxD4eWyUSQAVSN5Dlf3XnSI4YnZaqLJ0ozB8hOIFN
   O9XDNhcVwE7+mmwMuW6Quqa9k/+dLYGgRpwK/GF663gZfYNkHBA1Cxxn0
   7LNDwaa/lnhNEswDPgeFna+SFk2VBTT8L8C/Qwh0AMwc8kxCmu6dSTAte
   A==;
X-CSE-ConnectionGUID: nIgf9VVjTdSLb31jFHPFiw==
X-CSE-MsgGUID: /JK2ZUVASwW6SV7go1FbiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="63235754"
X-IronPort-AV: E=Sophos;i="6.18,277,1751266800"; 
   d="scan'208";a="63235754"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 22:42:45 -0700
X-CSE-ConnectionGUID: oGGKEl6tSHuZAt92ENdozg==
X-CSE-MsgGUID: ogkZWCFtQg6LavjO4eounQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,277,1751266800"; 
   d="scan'208";a="180858596"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa005.jf.intel.com with ESMTP; 18 Sep 2025 22:42:38 -0700
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
Subject: [PATCH v5 2/8] mm: Actually mark kernel page table pages
Date: Fri, 19 Sep 2025 13:40:00 +0800
Message-ID: <20250919054007.472493-3-baolu.lu@linux.intel.com>
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

