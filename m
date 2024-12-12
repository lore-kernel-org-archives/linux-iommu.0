Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DF3238E3E
	for <iommu@lists.linux.dev>; Thu, 12 Dec 2024 18:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026751; cv=none; b=AXoFgKUyL8ZBAjKH1RhipyL6akTePSxfEjqph6ZjaneJECPNHrtY17irqhsbaEAOH14j498Z06ShJjTWi0jrFpB0iSUimFFH6o4KRSWo1FAKQgPi/LkHif3MvBa8FPyyIBS+OEtigdum6zIvnGtrqIYW7+UCVbVvuCIpr7jJNas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026751; c=relaxed/simple;
	bh=ZTCW3MPLRkAgIQ6KHNuQcNDS5MIsVNoOiDzEFUuD1n4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f3YZqEcYJgV1JFiFFgbl30Anh1eoDjHgtqPGkxxvPM1gbu0pAYKrLcp7NBhq5uPF12BqBIvYztPWjn7JlSmvbl+e2IlQ0KtP0UVqocFq6Vh1ENWVei7iOSlHUr4FJEsmnH2IoH6wGIWc0NL44dxkByefDqWSPV+6cWNIeDlDpMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tm7UdglJ; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tm7UdglJ"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43621907030so9271195e9.1
        for <iommu@lists.linux.dev>; Thu, 12 Dec 2024 10:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734026748; x=1734631548; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HFThXzKnjRTlltuWbtKfTZlx0mgnbefnBgFBqpI1yLQ=;
        b=Tm7UdglJDG4/eIHOJWon1RWYDHGm5tBb2KUFV7ubmAQ1JVByHqloiYzLRTOaEhrKEb
         KGHq3pogddOog2FeWQfVSW6N0f7MzDEoXw8FqCvzwMwwCDYfxLUe0JGXS5lvap4KmGxM
         xwIzEvFLph7EGTjtlcLJgfl/PoiJEsFQYvpL24w8ytWUo3nQDn/SbTn13jG8HhOY7MMk
         G55pfhlpSuTqIEV5rjDN6H+wOTCLhE7zXphP2gPDYRD08w6/0j2WNHQLXAo9d9/J7AXA
         HrtIWBLyohLtYSCcRYep77tw1WEh78E2ahJse3E/7idsUWYk7YY4vJSwHa5T4Fx4WMTU
         5pug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734026748; x=1734631548;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HFThXzKnjRTlltuWbtKfTZlx0mgnbefnBgFBqpI1yLQ=;
        b=FIiZzPA3ZBcYO76c0igu9x834uyPOwygYIDbO/1hkmXSIWjDy0lVpCXhH3jot39GKt
         hBgR9gHgKGjQA0NPSUS77OJc7AzP+uZ6SHbzS7REnS/zsj/xoDGR6dCpH4RTrt85Z1tI
         hW36yqQccoFvZRqCg58S8v7lTeX0Kz3j/QjmdEcMTtREd1uz0htyCis8ERr/AoTpdGLZ
         JiI1b8Y2n0bMQ55vJGvwTWFdKwaweHxwAkfoYnufDaAZWKVxUtDN+6nehmGZjnZqExLL
         KKR1xExO/rczZvzopTpYUZBbhlPszp1r8JtZcexw9Lc9aceEZ3STMHqm+zBIWJAbix+B
         bdhg==
X-Gm-Message-State: AOJu0Yx4XUH7VkZf3K7kOljvbgCp3EDE4sNhePukghyh4UMLIC+zNHVY
	zvQ417vDWO9xBlfM2APqst9i6u6fXm9qUIxHnRnWeoVXk4s1hkQ+iN/PUioR8g8GmzQu2E8JUXD
	DUYyWLSEF2eSxObdqfFtkY0ftk2XD+zEUrmQXvpv13g4uN1tCcKy32nHjJiCulgi+v0aee3Uz6p
	QhQL7WY+Jz2iqrH3/VfLRtJAaoaCo7nlANC238AJ8C9A==
X-Google-Smtp-Source: AGHT+IEcA6NxPQcYOWP3jecw4tajvZQj85hXUMMgjZMFtmkSC/sm2wXlubiRoWv+mV1LLv3tR1NkxUnUlZkBAA==
X-Received: from wmdv18.prod.google.com ([2002:a05:600c:12d2:b0:436:164a:763e])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:524b:b0:434:a781:f5d9 with SMTP id 5b1f17b1804b1-4361c3aaefamr76123965e9.11.1734026746134;
 Thu, 12 Dec 2024 10:05:46 -0800 (PST)
Date: Thu, 12 Dec 2024 18:03:54 +0000
In-Reply-To: <20241212180423.1578358-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20241212180423.1578358-1-smostafa@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241212180423.1578358-31-smostafa@google.com>
Subject: [RFC PATCH v2 30/58] KVM: arm64: smmu-v3: Reset the device
From: Mostafa Saleh <smostafa@google.com>
To: iommu@lists.linux.dev, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: catalin.marinas@arm.com, will@kernel.org, maz@kernel.org, 
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, robdclark@gmail.com, joro@8bytes.org, 
	robin.murphy@arm.com, jean-philippe@linaro.org, jgg@ziepe.ca, 
	nicolinc@nvidia.com, vdonnefort@google.com, qperret@google.com, 
	tabba@google.com, danielmentz@google.com, tzukui@google.com, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

Now that all structures are initialized, send global invalidations and
reset the SMMUv3 device.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 arch/arm64/kvm/hyp/nvhe/iommu/arm-smmu-v3.c | 38 +++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/kvm/hyp/nvhe/iommu/arm-smmu-v3.c b/arch/arm64/kvm/hyp/nvhe/iommu/arm-smmu-v3.c
index 5020f74421ad..58662c2c4c97 100644
--- a/arch/arm64/kvm/hyp/nvhe/iommu/arm-smmu-v3.c
+++ b/arch/arm64/kvm/hyp/nvhe/iommu/arm-smmu-v3.c
@@ -441,6 +441,40 @@ static int smmu_init_strtab(struct hyp_arm_smmu_v3_device *smmu)
 	return 0;
 }
 
+static int smmu_reset_device(struct hyp_arm_smmu_v3_device *smmu)
+{
+	int ret;
+	struct arm_smmu_cmdq_ent cfgi_cmd = {
+		.opcode = CMDQ_OP_CFGI_ALL,
+	};
+	struct arm_smmu_cmdq_ent tlbi_cmd = {
+		.opcode = CMDQ_OP_TLBI_NSNH_ALL,
+	};
+
+	/* Invalidate all cached configs and TLBs */
+	ret = smmu_write_cr0(smmu, CR0_CMDQEN);
+	if (ret)
+		return ret;
+
+	ret = smmu_add_cmd(smmu, &cfgi_cmd);
+	if (ret)
+		goto err_disable_cmdq;
+
+	ret = smmu_add_cmd(smmu, &tlbi_cmd);
+	if (ret)
+		goto err_disable_cmdq;
+
+	ret = smmu_sync_cmd(smmu);
+	if (ret)
+		goto err_disable_cmdq;
+
+	/* Enable translation */
+	return smmu_write_cr0(smmu, CR0_SMMUEN | CR0_CMDQEN | CR0_ATSCHK);
+
+err_disable_cmdq:
+	return smmu_write_cr0(smmu, 0);
+}
+
 static int smmu_init_device(struct hyp_arm_smmu_v3_device *smmu)
 {
 	int ret;
@@ -472,6 +506,10 @@ static int smmu_init_device(struct hyp_arm_smmu_v3_device *smmu)
 	if (ret)
 		return ret;
 
+	ret = smmu_reset_device(smmu);
+	if (ret)
+		return ret;
+
 	return kvm_iommu_init_device(&smmu->iommu);
 }
 
-- 
2.47.0.338.g60cca15819-goog

