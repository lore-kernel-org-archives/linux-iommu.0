Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0872D4B55
	for <iommu@lists.linux.dev>; Fri, 23 May 2025 01:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747962095; cv=none; b=HJot82gDZyoreoYwTjFSHCyjCp2cx0DAN/J6kXJGPLOmqUXFFi8FrFgqxCjRW/MkIy+U3+xf57KM96MnqPGsfFzflOBfdssoyxblkCbadz0rb674tiQLPim9OEZNrrEgPyt8oSpD/ATulcPKnS4SROSFSrEoT1uzh4/o4fPdFQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747962095; c=relaxed/simple;
	bh=65fTcpLjkBtBO6xCL7Lqhp4uS5GSGwxSjcQbFJFJsvA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=k+9cDIYKhtnSaO1CDkqjVZNt2cEm5Lc8V20QcqVYXXoEPuAo1VIQoKDFYn+j68u4zumsR5fvIWxpMMiugQbtfKZAoF/CdRKMHroijs6xYSnyzEV9UJEBG84EMpMRuwE71HD0jrrzdPVi2tX2PQtn0LB5S0U6qtkWgE8jML9PD+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i6T96zVl; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i6T96zVl"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b1ffc678adfso5533120a12.0
        for <iommu@lists.linux.dev>; Thu, 22 May 2025 18:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747962093; x=1748566893; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=jRZ2pwWogb5EDz58ANC8fmbpd84fTXnIK4G2GwCRUWE=;
        b=i6T96zVl26OsVDruL4IcsJX9HKnme/JzxOCIiLx7pgEyioaQXUqSoDvW17RSAkUw6p
         sBVkuFs7bxhNjMvY7JY/xXxtZ8V1hsQRTqdVY/i8Tb9ZiuGUu+GowfbwD1fjYbCz0bQC
         8qUl9f8iGePwQqi2tnvuCcdUs3lp1opGQaGiegYrg4ajy1j7Xg/PaCMBelEWdL7duLKb
         zDfq/kMAG6RMQqkllY7oKFF76FHQl/bU9QsDQXdri9kqf+TCJiI8L0Y6f6HOR6egba95
         GZR32e7PBtJS6ZvfXRX+G0RkeiACwC6NUhSwtiKzpqTnrgkk/2eN7uq53GjiBpGn/H8N
         WFZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747962093; x=1748566893;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jRZ2pwWogb5EDz58ANC8fmbpd84fTXnIK4G2GwCRUWE=;
        b=bHYk1zUlWqIe4KEBbrZ6MWzwsfegvTPXnBKzzw1QRxSidH9p4NNvdTW0cWYKcZB6z4
         15gm0Anv2zp+o74KC19rCgkq93EJpCPcYYlS4qXrJWU2/X9ffEKCUwPIp3nNQaFJTCuO
         B8O1RskhruvN4qFW80+jwnsfYsJBR6Q2Inp7vSAqLabOQvzua5obh9qSxCc8glAuqpqo
         vqocjapSCWTFKr9nXtVT27hy6KY5SnpxA/Oh98uPkW12kRfD3pHDZIvrwxsylZepA/5m
         mqYQfgS/rB19ybhExoXgWT7o3v3F3jzpGvGhAqWrsoAWHK1jUt4eyT/22bUuJO3TXlzV
         H8uw==
X-Forwarded-Encrypted: i=1; AJvYcCXdivMaIDuE+ffk9jreaiQkdXey8ufgu93IF5C6XoWSmoKNhCPruUULJpUXz5s4J/wTJoSPmA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxl6394vexz2M4B5eGwapBVUM+oLK/C2y6xVNHkGHhySbUWEvHi
	VOS+G+WZwWG+Xs3jV/im1rGNBVIpUlEXcCdoFloludhH8HvQFv1yzGHZI96JeeD6EZ5yWsb5DQl
	yCY0j9A==
X-Google-Smtp-Source: AGHT+IFyeeumFKhc4Yu6rkIsxyO1z805cVfyQ8R0sxgmiUuh4VdwSV11ZDutI0EPEQI70l4STndzesKeIW4=
X-Received: from pjbsi3.prod.google.com ([2002:a17:90b:5283:b0:2ef:7af4:5e8e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3b48:b0:2ee:d433:7c50
 with SMTP id 98e67ed59e1d1-30e7d5ac7ecmr33847409a91.23.1747962092871; Thu, 22
 May 2025 18:01:32 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 May 2025 17:59:54 -0700
In-Reply-To: <20250523010004.3240643-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250523010004.3240643-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523010004.3240643-50-seanjc@google.com>
Subject: [PATCH v2 49/59] KVM: x86: WARN if IRQ bypass routing is updated
 without in-kernel local APIC
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Sairaj Kodilkar <sarunkod@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	Francesco Lavra <francescolavra.fl@gmail.com>, David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Yell if kvm_pi_update_irte() is reached without an in-kernel local APIC,
as kvm_arch_irqfd_allowed() should prevent attaching an irqfd and thus any
and all postable IRQs to an APIC-less VM.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/irq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/irq.c b/arch/x86/kvm/irq.c
index af766130b650..b6263ab4b18d 100644
--- a/arch/x86/kvm/irq.c
+++ b/arch/x86/kvm/irq.c
@@ -517,8 +517,8 @@ static int kvm_pi_update_irte(struct kvm_kernel_irqfd *irqfd,
 	struct kvm_lapic_irq irq;
 	int r;
 
-	if (!irqchip_in_kernel(kvm) || WARN_ON_ONCE(!kvm_arch_has_irq_bypass()))
-		return 0;
+	if (WARN_ON_ONCE(!irqchip_in_kernel(kvm) || !kvm_arch_has_irq_bypass()))
+		return -EINVAL;
 
 	if (entry && entry->type == KVM_IRQ_ROUTING_MSI) {
 		kvm_set_msi_irq(kvm, entry, &irq);
-- 
2.49.0.1151.ga128411c76-goog

