Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3544156FD
	for <iommu@lists.linux.dev>; Tue, 15 Aug 2023 21:35:41 +0000 (UTC)
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-589e5e46735so42518757b3.2
        for <iommu@lists.linux.dev>; Tue, 15 Aug 2023 14:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692135340; x=1692740140;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=bCGvdYVO9EKbpa2jmZF0w8IsHUC4STqQLwNPEWIlFrg=;
        b=4seg8jbUuzcf+Jrd/1/VCZUZyBFVOg1OI+RgVOOd17/vtRlmnaSGCfGp+yaEQXkaUV
         T93drzsN5+fFePzUoNFE5SkAYPYATw3WDE7OlPsPwxwzAMhJUK4DDKasrG347gUl0E0m
         bjiWWESP9bDXOkIXBXe5d/i1vj2ID5gyS8VmBT98ZfA0J7RSycx3pK9aDweUnUg1pEpZ
         OMJRY5agn0k5JzWysk/6LYC5fkHk1aZcSyGv+bny6dm9yLROA7+zldsiELd3m9avnZ+y
         AOqsx3XjHgeRNK9pgBLcqe3SoweWvFnkgZGQmTVd+2LdyxnWwa93d1buUfX/MTMzuYaq
         imaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692135340; x=1692740140;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bCGvdYVO9EKbpa2jmZF0w8IsHUC4STqQLwNPEWIlFrg=;
        b=UHJUatiCiOOoBTqK6BiKsSqdEC5AvrtemuYhPwwzr0BrNYp2kijj/ynsYZcJIxDsP+
         mSKRe33C4HRW5Ci1EEIjttidlcROegZXmDxVkpOSMKUioii4Db5xaOEf2wjGJtyjq2qw
         obMCFNiJxpomXduY+SnBhgh1KV+5/6EKfYPToYYvAD+ekf5epNeaNALYNCFRTi5tr5AG
         KcvzaaLNYvXUfcUmvhQwcIjWvH/GxUVfFG+BLFRAhueqoXKz0Sr7C36TZpEcd0Y7oWdp
         cFLVFvRmUYfva7bMFikD1laCAw8/ASO5KTTBYQ5asqPJWIgUCAPP2Ha6/LbfE2Mdhilq
         pWig==
X-Gm-Message-State: AOJu0YwIXBxo7qYW3ussXGpzRtMJlHgH98Moh/63D+2lYW3GS0QTGvGB
	apvCQV44QVoGt1RaWGTiqnQZs3oqaoI=
X-Google-Smtp-Source: AGHT+IGRuzrjE+vpyIzdyF/OQOo1U5zpH5XKrPubx9S5xZyoHO/CMSeIvVbf4AW+/aR8z9iCg8Y6aE7RL/Y=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:af27:0:b0:579:f832:74b with SMTP id
 n39-20020a81af27000000b00579f832074bmr200736ywh.10.1692135340576; Tue, 15 Aug
 2023 14:35:40 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 15 Aug 2023 14:35:24 -0700
In-Reply-To: <20230815213533.548732-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230815213533.548732-1-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
Message-ID: <20230815213533.548732-2-seanjc@google.com>
Subject: [PATCH 01/10] KVM: SVM: Drop pointless masking of default APIC base
 when setting V_APIC_BAR
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Drop VMCB_AVIC_APIC_BAR_MASK, it's just a regurgitation of the maximum
theoretical 4KiB-aligned physical address, i.e. is not novel in any way,
and its only usage is to mask the default APIC base, which is 4KiB aligned
and (obviously) a legal physical address.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/svm.h | 2 --
 arch/x86/kvm/svm/avic.c    | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index 72ebd5e4e975..1e70600e84f7 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -257,8 +257,6 @@ struct __attribute__ ((__packed__)) vmcb_control_area {
 
 #define AVIC_DOORBELL_PHYSICAL_ID_MASK			GENMASK_ULL(11, 0)
 
-#define VMCB_AVIC_APIC_BAR_MASK				0xFFFFFFFFFF000ULL
-
 #define AVIC_UNACCEL_ACCESS_WRITE_MASK		1
 #define AVIC_UNACCEL_ACCESS_OFFSET_MASK		0xFF0
 #define AVIC_UNACCEL_ACCESS_VECTOR_MASK		0xFFFFFFFF
diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index cfc8ab773025..7062164e4041 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -251,7 +251,7 @@ void avic_init_vmcb(struct vcpu_svm *svm, struct vmcb *vmcb)
 	vmcb->control.avic_backing_page = bpa & AVIC_HPA_MASK;
 	vmcb->control.avic_logical_id = lpa & AVIC_HPA_MASK;
 	vmcb->control.avic_physical_id = ppa & AVIC_HPA_MASK;
-	vmcb->control.avic_vapic_bar = APIC_DEFAULT_PHYS_BASE & VMCB_AVIC_APIC_BAR_MASK;
+	vmcb->control.avic_vapic_bar = APIC_DEFAULT_PHYS_BASE;
 
 	if (kvm_apicv_activated(svm->vcpu.kvm))
 		avic_activate_vmcb(svm);
-- 
2.41.0.694.ge786442a9b-goog

