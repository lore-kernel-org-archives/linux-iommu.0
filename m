Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DB1258EFE
	for <iommu@lists.linux.dev>; Fri, 10 Oct 2025 01:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760059213; cv=none; b=BEWMcI5F8rk+1wKZOWBP0pVNNvVRiYXNeqBB7QjhfKs0Z/f2QtqwlM3B4oPhedFCYWvbBnHqWLjMkRlau0+yOcqvSZZthjBPBOVbBFrsXNLboc1bkgI7sH40WEWALMcv0UyciDE7cq8qd29o3rf91RKbfm5Mxo7Z07TMb265YSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760059213; c=relaxed/simple;
	bh=NHw3RZ90+Da7UyHMBKVXx8p20p9oL5hkY0RUKVTk0us=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nBpby81NDmSZhGkogJhnn9tA+56mRms2soiue7795mneaSAv3he5qRP+hByzYEp3vvYTZVScQLMuKDVobGvd8mi+nUoibA9JSccC4cvo9Y1TX/K63FMIDD3gi/nB1kedEmnxBImsvxoqI/Vyinl8wJQ/0WlwySIUQDp5fSSYo0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FKETGBzW; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FKETGBzW"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b557abaad02so3736373a12.3
        for <iommu@lists.linux.dev>; Thu, 09 Oct 2025 18:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760059210; x=1760664010; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TF3568yP8arSICTc3vnXw7wkTlYOmrE0XKsy2eUArt4=;
        b=FKETGBzWpLFjgCfD/KypSNa0RdBy/lUqu74J4s5NdVkb7iQsOafVLRIfBYYV9JE2PJ
         qHjoM6GzoO+9LHtOi90x4KsQp/4U8DeB8UrfIz77G9onssM0YFm5xktE3mFL7YSfNn/6
         qeMXayufWJ9pe9XufqRtBrTVWpC0007P7dpeAy+VPT9DbpOXrKVWuA1qiHjSo1/trJQM
         /tiRqGPJg/Hbv3IOOj3t1SqJxwKb1k4MbaRpl8Hx+kgOg4yqvjpsIwiicjLYEix/HKph
         clE/byC7AA1Iw15+CzjK1eGLhp/hDKb+5K/KThovtdSiIPJReYBTIXNUH9PC9gMWjIUz
         qIbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760059210; x=1760664010;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TF3568yP8arSICTc3vnXw7wkTlYOmrE0XKsy2eUArt4=;
        b=cNVMTehAk8AoddyhWgcPxJD4yIdjX45QzS0U4NmUrlPFweIHlRXzRR95JyhsaA+x18
         Ji4XZYVTkFqsVhrkAAefyCFJEDH5/zEtVSGIs+PFCe3Mi6XiWisAlgW0TuGUyE7iSzID
         Kso5f8jQohUuB4Y1cXKyuK9vfTlkhYK8kx8+3fCGEbb4IxI1OCV96d+mlRy04ezVXvnH
         ZAG405qkeYMbTp4TNSpinEo3OBAxRWMOcXyBCt1CKG8RMcEYq0/61uzOpaPdqxr8EShw
         /f7lcnOrBlQLGHWjU2EpbEreQwJ3f8yfJm8ZKzV68t/ZxTn4suxoIb4GPQDOmI7dU2J5
         OOAg==
X-Forwarded-Encrypted: i=1; AJvYcCWBlEaNYkOTRzBLSbWnJS90sNbgZbFoAS77uAROcGq/8DoBtkFON2397L3TWDTmoFzgRJrUXA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwDn7BHKFqDogREsSSTxc3b0CCpoLBynvAn39nDRT8jtXJdJxtJ
	/qb02Y6a/K9LU8u/AzbSenDiLWXJOXPJ6zfItz0VsNZ5dRQTOxj7Kii9m12OOgGqhY6W6e0QO5w
	zbwnCYg==
X-Google-Smtp-Source: AGHT+IHpnUj2OMWlXlYxp3ZZZRkgvkpKUji8FWq+Is/jpL7rJv/HUvTEG2aUVmhGkdq+yIG7uf4JBu02rqQ=
X-Received: from pgbcq6.prod.google.com ([2002:a05:6a02:4086:b0:b49:de56:6e3c])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:431f:b0:32d:80ab:7132
 with SMTP id adf61e73a8af0-32da83de283mr12170415637.37.1760059209572; Thu, 09
 Oct 2025 18:20:09 -0700 (PDT)
Date: Thu,  9 Oct 2025 18:19:49 -0700
In-Reply-To: <20251010011951.2136980-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20251010011951.2136980-1-surenb@google.com>
X-Mailer: git-send-email 2.51.0.740.g6adb054d12-goog
Message-ID: <20251010011951.2136980-7-surenb@google.com>
Subject: [PATCH 6/8] add cleancache documentation
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

Document cleancache, it's APIs and sysfs interface.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 Documentation/mm/cleancache.rst | 112 ++++++++++++++++++++++++++++++++
 MAINTAINERS                     |   1 +
 2 files changed, 113 insertions(+)
 create mode 100644 Documentation/mm/cleancache.rst

diff --git a/Documentation/mm/cleancache.rst b/Documentation/mm/cleancache.rst
new file mode 100644
index 000000000000..deaf7de51829
--- /dev/null
+++ b/Documentation/mm/cleancache.rst
@@ -0,0 +1,112 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==========
+Cleancache
+==========
+
+Motivation
+==========
+
+Cleancache is a feature to utilize unused reserved memory for extending
+page cache.
+
+Cleancache can be thought of as a folio-granularity victim cache for clean
+file-backed pages that the kernel's pageframe replacement algorithm (PFRA)
+would like to keep around, but can't since there isn't enough memory. So
+when the PFRA "evicts" a folio, it stores the data contained in the folio
+into cleancache memory which is not directly accessible or addressable by
+the kernel (transcendent memory) and is of unknown and possibly
+time-varying size.
+
+Later, when a filesystem wishes to access a folio in a file on disk, it
+first checks cleancache to see if it already contains required data; if it
+does, the folio data is copied into the kernel and a disk access is
+avoided.
+
+The memory cleancache uses is donated by other system components, which
+reserve memory not directly addressable by the kernel. By donating this
+memory to cleancache, the memory owner enables its utilization while it
+is not used. Memory donation is done using cleancache backend API and any
+donated memory can be taken back at any time by its donor without no delay
+and with guarantees success. Since cleancache uses this memory only to
+store clean file-backed data, it can be dropped at any time and therefore
+the donor's request to take back the memory can be always satisfied.
+
+Implementation Overview
+=======================
+
+Cleancache "backend" (donor that provides transcendent memory), registers
+itself with cleancache "frontend" and received a unique pool_id which it
+can use in all later API calls to identify the pool of folios it donates.
+Once registered, backend can call cleancache_backend_put_folio() or
+cleancache_backend_put_folios() to donate memory to cleancache. Note that
+cleancache currently supports only 0-order folios and will not accept
+larger-order ones. Once the backend needs that memory back, it can get it
+by calling cleancache_backend_get_folio(). Only the original backend can
+take the folio it donated from the cleancache.
+
+Kernel uses cleancache by first calling cleancache_add_fs() to register
+each file system and then using a combination of cleancache_store_folio(),
+cleancache_restore_folio(), cleancache_invalidate_{folio|inode} to store,
+restore and invalidate folio content.
+cleancache_{start|end}_inode_walk() are used to walk over folios inside
+an inode and cleancache_restore_from_inode() is used to restore folios
+during such walks.
+
+From kernel's point of view folios which are copied into cleancache have
+an indefinite lifetime which is completely unknowable by the kernel and so
+may or may not still be in cleancache at any later time. Thus, as its name
+implies, cleancache is not suitable for dirty folios. Cleancache has
+complete discretion over what folios to preserve and what folios to discard
+and when.
+
+Cleancache Performance Metrics
+==============================
+
+If CONFIG_CLEANCACHE_SYSFS is enabled, monitoring of cleancache performance
+can be done via sysfs in the `/sys/kernel/mm/cleancache` directory.
+The effectiveness of cleancache can be measured (across all filesystems)
+with provided stats.
+Global stats are published directly under `/sys/kernel/mm/cleancache` and
+include:
+
+``stored``
+	number of successful cleancache folio stores.
+
+``skipped``
+	number of folios skipped during cleancache store operation.
+
+``restored``
+	number of successful cleancache folio restore operations.
+
+``missed``
+	number of failed cleancache folio restore operations.
+
+``reclaimed``
+	number of folios reclaimed from the cleancache due to insufficient
+	memory.
+
+``recalled``
+	number of times cleancache folio content was discarded as a result
+	of the cleancache backend taking the folio back.
+
+``invalidated``
+	number of times cleancache folio content was discarded as a result
+	of invalidation.
+
+``cached``
+	number of folios currently cached in the cleancache.
+
+Per-pool stats are published under `/sys/kernel/mm/cleancache/<pool name>`
+where "pool name" is the name pool was registered under. These stats
+include:
+
+``size``
+	number of folios donated to this pool.
+
+``cached``
+	number of folios currently cached in the pool.
+
+``recalled``
+	number of times cleancache folio content was discarded as a result
+	of the cleancache backend taking the folio back from the pool.
diff --git a/MAINTAINERS b/MAINTAINERS
index 1c97227e7ffa..441e68c94177 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6053,6 +6053,7 @@ CLEANCACHE
 M:	Suren Baghdasaryan <surenb@google.com>
 L:	linux-mm@kvack.org
 S:	Maintained
+F:	Documentation/mm/cleancache.rst
 F:	include/linux/cleancache.h
 F:	mm/cleancache.c
 F:	mm/cleancache_sysfs.c
-- 
2.51.0.740.g6adb054d12-goog

