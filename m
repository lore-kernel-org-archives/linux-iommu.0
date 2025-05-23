Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B13823AE96
	for <iommu@lists.linux.dev>; Fri, 23 May 2025 01:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747962038; cv=none; b=fe8oPemZzBbUQ77Mf8x8aBCONir8KDYGyBOVcMFIkfu1noMlk4K1TQsKpcLhC/JwiQ+oh7Fd2gUxqDrxqUlh3qB/lR7xFiRlTkhdzBJv2z+eY4WZTB2fONXJiYcATWdyB0W86JYw4Hqehu7pBsuy0J3IVOvXTQNRS+PIUFvSKh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747962038; c=relaxed/simple;
	bh=dlp1owjlTB9Q2ZNdky6CeTiZTUsuxD6LWgF2OyRxR9k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dOQ6gI7hRIDnMaHm2VunrBQ1M5e931E0qLK401QFV+6CKHY/03gLK58CX3GOAsEFciVApMIUpDjjaHPTCCygj7yKSXa/YMjxL1QRy6B5oaXtK2RHS/wyh52r5jpFEAtzFMpoeDV23ep7GdWkQ4ejtfIquNOXKBWshJZats95h0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GqdfKFKn; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GqdfKFKn"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-30ea0e890ccso6054268a91.2
        for <iommu@lists.linux.dev>; Thu, 22 May 2025 18:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747962035; x=1748566835; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=8hYW+M1uoR4gCkeYUzndz4aHuf/uvwQq+NXGlsnTPHE=;
        b=GqdfKFKnxMDtzqj8lMBGZ4S4lhqRAspMJO/mMPKDw55wv4cvZ3vUIsZopmRdEyPGto
         hVAAmJxUcJb0EVAGXqRjyburnA7oI2b3Ci6eCLXulc+nXIV4QAAicDEulToV44U9k1nb
         U9vDqBjV4OoKtaRDPZer9GaYM5TngpOlvamjQhH/7mngvaIIoy4CV274q63iXn8T7O4L
         J3bQgJkDgWVou3y+e10WSX3i3YNM98Y5RijBH5AB+urxpKewRoHvMtYRC9v95PB/KIhc
         ru6jgmjgZ8H4wR71Q8KaTxEVUr6vgfiKXrPP5nrkkBbigmqT9BRbMePrXv75aaUKyV5m
         M75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747962035; x=1748566835;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8hYW+M1uoR4gCkeYUzndz4aHuf/uvwQq+NXGlsnTPHE=;
        b=REdufFfcRlCFp3OQsfmtaijFebIYyj3eIGYhhL9l47wzl7nUtHcOXwSTLKA9H2HlaF
         m60RN3KIgKtH4IwX1NZs/+tmiGXLmqzSEzcN1fTjalWKpXWpxqH+HpBKf4ltpMlOvlxG
         UW47FEPfAq69n1GXAuScIWs5N3bkTkHjbkvpb5qZFKLbzVmneqF0ojn7oNid8PUxRJ8/
         MDavwvPyYtzdn6vptjyNBlXCqgI4LsfV1tmZwDjjhm8MeLwFFNbfuIPZczyPCtcC1Xf4
         OSmFTttXNR59JOZwptCMypC7r4RtCZJGw4hcyvIEQ3VboH5oTu5Df9tde0NNLepP6oE1
         mk0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVxkUD6O9R6ulh28GmHRHh1VyIsLG0jZiY3GNkVA82+yjIEWm5D9XGHUm3EZ+QpFWHdytaC/g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxK06JNWnnn68D4xup/5Y6otQTs+Op47fHn9ua9KrIWIUBnLsng
	eneoi3hNBsKriMl6dwtvMOEd/nAdNbQEiIZDwyzu384LRGguFrFk81trV+a4hXVlReuGScfXB4q
	2LssUMQ==
X-Google-Smtp-Source: AGHT+IERiQoZPoEemihmVi9aR21C5+4ZWBIzokk0EnGUgkUK/kwxgXf2E6CpkLPTP/gednSgPST54I+bLEA=
X-Received: from pji7.prod.google.com ([2002:a17:90b:3fc7:b0:2fa:a30a:3382])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:a015:b0:30e:ae5:479d
 with SMTP id 98e67ed59e1d1-30e83216f63mr30402479a91.27.1747962034725; Thu, 22
 May 2025 18:00:34 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 May 2025 17:59:19 -0700
In-Reply-To: <20250523010004.3240643-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250523010004.3240643-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523010004.3240643-15-seanjc@google.com>
Subject: [PATCH v2 14/59] KVM: VMX: Move enable_ipiv knob to common x86
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
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
index 8a4662bc2521..b645ccda0999 100644
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
2.49.0.1151.ga128411c76-goog

