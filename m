Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73AC278157
	for <iommu@lists.linux.dev>; Fri,  5 Sep 2025 05:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757051617; cv=none; b=sfIJhG6LPGMJI6g7eC2lHMwvMNpCBuF4EmTYWbl41kNrY85xN7k38liKIT982Flj/Pf0oFfnhNivuWFSn/9xBkwhPYRNRGiNL85zfaR1DLF4k+pV9LBfMPqhMAIcYVIW2hpeI+rHwaACCMgOQho0DrE2fb4lHdME+RXVEXYrbyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757051617; c=relaxed/simple;
	bh=+XAsHeukGK9OIWcEZcHNVxSvXx74vf0ur4G/6vU4Z/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n9frIdgdpguSVv01d19mkXcgi+p2TKsUI1JVmEu1Lqc8YP74uI+GSIueWTH21oMm81VqDvdtkmYgIuD+TEjZn/s0Y4mPfxKR83SQOM3g/KUIpeoXSd9Gy1HH8uP66enGeLvMYzUWXIdL3oUiFw5fxtxMOR4gxPlB2LsuofIxwIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VrhyUMWA; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VrhyUMWA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757051616; x=1788587616;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+XAsHeukGK9OIWcEZcHNVxSvXx74vf0ur4G/6vU4Z/U=;
  b=VrhyUMWAGc0mpvnO37jbK4pIzrgOg36Hjh9uypn2ymX65JCkdjNSKcjm
   y6dQFGrkEoYjzbT14t5uJ2KMF0IU0all/naYgRBwGKKxbe3fMlHNhJP94
   VKqp2myrh5gf5dymQm+DSdHeZfdpy+ZY+oesOgWOWezU4Ks/gx0rWUle0
   G/jC+yJrS/9s2VIavJfZj4qyGNTvPXG0Vn+dOTyfHIZc/+mRVBEYGco5i
   OgrLkWL3hSJ8WHes3ndVgPSJjA23Hoh4KESHmb2NOeGICUFYPSavDRy+p
   4gdBIpzIJt8+jDkMcjH4trqLfNuSPg/xgbgrQOiagb/FN+3rMQ9YYuYj8
   Q==;
X-CSE-ConnectionGUID: 7W+xuZk/QbyChbp1zgsMjA==
X-CSE-MsgGUID: CG/QGi92RWqRjNLze5M0xQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11543"; a="70015134"
X-IronPort-AV: E=Sophos;i="6.18,240,1751266800"; 
   d="scan'208";a="70015134"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 22:53:35 -0700
X-CSE-ConnectionGUID: pMYWhTUvQQumhEPGmdUQyw==
X-CSE-MsgGUID: RzLoRVOzQuyOeXqB7zySfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,240,1751266800"; 
   d="scan'208";a="209257747"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa001.jf.intel.com with ESMTP; 04 Sep 2025 22:53:32 -0700
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
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v4 5/8] x86/mm: Use pagetable_free()
Date: Fri,  5 Sep 2025 13:51:00 +0800
Message-ID: <20250905055103.3821518-6-baolu.lu@linux.intel.com>
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
index 76e33bd7c556..86b4297c1984 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1013,7 +1013,7 @@ static void __meminit free_pagetable(struct page *page, int order)
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

