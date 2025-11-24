Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD5832E120
	for <iommu@lists.linux.dev>; Mon, 24 Nov 2025 20:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764014900; cv=none; b=KMKyW3AmSSh023qdyPg0MttkdcYKw5FDq/f+S/Qbx90jLYtZ95Pf3nc1HlhJ61/JjJCAV8bpAQDVsCYogTjLOoyO/8iTbzsnFyUCAxgRXBJSAqlpYvGAZi1+X3FQLtgtoH3Jw5PQLLBLYyVgLoK3AZw744qr1RzYihBAJmHX/Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764014900; c=relaxed/simple;
	bh=+jM9DOdjBhyH7HlVHzP5atA4jvdGyiwhLOzyn6rPOkM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tqUoLSBrvvyerFXyTBxE6jWDAertiGfFfW690uKIoGnBzl3pbbJMfdJ2/w7Q+ZwaMjwFEJERZBDHGnVNPp+cgq1zxaQVBzUe9fA9G8uSn8spp/x7d/+p/D9HOuycPqQIX82EjD3UEkIVoTgWOFVtp4gJR3AdbCcUmbbFQXykyTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SXCvEZEl; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SXCvEZEl"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4779da35d27so58258655e9.3
        for <iommu@lists.linux.dev>; Mon, 24 Nov 2025 12:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764014897; x=1764619697; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y6cF97FuMaXldX4nVRk2ef3Y1LkWTsSlt/45nS3G5EU=;
        b=SXCvEZElQMsfDwIWhs/6WcLVo4C7RRxkeCC9vV7vbBwWbBB+fVOpicTipEp/TlGZrR
         Z4od6FOOaNqOcc1FNRh+BCHQVMDVtv+Edy+J1N6XoqSN3IJiYPMNdCHKVRyIhAkNETbC
         PG0FZHiM0nmSrC2Uvli02QDhy9StglLDYIK514pcU4PgZmkRBCBCqE6ORpLjEK7GUf6R
         QOubXnDcc8Rx+hOh6iaBpy5aQ7F0DFJ9AYAGVTsX0O0BWK/f8QBv/kgQIOgbSdKCqe6h
         lIyoXAp8FWI2BBuLVA+5BXgwyHybsoTfw8vOeq20xrX1waDae10VUXbA9g9hkvlbpvZ/
         hc0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764014897; x=1764619697;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y6cF97FuMaXldX4nVRk2ef3Y1LkWTsSlt/45nS3G5EU=;
        b=v2Lq/iT2l3g6PZ+I12hLRDqhXu6Kq7s6aP8s96KhFKDY1R7jRDCc4OVYN6e5ncyYez
         87BV6iZLdfm8re85BMH5kbKnwNzVIIR0V7YFVidW1/CgSTxlSb84mI+EHlqi9V+H6dpd
         RncalOukpoZXcZG7LNT1CCuWFONvfkI8ToWZlWoR6kOWBKVnsj2Xj4fu4HvNQJbwPASr
         3EOekdqjv8y+zJdMjSI1gpPj1PRwjz92WOFCLNgTgtEDB3D4v9GD83XHOXiDs8DovTD/
         pujg1MGDTYLb3rEHlAFSabD+VzRRqjF7r9Pq2IeD5oDrR9jH7xBE6B02R5ISMoAs95c/
         uJOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWH4BxZvv8zyjzDkLDB7mPcHkpgNDpzU7mcBr97Ta8aV7N/vnjgW08KJJYu/nRlGLcRNvfv3Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwI/DUmXjmu+YF61trfbXoWsl8P8Wd1VdqMNLVIEk0mH0R0gcd1
	SD0BlQfi8BxaxI4kGtPcI0wVzy5DWsuiDBZqZV2SzSwiHrAEwmiJUSsLmvnOjxGVIz6JXpbARlF
	xFmHAzlJNnLkzyw==
X-Google-Smtp-Source: AGHT+IG4vi0WfkeqorYIMjrVx6w0lretQ4YoAiBDlLabyKHqm8PtvfTjZqcpq685F8sErkOoMo/2vMj7xrLQbg==
X-Received: from wmcq20.prod.google.com ([2002:a05:600c:c114:b0:477:a656:6762])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8b37:b0:477:76bf:e1fb with SMTP id 5b1f17b1804b1-47904b1ab30mr1341855e9.16.1764014897434;
 Mon, 24 Nov 2025 12:08:17 -0800 (PST)
Date: Mon, 24 Nov 2025 20:08:07 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.460.gd25c4c69ec-goog
Message-ID: <20251124200811.2942432-1-smostafa@google.com>
Subject: [PATCH v3 0/4] iommu: Add IOMMU_DEBUG_PAGEALLOC sanitizer
From: Mostafa Saleh <smostafa@google.com>
To: linux-mm@kvack.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Cc: corbet@lwn.net, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com, mhocko@suse.com, 
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org, 
	xiaqinxin@huawei.com, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Overview
--------
This patch series introduces a new debugging feature,
IOMMU_DEBUG_PAGEALLOC, designed to catch DMA use-after-free bugs
and IOMMU mapping leaks from buggy drivers.

The kernel has powerful sanitizers like KASAN and DEBUG_PAGEALLOC
for catching CPU-side memory corruption. However, there is limited
runtime sanitization for DMA mappings managed by the IOMMU. A buggy
driver can free a page while it is still mapped for DMA, leading to
memory corruption or use-after-free vulnerabilities when that page is
reallocated and used for a different purpose.

Inspired by DEBUG_PAGEALLOC, this sanitizer tracks IOMMU mappings on a
per-page basis, as it=E2=80=99s not possible to unmap the pages, because it
requires to lock and walk all domains on every kernel free, instead we
rely on page_ext to add an IOMMU-specific mapping reference count for
each page.
And on each page allocated/freed from the kernel we simply check the
count and WARN if it is not zero, and dumping page owner information
if enabled.

Concurrency
-----------
By design this check is racy where one caller can map pages just after
the check, which can lead to false negatives.
In my opinion this is acceptable for sanitizers (for ex KCSAN have
that property).
Otherwise we have to implement locks in iommu_map/unmap for all domains
which is not favourable even for a debug feature.
The sanitizer only guarantees that the refcount itself doesn=E2=80=99t get
corrupted using atomics. And there are no false positives.

CPU vs IOMMU Page Size
----------------------
IOMMUs can use different page sizes and which can be non-homogeneous;
not even all of them have the same page size.

To solve this, the refcount is always incremented and decremented in
units of the smallest page size supported by the IOMMU domain. This
ensures the accounting remains consistent regardless of the size of
the map or unmap operation, otherwise double counting can happen.

Testing & Performance
---------------------
This was tested on Morello with Arm64 + SMMUv3
Did some tests on Qemu including different SMMUv3/CPU page size (arm64).

I also ran dma_map_benchmark on Morello:

echo dma_map_benchmark > /sys/bus/pci/devices/0000\:06\:00.0/driver_overrid=
e
echo 0000:06:00.0 >  /sys/bus/pci/devices/0000\:06\:00.0/driver/unbind
echo 0000:06:00.0 > /sys/bus/pci/drivers/dma_map_benchmark/bind
./dma_map_benchmark -t $threads -g $nr_pages

CONFIG refers to "CONFIG_IOMMU_DEBUG_PAGEALLOC"
cmdline refers to "iommu.debug_pagealloc"
Numbers are (map latency)/(unmap latency), lower is better.

			CONFIG=3Dn    CONFIG=3Dy    CONFIG=3Dy
			            cmdline=3D0   cmdline=3D1
4K - 1 thread		0.1/0.6     0.1/0.6     0.1/0.7
4K - 4 threads		0.1/1.1     0.1/1.0     0.2/1.1
1M - 1 thread		0.8/21.2    0.7/21.2    5.4/42.3
1M - 4 threads		1.1/45.9    1.1/46.0    5.9/45.1

Main changes in v3: (Most of them addressing Will comments)
v2: https://lore.kernel.org/linux-iommu/20251106163953.1971067-1-smostafa@g=
oogle.com/
- Reword the Kconfig help
- Use unmap_begin/end instead of unmap/remap
- Use relaxed accessors when refcounting
- Fix a bug with checking the returned address from iova_to_phys
- Add more hardening checks (overflow)
- Add more debug info on assertions (dump_page_owner())
- Handle cases where unmap returns larger size as the core code seems
  to tolerate that.
- Drop Tested-by tags from Qinxin as the code logic changed

Main changes in v2:
v1: https://lore.kernel.org/linux-iommu/20251003173229.1533640-1-smostafa@g=
oogle.com/
- Address J=C3=B6rg comments about #ifdefs and static keys
- Reword the Kconfig help
- Drop RFC
- Collect t-b from Qinxin
- Minor cleanups


Mostafa Saleh (4):
  drivers/iommu: Add page_ext for IOMMU_DEBUG_PAGEALLOC
  drivers/iommu: Add calls for IOMMU_DEBUG_PAGEALLOC
  drivers/iommu-debug-pagealloc: Track IOMMU pages
  drivers/iommu-debug-pagealloc: Check mapped/unmapped kernel memory

 .../admin-guide/kernel-parameters.txt         |   6 +
 drivers/iommu/Kconfig                         |  19 ++
 drivers/iommu/Makefile                        |   1 +
 drivers/iommu/iommu-debug-pagealloc.c         | 172 ++++++++++++++++++
 drivers/iommu/iommu.c                         |  12 +-
 include/linux/iommu-debug-pagealloc.h         |  85 +++++++++
 include/linux/mm.h                            |   5 +
 mm/page_ext.c                                 |   4 +
 8 files changed, 302 insertions(+), 2 deletions(-)
 create mode 100644 drivers/iommu/iommu-debug-pagealloc.c
 create mode 100644 include/linux/iommu-debug-pagealloc.h


base-commit: ac3fd01e4c1efce8f2c054cdeb2ddd2fc0fb150d
--=20
2.52.0.460.gd25c4c69ec-goog

