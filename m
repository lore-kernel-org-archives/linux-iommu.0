Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800BA221F2A
	for <iommu@lists.linux.dev>; Fri,  4 Apr 2025 19:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743795600; cv=none; b=ifHhQ06aQZGit1ood26PZocvIvWraR64svVJtxSVJwetS+BklYGzyzadgemx4BJOEpzGEGdOH3yP1HynHRRlROxU8g4Z55/dMU5PqzF7T5VmYRplhXOWWinBffUBlCjAySZkcwS2P3dG80P6J7XU2XtHFf3qaKGKviGUpAq9MvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743795600; c=relaxed/simple;
	bh=yOm0l7runQh/bqd/+NGHUK/eIjFj2umaZ1UvQPY4G08=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uE39UtmJK3lmm8o/+oMHkfekZimH3VnFKfqoODtEO2VfH6BHaJMjJjzoTbNT5wKo1csS7ORKzYg7lYhmzsrxuNqQSyzvBLB8xlnzBnSrW1Lt1G9h2ND+kgk/YMUNnOCodgDj+E+iZbuEm27Hhyub/DEVwJC7hK3dplCqOm42kJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eCNyMDzx; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eCNyMDzx"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-739515de999so1997544b3a.1
        for <iommu@lists.linux.dev>; Fri, 04 Apr 2025 12:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743795599; x=1744400399; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=ksKzicOEYbjGpeVOLeT0G0MNe2BKT96MICWw9wdEzS4=;
        b=eCNyMDzxra/KDxzv2ofRx+SU1uFT+DIBJOAMKIL0OMBVzE4Vvcj+1HXDfjnYVr5JXy
         qLW/LihMBZ4L4H5gYrDx8CsUj/DP5Ui87pqbB71ye59K94fVBXiviXfcTRaeVB0nDeh6
         YyZKCkS7PfQRu43yeR87MKMdW03ZOFIMFdjygBr4qXqaDqpOM9+UqRj/ksCfscVV4sG1
         x2w9Q/4x0MMF3zZRNzqwJPCBXADaFYjch+ZzRhMdHxNOZe8v5FyddYlYZtmDpk6P+OiW
         F5esqENTJMowvPczaH8mYzw6xEBUcwAZMXk+ayRpTfa7Z+rGerFGXoN7e2Jg8L0aTWNJ
         DluQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743795599; x=1744400399;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ksKzicOEYbjGpeVOLeT0G0MNe2BKT96MICWw9wdEzS4=;
        b=gD1Qzzlt+x1Nfv7kRN3CBMiiQGJ4Tmx0QWleaAsbWyCT+DvrKcDeIN+OM6hbPwlmCe
         Ikm7O2gT3wNCIZpRbv3Q1suHEsB71j7Woker3EjRURiBetVZe45NVp1L2nFH2uMMvRY2
         QMJ1UYLKHnTbY6B1Iw5AMU/HbPy8irXnOxyvuJMljDGb62jDu1T0mL1CNsjc7xj/g8XP
         RssM3xLXHRf6p7fuIg88M3R+CpFBPpTz+AR9dg3/L+aPDKAIv8Hz1gc12WRT2TAaVn7D
         GIN74MQlppzWNoxt31JGVabeP6hbCju4HHJP5iyN4mSiXJUvxhVFG6KkUbmFU27eYAOr
         WRKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjhkyEeBj2sF5SISmsWQu2cpDxvf0a2Z3obzfE8N4oEprUdfO8B3NK0aEykKtpPfw+h7+qQg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyTTKm6ofwS0akki6vWeiSmYBXYoYRK1tPTl4AdJP/4kz6UGcPC
	6ifyUI6fc4u0TXKatHPTrRpopgvGNqI+T5nR4o6d2/9gmKBUcTWBnk0QLUj8gHA8AbKO8yUo+J+
	KMg==
X-Google-Smtp-Source: AGHT+IHgQd8TSnrl1N62387tBCrXt8b1iTBjftjzhSHwCWE5Yo+RGmXWAwjPpFA1Fbz5oNevpz0/JHGX4zg=
X-Received: from pfax3.prod.google.com ([2002:aa7:9183:0:b0:736:47b8:9b88])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2e9d:b0:736:5f75:4a3b
 with SMTP id d2e1a72fcca58-739e6fdb4bemr5249939b3a.7.1743795598917; Fri, 04
 Apr 2025 12:39:58 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  4 Apr 2025 12:38:22 -0700
In-Reply-To: <20250404193923.1413163-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250404193923.1413163-8-seanjc@google.com>
Subject: [PATCH 07/67] KVM: SVM: WARN if an invalid posted interrupt IRTE
 entry is added
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Now that the AMD IOMMU doesn't signal success incorrectly, WARN if KVM
attempts to track an AMD IRTE entry without metadata.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index ef08356fdb1c..1708ea55125a 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -796,12 +796,15 @@ static int svm_ir_list_add(struct vcpu_svm *svm, struct amd_iommu_pi_data *pi)
 	struct amd_svm_iommu_ir *ir;
 	u64 entry;
 
+	if (WARN_ON_ONCE(!pi->ir_data))
+		return -EINVAL;
+
 	/**
 	 * In some cases, the existing irte is updated and re-set,
 	 * so we need to check here if it's already been * added
 	 * to the ir_list.
 	 */
-	if (pi->ir_data && (pi->prev_ga_tag != 0)) {
+	if (pi->prev_ga_tag) {
 		struct kvm *kvm = svm->vcpu.kvm;
 		u32 vcpu_id = AVIC_GATAG_TO_VCPUID(pi->prev_ga_tag);
 		struct kvm_vcpu *prev_vcpu = kvm_get_vcpu_by_id(kvm, vcpu_id);
-- 
2.49.0.504.g3bcea36a83-goog

