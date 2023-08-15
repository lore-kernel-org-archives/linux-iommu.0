Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D1C18B1A
	for <iommu@lists.linux.dev>; Tue, 15 Aug 2023 21:35:42 +0000 (UTC)
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-686e29cb7a0so6703930b3a.3
        for <iommu@lists.linux.dev>; Tue, 15 Aug 2023 14:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692135342; x=1692740142;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=SFpi+WGuvYcTqc5iutU3gDOga20tlCn0kmKYiGzba1s=;
        b=74tVcNm00OZaHpD1xVuPf4Jjj8KBDUlS++wNuw6IOr9Xww7JLEHfMfpDin20hyekXn
         UAZzdeOvKkgZUS6btGqtbj1EtOcbudgfP8uunjSwa10kl53dOsD2H4PMXQQ7CpyOKOA0
         fFJjtiO9IkGgau4YpenIfY616mMKNSNOk/KybhEQhb/R1OBjzFS1FxAE5sc0kRQ+eebR
         f+hPBPVTsmtcKA98ubnfVz6rHszpNxsmqCasREoyiC8y1zLZQWM3maIi8g+mst+1jtCV
         qq4sZhxyR+JYTtYagySkZoMNAZfN36FpIVb+Q3rAOdXkc6+JefuhcRoK+Iwm0FGQTYOH
         wB+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692135342; x=1692740142;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SFpi+WGuvYcTqc5iutU3gDOga20tlCn0kmKYiGzba1s=;
        b=fn9KQDEWxyog51w9XEr6znpKcBSg76JXBSwTdHDc6bGIkYRCgL8WkLxAV5G8FRJmI7
         HKBJgzFCSU/XT2rYm5qVqIj2gYcLC8P7hytGwl88Osd4TkP9ye1d+UaoWA5vFjI5H8LB
         jTZ3+Ok5NhCk5ZZYOq/O/kORfMS+xFdEkCZPbFzjSShzg/L98U5JJ5n3jWUF7tglUof8
         MR1zisHMwwUbnk+4YGcbjM7xMwCbqILbK2uDtsojX1v8Eanb6nk/ABayXm+17kxvUb9l
         Az1S9VPGf7yh0DikIxlO4LQ+IamDZM4TTfuf1y1Hk5FjIvZqrCBVf5ydFz81RRHeLwam
         35FQ==
X-Gm-Message-State: AOJu0YwBri4VfQcIBC+TJqkmXEFFo7NOCoceZVEa++JN+1VC1RQBZmYE
	ER3VGpF9CsEQRAs1lzfsKG6lTfzLmBc=
X-Google-Smtp-Source: AGHT+IG5MHzZLav8gJ1/MnkDQMEocS8Nk95fglVaOP6iG8M0zB5pJMu3CTRFZ48wrIVfKHX4OCFGKU3C7d8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:a17:b0:682:24c1:2951 with SMTP id
 p23-20020a056a000a1700b0068224c12951mr8029pfh.0.1692135342319; Tue, 15 Aug
 2023 14:35:42 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 15 Aug 2023 14:35:25 -0700
In-Reply-To: <20230815213533.548732-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230815213533.548732-1-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
Message-ID: <20230815213533.548732-3-seanjc@google.com>
Subject: [PATCH 02/10] KVM: SVM: Use AVIC_HPA_MASK when initializing vCPU's
 Physical ID entry
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Use AVIC_HPA_MASK instead of AVIC_PHYSICAL_ID_ENTRY_BACKING_PAGE_MASK when
initializing a vCPU's Physical ID table entry, the two masks are identical.
Keep both #defines for now, along with a few new static asserts.  A future
change will clean up the entire mess (spoiler alert, the masks are
pointless).

Opportunisitically move the bitwise-OR of AVIC_PHYSICAL_ID_ENTRY_VALID_MASK
outside of the call to __sme_set(), again to pave the way for code
deduplication.  __sme_set() is purely additive, i.e. ORing in the valid
bit before or after the C-bit does not change the end result.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/svm.h | 2 ++
 arch/x86/kvm/svm/avic.c    | 5 ++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index 1e70600e84f7..609c9b596399 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -285,6 +285,8 @@ static_assert((AVIC_MAX_PHYSICAL_ID & AVIC_PHYSICAL_MAX_INDEX_MASK) == AVIC_MAX_
 static_assert((X2AVIC_MAX_PHYSICAL_ID & AVIC_PHYSICAL_MAX_INDEX_MASK) == X2AVIC_MAX_PHYSICAL_ID);
 
 #define AVIC_HPA_MASK	~((0xFFFULL << 52) | 0xFFF)
+static_assert(AVIC_PHYSICAL_ID_ENTRY_BACKING_PAGE_MASK == AVIC_HPA_MASK);
+static_assert(AVIC_PHYSICAL_ID_ENTRY_BACKING_PAGE_MASK == GENMASK_ULL(51, 12));
 
 #define SVM_SEV_FEAT_DEBUG_SWAP                        BIT(5)
 
diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 7062164e4041..442c58ef8158 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -308,9 +308,8 @@ static int avic_init_backing_page(struct kvm_vcpu *vcpu)
 	if (!entry)
 		return -EINVAL;
 
-	new_entry = __sme_set((page_to_phys(svm->avic_backing_page) &
-			      AVIC_PHYSICAL_ID_ENTRY_BACKING_PAGE_MASK) |
-			      AVIC_PHYSICAL_ID_ENTRY_VALID_MASK);
+	new_entry = __sme_set(page_to_phys(svm->avic_backing_page) & AVIC_HPA_MASK) |
+		    AVIC_PHYSICAL_ID_ENTRY_VALID_MASK;
 	WRITE_ONCE(*entry, new_entry);
 
 	svm->avic_physical_id_cache = entry;
-- 
2.41.0.694.ge786442a9b-goog

