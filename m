Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C59E2FE057
	for <iommu@lists.linux.dev>; Sun, 26 Oct 2025 20:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761510983; cv=none; b=IJnKNRwzHh3jqoSwu+B5nR1bvMB3dBb8Vq5E7vIZ6FbL03mvjdiJMR3PtFtQgSipvo/6+KsAX635q/7D0mA2AGSgAiuLLukmLzDm9jL5UhhgQN1USeq7/z4bZg2nQn1S17Kakm3has7b8EHHonT05SSo1fBDAies2MC7uTrw+Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761510983; c=relaxed/simple;
	bh=QuxbnIJY4zttbFleGXLAX5MQ12fDQs4gIZS1TSv63Bk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l7IMSKA1uJ6NuaNDuVvtXZJ3EgF+2vTFNEFkF99YusFYfbXQzvYAjClTw6biWafRfPY2rTQcuOs0XXqOXTcAkfwTTn3f3dDELbc7IxLwA7Cpc0pOkCZ4wOsskgs9Bk+VeRLbSZ29GZ9A6unTfLAb0VBBxzVeyZdlquup9hbgdWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dlOuGJME; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dlOuGJME"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-785ebbc739aso20317267b3.1
        for <iommu@lists.linux.dev>; Sun, 26 Oct 2025 13:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761510980; x=1762115780; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IMCyHr31TLzATbQuHg3ruEQF/2874D74tyKjOOWzy0s=;
        b=dlOuGJMEmWyDbI8TzK7kqTGbkEJ/lCpuK/ti0xpZSDeMwPuCKSfEJgHKM2z0N3XI7Y
         JSrPDS2lSzTSmJcDTJ2E89eCR4mPij6vf+eRL7GnMNY3xL4ahBClorOdwcEJUSKSoW4q
         MivoySTJupeIQfh3kTBdtyEadWNGEKJfvJChInFdVU/8CR+gMVO7sy88iN9VHad0B61X
         XHgPV+kqRhxV0hZS1usLB5AELYuMsXQqcnm4/rvWZUvY7ikrsD1SSQO4n1+duhcohoKJ
         zO62643mQ/JPGoM5lwPuNWFIa1JU3W6rhlZGd6javqLX521qg8deXeM1Y7C8j1mMP5Qt
         lddQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761510980; x=1762115780;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IMCyHr31TLzATbQuHg3ruEQF/2874D74tyKjOOWzy0s=;
        b=Nu9knVsFaXWm1VH88H4t2GBg4va33xXvCVXlcX3QTDrJNYCdU9XC7cr10cj4FQ4C28
         lbX7HTF5c02Fnd3pj1i7on3tu+sFthq7+MhPuQwutFxmGQhFgm2Vtk3a58L8f+C4tSp4
         uIGp0BeYHluDJ44rJ8rshAMYdLQ86N2s8HpiJGLGgH29wWjDqOg3y2/3ZwQOqAUP86r3
         XVm/hdOQUeQAv8VrbEE/V5O/o57E17A6Y6qGe7VsvE9A1zSTkL7Pe2EYMr+mSfEulOMq
         cRXDzw4WfE9gEvKMH46ULMCYs4QO+yAQjdOwwCVzG9gpShASSSN2UMf3os40U/xkKQh+
         n4sg==
X-Forwarded-Encrypted: i=1; AJvYcCUiKpdbJjP79UZjw38RP4+hh32hx79dmiuIWNsEoJC9qLR3Zumrd9C8m7/jfO4JGmROCiR4FQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywj1QJdPtoQdbx2VQqMzF7V7tp3g1k/QZI3pef0YI2lb1YmaT/S
	1JdPg/v3VyWqi0p4QByEA3/iWetq6gxZoMuaegdGCWywZRCA49ERqj8Joe1UeLSim3RF9hqcxjk
	O8wi8lw==
X-Google-Smtp-Source: AGHT+IHpMr9cFr0H62WPICb/ViZzGU3rsCsk6GeJaW1ZdGu5t8yZ0ftElBAnf4rqpT99zJhDJFFFka8CTI4=
X-Received: from ywa1.prod.google.com ([2002:a05:690c:9401:b0:785:bb80:f2f5])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:690c:f88:b0:784:9419:2787
 with SMTP id 00721157ae682-78494193880mr250052107b3.69.1761510979847; Sun, 26
 Oct 2025 13:36:19 -0700 (PDT)
Date: Sun, 26 Oct 2025 13:36:05 -0700
In-Reply-To: <20251026203611.1608903-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20251026203611.1608903-1-surenb@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251026203611.1608903-3-surenb@google.com>
Subject: [PATCH v2 2/8] mm/cleancache: add cleancache LRU for folio aging
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
	iommu@lists.linux.dev, Minchan Kim <minchan@google.com>
Content-Type: text/plain; charset="UTF-8"

Once all folios in the cleancache are used to store data from previously
evicted folios, no more data can be stored there. To avoid that situation
we can drop older data and make space for new one.
Add an LRU for cleancache folios to reclaim the oldest folio when
cleancache is full and we need to store a new folio.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Minchan Kim <minchan@google.com>
---
 mm/cleancache.c | 91 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 89 insertions(+), 2 deletions(-)

diff --git a/mm/cleancache.c b/mm/cleancache.c
index 26fb91b987b7..3acf46c0cdd1 100644
--- a/mm/cleancache.c
+++ b/mm/cleancache.c
@@ -18,6 +18,13 @@
  *
  *	ccinode->folios.xa_lock
  *		pool->lock
+ *
+ *	ccinode->folios.xa_lock
+ *		lru_lock
+ *
+ *	ccinode->folios.xa_lock
+ *		lru_lock
+ *			pool->lock
  */
 
 #define INODE_HASH_BITS		6
@@ -58,6 +65,8 @@ static struct kmem_cache *slab_inode; /* cleancache_inode slab */
 static struct cleancache_pool pools[CLEANCACHE_MAX_POOLS];
 static atomic_t nr_pools = ATOMIC_INIT(0);
 static DEFINE_SPINLOCK(pools_lock); /* protects pools */
+static LIST_HEAD(cleancache_lru);
+static DEFINE_SPINLOCK(lru_lock); /* protects cleancache_lru */
 
 static inline void init_cleancache_folio(struct folio *folio, int pool_id)
 {
@@ -73,6 +82,7 @@ static inline void clear_cleancache_folio(struct folio *folio)
 {
 	/* Folio must be detached and not in the pool. No locking is needed. */
 	VM_BUG_ON(folio->cc_inode);
+	VM_BUG_ON(!list_empty(&folio->lru));
 
 	folio->cc_pool_id = -1;
 }
@@ -123,6 +133,7 @@ static inline bool is_folio_attached(struct folio *folio)
 /*
  * Folio pool helpers.
  *	Only detached folios are stored in the pool->folio_list.
+ *	Once a folio gets attached, it's placed on the cleancache LRU list.
  *
  * Locking:
  *	pool->folio_list is accessed under pool->lock.
@@ -174,6 +185,32 @@ static struct folio *pick_folio_from_any_pool(void)
 	return folio;
 }
 
+/* Folio LRU helpers. Only attached folios are stored in the cleancache_lru. */
+static void add_folio_to_lru(struct folio *folio)
+{
+	VM_BUG_ON(!list_empty(&folio->lru));
+
+	spin_lock(&lru_lock);
+	list_add(&folio->lru, &cleancache_lru);
+	spin_unlock(&lru_lock);
+}
+
+static void rotate_lru_folio(struct folio *folio)
+{
+	spin_lock(&lru_lock);
+	if (!list_empty(&folio->lru))
+		list_move(&folio->lru, &cleancache_lru);
+	spin_unlock(&lru_lock);
+}
+
+static void delete_folio_from_lru(struct folio *folio)
+{
+	spin_lock(&lru_lock);
+	if (!list_empty(&folio->lru))
+		list_del_init(&folio->lru);
+	spin_unlock(&lru_lock);
+}
+
 /* FS helpers */
 static struct cleancache_fs *get_fs(int fs_id)
 {
@@ -306,6 +343,7 @@ static void erase_folio_from_inode(struct cleancache_inode *ccinode,
 
 	removed = __xa_erase(&ccinode->folios, offset);
 	VM_BUG_ON(!removed);
+	delete_folio_from_lru(folio);
 	remove_inode_if_empty(ccinode);
 }
 
@@ -403,6 +441,48 @@ static struct cleancache_inode *add_and_get_inode(struct cleancache_fs *fs,
 	return ccinode;
 }
 
+static struct folio *reclaim_folio_from_lru(void)
+{
+	struct cleancache_inode *ccinode;
+	struct folio *folio;
+	pgoff_t offset;
+
+again:
+	spin_lock(&lru_lock);
+	if (list_empty(&cleancache_lru)) {
+		spin_unlock(&lru_lock);
+		return NULL;
+	}
+	ccinode = NULL;
+	/* Get the ccinode of the folio at the LRU tail */
+	list_for_each_entry_reverse(folio, &cleancache_lru, lru) {
+		struct cleancache_pool *pool = folio_pool(folio);
+
+		/* Find and get ccinode */
+		spin_lock(&pool->lock);
+		folio_attachment(folio, &ccinode, &offset);
+		if (ccinode && !get_inode(ccinode))
+			ccinode = NULL;
+		spin_unlock(&pool->lock);
+		if (ccinode)
+			break;
+	}
+	spin_unlock(&lru_lock);
+
+	if (!ccinode)
+		return NULL; /* No ccinode to reclaim */
+
+	if (!isolate_folio_from_inode(ccinode, offset, folio)) {
+		/* Retry if the folio got erased from the ccinode */
+		put_inode(ccinode);
+		goto again;
+	}
+
+	put_inode(ccinode);
+
+	return folio;
+}
+
 static void copy_folio_content(struct folio *from, struct folio *to)
 {
 	void *src = kmap_local_folio(from, 0);
@@ -458,14 +538,19 @@ static bool store_into_inode(struct cleancache_fs *fs,
 			move_folio_from_inode_to_pool(ccinode, offset, stored_folio);
 			goto out_unlock;
 		}
+		rotate_lru_folio(stored_folio);
 	} else {
 		if (!workingset)
 			goto out_unlock;
 
 		stored_folio = pick_folio_from_any_pool();
 		if (!stored_folio) {
-			/* No free folios, TODO: try reclaiming */
-			goto out_unlock;
+			/* No free folios, try reclaiming */
+			xa_unlock(&ccinode->folios);
+			stored_folio = reclaim_folio_from_lru();
+			xa_lock(&ccinode->folios);
+			if (!stored_folio)
+				goto out_unlock;
 		}
 
 		if (!store_folio_in_inode(ccinode, offset, stored_folio)) {
@@ -477,6 +562,7 @@ static bool store_into_inode(struct cleancache_fs *fs,
 			spin_unlock(&pool->lock);
 			goto out_unlock;
 		}
+		add_folio_to_lru(stored_folio);
 	}
 	copy_folio_content(folio, stored_folio);
 
@@ -506,6 +592,7 @@ static bool load_from_inode(struct cleancache_fs *fs,
 	xa_lock(&ccinode->folios);
 	stored_folio = xa_load(&ccinode->folios, offset);
 	if (stored_folio) {
+		rotate_lru_folio(stored_folio);
 		copy_folio_content(stored_folio, folio);
 		ret = true;
 	}
-- 
2.51.1.851.g4ebd6896fd-goog

