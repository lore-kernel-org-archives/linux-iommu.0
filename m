Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE1226B0B3
	for <iommu@lists.linux.dev>; Sun, 26 Oct 2025 20:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761510978; cv=none; b=eg9SKlgOdO8w5wHKczRo4JvYXg7ajwiyybO2yiHWySP+NhTUhZNrMnCG+3hPAVImEMsaQD8FzFz668oDRrIcXAixOpHSI+msvC5/db3nyLafECdYhhcZllGRU+n3WvN6xKakHUfk3c9u2utsQI705/I5BAlsLiw0i4snWBR8qeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761510978; c=relaxed/simple;
	bh=EtPHM/rxvf1s6wpudENnj+c1ViV9senew6m5yYbiKog=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=LVboPAty4zzzzW507nT22PXTFrXwN06cCmB2bSIsVmP7PKoJOOQ1zNKD5sJL57EjrupCYqBgjmGXOUzS8QbVETRmSqE9pDogO+r928XoOOhK6rKqNWLUDDUWp28FB8hCggb9+9iPhdktLl/didX5lvnuwQ+fUzqZb5bzz1ZFMWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CuT4oOGz; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CuT4oOGz"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-7837a5e5b46so56492847b3.0
        for <iommu@lists.linux.dev>; Sun, 26 Oct 2025 13:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761510976; x=1762115776; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oIYNgmwaiZev52ielsOny0g8kp/qW6C19JMGXvUOw8g=;
        b=CuT4oOGzSDDPCqA81zAzR5LUhPhNxgSbufQgaW5WUnDStOnx4yuKQ9eaKz8+MxKqy3
         iPoRdsEWyjhVPaEsha7Jh6sDaZx0jwGzh8Unkim/18fh89i7qlT5ujbKq6gj0xy0GZip
         jGLMu3CvSHCU5kqixLV7saPST6B/u73x3haAu4tWTffqEqkJeHu5sNuRbwsAM2UIaj9u
         yWWzhNr0db5Nsnm7ebgkmtV8DKUppBqnREyaskFKIN4iglv4UKncEYkW0+998dkuc9FX
         Poju/GulhGFHOCNS6VYKYeUlMlAE1twF0ssVtnbtFg6IwBAtm5K7uNY7TGu3tnuCOo/r
         Wc1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761510976; x=1762115776;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oIYNgmwaiZev52ielsOny0g8kp/qW6C19JMGXvUOw8g=;
        b=KhIgkAs3SZGxvy1E43OceKdzsLONs3D7J532vb45VLi72Aycnq69ZWLwWhRCnfcmhi
         m6GNUShfoAw1RV4vIDw7oLAfqdhSFl9wZ/s24yZs0MO2XslOpOPtcH7dKqmJHSPIIfBb
         uwzzfsWaN+lSZwDV2a+CCrmtj61rJFZWJB9kuzeArWuTQHLfbR7BMPo7lWluSqS8B53J
         x98odYEL61pE/b/APv9EuxkYYKp3/drvZOdGy0Pr8IDW087P3tu9iim6eVyOmKIeU6Gl
         fLge52e0SEWTUZ7OVJ+9VgTq8ClUmBEZVEc3qiIjbVvunipdKknwzVx1jutMCw6jxZTz
         2PmA==
X-Forwarded-Encrypted: i=1; AJvYcCVtm4mctinHsdlGyfwGlXwe5BrkEF7NXyCKyya8R6rHZAyGl3Jc7nzn6nqs/HHicQ6sd37KzA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzHim3puEFs074p70MfepBx45hTzwQf8wI2YDVgZxVm9bEIwg4t
	kr2Or9T+j/5SCL9pCTIgUt+vP61vG5M/CpmTEtWh8QDbsvttElMoLMQmahXFI+RL23+X0suP5jK
	87Istow==
X-Google-Smtp-Source: AGHT+IEQ9Pwyyd7kjVHYsKEBM6jXV+KGbNmmj3ZfQc3rnB2XqZ4bQZDKRwRIjK4vvzIoUgZwP2mnd9XDO/0=
X-Received: from yxdd3.prod.google.com ([2002:a05:690e:2443:b0:63f:2d9a:656b])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:690c:9a07:b0:784:8620:1c49
 with SMTP id 00721157ae682-78486201eacmr444866607b3.30.1761510975632; Sun, 26
 Oct 2025 13:36:15 -0700 (PDT)
Date: Sun, 26 Oct 2025 13:36:03 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251026203611.1608903-1-surenb@google.com>
Subject: [PATCH v2 0/8] Guaranteed CMA
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

Guaranteed CMA (GCMA) is designed to improve utilization of reserved
memory carveouts without compromising their advantages of:
1. Guaranteed success of allocation (as long as total allocation size is
below the size of the reservation.
2. Low allocation latency.
The idea is that carved out memory when not used for its primary purpose
can be donated and used as an extension of the pagecache and any donated
folio can be taken back at any moment with minimal latency and guaranteed
success.

To achieve this, GCMA needs to use memory that is not addressable by the
kernel (can't be pinned) and that contains content that can be discarded.
To provide such memory we reintroduce cleancache idea [1] with two major
changes. New implementation:
1. Avoids intrusive hooks into filesystem code, limiting them to two hooks
for filesystem mount/unmount events and a hook for bdev invalidation.
2. Manages inode to folio association and handles pools of donated folios
inside cleancache itself, freeing backends of this burden.

Cleancache provides a simple interface to its backends which lets them
donate folios to cleancache, take a folio back for own use and return the
folio back to cleancache when not needed.

With cleancache in place, GCMA becomes a thin layer linking CMA allocator
to cleancache, which allows existing CMA API to be used for continuous
memory allocations with additional guarantees listed above.
The limitation of GCMA is that its donated memory can be used only to
extend file-backed pagecache. Note that both CMA and GCMA can be used
at the same time.

Accounting for folios allocated from GCMA is implemented the same way as
for CMA. The reasoning is that both CMA and GCMA use reserved memory for
contiguous allocations with the only difference in how that memory gets
donated while not in use. CMA donates its memory to the system for movable
allocations with expectation that it will be returned when it is needed.
GCMA donatest its memory to cleancache with the same expectation. Once CMA
or GCMA use that memory for contiguous allocation, the difference between
them disappears, therefore accounting at that point should not differ.

The patchset borrows some ideas and code from previous implementations of
the cleancache and GCMA [2] as well as Android's reference patchset [3]
implemented by Minchan Kim and used by many Android vendors.

[1] https://elixir.bootlin.com/linux/v5.16.20/source/Documentation/vm/cleancache.rst
[2] https://lore.kernel.org/lkml/1424721263-25314-1-git-send-email-sj38.park@gmail.com/
[3] https://android-review.googlesource.com/q/topic:%22gcma_6.12%22

Patchset is based on mm-new.

Changes since v1 [1]:
- Removed extra address_space parameter in cleancache hooks,
per Matthew Wilcox
- Updated comments to replace page with folio, per Matthew Wilcox
- Removed unnecessary new abbreviations from Kconfig, changelog and
documentation, per Matthew Wilcox
- Removed unnecessary comment about lock protecting xarray,
per Matthew Wilcox
- Replaced IDR with xarray for storage, per Matthew Wilcox
- Added unions in the folio for aliased fields, per Matthew Wilcox
- Removed an unused variable in the test, per kernel test robot
- Linked the cleancache document in mm/index.rst, per SeongJae Park
- Split cleancache sysfs documenation into cleancache_sysfs.rst and
linked it in Documentation/admin-guide/mm/index.rst, per SeongJae Park
- Cleaned up free_folio_range() code, per SeongJae Park
- Reworked gcma_free_range() to handle failures and properly rollback
refcount changes, per SeongJae Park
- Removed references to transcendent memory, per SeongJae Park
- Other minor documentation fixups, per SeongJae Park
- Added Minchan Kim as cleancache maintainer
- Minor code and documentation cleanups

Minchan Kim (1):
  mm: introduce GCMA

Suren Baghdasaryan (7):
  mm: implement cleancache
  mm/cleancache: add cleancache LRU for folio aging
  mm/cleancache: readahead support
  mm/cleancache: add sysfs interface
  mm/tests: add cleancache kunit test
  add cleancache documentation
  mm: integrate GCMA with CMA using dt-bindings

 .../admin-guide/mm/cleancache_sysfs.rst       |   51 +
 Documentation/admin-guide/mm/index.rst        |    1 +
 Documentation/mm/cleancache.rst               |   68 +
 Documentation/mm/index.rst                    |    1 +
 MAINTAINERS                                   |   15 +
 block/bdev.c                                  |    6 +
 fs/super.c                                    |    3 +
 include/linux/cleancache.h                    |   77 ++
 include/linux/cma.h                           |   11 +-
 include/linux/fs.h                            |    6 +
 include/linux/gcma.h                          |   36 +
 include/linux/mm_types.h                      |   12 +-
 include/linux/pagemap.h                       |    1 +
 kernel/dma/contiguous.c                       |   11 +-
 mm/Kconfig                                    |   39 +
 mm/Kconfig.debug                              |   13 +
 mm/Makefile                                   |    4 +
 mm/cleancache.c                               | 1127 +++++++++++++++++
 mm/cleancache_sysfs.c                         |  209 +++
 mm/cleancache_sysfs.h                         |   58 +
 mm/cma.c                                      |   37 +-
 mm/cma.h                                      |    1 +
 mm/cma_sysfs.c                                |   10 +
 mm/filemap.c                                  |   26 +
 mm/gcma.c                                     |  244 ++++
 mm/readahead.c                                |   54 +
 mm/tests/Makefile                             |    6 +
 mm/tests/cleancache_kunit.c                   |  420 ++++++
 mm/truncate.c                                 |    4 +
 mm/vmscan.c                                   |    1 +
 30 files changed, 2537 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/admin-guide/mm/cleancache_sysfs.rst
 create mode 100644 Documentation/mm/cleancache.rst
 create mode 100644 include/linux/cleancache.h
 create mode 100644 include/linux/gcma.h
 create mode 100644 mm/cleancache.c
 create mode 100644 mm/cleancache_sysfs.c
 create mode 100644 mm/cleancache_sysfs.h
 create mode 100644 mm/gcma.c
 create mode 100644 mm/tests/Makefile
 create mode 100644 mm/tests/cleancache_kunit.c


base-commit: 752c460b5865d87117095c915addcce7a68296f2
-- 
2.51.1.851.g4ebd6896fd-goog

