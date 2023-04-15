Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C1A1868
	for <iommu@lists.linux.dev>; Sat, 15 Apr 2023 12:09:25 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id o6-20020a05600c4fc600b003ef6e6754c5so9338447wmq.5
        for <iommu@lists.linux.dev>; Sat, 15 Apr 2023 05:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681560564; x=1684152564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+LSahXs7vXHVGQn1uT2igLaiQzqbh9LfXfVKe7mEnQ=;
        b=GsxnOitYpi73oLhTi6FjVEXHbNNB2I1m+LTWchC6U9ognod3QRNbzxwZCHEWBtDhe1
         6DkMMTmq001Yy+AOQ7R1KYIg7r1GVSrp1RMbGkRCFI5uJbbDiUh2Osw1wBbs/Lrj5r8b
         c88Clz1Eewi+NicYztqrNHk93PEk1mE/B1kj0IjymWDErCqKvYUQtGrzh9lI3TOMC0Zr
         AdzXrOUeAelvmsbu2JOIKoGC6gAidmka43ibRiAwKHjzsNMmoAzks5fQgfTZiEyBp/NZ
         tepv+9YlS6JIp0PWTA2p88c2oQslYAzfhDr188x7TBPTSZ88a5WAWUA6TFGit6GgjSLG
         QKIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681560564; x=1684152564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J+LSahXs7vXHVGQn1uT2igLaiQzqbh9LfXfVKe7mEnQ=;
        b=D4IkcFToi3E4Rbsfy7atZEIjktEqZ3caABRSTtUeOrvkb4tIhcZFxmz9J2ThDdSbKN
         yT3LcuWC+7n8RJGiUqPV28KjawtAIwEEhUgeDhrQw5jqES8VhUBIJzEaxhV0w+9i6k8v
         5I1i3F4lTIAPx43N5PXZg6gPHwCobPnrNGDoxHaVF4a9E6CWFYKX1ROJ2jl55EVZ6Nqc
         sgvX1o/huYDzhBOhB/FDPKLfAklh0BD+XlZF5kVBHjAzR8PLUFP85cnyoz3DowmTfdsK
         3w8OuZORdesrP1/QnDlje6N7XmXTHiil78erqj5L4Et8jIaAlrCQVXWM8fy2GeBapYd5
         lGpA==
X-Gm-Message-State: AAQBX9cKOcgyW61a3HlZKc6iiJykKq7NWd6esU3ulurQ30Zy3AzYokwT
	vo9NtGulGBW1u7TNa57ZuK4=
X-Google-Smtp-Source: AKy350aKB0tm+8SA/HZcPhTfSTG7LR/yw/OdGCM9lH11ZxILot8tUnno6Y2e/17DZKVXVtbkRaIQaA==
X-Received: by 2002:a7b:cd88:0:b0:3f0:44d1:3ba5 with SMTP id y8-20020a7bcd88000000b003f044d13ba5mr6453227wmj.5.1681560563832;
        Sat, 15 Apr 2023 05:09:23 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id p22-20020a05600c205600b003f16f362ae7sm631546wmg.21.2023.04.15.05.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 05:09:23 -0700 (PDT)
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
	Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v3 2/7] mm/gup: remove unused vmas parameter from pin_user_pages_remote()
Date: Sat, 15 Apr 2023 13:09:21 +0100
Message-Id: <59022490ef05da7310e6abd7f42df933bebdda2a.1681558407.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1681558407.git.lstoakes@gmail.com>
References: <cover.1681558407.git.lstoakes@gmail.com>
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

