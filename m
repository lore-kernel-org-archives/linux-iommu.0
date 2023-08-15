Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAF7156FD
	for <iommu@lists.linux.dev>; Tue, 15 Aug 2023 21:35:39 +0000 (UTC)
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-56477bea06fso6297161a12.1
        for <iommu@lists.linux.dev>; Tue, 15 Aug 2023 14:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692135338; x=1692740138;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tVl3VRj57iGr8qaIRcvd93q5Wtl5mgpiK42P78vs0Wk=;
        b=st/sTpRNP/idx5nlQZE0UaS24tJVAcF4CELTvWKEpOBxgj1C2QWWPrpIZvxmbTd0Ip
         hr0jUZwnERWNdnSUZoMdaS0UF/GVcygUH6nlTEsQGb50HvVWmbsyS7kc9NWoj9r+MiGv
         pH6vEZAwPcYxZGa4aZugNXLAQaJrV9kngpycQftIzDW2oeOeD0H0cN2VygiIouovp3oa
         YAIKwVT2AG1eBqo2IISvcl0XDoSr2+US9Suzl23ovnjkQmczqdwvlmYpLQ698FmWd6DE
         dXy/Alrh3bAytD25sizHNdi7CylUdgAMwj6udvCHrTw16L9SbRHJdsB8NaYGIzG1fpRW
         5rLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692135338; x=1692740138;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tVl3VRj57iGr8qaIRcvd93q5Wtl5mgpiK42P78vs0Wk=;
        b=C9zmvntlPwZK7jHE0luqv09oqwjAZk6Ub0MHxAEo1VmLbV9sI4s4yz6EpDB9FIJKw+
         S8HKEOj0iT8KdaHNUSXXCuFvzwqcsUbgd3hv1z/S+VjQITHZgCiZ9uwxkt1CXRQJz/lq
         Zhmj0rs5mkBwoCBtJ9dF0eR0sUPwRmVVEGj6IdTUEil/KezCXhefwPwMscmb1eAldB43
         hKzHV1wTOI4qZLR16eka9yGJExXhkHA2AFNipqhia/JmlMpfD1IRIUG1UOsN8n1LfOEL
         DUlKvvf4t6SQYYApi5bGlgLCvfTnkKlLQp85nB6bUw4ugl8xpnxmZddV75IvH+9aX8Md
         igBw==
X-Gm-Message-State: AOJu0YyyhgQa7JqsoUN5Ht/s+K496qqVeAyuTh2wO5AYVLGFtOukpXja
	xfwt6GUQWK4Mr4QyBh+Sse7JwpawgJ8=
X-Google-Smtp-Source: AGHT+IEQJUXjsmbqH1x4y9bzfU8nFQD6xuICpUdNtkubfBXgLbWJbZDHZj0rAyx8MSDnBexaefmpTUylrls=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:950c:0:b0:565:e2cd:c9e1 with SMTP id
 p12-20020a63950c000000b00565e2cdc9e1mr8860pgd.11.1692135338581; Tue, 15 Aug
 2023 14:35:38 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 15 Aug 2023 14:35:23 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
Message-ID: <20230815213533.548732-1-seanjc@google.com>
Subject: [PATCH 00/10] VM: SVM: Honor KVM_MAX_VCPUS when AVIC is enabled
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"

The only true functional change in this entire mess is to change KVM's
handling of KVM_CREATE_VCPU when AVIC is enabled.  Currently, KVM rejects
vCPU creation if the vcpu_id is unaddressable, i.e. if it's larger than
what is suppported by AVIC/x2AVIC hardware.  That is a rather blatant
violation of both KVM_CAP_MAX_VCPUS and KVM_CAP_MAX_VCPU_ID, as KVM will
advertise a KVM_CAP_MAX_VCPUS as 1024 and KVM_CAP_MAX_VCPU_ID as 4096,
but then reject vcpu_ids as low as 256 (AVIC).

To fix the problem, add yet another AVIC inhibit to disable AVIC if
userspace creates unaddressable vCPUs.  Alternatively, KVM could report
different KVM_CAP_MAX_VCPUS and KVM_CAP_MAX_VCPU_ID values when AVIC is
enabled, but IMO that path sets KVM up for failure, e.g. it would make it
really hard for us to enable AVIC/x2AVIC by default, and we'd have to have
to rework KVM selftests, which assume that KVM supports at least 512 vCPUs,
e.g. recalc_apic_map_test fails when AVIC is enabled.

The bulk of this series is cleaning up related code, most of which is
purely opportunistic, e.g. the many pointless PA masks, but some of which
are functionally "necessary", for some definitions of necessary.

Lightly tested, and the IOMMU interaction is basically compile tested only.
But this is firmly post-6.6 material, so no rush on anyone testing this
(I wouldn't even care all that much if the darn selftests didn't fail).

Sean Christopherson (10):
  KVM: SVM: Drop pointless masking of default APIC base when setting
    V_APIC_BAR
  KVM: SVM: Use AVIC_HPA_MASK when initializing vCPU's Physical ID entry
  KVM: SVM: Drop pointless masking of kernel page pa's with "AVIC's" HPA
    mask
  KVM: SVM: Add helper to deduplicate code for getting AVIC backing page
  KVM: SVM: Drop vcpu_svm's pointless avic_backing_page field
  iommu/amd: KVM: SVM: Use pi_desc_addr to derive ga_root_ptr
  KVM: SVM: Inhibit AVIC if ID is too big instead of rejecting vCPU
    creation
  KVM: SVM: WARN if KVM attempts to create AVIC backing page with user
    APIC
  KVM: SVM: Drop redundant check in AVIC code on ID during vCPU creation
  KVM: SVM: Rename "avic_physical_id_cache" to "avic_physical_id_entry"

 arch/x86/include/asm/kvm_host.h |  6 +++
 arch/x86/include/asm/svm.h      |  6 +--
 arch/x86/kvm/svm/avic.c         | 79 +++++++++++++++------------------
 arch/x86/kvm/svm/svm.h          |  6 +--
 drivers/iommu/amd/iommu.c       |  2 +-
 include/linux/amd-iommu.h       |  1 -
 6 files changed, 48 insertions(+), 52 deletions(-)


base-commit: 240f736891887939571854bd6d734b6c9291f22e
-- 
2.41.0.694.ge786442a9b-goog

