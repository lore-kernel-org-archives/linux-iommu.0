Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7614D23C8A0
	for <iommu@lists.linux.dev>; Fri, 10 Oct 2025 01:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760059205; cv=none; b=e4//2mzd2E8wzlQ0kiCoI/O0/wG7+Aw8bZGCCX6vT15LD8WH9JgTzK8tKq6g0UccY7g5KPWO14cIPLAP5tTMASCRmVrKYJ9Y9ibEnmBz0jYL4Jz6sKiav9pCP2MtJAQk8hDGb3+v2DEEla7SB0inHkLuVWb26nVk6FCx5ze+nx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760059205; c=relaxed/simple;
	bh=B/QFPXniGwEFGN4sNohbRDTRW/JKndUEcycvqtnTGMQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sGPb2YsxIQaNLPnAMeRI3j6kMGpSEMtGFXnAJehN6gj4+oRqXo1bqpIq/qbFaWN2xosxQxdiEiaB9EoZWQ/RUFUsovjAU6kl1L0AL75npKPc8qs2n62C8lsTt8bF4vLdBwN8xRPt0piAtc0rVD0Nw11YpwU7k/MrXdXckMkfT0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PIos4fRi; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PIos4fRi"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32ec69d22b2so3509218a91.1
        for <iommu@lists.linux.dev>; Thu, 09 Oct 2025 18:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760059203; x=1760664003; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qfFmaAKl937kSaDktiPuEwSl7VxkpxzCXx+g6sFaHjQ=;
        b=PIos4fRibwcIo12/Hcf0QeAH5lClU7eb16696f4eFqlO9dxZdPrm5KyiA78BuG/ZgT
         QKtHDTyL/Bh1pjhwwTPjU/o/seytwS8ooHXjM1vTDUtA6FI3BnZws7+NxNXE9V4Bf+V0
         LQRN2eTJrRD8i8M7yobcPI+BT+jsUvZNEnK122GW8qLEHVnp/d+SjYFMWUDX77KEIlUC
         2kzA8njTQKf19xDPiblGzNvw6BPXCECPGoPORWWmaV2vOLTzPvXb2YtJtcVt2oiRJmdT
         trGxEmXDXTGLJ1WZrHkHozDq6JDyc/ayZnYXshqwiJX7KfA3pApHu+qiJM/IjRO3S7Zu
         +VGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760059203; x=1760664003;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qfFmaAKl937kSaDktiPuEwSl7VxkpxzCXx+g6sFaHjQ=;
        b=gXac1eqw5Gem9Lw9Me5fVVzchto5QnSFr5T8xreFffSodYg8iAzAok1/UCPVh+c56e
         OpwMXYnjuVygogUDbytSaS/FtWW6j0NZI4zlh3JFnvR3IFS38WVWmWFocIseTmlAHe05
         7I2P9RShMCPa0mfzldH3DqVCfRR3hlmKxiURTgnJPs2n6UsXtahrmMcdY8TOgXV81wm0
         6+JkKC4+rXeAFKpPs1C0ageojZIFiNGJBsk69Qm+EOcx6qnYXhEj82T79szGVH3pUXNY
         7p1AAc2teVSFMxqfwR0KR22Av02CeVKVVhGxl0zfzIo9OOoOP089MvSWJQIPlo3MUlnz
         xC5A==
X-Forwarded-Encrypted: i=1; AJvYcCVakG/PSxMOha70xSRJd2uuSGladafiZaq0OyoOzyR+vagLk/d4bI9XNWnta3xlAZVmaVLUmw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwCcIvKYeyVaHnC54EmC77iacSJn3d+by3Bu758Ba6tW72isguN
	Pdrx5XB9pYCKmPHJg2fQePUPoeRmUhox6LMBwDhxHH9rml2/vDp6tr9PASKnr6xdJJkFL30gEX6
	wV45bdQ==
X-Google-Smtp-Source: AGHT+IFjOaBKWzMfb/TvgcjiAKDwb9C3QEg3GiheZ0wej2yAwCBPTptgb70zWp2JQn59IyW7GzdntSOdWLc=
X-Received: from pjbsr7.prod.google.com ([2002:a17:90b:4e87:b0:32e:e06a:4668])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1e07:b0:339:f09b:d372
 with SMTP id 98e67ed59e1d1-33b513b4c91mr13745970a91.23.1760059202712; Thu, 09
 Oct 2025 18:20:02 -0700 (PDT)
Date: Thu,  9 Oct 2025 18:19:46 -0700
In-Reply-To: <20251010011951.2136980-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20251010011951.2136980-1-surenb@google.com>
X-Mailer: git-send-email 2.51.0.740.g6adb054d12-goog
Message-ID: <20251010011951.2136980-4-surenb@google.com>
Subject: [PATCH 3/8] mm/cleancache: readahead support
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

Restore pages from the cleancache during readahead operation.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/cleancache.h | 17 +++++++++++
 mm/cleancache.c            | 59 ++++++++++++++++++++++++++++++++++++++
 mm/readahead.c             | 55 +++++++++++++++++++++++++++++++++++
 3 files changed, 131 insertions(+)

diff --git a/include/linux/cleancache.h b/include/linux/cleancache.h
index 458a7a25a8af..28b6d7b25964 100644
--- a/include/linux/cleancache.h
+++ b/include/linux/cleancache.h
@@ -11,6 +11,7 @@
 
 #define CLEANCACHE_KEY_MAX	6
 
+struct cleancache_inode;
 
 #ifdef CONFIG_CLEANCACHE
 
@@ -24,6 +25,14 @@ bool cleancache_invalidate_folio(struct address_space *mapping,
 bool cleancache_invalidate_inode(struct address_space *mapping,
 				 struct inode *inode);
 
+struct cleancache_inode *
+cleancache_start_inode_walk(struct address_space *mapping,
+			    struct inode *inode,
+			    unsigned long count);
+void cleancache_end_inode_walk(struct cleancache_inode *ccinode);
+bool cleancache_restore_from_inode(struct cleancache_inode *ccinode,
+				   struct folio *folio);
+
 /*
  * Backend API
  *
@@ -53,6 +62,14 @@ static inline bool cleancache_invalidate_folio(struct address_space *mapping,
 static inline bool cleancache_invalidate_inode(struct address_space *mapping,
 					       struct inode *inode)
 		{ return false; }
+static inline struct cleancache_inode *
+cleancache_start_inode_walk(struct address_space *mapping, struct inode *inode,
+			    unsigned long count)
+		{ return NULL; }
+static inline void cleancache_end_inode_walk(struct cleancache_inode *ccinode) {}
+static inline bool cleancache_restore_from_inode(struct cleancache_inode *ccinode,
+						 struct folio *folio)
+		{ return false; }
 static inline int cleancache_backend_register_pool(const char *name)
 		{ return -EOPNOTSUPP; }
 static inline int cleancache_backend_get_folio(int pool_id, struct folio *folio)
diff --git a/mm/cleancache.c b/mm/cleancache.c
index 73a8b2655def..59b8fd309619 100644
--- a/mm/cleancache.c
+++ b/mm/cleancache.c
@@ -813,6 +813,65 @@ bool cleancache_invalidate_inode(struct address_space *mapping,
 	return count > 0;
 }
 
+struct cleancache_inode *
+cleancache_start_inode_walk(struct address_space *mapping, struct inode *inode,
+			    unsigned long count)
+{
+	struct cleancache_inode *ccinode;
+	struct cleancache_fs *fs;
+	int fs_id;
+
+	if (!inode)
+		return ERR_PTR(-EINVAL);
+
+	fs_id = mapping->host->i_sb->cleancache_id;
+	if (fs_id == CLEANCACHE_ID_INVALID)
+		return ERR_PTR(-EINVAL);
+
+	fs = get_fs(fs_id);
+	if (!fs)
+		return NULL;
+
+	ccinode = find_and_get_inode(fs, inode);
+	if (!ccinode) {
+		put_fs(fs);
+		return NULL;
+	}
+
+	return ccinode;
+}
+
+void cleancache_end_inode_walk(struct cleancache_inode *ccinode)
+{
+	struct cleancache_fs *fs = ccinode->fs;
+
+	put_inode(ccinode);
+	put_fs(fs);
+}
+
+bool cleancache_restore_from_inode(struct cleancache_inode *ccinode,
+				   struct folio *folio)
+{
+	struct folio *stored_folio;
+	void *src, *dst;
+	bool ret = false;
+
+	xa_lock(&ccinode->folios);
+	stored_folio = xa_load(&ccinode->folios, folio->index);
+	if (stored_folio) {
+		rotate_lru_folio(stored_folio);
+		src = kmap_local_folio(stored_folio, 0);
+		dst = kmap_local_folio(folio, 0);
+		memcpy(dst, src, PAGE_SIZE);
+		kunmap_local(dst);
+		kunmap_local(src);
+		ret = true;
+	}
+	xa_unlock(&ccinode->folios);
+
+	return ret;
+}
+
 /* Backend API */
 /*
  * Register a new backend and add its folios for cleancache to use.
diff --git a/mm/readahead.c b/mm/readahead.c
index 3a4b5d58eeb6..6f4986a5e14a 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -128,6 +128,7 @@
 #include <linux/blk-cgroup.h>
 #include <linux/fadvise.h>
 #include <linux/sched/mm.h>
+#include <linux/cleancache.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/readahead.h>
@@ -146,12 +147,66 @@ file_ra_state_init(struct file_ra_state *ra, struct address_space *mapping)
 }
 EXPORT_SYMBOL_GPL(file_ra_state_init);
 
+static inline bool restore_from_cleancache(struct readahead_control *rac)
+{
+	XA_STATE(xas, &rac->mapping->i_pages, rac->_index);
+	struct cleancache_inode *ccinode;
+	struct folio *folio;
+	unsigned long end;
+	bool ret = true;
+
+	int count = readahead_count(rac);
+
+	/* Readahead should not have started yet. */
+	VM_BUG_ON(rac->_batch_count != 0);
+
+	if (!count)
+		return true;
+
+	ccinode = cleancache_start_inode_walk(rac->mapping, rac->mapping->host,
+					      count);
+	if (!ccinode)
+		return false;
+
+	end = rac->_index + rac->_nr_pages - 1;
+	xas_for_each(&xas, folio, end) {
+		unsigned long nr;
+
+		if (xas_retry(&xas, folio)) {
+			ret = false;
+			break;
+		}
+
+		if (!cleancache_restore_from_inode(ccinode, folio)) {
+			ret = false;
+			break;
+		}
+
+		nr = folio_nr_pages(folio);
+		folio_mark_uptodate(folio);
+		folio_unlock(folio);
+		rac->_index += nr;
+		rac->_nr_pages -= nr;
+		rac->ra->size -= nr;
+		if (rac->ra->async_size >= nr)
+			rac->ra->async_size -= nr;
+	}
+
+	cleancache_end_inode_walk(ccinode);
+
+	return ret;
+}
+
 static void read_pages(struct readahead_control *rac)
 {
 	const struct address_space_operations *aops = rac->mapping->a_ops;
 	struct folio *folio;
 	struct blk_plug plug;
 
+	/* Try to read all pages from the cleancache */
+	if (restore_from_cleancache(rac))
+		return;
+
 	if (!readahead_count(rac))
 		return;
 
-- 
2.51.0.740.g6adb054d12-goog

