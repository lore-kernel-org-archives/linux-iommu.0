Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4908E3403E8
	for <iommu@lists.linux.dev>; Tue, 19 May 2026 13:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779198816; cv=none; b=Ac5xdmACmSFV5kXlw5bLW/Nr1LkteXBixdoZN4lob846N0uDTncTjHNEmutaZHMz1F1tlyzLKAewkYXcKZxBzIjxSBe2RrO+6xfs/A9BMGrW1E9lefYbi5DJD1F5IIyNtfqZG9j2z3ASZ0hIq8lD7J+zIAImo2sONjf3ouuoWkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779198816; c=relaxed/simple;
	bh=F77Y+VEw2xuBQKl2TrIZqfw7tzIvP+VoFwv7s/NVV0E=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=T4RIIz5eRitu1jr6UkonhUPHvnJLaoiwE9dPsex3lAcI3vAX+NL5TxR0RVhKVvDPbNKImVM0ABzXiEA94s/4fdnbGuX8luFdWIuZ4MDc76nbA56APAsc9aZyyPKgAZg5nqbx+l2hD2zPg96iobpLHDT9mQ74cKhqCQqhjEuNEBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HaT6R0Ax; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HaT6R0Ax"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-367f715cbd0so3745673a91.0
        for <iommu@lists.linux.dev>; Tue, 19 May 2026 06:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779198814; x=1779803614; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LseJJ503fMaFTO/RV87YZuQhoIlQze9D5qECxjs2xgM=;
        b=HaT6R0AxP03gR057h3BO5mup2yCqPhtoEGCTVvwFx29m0JZ1l7bgwCz60kwRn3sT2w
         sRsPku9psr5FEhgILS/Zob1Ysd0qOtLUOxmSaBHFAS6sHuIXbObTXcLJ2XvUDSLQuUhy
         G5KG9t9mpXDnY2HLRzeCkCJ2fVasfZRDClqBZ8ikLXv/69LVbmC/ss/RhhfSKioz4BH/
         CekEmFyrlW9+rEXZUyAlwGoQ/9ZTwnsrf5libOX+di9ANh96VUlvZ3VdaPvyMxUvB8+Y
         iaURNvBfKCTENhqilPqAacigakptvoVHLPLbqVb2ymgpUZjaSsY3/xHpODz0N27n9Zu4
         9HiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779198814; x=1779803614;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LseJJ503fMaFTO/RV87YZuQhoIlQze9D5qECxjs2xgM=;
        b=n10+Ec3aEjQGzsSDVdyTg7MTtTerHyQKm8C2Bn0ZSKxvNq/xKksvDwYJWFfuwG/Z/T
         NRQRn1Nt5aD1ktTiUz4WcrFsffpuPRK5NzVVXgiv0pam1Gnyrs8AjqvBUi7RE3IKFOYC
         BcaEO55FV/vR5ddI605tkr1OA01XslyMADxCyptdKiar8N2YGj+HmvJpwZxPOxN7b/hK
         Qdx8ugqyq6xuL2YZgAf5Llxt6kVBIlOYruCWVElqEv4Os6B/Qm3RqA6SgrNYP/oCpKY1
         cjPyIVmMZluGrhXKkYUUjgyto42An9s1gZXgs+mYk3SXPfpmg2lfSDB2H92PRMGgcztt
         7IsQ==
X-Gm-Message-State: AOJu0YzWn8w3x72F1IQRvR8J86olf+oiTOnXvUrRrr/u1i1GebUaX8Jv
	2OEPCYVH8G2jr3XwKYT/Nj1/Sbw1dYFteACJMAvU0f0uIcMjXBcvnPvNdoJxDfxTsQNdGdKjYbP
	MfieUVRkJwOYZK7R7nDvuVlsmFZY/EDFvqgYyC1/w8mgCQyWTw6TSUDflYKk0BPht5e8d3ZZ86q
	0UWbKZo7ULTSR/CpkQWY+gW1ZIjT0rWA==
X-Received: from pjbfz8.prod.google.com ([2002:a17:90b:248:b0:367:e13b:f33])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:33cd:b0:368:7536:b5b7
 with SMTP id 98e67ed59e1d1-36951b71e46mr19846027a91.16.1779198813302; Tue, 19
 May 2026 06:53:33 -0700 (PDT)
Date: Tue, 19 May 2026 13:53:19 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260519135323.1558777-1-praan@google.com>
Subject: [PATCH v3 0/3] iommu/arm-smmu-v3: Fix ATS robustness and state tracking
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, linux-pci@vger.kernel.org
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, Nicolin Chen <nicolinc@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Daniel Mentz <danielmentz@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"


This series addresses a set of related ATS robustness issues in the PCI
core and the ARM SMMUv3 driver.

The primary motivation is a state mismatch observed under heavy load
where a failure in pci_enable_ats() leaves the SMMUv3 driver with
inconsistent internal counters (nr_ats_masters), leading to memory
leaks and PCI core warnings during device detach.

While David's recent work [1] addressed the discovery race for specific
quirked devices by moving them to the HEADER phase, gaps remained 
regarding how Virtual Functions (VFs) inherit state from their Physical
Functions (PFs). Specifically, pci_ats_supported() did not account for
PF-level quirked status, and pci_prepare_ats() lacked STU validation for 
VFs.

This series addresses these gaps and hardens the SMMUv3 driver:
 - Patch 1 makes pci_ats_supported() PF-aware, ensuring PF-level
   constraints correctly propagate to VFs.
 - Patch 2 adds STU validation to pci_prepare_ats() for VFs, ensuring
   consistent page shift configurations.
 - Patch 3 introduces an 'ats_prepared' gate in the SMMUv3 driver to
   ensure that configuration failures at probe result in a clean
   fallback to non-ATS mode, preventing domain state pollution.

Thanks,
Pranjal

[1] https://lore.kernel.org/linux-pci/20260403222750.1215002-1-dmatlack@google.com/

v2: https://lore.kernel.org/all/20260504163842.2692314-1-praan@google.com/

Pranjal Shrivastava (3):
  PCI/ATS: Ensure pci_ats_supported() is PF-aware for VFs
  PCI/ATS: Validate STU for VFs in pci_prepare_ats()
  iommu/arm-smmu-v3: Fix ATS state tracking via ats_prepared gate

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  5 +++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 +
 drivers/pci/ats.c                           | 14 +++++++++++---
 3 files changed, 15 insertions(+), 5 deletions(-)

-- 
2.54.0.563.g4f69b47b94-goog

