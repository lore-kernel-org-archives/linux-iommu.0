Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB833247284
	for <iommu@lists.linux.dev>; Fri, 10 Oct 2025 01:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760059208; cv=none; b=Sbakjfmu6+HdzhKh4sYml/k7Vv0qkjyD39bsIzTwd1iEWG4G5kUx8faKJX8o+Gp8vWiYFZ4gMQIV/f7GEdpbm9X5nKOw+vZdBYqPK1vahczGHNgPhI0erSKNQpt5PyS13+2KRcnxuK+4k+69mCWc4Nzy0sIzGI/o5lV6aK70ax4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760059208; c=relaxed/simple;
	bh=bn9lTdYGL9Ujc3sLUhzNwz04Ju6VtGy9ZkLXqXBGZBs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PflhpGvWiZ+0Gf3DLZBbN4tkAv9ryJOZjcXGOj1QPpEIC560lnO7IuXjCC765gIIngE+cur1ggg2cKOH4thSbpGmE/CxR4a1iF6se5SMi6yaqRakEUbnnmnlTym4dCVVaiHQNeUB8mFWOcM6zfDA4WdURO0bt40+hem+sKoCUxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bNm5S3L4; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bNm5S3L4"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-78105c10afdso2335651b3a.1
        for <iommu@lists.linux.dev>; Thu, 09 Oct 2025 18:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760059205; x=1760664005; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tcN6OGexdDN4REs0WUDwtbwKs1bNtyrXTB87BI/xDL8=;
        b=bNm5S3L4T+2L65e2JP32Lk+KhSNxtqvoXc+MLaP734SUCaKljhv2wY7QV2qOfaSX4A
         TDLUlNY8gzms/avGEpgJ0eqq7XweAmSFHE7iXsPop2uv2/ZTacD5HvgtcswtusZFnf+h
         V6+RekpGcXUbeM8QHtIXdpTSgQDMWq+GOQfHRJrGt9780ufVtC40SHjpT1+mfJ2gU+8O
         sF6KyhkmpgJwwRMS08gPGVDvAu0H+auEg5wtV4DwZzP42UOvQVPyVHejBHmsmltpRSBx
         BPP316/vUXzRMHGaQcRuL15LbpXnjIC93wTf1uTOT7PLl09LOqCN/yNc/bQhtvrqfGV9
         PjSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760059205; x=1760664005;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tcN6OGexdDN4REs0WUDwtbwKs1bNtyrXTB87BI/xDL8=;
        b=EpgK6dfHiFCYKSQ0CjeDfhjEN2pTp/7Mm5RyJkSi8BMbyUgBX+wVQctONPBzmlaPB0
         kFxK9oCRIhq/apvZYYRaXbcpA5xthZwa6YKa2mL2OEQTnqtKyfmHn+6WL3LulrACPzB0
         ++USgqg1LfgwoVGxA0w7mO3Za4kpwigJLFF9p1W3gfWLrF/WQIUXDwZnNlVppZ+Zaxv/
         YKqixv2NIHRIV5QcQoQogXtQicBkD9B0LJ1bSAf3ew0pxRiPBy5O7uSUG0e7zdn18KUD
         y2D0Ua5YVNYhzuYk4k9hrNBuXcSR4aCxU5j3o6FNpKq2t3UBBT8qGF/Fp2Mc9DBPfxnY
         wTZA==
X-Forwarded-Encrypted: i=1; AJvYcCVU9m+155EhusIjyhI3sV7oWXdDpLXa4qNwx6ho1ODFPtb1T7+zlqAPpc9vnvL15aw1YrUM9w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyaLm/XoLj5L+DUmw3ck1BU536PhF6iBQ8wzXSrVhdqWQBJeMld
	5IxCJ5Q2dMwz5Xl3JuMJMslrlcgEfjGA9iULWvhPMPaqnzKvyAJo2ytrxBpsulb/SaTGOr914Yt
	EMtMrYg==
X-Google-Smtp-Source: AGHT+IGWo2umirCkNnF3dRSzHnJXKgnnR9cLHUFGdmby3Duxq7TZVj0L2Xz38+ViMs5EtsI8nLTHCdiBjWM=
X-Received: from pgar12.prod.google.com ([2002:a05:6a02:2e8c:b0:b63:7a61:419c])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:748b:b0:32b:6e08:fa19
 with SMTP id adf61e73a8af0-32da81345fdmr12546348637.1.1760059205122; Thu, 09
 Oct 2025 18:20:05 -0700 (PDT)
Date: Thu,  9 Oct 2025 18:19:47 -0700
In-Reply-To: <20251010011951.2136980-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20251010011951.2136980-1-surenb@google.com>
X-Mailer: git-send-email 2.51.0.740.g6adb054d12-goog
Message-ID: <20251010011951.2136980-5-surenb@google.com>
Subject: [PATCH 4/8] mm/cleancache: add sysfs interface
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, 
	vbabka@suse.cz, alexandru.elisei@arm.com, peterx@redhat.com, sj@kernel.org, 
	rppt@kernel.org, mhocko@suse.com, corbet@lwn.net, axboe@kernel.dk, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, hch@infradead.org, jack@suse.cz, 
	willy@infradead.org, m.szyprowski@samsung.com, robin.murphy@arm.com, 
	hannes@cmpxchg.org, zhengqi.arch@bytedance.com, shakeel.butt@linux.dev, 
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	minchan@kernel.org, surenb@google.com, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Create sysfs API under /sys/kernel/mm/cleancache/ to report the following
metrics:
  stored      - number of successful cleancache folio stores
  skipped     - number of folios skipped during cleancache store operation
  restored    - number of successful cleancache folio restore operations
  missed      - number of failed cleancache folio restore operations
  reclaimed   - number of folios dropped due to their age
  recalled    - number of folios dropped because cleancache backend took
                them back
  invalidated - number of folios dropped due to invalidation
  cached      - number of folios currently cached in the cleancache

In addition each pool creates a /sys/kernel/mm/cleancache/<pool name>
directory containing the following metrics:
  size        - number of folios in the pool
  cached      - number of folios currently cached in the pool
  recalled    - number of folios dropped from the pool because cleancache
                backend took them back

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 MAINTAINERS           |   2 +
 mm/Kconfig            |   8 ++
 mm/Makefile           |   1 +
 mm/cleancache.c       | 113 +++++++++++++++++++++--
 mm/cleancache_sysfs.c | 209 ++++++++++++++++++++++++++++++++++++++++++
 mm/cleancache_sysfs.h |  58 ++++++++++++
 6 files changed, 383 insertions(+), 8 deletions(-)
 create mode 100644 mm/cleancache_sysfs.c
 create mode 100644 mm/cleancache_sysfs.h

diff --git a/MAINTAINERS b/MAINTAINERS
index de7a89cd44a0..f66307cd9c4b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6055,6 +6055,8 @@ L:	linux-mm@kvack.org
 S:	Maintained
 F:	include/linux/cleancache.h
 F:	mm/cleancache.c
+F:	mm/cleancache_sysfs.c
+F:	mm/cleancache_sysfs.h
 
 CLK API
 M:	Russell King <linux@armlinux.org.uk>
diff --git a/mm/Kconfig b/mm/Kconfig
index 7e2482c522a0..9f4da8a848f4 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -965,6 +965,14 @@ config CLEANCACHE
 
 	  If unsure, say N.
 
+config CLEANCACHE_SYSFS
+	bool "Cleancache information through sysfs interface"
+	depends on CLEANCACHE && SYSFS
+	help
+	  This option exposes sysfs attributes to get information from
+	  cleancache. The user space can use the interface for query cleancache
+	  and individual cleancache pool metrics.
+
 config CMA
 	bool "Contiguous Memory Allocator"
 	depends on MMU
diff --git a/mm/Makefile b/mm/Makefile
index b78073b87aea..a7a635f762ee 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -147,3 +147,4 @@ obj-$(CONFIG_EXECMEM) += execmem.o
 obj-$(CONFIG_TMPFS_QUOTA) += shmem_quota.o
 obj-$(CONFIG_PT_RECLAIM) += pt_reclaim.o
 obj-$(CONFIG_CLEANCACHE) += cleancache.o
+obj-$(CONFIG_CLEANCACHE_SYSFS)	+= cleancache_sysfs.o
diff --git a/mm/cleancache.c b/mm/cleancache.c
index 59b8fd309619..56dce7e03709 100644
--- a/mm/cleancache.c
+++ b/mm/cleancache.c
@@ -12,6 +12,8 @@
 #include <linux/workqueue.h>
 #include <linux/xarray.h>
 
+#include "cleancache_sysfs.h"
+
 /*
  * Lock nesting:
  *	ccinode->folios.xa_lock
@@ -57,6 +59,8 @@ struct cleancache_inode {
 struct cleancache_pool {
 	struct list_head folio_list;
 	spinlock_t lock; /* protects folio_list */
+	char *name;
+	struct cleancache_pool_stats *stats;
 };
 
 #define CLEANCACHE_MAX_POOLS	64
@@ -110,6 +114,7 @@ static void attach_folio(struct folio *folio, struct cleancache_inode *ccinode,
 
 	folio->mapping = (struct address_space *)ccinode;
 	folio->index = offset;
+	cleancache_pool_stat_inc(folio_pool(folio)->stats, POOL_CACHED);
 }
 
 static void detach_folio(struct folio *folio)
@@ -118,6 +123,7 @@ static void detach_folio(struct folio *folio)
 
 	folio->mapping = NULL;
 	folio->index = 0;
+	cleancache_pool_stat_dec(folio_pool(folio)->stats, POOL_CACHED);
 }
 
 static void folio_attachment(struct folio *folio, struct cleancache_inode **ccinode,
@@ -525,7 +531,7 @@ static bool store_into_inode(struct cleancache_fs *fs,
 	ccinode = find_and_get_inode(fs, inode);
 	if (!ccinode) {
 		if (!workingset)
-			return false;
+			goto out;
 
 		ccinode = add_and_get_inode(fs, inode);
 		if (IS_ERR_OR_NULL(ccinode)) {
@@ -545,6 +551,7 @@ static bool store_into_inode(struct cleancache_fs *fs,
 	if (stored_folio) {
 		if (!workingset) {
 			move_folio_from_inode_to_pool(ccinode, offset, stored_folio);
+			cleancache_stat_inc(RECLAIMED);
 			goto out_unlock;
 		}
 		rotate_lru_folio(stored_folio);
@@ -560,6 +567,8 @@ static bool store_into_inode(struct cleancache_fs *fs,
 			xa_lock(&ccinode->folios);
 			if (!stored_folio)
 				goto out_unlock;
+
+			cleancache_stat_inc(RECLAIMED);
 		}
 
 		if (!store_folio_in_inode(ccinode, offset, stored_folio)) {
@@ -571,6 +580,7 @@ static bool store_into_inode(struct cleancache_fs *fs,
 			spin_unlock(&pool->lock);
 			goto out_unlock;
 		}
+		cleancache_stat_inc(STORED);
 		add_folio_to_lru(stored_folio);
 	}
 	copy_folio_content(folio, stored_folio);
@@ -582,6 +592,8 @@ static bool store_into_inode(struct cleancache_fs *fs,
 		remove_inode_if_empty(ccinode);
 	xa_unlock(&ccinode->folios);
 	put_inode(ccinode);
+out:
+	cleancache_stat_inc(SKIPPED);
 
 	return ret;
 }
@@ -592,23 +604,26 @@ static bool load_from_inode(struct cleancache_fs *fs,
 {
 	struct cleancache_inode *ccinode;
 	struct folio *stored_folio;
-	bool ret = false;
 
 	ccinode = find_and_get_inode(fs, inode);
-	if (!ccinode)
+	if (!ccinode) {
+		cleancache_stat_inc(MISSED);
 		return false;
+	}
 
 	xa_lock(&ccinode->folios);
 	stored_folio = xa_load(&ccinode->folios, offset);
 	if (stored_folio) {
 		rotate_lru_folio(stored_folio);
 		copy_folio_content(stored_folio, folio);
-		ret = true;
+		cleancache_stat_inc(RESTORED);
+	} else {
+		cleancache_stat_inc(MISSED);
 	}
 	xa_unlock(&ccinode->folios);
 	put_inode(ccinode);
 
-	return ret;
+	return !!stored_folio;
 }
 
 static bool invalidate_folio(struct cleancache_fs *fs,
@@ -623,8 +638,10 @@ static bool invalidate_folio(struct cleancache_fs *fs,
 
 	xa_lock(&ccinode->folios);
 	folio = xa_load(&ccinode->folios, offset);
-	if (folio)
+	if (folio) {
 		move_folio_from_inode_to_pool(ccinode, offset, folio);
+		cleancache_stat_inc(INVALIDATED);
+	}
 	xa_unlock(&ccinode->folios);
 	put_inode(ccinode);
 
@@ -645,6 +662,7 @@ static unsigned int invalidate_inode(struct cleancache_fs *fs,
 		ret = erase_folios_from_inode(ccinode, &xas);
 		xas_unlock(&xas);
 		put_inode(ccinode);
+		cleancache_stat_add(INVALIDATED, ret);
 
 		return ret;
 	}
@@ -652,6 +670,53 @@ static unsigned int invalidate_inode(struct cleancache_fs *fs,
 	return 0;
 }
 
+/* Sysfs helpers */
+#ifdef CONFIG_CLEANCACHE_SYSFS
+
+static struct kobject *kobj_sysfs_root;
+
+static void __init cleancache_sysfs_init(void)
+{
+	struct cleancache_pool *pool;
+	int pool_id, pool_count;
+	struct kobject *kobj;
+
+	kobj = cleancache_sysfs_create_root();
+	if (IS_ERR(kobj)) {
+		pr_warn("Failed to create cleancache sysfs root\n");
+		return;
+	}
+
+	kobj_sysfs_root = kobj;
+	if (!kobj_sysfs_root)
+		return;
+
+	pool_count = atomic_read(&nr_pools);
+	pool = &pools[0];
+	for (pool_id = 0; pool_id < pool_count; pool_id++, pool++)
+		if (cleancache_sysfs_create_pool(kobj_sysfs_root, pool->stats, pool->name))
+			pr_warn("Failed to create sysfs nodes for \'%s\' cleancache backend\n",
+				pool->name);
+}
+
+static void cleancache_sysfs_pool_init(struct cleancache_pool_stats *pool_stats,
+				       const char *name)
+{
+	/* Skip if sysfs was not initialized yet. */
+	if (!kobj_sysfs_root)
+		return;
+
+	if (cleancache_sysfs_create_pool(kobj_sysfs_root, pool_stats, name))
+		pr_warn("Failed to create sysfs nodes for \'%s\' cleancache backend\n",
+			name);
+}
+
+#else /* CONFIG_CLEANCACHE_SYSFS */
+static inline void cleancache_sysfs_init(void) {}
+static inline void cleancache_sysfs_pool_init(struct cleancache_pool_stats *pool_stats,
+					      const char *name) {}
+#endif /* CONFIG_CLEANCACHE_SYSFS */
+
 /* Hooks into MM and FS */
 void cleancache_add_fs(struct super_block *sb)
 {
@@ -835,6 +900,7 @@ cleancache_start_inode_walk(struct address_space *mapping, struct inode *inode,
 	ccinode = find_and_get_inode(fs, inode);
 	if (!ccinode) {
 		put_fs(fs);
+		cleancache_stat_add(MISSED, count);
 		return NULL;
 	}
 
@@ -865,7 +931,10 @@ bool cleancache_restore_from_inode(struct cleancache_inode *ccinode,
 		memcpy(dst, src, PAGE_SIZE);
 		kunmap_local(dst);
 		kunmap_local(src);
+		cleancache_stat_inc(RESTORED);
 		ret = true;
+	} else {
+		cleancache_stat_inc(MISSED);
 	}
 	xa_unlock(&ccinode->folios);
 
@@ -879,9 +948,18 @@ bool cleancache_restore_from_inode(struct cleancache_inode *ccinode,
  */
 int cleancache_backend_register_pool(const char *name)
 {
+	struct cleancache_pool_stats *pool_stats;
 	struct cleancache_pool *pool;
+	char *pool_name;
 	int pool_id;
 
+	if (!name)
+		return -EINVAL;
+
+	pool_name = kstrdup(name, GFP_KERNEL);
+	if (!pool_name)
+		return -ENOMEM;
+
 	/* pools_lock prevents concurrent registrations */
 	spin_lock(&pools_lock);
 	pool_id = atomic_read(&nr_pools);
@@ -893,12 +971,22 @@ int cleancache_backend_register_pool(const char *name)
 	pool = &pools[pool_id];
 	INIT_LIST_HEAD(&pool->folio_list);
 	spin_lock_init(&pool->lock);
+	pool->name = pool_name;
 	/* Ensure above stores complete before we increase the count */
 	atomic_set_release(&nr_pools, pool_id + 1);
 	spin_unlock(&pools_lock);
 
+	pool_stats = cleancache_create_pool_stats(pool_id);
+	if (!IS_ERR(pool_stats)) {
+		pool->stats = pool_stats;
+		cleancache_sysfs_pool_init(pool_stats, pool->name);
+	} else {
+		pr_warn("Failed to create pool stats for \'%s\' cleancache backend\n",
+			pool->name);
+	}
+
 	pr_info("Registered \'%s\' cleancache backend, pool id %d\n",
-		name ? : "none", pool_id);
+		name, pool_id);
 
 	return pool_id;
 }
@@ -947,10 +1035,13 @@ int cleancache_backend_get_folio(int pool_id, struct folio *folio)
 		goto again;
 	}
 
+	cleancache_stat_inc(RECALLED);
+	cleancache_pool_stat_inc(folio_pool(folio)->stats, POOL_RECALLED);
 	put_inode(ccinode);
 out:
 	VM_BUG_ON_FOLIO(folio_ref_count(folio) != 0, (folio));
 	clear_cleancache_folio(folio);
+	cleancache_pool_stat_dec(pool->stats, POOL_SIZE);
 
 	return 0;
 }
@@ -972,6 +1063,7 @@ int cleancache_backend_put_folio(int pool_id, struct folio *folio)
 	INIT_LIST_HEAD(&folio->lru);
 	spin_lock(&pool->lock);
 	add_folio_to_pool(folio, pool);
+	cleancache_pool_stat_inc(pool->stats, POOL_SIZE);
 	spin_unlock(&pool->lock);
 
 	return 0;
@@ -984,6 +1076,7 @@ int cleancache_backend_put_folios(int pool_id, struct list_head *folios)
 	LIST_HEAD(unused_folios);
 	struct folio *folio;
 	struct folio *tmp;
+	int count = 0;
 
 	list_for_each_entry_safe(folio, tmp, folios, lru) {
 		/* Do not support large folios yet */
@@ -993,10 +1086,12 @@ int cleancache_backend_put_folios(int pool_id, struct list_head *folios)
 
 		init_cleancache_folio(folio, pool_id);
 		list_move(&folio->lru, &unused_folios);
+		count++;
 	}
 
 	spin_lock(&pool->lock);
 	list_splice_init(&unused_folios, &pool->folio_list);
+	cleancache_pool_stat_add(pool->stats, POOL_SIZE, count);
 	spin_unlock(&pool->lock);
 
 	return list_empty(folios) ? 0 : -EINVAL;
@@ -1009,6 +1104,8 @@ static int __init init_cleancache(void)
 	if (!slab_inode)
 		return -ENOMEM;
 
+	cleancache_sysfs_init();
+
 	return 0;
 }
-core_initcall(init_cleancache);
+subsys_initcall(init_cleancache);
diff --git a/mm/cleancache_sysfs.c b/mm/cleancache_sysfs.c
new file mode 100644
index 000000000000..5ad7ae84ca1d
--- /dev/null
+++ b/mm/cleancache_sysfs.c
@@ -0,0 +1,209 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/kobject.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
+#include "cleancache_sysfs.h"
+
+static atomic64_t stats[CLEANCACHE_STAT_NR];
+
+void cleancache_stat_inc(enum cleancache_stat type)
+{
+	atomic64_inc(&stats[type]);
+}
+
+void cleancache_stat_add(enum cleancache_stat type, unsigned long delta)
+{
+	atomic64_add(delta, &stats[type]);
+}
+
+void cleancache_pool_stat_inc(struct cleancache_pool_stats *pool_stats,
+			      enum cleancache_pool_stat type)
+{
+	atomic64_inc(&pool_stats->stats[type]);
+}
+
+void cleancache_pool_stat_dec(struct cleancache_pool_stats *pool_stats,
+			      enum cleancache_pool_stat type)
+{
+	atomic64_dec(&pool_stats->stats[type]);
+}
+
+void cleancache_pool_stat_add(struct cleancache_pool_stats *pool_stats,
+			      enum cleancache_pool_stat type, long delta)
+{
+	atomic64_add(delta, &pool_stats->stats[type]);
+}
+
+#define CLEANCACHE_ATTR_RO(_name) \
+	static struct kobj_attribute _name##_attr = __ATTR_RO(_name)
+
+static inline struct cleancache_pool_stats *kobj_to_stats(struct kobject *kobj)
+{
+	return container_of(kobj, struct cleancache_pool_stats, kobj);
+}
+
+static ssize_t stored_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%llu\n", (u64)atomic64_read(&stats[STORED]));
+}
+CLEANCACHE_ATTR_RO(stored);
+
+static ssize_t skipped_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%llu\n", (u64)atomic64_read(&stats[SKIPPED]));
+}
+CLEANCACHE_ATTR_RO(skipped);
+
+static ssize_t restored_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%llu\n", (u64)atomic64_read(&stats[RESTORED]));
+}
+CLEANCACHE_ATTR_RO(restored);
+
+static ssize_t missed_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%llu\n", (u64)atomic64_read(&stats[MISSED]));
+}
+CLEANCACHE_ATTR_RO(missed);
+
+static ssize_t reclaimed_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%llu\n", (u64)atomic64_read(&stats[RECLAIMED]));
+}
+CLEANCACHE_ATTR_RO(reclaimed);
+
+static ssize_t recalled_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%llu\n", (u64)atomic64_read(&stats[RECALLED]));
+}
+CLEANCACHE_ATTR_RO(recalled);
+
+static ssize_t invalidated_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%llu\n", (u64)atomic64_read(&stats[INVALIDATED]));
+}
+CLEANCACHE_ATTR_RO(invalidated);
+
+static ssize_t cached_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	s64 dropped = atomic64_read(&stats[INVALIDATED]) +
+			atomic64_read(&stats[RECLAIMED]) +
+			atomic64_read(&stats[RECALLED]);
+
+	return sysfs_emit(buf, "%llu\n", (u64)(atomic64_read(&stats[STORED]) - dropped));
+}
+CLEANCACHE_ATTR_RO(cached);
+
+static struct attribute *cleancache_attrs[] = {
+	&stored_attr.attr,
+	&skipped_attr.attr,
+	&restored_attr.attr,
+	&missed_attr.attr,
+	&reclaimed_attr.attr,
+	&recalled_attr.attr,
+	&invalidated_attr.attr,
+	&cached_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(cleancache);
+
+#define CLEANCACHE_POOL_ATTR_RO(_name) \
+	static struct kobj_attribute _name##_pool_attr = {		\
+		.attr	= { .name = __stringify(_name), .mode = 0444 },	\
+		.show	= _name##_pool_show,				\
+}
+
+static ssize_t size_pool_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%llu\n",
+		(u64)atomic64_read(&kobj_to_stats(kobj)->stats[POOL_SIZE]));
+}
+CLEANCACHE_POOL_ATTR_RO(size);
+
+static ssize_t cached_pool_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%llu\n",
+		(u64)atomic64_read(&kobj_to_stats(kobj)->stats[POOL_CACHED]));
+}
+CLEANCACHE_POOL_ATTR_RO(cached);
+
+static ssize_t recalled_pool_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%llu\n",
+		(u64)atomic64_read(&kobj_to_stats(kobj)->stats[POOL_RECALLED]));
+}
+CLEANCACHE_POOL_ATTR_RO(recalled);
+
+
+static struct attribute *cleancache_pool_attrs[] = {
+	&size_pool_attr.attr,
+	&cached_pool_attr.attr,
+	&recalled_pool_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(cleancache_pool);
+
+static void cleancache_pool_release(struct kobject *kobj)
+{
+	kfree(kobj_to_stats(kobj));
+}
+
+static const struct kobj_type cleancache_pool_ktype = {
+	.release = &cleancache_pool_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = cleancache_pool_groups,
+};
+
+struct cleancache_pool_stats *cleancache_create_pool_stats(int pool_id)
+{
+	struct cleancache_pool_stats *pool_stats;
+
+	pool_stats = kzalloc(sizeof(*pool_stats), GFP_KERNEL);
+	if (!pool_stats)
+		return ERR_PTR(-ENOMEM);
+
+	pool_stats->pool_id = pool_id;
+
+	return pool_stats;
+}
+
+struct kobject * __init cleancache_sysfs_create_root(void)
+{
+	struct kobject *kobj;
+	int err;
+
+	kobj = kobject_create_and_add("cleancache", mm_kobj);
+	if (unlikely(!kobj)) {
+		pr_err("Failed to create cleancache kobject\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	err = sysfs_create_group(kobj, cleancache_groups[0]);
+	if (err) {
+		kobject_put(kobj);
+		pr_err("Failed to create cleancache group kobject\n");
+		return ERR_PTR(err);
+	}
+
+	return kobj;
+}
+
+int cleancache_sysfs_create_pool(struct kobject *root_kobj,
+				 struct cleancache_pool_stats *pool_stats,
+				 const char *name)
+{
+	return kobject_init_and_add(&pool_stats->kobj, &cleancache_pool_ktype,
+				    root_kobj, name);
+}
diff --git a/mm/cleancache_sysfs.h b/mm/cleancache_sysfs.h
new file mode 100644
index 000000000000..fb8d2a72be63
--- /dev/null
+++ b/mm/cleancache_sysfs.h
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __CLEANCACHE_SYSFS_H__
+#define __CLEANCACHE_SYSFS_H__
+
+enum cleancache_stat {
+	STORED,
+	SKIPPED,
+	RESTORED,
+	MISSED,
+	RECLAIMED,
+	RECALLED,
+	INVALIDATED,
+	CLEANCACHE_STAT_NR
+};
+
+enum cleancache_pool_stat {
+	POOL_SIZE,
+	POOL_CACHED,
+	POOL_RECALLED,
+	CLEANCACHE_POOL_STAT_NR
+};
+
+struct cleancache_pool_stats {
+	struct kobject kobj;
+	int pool_id;
+	atomic64_t stats[CLEANCACHE_POOL_STAT_NR];
+};
+
+#ifdef CONFIG_CLEANCACHE_SYSFS
+void cleancache_stat_inc(enum cleancache_stat type);
+void cleancache_stat_add(enum cleancache_stat type, unsigned long delta);
+void cleancache_pool_stat_inc(struct cleancache_pool_stats *pool_stats,
+			 enum cleancache_pool_stat type);
+void cleancache_pool_stat_dec(struct cleancache_pool_stats *pool_stats,
+			 enum cleancache_pool_stat type);
+void cleancache_pool_stat_add(struct cleancache_pool_stats *pool_stats,
+			 enum cleancache_pool_stat type, long delta);
+struct cleancache_pool_stats *cleancache_create_pool_stats(int pool_id);
+struct kobject * __init cleancache_sysfs_create_root(void);
+int cleancache_sysfs_create_pool(struct kobject *root_kobj,
+				 struct cleancache_pool_stats *pool_stats,
+				 const char *name);
+
+#else /* CONFIG_CLEANCACHE_SYSFS */
+static inline void cleancache_stat_inc(enum cleancache_stat type) {}
+static inline void cleancache_stat_add(enum cleancache_stat type, unsigned long delta) {}
+static inline void cleancache_pool_stat_inc(struct cleancache_pool_stats *pool_stats,
+				       enum cleancache_pool_stat type) {}
+static inline void cleancache_pool_stat_dec(struct cleancache_pool_stats *pool_stats,
+				       enum cleancache_pool_stat type) {}
+static inline void cleancache_pool_stat_add(struct cleancache_pool_stats *pool_stats,
+				       enum cleancache_pool_stat type, long delta) {}
+static inline
+struct cleancache_pool_stats *cleancache_create_pool_stats(int pool_id) { return NULL; }
+
+#endif /* CONFIG_CLEANCACHE_SYSFS */
+
+#endif /* __CLEANCACHE_SYSFS_H__ */
-- 
2.51.0.740.g6adb054d12-goog

