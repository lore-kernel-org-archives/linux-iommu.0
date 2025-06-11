Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB6D2ECE88
	for <iommu@lists.linux.dev>; Wed, 11 Jun 2025 22:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749682115; cv=none; b=LDr2cMj3bmJq9DBnEqXHrYwatWcjbsnVtVEdTHfjCJ9FKiwJFqGi6nFlRpNwCLIAqdkZQYB1MvTtCJ+9U5iP1OaCt/QGaVzD1YavLkZ923KwTVDKbVFt9mHu3xzhfaQOjXO7CRpr0LZISlHkNvLjOIPZCVZn3HfUkHS83Q6tFmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749682115; c=relaxed/simple;
	bh=oClo+BVpPugtrWJhwqiJOJyGd7gX17MvqJmd+Hb+bsE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JGGtNSScI3g5Q/sE1teVdxfv2bmz5A631ttJACZFEIPcgGSvwcxToueznOkWwICrXkgEn84om6kr/mLEdN+iPqTzIvnB9nO/LnItQgDi3dl2203OoPiXzWwFLmWRcpERX/e6OsrOWMneP0Q9fNkzcdQF7qfItb6ZKhcXWx4h4fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WnEG7G5i; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WnEG7G5i"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-747cebffd4eso233612b3a.2
        for <iommu@lists.linux.dev>; Wed, 11 Jun 2025 15:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749682113; x=1750286913; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=wAqMQv4ZCiS/o57gwDnKWsXRvD97E5JGl6V3dBiKRrw=;
        b=WnEG7G5iJTiM+ezuoObv+rRf/JRkp/3Ra9C/04Sa1JNeTdMuP/ALcWEjpQK/ac8N4/
         qIOx5PulRn7HZQmZ4BfKuWRpUclJeHRB4gOwiWd+dc4OzumYgyvSDym/5FwwTC12zrBV
         dmXnuZkoc+HBsxkuyjssWklsnoS9pGpfqExsGunrJ8C2DPurVHbMnWSlcA8zeeqiJoDy
         7smvqS8QYJXQswgzL2lVKjssOxlkj3+zNyjchbkYOcu+PiseTC1llKdZM3YDXbvPkHMY
         D+EU4NNbGna/Lyc+8duUZ9vlSYP20qHSZyUlMQ4e0mwS9LBJJsQ+K83IiNXOYu3+xpRj
         AYGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749682113; x=1750286913;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wAqMQv4ZCiS/o57gwDnKWsXRvD97E5JGl6V3dBiKRrw=;
        b=Xh/VtEO2sw2n4cY+SVX93uiCTYwu7pQLlSeg3h441cZ9Q0inOweIGAK6EuBDx/Xxp4
         q/VUq0ai3Eq8r708fo4vUujH/jyo7b3FfWkyvDs+EeL+GIxJrU9XVYdn/fcfXiQ93ncz
         wm8nVzBdtci9u5hH5aIn7Ui2ajDGe9xfEwdePBlT9WQ+WhwPXhHaozfmtW6cj8hf/7rC
         AzrTm+j6/61jycohCWgrU2gYWRtT03XDT4fQhUQEZbr43T13IbH/+qnoVXgUiylOJ250
         3DdsF7LTbp11gEcLsjF+B7Yd9OcA9Q4FZipwElBRGNrWnJ94e1BKapgtHt5WdslINOpe
         MJag==
X-Forwarded-Encrypted: i=1; AJvYcCXR66yM2+HRr89n91RlIfNSsv82+7gzzbzEd9PvkxgdBLcSKcto6lAVjsQQQAiT7WAMsuoEtw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz1Ki3MLSQUVTI5clsU0dRJLPY7Ql4/7gQxwlKj7N3eN7nrtZS1
	ZpCPF+D/z5hhqFfo0PpfRodpSF337mVsTCkTIGYuI1GHrD1WvqjoYHQRfdZfXaBowm4St6Yf2+X
	DdFccug==
X-Google-Smtp-Source: AGHT+IGWXeo6wLxobJN8weuZ+dD2iRb7MDLZVxncM/6se6ioUirEafScJTOie1Jy0cagndCeqMrM68HvN2k=
X-Received: from pfms8.prod.google.com ([2002:aa7:8288:0:b0:746:1a7b:a39a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a86:b0:736:5f75:4a3b
 with SMTP id d2e1a72fcca58-7487e0f2cb6mr1014723b3a.7.1749682112843; Wed, 11
 Jun 2025 15:48:32 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 11 Jun 2025 15:45:59 -0700
In-Reply-To: <20250611224604.313496-2-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250611224604.313496-2-seanjc@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250611224604.313496-58-seanjc@google.com>
Subject: [PATCH v3 56/62] iommu/amd: WARN if KVM calls GA IRTE helpers without
 virtual APIC support
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

WARN if KVM attempts to update IRTE entries when virtual APIC isn't fully
supported, as KVM should guard all such calls on IRQ posting being enabled.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 drivers/iommu/amd/iommu.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index becef69a306d..926dcdfe08c8 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3836,8 +3836,10 @@ int amd_iommu_update_ga(int cpu, void *data)
 	struct amd_ir_data *ir_data = (struct amd_ir_data *)data;
 	struct irte_ga *entry = (struct irte_ga *) ir_data->entry;
 
-	if (!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir) ||
-	    !entry || !entry->lo.fields_vapic.guest_mode)
+	if (WARN_ON_ONCE(!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir)))
+		return -EINVAL;
+
+	if (!entry || !entry->lo.fields_vapic.guest_mode)
 		return 0;
 
 	if (!ir_data->iommu)
@@ -3856,7 +3858,10 @@ int amd_iommu_activate_guest_mode(void *data, int cpu)
 	struct irte_ga *entry = (struct irte_ga *) ir_data->entry;
 	u64 valid;
 
-	if (!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir) || !entry)
+	if (WARN_ON_ONCE(!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir)))
+		return -EINVAL;
+
+	if (!entry)
 		return 0;
 
 	valid = entry->lo.fields_vapic.valid;
@@ -3885,8 +3890,10 @@ int amd_iommu_deactivate_guest_mode(void *data)
 	struct irq_cfg *cfg = ir_data->cfg;
 	u64 valid;
 
-	if (!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir) ||
-	    !entry || !entry->lo.fields_vapic.guest_mode)
+	if (WARN_ON_ONCE(!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir)))
+		return -EINVAL;
+
+	if (!entry || !entry->lo.fields_vapic.guest_mode)
 		return 0;
 
 	valid = entry->lo.fields_remap.valid;
-- 
2.50.0.rc1.591.g9c95f17f64-goog

