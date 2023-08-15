Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0194418B1C
	for <iommu@lists.linux.dev>; Tue, 15 Aug 2023 21:35:54 +0000 (UTC)
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-589ee10d363so26242257b3.1
        for <iommu@lists.linux.dev>; Tue, 15 Aug 2023 14:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692135354; x=1692740154;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=PakTUVCPT5RglwMpqqLace7eQ/bk2K7iwBZe/rVtlVs=;
        b=5rLK6uTTx0ExsbLfIixDo7od8tbQaS4kXbrmtgrAvOiSx66zMkL0PbeN8cCO3GmcET
         rQfJDOFy2SKfMk/vtb/AALMSNoJTG5bAo3AKUoAhK76FiiD4f5wBluvY/NmVU7/Knp5X
         4jsJimcYPRNr/ZLa/k+ME8OQVgCjtP7dLlMplcjjToWJxQ0vWbi5zYk08mCd+/wOf53g
         KCYyjN0tRxykyQUuNoQK/Y7V23OE4vuYeccDSAAnIMA5ucLUapfi/t0Md05tZ9Q+D1V6
         0vWqH9BF/OC4Ce5aKiKt3s+fHLlyZQlzkrwwYYImjSrE61q9wggw7dmrXCp77o0mh3Vz
         Kgjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692135354; x=1692740154;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PakTUVCPT5RglwMpqqLace7eQ/bk2K7iwBZe/rVtlVs=;
        b=eeqaxeMgNlCldZ8NXjsDnfz+ZNKJW+Ka9EPiAMEyM/ECQ9PES9iAM5oVzXkGpb1OuM
         jNM7jzhhj6nhOrT4cQMzLJ71cpbh4QAc9ZoQEGJU9EwYglUJWDVwSuMd22rAmIBAZgdr
         14972yHPFmCYU6Y4Xre8s4kSp2neilDZVduzGxCpNXK3iHv553qTKErYU1oU9kawRhT1
         827DgBZbChuwu2TKb8f6fPNX3Udu4ft5i/Akb/qbhfIO9wqK3RKAQ6tJkx+N5rG2t3/D
         8dA4Gqi5LN2XWbCSw15NdYBXPyanDGKKPFwD8/56wuZpZhd7KYK0yZwUlRExTQn/r6LR
         q+OQ==
X-Gm-Message-State: AOJu0YxlAMqkIydOW3gdkC21i6w8FFydb32CHFcq1GEtA6Te71j5MeJB
	2QthlYcA0zpvqEal9uQSsFfMfc8eXdw=
X-Google-Smtp-Source: AGHT+IHTFzi+EmSO3knDI1gLm28+MBww8MUDQX629AwYVZWFBhP3uZRswmmdR81NdMuUAnbgxq8ugbnzpzU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:ab08:0:b0:c61:7151:6727 with SMTP id
 u8-20020a25ab08000000b00c6171516727mr23ybi.10.1692135353782; Tue, 15 Aug 2023
 14:35:53 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 15 Aug 2023 14:35:31 -0700
In-Reply-To: <20230815213533.548732-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230815213533.548732-1-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
Message-ID: <20230815213533.548732-9-seanjc@google.com>
Subject: [PATCH 08/10] KVM: SVM: WARN if KVM attempts to create AVIC backing
 page with user APIC
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"

WARN if KVM attempts to allocate a vCPU's AVIC backing page without an
in-kernel local APIC.  avic_init_vcpu() bails early if the APIC is not
in-kernel, and KVM disallows enabling an in-kernel APIC after vCPUs have
been created, i.e. it should be impossible to reach
avic_init_backing_page() without the vAPIC being allocated.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 522feaa711b4..3b2d00d9ca9b 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -300,7 +300,7 @@ static int avic_init_backing_page(struct kvm_vcpu *vcpu)
 		return 0;
 	}
 
-	if (!vcpu->arch.apic->regs)
+	if (WARN_ON_ONCE(!vcpu->arch.apic->regs))
 		return -EINVAL;
 
 	if (kvm_apicv_activated(vcpu->kvm)) {
-- 
2.41.0.694.ge786442a9b-goog

