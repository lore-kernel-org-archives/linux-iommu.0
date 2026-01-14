Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647173A4AD7
	for <iommu@lists.linux.dev>; Wed, 14 Jan 2026 16:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768409013; cv=none; b=U5HlbVOXG4N5Lm/fzor89MCaSsJquGS6SKjTfJx0Rb/WmumvXu3dER9hjYEXRf2tHL/vrCWnn387xy2C0SFAAy0549BuRUNMqwWazbsLtGfJqolpvmpweC5CNMpHhNXPImoQibu6keadAY5cv3FFkybhXRQYwVA/2DKuplDhgpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768409013; c=relaxed/simple;
	bh=dXh2ayx+79QFmMkjaJ3fx+VU7Efs17lwo3jymxpelrw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=NNhzAaoaD/l4bdjkq8Mepk62RJWMY1dJc00yTJQ6nkyeYys5hg1ycn/emumpRS/y0g2z75CV81AQzwL804Ls5VjOu+9l/lfDMDoh3Re9TXSi+KHo5aI1Uck4cXIoCUQ+bhf7u/BVwaHsXRdJNyKbAU++PhCFC4KXjp7vewMJWaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L6o9v8ij; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L6o9v8ij"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-477563a0c75so200325e9.1
        for <iommu@lists.linux.dev>; Wed, 14 Jan 2026 08:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768409010; x=1769013810; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ptbGfqhARAg/OJu3oyRxs8/LiGbyPAv+mElQ7v4+SEE=;
        b=L6o9v8ijSJ8tF5oRSZ0OyngEz2HIb/3tYGNNAY0M1wgq57Xsd8auJQcVQywlzumoDr
         GDJsgLyF6DOSDUeJ1+K7CXUvhGV8Pp9g0bxtb73OdQOwXzHuEBDERhnotllQFnelxdfg
         0iSkrNA6dpPyyzmzkthjcdPRCIIjS3q7Eb5OnVNOqJ6cNC3Fmo1ddR1OsQpa7nADuXy+
         zj0d7pZ9MN/xZITN4X098N7/+05YDU2ntgin4eBrMUdFQ0zesj2/hKQDKGNxi73SadHn
         qf6UzK6JOXtUqag6KfYo2Rqv/Nq35IoSb3TG9TtO6dK/KLugtPtvdUHfIxwSlz84lJgl
         SmAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768409010; x=1769013810;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ptbGfqhARAg/OJu3oyRxs8/LiGbyPAv+mElQ7v4+SEE=;
        b=cU6K2h4J57uFjPkSAkdvcERInZFIfhaYRNpJZcVNVigntPbKPgPg3xr+csgyDXArDf
         dnHO9jPuHYpabgAlLDBwScktiz1igwuXvc2KTCSYkLWouTs+lVMKAY6IkApn1JUdOLTW
         EbVotf2zDery+nOwJs7zYUhG+8YVdFlPqpj/7c8AErfl6cB8gHybJ1pW45PnfzVGGE/w
         XjpEGUYjvH3B91FgoIJ6NfXweqHq0XuOOt1Q3DjQG707g87ZSYtGYW8ku62g5HDVad5k
         HF2OiEHTG5lIdJVUJX+0rPZsigvbvcuJMk85tZMD2w6ynk3FW0UGyPtLrucmdTZsAvVf
         4vmw==
X-Forwarded-Encrypted: i=1; AJvYcCWy6xC29nexyQsXLSosYIE6BE7c0hQKnmO3sskvz0J98Ja0gT6hUS3ddWRJAzATADAvneChMg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwRGAJrMK71ldSEHyUKAamM0twLQ7aKbJaPEDSjXYoCSiwNxsR5
	P9Wm7R37BfrB/TnPc8oUXWV6joId3scEMrtiUFsJCcRtIeWjhmQmnwkKMNJC1s2jafYaMmuLEwm
	sWYIOR2a5lQQJMQ==
X-Received: from wmbem10.prod.google.com ([2002:a05:600c:820a:b0:479:3624:3472])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4e0f:b0:477:73cc:82c2 with SMTP id 5b1f17b1804b1-47ee32fcef4mr41658405e9.9.1768409009960;
 Wed, 14 Jan 2026 08:43:29 -0800 (PST)
Date: Wed, 14 Jan 2026 16:43:17 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260114164322.787125-1-smostafa@google.com>
Subject: [PATCH v7 0/5] iommu: Add page_ext for IOMMU_DEBUG_PAGEALLOC
From: Mostafa Saleh <smostafa@google.com>
To: linux-mm@kvack.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Cc: corbet@lwn.net, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com, mhocko@suse.com, 
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org, 
	xiaqinxin@huawei.com, baolu.lu@linux.intel.com, rdunlap@infradead.org, 
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
Earlier versions were tested on Morello with Arm64 + SMMUv3
This version was tested and benchmarked on Lenovo IdeaCentre X Gen 10
Snapdragon.

With dma_map_benchmark, tested on both SMMUv3 and SMMUv3, where:

CONFIG refers to "CONFIG_IOMMU_DEBUG_PAGEALLOC"
cmdline refers to "iommu.debug_pagealloc"
Numbers are (map latency)/(unmap latency), lower is better.

SMMUv3:
echo dma_map_benchmark > /sys/bus/pci/devices/0005\:01\:00.0/driver_overrid=
e
echo 0005:01:00.0 >  /sys/bus/pci/devices/0005\:01\:00.0/driver/unbind
echo 0005:01:00.0 > /sys/bus/pci/drivers/dma_map_benchmark/bind
./dma_map_benchmark -t $threads -g $nr_pages

			CONFIG=3Dn    CONFIG=3Dy    CONFIG=3Dy
			            cmdline=3D0   cmdline=3D1
4K - 1 thread		0.0/1.8     0.0/1.8     0.1/1.9
4K - 8 threads		0.2/6.2     0.2/6.1     0.3/6.8
1M - 1 thread		0.5/54.3    0.5/54.4    6.7/74.4
1M - 8 threads		1.2/339.7   1.1/340.9   10.5/331.7


SMMUv2:
echo dma_map_benchmark > /sys/bus/platform/devices/ac0000.geniqup/driver_ov=
erride
echo ac0000.geniqup >  /sys/bus/platform/devices/ac0000.geniqup/driver/unbi=
nd
echo ac0000.geniqup > /sys/bus/platform/drivers/dma_map_benchmark/bind
./dma_map_benchmark -t $threads -g $nr_pages

			CONFIG=3Dn    CONFIG=3Dy    CONFIG=3Dy
			            cmdline=3D0   cmdline=3D1
4K - 1 thread		0.6/3.9     0.6/3.9     0.7/4.0
4K - 8 threads		1.0/19.6    1.0/19.7    1.1/19.9
1M - 1 thread		61.8/372.0  61.8/374.9  68.1/396.7
1M - 8 threads		89.4/1470.5 89.9/1362.9 100.3/1373.3

Changes in v7:
v6: https://lore.kernel.org/linux-iommu/20260109171805.901995-1-smostafa@go=
ogle.com/
- Add a new function page_ext_get_phys() and use it instead of
  pfn_valid() + phys_to_page().
- Drop R-bs on patch 4.

Changes in v6:
v5: https://lore.kernel.org/linux-iommu/20260106162200.2223655-1-smostafa@g=
oogle.com/
- Remove wrong logic for handling unmap with bigger size than requested
  and warn instead.
- Collect R-bs and Acked-by

Changes in v5:
v4: https://lore.kernel.org/all/20251211125928.3258905-1-smostafa@google.co=
m/
- Fix typo in comment
- Collect Baolu R-bs

Main changes in v4:
v3: https://lore.kernel.org/all/20251124200811.2942432-1-smostafa@google.co=
m/
- Update the kernel parameter format in docs based on Randy feedback
- Update commit subjects
- Add IOMMU only functions in iommu-priv.h based on Baolu feedback

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

Mostafa Saleh (5):
  mm/page_ext: Add page_ext_get_phys()
  iommu: Add page_ext for IOMMU_DEBUG_PAGEALLOC
  iommu: Add calls for IOMMU_DEBUG_PAGEALLOC
  iommu: debug-pagealloc: Track IOMMU pages
  iommu: debug-pagealloc: Check mapped/unmapped kernel memory

 .../admin-guide/kernel-parameters.txt         |   9 +
 drivers/iommu/Kconfig                         |  19 ++
 drivers/iommu/Makefile                        |   1 +
 drivers/iommu/iommu-debug-pagealloc.c         | 169 ++++++++++++++++++
 drivers/iommu/iommu-priv.h                    |  58 ++++++
 drivers/iommu/iommu.c                         |  11 +-
 include/linux/iommu-debug-pagealloc.h         |  32 ++++
 include/linux/mm.h                            |   5 +
 include/linux/page_ext.h                      |   6 +
 mm/page_ext.c                                 |  27 +++
 10 files changed, 335 insertions(+), 2 deletions(-)
 create mode 100644 drivers/iommu/iommu-debug-pagealloc.c
 create mode 100644 include/linux/iommu-debug-pagealloc.h

--=20
2.52.0.457.g6b5491de43-goog

