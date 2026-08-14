Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805483D25B6
	for <iommu@lists.linux.dev>; Fri, 14 Aug 2026 01:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786672612; cv=none; b=LI/Jd0B1o5aedjM9WrCn/fzwuDLgBSDAdXD9nuxTL2J/j+uOALJETl4p3iTxy27alanoEwqlhLi0OHqtvAsDdVxTQpcylLlN3ssS2azJxFN8iY5HN1383TMGj/fWmLe1yNJd4K1a2wWPbRRf8Vpdso6HkbCtmY2WmtjXjC/RNGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786672612; c=relaxed/simple;
	bh=NCd+j7nYxNHdzjcZFSHtTXKm1kUiQw8psOs+qwO+fZQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Wgho3IfVy7lQEzvajxPQmYQmZeKY8mUpzhxBuGYqKqmxS49gMtOw+a2VxZyNfda53x88UQKk2/eQ2bN42X+vo5D2Uj+PxxGnRXX/UBoChVRZcCvimo1N8uVRTRbYMwevLrEhnquj4fTmf7FNPv8/elgp5H68WRCaleMQ9vycZ6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HRYrznUy; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HRYrznUy"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cb5ea36f969so530921a12.2
        for <iommu@lists.linux.dev>; Thu, 13 Aug 2026 18:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786672611; x=1787277411; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OUkFjlhYb4V9G0SD2iUKbc3ig8CtlYc6GojhAFo6lwA=;
        b=HRYrznUygPIsQ5kqNwyagSD+2FQUywS+Odnc5FIBT+UFI46D7b+L7xbbhoclMmxtBn
         faGZhZTBTM1+Iock3Gj3tMRpcsvADiJhrxIVFlwKmNpjCEvkntAi3VexVCdacctXiRv1
         +81yVOk6aWGIPOEjfmdNQuPAElKRTPBCRbj5TR6yKgmtWIP6CAZn+vRkvkSFvVatzBkx
         k8gbuaKV+tGa5sLkoPtidKKKcspYoXwUGFycsnbcHaUrIn4Vzcvp9ZxFAKbmijrObjja
         rzFVUWSulCN1NbLSzMrp3cxXSKj9A4aK2x3GVwMNP4KmIO7sn9a1GNXYYkfCVAmvRLoZ
         8gZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786672611; x=1787277411;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OUkFjlhYb4V9G0SD2iUKbc3ig8CtlYc6GojhAFo6lwA=;
        b=svrGWC+nIje/9j+ApZS2qc5cKIpa3WyY2j+Vo+WHql3DHbsHyK4svhgNjZoSIa8eIW
         nFqSgInHGp3MAIV8sBZLlwNQfAljGJ3nJRbo9OwKh9rXcIrJhvPfI5pwSK8CCM2ouLUJ
         iYIcejw/hTJQcqKj2Jx6rOrZdJAqEn5fN1AE57jTTcyri7siKDTxaZ+XJKkp0IGh4IKm
         o7LpbePYYRg3RJQjjz0MpcM5Xp9UG/WVejwqI6WxDMbDHaX0JPyAnuV4Z5E/aB3KADj7
         w2rylPzNYM3dXLAFOJbjvvkGzIxFeYTVuCxqntcgVexB/PGkVXBICbraxNnSGNQ+8VVb
         cLVQ==
X-Gm-Message-State: AOJu0Yxweu32haQxE1+o0L9A2z3VQe59MijQSsXpy5zwsRknzuDMiu0+
	IK1sC1/gIBG1kY2CYjs+3PylEd0eKIH8Z3LFBHnMzRoUpJrKNVw0rS/ZROaNNG1EOTO4f6ZjBM5
	iIcsUSpsazLbIUOyItqe+vDIUr7Zz2ntb6mqBVE4oDeKs76gCOGnc3fimjImejF04asVML+di+p
	SnjhrHHDoQ0eOtCF4stiBA25+42/LF8g==
X-Received: from dybia9.prod.google.com ([2002:a05:7301:309:b0:314:f66b:be54])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:7a86:b0:3c3:875d:705e
 with SMTP id adf61e73a8af0-3cc71d7a018mr2488543637.19.1786672610589; Thu, 13
 Aug 2026 18:56:50 -0700 (PDT)
Date: Fri, 14 Aug 2026 01:56:42 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260814015647.3370124-1-praan@google.com>
Subject: [PATCH v2 0/5] iommu/amd: Refactors for ATS robustness
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	Vasant Hegde <vasant.hegde@amd.com>, Ankit Soni <ankit.soni@amd.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

This series forms the second half of the subsystem-wide ATS robustness
updates. The first part (focusing on the core subsystem, Intel, and ARM
SMMUv3) has already been merged upstream [1]. This half addresses the
AMD IOMMU driver and standardizes the PCI ATS API.

In v2, the series has been significantly restructured based on feedback
on v1. 

[v2]

 - Patch 1 Refctors the probe path, isolating capabilities into 
   iommu_init_device_caps().
 - Patch 2 renames iommu_ignore_device() to iommu_disable_device_dma().
   Following Jason's suggestion, it invalidates the hardware DTE by
   clearing the Valid bit (lower 128 bits) followed by the upper
   128 bits.  
 - Patch 3 splits the probe error paths to ensure that devices with
   config failures (like PD_MODE_NONE or ATS mismatches) can preserve
   their rlookup_table entries, successfully keeping IRQ remapping 
   functional for bypassed devices.
 - Patch 4 implements the "Fail Hard" pattern for ATS in the AMD driver,
   failing the probe and throwing a WARN_ON() upon ATS configuration or
   enablement failures.
 - Patch 5 enforces the checking of pci_ats_supported() prior to calling
   pci_prepare_ats() across the entire kernel PCI subsystem.

[v1]
 - https://lore.kernel.org/all/20260601134204.2150602-1-praan@google.com/

Thanks,
Praan

[1] https://lore.kernel.org/all/20260615235037.259909-1-praan@google.com/

Pranjal Shrivastava (5):
  iommu/amd: Refactor device probe and capability initialization
  iommu/amd: Fix DTE clearing and rename iommu_ignore_device()
  iommu/amd: Split probe error paths to preserve IRQ remapping
  iommu/amd: Fail probe on ATS configuration failure
  PCI/ATS: Mandate checking pci_ats_supported() before pci_prepare_ats()

 drivers/iommu/amd/iommu.c | 196 +++++++++++++++++++++++---------------
 drivers/pci/ats.c         |   6 +-
 2 files changed, 122 insertions(+), 80 deletions(-)

-- 
2.55.0.691.gc56d675ccc-goog

