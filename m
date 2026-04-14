Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D222E62B7
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 19:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776196045; cv=none; b=Y1BbxRy46/6wW3VC5Y1sEtxPnNE/6b5iyrEJSym4DPPC3PmGbjUvNXGh4m3Ol6Hs74kToLivhrEw0c6xCsW89lPM2NLFObw9fj9BpozPgYn+Q8OElEAkMXh7921FRkMB9LZpFcwsW7+8Fw2FtAxilKqb4Ghh65V7YVaajqs+I3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776196045; c=relaxed/simple;
	bh=H6W73gxDUwKuytR1KImmqQXF6LLTQXhiKylm/Gk7e0U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W2G1M7zR7AXbnRr7Nu0bqHCeZEX8NfpODWcfeJi9AnpzEac8VJwcYB1NNagONl/lpveXD3piOTtVjDAVyzerZFEhdLDqtcNMXFx6F/f68y1h5NFuNscle1DDIyOabz2UPlhiKfxYhjsr6Y9ZH8cCKRUWPU6EBUKLAFeQKwS04QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pb7rqjW/; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pb7rqjW/"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35fbc53b64bso2413895a91.1
        for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 12:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776196043; x=1776800843; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JJIH33TDEK6XAus04znE10E3teZOxc5Rexz/vMvK6rc=;
        b=pb7rqjW/mS7z0rWH20/UmnzONiLDp09HDAgL4quOALg51u5JxnTcdzT96pmyIyXJG+
         RirnZCQatQkh5AZIAfEtw3UTPXbSnn8C4YgasjOhlmxByG0IjMAdbNEvyh9+B1z/u3dJ
         rQuqvYHAUYFvNsdlGIXrE4sQhHU/RO7XE+53Q0vsYQOAZbPG7GpLIFJu460GSSh5KblU
         qPLE3QZUTgE+HtGBIA4+qVKnnAzBsIbjlWhHe9FNU0Xg3s0fwaSUeMaU77ZNE+9e0J3B
         SXNOtaHkm60xryad8UaCgxQfI+cJr01wUM/L/8u1U7hS8tpyDc5QtLgIUlKevvCzyPuV
         RJIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776196043; x=1776800843;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JJIH33TDEK6XAus04znE10E3teZOxc5Rexz/vMvK6rc=;
        b=cxljytaGXaRHGRGzwMKErrCg7wnp4WCKOQxonDKY9l1KF4iDOKawSknU+6Ltx9mOOb
         X+HpsXA5hRH5dKRVh6b86HyImRsYmZ9s1CrE96g7TMq7ceT8KzUF01OxFZkEYTq52Toh
         Tbk0S66KnZ41F76oBfypTvQiBX4qEU+fCR4fkK4wfqY/GDRFEOlH4A5IcSM7Vw/MCCx4
         0WgvE0yjP1QdOteuSvtri/e/mnnACt7IMsPfrJ8wYLMESnjoJQ7HisMxRkoRWmPpOiHv
         5pMNDNON+ZFXeEBO+FiatPKIdxCGZVfBY5StoC6DYl8rjNGn9j7RMDvLjOWkAL1s3INd
         7wNg==
X-Gm-Message-State: AOJu0YzOcrpFqlZukhc8tqzEEUvUkQ0bL64C9VNFs5GO2qL0vLikDV63
	mn2u2PTICwxOcTwv7kWSwQFoTr1/jQrk2nZyHI6txlqnfW5rTk/TtzIa8d1GWF/Qc1ork7HhA+x
	X276GNdZPrID2+iOMfppg6jJw0HloxcnOHWpydOupp/P0wal2cxc1kL08iq64bnjichuypuUuP6
	ht/cXOiFv/m69J0dpS19UZM2A02ZlfeA==
X-Received: from pjbgc10.prod.google.com ([2002:a17:90b:310a:b0:35e:3e2a:3c1b])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:289:b0:35e:58d3:3286
 with SMTP id 98e67ed59e1d1-35e58d3350cmr6561354a91.24.1776196043225; Tue, 14
 Apr 2026 12:47:23 -0700 (PDT)
Date: Tue, 14 Apr 2026 19:46:57 +0000
In-Reply-To: <20260414194702.1229094-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260414194702.1229094-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.rc0.605.g598a273b03-goog
Message-ID: <20260414194702.1229094-6-praan@google.com>
Subject: [PATCH v6 05/10] iommu/arm-smmu-v3: Cache and restore MSI config
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	Ashish Mhetre <amhetre@nvidia.com>, Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

The SMMU's MSI configuration registers (*_IRQ_CFGn) containing target
address, data and memory attributes lose their state when the SMMU is
powered down. We'll need to cache and restore their contents to ensure
that MSIs work after the system resumes.

To address this, cache the original `msi_msg` within the `msi_desc`
when the configuration is first written by `arm_smmu_write_msi_msg`.
This primarily includes the target address and data since the memory
attributes are fixed.

Introduce a new helper `arm_smmu_resume_msis` which will later be called
during the driver's resume callback. The helper would retrieve the
cached MSI message for each relevant interrupt (evtq, gerr, priq) via
get_cached_msi_msg & re-config the registers via arm_smmu_write_msi_msg.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 37 +++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index e865a8aa2210..4fa452465b4d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4677,6 +4677,9 @@ static void arm_smmu_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
 	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
 	phys_addr_t *cfg = arm_smmu_msi_cfg[desc->msi_index];
 
+	/* Cache the msi_msg for resume */
+	desc->msg = *msg;
+
 	doorbell = (((u64)msg->address_hi) << 32) | msg->address_lo;
 	doorbell &= MSI_CFG0_ADDR_MASK;
 
@@ -4685,6 +4688,40 @@ static void arm_smmu_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
 	writel_relaxed(ARM_SMMU_MEMATTR_DEVICE_nGnRE, smmu->base + cfg[2]);
 }
 
+static void arm_smmu_resume_msi(struct arm_smmu_device *smmu,
+				unsigned int irq, const char *name)
+{
+	struct msi_desc *desc;
+	struct msi_msg msg;
+
+	if (!irq)
+		return;
+
+	desc = irq_get_msi_desc(irq);
+	if (!desc) {
+		dev_err(smmu->dev, "Failed to resume msi: %s", name);
+		return;
+	}
+
+	get_cached_msi_msg(irq, &msg);
+	arm_smmu_write_msi_msg(desc, &msg);
+}
+
+static void arm_smmu_resume_msis(struct arm_smmu_device *smmu)
+{
+	if (!(smmu->features & ARM_SMMU_FEAT_MSI))
+		return;
+
+	if (!dev_get_msi_domain(smmu->dev))
+		return;
+
+	arm_smmu_resume_msi(smmu, smmu->gerr_irq, "gerror");
+	arm_smmu_resume_msi(smmu, smmu->evtq.q.irq, "evtq");
+
+	if (smmu->features & ARM_SMMU_FEAT_PRI)
+		arm_smmu_resume_msi(smmu, smmu->priq.q.irq, "priq");
+}
+
 static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
 {
 	int ret, nvec = ARM_SMMU_MAX_MSIS;
-- 
2.54.0.rc0.605.g598a273b03-goog

