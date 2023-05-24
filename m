Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0FB18AFF
	for <iommu@lists.linux.dev>; Wed, 24 May 2023 17:19:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7145C4339B;
	Wed, 24 May 2023 17:19:18 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>,
	Robin Murphy <robin.murphy@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Will Deacon <will@kernel.org>,
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
	linux-mm@kvack.org,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 03/15] mm/slab: Simplify create_kmalloc_cache() args and make it static
Date: Wed, 24 May 2023 18:18:52 +0100
Message-Id: <20230524171904.3967031-4-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230524171904.3967031-1-catalin.marinas@arm.com>
References: <20230524171904.3967031-1-catalin.marinas@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the slab variant of kmem_cache_init(), call new_kmalloc_cache()
instead of initialising the kmalloc_caches array directly. With this,
create_kmalloc_cache() is now only called from new_kmalloc_cache() in
the same file, so make it static. In addition, the useroffset argument
is always 0 while usersize is the same as size. Remove them.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 mm/slab.c        |  6 +-----
 mm/slab.h        |  5 ++---
 mm/slab_common.c | 14 ++++++--------
 3 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index bb57f7fdbae1..b7817dcba63e 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1240,11 +1240,7 @@ void __init kmem_cache_init(void)
 	 * Initialize the caches that provide memory for the  kmem_cache_node
 	 * structures first.  Without this, further allocations will bug.
 	 */
-	kmalloc_caches[KMALLOC_NORMAL][INDEX_NODE] = create_kmalloc_cache(
-				kmalloc_info[INDEX_NODE].name[KMALLOC_NORMAL],
-				kmalloc_info[INDEX_NODE].size,
-				ARCH_KMALLOC_FLAGS, 0,
-				kmalloc_info[INDEX_NODE].size);
+	new_kmalloc_cache(INDEX_NODE, KMALLOC_NORMAL, ARCH_KMALLOC_FLAGS);
 	slab_state = PARTIAL_NODE;
 	setup_kmalloc_cache_index_table();
 
diff --git a/mm/slab.h b/mm/slab.h
index f01ac256a8f5..592590fcddae 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -255,9 +255,8 @@ gfp_t kmalloc_fix_flags(gfp_t flags);
 /* Functions provided by the slab allocators */
 int __kmem_cache_create(struct kmem_cache *, slab_flags_t flags);
 
-struct kmem_cache *create_kmalloc_cache(const char *name, unsigned int size,
-			slab_flags_t flags, unsigned int useroffset,
-			unsigned int usersize);
+void __init new_kmalloc_cache(int idx, enum kmalloc_cache_type type,
+			      slab_flags_t flags);
 extern void create_boot_cache(struct kmem_cache *, const char *name,
 			unsigned int size, slab_flags_t flags,
 			unsigned int useroffset, unsigned int usersize);
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 607249785c07..7f069159aee2 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -658,17 +658,16 @@ void __init create_boot_cache(struct kmem_cache *s, const char *name,
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
 	list_add(&s->list, &slab_caches);
 	s->refcount = 1;
 	return s;
@@ -863,7 +862,7 @@ void __init setup_kmalloc_cache_index_table(void)
 	}
 }
 
-static void __init
+void __init
 new_kmalloc_cache(int idx, enum kmalloc_cache_type type, slab_flags_t flags)
 {
 	if ((KMALLOC_RECLAIM != KMALLOC_NORMAL) && (type == KMALLOC_RECLAIM)) {
@@ -880,8 +879,7 @@ new_kmalloc_cache(int idx, enum kmalloc_cache_type type, slab_flags_t flags)
 
 	kmalloc_caches[type][idx] = create_kmalloc_cache(
 					kmalloc_info[idx].name[type],
-					kmalloc_info[idx].size, flags, 0,
-					kmalloc_info[idx].size);
+					kmalloc_info[idx].size, flags);
 
 	/*
 	 * If CONFIG_MEMCG_KMEM is enabled, disable cache merging for
