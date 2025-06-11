Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA992E7F09
	for <iommu@lists.linux.dev>; Wed, 11 Jun 2025 22:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749682085; cv=none; b=OOk7zYW1RUg+yY5kDiuZLM9lJVe628JUb6YibgaU55ZqXKJtxTXthCzqfD1Osj2rkbybZ1E8Nciws0GPqyQTMFtcQOHXVG+yGMW5xyHDHH4x5Vv/xH3bdo8aaWJtoqHJbXmqSvidu3Kv2p6EABvwVNPurzTJBSn5Z+Yohh+j9t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749682085; c=relaxed/simple;
	bh=WiRNHbtpZOil+9fwHPGuk9Q4bsY1vkPwMWiwfcncPr8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=an0NFtb6VmzzLhkypuVGzlHkpJMOZnYpFsxOa0wtGTmuPgpeMj/TBAnkmrFoXAU7M9F8n3UNXwmIqBmJrS6d4DN4yTO1YaXqNv8iCSpdAyK4+JKNNlgmSaDDURGDM6aaumZpnD4gkOHhyCmlxOxc13dQrlASGLGfpnRF6GwwOLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ry5zhxU8; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ry5zhxU8"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b2eb60594e8so123901a12.1
        for <iommu@lists.linux.dev>; Wed, 11 Jun 2025 15:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749682083; x=1750286883; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=1o3WGFG+EaR4ZcOuVZ9zENMrapystEeQsKqGzB4EF5M=;
        b=ry5zhxU8K3cKMaHZatjTi0T3pB86jR61KhqwnCMAqoRZ8DEWmw9Ee7YhPeaUJf6ur/
         X8FCfZ59b2fxCQLDNpo7/wwWQYbhQ/e7tU6WczJGVCRQcVnUO/6qtuSkjSGfW5e4NjBp
         3+l72gnGAjKKFNhdkfHlTv3xWrZoLjBwy1ZigV9VJKC76KeQCnXE4RbLW134N00LDKDp
         ojR9+onPtL7GH+hx8uwUXG5TOtuKrm6m9IwaGr3RoPwD63J+uXMCKoDK4cfZfptdj+oI
         8zEWIXf4OyysS/9kmHKnUE3NwLrzMDEtT2D3oyX9HEW2BDN+hqRfSBEzvbUUDlh+gepL
         srrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749682083; x=1750286883;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1o3WGFG+EaR4ZcOuVZ9zENMrapystEeQsKqGzB4EF5M=;
        b=wFdojC9l7EiKGBBoIYrcMognNCbYSO/It02bsrAMlzpRPREVus0Oj3zngRN1zeoeqm
         5g3kYKp9nlhA3L0AadqMlCb0QU2xJ0o2mKmrA3DYFsgOmx+HwxNviZJYEct/YK9glUjX
         2qOG1t0Ev6DGPgsuQqEnQajqcq5zX97SmfbFo8N0EEclaWGAn1tmyQcdP8cbfW4Fagtu
         /Lv85AGgbMc5s+RwGiH6cjc+VrapyBp0ZMK9XNzMC/iIOxAz/eBk41bCMOQjzZuwQQ78
         E454WcioQegRpoDdm0yhYVcu4uaxO+ZP8zatRCMHW0xTSlSM+SLBBHd4zYiVIM4U22aD
         3QDg==
X-Forwarded-Encrypted: i=1; AJvYcCUy2uvX4s/tcLacFQRNyFA1wTqjyK3m+I2eVUnkqI4bELKIgl5wQ63Iiv5yeEDaEhxrh6J8YQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyLZvSqFlliMcaZ+IowX8h38Sz+l84rFEfokwdCoSUsy+YYBkGQ
	mLdZuAe3J4i+6gQG5Dtg1nNPUAr+tr49cCpyAYV6iYiTwkcqEMKs8p0S2SOjOuIPJjOFyb8H7Qe
	oz7y5EA==
X-Google-Smtp-Source: AGHT+IGR4w9J3onYODzU2Sfz5wEnxfVemQzL0W0aJt8YvQhN18RuJB+dzan66R+cAm17xLYHnG+IrBPZWnM=
X-Received: from pgbdr17.prod.google.com ([2002:a05:6a02:fd1:b0:b2e:c00e:65ed])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:8cca:b0:215:d4be:b0b2
 with SMTP id adf61e73a8af0-21f9b93f637mr691254637.34.1749682083132; Wed, 11
 Jun 2025 15:48:03 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 11 Jun 2025 15:45:42 -0700
In-Reply-To: <20250611224604.313496-2-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250611224604.313496-2-seanjc@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250611224604.313496-41-seanjc@google.com>
Subject: [PATCH v3 39/62] iommu/amd: Document which IRTE fields
 amd_iommu_update_ga() can modify
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Joerg Roedel <joro@8bytes.org>, 
	David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Sairaj Kodilkar <sarunkod@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	Francesco Lavra <francescolavra.fl@gmail.com>, David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a comment to amd_iommu_update_ga() to document what fields it can
safely modify without issuing an invalidation of the IRTE, and to explain
its role in keeping GA IRTEs up-to-date.

Per page 93 of the IOMMU spec dated Feb 2025:

  When virtual interrupts are enabled by setting MMIO Offset 0018h[GAEn] and
  IRTE[GuestMode=1], IRTE[IsRun], IRTE[Destination], and if present IRTE[GATag],
  are not cached by the IOMMU. Modifications to these fields do not require an
  invalidation of the Interrupt Remapping Table.

Link: https://lore.kernel.org/all/9b7ceea3-8c47-4383-ad9c-1a9bbdc9044a@oracle.com
Cc: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 drivers/iommu/amd/iommu.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 36749efcc781..5adc932b947e 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3986,6 +3986,18 @@ int amd_iommu_create_irq_domain(struct amd_iommu *iommu)
 	return 0;
 }
 
+/*
+ * Update the pCPU information for an IRTE that is configured to post IRQs to
+ * a vCPU, without issuing an IOMMU invalidation for the IRTE.
+ *
+ * This API is intended to be used when a vCPU is scheduled in/out (or stops
+ * running for any reason), to do a fast update of IsRun and (conditionally)
+ * Destination.
+ *
+ * Per the IOMMU spec, the Destination, IsRun, and GATag fields are not cached
+ * and thus don't require an invalidation to ensure the IOMMU consumes fresh
+ * information.
+ */
 int amd_iommu_update_ga(int cpu, bool is_run, void *data)
 {
 	struct amd_ir_data *ir_data = (struct amd_ir_data *)data;
-- 
2.50.0.rc1.591.g9c95f17f64-goog

