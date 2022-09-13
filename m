Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7A766E8
	for <iommu@lists.linux.dev>; Tue, 13 Sep 2022 19:57:59 +0000 (UTC)
Received: by mail-qt1-f179.google.com with SMTP id z18so9605926qts.7
        for <iommu@lists.linux.dev>; Tue, 13 Sep 2022 12:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=rWqwJImtlBlKgE2e4HCMCjZ57hDnUIYZvYnGoYO3Ko0=;
        b=d2+jGtD0TKLMdHImIPIOFRc/CCsLBd1zTd7Z32acL/4ee7Q///DRfLAeWKVby8PAWE
         fgb6z8hXf1k5PM+mERKCcjYlhJUc7YcVmkzbKybhsAlNUjEqr+U7/BKoMqeCMB/HNIHI
         g9CIZx3cpM7r7QtrN3niww/63rwDZ4ABYIOm7CcpFGEgc/xw03gOtoM8VQgFq7CdtHOy
         PnM3xHgjGzGq4Cl6QAxH02OPTmRMVzFrDgXO8l6Rjf0jEf15sxaNGCsaRPE9K0g1rGX0
         Q9q2x8LOpIavofodITDiPKTwnIXo7FGcbxZ+dhF4xLlkpGof9K3nuM7AOF386w+Nu9xd
         TF4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=rWqwJImtlBlKgE2e4HCMCjZ57hDnUIYZvYnGoYO3Ko0=;
        b=zIqrkvssTx0nmORBkj2eiME6LmPMMoTVX0cSSjvmqRPdOhr4aeB/lxzMvW7YlRuCVg
         3Wx4aKkpEKqEqdQvm/NMJ1xxZ747ktlJUag0qAcI7rscVWvu5t26riG/1sLTMUzzRBtN
         OULwyzzywKEkJP8gU11OPkHxZc1Y3/TDdpf7NQJAuJc7j1tPaqQMyUvvt8WwNOgeFfQG
         P6ycbHfmXI+If8stgFMC/4Nfi+TJ0RELixx7xwurGZhoc2FE8c0HqSCYZhV30h4M8tzz
         ph3IdUz7Vai7MsE7oxifJojycBomUvDHBkIi2axM+KNG2R9qTgU8tlxQYeekCQn8taVK
         rERQ==
X-Gm-Message-State: ACgBeo3cjmnr/3RO7fCy+wvms1PfU4hQaysBu1x7LUWjO2UgfXTpbHEQ
	PNBN0flNqEeSOLb7xDyN8XQ=
X-Google-Smtp-Source: AA6agR5i53agCunM1nP5BNWdgMMXAxgKBBgHP+YifFsQRT8ONLZddir0hPCAFH311ymBKWli946Oxg==
X-Received: by 2002:a05:622a:40e:b0:343:7769:5895 with SMTP id n14-20020a05622a040e00b0034377695895mr30562094qtx.467.1663099078015;
        Tue, 13 Sep 2022 12:57:58 -0700 (PDT)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id s11-20020a05620a29cb00b006b8e049cf08sm276305qkp.2.2022.09.13.12.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 12:57:57 -0700 (PDT)
From: Doug Berger <opendmb@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <songmuchun@bytedance.com>,
	Mike Rapoport <rppt@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Borislav Petkov <bp@suse.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	Zi Yan <ziy@nvidia.com>,
	Oscar Salvador <osalvador@suse.de>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Kees Cook <keescook@chromium.org>,
	- <devicetree-spec@vger.kernel.org>,
	KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
	Mel Gorman <mgorman@suse.de>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mm@kvack.org,
	iommu@lists.linux.dev
Subject: [PATCH 01/21] mm/page_isolation: protect cma from isolate_single_pageblock
Date: Tue, 13 Sep 2022 12:54:48 -0700
Message-Id: <20220913195508.3511038-2-opendmb@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220913195508.3511038-1-opendmb@gmail.com>
References: <20220913195508.3511038-1-opendmb@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function set_migratetype_isolate() has special handling for
pageblocks of MIGRATE_CMA type that protects them from being
isolated for MIGRATE_MOVABLE requests.

Since isolate_single_pageblock() doesn't receive the migratetype
argument of start_isolate_page_range() it used the migratetype
of the pageblock instead of the requested migratetype which
defeats this MIGRATE_CMA check.

This allows an attempt to create a gigantic page within a CMA
region to change the migratetype of the first and last pageblocks
from MIGRATE_CMA to MIGRATE_MOVABLE when they are restored after
failure, which corrupts the CMA region.

The calls to (un)set_migratetype_isolate() for the first and last
pageblocks of the start_isolate_page_range() are moved back into
that function to allow access to its migratetype argument and make
it easier to see how all of the pageblocks in the range are
isolated.

Fixes: b2c9e2fbba32 ("mm: make alloc_contig_range work at pageblock granularity")
Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 mm/page_isolation.c | 75 +++++++++++++++++++++------------------------
 1 file changed, 35 insertions(+), 40 deletions(-)

diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 9d73dc38e3d7..8e16aa22cb61 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -286,8 +286,6 @@ __first_valid_page(unsigned long pfn, unsigned long nr_pages)
  * @flags:			isolation flags
  * @gfp_flags:			GFP flags used for migrating pages
  * @isolate_before:	isolate the pageblock before the boundary_pfn
- * @skip_isolation:	the flag to skip the pageblock isolation in second
- *			isolate_single_pageblock()
  *
  * Free and in-use pages can be as big as MAX_ORDER-1 and contain more than one
  * pageblock. When not all pageblocks within a page are isolated at the same
@@ -302,9 +300,8 @@ __first_valid_page(unsigned long pfn, unsigned long nr_pages)
  * the in-use page then splitting the free page.
  */
 static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
-			gfp_t gfp_flags, bool isolate_before, bool skip_isolation)
+			gfp_t gfp_flags, bool isolate_before)
 {
-	unsigned char saved_mt;
 	unsigned long start_pfn;
 	unsigned long isolate_pageblock;
 	unsigned long pfn;
@@ -328,18 +325,6 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
 	start_pfn  = max(ALIGN_DOWN(isolate_pageblock, MAX_ORDER_NR_PAGES),
 				      zone->zone_start_pfn);
 
-	saved_mt = get_pageblock_migratetype(pfn_to_page(isolate_pageblock));
-
-	if (skip_isolation)
-		VM_BUG_ON(!is_migrate_isolate(saved_mt));
-	else {
-		ret = set_migratetype_isolate(pfn_to_page(isolate_pageblock), saved_mt, flags,
-				isolate_pageblock, isolate_pageblock + pageblock_nr_pages);
-
-		if (ret)
-			return ret;
-	}
-
 	/*
 	 * Bail out early when the to-be-isolated pageblock does not form
 	 * a free or in-use page across boundary_pfn:
@@ -428,7 +413,7 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
 					ret = set_migratetype_isolate(page, page_mt,
 						flags, head_pfn, head_pfn + nr_pages);
 					if (ret)
-						goto failed;
+						return ret;
 				}
 
 				ret = __alloc_contig_migrate_range(&cc, head_pfn,
@@ -443,7 +428,7 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
 					unset_migratetype_isolate(page, page_mt);
 
 				if (ret)
-					goto failed;
+					return -EBUSY;
 				/*
 				 * reset pfn to the head of the free page, so
 				 * that the free page handling code above can split
@@ -459,24 +444,19 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
 				while (!PageBuddy(pfn_to_page(outer_pfn))) {
 					/* stop if we cannot find the free page */
 					if (++order >= MAX_ORDER)
-						goto failed;
+						return -EBUSY;
 					outer_pfn &= ~0UL << order;
 				}
 				pfn = outer_pfn;
 				continue;
 			} else
 #endif
-				goto failed;
+				return -EBUSY;
 		}
 
 		pfn++;
 	}
 	return 0;
-failed:
-	/* restore the original migratetype */
-	if (!skip_isolation)
-		unset_migratetype_isolate(pfn_to_page(isolate_pageblock), saved_mt);
-	return -EBUSY;
 }
 
 /**
@@ -534,21 +514,30 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
 	unsigned long isolate_start = ALIGN_DOWN(start_pfn, pageblock_nr_pages);
 	unsigned long isolate_end = ALIGN(end_pfn, pageblock_nr_pages);
 	int ret;
-	bool skip_isolation = false;
 
 	/* isolate [isolate_start, isolate_start + pageblock_nr_pages) pageblock */
-	ret = isolate_single_pageblock(isolate_start, flags, gfp_flags, false, skip_isolation);
+	ret = set_migratetype_isolate(pfn_to_page(isolate_start), migratetype,
+			flags, isolate_start, isolate_start + pageblock_nr_pages);
 	if (ret)
 		return ret;
-
-	if (isolate_start == isolate_end - pageblock_nr_pages)
-		skip_isolation = true;
+	ret = isolate_single_pageblock(isolate_start, flags, gfp_flags, false);
+	if (ret)
+		goto unset_start_block;
 
 	/* isolate [isolate_end - pageblock_nr_pages, isolate_end) pageblock */
-	ret = isolate_single_pageblock(isolate_end, flags, gfp_flags, true, skip_isolation);
+	pfn = isolate_end - pageblock_nr_pages;
+	if (isolate_start != pfn) {
+		ret = set_migratetype_isolate(pfn_to_page(pfn), migratetype,
+				flags, pfn, pfn + pageblock_nr_pages);
+		if (ret)
+			goto unset_start_block;
+	}
+	ret = isolate_single_pageblock(isolate_end, flags, gfp_flags, true);
 	if (ret) {
-		unset_migratetype_isolate(pfn_to_page(isolate_start), migratetype);
-		return ret;
+		if (isolate_start != pfn)
+			goto unset_end_block;
+		else
+			goto unset_start_block;
 	}
 
 	/* skip isolated pageblocks at the beginning and end */
@@ -557,15 +546,21 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
 	     pfn += pageblock_nr_pages) {
 		page = __first_valid_page(pfn, pageblock_nr_pages);
 		if (page && set_migratetype_isolate(page, migratetype, flags,
-					start_pfn, end_pfn)) {
-			undo_isolate_page_range(isolate_start, pfn, migratetype);
-			unset_migratetype_isolate(
-				pfn_to_page(isolate_end - pageblock_nr_pages),
-				migratetype);
-			return -EBUSY;
-		}
+					start_pfn, end_pfn))
+			goto unset_isolated_blocks;
 	}
 	return 0;
+
+unset_isolated_blocks:
+	ret = -EBUSY;
+	undo_isolate_page_range(isolate_start + pageblock_nr_pages, pfn,
+				migratetype);
+unset_end_block:
+	unset_migratetype_isolate(pfn_to_page(isolate_end - pageblock_nr_pages),
+				  migratetype);
+unset_start_block:
+	unset_migratetype_isolate(pfn_to_page(isolate_start), migratetype);
+	return ret;
 }
 
 /*
-- 
2.25.1

