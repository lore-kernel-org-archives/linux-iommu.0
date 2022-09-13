Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4887866E8
	for <iommu@lists.linux.dev>; Tue, 13 Sep 2022 19:58:10 +0000 (UTC)
Received: by mail-qk1-f179.google.com with SMTP id h28so9342517qka.0
        for <iommu@lists.linux.dev>; Tue, 13 Sep 2022 12:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=yHgeZ0+Ocv6GrFoaruOXhrYrRwLmKzzR+EPUoXoCFLk=;
        b=MO7TGhjFAweThFGVYteWrV+nJ7j5y3LZRa4C7ACnJ1qWyIG54wf5kg5kO3xvw/FqDQ
         s4wKsy9yFNOEBO191kejMvdr64z7Q9PD3aPBFXDJT69Mpap/Qm7BagM/tmOC2sbVk5Ek
         f646vwKxfSqOitl6VKXJ3CuYfAma7EN7IglgyNYbVTkgDe6A8Ejr2VK5Z6ft+DXrx+l4
         fQRhw7+DxWu3uXxtthnmrlFhvdM2zwLPoqSspHMHQaTzl30h2Y5TuDS9T3a1oeXGiuia
         JD/Wvi1/kbP+I5YXUEfkPCFyR+Q73ACUQMRNqUffeivDuZhRpUvnXKzfC7RG3PK+ZTef
         LsyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=yHgeZ0+Ocv6GrFoaruOXhrYrRwLmKzzR+EPUoXoCFLk=;
        b=wsfhqBOZykcCqyP4xCCLSVB2QuKGXxcjZtGXRdrRqEaafQa5mAJDrOQz275F7ZT0/G
         VyfWup9srbqbb9tfcEfprAOAKjd51dqMtIQJnRvOF28MdPtisEsaCLp2sMp+jqGOEHKe
         cL6yP4pkw3naEPfjcbxwAmhjvHImu88u1b9sdBzyguI8PEHmF7SXxkG6TTWOZWohk50B
         l5tG0q+3mqOEKg8HbNUDKOXYjIxroNzz/IXfwsKf5fWOfIbDRGFbdiPzrBqU7Nebc3y2
         yTmBkkIg5PGu2gJyVdwR1N7jgeBNKgddAZKwySB4CgK3Hs4cvIq1L8PMezWb91LBOKtg
         r3vw==
X-Gm-Message-State: ACgBeo0MiutFnFT69idcVRhlj7U66oUVPBgteIFEeKI/YkLMG5Dl0QPb
	px/sakVaAIRhQozVDz6OVXuOsY1S094=
X-Google-Smtp-Source: AA6agR5MEfLRKDjJcxpoJCjM2jEAW8H06DRSio04kdGXrEcQ2RvULscAsN8q5RMRJ4UP1SunQTdfRQ==
X-Received: by 2002:a05:620a:488f:b0:6ce:634e:8963 with SMTP id ea15-20020a05620a488f00b006ce634e8963mr3462100qkb.16.1663099089149;
        Tue, 13 Sep 2022 12:58:09 -0700 (PDT)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id s11-20020a05620a29cb00b006b8e049cf08sm276305qkp.2.2022.09.13.12.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 12:58:08 -0700 (PDT)
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
Subject: [PATCH 04/21] mm/hugetlb: refactor alloc_and_dissolve_huge_page
Date: Tue, 13 Sep 2022 12:54:51 -0700
Message-Id: <20220913195508.3511038-5-opendmb@gmail.com>
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

The alloc_replacement_page() and replace_hugepage() functions are
created from code in the alloc_and_dissolve_huge_page() function
to allow their reuse by the next commit.

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 mm/hugetlb.c | 84 +++++++++++++++++++++++++++++++---------------------
 1 file changed, 51 insertions(+), 33 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a1d51a1f0404..f232a37df4b6 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2709,32 +2709,22 @@ void restore_reserve_on_error(struct hstate *h, struct vm_area_struct *vma,
 }
 
 /*
- * alloc_and_dissolve_huge_page - Allocate a new page and dissolve the old one
- * @h: struct hstate old page belongs to
- * @old_page: Old page to dissolve
- * @list: List to isolate the page in case we need to
- * Returns 0 on success, otherwise negated error.
+ * Before dissolving the page, we need to allocate a new one for the
+ * pool to remain stable.  Here, we allocate the page and 'prep' it
+ * by doing everything but actually updating counters and adding to
+ * the pool.  This simplifies and let us do most of the processing
+ * under the lock.
  */
-static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
-					struct list_head *list)
+static struct page *alloc_replacement_page(struct hstate *h, int nid)
 {
 	gfp_t gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
-	int nid = page_to_nid(old_page);
 	bool alloc_retry = false;
 	struct page *new_page;
-	int ret = 0;
 
-	/*
-	 * Before dissolving the page, we need to allocate a new one for the
-	 * pool to remain stable.  Here, we allocate the page and 'prep' it
-	 * by doing everything but actually updating counters and adding to
-	 * the pool.  This simplifies and let us do most of the processing
-	 * under the lock.
-	 */
 alloc_retry:
 	new_page = alloc_buddy_huge_page(h, gfp_mask, nid, NULL, NULL);
 	if (!new_page)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 	/*
 	 * If all goes well, this page will be directly added to the free
 	 * list in the pool.  For this the ref count needs to be zero.
@@ -2748,7 +2738,7 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
 	SetHPageTemporary(new_page);
 	if (!put_page_testzero(new_page)) {
 		if (alloc_retry)
-			return -EBUSY;
+			return ERR_PTR(-EBUSY);
 
 		alloc_retry = true;
 		goto alloc_retry;
@@ -2757,6 +2747,48 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
 
 	__prep_new_huge_page(h, new_page);
 
+	return new_page;
+}
+
+static void replace_hugepage(struct hstate *h, int nid, struct page *old_page,
+			     struct page *new_page)
+{
+	lockdep_assert_held(&hugetlb_lock);
+	/*
+	 * Ok, old_page is still a genuine free hugepage. Remove it from
+	 * the freelist and decrease the counters. These will be
+	 * incremented again when calling __prep_account_new_huge_page()
+	 * and enqueue_huge_page() for new_page. The counters will remain
+	 * stable since this happens under the lock.
+	 */
+	remove_hugetlb_page(h, old_page, false);
+
+	/*
+	 * Ref count on new page is already zero as it was dropped
+	 * earlier.  It can be directly added to the pool free list.
+	 */
+	__prep_account_new_huge_page(h, nid);
+	enqueue_huge_page(h, new_page);
+}
+
+/*
+ * alloc_and_dissolve_huge_page - Allocate a new page and dissolve the old one
+ * @h: struct hstate old page belongs to
+ * @old_page: Old page to dissolve
+ * @list: List to isolate the page in case we need to
+ * Returns 0 on success, otherwise negated error.
+ */
+static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
+					struct list_head *list)
+{
+	int nid = page_to_nid(old_page);
+	struct page *new_page;
+	int ret = 0;
+
+	new_page = alloc_replacement_page(h, nid);
+	if (IS_ERR(new_page))
+		return PTR_ERR(new_page);
+
 retry:
 	spin_lock_irq(&hugetlb_lock);
 	if (!PageHuge(old_page)) {
@@ -2783,21 +2815,7 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
 		cond_resched();
 		goto retry;
 	} else {
-		/*
-		 * Ok, old_page is still a genuine free hugepage. Remove it from
-		 * the freelist and decrease the counters. These will be
-		 * incremented again when calling __prep_account_new_huge_page()
-		 * and enqueue_huge_page() for new_page. The counters will remain
-		 * stable since this happens under the lock.
-		 */
-		remove_hugetlb_page(h, old_page, false);
-
-		/*
-		 * Ref count on new page is already zero as it was dropped
-		 * earlier.  It can be directly added to the pool free list.
-		 */
-		__prep_account_new_huge_page(h, nid);
-		enqueue_huge_page(h, new_page);
+		replace_hugepage(h, nid, old_page, new_page);
 
 		/*
 		 * Pages have been replaced, we can safely free the old one.
-- 
2.25.1

