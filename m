Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F063418B1C
	for <iommu@lists.linux.dev>; Tue, 15 Aug 2023 21:35:56 +0000 (UTC)
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-d65201b777dso10248593276.0
        for <iommu@lists.linux.dev>; Tue, 15 Aug 2023 14:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692135356; x=1692740156;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=XKYtflVs6x0P0nG2XmReTxoXGzhm2UoHQdfpKsYPPNY=;
        b=gTV6SCMN5bJtw7ZipgqQ/Ha6xtnuyOxIzI9hPVU/IHJWYusADTAXSdZSEjqrdDvKFC
         H24by3+WRSsHD8ktrTbPXqbnVMsshBgkR7Qtizb5ozlvhvguhcV4O6Dy0UQmPrlGU5q1
         kmSjTHik0kFE+ree6QrqFLChvoY0qLuwjy7n00kwpKgzKsukZuE4WZc3RJXjeBegfnzN
         QNCzsgylSTpei/Dpc2l18J7ku3sZgSKl1oRWYeP8ytJcXPe6azd0ac2ZUKTf/E1wzsiS
         0J/cMrZ1DN4bFw9uLJVz7hyOkGRqhVejQvIy1/z+gDrAaxhs9P9+pI0332AplAir6Vx2
         orYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692135356; x=1692740156;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XKYtflVs6x0P0nG2XmReTxoXGzhm2UoHQdfpKsYPPNY=;
        b=DQwsDdLI6m6r3W9dJp2D8Zxe1Fhm650Ksv9MV91hzHTGHCTw7RfGRBMNJYfsWyCjqp
         bThQt06+rc3HTkW3DmsdZ/PiI2tHlOdK3mRa4qlhK9gYayVe+gRJBuHAyCQyAcbclj/r
         adYPAd+6QN8sDFTg35uP9TUBJDzF/IWj1S+YXcOEnnROYggEZf2g6im2PfZ/aQtpRr88
         bhukzJ+D2uQZkzXIxG2H2ouM/R6BED/fDAHq5m2EtxSJFvZGXSsXpAi65B3dA43eUkaQ
         TRMRY9WPX2z3whOq+vru0oPIyU7N/9GpWl9RrfqB0/I0R+XmZf6jwVWCF3OurC0MFDp7
         tX+w==
X-Gm-Message-State: AOJu0Yx+qqRSWpoZdljxb1CqY3mMmxJcbpbgb8b731QBDtD4xqk1DR9r
	KGBBm8AfPruEMmDCf9zPm5LI0pCA4JQ=
X-Google-Smtp-Source: AGHT+IErNwqVt6Ll9LVDM795Zz4F0y53aJAzMjQ8Os681uzsdutwM4dp6vSZf6bhQDOx24qg7MUvE1zlle0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1021:b0:d2c:649:f848 with SMTP id
 x1-20020a056902102100b00d2c0649f848mr4288ybt.1.1692135355855; Tue, 15 Aug
 2023 14:35:55 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 15 Aug 2023 14:35:32 -0700
In-Reply-To: <20230815213533.548732-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230815213533.548732-1-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
Message-ID: <20230815213533.548732-10-seanjc@google.com>
Subject: [PATCH 09/10] KVM: SVM: Drop redundant check in AVIC code on ID
 during vCPU creation
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Drop avic_get_physical_id_entry()'s compatibility check on the incoming
ID, as its sole caller, avic_init_backing_page(), performs the exact same
check.  Drop avic_get_physical_id_entry() entirely as the only remaining
functionality is getting the address of the Physical ID table, and
accessing the array without an immediate bounds check is kludgy.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 28 ++++++----------------------
 1 file changed, 6 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 3b2d00d9ca9b..6803e2d7bc22 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -263,26 +263,12 @@ void avic_init_vmcb(struct vcpu_svm *svm, struct vmcb *vmcb)
 		avic_deactivate_vmcb(svm);
 }
 
-static u64 *avic_get_physical_id_entry(struct kvm_vcpu *vcpu,
-				       unsigned int index)
-{
-	u64 *avic_physical_id_table;
-	struct kvm_svm *kvm_svm = to_kvm_svm(vcpu->kvm);
-
-	if ((!x2avic_enabled && index > AVIC_MAX_PHYSICAL_ID) ||
-	    (index > X2AVIC_MAX_PHYSICAL_ID))
-		return NULL;
-
-	avic_physical_id_table = page_address(kvm_svm->avic_physical_id_table_page);
-
-	return &avic_physical_id_table[index];
-}
-
 static int avic_init_backing_page(struct kvm_vcpu *vcpu)
 {
-	u64 *entry, new_entry;
+	struct kvm_svm *kvm_svm = to_kvm_svm(vcpu->kvm);
+	struct vcpu_svm *svm = to_svm(vcpu);
+	u64 *table, new_entry;
 	int id = vcpu->vcpu_id;
-	struct vcpu_svm *svm = to_svm(vcpu);
 
 	/*
 	 * Inhibit AVIC if the vCPU ID is bigger than what is supported by AVIC
@@ -318,15 +304,13 @@ static int avic_init_backing_page(struct kvm_vcpu *vcpu)
 	}
 
 	/* Setting AVIC backing page address in the phy APIC ID table */
-	entry = avic_get_physical_id_entry(vcpu, id);
-	if (!entry)
-		return -EINVAL;
+	table = page_address(kvm_svm->avic_physical_id_table_page);
 
 	new_entry = avic_get_backing_page_address(svm) |
 		    AVIC_PHYSICAL_ID_ENTRY_VALID_MASK;
-	WRITE_ONCE(*entry, new_entry);
+	WRITE_ONCE(table[id], new_entry);
 
-	svm->avic_physical_id_cache = entry;
+	svm->avic_physical_id_cache = &table[id];
 
 	return 0;
 }
-- 
2.41.0.694.ge786442a9b-goog

