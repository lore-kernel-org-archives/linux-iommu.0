Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF92246AF0A
	for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 11:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784116774; cv=none; b=m/M1uQZXK41+3dvvBNsD8uuHOlETFBRJ3E9glCndImPCkFokI1k4v0DwcIijRPh3/H6DbLw1bv7cSlS+JMnh06gz3axm+ZV/CC9lkK2YCyl9Mf1DXtuH/JHgFKQ6sUwWpfqZjUAMr5LdUavzYR312fyQi7Nhxcn+nAkfO6RKmT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784116774; c=relaxed/simple;
	bh=avKKUR3ivX1o4eXWAvFx7D4B/bGHctrz504BKkAdasI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Gn+LDZQ/MyWboYrCKysF4/nKzsnyOm36bhuiHQi5mnGDk690jwVuPvg7EiCNx49ZgLfGk7kB1HTTzlvvYpfhnx81uesOuv+enrw3KhJPPNeTlwWEj0O9JXFTASAyDJdnOLk+OP9QsiCdg2nLP5y8dhgmZcK2ykplDBXYPr1/J6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j8XpNDK0; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j8XpNDK0"
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-69c20d1d150so1914753a12.0
        for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 04:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784116768; x=1784721568; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U+wIzMWf2cSB6EX/Jc8f2fGh3ASjjz6WosFQJCh8Jwc=;
        b=j8XpNDK0a5JvbAizaQA8fwbytpispmfR8bKA0ruXbMzr3HZ6yl4S/F4xkJ1417jq1V
         FoJidINMPMDR/eerdoyouregAKJCEpI8gAAhbt3IVYf4xbPtJ44nS0ROEpbmN0CipDUj
         gyQf3D/3lCTmsiEjWhYEMZ6IwK6o+l3411DnHj0ufbaApPBc6GYy5G+ZExDC1fndsbcs
         ZDMvNY29Sy7LEYW+IwZo0/OePoCYk52e6mzAAexPmyys/695fPdKGV25oFfpH0v+6B39
         Jmm72Lez0z+DDAWMIkmR6QKRuBmjKokgtvhK639pxzZvu+Tfjj4SElfovfTmuHG0SXPe
         GSiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784116768; x=1784721568;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U+wIzMWf2cSB6EX/Jc8f2fGh3ASjjz6WosFQJCh8Jwc=;
        b=fz11/Yp6Si5OzQo8fKcRqu1CGs5KYZw7xYvr7VNy9tEx/Ibt/BPfmtmTo1k6Ruevhc
         xzBUwoLpmjIhwCRu60u4GeRM0eD/cuHUFvRQ7aedv2JrW7jv4BiwTo/TKF/jNu2zA7ml
         mDQ/4zT79qiv/hKNkBEN65aZO+3tKgjD+5DEoLmcQ2OcWvCTNNDdbVG9EJV+CbSZ1Dn3
         ZL1CPdMz4rA5or5Hz0VstcbCppgzsVjf6czQYUFBU8ZuTzGVjpUGfcTJC0m4y4UHtj6z
         cPzq4/U+C8Me+ry0VwDPd/g9MuvU8PqRmpL+Pn8RjRhm9pl/dIsJlfjtcmYILKatMsfq
         0IJQ==
X-Forwarded-Encrypted: i=1; AHgh+RqDAiHClOZ53j6LwzesiVoKjIsVD/zW17TiIZoT2S7XMstjUSopLwsKl1yBymDSmbAnmjJSiQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzCrIeptvbVEj4r2YWbXbV5tcDGVimffzhLkjth75w+5mPkAOzC
	JHcTYimH8rWm3MM7RYWpgf7c4irCdybajOsJoZO5Un1ZOZYqJy+is1tAd63IXJl4GV00r1q46y6
	cOiabr9N3PgZJ2w==
X-Received: from edou7.prod.google.com ([2002:aa7:d0c7:0:b0:69c:458d:1598])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:1d4b:b0:69c:7754:f8b7 with SMTP id 4fb4d7f45d1cf-69c7754f940mr8902542a12.38.1784116767878;
 Wed, 15 Jul 2026 04:59:27 -0700 (PDT)
Date: Wed, 15 Jul 2026 11:58:53 +0000
In-Reply-To: <20260715115906.2664882-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260715115906.2664882-1-smostafa@google.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <20260715115906.2664882-13-smostafa@google.com>
Subject: [PATCH v7 12/24] iommu/arm-smmu-v3-kvm: Probe SMMU HW
From: Mostafa Saleh <smostafa@google.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kvmarm@lists.linux.dev, iommu@lists.linux.dev
Cc: catalin.marinas@arm.com, will@kernel.org, maz@kernel.org, 
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, joro@8bytes.org, jgg@ziepe.ca, mark.rutland@arm.com, 
	qperret@google.com, tabba@google.com, vdonnefort@google.com, 
	sebastianene@google.com, keirf@google.com, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

Probe SMMU features from the IDR register space, most of
the logic is common with the kernel.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 .../iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c  | 54 +++++++++++++++++++
 .../iommu/arm/arm-smmu-v3/pkvm/arm_smmu_v3.h  |  6 +++
 2 files changed, 60 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
index fee5db6c9c20..be5922d80184 100644
--- a/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
@@ -10,6 +10,7 @@
 #include <nvhe/mem_protect.h>
 
 #include "arm_smmu_v3.h"
+#include "../arm-smmu-v3.h"
 
 size_t __ro_after_init kvm_hyp_arm_smmu_v3_count;
 struct hyp_arm_smmu_v3_device *kvm_hyp_arm_smmu_v3_smmus;
@@ -26,6 +27,53 @@ static void smmu_deinit_device(struct hyp_arm_smmu_v3_device *smmu)
 	smmu->base = NULL;
 }
 
+/*
+ * Mini-probe and validation for the hypervisor.
+ */
+static int smmu_probe(struct hyp_arm_smmu_v3_device *smmu)
+{
+	u32 reg;
+
+	/* Similar to the kernel, rely on firmware override. */
+	if (!(smmu->features & ARM_SMMU_FEAT_COHERENCY))
+		return -EINVAL;
+
+	/* IDR0 */
+	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR0);
+
+	smmu->features |= smmu_idr0_features(reg);
+	if (!(smmu->features & (ARM_SMMU_FEAT_TT_LE | ARM_SMMU_FEAT_TT_BE)))
+		return -ENXIO;
+
+	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR1);
+	if (reg & (IDR1_TABLES_PRESET | IDR1_QUEUES_PRESET | IDR1_REL))
+		return -EINVAL;
+
+	smmu->sid_bits = FIELD_GET(IDR1_SIDSIZE, reg);
+	/* Follows the kernel logic */
+	if (smmu->sid_bits <= STRTAB_SPLIT)
+		smmu->features &= ~ARM_SMMU_FEAT_2_LVL_STRTAB;
+
+	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR3);
+	smmu->features |= smmu_idr3_features(reg);
+
+	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR5);
+	smmu->pgsize_bitmap = smmu_idr5_to_pgsize(reg);
+
+	smmu->oas = smmu_idr5_to_oas(reg);
+	if (smmu->oas == 52)
+		smmu->pgsize_bitmap |= 1ULL << 42;
+	else if (!smmu->oas)
+		smmu->oas = 48;
+
+	reg = readl_relaxed(smmu->base + ARM_SMMU_IIDR);
+	smmu->features = smmu_iidr_features(reg, smmu->features);
+	if (!(smmu->features & ARM_SMMU_FEAT_NESTING))
+		return -ENXIO;
+
+	return 0;
+}
+
 static int smmu_init_device(struct hyp_arm_smmu_v3_device *smmu)
 {
 	unsigned long haddr;
@@ -39,8 +87,14 @@ static int smmu_init_device(struct hyp_arm_smmu_v3_device *smmu)
 		return ret;
 
 	smmu->base = (void __iomem *)haddr;
+	ret = smmu_probe(smmu);
+	if (ret)
+		goto out_ret;
 
 	return 0;
+out_ret:
+	smmu_deinit_device(smmu);
+	return ret;
 }
 
 /* Called while is the host is still trusted. */
diff --git a/drivers/iommu/arm/arm-smmu-v3/pkvm/arm_smmu_v3.h b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm_smmu_v3.h
index 744ee2b7f0b4..82b84673e85b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/pkvm/arm_smmu_v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm_smmu_v3.h
@@ -12,12 +12,18 @@
  *
  * Other members are filled and used at runtime by the SMMU driver.
  * @base		Virtual address of SMMU registers
+ * @oas			PA size
+ * @pgsize_bitmap	Supported page sizes
+ * @sid_bits		Max number of SID bits supported
  */
 struct hyp_arm_smmu_v3_device {
 	phys_addr_t		mmio_addr;
 	size_t			mmio_size;
 	void __iomem		*base;
 	u32			features;
+	unsigned long		oas;
+	unsigned long		pgsize_bitmap;
+	unsigned int		sid_bits;
 };
 
 extern size_t kvm_nvhe_sym(kvm_hyp_arm_smmu_v3_count);
-- 
2.55.0.141.g00534a21ce-goog

