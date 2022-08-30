Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF9B610B
	for <iommu@lists.linux.dev>; Tue, 30 Aug 2022 21:49:48 +0000 (UTC)
Received: by mail-yb1-f202.google.com with SMTP id n18-20020a25d612000000b0069661a1dc48so725395ybg.20
        for <iommu@lists.linux.dev>; Tue, 30 Aug 2022 14:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=p8/y/nLBQm6IGi3iJX5wV5NMUkycPfOY4OR1rTeRfxQ=;
        b=eh/OQULFmIACthv18cWUl4oX11okytVSai6q8VzR+NAQKjUe//Iyb+nFKGGFut6bnz
         U9vNve6H/h3V8KtV1wUMGWZN/R3y/KwtIJWlz0MYZTJiIV/PhXncLGaXcxmIWasd49k4
         MzAfZ3MmPE/GrPk0xGglkpLQ6vp+JNN34VaaKbWMkI6l0blrObop9acuYIFl58Z8BCzL
         5fC4JT76yIwf+mLDK1SPTy1QXCq8FwZe3KmkNaoWIFZ0MNlEC2nHkf9R6kzo++VpnZeN
         5Whn6DE0IEl1BMPRxgM5XkxVMj4js15JxMerWLMdHXpHMsiFoGiwHoKTk4A6B15t/TFb
         q+Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=p8/y/nLBQm6IGi3iJX5wV5NMUkycPfOY4OR1rTeRfxQ=;
        b=kPr/5EuKI8LRvCrhfCDBO94sEE2rtStRekNIHViVj7YsXuaA4qfsMJQfAI/0esu/4s
         rdCHAwjG70CUUrA8Lvv359fRlbmtBprC0wSYt99TzI+jwAs0U/aOYqUbNqk8xwoE7cj8
         2UZKsjRdNMyKFqZ2/71mrGmwLCkgA+eg4xMDwwlGJsgYDUFhX5bhjIUBlrzJ/MTVgeHw
         5+ssR0eC77+6Agfhc3A9PcB1JZiTgcfdI1eulGX09OZ3T+Gn2BX5O4uLBIW/wzSlq4vI
         OSi36JowvVD9z/MQwd5xcO7xWEZPIfFvgKuirWn4+LglpPj+Tgm3jPKduegBSaJ+q1jt
         IAfw==
X-Gm-Message-State: ACgBeo3sJEWk+f/VUHmhylMRJKtU6PHWmP8bKOQojjR8UUc6r6R1FQpt
	jFsrLdumiE8qOORMP0Y/+HsFB0WEu0I=
X-Google-Smtp-Source: AA6agR5jbCGe1MArd8G7FNCgOj77g3iLznXqPzYSPJ0w7ptPLXk4tjPHYPeR1rNV3a/cmH1L2NtV8LKD3is=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:a005:55b3:6c26:b3e4])
 (user=surenb job=sendgmr) by 2002:a25:4d56:0:b0:69c:3d80:bb51 with SMTP id
 a83-20020a254d56000000b0069c3d80bb51mr6383765ybb.124.1661896187249; Tue, 30
 Aug 2022 14:49:47 -0700 (PDT)
Date: Tue, 30 Aug 2022 14:48:58 -0700
In-Reply-To: <20220830214919.53220-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20220830214919.53220-1-surenb@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220830214919.53220-10-surenb@google.com>
Subject: [RFC PATCH 09/30] change alloc_pages name in dma_map_ops to avoid
 name conflicts
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	void@manifault.com, peterz@infradead.org, juri.lelli@redhat.com, 
	ldufour@linux.ibm.com, peterx@redhat.com, david@redhat.com, axboe@kernel.dk, 
	mcgrof@kernel.org, masahiroy@kernel.org, nathan@kernel.org, 
	changbin.du@intel.com, ytcoode@gmail.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org, 
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com, 
	elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, arnd@arndb.de, jbaron@akamai.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	surenb@google.com, kernel-team@android.com, linux-mm@kvack.org, 
	iommu@lists.linux.dev, kasan-dev@googlegroups.com, io-uring@vger.kernel.org, 
	linux-arch@vger.kernel.org, xen-devel@lists.xenproject.org, 
	linux-bcache@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

After redefining alloc_pages, all uses of that name are being replaced.
Change the conflicting names to prevent preprocessor from replacing them
when it's not intended.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 arch/x86/kernel/amd_gart_64.c | 2 +-
 drivers/iommu/dma-iommu.c     | 2 +-
 drivers/xen/grant-dma-ops.c   | 2 +-
 drivers/xen/swiotlb-xen.c     | 2 +-
 include/linux/dma-map-ops.h   | 2 +-
 kernel/dma/mapping.c          | 4 ++--
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/amd_gart_64.c b/arch/x86/kernel/amd_gart_64.c
index 194d54eed537..5e83a387bfef 100644
--- a/arch/x86/kernel/amd_gart_64.c
+++ b/arch/x86/kernel/amd_gart_64.c
@@ -676,7 +676,7 @@ static const struct dma_map_ops gart_dma_ops = {
 	.get_sgtable			= dma_common_get_sgtable,
 	.dma_supported			= dma_direct_supported,
 	.get_required_mask		= dma_direct_get_required_mask,
-	.alloc_pages			= dma_direct_alloc_pages,
+	.alloc_pages_op			= dma_direct_alloc_pages,
 	.free_pages			= dma_direct_free_pages,
 };
 
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 17dd683b2fce..58b4878ef930 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1547,7 +1547,7 @@ static const struct dma_map_ops iommu_dma_ops = {
 	.flags			= DMA_F_PCI_P2PDMA_SUPPORTED,
 	.alloc			= iommu_dma_alloc,
 	.free			= iommu_dma_free,
-	.alloc_pages		= dma_common_alloc_pages,
+	.alloc_pages_op		= dma_common_alloc_pages,
 	.free_pages		= dma_common_free_pages,
 	.alloc_noncontiguous	= iommu_dma_alloc_noncontiguous,
 	.free_noncontiguous	= iommu_dma_free_noncontiguous,
diff --git a/drivers/xen/grant-dma-ops.c b/drivers/xen/grant-dma-ops.c
index 8973fc1e9ccc..0e26d066036e 100644
--- a/drivers/xen/grant-dma-ops.c
+++ b/drivers/xen/grant-dma-ops.c
@@ -262,7 +262,7 @@ static int xen_grant_dma_supported(struct device *dev, u64 mask)
 static const struct dma_map_ops xen_grant_dma_ops = {
 	.alloc = xen_grant_dma_alloc,
 	.free = xen_grant_dma_free,
-	.alloc_pages = xen_grant_dma_alloc_pages,
+	.alloc_pages_op = xen_grant_dma_alloc_pages,
 	.free_pages = xen_grant_dma_free_pages,
 	.mmap = dma_common_mmap,
 	.get_sgtable = dma_common_get_sgtable,
diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 67aa74d20162..5ab2616153f0 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -403,6 +403,6 @@ const struct dma_map_ops xen_swiotlb_dma_ops = {
 	.dma_supported = xen_swiotlb_dma_supported,
 	.mmap = dma_common_mmap,
 	.get_sgtable = dma_common_get_sgtable,
-	.alloc_pages = dma_common_alloc_pages,
+	.alloc_pages_op = dma_common_alloc_pages,
 	.free_pages = dma_common_free_pages,
 };
diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index d678afeb8a13..e8e2d210ba68 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -27,7 +27,7 @@ struct dma_map_ops {
 			unsigned long attrs);
 	void (*free)(struct device *dev, size_t size, void *vaddr,
 			dma_addr_t dma_handle, unsigned long attrs);
-	struct page *(*alloc_pages)(struct device *dev, size_t size,
+	struct page *(*alloc_pages_op)(struct device *dev, size_t size,
 			dma_addr_t *dma_handle, enum dma_data_direction dir,
 			gfp_t gfp);
 	void (*free_pages)(struct device *dev, size_t size, struct page *vaddr,
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 49cbf3e33de7..80a2bfeed8d0 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -552,9 +552,9 @@ static struct page *__dma_alloc_pages(struct device *dev, size_t size,
 	size = PAGE_ALIGN(size);
 	if (dma_alloc_direct(dev, ops))
 		return dma_direct_alloc_pages(dev, size, dma_handle, dir, gfp);
-	if (!ops->alloc_pages)
+	if (!ops->alloc_pages_op)
 		return NULL;
-	return ops->alloc_pages(dev, size, dma_handle, dir, gfp);
+	return ops->alloc_pages_op(dev, size, dma_handle, dir, gfp);
 }
 
 struct page *dma_alloc_pages(struct device *dev, size_t size,
-- 
2.37.2.672.g94769d06f0-goog

