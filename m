Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD683CFF62
	for <iommu@lists.linux.dev>; Fri, 29 May 2026 11:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780053135; cv=none; b=QLICeHC58NZdrGPJcqdR+WLXHg/eYoKJ21fzbHnxzChs3R2hbxAMuQKoNLR/SLbEdIaQtIaeoVAvLHqVVct2bBiFOISyMftdqZsHXy/bMHXUHv7CCyh74rbZcqKRE/Pq+XTaq+miB0qKSIb2aGWBkhytydRik7TtAmdke5lbFK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780053135; c=relaxed/simple;
	bh=YPpTmg45GJK8y+rb5wGdt6oO/mzN5qPxq8bXqYfGSdM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=gcNM/BNR72DcG+6ncZHZekNq5hvRgtedZHPik0IL5pEueQj24QSldQsb1TYgOp+wgteFjs2Hms0bhHgzeIbydZTHxE2dZW/AJ6YFZUEvLPcv7WtCFdPjnMyxim76n5B1N1fjD5p3eYgc5NA/RTh6kB9OsaDf5ni/4lFlesAubDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CERZlK5D; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CERZlK5D"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8353fbc7ad5so7129215b3a.3
        for <iommu@lists.linux.dev>; Fri, 29 May 2026 04:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780053132; x=1780657932; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lCxdVVEheuvS2AoHvSV+25X74uQUGsdU+w3bwjC0ns0=;
        b=CERZlK5D0a04bVj5HyoEyIxCMnGm6W6NGNX0s44xwzZg+tI0N1U7qrZjvn0pNVojNX
         6tTyOZ/WkrjExSbCSf9ZK06G3/OwKBkSBmccOcTPZ1orXB2hodmeeh8zsE9uMA6tVNe/
         7LPthGweD1UWZb6aGIuPfcNw+u6thrs+bxVEEbVygfAqXG3c0ZWpt2yztudziU47jC6u
         kFzyfF4LBd5CRlQqU1WNRp0sQY/XDnIvPra9RQutmTmnqWT8JQ1S/znG4LWsyfRWUull
         c6OBfnfvc8mC2yq7mzY72kiiDaeKKR22XGTpzQMelckOtExmZHYpAYsaGRvqoixjkJKR
         cIVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780053132; x=1780657932;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lCxdVVEheuvS2AoHvSV+25X74uQUGsdU+w3bwjC0ns0=;
        b=moFxJ4r6MKPz3yXDKS9pe0Q83X59di5dVlDZ4YWogCrUsrsteNRSz/x+1xOg+vE82Z
         dKagxKUzd4C5p/4oGhRvSMHtvk51SSPGBz1mkYaM9D69gxfqFOSOxFsGcenPLJaMJLjk
         X35lmAj2DsOqWBj+CTYc81b4yxahM7Eu6vCvXO37qf0K1kEeZoH4kn6+SqOvz6vdosmk
         OLpPrp/zErYPyKG6e0TtSQA8uKedlcBanA6XT2hoW2hQlssB+bEPHJAvW7UdfkNZk45G
         dB0VgVAc7dR+SIg8Z6mMT6xIkfbuR0Pj9Kfbaq9QwJFMPxok2xUh76a++c5Zwy/ns/hp
         P2Mw==
X-Gm-Message-State: AOJu0YxqOGpx5OmbtvmQ10B9Yhip326Z53b7ig2d3p4MN1/21E7ApTjE
	l8yuF0SPh2a5Pj2/x6VmThAkwy9tt6KwO2PvFNsBYzO82I0cWVSMo1yd4PK+9GepJYQiiYOfYHA
	bai+R8eJMeJ8KPcEBjAx/NvJQlpdDz0iqfgg/2APf/1d3HeBcZFkllkIPVsQMbEz929w/K7hmkJ
	MyZH6RMoVSOUXR9z+XB3B/TVbRd0JpMA==
X-Received: from pfbgj6.prod.google.com ([2002:a05:6a00:8406:b0:841:c3cc:207d])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3693:b0:837:8c8f:8f51
 with SMTP id d2e1a72fcca58-84212dc82c2mr2600820b3a.47.1780053131812; Fri, 29
 May 2026 04:12:11 -0700 (PDT)
Date: Fri, 29 May 2026 11:12:02 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529111208.387412-1-praan@google.com>
Subject: [PATCH v6 0/6] iommu: Standardize ATS robustness and state tracking
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Robin Murphy <robin.murphy@arm.com>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Nicolin Chen <nicolinc@nvidia.com>, David Matlack <dmatlack@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Daniel Mentz <danielmentz@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Mostafa Saleh <smostafa@google.com>, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

The primary motivation for this series is an ATS state mismatch observed
under heavy load (via iova_stress). A failure in pci_enable_ats() leaves
IOMMU drivers like arm-smmu-v3 with inconsistent state leading to PCI core
warnings during device detach.

While David's recent work [1] addressed a discovery race for specific
quirked devices by moving them to the HEADER phase, gaps remained
regarding how Virtual Functions (VFs) inherit state from their Physical
Functions (PFs). Specifically, pci_ats_supported() did not account for
PF-level quirked status, and pci_prepare_ats() lacked STU validation for
VFs.

Based on discussion with Jason and Baolu in v3/v5, it was decided that the
IOMMU drivers should explicitly check pci_ats_supported() before calling
pci_prepare_ats(). To enforce this, pci_prepare_ats() now noisily checks
for support via WARN_ON(). Furthermore, the device probe should fail if
pci_prepare_ats() fails. Since these early gates preclude software
configuration errors, any remaining failure during pci_enable_ats() is
treated as a kernel bug.

This series standardizes this pattern across ARM SMMUv3, Intel VT-d, &
AMD IOMMU drivers.

[1] https://lore.kernel.org/linux-pci/20260403222750.1215002-1-dmatlack@google.com/

[v6]
  - Reverted the decoupling of pci_ats_supported() from pci_prepare_ats().
  - Added a WARN_ON() to the internal support check in pci_prepare_ats().
  - Dropped the standalone Intel bugfixes (RB-tree and UAF) to be sent as a
   separate standalone series per maintainer request.
  - Kept the folded UAF fix in the AMD IOMMU patch to ensure the new error
   path is immediately safe.
  - Collected Reviewed-by tags from Lu Baolu for PCI core patches.

[v5]
  - https://lore.kernel.org/all/20260528202353.3422206-1-praan@google.com/
  - Decoupled pci_ats_supported() from pci_prepare_ats() in the PCI core.
  - Rebased SMMUv3 support on top of Nicolin Chen's "Always-On ATS" series.
  - Fixed pre-existing RB-tree corruption in VT-d probe (Baolu/Sashiko).
  - Addressed the pre-existing UAF in AMD IOMMU probe suggested by Sashiko.

[v4]
  - https://lore.kernel.org/all/20260525184347.4059549-1-praan@google.com/
  - Standardized the pattern across Intel VT-d and AMD IOMMU drivers.
  - Replaced the SMMUv3 ats_prepared gate with a fatal probe-fail logic.
  - Utilized WARN() macros for runtime enablement failures in all drivers.
  - Collected R-b tags from Jason and Sami.

Pranjal Shrivastava (6):
  PCI/ATS: Ensure pci_ats_supported() is PF-aware for VFs
  PCI/ATS: Validate STU for VFs in pci_prepare_ats()
  PCI/ATS: Mandate checking pci_ats_supported() before pci_prepare_ats()
  iommu/arm-smmu-v3: Standardize ATS enablement failure reporting
  iommu/vt-d: Fail probe on ATS configuration failure
  iommu/amd: Fail probe on ATS configuration failure

 drivers/iommu/amd/iommu.c                   | 30 ++++++++++++++++-----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 10 +++++--
 drivers/iommu/intel/iommu.c                 | 15 ++++++++---
 drivers/pci/ats.c                           | 19 +++++++++----
 4 files changed, 58 insertions(+), 16 deletions(-)

-- 
2.54.0.823.g6e5bcc1fc9-goog

