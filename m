Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494458634C
	for <iommu@lists.linux.dev>; Thu,  6 Nov 2025 16:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762447213; cv=none; b=sU5DlJ6a39NrYTJKqNEz9hxpndE36q3P1bRHSZyc2r0JQ93NqGpx7MAPWURg42KnO55UFbU7alOqEwqqUrP9iMVUh9PKsBIpbTUKVksQCnli5c3tQbc5B6hUNk9zvI4mKwQRY3ePhmksoDseDkDGHRMuma5fwjg5FvVWir34Tto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762447213; c=relaxed/simple;
	bh=mCZIsgqJp2i9uamt+pKRhzaXYJ3tiym2vWHNOfxN64g=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=NN3j7a833r2RliK9z6pryhKW/AkZHRmqsLRtFOiJ5D/p5C1MNNAWdfOsBBR9B9pW2/++m/pLLyYfuGVZ0/a+Wj7Uu+C59sQ2TY873BRCfiQ/JOJ0FPZbQO8ovqyzPLQiUSnrZ+OU8WqkRxtaI7KHXSyG9Ri+vniLxML71YYn9pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LmMFFxlf; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LmMFFxlf"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-47761eafd18so7700085e9.3
        for <iommu@lists.linux.dev>; Thu, 06 Nov 2025 08:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762447209; x=1763052009; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/LFdv3AJsjeDbdyHxZcbSRtknBSxAI/EO76KEsSfSxM=;
        b=LmMFFxlfMpblYjeCobfwa3vRDmGgwnR2wD3JTq2YAv9bmsEHfCP8sYuFz8tyBfe67D
         2wqMsLv2zHlJ3SnISc29QyhzO14aoUIHJCtu4EAN2nHmEC8Cmor4Y4SzJPRS8T5IaxsK
         vC7LU/YgO1xN96BnO/FaKx3hMqIQawk8QKChkU+wEu6MeP4KUneVHhJwksQKgFWfd92H
         IKCKc7bTLUjGtPIV445VuGV6ZM2EuSWPVUslzHG4AyF0Y34zHSP3jgMq+L+IpPgNsOSa
         BHn/DTS6f8xEzI7WN5GCKzLJtfGXxrzD2M30yLX7/0jC0rC+ekQB2HnA7QPcyltn6YOv
         Kk5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762447209; x=1763052009;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/LFdv3AJsjeDbdyHxZcbSRtknBSxAI/EO76KEsSfSxM=;
        b=gcaIEGEl1ao4iYs1/WjxXhHkiUFJzaNoNaptrSCYeHa7xhmByrQfaECq3di0wYVh1h
         zFPBjdDDi/6zTnonsWK5sfffdx5Z+uoYYs1c8zltI76tDVGvNE/PxVDdQmoYowRhJ6m7
         pK2LjdPdRggF1Bp6urQt8gTo4oIsc3gGn6/1/5Y/hjXJKcCUn+eDpYLj1tciGO2HOcB7
         BpdWnV7wNqI2QhtGvIWZv/VV0AlyoVoQH/o1KCILQ6xBSUQVhSICP31EYVqLK+brBhUC
         Kq7e7vxRwfxBPA3iSFputdZpjiSMnPimlELafh9jBEoplMeYNAvD0XLGtpO7byRdPwZv
         L1tw==
X-Forwarded-Encrypted: i=1; AJvYcCVMO7P4gZeSSzH4qLDMFbGxCBQTgESR9OIpjyyfNXdUgZrbhc8B7sR8sQcakQ3TeBbWFUzz8A==@lists.linux.dev
X-Gm-Message-State: AOJu0YyEb/3Z/TdjvK6eewbBNSVs4OVnFEEaHH4RkpUv4jI9LDhyHb8L
	r5qxu0tPC3ghxNoyvG/NKd1u0DXFrTelbenidCF+JauAAOwFeFGYQOWiD0y7s9yCACzm5LJVmYA
	jhqE/s3n4/7Oj4w==
X-Google-Smtp-Source: AGHT+IHxGvKB7RNBXPd5yjtxQlMPWEmFro0Urso+GGwuaW5qjEm9Qb3qx0pkyEB024YUCyxOSQ+DM6J5drYxMg==
X-Received: from wmcm6.prod.google.com ([2002:a7b:ce06:0:b0:477:1716:3f2e])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a12:b0:477:55ce:f3c3 with SMTP id 5b1f17b1804b1-4775cdad693mr58624485e9.5.1762447208638;
 Thu, 06 Nov 2025 08:40:08 -0800 (PST)
Date: Thu,  6 Nov 2025 16:39:49 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.2.1026.g39e6a42477-goog
Message-ID: <20251106163953.1971067-1-smostafa@google.com>
Subject: [PATCH v2 0/4] iommu: Add IOMMU_DEBUG_PAGEALLOC sanitizer
From: Mostafa Saleh <smostafa@google.com>
To: linux-mm@kvack.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Cc: corbet@lwn.net, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com, mhocko@suse.com, 
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org, 
	Mostafa Saleh <smostafa@google.com>
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
count and WARN if it is not zero.

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
Also I booted RockPi-4b with Rockchip IOMMU.
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
4K - 4 threads		0.1/1.0     0.1/1.0     0.1/1.1
1M - 1 thread		0.8/21.2    0.8/21.2    5.6/42.4
1M - 4 threads		1.1/45.9    1.1/46.0    6.0/45.4


Main changes v2:
v1: https://lore.kernel.org/linux-iommu/20251003173229.1533640-1-smostafa@g=
oogle.com/
- Address J=C3=B6rg comments about #ifdefs and static keys
- Reword the KCONFIG help
- Drop RFC
- Collect t-b from Qinxin
- Minor cleanups

Mostafa Saleh (4):
  drivers/iommu: Add page_ext for IOMMU_DEBUG_PAGEALLOC
  drivers/iommu: Add calls for IOMMU_DEBUG_PAGEALLOC
  drivers/iommu-debug-pagealloc: Track IOMMU pages
  drivers/iommu-debug-pagealloc: Check mapped/unmapped kernel memory

 .../admin-guide/kernel-parameters.txt         |   6 +
 drivers/iommu/Kconfig                         |  15 ++
 drivers/iommu/Makefile                        |   1 +
 drivers/iommu/iommu-debug-pagealloc.c         | 148 ++++++++++++++++++
 drivers/iommu/iommu.c                         |  14 +-
 include/linux/iommu-debug-pagealloc.h         |  83 ++++++++++
 include/linux/mm.h                            |   5 +
 mm/page_ext.c                                 |   4 +
 8 files changed, 274 insertions(+), 2 deletions(-)
 create mode 100644 drivers/iommu/iommu-debug-pagealloc.c
 create mode 100644 include/linux/iommu-debug-pagealloc.h


base-commit: dc77806cf3b4788d328fddf245e86c5b529f31a2
--=20
2.51.2.1026.g39e6a42477-goog

