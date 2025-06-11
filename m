Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6337F2E0B68
	for <iommu@lists.linux.dev>; Wed, 11 Jun 2025 22:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749682070; cv=none; b=pqyhFp9yPpPaSuifOzA0s143g/JbrlxbZ1LVFJa4Zd6xcXfWlL2LoXQ4gtvKpX/mYybfbai0yCamiRJjeJcPuVdI+eIWMnM1eEB7PbbDCnZtV/hFjIxxuN2nYVG+tJFOgjL9haLF7BCNu7c0SgFCtq7fIp7t4ArAj0wYZneUCvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749682070; c=relaxed/simple;
	bh=qt8zb5uI4+X1TebyXBfKCY7Oiv/Cu3N97xLB9PqUJ80=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LVgG89WZmVCy0G5DpB1elQDguom3WGKV007L+hbX48mOs58zzXd8BbRBCnGFuhKw05AOKBQP4iFLPJd8DEYsjAj/863OlKDCWTl4VDUVkaAO5s+sMijpjxw/3vgENHP7gsjIQSFnfubcRb2n1CYsaamCJ1TfGOxeJVIkIeC0J6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GShmTUnB; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GShmTUnB"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b2eea1c2e97so154598a12.2
        for <iommu@lists.linux.dev>; Wed, 11 Jun 2025 15:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749682068; x=1750286868; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=+DtVGJXTI5NZcLSNxUulZl3FS9wdQHA/Njni8dB9YZ8=;
        b=GShmTUnB0OVlQQtArMv8K384qMVdmNZ/qGkyrWeXXrXpr4POIcAp9RO/whRWGKO0M7
         ei+EHF3htoQNGFRkQsqKYbzHdMRizakGfwzJlX1nXpwIjb0S6vEx6C2zPyFxXUkewHx1
         QmsagZfqPV4PvY8ufOcAe0nWLWnxaEBVQDLh0Dq8Q3/TC1hduWB+i8HBAVTjT2fdztt+
         NijdzZ6m4uLyPO5U1KdpTW246KnHryKD82d/swNBTp1clA/BYVGG7+uz+8qRYic8cjni
         +xFAKEi/YbJ02Bmv6p7FA6oaH67R81vH6X6i8J+Qhd9n82ZzUixVH04ExVQnKGBoQo83
         7CiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749682068; x=1750286868;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+DtVGJXTI5NZcLSNxUulZl3FS9wdQHA/Njni8dB9YZ8=;
        b=CW6bSosahofdMmQvgmZr4v0/9dFeuRk5bPtqce5Pk0y4d2wxEzqR9E3Fg+Nv8JO/0r
         q8QhmNPU1n1BDLhIOZBkBm/w/M4uNYfbInzV8SIXXtff5lJInzaQXk/7Dp4N0t9ihjEs
         wFGi5AbEXgFqj8ai51Dovt7wkzwHu3Xu8YQer+W00IHSKTT/LSoH1kym2ueJSRZ0vomF
         ugC2OALoGUI1Rz/2JyBkVBRXLLw646mwRhoB3ufxLunethSz0py39hH7Gx94fTU0fTVB
         ppp/rUjrLf21cZM9wOPByvJQlP3uQJQ7yy5hE8pZEzQUFe3W8QHTeDfwVr/Ql3UwE0uS
         63hw==
X-Forwarded-Encrypted: i=1; AJvYcCW4qcboVvgHGEW+LRG+K5u0GZJTkkPNrgsFXHDlMU3hQGITgJ86n4QPkdPws1VMsk0PG3WykQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxaclsYApjQQTU8T05aPap0GjNaAd2mxujzNrcYAYsmPG79n4nV
	avdACWKtPzDXrLz4zbplbblQqaMxXIV64IjKNVkIrSrJ6RAzBs8ljGt2uo2dK6xRDG+uDtutsdO
	DV43ODA==
X-Google-Smtp-Source: AGHT+IFyGDdeorUwj3sAfzICdRUEdg2fKYugNVe8KlRyB4tgk6PAyMC59w8WcXLbD69NI4qphVBoJu3KIY4=
X-Received: from pflc8.prod.google.com ([2002:a05:6a00:ac8:b0:746:1e60:660e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:2589:b0:21f:53a9:b72c
 with SMTP id adf61e73a8af0-21f86754dbemr7156966637.38.1749682067486; Wed, 11
 Jun 2025 15:47:47 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 11 Jun 2025 15:45:33 -0700
In-Reply-To: <20250611224604.313496-2-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250611224604.313496-2-seanjc@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250611224604.313496-32-seanjc@google.com>
Subject: [PATCH v3 30/62] KVM: SVM: Clean up return handling in avic_pi_update_irte()
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

Clean up the return paths for avic_pi_update_irte() now that the
refactoring dust has settled.

Opportunistically drop the pr_err() on IRTE update failures.  Logging that
a failure occurred without _any_ context is quite useless.

Tested-by: Sairaj Kodilkar <sarunkod@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index d8d50b8f14bb..a0f3cdd2ea3f 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -807,8 +807,6 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 			unsigned int host_irq, uint32_t guest_irq,
 			struct kvm_vcpu *vcpu, u32 vector)
 {
-	int ret = 0;
-
 	/*
 	 * If the IRQ was affined to a different vCPU, remove the IRTE metadata
 	 * from the *previous* vCPU's list.
@@ -838,8 +836,11 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 			.is_guest_mode = true,
 			.vcpu_data = &vcpu_info,
 		};
+		int ret;
 
 		ret = irq_set_vcpu_affinity(host_irq, &pi);
+		if (ret)
+			return ret;
 
 		/**
 		 * Here, we successfully setting up vcpu affinity in
@@ -848,20 +849,9 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 		 * we can reference to them directly when we update vcpu
 		 * scheduling information in IOMMU irte.
 		 */
-		if (!ret)
-			ret = svm_ir_list_add(to_svm(vcpu), irqfd, &pi);
-	} else {
-		ret = irq_set_vcpu_affinity(host_irq, NULL);
+		return svm_ir_list_add(to_svm(vcpu), irqfd, &pi);
 	}
-
-	if (ret < 0) {
-		pr_err("%s: failed to update PI IRTE\n", __func__);
-		goto out;
-	}
-
-	ret = 0;
-out:
-	return ret;
+	return irq_set_vcpu_affinity(host_irq, NULL);
 }
 
 static inline int
-- 
2.50.0.rc1.591.g9c95f17f64-goog

