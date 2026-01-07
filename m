Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4E3F4FA
	for <iommu@lists.linux.dev>; Wed,  7 Jan 2026 20:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767817085; cv=none; b=jo+WjYN4bClBfv+oyoOsF1RDicDn86ZZ/rN2uzd+8EBuZd8IHCgchTWci0+RTfWSZN11qc6No1RnCE+v46FQm1/45sHVOZK0g/Fm0rlFTjXFSugpANDu5wa9yBvRxefy4WsiDmOtWYwDUk1yJ5S42h/ZD3TsrN5pgK/8itxtuOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767817085; c=relaxed/simple;
	bh=TvOkn6u8I9/U/iJG9I9EEu4rPAWu4/Ro3ETE+xAntc0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=FyTMU41wL0PxlmtHMTNUEcF6GaVVl7yYYa3CBCR3Cbb4nhBe0tJsXB/tCzgN9HGjGngfszbZNzFFxOJCcmsrhUFTDL1kTlIF5w1gwFHkiO5tS8Q6+ygUnf9YnEpHrD/g0v9FxmAOE65O7D9N+QfI9H2adDtZlq/YdBjZcjCJg7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3AcFK9Fq; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3AcFK9Fq"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-81b299128b8so1264870b3a.1
        for <iommu@lists.linux.dev>; Wed, 07 Jan 2026 12:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767817083; x=1768421883; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BRji2ofdtY/PgKBBjoXBJuWSbx9X2KHKEteqA3GTxBo=;
        b=3AcFK9FqnnzU01Cgkt/gBg37K4768EnF9cv/dbQ14Qrm38BVXLCR4gEVVI8Mbe7dYh
         L95eOlgMrDTEXvwbmCtxEXOUhGIppKqJ+Rk27QUn1qnYH3tv4cbEtynf2Y/0Gt5xz73q
         N3d8FJ7NOr9ip+36jUwj/w7BUFbIXihmQ8CWVKOPbDCALgvrgdUtIz9jR8/4rCZ5dFbG
         F2J7k45Akm4Mi3zpCTNVqtBQpuB2cL/8XiKL8PLI2dv2IcZ01/3IFQImR44FwKhvOexe
         WaiBtYXM7cogrVfpw5jyBsihm9w29cM4l6m+6xILTBO8bUDj/bm4bhxS8wV+Vkw1hwNj
         YGhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767817083; x=1768421883;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BRji2ofdtY/PgKBBjoXBJuWSbx9X2KHKEteqA3GTxBo=;
        b=AHFNZJZlDq3CUaEswQv1ZdZTvpm7vYjcsgD4cIN19sIXX4W6p1JtLEaUJD5D3HdJ6+
         nRv9oNfI+CQF5TPIpm3gnz8qHUy6h/qAZly+ZrgTICbjj5OAt1meotpBn457jQsblBjp
         1lPvnPZKEn3gAMgqht13S9QwavypNktrxGnDwUcMaVjxz1RDtuy64SNrSUnSRMo0+aSm
         I4twlrHbPDODTJE2Wfd4k0Bge0gpKrlfDCTmZJMKIV9ryd3O9IldsL7xuvrIFULVg16H
         ih8c/5RQfvaVZ3ERxVX734P6fjM8xDZgpLECSOhImSO7U0jgK65pltCkM5OLnZui+ULZ
         s+wA==
X-Forwarded-Encrypted: i=1; AJvYcCVouwxNiYE0Td04HQ8x5ZQuTMDzWu9xsUNZJ1/yBI4KVjSYP9aR8kNWadE/j2n2VEWwzSxaqQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyMhl4Qnau0DpkaKhPyzzMARgJnMw7YbeFmoVNpVa7S/sX9p4Pp
	dxrdeScVLfNOMJ/JrMzBuHagl5e6y+nMQPT/a2XxryL5f7ARuLFL6uhZ5G+FdadFg4i6aTE1u03
	CRFcmgb3U2qF0Qw==
X-Google-Smtp-Source: AGHT+IHpSjmtFIkns5HQtlhETgrC7VtMTaI0oceBagAYDCz1RUoLr1bA46QQW/+00lvC5tMM37yLiV7a8rdzpg==
X-Received: from pfblp20.prod.google.com ([2002:a05:6a00:3d54:b0:7b8:565a:73bd])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:8086:b0:7e8:4471:8c5 with SMTP id d2e1a72fcca58-81b7f101490mr3287211b3a.38.1767817082661;
 Wed, 07 Jan 2026 12:18:02 -0800 (PST)
Date: Wed,  7 Jan 2026 20:17:57 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Message-ID: <20260107201800.2486137-1-skhawaja@google.com>
Subject: [PATCH 0/3] iommu/vt-d: Add support to hitless replace IOMMU domain
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	David Matlack <dmatlack@google.com>
Cc: Samiullah Khawaja <skhawaja@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

Intel IOMMU Driver already supports replacing IOMMU domain hitlessly in
scalable mode. The support is not available in legacy mode and for
NO_PASID in scalable mode. This patch series adds the support for legacy
mode and NO_PASID scalable mode.

This is needed for the Live update IOMMU persistence to hotswap the
iommu domain after liveupdate:
https://lore.kernel.org/all/20251202230303.1017519-1-skhawaja@google.com/

The patch adds the support for scalable mode NO_PASID mode by using the
existing replace semantics. This works since in scalable mode the
context entries are not updated and only the pasid entries are updated.

The patch series also contains a vfio selftests for the iommu domain
replace using iommufd hwpt replace functionality.

Tested on a Host with scalable mode and on Qemu with legacy mode:

tools/testing/selftests/vfio/scripts/setup.sh <dsa_device_bdf>
tools/testing/selftests/vfio/vfio_iommufd_hwpt_replace_test <dsa_device_bdf>

TAP version 13
1..2
# Starting 2 tests from 2 test cases.
#  RUN           vfio_iommufd_replace_hwpt_test.domain_replace.memcpy ...
#            OK  vfio_iommufd_replace_hwpt_test.domain_replace.memcpy
ok 1 vfio_iommufd_replace_hwpt_test.domain_replace.memcpy
#  RUN           vfio_iommufd_replace_hwpt_test.noreplace.memcpy ...
#            OK  vfio_iommufd_replace_hwpt_test.noreplace.memcpy
ok 2 vfio_iommufd_replace_hwpt_test.noreplace.memcpy
# PASSED: 2 / 2 tests passed.
# Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0

Samiullah Khawaja (3):
  iommu/vt-d: Allow replacing no_pasid iommu_domain
  vfio: selftests: Add support of creating iommus from iommufd
  vfio: selftests: Add iommufd hwpt replace test

 drivers/iommu/intel/iommu.c                   | 107 +++++++++----
 tools/testing/selftests/vfio/Makefile         |   1 +
 .../vfio/lib/include/libvfio/iommu.h          |   2 +
 .../lib/include/libvfio/vfio_pci_device.h     |   2 +
 tools/testing/selftests/vfio/lib/iommu.c      |  60 ++++++-
 .../selftests/vfio/lib/vfio_pci_device.c      |  16 +-
 .../vfio/vfio_iommufd_hwpt_replace_test.c     | 151 ++++++++++++++++++
 7 files changed, 303 insertions(+), 36 deletions(-)
 create mode 100644 tools/testing/selftests/vfio/vfio_iommufd_hwpt_replace_test.c


base-commit: 6cd6c12031130a349a098dbeb19d8c3070d2dfbe
-- 
2.52.0.351.gbe84eed79e-goog

