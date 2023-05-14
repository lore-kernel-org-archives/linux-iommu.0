Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45C01FCE
	for <iommu@lists.linux.dev>; Sun, 14 May 2023 21:26:53 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-3f4c6c4b51eso49947645e9.2
        for <iommu@lists.linux.dev>; Sun, 14 May 2023 14:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684099612; x=1686691612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZmBAahwH3yBC6wiSFBmCvOUJZc6pQJuHBQHQjehZN04=;
        b=P9v4mBU31DGSqiMeXVGSxNgDot0QvCFZEg81a2ZqSRg8aNjpkh1heg2g0YDLwGP1WW
         pumh6XzLEJs+M0DyO1sdJOxuO5GXSIg7X98SLUQn5Aq+xU++Ezi5PFtH7qk9tEVHDcVU
         PtifjH/BqYn+H9IvTbDYymR3gOt7fAs8busLuz8pPLS9adFg/Q17UmH2jxfHUYC7/ffW
         O3fouSy/AkWD38T9QKesFhyoTZHE7Ndr/7ZPCy9pQbJ2TshQhoPGX6sP53+BdEOT6/6a
         XApfU798flXg+lhZw7l9ve1Ik8oxAjkwIqV0AzasmwGY7WoC2ffal7clqg7KJx8Mk/xe
         QpCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684099612; x=1686691612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZmBAahwH3yBC6wiSFBmCvOUJZc6pQJuHBQHQjehZN04=;
        b=jS0roS1USzYx83M74wAkRuXMa5sAt1LEn1MZEo53yy9NfuvLO2gRrzP4gr8UES4RV1
         V2FTw9GhbGfFs8Bdqb5bXm8B09mux+b9M1tHFs4wus/1Hm7yA6HUw5VgIyUBNI8+M98K
         kxRJHyovIwjCi3ujYb5yu6mBK549n0bYiQg1hzs/PXV2bs/BJ+35vXEBJjv0tlZ9Icwf
         plUNNdOKUI1zltJTCF1b9G+lgzlqTr4fB1DcyvYHUOnQusENwyuWHw48v39sOc5nzRvB
         t7v7QOikirDl94UFRI7x3sW9PklziSSaH7J8WQCHCUyTulONw6kcWdJBoCrsYQT9tmwH
         HBeQ==
X-Gm-Message-State: AC+VfDygq+EnJHv5cOjt6zqYcWLk1xXCW4UoF9H/fGkuTsbPYk8e8s21
	grEkVcXDL/JH1owk6fdmDuo=
X-Google-Smtp-Source: ACHHUZ7lK5a36mvxmR1Pxfpqxs+w/WjMWXdphswTjkKa0cVHWahzuWK+ycuAS5s3uVehE/QApFMdkQ==
X-Received: by 2002:a05:600c:2207:b0:3f5:6e5:1689 with SMTP id z7-20020a05600c220700b003f506e51689mr1792509wml.17.1684099611749;
        Sun, 14 May 2023 14:26:51 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id l11-20020a05600c1d0b00b003f1978bbcd6sm25750205wms.3.2023.05.14.14.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 14:26:50 -0700 (PDT)
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
	Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v5 2/6] mm/gup: remove unused vmas parameter from pin_user_pages_remote()
Date: Sun, 14 May 2023 22:26:47 +0100
Message-Id: <61f0d12058825a14feee6a3292e5a257662e719c.1684097002.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1684097001.git.lstoakes@gmail.com>
References: <cover.1684097001.git.lstoakes@gmail.com>
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
index 3c47846cc5ef..412ca96be128 100644
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
@@ -1799,7 +1799,7 @@ static int iopt_pages_rw_page(struct iopt_pages *pages, unsigned long index,
 	rc = pin_user_pages_remote(
 		pages->source_mm, (uintptr_t)(pages->uptr + index * PAGE_SIZE),
 		1, (flags & IOMMUFD_ACCESS_RW_WRITE) ? FOLL_WRITE : 0, &page,
-		NULL, NULL);
+		NULL);
 	mmap_read_unlock(pages->source_mm);
 	if (rc != 1) {
 		if (WARN_ON(rc >= 0))
diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 3d4dd9420c30..3d2d9a944906 100644
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
index 2c1a92bf5626..8ea82e9e7719 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2380,7 +2380,7 @@ long get_user_pages_remote(struct mm_struct *mm,
 long pin_user_pages_remote(struct mm_struct *mm,
 			   unsigned long start, unsigned long nr_pages,
 			   unsigned int gup_flags, struct page **pages,
-			   struct vm_area_struct **vmas, int *locked);
+			   int *locked);
 long get_user_pages(unsigned long start, unsigned long nr_pages,
 		    unsigned int gup_flags, struct page **pages);
 long pin_user_pages(unsigned long start, unsigned long nr_pages,
diff --git a/mm/gup.c b/mm/gup.c
index b8189396f435..ce78a5186dbb 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -3243,8 +3243,6 @@ EXPORT_SYMBOL_GPL(pin_user_pages_fast);
  * @gup_flags:	flags modifying lookup behaviour
  * @pages:	array that receives pointers to the pages pinned.
  *		Should be at least nr_pages long.
- * @vmas:	array of pointers to vmas corresponding to each page.
- *		Or NULL if the caller does not require them.
  * @locked:	pointer to lock flag indicating whether lock is held and
  *		subsequently whether VM_FAULT_RETRY functionality can be
  *		utilised. Lock must initially be held.
@@ -3259,14 +3257,14 @@ EXPORT_SYMBOL_GPL(pin_user_pages_fast);
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
2.40.1

