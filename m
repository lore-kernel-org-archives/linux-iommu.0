Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101063546FF
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 20:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999846; cv=none; b=FSUvxSjBWNLuaDVriCpC4C7nUtbqtTCpIOnoCOsMNymrNKunUOGj8JtK4nWzPkSHcuu5sCaFp5IZ3Ppg31B1SYEf/BoDnIUxy1pOKaNwomFXE81EL2lED+/musJ4rAoz3VrdohyD7rk9jUScE9QTKIPXYYdzY9rCdACOVaT4hc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999846; c=relaxed/simple;
	bh=C32dPM3NWhfYHk+PhOeUKOa0PbpNAjRjIDRpztej9Bs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=F8Xkj5Wu+kVtfdjefSnk/ZiDbSyW5q7GWaDFVpJi5cVAo/OaGTi9Kx6kyGdWch80fdMzRCxq05POv+XEPVOws2ouGSGBeS1mpFrwecj2PA29IeP8WLVV9ZC38g8qd5neDcGLjMAaMQ+i9cX7FQWXp4m3rVZvTP71fmZS79/kI+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HY8a94gX; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HY8a94gX"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bd04e4fe3dso96900295ad.3
        for <iommu@lists.linux.dev>; Thu, 28 May 2026 13:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779999844; x=1780604644; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8knH7UioVOHGAK4eKxBC8130k96uQrzRV3kgHSLvOkg=;
        b=HY8a94gXzXE6Ddya2H3Z2o1RcCUi+k3qxZLfEXVfUINZcLN+K+aV7Lr0u5R383qwFC
         ejbvCkAoLbTZJsKM0lOC5gDkPwNtBczM4XFfwkXB3Pxhpx1OihMS6WLwF2ZG/q6XRcMh
         W5MaOqNInyat7HZ57cbXFaUMwzTkzID+0ZshkcDgUW9k12QaVyl5XfOkIQ4SKpOwgCtq
         /LVahmuNQXPTLQK45fbYb38SwmuauEOknNPMk6PG0pRh/5EcsicnB0tLVzxNeOWjbRN2
         lRBv6YrhdIhPjpuEu5CpRI9SVc9i1w+0p2PVWrFiGNgsmhDFPWgAdQXF4WSqGQr7GSDJ
         uY7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779999844; x=1780604644;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8knH7UioVOHGAK4eKxBC8130k96uQrzRV3kgHSLvOkg=;
        b=c7FXbRWuX2Wm2jRq8fsXeZGodEoJILSGby64qR7m9KYF8FCcZos0UQiJxq7LH9+Cie
         PjlAuhizeGdPwtuW47N4ZEo9fOqQO4f8DufXVtGpAWw26eNAoUxpikpfnpakcfPa0cuH
         PAs7EkuNmCYDNYKJxJw1r6B/aOKRTizfDviITFl21Z8MJrBISTGnmmT3RPWCP3u6gsdA
         7+Le4Sj+RerCpJme+nbQW9dsDWIu4Ww4eqHBK2NdM1Ufnjljko2dk4W8drg9s/Z1ZXOK
         GugPlTLqnva1s0fv4pgfocALDqKitN6heM6re/7LVhEFNQ8pO5uVYwgbxt+o5WLSd1Di
         kZLQ==
X-Gm-Message-State: AOJu0YypoQpatI5GF7okP12UdNuhFp/L9h02nqNn47z0YRsBH4m+5+f5
	OaIt4Fk5xGxyJE3IWVYZchH3QrqJUSwsM+ABGFsPcC/za2ZGWxwsuEB1t8f4PGtnzqWVXpr7v/5
	pJiw/DLvJ8VzcxgRbwA/EMtJsmAdz7lJZpagejLNZwl5Aou5mkeMF0uCH4EXB/NBm4r6Of3tCEW
	vCxytSXLdNxxUP9Vo78m8zEMFHKbv2hA==
X-Received: from plxm11.prod.google.com ([2002:a17:902:db0b:b0:2bf:1b22:9616])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1ae3:b0:2ba:6ca2:bca
 with SMTP id d9443c01a7336-2bf1eb9710amr3927415ad.26.1779999844039; Thu, 28
 May 2026 13:24:04 -0700 (PDT)
Date: Thu, 28 May 2026 20:23:50 +0000
In-Reply-To: <20260528202353.3422206-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260528202353.3422206-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260528202353.3422206-5-praan@google.com>
Subject: [PATCH v5 4/7] iommu/arm-smmu-v3: Standardize ATS enablement failure reporting
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

The SMMUv3 driver currently has a two-phase commit in its ATS enablement
flow. During arm_smmu_attach_prepare(), it predicts whether ATS will be
enabled using arm_smmu_ats_supported() and accordingly increments
nr_ats_masters and merges ATS invalidations into the domain's invs array.

However, the actual hardware enablement via pci_enable_ats() happens
later in arm_smmu_attach_commit(). If this call to pci_enable_ats fails,
the SMMU driver's ATS state tracking remains polluted, i.e., the driver
tracks ATS as enabled on a master that is not actually using it. This
leads to an incorrect nr_ats_masters and triggers a warning in the PCI
core during detach:

 1 [  127.925080] ------------[ cut here ]------------
 2 [  127.925084] WARNING: drivers/pci/ats.c:132 at pci_disable_ats+0x94/0xa8
 3 ...
 4 [  128.068169] Call trace:
 5 [  128.070603]  pci_disable_ats+0x94/0xa8 (P)
 6 [  128.074688]  arm_smmu_attach_prepare+0x104/0x310
 7 [  128.079292]  arm_smmu_attach_dev_ste+0x128/0x1e0

The issue was exposed under heavy load when running a VFIO-based DMA
map stress test (iova_stress).

Following the addition of the arm_smmu_master_prepare_ats() [1] helper during
device probe, failable ATS configuration (STU setup) is now handled early
during probe. This ensures that any master reaching the attach phase is
guaranteed to have a valid ATS configuration.

Update arm_smmu_enable_ats() to use the WARN() macro for any
subsequent enablement failures during the commit phase. Since probe
checks now preclude software configuration errors, any failure here is
considered a kernel bug.

[1] https://lore.kernel.org/all/cover.1779392420.git.nicolinc@nvidia.com/

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index a10affb483a4..aaebd72bc48d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2956,8 +2956,14 @@ static void arm_smmu_enable_ats(struct arm_smmu_master *master)
 	 * ATC invalidation of PASID 0 causes the entire ATC to be flushed.
 	 */
 	arm_smmu_atc_inv_master(master, IOMMU_NO_PASID);
-	if (pci_enable_ats(pdev, stu))
-		dev_err(master->dev, "Failed to enable ATS (STU %zu)\n", stu);
+
+	/*
+	 * Any failure at this point is a kernel bug. pci_ats_supported()
+	 * and pci_prepare_ats() have already verified the hardware capability
+	 * and programmed the STU. Thus, pci_enable_ats() should not fail here.
+	 */
+	WARN(pci_enable_ats(pdev, stu),
+	     "Failed to enable ATS (STU %zu)\n", stu);
 }
 
 static int arm_smmu_enable_pasid(struct arm_smmu_master *master)
-- 
2.54.0.823.g6e5bcc1fc9-goog

