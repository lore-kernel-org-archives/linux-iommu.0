Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704C2258ECE
	for <iommu@lists.linux.dev>; Fri, 19 Sep 2025 05:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758260583; cv=none; b=ZbyGJ3CmQ+nfvns5Q6YOn34+nWE4ArB0pOS2rWnhIv0vvDq9HQGI4hRUDys0gB1zDY6FtRc/t58gfp5GpEN0IO74EhqqqJqJ0ZfE9ghkFSpjB1SaCqW9GxVtxMlYbxLKgBFO+V3W6OgmY/Ie/RQi4jdxQd0vMdMcQRc+hJFJLrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758260583; c=relaxed/simple;
	bh=nrilrx2mPA3TWSSuztVQs7qAYj2QPgzZaCIBERNxtEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aoeZ6AnGg8jgpPsWcMm/x9Be0hutbT+/dk/hlZARQTTj2MmuUowiC4GczciWYhK8v24NXX+fWUkiiOPHoJxCn1aqgsqnp0ZJLMMl/DR5sswk1Qn3/duvH0e/ZgSiF9Y4uy7tKVPa9d5vksN+dTJTcH9vbEeRbdZ8fE578ZkGET8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jyG5ydIX; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jyG5ydIX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758260582; x=1789796582;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nrilrx2mPA3TWSSuztVQs7qAYj2QPgzZaCIBERNxtEw=;
  b=jyG5ydIXexyg+wkl/hak0AY4KnHY9hoOfNs31I7PHvfvVJtq43ou+Icp
   OX1gFUUWXG0+v2iZbekUc6R8oVbr9PX22kWi77F0dpwBbxawNziwt92Qr
   Thsvyfg0MHpPVNA2JgbkpFNTS5D0na79wj88dzaO7bRUxCFEB+kFiE7uU
   oQMAscFT16pCyBypVidW5CriL4uEhr2DyVexcPo+852BfRtXWCyCzfwqq
   mhak8SUEA0MixuzK/AIXf2pZ5NOhbf6W/Ek/ojUUUvEj197Hi3raqJlI9
   6sQTgsreuUMnRKKslwaghLSQ9LISksruSYDoParoCi5shMIowGtudfd8O
   Q==;
X-CSE-ConnectionGUID: E4eC25tLS6uBsoYyKNIhQA==
X-CSE-MsgGUID: 7bRBqZFrT3KlWK5w+Fq+BQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="63235807"
X-IronPort-AV: E=Sophos;i="6.18,277,1751266800"; 
   d="scan'208";a="63235807"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 22:43:01 -0700
X-CSE-ConnectionGUID: 8Qvwh1+/T8iwkFdtVSsN2A==
X-CSE-MsgGUID: wx26YAthRpau1H2H4cvuHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,277,1751266800"; 
   d="scan'208";a="180858706"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa005.jf.intel.com with ESMTP; 18 Sep 2025 22:42:55 -0700
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
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v5 5/8] x86/mm: Use pagetable_free()
Date: Fri, 19 Sep 2025 13:40:03 +0800
Message-ID: <20250919054007.472493-6-baolu.lu@linux.intel.com>
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

The kernel's memory management subsystem provides a dedicated interface,
pagetable_free(), for freeing page table pages. Updates two call sites to
use pagetable_free() instead of the lower-level __free_page() or
free_pages(). This improves code consistency and clarity, and ensures the
correct freeing mechanism is used.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 arch/x86/mm/init_64.c        | 2 +-
 arch/x86/mm/pat/set_memory.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index b9426fce5f3e..3d9a5e4ccaa4 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1031,7 +1031,7 @@ static void __meminit free_pagetable(struct page *page, int order)
 		free_reserved_pages(page, nr_pages);
 #endif
 	} else {
-		free_pages((unsigned long)page_address(page), order);
+		pagetable_free(page_ptdesc(page));
 	}
 }
 
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 8834c76f91c9..8b78a8855024 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -438,7 +438,7 @@ static void cpa_collapse_large_pages(struct cpa_data *cpa)
 
 	list_for_each_entry_safe(ptdesc, tmp, &pgtables, pt_list) {
 		list_del(&ptdesc->pt_list);
-		__free_page(ptdesc_page(ptdesc));
+		pagetable_free(ptdesc);
 	}
 }
 
-- 
2.43.0

