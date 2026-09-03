Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57900339360
	for <iommu@lists.linux.dev>; Thu,  3 Sep 2026 02:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788402903; cv=none; b=ApP2fQgSKUWd11cHbmwMnlXaMRnLxGInjiB0fy6SxiRokYg2+L6nJ178cnGGiK8yDxOZ1Uq7QGvd0ahKZzbOfu7ChuZmeUScxt+SShKn3/hS6nOq50c6zVn747eOrnQUFzF7Ta8DZERcn0xAJuxLKy7qI8rPL5cvw7WlIkHqXW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788402903; c=relaxed/simple;
	bh=KttI8yN3SEE9knj1xRs/FNrG5jE/gzLZlVVCanD/Yjg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=sokry9n9kTuEYsRkNgokL6HnKxOeNKrDU5VH/Z81f0H6IHUu27gcZnXY88IYgZf/l111Uw9ZfcnbSJ4DxDuRN1kXg3utUw+oqCaURnrWWRa1MDKh8ZQtGO3H3UX1qAN6Hu+fy0OxgTEM/kWOKB9839e2Tjt5e67xqMIgpXADN9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--loganodell.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t9lxLB8B; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--loganodell.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t9lxLB8B"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38ecc48b3c2so2941754a91.1
        for <iommu@lists.linux.dev>; Wed, 02 Sep 2026 19:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788402896; x=1789007696; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z/CUOTjDyaAxtZC1lTIYdZbcKOF2SIWxflbwVxpxItE=;
        b=t9lxLB8BOhqyGYJtj7Mlxn82IqyEKvzP8Rf354ECHj/4gTs6C3GGF0ztPlxzTi7v5Z
         qvTNvY0dTB7BFYhSaHJ9EtsQgtC6SjEBkJKAdglDU+NOm2MFN4JexOjPJFYlIojXNqUh
         viwPKqme8+XPEQkzT2m5YiLTaCI24RBnv59X/+pLsNZtS9LVzYnB89wgP8L4EZta+k/L
         Fd3vtFHQbT7xaXxXDx03CaJui9BivGkcoDv28COX5q8V0AI+8mbBWQNK/tdxCfO/0wOF
         9BgM9F9UdtbWizeSxKdvQ5NiYgV+fk7VNzP6LSKhuhWLwwzuSZNEwGl5RlfyuQIWbA36
         +erw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788402896; x=1789007696;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z/CUOTjDyaAxtZC1lTIYdZbcKOF2SIWxflbwVxpxItE=;
        b=RnX8IMgPoq/2yKOEgYKmBXHJZHX/5BZ/sIBJndMYMJRXX14c0vD4eWRlAiJLNy6KIL
         rb/p4rFaZRmzZaQGSDOnf42eRnZbRBMI4oxX0T9kfydpWNkCb3SnEvTOg3IAIc13et8s
         4TnyjV9RUKaaXJOBCZ+XoD4VoHyMeBLh1391aibWSpO6Jmhr2U7dkfqc6aYkCoBHlorT
         sQqeFiwT6zhqRc7XCazkXj8/5QgVJAgr77IwpqSh/J+YYMJRs4F9upcoLxzPk0iVvmHH
         v5buwOIaOkrAShOEz8YJVdowZOOqlpOCuTmCEoadttHD6matVmRIx9xVXIWhXVDj6nhR
         eXIw==
X-Forwarded-Encrypted: i=1; AKwUvByXlCK+3PNJcQy5XAMpH3KSdlVBPweP2p6X0psloKi2FnH80ONZE+jQks6gdbaLBZUb/nSgSA==@lists.linux.dev
X-Gm-Message-State: AFuF++l0SwLcvsKVFQ/1aZS4KGam0U+Q2b+GBS8GkoVZopDRECYkcbaZ
	ggcXvn3ntTYa6L1bUkTDLMurqpqzCq+ZCTdrlbe7eLXZEVsXLkb3fNQArofCVSsrMzIZ82q+VSD
	LQtI50zNFktSMWFirpzJ2sg==
X-Received: from dysc26.prod.google.com ([2002:a05:7300:3b1a:b0:332:2edd:e13a])
 (user=loganodell job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2d85:b0:398:9c00:29f0 with SMTP id 98e67ed59e1d1-39aee249bd7mr14082963a91.24.1788402895806;
 Wed, 02 Sep 2026 19:34:55 -0700 (PDT)
Date: Wed,  2 Sep 2026 19:34:49 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260903023452.721732-1-loganodell@google.com>
Subject: [RFC PATCH 0/3] liveupdate: Move to feature flags for LUO and memfd
 ABI compatibility
From: Logan Odell <loganodell@google.com>
To: arnd@arndb.de, pasha.tatashin@soleen.com, rppt@kernel.org, 
	pratyush@kernel.org, graf@amazon.com, akpm@linux-foundation.org, 
	pbonzini@redhat.com, maz@kernel.org, oupton@kernel.org, seanjc@google.com, 
	bhelgaas@google.com, alex@shazbot.org, jgg@nvidia.com, kevin.tian@intel.com, 
	dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org, 
	will@kernel.org, robin.murphy@arm.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, linux-mm@kvack.org, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-pci@vger.kernel.org, iommu@lists.linux.dev, 
	Logan Odell <loganodell@google.com>
Content-Type: text/plain; charset="UTF-8"

We're including maintainers from all subsystems that currently is or
will be expected to participate in live update to ensure alignment on
the path forward for compatibility.

Currently, Live Update Orchestrator (LUO) and its file handlers rely on
monolithic compatibility strings (such as "luo-v5" and "memfd-v1") to
validate ABI compatibility across kexec live updates. Any modification
to serialized structures requires bumping the version string, which
strictly breaks compatibility between adjacent kernels even when changes
are additive, backwards-compatible, or optional.

This RFC series transitions LUO and subsystem file handlers to use
granular feature bitmasks instead of compatibility strings. We replace
the compatibility string with a header structure that includes some
reserved space to define the features that are included after the
feature.

We include 3 bits of data for each feature: supported, active, and
required. When the supported bit is set in the next kernel, the previous
kernel can serialize the feature and pass it to the next kernel. When
the active bit is set, it means the previous occurred and the data for
that feature is valid. When the required bit is set, it means that the
next kernel must have the associated supported bit in order to be
compatible.

If a feature is required in that it cannot live update to a kernel that
does not support the feature, it is expected that the feature not be
active or required initially. This allows for an intermediate upgrade
path.

Overview of Changes:
1. Define feature header and migrate luo_ser (Patch 1):
  - Introudce the feature header with the supported, active, and
    required bits.
  - Replace the luo compatibility string with this new header.
  - Validate the preserved size is at least the size of the header. This
    breaks compatibility with the old way.

2. Export feature header information to vmlinux (Patch 2):
  - Adds a .liveupdate_features section in vmlinux containing
  - Adds helper macros to export feature information for a given
    subsystem
  - Export luo's feature information

3. Memfd Handler Migration (Patch 3):
  - Migrate memfd to use the feature header instead of compatibility
    strings

Logan Odell (3):
  luo: Move to feature flags instead of compatibility strings
  luo: Export feature support to vmlinux section
  luo: memfd: Move to feature flags instead of compatibility strings

 include/asm-generic/vmlinux.lds.h |  12 ++++
 include/linux/kho/abi/luo.h       | 114 +++++++++++++++++++++++++-----
 include/linux/kho/abi/memfd.h     |  41 +++++++----
 include/linux/liveupdate.h        |  22 ++++--
 kernel/liveupdate/luo_core.c      |  60 ++++++++++++----
 kernel/liveupdate/luo_file.c      |  28 ++++----
 kernel/liveupdate/luo_flb.c       |   2 +-
 lib/tests/liveupdate.c            |   2 +-
 mm/memfd_luo.c                    |  40 ++++++++---
 9 files changed, 246 insertions(+), 75 deletions(-)

-- 
2.55.0.979.g7e5102b832-goog

