Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B129413796
	for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 20:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792094980; cv=none; b=Aw/XPojnoZjZegXw7Lu0qUXblKUefU0m3euNFW4hKoz+YaHfN2IX2TvlDdDUceLdCGrsskE2tpMeJTiS3akg+ucSbNsCt4qByoSpvfJgE9JXMi0C5OhaaEM3SxMbm+RdRWbALNlS9ptXUF6/0vegNj4G7SpiBZKNfTG3mi0D9D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792094980; c=relaxed/simple;
	bh=esGTvS6DZ/ClMQbU119hVRZc93nVCLe8LifqfkQfW5A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d3bXH6fqH/T3G7Vq/E0RayIlEZKqufm0ZeEGoet1kEXHgBYIJGeA2wVS3pTFiXJtXHWg3QqkNhIsxsWYRTa26+bszZgiwJVpctwQaRvxyB+SF/cFnCb9mrqco3rMO0UmP43QzEMUfNDXl29muDuGz4wrlhSXbFvOilrf+AGpfbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EqqR6c/z; arc=none smtp.client-ip=209.85.218.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EqqR6c/z"
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c4069f03949so10282166b.0
        for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 13:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792094975; x=1792699775; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ACz9N/uLV4ni8vIh9HTqb065WbDM683/OQmKXL1iQNQ=;
        b=EqqR6c/zKbHxVW5ct87ucV2HBKkHwkudBXvjIRKF+wf47+YdEh5lTeq92J9HoAmgvk
         xR5e1eh1ww77d2r0ej7hC7GuQmjMVxlvNbPCj9X6rLMjfNHt5JbwDvAJJPBJGYIcAokT
         Oc4Q8dNqqG43IoO3T3jAZMhEbuog9kwcRTOovlV53QtrgzDbuLypeqW/2a2O4s6KWzHl
         +wRBseGJ2K2WdApL5MIACNxJBvBNSDwBjT2XQXVFxDoo/ILtXhZXK0dbqyvVfYFqHao3
         JPDXDchEHqAH5+jZyUZi5+juY0hnrF0nXRiwuLWqd4aMVEiK+DZ6pGR27cAdCjpbk7az
         j/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792094975; x=1792699775;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ACz9N/uLV4ni8vIh9HTqb065WbDM683/OQmKXL1iQNQ=;
        b=U1eXyb3JlIqospEvQ1fhVz1W8yRHLzMMIqmmoPP9gDKSrQ5tO1VcH4yt7YoZuqZdpP
         PMDPWYBk9kG7wIg/8ZiPAh/vGrpO6RU7P0FVr5s2ZA/GmaguChZZqdRTx/jpAmVndIw0
         ym3WKDNuVQb48/C91vSzomEUoO/WCay6r6XDrylLP1zuxz9FmPMGHk3qfH6e/pJI3dla
         s+I5wkmhIeS8gVRBr8G4exgXxSQ1lek+cQzVtaQ9QtNUG47INZFb8KvswRNr5s8qur2b
         h2zQBQVhcGCnDaBLHEq4cT1+z5GwyyrXUSRnlKI+qXmht9qa+3W3egrmJCsXOP9JzHT/
         vQvg==
X-Forwarded-Encrypted: i=1; AKwUvBxeVcZT0LCgcorot8Tjx+i4kY4OWbDTG+wi7J16FnxwBZbOO88oO2Tm8IHtvcSDVkU3BBhrHg==@lists.linux.dev
X-Gm-Message-State: AFq9FYJxaSlqS72uynn/UiFp86GHwgYE8IARYOPfjsLhxaJL6rx+sllK
	q2hSnr0HzeQK7LX8OKJPahh/d1akUZfr/zCyswsz2eZeQMwSEOtF5uFNVK3HFLoDGe5wyx8yk0f
	bHyWSXTff1ww0Vw==
X-Received: from ejsh10.prod.google.com ([2002:a17:906:584a:b0:c3f:cc01:4b72])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:2d11:b0:c29:519b:3aee with SMTP id a640c23a62f3a-c402349d091mr109107066b.33.1792094975445;
 Thu, 15 Oct 2026 13:09:35 -0700 (PDT)
Date: Thu, 15 Oct 2026 20:08:51 +0000
In-Reply-To: <20261015200903.2735565-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20261015200903.2735565-1-smostafa@google.com>
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
Message-ID: <20261015200903.2735565-21-smostafa@google.com>
Subject: [PATCH v9 20/25] iommu/arm-smmu-v3-kvm: Emulate GBPA
From: Mostafa Saleh <smostafa@google.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kvmarm@lists.linux.dev, iommu@lists.linux.dev
Cc: catalin.marinas@arm.com, will@kernel.org, maz@kernel.org, 
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, joro@8bytes.org, jgg@ziepe.ca, mark.rutland@arm.com, 
	qperret@google.com, tabba@google.com, vdonnefort@google.com, 
	nicolinc@nvidia.com, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

The last bit of emulation is GBPA. it must be always set to ABORT,
as when the SMMU is disabled it's not allowed for the host to bypass
the SMMU.

That's is done by setting the GBPA to ABORT at init time, and host
writes are always ignored and host reads always return ABORT.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 .../arm/arm-smmu-v3/pkvm/arm-smmu-v3-hyp.c    | 32 +++++++++++++++++--
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3-hyp.c b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3-hyp.c
index 1972df1d2a8d..943ffef0bb4a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3-hyp.c
+++ b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3-hyp.c
@@ -217,6 +217,22 @@ static int smmu_send_cmd(struct hyp_arm_smmu_v3_device *smmu,
 	return smmu_sync_cmd(smmu);
 }
 
+static int smmu_abort_gbpa(struct hyp_arm_smmu_v3_device *smmu)
+{
+	int ret;
+	u32 reg;
+
+	ret = smmu_wait(false,
+			(readl_relaxed(smmu->base + ARM_SMMU_GBPA) & GBPA_UPDATE) == 0);
+	if (ret)
+		return ret;
+
+	reg = readl_relaxed(smmu->base + ARM_SMMU_GBPA);
+	writel_relaxed(GBPA_UPDATE | GBPA_ABORT | reg, smmu->base + ARM_SMMU_GBPA);
+	return smmu_wait(false,
+			 (readl_relaxed(smmu->base + ARM_SMMU_GBPA) & GBPA_UPDATE) == 0);
+}
+
 /* Put the device in a state that can be probed by the host driver. */
 static void smmu_deinit_device(struct hyp_arm_smmu_v3_device *smmu)
 {
@@ -456,6 +472,10 @@ static int smmu_init_device(struct hyp_arm_smmu_v3_device *smmu)
 	if (ret)
 		goto out_deinit;
 
+	ret = smmu_abort_gbpa(smmu);
+	if (ret)
+		goto out_deinit;
+
 	return 0;
 
 out_deinit:
@@ -781,10 +801,16 @@ static bool smmu_dabt_device(struct hyp_arm_smmu_v3_device *smmu,
 			val = smmu->host_ste_cfg;
 			goto out_update_regs;
 		}
-	/* Passthrough the register access for bisectability, handled later */
 	case ARM_SMMU_GBPA:
-		mask = read_write;
-		break;
+		if (len != sizeof(u32))
+			break;
+
+		/* Ignore write, always read to abort. */
+		if (!is_write) {
+			val = GBPA_ABORT;
+			goto out_update_regs;
+		}
+		goto out_ret;
 	case ARM_SMMU_CR0:
 		if (len != sizeof(u32))
 			break;
-- 
2.56.0.176.g3575e65682-goog

