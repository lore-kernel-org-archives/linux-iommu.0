Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0832D1F61
	for <iommu@lists.linux.dev>; Wed, 11 Jun 2025 22:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749682046; cv=none; b=BFd6nyXpdTVNDYSrGqt1Zw52PIER9zcxsyc9kpWyWzzdyEmjdE7w4CQjJmA1hs1XO4AkxaD8TqIKwzz+y4zgJURnssdC235B42Kv3bH+wAR7es6RUJOSRhJPEVepCEXplMebFKOV5LXluXXG2NtdM4isDECx2YEO9tjnWf6hN7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749682046; c=relaxed/simple;
	bh=42cURYzNOSYVDWBQ0v/mU/h1dxNifaKTdnd5p1g+eHQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ADVakcxCwWH35iMsCO46C7WxY8kBWO6snL105F31Xggh+mIpbnJEsIgM6ltpvRrBvBDsgp+c1H/IYAHeGP53Vljd+sBI6v/KoM2AcFHghGdhbZ7Ir3ofYgrQ2KlDuoJV1b38XunJYzCyTWU+KACFmPbNxVlmEAzdS7EVLlVEYXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JI6LeHY2; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JI6LeHY2"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-31315427249so372135a91.1
        for <iommu@lists.linux.dev>; Wed, 11 Jun 2025 15:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749682044; x=1750286844; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=zSDDoR+RslpHc3sFyno+iStW5FaTxNYMSfnwl+S1QGs=;
        b=JI6LeHY2K5RrH0nj8ZroH/FToT6wvP94fetB7r1VkUqN1wh0mxr/NPeJHspNhDxqNz
         IJhxX1XUGIluc5EtJAe1ljFKnZnDodm+5HpP3Qa8gY4N5MyFLdqQ6OvYuhB51nrugL7n
         hGhFyMucf/xXJoPkuMuyWVN2tgHldzWmuES4GJByvs2jzbfwby4snaBrf5PrV+OnhAmz
         Ov7p+doRexZfgZcx+LwNlQFm5YVclFc7g89N0JBEt6oms5kUEGkTdZymZxn3zx1sDsqZ
         cTKsIU7Z5SREN63+egKkHe+JKs+sZEX0CT3Trpk1mrzuPVXENpTK/Wx+Ly7zgS1XAoT4
         qieQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749682044; x=1750286844;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zSDDoR+RslpHc3sFyno+iStW5FaTxNYMSfnwl+S1QGs=;
        b=jtdjyxjQQsaxoYtdTmMSoca1HjOObLfSjsZS7sdXKQqs2p8I9P3sfxjX2SEg2we5Iu
         AM98S1qWbeMbZrtab8wwPSJOFbYFPlwysDfVFzNQDSGZfUIqDW32ln7WfprMA0y2n7M3
         G68QSE5FIsqhH4RnzLCrYtQv7XvBdH1HS6qvy0SxykAXwdr9m9Jrm3JjainH0dORcCLI
         X6wIEExz8ORZNzbKrE+mVmdWc3n9npq5GuPTz94Va4YN9A5OknVyrPLrtDCbCxoUKAul
         5douN8AAra9gcEGWkKcZUePWBCVS63PA4bpMehBTtkapbagCbUOCf7ToUkGlh8AJsJyk
         84Dg==
X-Forwarded-Encrypted: i=1; AJvYcCX973culLD5u2XkF/hBeGMDQNlWiAKJxvTBENxW8S7aGXD/jI/h+W4mizU7L1hlGO/g8V7d0Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwzCS7M9BC/EenlrLL4nzOylmnJxKiJFooq0u62aus458wRuP/U
	Nuf/7xVBNwAwOYcgK8ULaj2xzj47U4/B14NUTSy0uk5LED/82C015jRdxTMikUZsx1mCa64hn5g
	U3//BVg==
X-Google-Smtp-Source: AGHT+IFW1CnJBjbF7Aa/vCphsUpZawH1JrjgBFuOplZJCnRAXG3kKQQQygDZU5VinjflvWeeW7y2BmvVPI0=
X-Received: from pjbsq7.prod.google.com ([2002:a17:90b:5307:b0:313:2d44:397b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2642:b0:313:2f45:2fc8
 with SMTP id 98e67ed59e1d1-313af1b2399mr7734150a91.18.1749682043833; Wed, 11
 Jun 2025 15:47:23 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 11 Jun 2025 15:45:19 -0700
In-Reply-To: <20250611224604.313496-2-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250611224604.313496-2-seanjc@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250611224604.313496-18-seanjc@google.com>
Subject: [PATCH v3 16/62] KVM: VMX: Move enable_ipiv knob to common x86
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Joerg Roedel <joro@8bytes.org>, 
	David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Sairaj Kodilkar <sarunkod@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	Francesco Lavra <francescolavra.fl@gmail.com>, David Matlack <dmatlack@google.com>
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
index a9b709db7c59..cba82d7a701d 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1950,6 +1950,7 @@ struct kvm_arch_async_pf {
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
index 9ff00ae9f05a..f79604bc0127 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -112,8 +112,6 @@ static bool __read_mostly fasteoi = 1;
 module_param(fasteoi, bool, 0444);
 
 module_param(enable_apicv, bool, 0444);
-
-bool __read_mostly enable_ipiv = true;
 module_param(enable_ipiv, bool, 0444);
 
 module_param(enable_device_posted_irqs, bool, 0444);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 93711a5ef272..f1b0dbce9a8b 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -226,6 +226,9 @@ EXPORT_SYMBOL_GPL(allow_smaller_maxphyaddr);
 bool __read_mostly enable_apicv = true;
 EXPORT_SYMBOL_GPL(enable_apicv);
 
+bool __read_mostly enable_ipiv = true;
+EXPORT_SYMBOL_GPL(enable_ipiv);
+
 bool __read_mostly enable_device_posted_irqs = true;
 EXPORT_SYMBOL_GPL(enable_device_posted_irqs);
 
-- 
2.50.0.rc1.591.g9c95f17f64-goog

