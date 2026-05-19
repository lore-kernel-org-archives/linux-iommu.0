Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA32340402
	for <iommu@lists.linux.dev>; Tue, 19 May 2026 13:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779198820; cv=none; b=NL55BG9yyG/FcGS/3cvTho8l704Sx5lsXMBNGyCv2bPeihWzp5CazQb68D0ekEhI4EnvwxIj3numdG/KoQIGkz+qLPefemZEXyutZb+H4oXVZbneqafddkJ46WZZg8o3lzsm95QMVOvBfDgLXhjt4/wINMqCGP2CyRyDKzHqNE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779198820; c=relaxed/simple;
	bh=CwFF+RiM5QuQxYWpLDlViY1A4N1Wc9d+1x/on0eEkbk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NGRwIuvpaHTpkQFkk6t3ofmC9VIflVVs13s9sj8ee9EpkEdJkMCFWJvDyFsNl4Ykbze1jASxbMsBZVpdEejgvPLVjIbxuW5zEtsCRkn4yCroBgQrMKm7e5tKcy7lVdgGeHdZXeyhTH7zewZM1H69mKzdbnThqMY0KPPsXCL6aAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XJAuWlCx; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XJAuWlCx"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82f6b984b3aso1890201b3a.3
        for <iommu@lists.linux.dev>; Tue, 19 May 2026 06:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779198818; x=1779803618; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KWBOwL+HKQFniymTwRy/QPXq3vFl2Ebh684Oe2Ka/N8=;
        b=XJAuWlCxPnisXul+sIUogf2pIJr7YeOa9ZBigNjakxnAOUTc8rSg2mobXKOXSvbJxP
         ozBeb2CJgu9J76VWXXu9ic0MHTBp5dAtvOovVPw2tkk185B5gHPjpmkX+qpexnb0bkrw
         8s2VDKxnvJJNxV04DJWsnwBnV7xVuV74QCdZHaKkuNTb9zQ1qkuLuLuRRwQxOVVKJZeh
         TU3mzQ6KfoIkAxR+MECqbSSV5ldR4arNyvCsPOoqUphMkT5QGUOMCIhxSSdKiFW3mB/I
         +eEQmDEAWnp5bl7tbPt1y/dlTjh5x8v8CcTwXD0swrou3hgfIE13Q3vgMEwQsxOQha65
         7pVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779198818; x=1779803618;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KWBOwL+HKQFniymTwRy/QPXq3vFl2Ebh684Oe2Ka/N8=;
        b=E0M/sa6RHf1TlsTkVHQiL20Qzx6fZfPIxfH8jnuaQPb0CcB45S/jTytF2PKy9CR3s6
         3Pplku3kQ99jfs5SVAh01Mi1s4rza0+ak+k5nh51Gn2qte3nBb1WsQ8YUOZqb4OaC5yD
         F/qlgqZZ9ArNXDLJJKpRRfXEakK1kQ5cenLDOGmwPnr2YLtKXT/H555R/vtNcgdVBwj8
         AATYQs6rGp7e8h6EwwJuJss5fe5DTiCnBEnHyuUd/nHyZXoqAFwtyusm8RUQt7Q8uOWH
         RlxZL37efRhxAssNCfgzHzM0SDceGr4aTdWwYfWTJQ87dsK3n+zxJsrTX26Y2oess4j/
         T6FQ==
X-Gm-Message-State: AOJu0YxOf6FQRqLMawbIRJ6f67NZj6qk/QkQyLzoO5mmkA4s9lrBOGng
	DwbwSp1C7CEwArZTwqoGJ4UlM6E+TuJn5ckPyge1efHujFOUvqaY2TmV0uZxP9KX8C+GYgyfdr2
	wZM+5MW0a+M12muM1oQE4aV2KKIg/CbFkIYoPkGKLAQCQGPqZ4EChKuvZKUaqOkJPaAIv+mumz5
	8ouTN7ejiTKGeTW6YUxx20LvYJ9dD3OQ==
X-Received: from pfes8.prod.google.com ([2002:aa7:8d48:0:b0:82f:a396:2232])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:aa7:88d1:0:b0:835:6bdf:c87f
 with SMTP id d2e1a72fcca58-83f33c3353bmr18880796b3a.9.1779198817951; Tue, 19
 May 2026 06:53:37 -0700 (PDT)
Date: Tue, 19 May 2026 13:53:21 +0000
In-Reply-To: <20260519135323.1558777-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260519135323.1558777-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260519135323.1558777-3-praan@google.com>
Subject: [PATCH v3 2/3] PCI/ATS: Validate STU for VFs in pci_prepare_ats()
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, linux-pci@vger.kernel.org
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, Nicolin Chen <nicolinc@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Daniel Mentz <danielmentz@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, 
	Pranjal Shrivastava <praan@google.com>
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

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/pci/ats.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index a5fa7745bce8..54319854bfd8 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -73,8 +73,13 @@ int pci_prepare_ats(struct pci_dev *dev, int ps)
 	if (ps < PCI_ATS_MIN_STU)
 		return -EINVAL;
 
-	if (dev->is_virtfn)
+	if (dev->is_virtfn) {
+		struct pci_dev *pdev = pci_physfn(dev);
+
+		if (pdev->ats_stu != ps)
+			return -EINVAL;
 		return 0;
+	}
 
 	dev->ats_stu = ps;
 	ctrl = PCI_ATS_CTRL_STU(dev->ats_stu - PCI_ATS_MIN_STU);
-- 
2.54.0.563.g4f69b47b94-goog

