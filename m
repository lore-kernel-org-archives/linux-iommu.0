Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B9523AE64
	for <iommu@lists.linux.dev>; Fri,  4 Apr 2025 19:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743795666; cv=none; b=pvT9d+hmGwOnNiuyQgOm1eRq8G1YGJci3fT2dEJcBxJIva4Mr8wy+qjhhYBdEjUImITiDVcgpNtgPg5jI46WhTkz1usFfyWWzZM+RzlLkDg73SrigDynSP/hRVX7H9bdSB+D0U2b1zmKwb3dtg6Tlgk/BnD99MpGGnpoJ24jRSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743795666; c=relaxed/simple;
	bh=l9/TMQHoV8daxs6LkFNlEupntQ06coEMa2x+aKyzlWY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l3OyfxdR2/L+z569gsGjgq1becsGSexmGfwbgY83lhDE04U+S5d+2kFuQRHPxrOcS1IQRQbxWSEdFNNtFi+EjdhVefvl2vHMPzwX0kW5eIzWoOvs0AyQ3h8h/VQCJSt1AoypiVofNFsVHfm9ZQsZUsp7nAQKQ8qCrgC06fARtqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KdbG3/kr; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KdbG3/kr"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7369c5ed395so2833560b3a.0
        for <iommu@lists.linux.dev>; Fri, 04 Apr 2025 12:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743795664; x=1744400464; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=l67GfpOlJHxEJdXm0d3y4sV8FlCkfwhTj3jmH6dDpac=;
        b=KdbG3/krU2jvJvIPTBBsa6VaxPfgjgJGUftzWz0fx6zwfhlVLSxH+UAQ7LyMRztSMX
         L5ElxOoa7tBL0mAds82w4NrwXxDZOcuQ0RI3Bu0OgvBOytLGXxeew62t0FcNPkiprAsG
         XXtBQl7RkC3I7UzOaUFCNnLdYMKHcsiFVgkNeAWUKHu4rwys4iINcOmQZTKvAt6g4+rI
         MFz3W5PX0CQn7iiBcj8jjpSDdUmn6z3jAoJLjWeCMeCsH36D+UZ3O4Ipke1RaLPrAoOC
         IksAynvjT1O+DuxqedBaJCMdeVonila+t2IwWO+i+CCT7OsFHS2zFnfOtbXe995x4lVe
         68yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743795664; x=1744400464;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l67GfpOlJHxEJdXm0d3y4sV8FlCkfwhTj3jmH6dDpac=;
        b=PYyGg8zI3qpUooWjUIAyTlR5z5WkY3sXSAxe+sw8qqMQZg6+81WE5iL+KZNRailaXI
         SAddlj2Tn3HRyt/++5EZOla5cZ1cMvliLcUm/wbbfxvL2+dtbttu56M2eRJq+Do2whMA
         UVqZ0Ai3GRLNZc36S1AA7p/saN81KdZANYa3ePpEPo0wHVAWr/IR8qNBTOsptLnKKeKH
         CjkUwD48UYFpzDFcrU7XeX2ZpjB03CyJx4hwzCbBYLYB469IMk7j+DUp6DwkrfP23mFV
         qMWEguB0PqIkTAQ1pxR+wSqT1sr/h2m4MM0X8H6jPJ+jQejP4ZD5RISKk5IU+imYPRwZ
         0ETA==
X-Forwarded-Encrypted: i=1; AJvYcCUhx/DvcbG9p++tVKPshkcMhPUoSncqrjw1fkHI4EYOBGbzF6ckp0Crq9JLaz7sc3TfjaDxSw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyph5ivNWEv+y/9HFIHv9HwL2LIFDslcAZvrqF2pR+Abt7g0yVs
	vdOlrAfyhqKRKl32CXK6scYDT8spN64C+ogo5MMY9XFF6Lr/khbxFisVlrXnDmYKdX0Ycep2pMn
	4ww==
X-Google-Smtp-Source: AGHT+IEsFzK6cRrJ4WqDr7v3u7M9JaAhLsSDAqEgoXQfJ0GjLsWP9yEnMTwux+uXm8Wz38v+7YUWG83LmH0=
X-Received: from pfgs23.prod.google.com ([2002:a05:6a00:1797:b0:732:6425:de9a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:398f:b0:730:9752:d02a
 with SMTP id d2e1a72fcca58-739e48cefc2mr6715054b3a.4.1743795664464; Fri, 04
 Apr 2025 12:41:04 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  4 Apr 2025 12:39:00 -0700
In-Reply-To: <20250404193923.1413163-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250404193923.1413163-46-seanjc@google.com>
Subject: [PATCH 45/67] iommu/amd: Factor out helper for manipulating IRTE
 GA/CPU info
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Split the guts of amd_iommu_update_ga() to a dedicated helper so that the
logic can be shared with flows that put the IRTE into posted mode.

Opportunistically move amd_iommu_update_ga() and its new helper above
amd_iommu_activate_guest_mode() so that it's all co-located.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 drivers/iommu/amd/iommu.c | 59 +++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 27 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index ba3a1a403cb2..4fdf1502be69 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3775,6 +3775,38 @@ static const struct irq_domain_ops amd_ir_domain_ops = {
 	.deactivate = irq_remapping_deactivate,
 };
 
+static void __amd_iommu_update_ga(struct irte_ga *entry, int cpu)
+{
+	if (cpu >= 0) {
+		entry->lo.fields_vapic.destination =
+					APICID_TO_IRTE_DEST_LO(cpu);
+		entry->hi.fields.destination =
+					APICID_TO_IRTE_DEST_HI(cpu);
+		entry->lo.fields_vapic.is_run = true;
+	} else {
+		entry->lo.fields_vapic.is_run = false;
+	}
+}
+
+int amd_iommu_update_ga(int cpu, void *data)
+{
+	struct amd_ir_data *ir_data = (struct amd_ir_data *)data;
+	struct irte_ga *entry = (struct irte_ga *) ir_data->entry;
+
+	if (!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir) ||
+	    !entry || !entry->lo.fields_vapic.guest_mode)
+		return 0;
+
+	if (!ir_data->iommu)
+		return -ENODEV;
+
+	__amd_iommu_update_ga(entry, cpu);
+
+	return __modify_irte_ga(ir_data->iommu, ir_data->irq_2_irte.devid,
+				ir_data->irq_2_irte.index, entry);
+}
+EXPORT_SYMBOL(amd_iommu_update_ga);
+
 int amd_iommu_activate_guest_mode(void *data)
 {
 	struct amd_ir_data *ir_data = (struct amd_ir_data *)data;
@@ -3956,31 +3988,4 @@ int amd_iommu_create_irq_domain(struct amd_iommu *iommu)
 
 	return 0;
 }
-
-int amd_iommu_update_ga(int cpu, void *data)
-{
-	struct amd_ir_data *ir_data = (struct amd_ir_data *)data;
-	struct irte_ga *entry = (struct irte_ga *) ir_data->entry;
-
-	if (!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir) ||
-	    !entry || !entry->lo.fields_vapic.guest_mode)
-		return 0;
-
-	if (!ir_data->iommu)
-		return -ENODEV;
-
-	if (cpu >= 0) {
-		entry->lo.fields_vapic.destination =
-					APICID_TO_IRTE_DEST_LO(cpu);
-		entry->hi.fields.destination =
-					APICID_TO_IRTE_DEST_HI(cpu);
-		entry->lo.fields_vapic.is_run = true;
-	} else {
-		entry->lo.fields_vapic.is_run = false;
-	}
-
-	return __modify_irte_ga(ir_data->iommu, ir_data->irq_2_irte.devid,
-				ir_data->irq_2_irte.index, entry);
-}
-EXPORT_SYMBOL(amd_iommu_update_ga);
 #endif
-- 
2.49.0.504.g3bcea36a83-goog

