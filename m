Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C57130BB9A
	for <iommu@lists.linux.dev>; Wed, 22 Oct 2025 08:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761121795; cv=none; b=sy4yniIC8Ya+E63qq7df5HfioHJJuBbVdByzpvNWmjcQVsj4ZiEEow9qrc93HLM8SwWF+hu9cu2Zn0lzT8zDT2hofYcVFkg3j+bC2tMnQu5XsqiRkFcHfpH4oHKur2Y5xzyXIYsaf7+QwWJ0eq348jj+igJV/+aD7AcDtNmPZ34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761121795; c=relaxed/simple;
	bh=UdXEkbwZwh7s3Ab/yIsSNM8JqfKTQQu6KsOh09Fx8rY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IzQrytikEcJahW1VjbHwGeSV2ON9lQbeXFK3E5oimrh4hRQ1DpLJ9Z4/hcoKnuMgBvpUvE4drDyqxV09lypjTfk643nNTIFA6yPUY6R2PL0zLf6+8AMTo7C4nwefzARq2TQgGVQsfaOSkXb9PvM2I1jigx6QwV9oM0TCYH76KFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mLnwmAlf; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mLnwmAlf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761121794; x=1792657794;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UdXEkbwZwh7s3Ab/yIsSNM8JqfKTQQu6KsOh09Fx8rY=;
  b=mLnwmAlfAGbkTWmIvBxC3hqNIilGGKo0e2aW8w//hGXbn4PTbjwibYww
   JwX2o6my/mT7b8LMFzBm6ssirFf0pWXfZylhZ3ykU2fiLhTPN1G1tQKuH
   nppHMYrSHXVuqlyOtwlHSy/754U/FBcOF2Lv/SO8KXJtaTpJCe5HrH9O0
   vBD15ZPDGPzhAM0cnptlHTvupItWBsc4wIksVDA3kYAY229cxBcVltVRQ
   RzKTWQgQun5Le4g4KCaMQkEyTHHeinaiP6ILVHPcLnOxAoIxHUFZ0paoL
   WNYJKpaeGZxAAXuM3WmjwIkgCn0kxUqsvj+3C0t152dsJiWTED8Q7+Awp
   g==;
X-CSE-ConnectionGUID: rkmVYFGJQAqxIGr5YEW1Ng==
X-CSE-MsgGUID: yfIikf1tSr6J6+OuD0SJXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="65879192"
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="65879192"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 01:29:53 -0700
X-CSE-ConnectionGUID: xpCywqjkQey1za499pJiyQ==
X-CSE-MsgGUID: sVb55JoAQ0aCTSAQaUEdMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="183516428"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa007.fm.intel.com with ESMTP; 22 Oct 2025 01:29:47 -0700
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
	Matthew Wilcox <willy@infradead.org>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: iommu@lists.linux.dev,
	security@kernel.org,
	x86@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v7 6/8] x86/mm: Use pagetable_free()
Date: Wed, 22 Oct 2025 16:26:32 +0800
Message-ID: <20251022082635.2462433-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251022082635.2462433-1-baolu.lu@linux.intel.com>
References: <20251022082635.2462433-1-baolu.lu@linux.intel.com>
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
index 970981893c9b..fffb6ef1997d 100644
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

