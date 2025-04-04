Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265F82253F8
	for <iommu@lists.linux.dev>; Fri,  4 Apr 2025 19:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743795616; cv=none; b=i0lHzt+egxHW9qHzqjsv/osZAMF6NNYz/a+C3WaiVbQHgFH9J7zQ4pxYp9II8JlxZ3pK/4Ru0dzKwvu94TbzUYVhclTu+wxUptDd/sR0MoMyzZwOahriDQvHXbv7Nb1QaKXFJLRUdvMXfEkC0OzVAVr63cl0QjpG93lJr4ZdgDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743795616; c=relaxed/simple;
	bh=5pcNK2/F2mUD0tglxtkkvS4t6gF1WjE0uv3B3h/LLIU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=h1ZjHdXPgLOqi4nbNVvHrpJRBThtpwjLf9ByuU8nKedT9ark4l8SM/1IKOOYbPSr9b0l8T0KgPB+ohjrEQcRf2fIFuv7xqBrm/1fgZ5dgeVWpigXlLrtTK/anxNrbnocdioxhl50zrve6wcWb2MMD0J2XqTm8oIKdYp4I+EQ2hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XhAc3n8d; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XhAc3n8d"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2242ade807fso38141865ad.2
        for <iommu@lists.linux.dev>; Fri, 04 Apr 2025 12:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743795614; x=1744400414; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=xGc410CdItV9i0XHHpZ/RMSaoI91XXBZ8UWJ2P2MUyk=;
        b=XhAc3n8dIoVWxadXPTOVpHaWezBxjE3nhCbLU1Rf+4u47IAp1G/97n3PohZDXtav5v
         oMPnCvV5syHU0JYQ5KYsTIkub6FPQNLjmWPyD6GWRrh0ilj+V9o+WtkVzbtQxnD1cYXV
         qT50RZ9xI99bJV5i/MzMcj5eyC1H+viSL566uTW0KG/pYnheznsxp/43YlcHTBC5JuYG
         VOHfur0alQhfW62b7UcZYKp2uFhdgCG2dgnohi9kswPi7st5cczJwyZwIGcMoQ6/N73h
         B+uAiUpYDUqSfJYHynaMwnbuM6+hj9Mq/krXVcTFRzWAqfVlZ0fAbvTLgMYJ4hZvEyQX
         wk0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743795614; x=1744400414;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xGc410CdItV9i0XHHpZ/RMSaoI91XXBZ8UWJ2P2MUyk=;
        b=QDNELpVlVqZ6hNxaV6nwvRzcXK8yxgm3JySIqg4WT2bX2xaUlBzxLU3DC2TdRGz7Bi
         NU+GRj8D7NokxxctdGpB1bN/AQGwyz5LlH5RUjrjDvbf3MY7LaTZt+5RH1D9Fth8A1Wu
         AznLstKs5vHbMT4MMAsvhMekpEIAHicl2Z7vhjJR8d4b+MqbRBdf4UPeJgfwlH/LBPg9
         /lxfZtrKLKUB7cgR1Kyic46rzNt6OmuuQBiqGyPUKp0dMNuHUC3HGaeRe160auBzAwCP
         J/YuOianFrEA4vKVJI+9gx0En2i7k/RKRjdzeEVQRkpNQs5st/Gki0xsxFTGOiBAl513
         ZI+w==
X-Forwarded-Encrypted: i=1; AJvYcCXNfhos/D937xRfwP4KB699axocLPpGvEP0vvO8SzTiWaBdX9Gf++/s7NLSBvPOgiGNs69y0Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yym6R8YeH+LqnZwCCo7Kfmd9Jb/rpjAkpV75yQNgBU1akGZ6AWq
	Uc5QClQ6Rr/J/mSesU21nkD/k1VRyPRIn1uh9EqBKo9LgprQCwR/BH/KVLH8YNoIPVfIjGZ3b2r
	VyQ==
X-Google-Smtp-Source: AGHT+IHtyu5/n45SoUCdmyRwx78ZExMmcLv2DVkaCFXoZBFEW/oA9gYZTnVIAZvyMAiWmV0cdXBxBQzi80A=
X-Received: from pfks21.prod.google.com ([2002:a05:6a00:1955:b0:730:848d:a5a3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:41d0:b0:223:4bd6:3869
 with SMTP id d9443c01a7336-22a8a85adcbmr56111145ad.15.1743795614550; Fri, 04
 Apr 2025 12:40:14 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  4 Apr 2025 12:38:31 -0700
In-Reply-To: <20250404193923.1413163-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250404193923.1413163-17-seanjc@google.com>
Subject: [PATCH 16/67] KVM: SVM: Inhibit AVIC if ID is too big instead of
 rejecting vCPU creation
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	David Matlack <dmatlack@google.com>
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
 arch/x86/include/asm/kvm_host.h |  9 ++++++++-
 arch/x86/kvm/svm/avic.c         | 16 ++++++++++++++--
 arch/x86/kvm/svm/svm.h          |  3 ++-
 3 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 54f3cf73329b..0583d8a9c8d4 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1304,6 +1304,12 @@ enum kvm_apicv_inhibit {
 	 */
 	APICV_INHIBIT_REASON_LOGICAL_ID_ALIASED,
 
+	/*
+	 * AVIC is disabled because the vCPU's APIC ID is beyond the max
+	 * supported by AVIC/x2AVIC, i.e. the vCPU is unaddressable.
+	 */
+	APICV_INHIBIT_REASON_PHYSICAL_ID_TOO_BIG,
+
 	NR_APICV_INHIBIT_REASONS,
 };
 
@@ -1322,7 +1328,8 @@ enum kvm_apicv_inhibit {
 	__APICV_INHIBIT_REASON(IRQWIN),			\
 	__APICV_INHIBIT_REASON(PIT_REINJ),		\
 	__APICV_INHIBIT_REASON(SEV),			\
-	__APICV_INHIBIT_REASON(LOGICAL_ID_ALIASED)
+	__APICV_INHIBIT_REASON(LOGICAL_ID_ALIASED),	\
+	__APICV_INHIBIT_REASON(PHYSICAL_ID_TOO_BIG)
 
 struct kvm_arch {
 	unsigned long n_used_mmu_pages;
diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index c8ba2ce4cfd8..ba8dfc8a12f4 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -286,9 +286,21 @@ static int avic_init_backing_page(struct kvm_vcpu *vcpu)
 	int id = vcpu->vcpu_id;
 	struct vcpu_svm *svm = to_svm(vcpu);
 
+	/*
+	 * Inhibit AVIC if the vCPU ID is bigger than what is supported by AVIC
+	 * hardware.  Do so immediately, i.e. don't defer the update via a
+	 * request, as avic_vcpu_load() expects to be called if and only if the
+	 * vCPU has fully initialized AVIC.  Immediately clear apicv_active,
+	 * as avic_vcpu_load() assumes avic_physical_id_cache is valid, i.e.
+	 * waiting until KVM_REQ_APICV_UPDATE is processed on the first KVM_RUN
+	 * will result in an NULL pointer deference when loading the vCPU.
+	 */
 	if ((!x2avic_enabled && id > AVIC_MAX_PHYSICAL_ID) ||
-	    (id > X2AVIC_MAX_PHYSICAL_ID))
-		return -EINVAL;
+	    (id > X2AVIC_MAX_PHYSICAL_ID)) {
+		kvm_set_apicv_inhibit(vcpu->kvm, APICV_INHIBIT_REASON_PHYSICAL_ID_TOO_BIG);
+		vcpu->arch.apic->apicv_active = false;
+		return 0;
+	}
 
 	if (WARN_ON_ONCE(!vcpu->arch.apic->regs))
 		return -EINVAL;
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 1cc4e145577c..7af28802ebee 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -715,7 +715,8 @@ extern struct kvm_x86_nested_ops svm_nested_ops;
 	BIT(APICV_INHIBIT_REASON_PHYSICAL_ID_ALIASED) |	\
 	BIT(APICV_INHIBIT_REASON_APIC_ID_MODIFIED) |	\
 	BIT(APICV_INHIBIT_REASON_APIC_BASE_MODIFIED) |	\
-	BIT(APICV_INHIBIT_REASON_LOGICAL_ID_ALIASED)	\
+	BIT(APICV_INHIBIT_REASON_LOGICAL_ID_ALIASED) |	\
+	BIT(APICV_INHIBIT_REASON_PHYSICAL_ID_TOO_BIG)	\
 )
 
 bool avic_hardware_setup(void);
-- 
2.49.0.504.g3bcea36a83-goog

