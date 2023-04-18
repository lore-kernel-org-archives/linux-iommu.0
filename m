Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482821C02
	for <iommu@lists.linux.dev>; Tue, 18 Apr 2023 15:49:10 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-3f1763ee8f8so10348115e9.1
        for <iommu@lists.linux.dev>; Tue, 18 Apr 2023 08:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681832948; x=1684424948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NPDSA+x4oz9imX3uiByE603i/j50qlmE+SnCawov5Gk=;
        b=J+hC8F71kco8Juht/1xZ6HvwdaZ1yKC/66ZDQkDWwb6JRvwGxhNRTSXnHHz42bMO25
         DmuRwo9hXxa4Kcc+fn0Bc7/oB557sS2XTIiHyGcE56cNznhhujRB3aVvEU0i/VqEHHSN
         4QQBvP+edSPhv2Q/URS3BYuFpezdoIpB65jUr4OluO2ZqtdoK/GzsDzTDVHPTG+yfsLM
         UnejDVErRWK6ELXtmYEklX4B8FWPaFJvA4bkW48mkxb9pTwpbAO7dtiwxsqhXil0ddt+
         fMBxrFS7p6BsoAX4kPiFEgZHEnWVhrX5x3Cprq2UOwpQyBDI2OPIJz4zPj/LDfgyljp9
         CSLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681832948; x=1684424948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NPDSA+x4oz9imX3uiByE603i/j50qlmE+SnCawov5Gk=;
        b=fOPuJaMsd+gBcgpXtHhMC6Kn+A7r38OnyLiOmBO9z5p67S6I/OB/hpTI0I9geouscf
         v/fVyXrdNZwInEis53vizFZjkFXDOUZg4BZI0rA6awO1unDB2rMVcXTwnKQatJic+E+8
         PSYE86wpIBdoeU6zA9vTSsRGsvRkZjb9eo3vznvip6n+fZlkGtu8mAq3mhlfXbfNxKMy
         HRe4JiYjVnR94a42dKW+8S+FDqCNWfn+2yMw4g6iT3QcthCCghuXQ5hd8lHcP8lZZ3fb
         044ccmRJF03xK/znxuZXdB1L8SX3FFEx1pebsLCoJweL2w+qPICzJhjtJZnTRPdLsve0
         RNCg==
X-Gm-Message-State: AAQBX9cgx6xcWOpr4POqm7ukIgym6rAfvlErrkDihI3oBe3XgfK1T88G
	Wzw4hiYebFrho4NsTtQ+3Lk=
X-Google-Smtp-Source: AKy350YiLSJ7u9SiqFEKwv2I6butZKhidTn4j0OJ/5851Zru7xsHmoegW+XNWDQ016eO2V5AEiXTdQ==
X-Received: by 2002:adf:dbce:0:b0:2f9:5841:a4d4 with SMTP id e14-20020adfdbce000000b002f95841a4d4mr2063234wrj.27.1681832948536;
        Tue, 18 Apr 2023 08:49:08 -0700 (PDT)
Received: from lucifer.home (host86-156-84-164.range86-156.btcentralplus.com. [86.156.84.164])
        by smtp.googlemail.com with ESMTPSA id p11-20020a5d458b000000b002efb31d3c24sm13352583wrq.32.2023.04.18.08.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 08:49:07 -0700 (PDT)
From: Lorenzo Stoakes <lstoakes@gmail.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	iommu@lists.linux.dev
Cc: Matthew Wilcox <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	kvm@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v4 2/6] mm/gup: remove unused vmas parameter from pin_user_pages_remote()
Date: Tue, 18 Apr 2023 16:49:05 +0100
Message-Id: <e7f5010ec0f2eb0ce5dc7c82b2fefd56b86af3f8.1681831798.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1681831798.git.lstoakes@gmail.com>
References: <cover.1681831798.git.lstoakes@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No invocation of pin_user_pages_remote() uses the vmas parameter, so remove
it. This forms part of a larger patch set eliminating the use of the vmas
parameters altogether.

Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 drivers/iommu/iommufd/pages.c   | 4 ++--
 drivers/vfio/vfio_iommu_type1.c | 2 +-
 include/linux/mm.h              | 2 +-
 mm/gup.c                        | 8 +++-----
 mm/process_vm_access.c          | 2 +-
 5 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index f8d92c9bb65b..9d55a2188a64 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -786,7 +786,7 @@ static int pfn_reader_user_pin(struct pfn_reader_user *user,
 			user->locked = 1;
 		}
 		rc = pin_user_pages_remote(pages->source_mm, uptr, npages,
-					   user->gup_flags, user->upages, NULL,
+					   user->gup_flags, user->upages,
 					   &user->locked);
 	}
 	if (rc <= 0) {
@@ -1787,7 +1787,7 @@ static int iopt_pages_rw_page(struct iopt_pages *pages, unsigned long index,
 	rc = pin_user_pages_remote(
 		pages->source_mm, (uintptr_t)(pages->uptr + index * PAGE_SIZE),
 		1, (flags & IOMMUFD_ACCESS_RW_WRITE) ? FOLL_WRITE : 0, &page,
-		NULL, NULL);
+		NULL);
 	mmap_read_unlock(pages->source_mm);
 	if (rc != 1) {
 		if (WARN_ON(rc >= 0))
diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 493c31de0edb..e6dc8fec3ed5 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -562,7 +562,7 @@ static int vaddr_get_pfns(struct mm_struct *mm, unsigned long vaddr,
 
 	mmap_read_lock(mm);
 	ret = pin_user_pages_remote(mm, vaddr, npages, flags | FOLL_LONGTERM,
-				    pages, NULL, NULL);
+				    pages, NULL);
 	if (ret > 0) {
 		int i;
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index b14cc4972d0b..ec9875c59f6d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2378,7 +2378,7 @@ long get_user_pages_remote(struct mm_struct *mm,
 long pin_user_pages_remote(struct mm_struct *mm,
 			   unsigned long start, unsigned long nr_pages,
 			   unsigned int gup_flags, struct page **pages,
-			   struct vm_area_struct **vmas, int *locked);
+			   int *locked);
 long get_user_pages(unsigned long start, unsigned long nr_pages,
 		    unsigned int gup_flags, struct page **pages);
 long pin_user_pages(unsigned long start, unsigned long nr_pages,
diff --git a/mm/gup.c b/mm/gup.c
index 7e454d6b157e..931c805bc32b 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -3093,8 +3093,6 @@ EXPORT_SYMBOL_GPL(pin_user_pages_fast);
  * @gup_flags:	flags modifying lookup behaviour
  * @pages:	array that receives pointers to the pages pinned.
  *		Should be at least nr_pages long.
- * @vmas:	array of pointers to vmas corresponding to each page.
- *		Or NULL if the caller does not require them.
  * @locked:	pointer to lock flag indicating whether lock is held and
  *		subsequently whether VM_FAULT_RETRY functionality can be
  *		utilised. Lock must initially be held.
@@ -3109,14 +3107,14 @@ EXPORT_SYMBOL_GPL(pin_user_pages_fast);
 long pin_user_pages_remote(struct mm_struct *mm,
 			   unsigned long start, unsigned long nr_pages,
 			   unsigned int gup_flags, struct page **pages,
-			   struct vm_area_struct **vmas, int *locked)
+			   int *locked)
 {
 	int local_locked = 1;
 
-	if (!is_valid_gup_args(pages, vmas, locked, &gup_flags,
+	if (!is_valid_gup_args(pages, NULL, locked, &gup_flags,
 			       FOLL_PIN | FOLL_TOUCH | FOLL_REMOTE))
 		return 0;
-	return __gup_longterm_locked(mm, start, nr_pages, pages, vmas,
+	return __gup_longterm_locked(mm, start, nr_pages, pages, NULL,
 				     locked ? locked : &local_locked,
 				     gup_flags);
 }
diff --git a/mm/process_vm_access.c b/mm/process_vm_access.c
index 78dfaf9e8990..0523edab03a6 100644
--- a/mm/process_vm_access.c
+++ b/mm/process_vm_access.c
@@ -104,7 +104,7 @@ static int process_vm_rw_single_vec(unsigned long addr,
 		mmap_read_lock(mm);
 		pinned_pages = pin_user_pages_remote(mm, pa, pinned_pages,
 						     flags, process_pages,
-						     NULL, &locked);
+						     &locked);
 		if (locked)
 			mmap_read_unlock(mm);
 		if (pinned_pages <= 0)
-- 
2.40.0

