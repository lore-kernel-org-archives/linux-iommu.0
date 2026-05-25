Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9454036E468
	for <iommu@lists.linux.dev>; Mon, 25 May 2026 18:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779734632; cv=none; b=abqIo0ZdQI4b0k9IjayMW9IhW3X5vcSHQPZGqHUBtb+Jx6Gd978vrg6YwR8IpcJ5TSSfORct5uTmcREkF9U/PJ3DLMdbvBf08byu8a6ZhsgieuAazWzm38VC89EMKAMr+qyY1f+ytYVaFE3zFozxmsSeP0Kzm2erUWh81RC/3ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779734632; c=relaxed/simple;
	bh=S3WwxYOwTFTGOXsA16goqVxlrACGQO7go6i+UDqPF0o=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=byCF9U0V6vGeVoBr5yxatuAq7KSnhz7js+nz5vls31tZ8gsmj3UwNzLI2/wAoEXm2aGlIxgzKGng3Y8yM9Ah9rB/C39drF75TFl1Hu9VymSeJYso9X40Q3jCD5rnMHQ82mYtnbYtTB6+QIJhiVIs/DMAFFHlVVmPzEQ2LmIjVec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aPA9QQza; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aPA9QQza"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bc7f9b2213so71211235ad.0
        for <iommu@lists.linux.dev>; Mon, 25 May 2026 11:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779734631; x=1780339431; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hKucAVRhiN094mFuCmSJPl9Zvf4iz9kVDYBn+OIoEcY=;
        b=aPA9QQzaFxeT1iJEAFqdpkceMzx7Rqyftzo+EUFnDf0UrXJxyc1Vtt9xIofKJ+PGtv
         yLhQctbgxKoYs9lg0/nKnMxinHxa+vTBHVnChJWPE+MWQUYNv/nwwfO4B9vhVG3+UhiJ
         d7zQ9uo3K9Vq0m1pDyqmzrYGv5GgeEz/5VFEk/dX5ZaGxbw4XLlAmnhmQ7TlU71DHOWu
         5AJruyCTZSJVXXGR8Mok+ZpDxciNiYdyDbvH1ewGxHKUxb/UUEBSchws8X2L3UB4dfAa
         tQH7VrRxWwTu+a4NMToEZoNfdRbA1I552QnAFzCdtOVpOw3cgmf/eyUbt6+svvRIy7M+
         vrIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779734631; x=1780339431;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hKucAVRhiN094mFuCmSJPl9Zvf4iz9kVDYBn+OIoEcY=;
        b=Aid1vwRRPP9peJKHX/0lQSLR7r0+B+/f2p23jS3WqkKTV+5S5Wiy2F1f41VioF1Ce1
         Xm2BnvuHRtEaBEWdFZYt+QL/Yl4qZ+3ksJgjLF0LZ53/RDxEw21L67qHItVtoXvmyRux
         29nkPcu1HmrGJmgki91lgIQGWdzQX1I6kzPPixPhhK0u8R4TreEHhhQFX+gTo3kQq+NF
         NseVGtry7M46w6zQ10uBllbxXYUrOu6HgPffHBcDO4Xv8JuoSMU05jgr2OhC8PoKNCBD
         AEjX12Hwf+DGvfT6P9w7GkzvPvXhZ7BmSCMhLOTXRLl39eLanpGlpa3vmvzax5GoynYD
         v7eA==
X-Gm-Message-State: AOJu0Yy7jaESUHb7UQe0WDEjSV97SQ9BSyprROGzWaHZ3nkAUO9Yw+wW
	ItBwr2ifmFE1gzW7wXLj+uHjdUHfd8/w/cxYLA0ceNm30OQYI9Cjy/3djzmI3aMvhEasD+S57KG
	ZWSsivYV/wok5xcfvIwt6F/9beQzsBY58yHbuk3XnARBYLs9fOFXzibtcvqF7RX46zFFEgJXVDv
	VCcKfLO0tNveLhiPr10xQkkZQauvLY4g==
X-Received: from pllo21.prod.google.com ([2002:a17:902:7795:b0:2b7:882d:6a56])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d50c:b0:2bc:78ec:54cf
 with SMTP id d9443c01a7336-2beb035a83bmr182353345ad.9.1779734630658; Mon, 25
 May 2026 11:43:50 -0700 (PDT)
Date: Mon, 25 May 2026 18:43:42 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260525184347.4059549-1-praan@google.com>
Subject: [PATCH v4 0/5] iommu: Standardize ATS robustness and state tracking
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

Based on discussion with Jason in v3 it was decided that IOMMU drivers 
should explicitly check pci_ats_supported before calling pci_prepare_ats
and the device probe should fail if pci_prepare_ats fails. Since these
early gates preclude software configuration errors, any remaining failure
during pci_enable_ats() is treated as a kernel bug & reported via WARN().

This series standardizes this pattern across ARM SMMUv3, Intel VT-d, &
AMD IOMMU drivers.

[1] https://lore.kernel.org/linux-pci/20260403222750.1215002-1-dmatlack@google.com/

[v4]
 - Standardized the pattern across Intel VT-d and AMD IOMMU drivers.
 - Replaced the SMMUv3 ats_prepared gate with a fatal probe-fail logic.
 - Utilized WARN() macros for runtime enablement failures in all drivers.
 - Collected R-b tags from Jason and Sami.

[v3] https://lore.kernel.org/all/20260519135323.1558777-1-praan@google.com/
[v2] https://lore.kernel.org/all/20260504163842.2692314-1-praan@google.com/

Pranjal Shrivastava (5):
  PCI/ATS: Ensure pci_ats_supported() is PF-aware for VFs
  PCI/ATS: Validate STU for VFs in pci_prepare_ats()
  iommu/arm-smmu-v3: Fix ATS state tracking
  iommu/vt-d: Fail probe on ATS configuration failure
  iommu/amd: Fail probe on ATS configuration failure

 drivers/iommu/amd/iommu.c                   | 27 ++++++++++++++++-----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 21 +++++++++++++---
 drivers/iommu/intel/iommu.c                 | 15 +++++++++---
 drivers/pci/ats.c                           | 14 ++++++++---
 4 files changed, 61 insertions(+), 16 deletions(-)

-- 
2.54.0.746.g67dd491aae-goog

