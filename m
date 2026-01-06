Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645D025F96D
	for <iommu@lists.linux.dev>; Tue,  6 Jan 2026 16:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767716533; cv=none; b=rt+cvIaVdePAt0cmyIh1MHj2Va+M4rT99dRjOZZEQhOLMgQcssLJrcmAktvve1AY7Gfi2TJvYKSsz2CZIcNeMm61Tl/2Xt7evttp81O3SZhda8ZXqyrJiyJh/TL4BKAG5vdoeJ9BMefmu3TMi8Adac5KNApccB3aq3oux55bV6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767716533; c=relaxed/simple;
	bh=94DqW7ogGAaLjIIqYMc4rSjyRy/Grl4qfjjA/fEJZ8c=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Efn5Axw34FNslW97Gs2JFkjgxl8N8D6LuNDIO/8Q+ko6Qc/f5JMlgskgGqMcLLBONPiiSZvoM0BL1omzz6X2vJZOSdSeC63j1ODuqJVjX1cNyfcqsh11nff5U4ol9FQYsQ3FzcHFhFDS9JRQ6tfLzsToGlFfPAkfSlbnfboeWaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aLRGCDO+; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aLRGCDO+"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-430f8866932so864235f8f.1
        for <iommu@lists.linux.dev>; Tue, 06 Jan 2026 08:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767716528; x=1768321328; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zKAqbwUbcchTwKTjD1t6ChHOkXjBfpnVs5Rhwmy3fpU=;
        b=aLRGCDO+1BiYHMhBtnYJKz+HbYi3C5yG6OHzzAJC80ATCNwcvnONemWMhTIoHRKr6t
         MsbDu+84dd816ztO/dfl6wPz43wNMbuZEkpKegagHhI+kutCOSw3DdY1zNVzLj0GsZGf
         8Lf/LDR+3mAF2lmUECPX3scotYstsUWhwrdBQ8bE8eeiHWQwXEPX+QKobN508AQGbzEP
         BSbxifXiatFMBAYX6QZAmoqPcRe3r7TMSBZmmRNgnNlPoryecKLQiQ/S5qrqjrdeE68N
         dvbcO5zcxrr/0hNq79sH4DUWaEkLj+qNpm2ot17dlgf0IcFS6qlFYYTmAoaskmIuTFiu
         iyIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767716528; x=1768321328;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zKAqbwUbcchTwKTjD1t6ChHOkXjBfpnVs5Rhwmy3fpU=;
        b=EQzIoyT5tZSkGPIDpct6areWdkSaZ0fRb+dM3uHxgl5eIhLY3Gdkh2haUBVhmHRXlD
         ggymBFJY50G90eu6Cx8Kx0pVErUIhMvA2v38wsOQO83HELZuujTN9C9A31ZRyzTJo7fj
         G3vXEmTZqVh/qOUuoQVVgHo4Hp1Bx4wfL8RDzEDAO3m8g7t93YlP3KqT12TqwBx38Xb+
         sz07/5rOVnvzHJDXWXHRiVTpn9O/D5CjLAktkuKVdzd995r9o555Lp02Fk3MCfqv6My/
         gnbzJAHK5N55nrxkkH0n/o3anLeizZMZlv1OaYY93kxIbw7O3/6rufMdz1PRKQYRXQk8
         nCBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJnsSrsibPOsHr8ZmL0yuycc3DrQsowJIxrsW8fAzmAFYucrpaJWszP9KrPGi6QUOvlK8UKw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzWPhKBFMSE9vFbQH84BtEZSGT/oG7vnc1hh8ggRjKzehDD2dFy
	HS9g6q3L0fSlmRrugKOmGLyAxMaYxZz5mNGKU1zQJoYErc812NkOSnG4Tdm5CxiwrsLmHVbMiTJ
	h89Yu2cuT8rH5Uw==
X-Google-Smtp-Source: AGHT+IE/qy1LfP4KHNR4hLsIgyEGcvqJy/Wln0GOFpcBQE2xmH7wf/+hwlojpH5iVq4CKKX4O8sUT1CS1VuLog==
X-Received: from wrbck18.prod.google.com ([2002:a5d:5e92:0:b0:431:334:a1ce])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2504:b0:432:5bf9:cf26 with SMTP id ffacd0b85a97d-432bc9cbe81mr4724605f8f.13.1767716528301;
 Tue, 06 Jan 2026 08:22:08 -0800 (PST)
Date: Tue,  6 Jan 2026 16:21:56 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Message-ID: <20260106162200.2223655-1-smostafa@google.com>
Subject: [PATCH v5 0/4] iommu: Add IOMMU_DEBUG_PAGEALLOC sanitizer
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
2.52.0.351.gbe84eed79e-goog

