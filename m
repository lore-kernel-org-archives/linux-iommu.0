Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E5B378818
	for <iommu@lists.linux.dev>; Mon,  4 May 2026 12:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777899242; cv=none; b=iAnYTxmT0OM1GGc8DAkN/VMO0lXF+en/WrNbvvVf6YZmbG8ZQwgS7db5lytcOZXXgy+b6ZSq+edTMhBQioFeWWrLwnAG/WOwfq9ZDuc7plHs9OBJuNQ5QbXckjcQvpy3NHT48SvfgszTVhc/NNKfPGa7EbOI1mXm9VC6WJlr6cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777899242; c=relaxed/simple;
	bh=yAqL4q0N0jSQt7KcmvNEWpAu/gSojLBNjarC0tiPw8A=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=V5iy/PXMx7lwJj3cRBbfHO1pBoWrVdGwfKaioQO9X9qJB7NrA7FWuwFyE5DhXV2Iyzd0A6I1ABqquVgqrnXs13Di6l0Lh/Hitk1FKW1kjL8szLBexon5Jpl6J/Qmf/OQFr3ecXIu/TCFnu3OAZXURSzFP1YGTzXDVuzDqYatS0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WXEjkv4R; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WXEjkv4R"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35fbb57764aso5428478a91.1
        for <iommu@lists.linux.dev>; Mon, 04 May 2026 05:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777899241; x=1778504041; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kKE9/d7s5TzTov68yHVyHNVKvHYTgS1dMt0EB2Qan4M=;
        b=WXEjkv4R5H0/9G3IjSulaQPaJoYUPI+M0JjKpzVZvLOAgENovenjKxFWI1g45WJiyd
         nBAcGvDqhGObNPE28ja1nShrzncXv2DJsSBO3MrqYqHAISYQyl/PyCp2riyCCXrwCO0H
         tcElYNMTGKwNmOIdLluR+SNMW1RiN/RNDWev2t4BGm7T8mL8Df3TWoLhDesi4AB78K4r
         Y+O045YJUvQyuFz2bEk6v/9QfNllKa6iUpbbj7YHI+eYu1ujBLYa3qEkVkZIcCtWDTo3
         Ro3xXNUwJAGoFJue2F5rT8iAQ7ZclLMX7nIUZLPh36xgoxyETyopvW21ZYp8YsYxeocN
         xO+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777899241; x=1778504041;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kKE9/d7s5TzTov68yHVyHNVKvHYTgS1dMt0EB2Qan4M=;
        b=bLRXqmQv/Rf6AbWDDWQFw7G9Vab6AcbgigAbHoN6ULYfpsbtsiS7KI/vdagquvLm3A
         JMM6r0WP0+j0frvdCHH+4kw4eqcFvmg4ZN/vImukfnQm4jpY7s6ZyxiHXwvUo4HLVIS5
         wTzPbP7ZdONXnMB4LRlQ+w+vQ4pG9bIXRRfftTr2H/ZZcQhJx2MV5JcrF8h/EexYAoNQ
         2zea8abn+W8gN9OKx+LpMX9AhisQ8GdzHbKphX6FI8EStExtfu5ecKvUlssXfptJz6Lz
         Z8LBehzEWkOWawZ+rA9Ol0AFFHVE7oV6+MR9iLnBIyiU89+GXZ+mN4HjuRyz7Ia2YEsE
         seyg==
X-Gm-Message-State: AOJu0YyMTp/QLEGUU+ppvja0hPqqNe6jv4QviEDWkEcs7eHHVXhNIvS8
	bnvuQP31nlIJfWLhrc+YmNSCOJ12vTTlLfTG8p4lGcs46TJkN0OG94GnVHqz5mwe4Y1yHY2hW3L
	APChegasUxueeqjjnJozYrSlCKFdgRPmMhroegXw4JGK6b9wWA4WJBSdyuxMyQuujrVHHAPObVz
	+zRGDwF3POQUrsWR31ZfbGNA0ry3qbfw==
X-Received: from pgbee13.prod.google.com ([2002:a05:6a02:458d:b0:c73:9a1a:387d])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:4311:b0:35d:cc9a:8bc1
 with SMTP id adf61e73a8af0-3a7f041ebf8mr7655271637.27.1777899240358; Mon, 04
 May 2026 05:54:00 -0700 (PDT)
Date: Mon,  4 May 2026 12:53:42 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260504125343.2088858-1-praan@google.com>
Subject: [PATCH rc] iommu/arm-smmu-v3: Fix inconsistent ATS state tracking
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Daniel Mentz <danielmentz@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

arm_smmu_enable_ats() ignores the return value of pci_enable_ats(). If
pci_enable_ats() fails, the driver still updates its internal state
master->ats_enabled to true in arm_smmu_attach_commit().

This leads to a state mismatch between the SMMU driver and the PCI core,
the SMMU driver operates assuming ATS is enabled. Later, when detaching
the device the driver callspci_disable_ats() because it believes ATS is
enabled. This triggers a warning in the PCI core since ATS was never
actually enabled on the device:

[  127.925080] ------------[ cut here ]------------
[  127.925084] WARNING: drivers/pci/ats.c:132 at pci_disable_ats+0x94/0xa8, CPU#42: iova_stress/12240
[  127.949761] Modules linked in: vfat fat dummy bridge stp llc cdc_ncm cdc_eem cdc_ether usbnet mii xhci_pci xhci_hcd ehci_pci ehci_hcd
[  127.961760] CPU: 42 UID: 0 PID: 12240 Comm: iova_stress Not tainted 7.1.0-smp-DEV #4 PREEMPTLAZY
[  127.970619] Hardware name: <REDACTED>
[  127.977655] pstate: 61400009 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
[  127.984603] pc : pci_disable_ats+0x94/0xa8
[  127.988687] lr : arm_smmu_attach_prepare+0x104/0x310
[  127.993641] sp : ffff8000ae013ab0
[  127.996943] x29: ffff8000ae013ac0 x28: ffff0001481b0000 x27: ffff000103d17980
[  128.004066] x26: ffff0001093aad48 x25: ffff0001093ab020 x24: ffff0001118200c8
[  128.011189] x23: ffffcf76ddf1ca1c x22: ffffcf76df679020 x21: ffff000148f1df00
[  128.018311] x20: ffff8000ae013c18 x19: ffff8000ae013b28 x18: 0000000000000000
[  128.025434] x17: 0000000000000000 x16: ffff00010945a358 x15: ffff000110ffd080
[  128.032557] x14: 0000000000000200 x13: 0000000000000002 x12: 0000000000000001
[  128.039679] x11: 0000000000004040 x10: 0000000000000001 x9 : ffffcf76dd37f504
[  128.046801] x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000000000
[  128.053924] x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff0001093ab000
[  128.061046] x2 : 0000000000000000 x1 : 0000000000000001 x0 : ffff000111820000
[  128.068169] Call trace:
[  128.070603]  pci_disable_ats+0x94/0xa8 (P)
[  128.074688]  arm_smmu_attach_prepare+0x104/0x310
[  128.079292]  arm_smmu_attach_dev_ste+0x128/0x1e0
[  128.083899]  arm_smmu_attach_dev_blocked+0x50/0x88
[  128.088677]  __iommu_attach_device+0x30/0x138
[  128.093026]  __iommu_group_set_domain_internal+0xdc/0x228
[  128.098412]  __iommu_take_dma_ownership+0x118/0x150
[  128.103278]  iommu_group_claim_dma_owner+0x48/0x80
[  128.108056]  vfio_container_attach_group+0xc8/0x1b0
[  128.112927]  vfio_group_fops_unl_ioctl+0x578/0x968
[  128.117706]  __arm64_sys_ioctl+0x90/0xe8
[  128.121622]  invoke_syscall+0x50/0x108
[  128.125366]  el0_svc_common+0x94/0xe8
[  128.129016]  do_el0_svc+0x24/0x38
[  128.132319]  el0_svc+0x44/0xf8
[  128.135364]  el0t_64_sync_handler+0x68/0xe0
[  128.139534]  el0t_64_sync+0x1b0/0x1b8
[  128.143185] ---[ end trace 0000000000000000 ]---

The issue was exposed under heavy load when running a VFIO-based DMA map
stress test: iova_stress [1]

Fix this by propagating the error from arm_smmu_enable_ats() and updating
state->ats_enabled to false on failure. This ensures that
master->ats_enabled correctly reflects the actual state of the device.

Signed-off-by: Pranjal Shrivastava <praan@google.com>

[1] https://github.com/soleen/iova_stress
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index e8d7dbe495f0..50ede399089d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3051,8 +3051,9 @@ static bool arm_smmu_ats_supported(struct arm_smmu_master *master)
 	return dev_is_pci(dev) && pci_ats_supported(to_pci_dev(dev));
 }
 
-static void arm_smmu_enable_ats(struct arm_smmu_master *master)
+static int arm_smmu_enable_ats(struct arm_smmu_master *master)
 {
+	int ret = 0;
 	size_t stu;
 	struct pci_dev *pdev;
 	struct arm_smmu_device *smmu = master->smmu;
@@ -3065,8 +3066,11 @@ static void arm_smmu_enable_ats(struct arm_smmu_master *master)
 	 * ATC invalidation of PASID 0 causes the entire ATC to be flushed.
 	 */
 	arm_smmu_atc_inv_master(master, IOMMU_NO_PASID);
-	if (pci_enable_ats(pdev, stu))
+	ret = pci_enable_ats(pdev, stu);
+	if (ret)
 		dev_err(master->dev, "Failed to enable ATS (STU %zu)\n", stu);
+
+	return ret;
 }
 
 static int arm_smmu_enable_pasid(struct arm_smmu_master *master)
@@ -3635,7 +3639,8 @@ void arm_smmu_attach_commit(struct arm_smmu_attach_state *state)
 	arm_smmu_attach_commit_vmaster(state);
 
 	if (state->ats_enabled && !master->ats_enabled) {
-		arm_smmu_enable_ats(master);
+		if (arm_smmu_enable_ats(master))
+			state->ats_enabled = false;
 	} else if (state->ats_enabled && master->ats_enabled) {
 		/*
 		 * The translation has changed, flush the ATC. At this point the
-- 
2.54.0.545.g6539524ca2-goog

