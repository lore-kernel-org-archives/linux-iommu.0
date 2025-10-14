Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD03F3191B9
	for <iommu@lists.linux.dev>; Tue, 14 Oct 2025 13:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760447290; cv=none; b=jesXUKTZHC+P+QJ+FSe3TJdajgwRBxhi8SpZjt9IfmVvfVO0zET+8PUBQBaOa4/Ho50DkvWXTXOqHDnpgxs4VnT5HR39QSmoa66eaOdM7uoMuP+jju4Z9N7qGlTDfDQX9wP6wUVbUzPg7EKGPmkwJ2qlcZqed36QVY1esbONCbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760447290; c=relaxed/simple;
	bh=J/aPVU8JbHxYyfCDcj6K7oo52RWRfEFFerOeOF+XTLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oa9K74Mm4JVHKApTuf4gn4ir6RXaKUNalc81GgTCB4oBl5VRWnlW/yroYC7WG6uIOAkJgNvOld0Nu+V9WEQpCNyQ4wegxNzDxu5WZa31MoeGYnfjeLQY9hCPCt/0iuc79RWY3oZnbFPjjvL3xyske26oC0Bn2Cj/b02vG5al32U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VNkm00sP; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VNkm00sP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760447289; x=1791983289;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J/aPVU8JbHxYyfCDcj6K7oo52RWRfEFFerOeOF+XTLA=;
  b=VNkm00sPePEO5N2FG5aumjNhn063mYe5ozdBJWOgu9OVmrZjYONhKxdV
   SVvBUhtIAuUeu1zYST936f5Hf0Mjyco60aMBlM51JEAksX615TI9RaLaX
   jUepn0S6bIyyrQ9npWm55EbSHOKijU4bmk4O7x/CF+LGWIInpb6x8gesF
   I3oxlT74EBvL3QVMo7Qf6mUVYd1bd9jdIso1d1mER3fbscVm8XYHJbDCy
   3b0owD+UDh9CAylfrg99plD+sF9uUioZ8BOFjbMcovFRDkEsqEMi5NW0x
   0cTsV+zwwUpF5fnLD9uQG8TVD5zh0dhVehXWUL0gyVn+PNYn9Mg1UyHEf
   w==;
X-CSE-ConnectionGUID: PTSTnHseRwuyLS5j7dU+PQ==
X-CSE-MsgGUID: PybM5VYvTNCBUE+EJFYYLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62515442"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62515442"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 06:08:07 -0700
X-CSE-ConnectionGUID: EIHOS615R1+i2QYo8Z03rQ==
X-CSE-MsgGUID: UH1eyTeURm+UWSuYvSl9nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; 
   d="scan'208";a="182675673"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa010.fm.intel.com with ESMTP; 14 Oct 2025 06:07:59 -0700
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
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v6 5/7] x86/mm: Use pagetable_free()
Date: Tue, 14 Oct 2025 21:04:35 +0800
Message-ID: <20251014130437.1090448-6-baolu.lu@linux.intel.com>
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

The kernel's memory management subsystem provides a dedicated interface,
pagetable_free(), for freeing page table pages. Updates two call sites to
use pagetable_free() instead of the lower-level __free_page() or
free_pages(). This improves code consistency and clarity, and ensures the
correct freeing mechanism is used.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/x86/mm/init_64.c        | 2 +-
 arch/x86/mm/pat/set_memory.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 0e4270e20fad..3d9a5e4ccaa4 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1031,7 +1031,7 @@ static void __meminit free_pagetable(struct page *page, int order)
 		free_reserved_pages(page, nr_pages);
 #endif
 	} else {
-		__free_pages(page, order);
+		pagetable_free(page_ptdesc(page));
 	}
 }
 
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index d2d54b8c4dbb..4366e7d11afd 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -429,7 +429,7 @@ static void cpa_collapse_large_pages(struct cpa_data *cpa)
 
 	list_for_each_entry_safe(ptdesc, tmp, &pgtables, pt_list) {
 		list_del(&ptdesc->pt_list);
-		__free_page(ptdesc_page(ptdesc));
+		pagetable_free(ptdesc);
 	}
 }
 
-- 
2.43.0

