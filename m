Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4307C18B1C
	for <iommu@lists.linux.dev>; Tue, 15 Aug 2023 21:35:48 +0000 (UTC)
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1bddcaed7d7so30312535ad.0
        for <iommu@lists.linux.dev>; Tue, 15 Aug 2023 14:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692135347; x=1692740147;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=CHnuPfUXbmZWu5F2MvTRaFvjEQfMFtfyp4fO+JPGxbI=;
        b=kVAV3xXrMTAbLQ3rPVK4qegv5MzcfS8e5dljWpr6AvcDuBCLiIlKECoYWD0XJVho2d
         jGHvwxgZljxFQgu9npgxS0x58JZUu5bU6WNjVCyPnO35SrWnCN2H+7CpCT70QXB8cRcr
         Pm68+mIdMG7Vl/qw6lSltNtd2pWdOLis+Zl8fjgJ6ApWsU6cxkl4XOtNCEDxY2oiqK5g
         eHSIZrYlahQWr00vrJsklrB6UFyfC5BbaAtr0DMTu0XBUvY5RFq/76/YBxjT4ujsAS2m
         vAqC/DTBbvrhK664IFPuNgeJmAz/J50Ejod+21zKsCGZ5Otsf7bOl91ky9QfiCR7/JOz
         00ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692135347; x=1692740147;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CHnuPfUXbmZWu5F2MvTRaFvjEQfMFtfyp4fO+JPGxbI=;
        b=UmeDlJyAvLGX0XnyA+gQtBCBsQK0NeRn4QKkv0Sw7wSdm5AdtLkmzUtHSu8tQTlzVD
         7+vmaQ/Dw71JbtPgV5ZOLFFN7oU/9pyXJ5vYzZ0TR7o1tA8cvk6ClqlgMbYCvYYsWBkX
         zkcOXiXaZ+4CW0Hl6MY4Zh4433BJaIA/aMvEMp4tLf0cVS+o1DrYzEIp7PL+e+PQwB/p
         r2WuP/atj+/sjK6C+wiA/MPihEHK7j75kgteA6cronoOk6xxxRcSHiXz9VutrH4+184A
         Q+fxiz5+ZJUE7If9OXhPcxnrcJyeOm3vQ8dDSxVsUghU66Y77acAnqGA+I/UhFsddTg1
         JK4w==
X-Gm-Message-State: AOJu0Ywf7/F3hUHkCpADx0598LaAA2p0xKITlq/MokdK9DWXlAKZtQyz
	lKwMHqUdvwZ3tGcJJRmY3K68Aq/b0/Q=
X-Google-Smtp-Source: AGHT+IGZpFTzWg3Yj6yV3ARgS1gRpt4WlnLvCCsXQ6y9zKKLCPAYed5RzAVM7pWLFGE752cW0iko5FNITv0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:1c3:b0:1b5:2496:8c0d with SMTP id
 e3-20020a17090301c300b001b524968c0dmr24608plh.3.1692135347694; Tue, 15 Aug
 2023 14:35:47 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 15 Aug 2023 14:35:28 -0700
In-Reply-To: <20230815213533.548732-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230815213533.548732-1-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
Message-ID: <20230815213533.548732-6-seanjc@google.com>
Subject: [PATCH 05/10] KVM: SVM: Drop vcpu_svm's pointless avic_backing_page field
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Drop vcpu_svm's avic_backing_page pointer and instead grab the physical
address of KVM's vAPIC page directly from the source.  Getting a physical
address from a kernel virtual address is not an expensive operation, and
getting the physical address from a struct page is *more* expensive for
CONFIG_SPARSEMEM=y kernels.  Regardless, none of the paths that consume
the address are hot paths, i.e. shaving cycles is not a priority.

Eliminating the "cache" means KVM doesn't have to worry about the cache
being invalid, which will simplify a future fix when dealing with vCPU IDs
that are too big.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 4 +---
 arch/x86/kvm/svm/svm.h  | 1 -
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 954bdb45033b..e49b682c8469 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -243,7 +243,7 @@ int avic_vm_init(struct kvm *kvm)
 
 static phys_addr_t avic_get_backing_page_address(struct vcpu_svm *svm)
 {
-	return __sme_set(page_to_phys(svm->avic_backing_page));
+	return __sme_set(__pa(svm->vcpu.arch.apic->regs));
 }
 
 void avic_init_vmcb(struct vcpu_svm *svm, struct vmcb *vmcb)
@@ -305,8 +305,6 @@ static int avic_init_backing_page(struct kvm_vcpu *vcpu)
 			return ret;
 	}
 
-	svm->avic_backing_page = virt_to_page(vcpu->arch.apic->regs);
-
 	/* Setting AVIC backing page address in the phy APIC ID table */
 	entry = avic_get_physical_id_entry(vcpu, id);
 	if (!entry)
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 2237230aad98..a9fde1bb85ee 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -261,7 +261,6 @@ struct vcpu_svm {
 
 	u32 ldr_reg;
 	u32 dfr_reg;
-	struct page *avic_backing_page;
 	u64 *avic_physical_id_cache;
 
 	/*
-- 
2.41.0.694.ge786442a9b-goog

