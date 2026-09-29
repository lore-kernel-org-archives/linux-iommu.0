Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F216940315F
	for <iommu@lists.linux.dev>; Tue, 29 Sep 2026 03:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790653546; cv=none; b=KJr7Kt5uQAE3xJTBBqpE2ubyQH4tQs4KNY4hYP/iMy9CKo9GsI1ltb8dkBS9v0VaHghL1JbQX8HHouJa1/C12JiRg5mVvcr/uZNANrepQQorApElMkG8B1GB2Co7XG18eHRqFV3JzoCnLazgtjuNH60N5qtqqx5M/K4UEx2KKt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790653546; c=relaxed/simple;
	bh=uZ6gY/m1/uNPwW0ngnSZ50aeviMaNpqsykMbkfZBHTw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dgqlTWBlUrPJvayCAhGj1TawGKemcYkLKfxerA4vm2n4hjtNx5s6OP0A6F9kjMgIbpZ8ZZRYAOS/zvXQhTEu+qxaVorHoIUilIWwrEAuGv/jtGphXhTCbNf2+aFWiUG+IMMablRS4MDNNK/Hax3REqGEhVwI+GWK99JnunApmyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a3tTKVbl; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a3tTKVbl"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc7361c62b9so2624568a12.3
        for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 20:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790653544; x=1791258344; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pamITFUcwnp5TeeHCBPmUcU036kd5Sty9zaNaR/GKjI=;
        b=a3tTKVblOxioY6EXdRig1cMNmynXScbhnu/Lfhvl3fyn1Tbi6RK2rJqZ+GpjC2L1VX
         vUltnxvCdQO9N71YqfmWyBpxq3ICeS21fYumsEBpvMobDhX6Cv2BQ76q4x/55KNgU09D
         8S8N90QgVtzl/5B+KkVCbwX1DmWPYsenJ4bMMBbkUEf3Z0Brpz0wkf1oH/E+O0NHIUqI
         ZPKtglRq00B7lxFUQK7rY3w7ra4VAH6Byo/c4vLlV6HEaIRZRnULkIt4CSUai1AT9ErS
         +gLGaWdZElHn38kB7Hc9uhY7S53l9rrAvqhqZ5x/VypIi+JG/t1wN9LjxBPN4TCf5KR2
         U9Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790653544; x=1791258344;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pamITFUcwnp5TeeHCBPmUcU036kd5Sty9zaNaR/GKjI=;
        b=ieDpeRiVkcwSXT3JTqsnZE4irqjEfbIAy89Z/eTK9gYduZhjDlLjy8cvbZFTSYPDnb
         AyBaOjH/MM8JCY1AGEj2Orb0SVki035C0Fmr6Ub9PHMr2Es8Kzs6E3ywc3r4HqfQTMD+
         Ws4kLWNYLL7oMCP0VZJyNyIHxvqTCAgNgbP5ByP1+nN6luK1zaYfwaxQ3sETelbRBJXx
         FKW3QXJVAzCMyNTMt+ukt8cfhLdx8Xp29qXeLrGTltcuenKY3NZcK8J55nLhjbgbIRej
         Np8F64kZCoU1HnVk0EB96lUKm0Jzfal9ngaWGYrvT+/l6m0EhL0pqbFlcfA8bDndpFBP
         +YLg==
X-Gm-Message-State: AFuF++laLu/fjCUMK+dKTeVrAypGb5vYU8sC0MTp5IqDQ6chjpmb9qd9
	g1wGDZGnOZddBen64UQ4yXSoZLsTsqnAY6NfWlNesRV5JEzMd3FIApAFEIuvBRddjOSxDOoJuKQ
	OVh/QSyeWaOnZBPGWUcGhWeZMIJR91TZKBOMf/NTnHkFBuEbiwoVmqdu87ZcG+RyDqSiKonyLyy
	3W6KkiayB4M9pWsz/FLCsDk/UouyWEZg==
X-Received: from pfbdl3.prod.google.com ([2002:a05:6a00:4903:b0:884:2224:5f7d])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:244f:b0:3de:6873:84d1
 with SMTP id adf61e73a8af0-3de6873856fmr3745913637.74.1790653543715; Mon, 28
 Sep 2026 20:45:43 -0700 (PDT)
Date: Tue, 29 Sep 2026 03:45:04 +0000
In-Reply-To: <20260929034510.2023173-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260929034510.2023173-1-praan@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260929034510.2023173-11-praan@google.com>
Subject: [PATCH v11 10/16] iommu/arm-smmu-v3: Factor out arm_smmu_handle_gerror()
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	Ashish Mhetre <amhetre@nvidia.com>, linux-arm-kernel@lists.infradead.org, 
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, Bjorn Helgaas <bhelgaas@google.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rafael@kernel.org, 
	Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev, 
	Pranjal Shrivastava <praan@google.com>, Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

The GERROR register's state might be lost when the SMMU is powered down
during runtime suspend, requiring the suspend sequence to handle any
pending errors before the hardware state is lost.

Refactor the gerror handling logic into a helper function. Subsequent
patches will invoke it from the runtime suspend callback after disabling
the SMMU, ensuring that any late-breaking gerrors are logged and ack'ed
before the hardware state is lost.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 7347d3ecdae8..a123810fac57 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2406,10 +2406,10 @@ static irqreturn_t arm_smmu_priq_thread(int irq, void *dev)
 
 static int arm_smmu_device_disable(struct arm_smmu_device *smmu);
 
-static irqreturn_t arm_smmu_gerror_handler(int irq, void *dev)
+/* Lockless; must ensure that there are no concurrent callers */
+static irqreturn_t arm_smmu_handle_gerror(struct arm_smmu_device *smmu)
 {
 	u32 gerror, gerrorn, active;
-	struct arm_smmu_device *smmu = dev;
 
 	gerror = readl_relaxed(smmu->base + ARM_SMMU_GERROR);
 	gerrorn = readl_relaxed(smmu->base + ARM_SMMU_GERRORN);
@@ -2452,6 +2452,13 @@ static irqreturn_t arm_smmu_gerror_handler(int irq, void *dev)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t arm_smmu_gerror_handler(int irq, void *dev)
+{
+	struct arm_smmu_device *smmu = dev;
+
+	return arm_smmu_handle_gerror(smmu);
+}
+
 static irqreturn_t arm_smmu_combined_irq_thread(int irq, void *dev)
 {
 	struct arm_smmu_device *smmu = dev;
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

