Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF79A3D34AA
	for <iommu@lists.linux.dev>; Fri, 29 May 2026 11:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780053145; cv=none; b=BHp3tthzKkCJYzzv/WAb1CAVbLa8MvGzqPMMSfvK8O43H9Jv/LElGwDQ27tptF49hcd7Okw5TJUscOwr+E76YsMdqDtEm4yPf+9TnDAXEHsGdkIwft+vX7jqsGudcXaWXnwkftLjr25WhQus0V0PgfvyDaefkTLGeIxFKx5wgzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780053145; c=relaxed/simple;
	bh=C32dPM3NWhfYHk+PhOeUKOa0PbpNAjRjIDRpztej9Bs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JXZbiVxEvno3ocdyuE81zVikZdhfUXUxcQoCcxGpUK4KfMzUmS8QTbRwjF5zwGOCdeZMCIfTRVP1DZSCAZ8nD4XyTguFdurBmH/ihnLjJmdJlFpU/Xi1yH99A9WFddG/QyVSpR8veYwJrKNSSWqG/kg2B9HU234GLdTQrqposbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FERVikUw; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FERVikUw"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82f7bec24fdso6571477b3a.2
        for <iommu@lists.linux.dev>; Fri, 29 May 2026 04:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780053142; x=1780657942; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8knH7UioVOHGAK4eKxBC8130k96uQrzRV3kgHSLvOkg=;
        b=FERVikUwLMEuQImbYq2tmHF5KWxo++A/Gu6dV57OjfOHI00krAxNciWhv9bmefEe5A
         5rf2EfQwTd3rq4BzLDck9ndbOwvwLGY0uT2JThu5tT9o5+DkSb197uQe4oI67XS/ZTf4
         K0UQAakju2OhGb+Xq8ezmRzu+A94tzsySeLE2PLvItpkawro/P+1Vmze7WHhGqRZT+jI
         CWK04hEU90cK6QzeI7o4HFwberA3UsElOTWLeaEn7uFfCB8gZYL7BueQ6nhT31nCZA/P
         GqSGt0AarTHbTmdczsOvMblfRmlrByE1c2+UXaJoVoabrqvvC9Me5mwiMvI30OWLgxjC
         s+Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780053142; x=1780657942;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8knH7UioVOHGAK4eKxBC8130k96uQrzRV3kgHSLvOkg=;
        b=dHpg3a9waorah3sYqGTv7gOaD9bDVIEyfo5umr+eX3KLkyZeoYsuN+Xl0qpyxWiKXh
         uOp3LYZ/eSdxlR8iyrcgv9cBAPjVBl+sL4vDf5epv4ZVbSPSnMXf/oZeXmgUxo+Zhnjq
         HfOLYbskTZneQAaX6wW5Ef37i6jewVf8VOUSvAZYIuyx+LzqPnuOjMGa7EKDO2tsit9H
         wXIjgqUEZIM+pFkQdtdZRq3EGteUJwZAu4xb5OB4w3Rlr0jKZf36dvIGDihXQWcL98RM
         8hQRnm5xLTV6l2fnwekJtlitIbNQ9bbENlU1+fzhpoMwDcGc++UtKLoOdR6b7QsKoBSY
         rDlw==
X-Gm-Message-State: AOJu0YxYsDjj29SymCCWsTxoAKeAYQ0vibZWzk46Og3nZZne/3VK0uuP
	1SdTFNoJlNOsRW7HhTNwwp/Bt2hp94VKAF93c6TaihMZcCiF4uVHLUZQRuBdWCeQOToQ3Xa9RYT
	KN34v+e3J9m9zWc86HFJYwubRDMmhNptZqEaflQTibFHo6w//7Yr3XE4LiVPfpgV4sVfN9A72st
	unWZCwiY2RfzysXM9DmPDZtVW7YihbcA==
X-Received: from pfbll21.prod.google.com ([2002:a05:6a00:7295:b0:835:429c:76df])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2185:b0:834:df57:9d36
 with SMTP id d2e1a72fcca58-84212ba2fb4mr2617218b3a.25.1780053141470; Fri, 29
 May 2026 04:12:21 -0700 (PDT)
Date: Fri, 29 May 2026 11:12:06 +0000
In-Reply-To: <20260529111208.387412-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260529111208.387412-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529111208.387412-5-praan@google.com>
Subject: [PATCH v6 4/6] iommu/arm-smmu-v3: Standardize ATS enablement failure reporting
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

