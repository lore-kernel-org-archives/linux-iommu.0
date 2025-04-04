Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370C1227BA9
	for <iommu@lists.linux.dev>; Fri,  4 Apr 2025 19:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743795623; cv=none; b=hWIk42OAKcG6CtxglhNL/OjanfnSrWm6H0t0bZ8c1EfN2CmnUmNjxux3E0UH3mnZ2HAiKVGUmeuzq9zLsqk620am9X+DqnfnzNETQNcUlvHKSGG7YymoJ7KV8gS/TvICvwf8P/We5qst/Z3XJoqQ7V23ap0nvvbOwmNClkAmF6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743795623; c=relaxed/simple;
	bh=ncnSIRMStjRgoaLxhUROgr9SOC8QWiUmuvo8MAqoaW0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MDeqEfqzC2o7XgST57DbqHXu1PEKagVS89kISzDZF/YhsLZF6XW9xNGij1Ayp89JAe15XE9NDgZJauGryZSh7wACqF1BiCKWopYJxdCvBxViUsd3UzK8xBk5rPa50OXBD2woabi6/ztIUyT0gsQwOTMgz/gZyi/k4Lw8hP01QS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mmf2Uk/m; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mmf2Uk/m"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-225505d1ca5so22058585ad.2
        for <iommu@lists.linux.dev>; Fri, 04 Apr 2025 12:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743795621; x=1744400421; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=VCMo/RGlrbOJASvtC7+TsYQlxqkzXA/5CTBjvXO9fqA=;
        b=Mmf2Uk/mB5JcaXjSAvcmUfVFdRnRkzvGmViRBw8miVzV1SRWqBhyq+Po4XkM7Z+qiE
         33ck2VPqRhdUfo3kcpPWGugo1M8sqL8igQ4qOVsVIljjiKOajYOar0hqIWolSv63ibTZ
         wFDwq2yt3x3mRwWZpvvnlFX0v4SxAIu5EUO92wrfC7ORrK4R3qnVEu30SbaGtVa0EyAm
         ZKpfAHW2yqu1289DKTy7J1mhOYtmbm08oLcXGKc5wWWR0rkwnuWRnWRLJ9arpBaBDCcF
         YlZT6FyxJNSXIw2elu0EW+x2cuBvbAMdvnTIrip0qD6dEgQT4HxxiFKOfxKrCWWzoeSj
         llXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743795621; x=1744400421;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VCMo/RGlrbOJASvtC7+TsYQlxqkzXA/5CTBjvXO9fqA=;
        b=b3I80X+DpnAEL+j+xdcuVpZgrLk+5vhs6A/R1chAUFOo373ELz/Vu5nlXFcHZFka47
         WVGDhVSqvAMGdKa+CVQhGnVJPstfE0dMbyF7qpKA6kLXGnzl6dun+aRURbGHQN0pRiS5
         WeApPVfz6UHkEyaR5SStRssuRU+bZrG5p8S2jPznL7xrsgq3AF6RbHs7KZ+5Xj16nBn/
         9CoSGUUBtXAW2diFTZNfvpy5PGLzfyAoICjNcKnMP0a+RU9jep57PHT697YbZiyysapF
         LNHoLd44gY6NQ9MgEU9fNIMBS0Kvy4cXnx3zoTmXkuDZkMhZ32GitOLcD5OXlreUBk0o
         xEzA==
X-Forwarded-Encrypted: i=1; AJvYcCWfoVRlIfmt7UCvx68Qip9hz37gEsQAFDhBwH+CIGXGn2mDW6T6/7Mk/Fl2bAzINMKwl5NM5w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyQNYFj+NyevURri+sHuieYDn4x9SWGBQ3FnN/OPvfA0zF1ApEi
	j6DKrMkpY68XeQUv5SO4LJDtXWFw6zM/VpMOJ+NK2mLmwjikeVCC4AeUkKsXyxapo/i96Yh+CrN
	itQ==
X-Google-Smtp-Source: AGHT+IE5XbiMqRGlDARtEBjYgWidaO1ecxsBHLfL544ofCTr9/DpC8oice4f7Zykt01Y3R60ZjSJF5IkHjo=
X-Received: from pfbbe6.prod.google.com ([2002:a05:6a00:1f06:b0:736:aeb1:8ace])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ccd2:b0:224:1af1:87f4
 with SMTP id d9443c01a7336-22a8a06b3d0mr64838025ad.22.1743795621644; Fri, 04
 Apr 2025 12:40:21 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  4 Apr 2025 12:38:35 -0700
In-Reply-To: <20250404193923.1413163-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250404193923.1413163-21-seanjc@google.com>
Subject: [PATCH 20/67] KVM: VMX: Move enable_ipiv knob to common x86
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Move enable_ipiv to common x86 so that it can be reused by SVM to control
IPI virtualization when AVIC is enabled.  SVM doesn't actually provide a
way to truly disable IPI virtualization, but KVM can get close enough by
skipping the necessary table programming.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h | 1 +
 arch/x86/kvm/vmx/capabilities.h | 1 -
 arch/x86/kvm/vmx/vmx.c          | 2 --
 arch/x86/kvm/x86.c              | 3 +++
 4 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 0583d8a9c8d4..85f45fc5156d 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1932,6 +1932,7 @@ struct kvm_arch_async_pf {
 extern u32 __read_mostly kvm_nr_uret_msrs;
 extern bool __read_mostly allow_smaller_maxphyaddr;
 extern bool __read_mostly enable_apicv;
+extern bool __read_mostly enable_ipiv;
 extern bool __read_mostly enable_device_posted_irqs;
 extern struct kvm_x86_ops kvm_x86_ops;
 
diff --git a/arch/x86/kvm/vmx/capabilities.h b/arch/x86/kvm/vmx/capabilities.h
index cb6588238f46..5316c27f6099 100644
--- a/arch/x86/kvm/vmx/capabilities.h
+++ b/arch/x86/kvm/vmx/capabilities.h
@@ -15,7 +15,6 @@ extern bool __read_mostly enable_ept;
 extern bool __read_mostly enable_unrestricted_guest;
 extern bool __read_mostly enable_ept_ad_bits;
 extern bool __read_mostly enable_pml;
-extern bool __read_mostly enable_ipiv;
 extern int __read_mostly pt_mode;
 
 #define PT_MODE_SYSTEM		0
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index ac7f1df612e8..56b68db345a7 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -111,8 +111,6 @@ static bool __read_mostly fasteoi = 1;
 module_param(fasteoi, bool, 0444);
 
 module_param(enable_apicv, bool, 0444);
-
-bool __read_mostly enable_ipiv = true;
 module_param(enable_ipiv, bool, 0444);
 
 module_param(enable_device_posted_irqs, bool, 0444);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 23376fcd928c..52d8d0635603 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -227,6 +227,9 @@ EXPORT_SYMBOL_GPL(allow_smaller_maxphyaddr);
 bool __read_mostly enable_apicv = true;
 EXPORT_SYMBOL_GPL(enable_apicv);
 
+bool __read_mostly enable_ipiv = true;
+EXPORT_SYMBOL_GPL(enable_ipiv);
+
 bool __read_mostly enable_device_posted_irqs = true;
 EXPORT_SYMBOL_GPL(enable_device_posted_irqs);
 
-- 
2.49.0.504.g3bcea36a83-goog

