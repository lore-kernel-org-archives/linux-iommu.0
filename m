Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A66C4310F
	for <iommu@lists.linux.dev>; Tue, 17 Oct 2023 20:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="flntSAA2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697574336; x=1729110336;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1KnITalfSoEUJepIi5EFi3cXKWjkojf3kZ3un2NNboE=;
  b=flntSAA2vpFRJBmVhR/ZoPr3Xbm37Y1i9XK2W0yfxjIXlMlcMw2tmXku
   FvDV5OE4Vuzi4ZCxyaD18lKpATzY2oKuFRR5L/QgwmiibQI1rZ6BWHMtr
   WkPAxBlBjBuAbpIlhCS54pUEYJCDgPfLk54/Cvs8xAYf0UopKg4hcyuOd
   VLdffWjqgnWkg+MyKysUrehbKpNySh+Hypi7eMI+8oOz6N6FBUBk0SZCx
   OUJYXhPk2ENTEY06pX5U6NAKfO/VasmcGv2PH/0gvmF/oMIJTXNowWM70
   53hqFbF9j3HUZ2rKMDTGKEYwKvY2er2B2cvN/yaWIA/7UY2bf9ELu5pe+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="7429561"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="7429561"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 13:25:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="900040460"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="900040460"
Received: from rtdinh-mobl1.amr.corp.intel.com (HELO rpedgeco-desk4.intel.com) ([10.212.150.155])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 13:23:31 -0700
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
Subject: [PATCH 06/10] dma: Use free_decrypted_pages()
Date: Tue, 17 Oct 2023 13:25:01 -0700
Message-Id: <20231017202505.340906-7-rick.p.edgecombe@intel.com>
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

DMA could free decrypted/shared pages if set_memory_decrypted() fails.
Use the recently added free_decrypted_pages() to avoid this.

Several paths also result in proper encrypted pages being freed through
the same freeing function. Rely on free_decrypted_pages() to not leak the
memory in these cases.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 include/linux/dma-map-ops.h | 3 ++-
 kernel/dma/contiguous.c     | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index f2fc203fb8a1..b0800cbbc357 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -9,6 +9,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/pgtable.h>
 #include <linux/slab.h>
+#include <linux/set_memory.h>
 
 struct cma;
 
@@ -165,7 +166,7 @@ static inline struct page *dma_alloc_contiguous(struct device *dev, size_t size,
 static inline void dma_free_contiguous(struct device *dev, struct page *page,
 		size_t size)
 {
-	__free_pages(page, get_order(size));
+	free_decrypted_pages((unsigned long)page_address(page), get_order(size));
 }
 #endif /* CONFIG_DMA_CMA*/
 
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index f005c66f378c..e962f1f6434e 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -429,7 +429,7 @@ void dma_free_contiguous(struct device *dev, struct page *page, size_t size)
 	}
 
 	/* not in any cma, free from buddy */
-	__free_pages(page, get_order(size));
+	free_decrypted_pages((unsigned long)page_address(page), get_order(size));
 }
 
 /*
-- 
2.34.1

