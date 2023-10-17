Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D92430FB
	for <iommu@lists.linux.dev>; Tue, 17 Oct 2023 20:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TfJWvC4i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697574333; x=1729110333;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3Ad9kgdhE7qzJyM/s24lZCoX+Aafx5OUit4Dj7g+sn8=;
  b=TfJWvC4iQYYjFbNMIfKU/VKXObTvIG5n5AyBser9uxYsyxd+0aZLsS3k
   ZRgM2B9t+bq6GLCHfGPDTxRvnqp945SqwNbH2UvPojLPG7sJ/0k1kyRr0
   jBokC6Pc0EMMr3BC4Sa+tezyldQeVOclTMpK+zoILFz8+BUWLdZt2qWS4
   bmamddXzSNOPmiXUYvoHBh6a9uHc4zu4TIQt7GuNKxhEaFvhu/x7YK39Y
   5r08uCByUuZUTfqLW2/uSWU+wIRBhgfesrYAM2WIrSUoevCiZ71UISiyA
   nHtNUxfNJI+uzs0Lind/zRfdb+7Y36+7HJV351AKEDbGZk6euue8o2oGs
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="7429536"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="7429536"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 13:25:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="900040448"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="900040448"
Received: from rtdinh-mobl1.amr.corp.intel.com (HELO rpedgeco-desk4.intel.com) ([10.212.150.155])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 13:23:29 -0700
From: Rick Edgecombe <rick.p.edgecombe@intel.com>
To: x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	luto@kernel.org,
	peterz@infradead.org,
	kirill.shutemov@linux.intel.com,
	elena.reshetova@intel.com,
	isaku.yamahata@intel.com,
	seanjc@google.com,
	Michael Kelley <mikelley@microsoft.com>,
	thomas.lendacky@amd.com,
	decui@microsoft.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org
Cc: rick.p.edgecombe@intel.com,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev
Subject: [PATCH 04/10] swiotlb: Use free_decrypted_pages()
Date: Tue, 17 Oct 2023 13:24:59 -0700
Message-Id: <20231017202505.340906-5-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017202505.340906-1-rick.p.edgecombe@intel.com>
References: <20231017202505.340906-1-rick.p.edgecombe@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On TDX it is possible for the untrusted host to cause
set_memory_encrypted() or set_memory_decrypted() to fail such that an
error is returned and the resulting memory is shared. Callers need to take
care to handle these errors to avoid returning decrypted (shared) memory to
the page allocator, which could lead to functional or security issues.

Swiotlb could free decrypted/shared pages if set_memory_decrypted() fails.
Use the recently added free_decrypted_pages() to avoid this.

In swiotlb_exit(), check for set_memory_encrypted() errors manually,
because the pages are not nessarily going to the page allocator.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 kernel/dma/swiotlb.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 394494a6b1f3..ad06786c4f98 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -524,6 +524,7 @@ void __init swiotlb_exit(void)
 	unsigned long tbl_vaddr;
 	size_t tbl_size, slots_size;
 	unsigned int area_order;
+	int ret;
 
 	if (swiotlb_force_bounce)
 		return;
@@ -536,17 +537,19 @@ void __init swiotlb_exit(void)
 	tbl_size = PAGE_ALIGN(mem->end - mem->start);
 	slots_size = PAGE_ALIGN(array_size(sizeof(*mem->slots), mem->nslabs));
 
-	set_memory_encrypted(tbl_vaddr, tbl_size >> PAGE_SHIFT);
+	ret = set_memory_encrypted(tbl_vaddr, tbl_size >> PAGE_SHIFT);
 	if (mem->late_alloc) {
 		area_order = get_order(array_size(sizeof(*mem->areas),
 			mem->nareas));
 		free_pages((unsigned long)mem->areas, area_order);
-		free_pages(tbl_vaddr, get_order(tbl_size));
+		if (!ret)
+			free_pages(tbl_vaddr, get_order(tbl_size));
 		free_pages((unsigned long)mem->slots, get_order(slots_size));
 	} else {
 		memblock_free_late(__pa(mem->areas),
 			array_size(sizeof(*mem->areas), mem->nareas));
-		memblock_free_late(mem->start, tbl_size);
+		if (!ret)
+			memblock_free_late(mem->start, tbl_size);
 		memblock_free_late(__pa(mem->slots), slots_size);
 	}
 
@@ -581,7 +584,7 @@ static struct page *alloc_dma_pages(gfp_t gfp, size_t bytes)
 	return page;
 
 error:
-	__free_pages(page, order);
+	free_decrypted_pages((unsigned long)vaddr, order);
 	return NULL;
 }
 
-- 
2.34.1

