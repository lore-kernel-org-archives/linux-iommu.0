Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F861BA25
	for <iommu@lists.linux.dev>; Sun,  6 Nov 2022 22:02:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E53CC4314C;
	Sun,  6 Nov 2022 22:02:06 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christoph Hellwig <hch@lst.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Will Deacon <will@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Ard Biesheuvel <ardb@kernel.org>,
	Isaac Manjarres <isaacmanjarres@google.com>,
	Saravana Kannan <saravanak@google.com>,
	Alasdair Kergon <agk@redhat.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Joerg Roedel <joro@8bytes.org>,
	Mark Brown <broonie@kernel.org>,
	Mike Snitzer <snitzer@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	linux-mm@kvack.org,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 05/13] mm/slab: Simplify create_kmalloc_cache() args and make it static
Date: Sun,  6 Nov 2022 22:01:35 +0000
Message-Id: <20221106220143.2129263-6-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221106220143.2129263-1-catalin.marinas@arm.com>
References: <20221106220143.2129263-1-catalin.marinas@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

create_kmalloc_cache() is now only called from new_kmalloc_cache() in
the same file, so make it static. In addition, the useroffset argument
is always 0 while usersize is the same as size. Remove them.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 mm/slab.h        |  3 ---
 mm/slab_common.c | 11 +++++------
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index d0460e0f6760..93ba93e7b772 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -285,9 +285,6 @@ gfp_t kmalloc_fix_flags(gfp_t flags);
 /* Functions provided by the slab allocators */
 int __kmem_cache_create(struct kmem_cache *, slab_flags_t flags);
 
-struct kmem_cache *create_kmalloc_cache(const char *name, unsigned int size,
-			slab_flags_t flags, unsigned int useroffset,
-			unsigned int usersize);
 void __init new_kmalloc_cache(int idx, enum kmalloc_cache_type type,
 			      slab_flags_t flags);
 extern void create_boot_cache(struct kmem_cache *, const char *name,
diff --git a/mm/slab_common.c b/mm/slab_common.c
index b62f27c2dda7..3fe3f4ad1362 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -654,17 +654,16 @@ void __init create_boot_cache(struct kmem_cache *s, const char *name,
 	s->refcount = -1;	/* Exempt from merging for now */
 }
 
-struct kmem_cache *__init create_kmalloc_cache(const char *name,
-		unsigned int size, slab_flags_t flags,
-		unsigned int useroffset, unsigned int usersize)
+static struct kmem_cache *__init create_kmalloc_cache(const char *name,
+						      unsigned int size,
+						      slab_flags_t flags)
 {
 	struct kmem_cache *s = kmem_cache_zalloc(kmem_cache, GFP_NOWAIT);
 
 	if (!s)
 		panic("Out of memory when creating slab %s\n", name);
 
-	create_boot_cache(s, name, size, flags | SLAB_KMALLOC, useroffset,
-								usersize);
+	create_boot_cache(s, name, size, flags | SLAB_KMALLOC, 0, size);
 	kasan_cache_create_kmalloc(s);
 	list_add(&s->list, &slab_caches);
 	s->refcount = 1;
@@ -898,7 +897,7 @@ new_kmalloc_cache(int idx, enum kmalloc_cache_type type, slab_flags_t flags)
 	if (!kmalloc_caches[type][aligned_idx])
 		kmalloc_caches[type][aligned_idx] = create_kmalloc_cache(
 					kmalloc_info[aligned_idx].name[type],
-					aligned_size, flags, 0, aligned_size);
+					aligned_size, flags);
 	if (idx != aligned_idx)
 		kmalloc_caches[type][idx] = kmalloc_caches[type][aligned_idx];
 
