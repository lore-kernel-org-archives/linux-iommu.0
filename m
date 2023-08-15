Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAEB18B1C
	for <iommu@lists.linux.dev>; Tue, 15 Aug 2023 21:35:52 +0000 (UTC)
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-58c4d30c349so21609457b3.2
        for <iommu@lists.linux.dev>; Tue, 15 Aug 2023 14:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692135351; x=1692740151;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=CxcghMO4oqjMEN7NjAyYvu8EEPu+7dtIkj0PyyVU1PY=;
        b=UGhD9P3fwdCHLmsPnxBCw3IYw9fOU6RCS+CQwGE8IF1AWIgaPQgWFwxsPo3orqd5WN
         JKwbQYGkn5xQAiaPPerJL/k0tWOtPbnEpwCSUoHp9lwxKvsIwjPAs/TrAdaVgz7YrDpr
         YBDkuDs/nY2xT9YLhf/G+X3WmSckYw83Xm1NGjnqC2R7PR63CKD3kVBBKudi7KlMxjQM
         26OLmeO573eo+M6qYuUbUdYVv4VpupZ+xghORV2sVTR0bKsK6cjerz7uRPSvM3wPOX+t
         RjUhmUrYBYjQvHe4K4LTOkEC+rlHBm2zWYYyeMJBOwUVfwBP7Vi2jkgDroKaTHQJGGj0
         NsYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692135351; x=1692740151;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CxcghMO4oqjMEN7NjAyYvu8EEPu+7dtIkj0PyyVU1PY=;
        b=g4wFT0W8dse9RQ9wiK1CpJbD2a1N3SnCswu6bT5knjxmdXXoaZwoJE0hNkDAgr+LAY
         dDj2sipwXnGNGaJagDp+zw7ad3vc6yhfYZaIEyAuPBrbdCIeqVb7lke8MUJezVAq98HU
         LiF1fpPLG0umSfQ5Vb00R+PjquVQUP55Q70ZPVcKNNowYgv2NGUu4/WovcXM7+xDKUSG
         h85/35DS/VOrTyxLal3f922H2KMP9g9B5UUNR41NZVmn5ovKvICjBgcFxlehMswuIazm
         PzSZxefoVifeka9XjsGEfBSL8VCN2WJjQV96RvzOTCnQSY7M51Q7BzANwRw5g3BezKzL
         zxtw==
X-Gm-Message-State: AOJu0YxAU/mO25BhmSxXQDgv7n7Z/Fo6cNIRbo7Ga0PDbZcVI5oQqkkL
	9uW/Ihn/6KdfCp5zELq9mtrUzD+7hdk=
X-Google-Smtp-Source: AGHT+IH/wuwBL/LCXf2KX0BggSJOFAhvk+tGLuKVrUxDAKbe8bS9qAslf27WVZxhdW5q8B/OCgwFoC140tI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:cf8c:0:b0:d10:5b67:843c with SMTP id
 f134-20020a25cf8c000000b00d105b67843cmr56ybg.4.1692135351506; Tue, 15 Aug
 2023 14:35:51 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 15 Aug 2023 14:35:30 -0700
In-Reply-To: <20230815213533.548732-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230815213533.548732-1-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
Message-ID: <20230815213533.548732-8-seanjc@google.com>
Subject: [PATCH 07/10] KVM: SVM: Inhibit AVIC if ID is too big instead of
 rejecting vCPU creation
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Inhibit AVIC with a new "ID too big" flag if userspace creates a vCPU with
an ID that is too big, but otherwise allow vCPU creation to succeed.
Rejecting KVM_CREATE_VCPU with EINVAL violates KVM's ABI as KVM advertises
that the max vCPU ID is 4095, but disallows creating vCPUs with IDs bigger
than 254 (AVIC) or 511 (x2AVIC).

Alternatively, KVM could advertise an accurate value depending on which
AVIC mode is in use, but that wouldn't really solve the underlying problem,
e.g. would be a breaking change if KVM were to ever try and enable AVIC or
x2AVIC by default.

Cc: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h |  6 ++++++
 arch/x86/kvm/svm/avic.c         | 16 ++++++++++++++--
 arch/x86/kvm/svm/svm.h          |  3 ++-
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 60d430b4650f..4c2d659a1269 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1243,6 +1243,12 @@ enum kvm_apicv_inhibit {
 	 * mapping between logical ID and vCPU.
 	 */
 	APICV_INHIBIT_REASON_LOGICAL_ID_ALIASED,
+
+	/*
+	 * AVIC is disabled because the vCPU's APIC ID is beyond the max
+	 * supported by AVIC/x2AVIC, i.e. the vCPU is unaddressable.
+	 */
+	APICV_INHIBIT_REASON_ID_TOO_BIG,
 };
 
 struct kvm_arch {
diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index bd81e3517838..522feaa711b4 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -284,9 +284,21 @@ static int avic_init_backing_page(struct kvm_vcpu *vcpu)
 	int id = vcpu->vcpu_id;
 	struct vcpu_svm *svm = to_svm(vcpu);
 
+	/*
+	 * Inhibit AVIC if the vCPU ID is bigger than what is supported by AVIC
+	 * hardware.  Do so immediately, i.e. don't defer the update via a
+	 * request, as avic_vcpu_load() expects to be called if and only if the
+	 * vCPU has fully initialized AVIC.  Bypass all of the helpers and just
+	 * clear apicv_active directly, the vCPU isn't reachable and the VMCB
+	 * isn't even initialized at this point, i.e. there is no possibility
+	 * of needing to deal with the n
+	 */
 	if ((!x2avic_enabled && id > AVIC_MAX_PHYSICAL_ID) ||
-	    (id > X2AVIC_MAX_PHYSICAL_ID))
-		return -EINVAL;
+	    (id > X2AVIC_MAX_PHYSICAL_ID)) {
+		kvm_set_apicv_inhibit(vcpu->kvm, APICV_INHIBIT_REASON_ID_TOO_BIG);
+		vcpu->arch.apic->apicv_active = false;
+		return 0;
+	}
 
 	if (!vcpu->arch.apic->regs)
 		return -EINVAL;
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index a9fde1bb85ee..8b798982e5d0 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -632,7 +632,8 @@ extern struct kvm_x86_nested_ops svm_nested_ops;
 	BIT(APICV_INHIBIT_REASON_PHYSICAL_ID_ALIASED) |	\
 	BIT(APICV_INHIBIT_REASON_APIC_ID_MODIFIED) |	\
 	BIT(APICV_INHIBIT_REASON_APIC_BASE_MODIFIED) |	\
-	BIT(APICV_INHIBIT_REASON_LOGICAL_ID_ALIASED)	\
+	BIT(APICV_INHIBIT_REASON_LOGICAL_ID_ALIASED) |	\
+	BIT(APICV_INHIBIT_REASON_ID_TOO_BIG)		\
 )
 
 bool avic_hardware_setup(void);
-- 
2.41.0.694.ge786442a9b-goog

