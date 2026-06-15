Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDF435CB87
	for <iommu@lists.linux.dev>; Mon, 15 Jun 2026 23:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781567449; cv=none; b=CRkRQMXKORSQf8Nl+Q3xtt0kgVasVHHIK4dE+LAaZcKVEqHKA766cT2jAwArFZH2XMOftilVnteHDUSOIJ7r/kaYVhtf0+x+d/0KxI+Pw/ehCYllWPvR3k2Av1iZyl79RQCnb8hHY674jpwgDIGaPDFwF35PRi5ZMph5jNcZTU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781567449; c=relaxed/simple;
	bh=ZRWdb3UYrDa8ESWvtuWoYvy7WkD9/edpMBm0rxXZBM4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OCAUhlLa6XZ0eMBNTQbDnhvonjUabqYwCNlmkRMJQlFz3PvDx4dYEgkbYP5A3CM4wvjNJyKfirXi0xnIq8svc63RgoqC8a8wha6pg5uCmVmBnI82d7RvIJX2DdxpLGCidMfmJp6RRFKfeDLeaBFvLh5r1xMzt8xOXhRmfznp84Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HlFV+UtT; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HlFV+UtT"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c8584e3fc96so1837334a12.1
        for <iommu@lists.linux.dev>; Mon, 15 Jun 2026 16:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781567446; x=1782172246; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bsyi4xBeP3u6liStyWuzFOXTICTm8//1Wtemk4ZJB9U=;
        b=HlFV+UtTUffQKHHSMBPfYoeLXyqfe1ZrR/UUStOgLP+5cgI2yg5GPzoIN+aMOgmQRS
         DabhRDAkGzv64kWR3YbkiNHWeh14voozedyikoQhZX9b2iukMSKQM05yaoSvrc0eDbqP
         Qaopu7WxnuFsQorSXS2wAThCNmxEXAdStn/5+YC5linQDOpqD2RyMN5bMvrkG4T8lbbQ
         3gaRLBc7MuhzzE7uby2qxDaH4D6X2I7VtOuXphtywVEkSI7jHwZOhYOEgmdC+Ut8WQc8
         8cvdHuszigwuWi+11FC/HL+oj32eUcuIHeXtJHi4bt1STTEEocazeEVo9XR80ecHfJx8
         y9zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781567446; x=1782172246;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bsyi4xBeP3u6liStyWuzFOXTICTm8//1Wtemk4ZJB9U=;
        b=QdlOk6j5npoeWhkqcJ+nxcq89pEgCKTbjd9wXspvzsEzT8ZSN04Mwc9Hgzl6+Z9T3X
         vew9/ec4UmCoXHKvKqj6/R9a8CiZ9ih16VtP0lm/HTXCF5cc4Rt6m7aGESA3eT88Gtz3
         9pQTsKg/n9h34F4fLklxGSvZzYywfUm9lz+iHVoGByvriql6dk/5Z/hJA8p5FTPdKNTP
         Mf93vwW3NFnbvf0AfFeW7ebQp3NHK3TPTvpUdKyKPc5YPe6jHJFQ+P1AV0hj2flpbD93
         FwDOscHSguPybCeVgjKl3Pyd4dFS/oBt6XTOgZ4XHaJZ+fL4TJJ0L0ZD0eCB092fbxo5
         2h8Q==
X-Gm-Message-State: AOJu0Yx6dy4PWMOg0cATTajCgzrC3TzzP9lBVtIg0MGaj0fpFnQ9+V13
	lTA1bn1oOBc+y20v8mZx/+cTFpB11kEc4EzyZo4GMAOYcbHBVxgXfWcyry86dxEJfPxQf3W31DF
	M/pSnSQQSFwwQYRtSfX6VOifaxDZMau7QJ0ZMznNvlaonDqvsJEgIZzM0rD31E2mmaXbsO7zek8
	x27c7h5yXFXprrc70gSjVuutApHX0FSw==
X-Received: from pga4.prod.google.com ([2002:a05:6a02:4f84:b0:c7c:4b52:febd])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:6708:b0:3a2:d316:de53
 with SMTP id adf61e73a8af0-3b795fd5b0cmr14510565637.0.1781567445706; Mon, 15
 Jun 2026 16:50:45 -0700 (PDT)
Date: Mon, 15 Jun 2026 23:50:35 +0000
In-Reply-To: <20260615235037.259909-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260615235037.259909-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260615235037.259909-3-praan@google.com>
Subject: [PATCH v9 2/4] PCI/ATS: Validate STU for VFs in pci_prepare_ats()
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Baolu Lu <baolu.lu@linux.intel.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Pranjal Shrivastava <praan@google.com>, Nicolin Chen <nicolinc@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

While every PCI Function that implements ATS has an independent ATS
Extended Capability structure with a Read/Write Smallest Translation
Unit (STU) field, the kernel manages SR-IOV ATS by requiring the IOMMU
driver to configure the STU on the Physical Function (PF) before any
any Virtual Functions (VFs) are created.

Currently, pci_prepare_ats() bails out early for VFs, assuming that the
PF has already been correctly prepared. However, this creates a potential
mismatch if a VF is subsequently prepared with a different page shift.

Update pci_prepare_ats() to validate that the requested page shift (ps)
matches the STU already configured in the associated PF. This ensures
early detection of incompatible configurations and maintains the kernel's
policy of consistent STU sizing across all functions associated with a
given SMMU.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/pci/ats.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 679a3c3c1d54..9cb23780093d 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -73,8 +73,12 @@ int pci_prepare_ats(struct pci_dev *dev, int ps)
 	if (ps < PCI_ATS_MIN_STU)
 		return -EINVAL;
 
-	if (dev->is_virtfn)
+	if (dev->is_virtfn) {
+		if (pci_physfn(dev)->ats_stu != ps)
+			return -EINVAL;
+
 		return 0;
+	}
 
 	dev->ats_stu = ps;
 	ctrl = PCI_ATS_CTRL_STU(dev->ats_stu - PCI_ATS_MIN_STU);
-- 
2.54.0.1136.gdb2ca164c4-goog

