Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA4928C876
	for <iommu@lists.linux.dev>; Fri, 23 May 2025 01:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747962074; cv=none; b=bPC8gkQydlam7IRI4fA8+WhLo4094RZk6235vc/1mLW0qlDpVzanUOs6W6CqkszyaV92LLZRglID5ua5ZNdDIrrDugEDxwu0RqdySNEGMOjNL1wGHgATXFMgbtfEHX3KIorlEwIxHspNhdII5N2DvJrIYlYjdFqHd4kmmMdpBsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747962074; c=relaxed/simple;
	bh=OoaKuYJuGBNrzRs4FOlcqG4EfEZ0eKgNguock8Nm660=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mYfwv3bQ7lAFtYgjzQRwFtWJhedH0QFl+MdP9HSGVX11HySheUriJ9ftXJxFoDWjYtOia4Z416G8S/cy/ckfEkjZneACxpa3ldf88qptpuU/Sqgf7MytwMLR0cM3e24aUOAfIS9khVGd45Cuh8D4Pov3cXBsBvjLoi37im3uHEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=grgxEaft; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="grgxEaft"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-30ec5cc994eso4818100a91.2
        for <iommu@lists.linux.dev>; Thu, 22 May 2025 18:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747962072; x=1748566872; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=QZ/HVVcKE1D9F/RksSitv8YykybKRfr9scegH3bUh2Y=;
        b=grgxEaftl7c2ttvWjA6XuR15qce619ybKoI5Aq3NgBS80hA5Ce3g0fV+9fpwAcV38f
         v196JdhHr4NE5s0T8/d7xEqlKg/pkzSt3dY6Wfx2h41ljIHQihiDt5X4Rb9WlcKE6EAe
         t5pwD8U35MHnRtf6Ut3LxoDgY1Ay1iQyU9jdVxslNNURHHKOQ0VJSlya0Npd55CL/Cz4
         r9zR4JcYc22DIg5ek4IhP/OCD/9iXwlZ+F6YcHMOWJP1ngfT1NcOmxlMwpQG0yEn+dXB
         qqxjqDEJ28Vu0C6ImXnkt1UD6h7IzAcxbwf1es56IZknL84dAT2+Iq2k6HssM9pVZGeR
         mNeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747962072; x=1748566872;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QZ/HVVcKE1D9F/RksSitv8YykybKRfr9scegH3bUh2Y=;
        b=b9imu8YnLlufb/xWJKox079hnqCJrP1ubKAnE+a7/kWCi1FTWE13/Z40k7GRxzljEE
         7j9CCGEh7uw3JFbH8WXJ24k0BqbsH3ulN6KEdZMm05WL3WTzK4p75puCPiz7LEUAxi4Y
         KbkxUAkTmvky+JGgwl84nQf85qE8aAcHqPONTOO+N7P9s/Pvh6Mz6PBvY1lm5cEbf1l1
         pmkMvy/SmabTZftg0UOX1bhzBSraPNuNlGNG9JnsbYWpuboE6vP2WiBKSB34t9lYG4qP
         IhDadZ7ad/hBEu3NU6iWeBzRo8FE/7VICB4nXiUMwS/2nWBpLBuFXnyAmAnh3xQuDJwQ
         jc4w==
X-Forwarded-Encrypted: i=1; AJvYcCUnWLWTafuKwHTl96mfs/kLitwVfZlTqnYMsNcyz1iTcXZgr/1Jh6Iu8JTxdQDLIxdC7dv+TQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz5PhgwjayR53rthkn7twGUqRidioXyzvdEZB3Kpk1p5LuVRGUI
	TSLaHZAaLMJ0qceW1u1GasXRxIeuvxB9MzmwZTg1u2gOBUpRckb7drfYyA3XCQVW2GIdHwd9HJO
	97W250g==
X-Google-Smtp-Source: AGHT+IEivPKszStQSfYiwNpJ7/umbLGOogBna7x7mx10TTJkqWGmqjwZ44z3FVYVN+th/LcfZ1pWsae8+lg=
X-Received: from pja14.prod.google.com ([2002:a17:90b:548e:b0:2ef:d283:5089])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3b86:b0:30e:8c5d:8f8
 with SMTP id 98e67ed59e1d1-30e8c5d09b3mr44884823a91.14.1747962072336; Thu, 22
 May 2025 18:01:12 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 May 2025 17:59:42 -0700
In-Reply-To: <20250523010004.3240643-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250523010004.3240643-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523010004.3240643-38-seanjc@google.com>
Subject: [PATCH v2 37/59] iommu/amd: Document which IRTE fields
 amd_iommu_update_ga() can modify
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
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
2.49.0.1151.ga128411c76-goog

