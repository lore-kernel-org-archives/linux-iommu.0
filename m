Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0EC3AC0DC
	for <iommu@lists.linux.dev>; Mon,  1 Jun 2026 13:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780321330; cv=none; b=iR6KfHmD1ioly/l64zuHBMHYLdFHPnMqCTqdxXTcjcg/MfBBbZr1RiSnw7Qh3uE7cHIogqRvyPP9UA+uTu4ELs+hyaK+4KbIzzuKyD4XGSH320t4sBIpEt4YOvkVIO4xlk1stQcQBJZKoRMJiIgfhsV3Z7CN2ZUpKMSjDALRcjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780321330; c=relaxed/simple;
	bh=dy6ZJdEwqGXi1D7BxWGTU7NpCU8NjUAJeGH49rbOLEw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pFuMGFE9Snq+SVjt/dXg4AIt+bnhwxoHfJR0+NJ3HpH/bE4U7vGn6qITYYJbs3fwhmLwCMzG2xc34d5UFJZ5JRUBUKbRuEoeh9WAFG2s/Pd4akX7TbvIRLCwQsz/cSP5f4eZjWslcwuTw9Oyxb7kZgzl0pR/4SvXQThEve3y/ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ovnKMBDW; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ovnKMBDW"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36b9d265308so3148829a91.2
        for <iommu@lists.linux.dev>; Mon, 01 Jun 2026 06:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780321328; x=1780926128; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rR61/+xb/oc53nV+wAUc+P1RLRo45eSY8sAO+f4MVRQ=;
        b=ovnKMBDWAhQb3k8IIdDdb5QDeGXsHai0pjgdBvB5dO11Tg0n9iuhI2Y7yYDr2TiWTX
         qBFMJtoQMSzerCUrXEH+ZNvFrzZA+/mX4J11zvK/k/oPvwYnkVcU3zgl3HCui/V16w3O
         X5L3Tq6vEvcF0TvepYoPIJV9YCkTNh5IOSmZ+nTlBc2UU4MoMIIkggiJ+GY2lfGf7VAw
         w6gW+bWjbZHiezeWPMc0K+RSClBjB1VRI8vCRMkfMihF7VBoWapPWlgSkD06FeJn1plj
         y73Mxefk6VGlaZ7zvK479ZN426eDsxWnHhy7EesFlzLc3ojZcVVEsWiVefIuGlHHJYin
         MVtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780321328; x=1780926128;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rR61/+xb/oc53nV+wAUc+P1RLRo45eSY8sAO+f4MVRQ=;
        b=XrXxNKlweKCHKtnncB4abzs/nqjivFX77AqVqU4QJ+HVwviSvh8DkolyvuLZ9sfoYM
         P5ipqr1zZEvcbB3rTF0oRUhSVN2WBlFXKF2z6ulZM5nF8Fh2HndEmxK33DfYJvkrxYhL
         wOQwXg77dCSEnf7nhApXWwbvKv2tq6hZ8z0tG8ICLhAxwHTIIWfNHfN5mnbA3w4t3PD9
         P/Ud6jhIZv6Y72RYZCLs7J+FlPcKFQJUeBBorg0hXS61BaaWUoCPGeGVotDc7Lb8pp8s
         U3SDSYMNbils4/YAeUgmS48d2dXxglZiLNEhBhTLj/Jt3kIegZgq7r7LZOAeDRLNYpfJ
         YAZw==
X-Gm-Message-State: AOJu0YxvjmmTAcy2DxMsvJpr1XFNwaJW6NpXWi7d3CqcE62Z8xzeVLDf
	tLtNsZgtqvVB0Z1Aly0mDRn0ifngqINEzNtppaX5KbbUFuvdbFN5pm/CyWbalcPcHhbJjwY9Hgq
	vm6BpZ1fFH/76ccm/DDp/PpUyzteF1Yk+FEPYvD4EBVlUCxf1/oCuobC+gDPYw5GKAVYH5R2YdR
	dpGUR41D6bAMARmJjeXgeSpzXItNPLnw==
X-Received: from pjbiq7.prod.google.com ([2002:a17:90a:fb47:b0:36b:dc35:1b43])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:c2cc:b0:36a:7da3:266b
 with SMTP id 98e67ed59e1d1-36c68473b45mr10733749a91.21.1780321328092; Mon, 01
 Jun 2026 06:42:08 -0700 (PDT)
Date: Mon,  1 Jun 2026 13:41:58 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260601134204.2150602-1-praan@google.com>
Subject: [PATCH 0/6] iommu/amd: Refactors for ATS updates
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	Vasant Hegde <vasant.hegde@amd.com>, Ankit Soni <ankit.soni@amd.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

This series addresses some issues identified by Sashiko in the AMD IOMMU
driver during the review of the subsystem-wide ATS update work [1].

Patches 1-2 address the  pre-existing bugs in iommu_ignore_device()
regarding the order of alias clearing and cleaning up the DTEs. 

Patches 3-4 refine the probe error paths. As noted[2] by Ankit & Sashiko,
unconditionally calling iommu_ignore_device() on probe failure breaks
IRQ remapping for devices in PD_MODE_NONE. We now split the error paths
in probe_device to preserve interrupt mapping for non-fatal failures
while ensuring that dangling device pointers are cleared to prevent 
potential UAFs.

Finally, patch 5 implements the Fail Hard pattern being standardized
for ATS, ensuring configuration errors are caught during probe_device and
ATS enablement failures are reported with a WARN_ON().

Patch 6 is carried forward as is from the original ATS work [3] to
maintain bisectibility.

[1] https://lore.kernel.org/all/20260529111208.387412-1-praan@google.com/
[2] https://lore.kernel.org/all/20260529153216.2AD1E1F00899@smtp.kernel.org/
[3] https://lore.kernel.org/all/20260529111208.387412-4-praan@google.com/

Thanks,
Praan

Pranjal Shrivastava (6):
  iommu/amd: Clear aliases before setting the rlookup_table to NULL
  iommu/amd: Clear DTE with update_dte256 in iommu_ignore_device()
  iommu/amd: Split probe error paths to preserve IRQ remapping
  iommu/amd: Fix Use-After-Free in non-fatal probe error path
  iommu/amd: Fail probe on ATS configuration failure
  PCI/ATS: Mandate checking pci_ats_supported() before pci_prepare_ats()

 drivers/iommu/amd/iommu.c | 61 ++++++++++++++++++++++++++++++++-------
 drivers/pci/ats.c         |  6 ++--
 2 files changed, 55 insertions(+), 12 deletions(-)

base-commit: 283d245468a2b61c41aa8b582f25ed5615d1c304
-- 
2.54.0.823.g6e5bcc1fc9-goog

