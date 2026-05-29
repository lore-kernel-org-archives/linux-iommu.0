Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898633D1707
	for <iommu@lists.linux.dev>; Fri, 29 May 2026 11:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780053140; cv=none; b=srNZG/EEh9tuMyfO3XI8UMOc4oVhx1i0mQhh9bpHwri3Bl9IBIbhesoqORkoSuuUDApPLjRvuKA/NMIrjpkcM6ANz4cEWPeK2QO5iJjwiLehzN3wQ6kWUc8a1aHvRsabEDzYXcnF09eye5seHS3sORs2oZmEweNkAF1uAcN20bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780053140; c=relaxed/simple;
	bh=QMWF1Nn5UhAxAEgwX3QVOSlhArpqB7BokO3nvPMLRNI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u4ngmTVJOdAX8va5HvGFQ5pk4/2iCabBdQrM1/DNB6pkIe3T+xo9Kfv8Qj8vh/s4tfPEOpbW5dNnAVdhIwi1effQoxWGSDEEM2Ij2rYyGbmscsaX2/9MuSVQfMuQNGHi/HQvcMuWDmBB+bODvBTGyi3/oRuefZ2QtKEMJJYFYzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pxplEHs6; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pxplEHs6"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bf2bc4371bso1554065ad.1
        for <iommu@lists.linux.dev>; Fri, 29 May 2026 04:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780053137; x=1780657937; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V1OhefJlO7SddiDjet5+3aQQ9KCjHVV2cUEJthb1Tt4=;
        b=pxplEHs6BDJ1dhjbi34GO4TXBGzNuIOFbEosu4gXtEOQOO3jj68PTY0b4Bv5NuGlo8
         XFhwrX7u9571XNa47bHkc40bbZMNt+d2PLImAzf+fpw1d5pJIE6N6EiH59uG3xOOVdf5
         VgZHwlt5+BzgXgFl89ue+0yfH4b/9+6+5B4QNBra9c2rJ2O7fy8lCMoEd2V2nT1dRnlR
         lwwpCt9csqmjLVzTMoEvTpUP2OYrlNZXC8FPEyPQxnfDhT24CDs+cr1rLiOzJhZIix+6
         CxAAIu12zxG4t7cy2MgUWpG8rWNR6wtE8DLziM/FKFzCOxv4/B9KHXQfyK4Yrh5vpFaf
         DGKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780053137; x=1780657937;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V1OhefJlO7SddiDjet5+3aQQ9KCjHVV2cUEJthb1Tt4=;
        b=q2USyyjnXmYKEN2YPb3ircbd5EJxQXb/Cp8AvvrJ+Yjbr6lhqzQAmvL8gOrQU28WNk
         SC3gwghpG4hW6/KYzKDZeQQwbUCQ4tWF8ZQaFDHjMxbLjQcmV/2D32mcHRZqtZ0o8lA0
         9/WVbts+HXKGHy3OYRm5zzzOgKshE0DfI1BV1HlF/qLdRIQKPL+9rNWcKHBf4IzgZIGm
         Ks1+q+7a/WPjcr+uIsvVXDBJsgEgW+4PRv14DxFXMReGnRUKQR9NAwCt79e/21kB6g5n
         n3R05IxZfse2/FF5Rq+/k2uOTh296a+fg7p0qgwdLlvq1FIpO2VwWtrBRBdJOazmEFIT
         Ls2A==
X-Gm-Message-State: AOJu0YxFonNAWTHKtuUpLjO9RVqfBSkyI4dHloz0XEWeQokvKExU+fla
	pOZaQQLrHQSzYUokTE1NTAjzMLG5Ym3jPfPQR9RNAmjQ50ngQevRpygVF900SUjwjfsQpIU3ciM
	W8s0nYqt5QVCwMMVr6nVGl+kL1cL4NUe1jrme9jNy6cN2MW3xyP65bOq3vafDYnMUiIwLIwUAKU
	ZV9DSRklu+xCC2iv0xh9qaPr6IKuEqGw==
X-Received: from ploe7.prod.google.com ([2002:a17:903:2407:b0:2bf:a0d:a7e8])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:19cc:b0:2ba:838b:bfae
 with SMTP id d9443c01a7336-2bf20dfae24mr24843145ad.18.1780053136322; Fri, 29
 May 2026 04:12:16 -0700 (PDT)
Date: Fri, 29 May 2026 11:12:04 +0000
In-Reply-To: <20260529111208.387412-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260529111208.387412-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529111208.387412-3-praan@google.com>
Subject: [PATCH v6 2/6] PCI/ATS: Validate STU for VFs in pci_prepare_ats()
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
	Pranjal Shrivastava <praan@google.com>, Jason Gunthorpe <jgg@nvidia.com>
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
2.54.0.823.g6e5bcc1fc9-goog

