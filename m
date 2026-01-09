Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBCB3382C7
	for <iommu@lists.linux.dev>; Fri,  9 Jan 2026 17:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767979095; cv=none; b=ecFHb0ym9gXze3r4Xulqs2RAk1Vlo6I8MePzuI5kJsGzSMEzcFprCR0eAGrk5+hC24sH0J26dpaK2FUejeWxFkQA12LobR1N7go0XouyuG5Mfa+uVMKXA9EAzGN88i0y4n9zvn86I4wPeCXSvZry5jbe8rH5BfwfohQYzY3TMFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767979095; c=relaxed/simple;
	bh=MN7KwFeO9oAIogqgApPGUHmEWgErAJGaONG3a9YM5K4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=P5aWoI9ngphv5SWBzVKNp1KZmUycEdWus7q9BtJDFAVtKRHVFeHBELaUNopl3AxnxKbU39NWfeahqRv+TbaJel0PBs7AC2/ppLEzKr5GTIS30gNJCU+uzk35lZfPMGrqPTfOK58/HkhhTcBiaR2ZPAybi5m39o0tIpaJaSfp3PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZNaLkeDC; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZNaLkeDC"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-47918084ac1so47535485e9.2
        for <iommu@lists.linux.dev>; Fri, 09 Jan 2026 09:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767979092; x=1768583892; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EFPXi9jlv9rMnyA0grBQkKfopvHJmF7zvIc7VHv8N58=;
        b=ZNaLkeDC1aI5bJJWnvGhfKZeWFtK4hSIynYkSFZGkMWlmMVKTl5Cv6SsQYVj0HtBbQ
         MIRbLWYWfgM7YuECOCRFwfwo72MrHF0exiyu7MSj6c/MVuN+PcASs2S7hjG4FPqowXRU
         x8K4AUA4AuCycI9ckTYxG0T8b9t8a7V9nXdjAq3wWlDpqA/9Af22PGvnKBwm5uwFA4QM
         jOZ+xCie0REuFnh9/u1e6GzXOMcx9oyfxwLe1+cYy8/8tP6OEE0wdTihSN00I2wJ1No3
         n2XLUqHYc5Ut7Q2zSsfDZre8gQC1VA1KMjccncv3Ah7Ijjb3mxsMA2gqgUR5lTB3dDpL
         H6Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767979092; x=1768583892;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EFPXi9jlv9rMnyA0grBQkKfopvHJmF7zvIc7VHv8N58=;
        b=weNwZ5IYAZeafSm0Uiq3Fjc6bIUTeuw1GBasDTid8t1QZ8N+x4whb5khH3HOtks3AY
         iqEdeT2dtQNoekws03fG1k+x7OLvfXcv127Xxcxpr6eA/9XaDt02ARLkGAxCqdvGItM6
         zYFGJ+Kl1fb5+zFRj83qBQ9pJOBrZ0ShzTLJ1d08jtHY7kbLcqtv0kH25fLwdBTHCQxU
         XuCsuGTWj1LFi7hsNAaXEyhOyeXUEKqa/3f/QT/YV0VMa2STC2HKjxMc0sPl0iswtm8l
         brZfBOwVhpmcYV9SlOt/qpanNRoZMWpgP78sN3KQ87k4X97Sh363SkJ62TClCC5hw1A4
         PcAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFraBSmV1bmAhoVhmNEP5L9O5rOjKF7Mx12y5tkCejLyiO8tpuxZ4WsyLV9DJenofzeUCusg==@lists.linux.dev
X-Gm-Message-State: AOJu0YznNHnkafwa3tNXT6zAYxJhDDOs+JpivUIn3C2LNDhS/ZZnLSxl
	+7zcgd/7ZypMCYZkvQHHuXKtM7jnTBva8FHpfAbyonFJv9i/YqNge/VJl+MO0pN3ijOXgE8p6CP
	NVq3cgvkE8W9ENg==
X-Google-Smtp-Source: AGHT+IFocuqh4xf3N3PNsIA9bVyZchbl85zeIdFnVspAH2mPKuFwxxYp6oh+Bwc2UYAh9iIB3e8vzhQ1q9OD3A==
X-Received: from wmba20.prod.google.com ([2002:a05:600c:6dd4:b0:47b:d5ad:dd7f])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1d14:b0:477:97c7:9be7 with SMTP id 5b1f17b1804b1-47d84b0a7bdmr116367135e9.1.1767979092009;
 Fri, 09 Jan 2026 09:18:12 -0800 (PST)
Date: Fri,  9 Jan 2026 17:18:01 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260109171805.901995-1-smostafa@google.com>
Subject: [PATCH v6 0/4] iommu: Add page_ext for IOMMU_DEBUG_PAGEALLOC
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
This was tested on Morello with Arm64 + SMMUv3
Did some testing Lenovo IdeaCentre X Gen 10 Snapdragon
Did some testing on Qemu including different SMMUv3/CPU page size (arm64).

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

Mostafa Saleh (4):
  iommu: Add page_ext for IOMMU_DEBUG_PAGEALLOC
  iommu: Add calls for IOMMU_DEBUG_PAGEALLOC
  iommu: debug-pagealloc: Track IOMMU pages
  iommu: debug-pagealloc: Check mapped/unmapped kernel memory

 .../admin-guide/kernel-parameters.txt         |   9 +
 drivers/iommu/Kconfig                         |  19 ++
 drivers/iommu/Makefile                        |   1 +
 drivers/iommu/iommu-debug-pagealloc.c         | 167 ++++++++++++++++++
 drivers/iommu/iommu-priv.h                    |  58 ++++++
 drivers/iommu/iommu.c                         |  11 +-
 include/linux/iommu-debug-pagealloc.h         |  32 ++++
 include/linux/mm.h                            |   5 +
 mm/page_ext.c                                 |   4 +
 9 files changed, 304 insertions(+), 2 deletions(-)
 create mode 100644 drivers/iommu/iommu-debug-pagealloc.c
 create mode 100644 include/linux/iommu-debug-pagealloc.h

--=20
2.52.0.457.g6b5491de43-goog

