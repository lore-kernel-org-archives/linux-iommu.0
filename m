Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9991310630
	for <iommu@lists.linux.dev>; Thu, 11 Dec 2025 12:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765457977; cv=none; b=i1XBHsEKEOHyoFh2nDdzx9mLi9MdwxbJo75rdg72ZTyqz+W1cLslC8/hywtNFbsxUlC8lICDRFNgnQCXXAKQl4AwXiq3Pmt5eqybL4nu6x3DuHoa6TZvdcHddAg4pvUzZzy7kEBEGgNFjdvSRrMK8G1MhVSCd6jRTl8dvLPAtbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765457977; c=relaxed/simple;
	bh=rLcihtyFhSEoeTJa4t4hOIpNJcIYYd1QzG5DpHS2acY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Nj5ugBTmizsym6sfj+i9/F16UZsq5NPc33NUV7x5RmAXuUpqvIjuxUhGk6De5onDaQIpxpk9O4NOKBrvkx6SibRL5Wci5aqo2icDWiW89YnSamRXxPgNkSnbb52mPWsEuBeepc/gwWIxtoXnC1Zf+uOp5L5gTzkbbXOj3aMMmXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jyzXCe+o; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jyzXCe+o"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-477563e531cso414945e9.1
        for <iommu@lists.linux.dev>; Thu, 11 Dec 2025 04:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765457974; x=1766062774; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1YPd4rabCA15+W0gc58X3ldTKNVJsgSl/m8TAJcDC9k=;
        b=jyzXCe+oiRxbaWA68H/suTCtkuIt8FCRL6MwA5JUmoocDsXwN8VzLTvY+3YplABi8I
         LK8k0pCLCGCHpgLiYSL5b+xwZo45BxnFAVt5Ba36TYXS7BrEKL/RaYcc06zk6ZN15AlE
         kZe1DAacL+ndEApN7gVbyn6hkT90cDSuD9hfn0U0gG7Q4QdT2lCgVwoJQm+4bOp9rCCV
         iyWidLlz2ScZqVCguVNU6bzWEORr7h08czBFaFfsjJNoZb3CW3v4XDCQIR7Fvk7zv+a8
         uAcKBGmK7vdTlS0fV8ex2QxVQ3erZLXwxF2mTXNl8ABotPeBfm0UQqpT+8+YYthSCgRY
         Hlww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765457974; x=1766062774;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1YPd4rabCA15+W0gc58X3ldTKNVJsgSl/m8TAJcDC9k=;
        b=G6ckMLpKsUjggpBEFLyzdyayZaYw0AtfgTeDebGmmrkf+K3E9EXmfaHzrw3gjyxOP1
         oT1O+bR9Fs9o0kcNGrCwlzZ9FRg7DpAj6MT0DvQgd3V7LHEsaBSfA8Fp/E4+zIFoxWzA
         B5JryC1KaeigaAf2z+Rxogoq1X77PgTqLOpfg9YagDxM5nAgnIJ9i1l38zUvDwgHykSW
         PjcZZNaOVHPtEjI/TWnthC0dIWzErx2veu2rMdq+MV9qPXjBgInWtWHB35XrlIHy+Q/c
         qVczmE6wm5x8PS5R/Qfb5Q+NaGAKL2H1JtFqgfKuHC/5K596fdFJtldB1x423isAoKpK
         HjmQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9WZaKn5WRyPQlX8xxSiX93G+M33mu7UB5VCsAeAlU2XsZqx0ei88sY788DdaMrv92e3pi6A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzsAwDa7YVz5ZQveTGm6Ivz63Vw5gESfG4/Yueb5uwp7Zhig681
	1H+vHTzqEye7pj57CHKfoMcBl2R9ZXYU3ksrtd64/RP+UyH1Mt0ZZDvLOMmJVWHFIeoe9RQgZGx
	u1xJIRxu8JsMbBA==
X-Google-Smtp-Source: AGHT+IEutEw1d7HRrDvz7Uw5x03SFSXvQO6Sqwdti2F86uaAXoFjBNtSfbvmhvAiwBwLApQfmCLLxUs3FhConw==
X-Received: from wmbhi3.prod.google.com ([2002:a05:600c:5343:b0:477:c551:bdb9])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1389:b0:46e:4a13:e6c6 with SMTP id 5b1f17b1804b1-47a83843239mr56517695e9.19.1765457973952;
 Thu, 11 Dec 2025 04:59:33 -0800 (PST)
Date: Thu, 11 Dec 2025 12:59:24 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.223.gf5cc29aaa4-goog
Message-ID: <20251211125928.3258905-1-smostafa@google.com>
Subject: [PATCH v4 0/4] iommu: Add IOMMU_DEBUG_PAGEALLOC sanitizer
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
 drivers/iommu/iommu-debug-pagealloc.c         | 174 ++++++++++++++++++
 drivers/iommu/iommu-priv.h                    |  58 ++++++
 drivers/iommu/iommu.c                         |  11 +-
 include/linux/iommu-debug-pagealloc.h         |  32 ++++
 include/linux/mm.h                            |   5 +
 mm/page_ext.c                                 |   4 +
 9 files changed, 311 insertions(+), 2 deletions(-)
 create mode 100644 drivers/iommu/iommu-debug-pagealloc.c
 create mode 100644 include/linux/iommu-debug-pagealloc.h

--=20
2.52.0.223.gf5cc29aaa4-goog

