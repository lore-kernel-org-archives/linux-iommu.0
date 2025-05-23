Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B0521CC4F
	for <iommu@lists.linux.dev>; Fri, 23 May 2025 01:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747962030; cv=none; b=Z5PEQw/uqvtsANTFtOOzaBGdbI0GyIxQrm09zyn0/N2WFFKOxtzkRwA90Cgb8MBJ9zYjAflWj3gAgvBujmgYEUb5P55OXwCdaPSmZOjcYaCXqWZ3UO70lsVGp+kcfj1LF3pCmq8S3++7ovYLFrrog3hiEOIiTrl1rgZowNv+SFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747962030; c=relaxed/simple;
	bh=OynwmpZzE+tOR+c6k83RPGCMFRJPHQO+vuelylIgD9s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Waw0eV0yVtlexr5ooj4A6Fam66DVt/avRUwvdggMdJRGdKL3PA9jPTYktjQpdb8jrnvWnvPrfJm9clO06gqhXq044Ogrq7Cl92yVBuyGHVc2Xne83bv75pOxSTkcOpltGFiFW+br35eOJeaQDewUAdifj8YXuIO656OYhJUsdBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k74XysZ3; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k74XysZ3"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-30e7c25aedaso5798546a91.2
        for <iommu@lists.linux.dev>; Thu, 22 May 2025 18:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747962028; x=1748566828; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=la0aXzVeKKVBiy8uaO6FAWX8ZpsMttxn3OpIPvBkLxA=;
        b=k74XysZ3LZvdlQHT0Gt2tc3Jf7Jf0kwK1O2pj1s/lnHsaUfKmrcuMJmCBwxyLH4J2k
         zLHKu0dUWEBQXvVcUihdJ6DKiDcXJ+gIzzqWEXQJx1v7V7OA2Ja7CooDV9Wcab0zf6fp
         c+FGe6t5iF69J0xWvzf0K6TReSGdYkzjPqADOm4VC/egRJ8sSZn1fstChKTKxNQI3FFc
         5Ra/xP8USOOynjP2rtRM58iHLR97/aYMtSV7XoxqONLKqaPpo+NFmnTZ7XJYMSzl+IE5
         wQ4mJYYmo/BgtHupOzftNpV70ibuvqMuVqrpY4cxdbbF1ZQ7D66WkHFOt2E88z/ByLIl
         X5mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747962028; x=1748566828;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=la0aXzVeKKVBiy8uaO6FAWX8ZpsMttxn3OpIPvBkLxA=;
        b=I4aVDv/a0yLAIA7qEUOHdbQIP9aQQupKds62mMcda8uqdSMPFMrT7nVV07g8d5XG1s
         39KYEXa2ZaGI9pndc/WlUJrx+gfdFiyxxAGMWRl7zx5VKzgW9HVipcHqfOFZGoylSYyp
         h9QnmTWMQTPMbhNZZDR0bPuxBVJ8KfGDTjRzd0zU7BpKrU440ptkVf8yP/TXvwH0Uwqy
         fD7/UiMwF6HrXL+y+kPhLnMObvuRAg0so6LW1CiX5SE3lGNb47kAfpr36LKT3hALPbJD
         oUviYuAyHjH8LsHJwVNablTFqhxk37Wup6pps37HuyxM316uNjXXJQ8Am5HTnorLoHmj
         gPog==
X-Forwarded-Encrypted: i=1; AJvYcCXyeBWvUECX4U91JPTbOg4Xp94OrLCSnQuYWA7JFu8XKEV2v9oqnvn5OJ3az+jSQXQu1UwqdQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw02fhiXUgG8D6khvsnM/7SwL+awP53zk0XdcKNsAINepRRfjLW
	YHSShfKMbgNAXnhR4DLjY+sRyB2A075hU0IBsBKuRXe4p1GWPP8fNFtPg2jh8TiqRYrIcMP+uhh
	MDtGzUg==
X-Google-Smtp-Source: AGHT+IFB3ajdgTxrTXVysFpFaHJbw/mIl1eAI1Y8d57Q56yfcB9pR6oBP4Leg9XUSb1oftSrh5d450so4NU=
X-Received: from pjbpl16.prod.google.com ([2002:a17:90b:2690:b0:30e:7003:7604])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d44e:b0:2ee:d63f:d8f
 with SMTP id 98e67ed59e1d1-310e96c9598mr1763628a91.13.1747962028063; Thu, 22
 May 2025 18:00:28 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 May 2025 17:59:15 -0700
In-Reply-To: <20250523010004.3240643-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250523010004.3240643-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523010004.3240643-11-seanjc@google.com>
Subject: [PATCH v2 10/59] KVM: SVM: Inhibit AVIC if ID is too big instead of
 rejecting vCPU creation
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Sairaj Kodilkar <sarunkod@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	Francesco Lavra <francescolavra.fl@gmail.com>, David Matlack <dmatlack@google.com>
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
Tested-by: Sairaj Kodilkar <sarunkod@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h |  9 ++++++++-
 arch/x86/kvm/svm/avic.c         | 14 ++++++++++++--
 arch/x86/kvm/svm/svm.h          |  3 ++-
 3 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 2a6ef1398da7..a9b709db7c59 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1314,6 +1314,12 @@ enum kvm_apicv_inhibit {
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
 
@@ -1332,7 +1338,8 @@ enum kvm_apicv_inhibit {
 	__APICV_INHIBIT_REASON(IRQWIN),			\
 	__APICV_INHIBIT_REASON(PIT_REINJ),		\
 	__APICV_INHIBIT_REASON(SEV),			\
-	__APICV_INHIBIT_REASON(LOGICAL_ID_ALIASED)
+	__APICV_INHIBIT_REASON(LOGICAL_ID_ALIASED),	\
+	__APICV_INHIBIT_REASON(PHYSICAL_ID_TOO_BIG)
 
 struct kvm_arch {
 	unsigned long n_used_mmu_pages;
diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index ab228872a19b..f0a74b102c57 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -277,9 +277,19 @@ static int avic_init_backing_page(struct kvm_vcpu *vcpu)
 	int id = vcpu->vcpu_id;
 	struct vcpu_svm *svm = to_svm(vcpu);
 
+	/*
+	 * Inhibit AVIC if the vCPU ID is bigger than what is supported by AVIC
+	 * hardware.  Immediately clear apicv_active, i.e. don't wait until the
+	 * KVM_REQ_APICV_UPDATE request is processed on the first KVM_RUN, as
+	 * avic_vcpu_load() expects to be called if and only if the vCPU has
+	 * fully initialized AVIC.
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
index 1585288200f4..71e3c003580e 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -722,7 +722,8 @@ extern struct kvm_x86_nested_ops svm_nested_ops;
 	BIT(APICV_INHIBIT_REASON_PHYSICAL_ID_ALIASED) |	\
 	BIT(APICV_INHIBIT_REASON_APIC_ID_MODIFIED) |	\
 	BIT(APICV_INHIBIT_REASON_APIC_BASE_MODIFIED) |	\
-	BIT(APICV_INHIBIT_REASON_LOGICAL_ID_ALIASED)	\
+	BIT(APICV_INHIBIT_REASON_LOGICAL_ID_ALIASED) |	\
+	BIT(APICV_INHIBIT_REASON_PHYSICAL_ID_TOO_BIG)	\
 )
 
 bool avic_hardware_setup(void);
-- 
2.49.0.1151.ga128411c76-goog

