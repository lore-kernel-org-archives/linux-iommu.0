Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A667216E23
	for <iommu@lists.linux.dev>; Fri, 23 May 2025 01:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747962021; cv=none; b=J/Irli3Gg1noC72bSBjD+u817acVIwLvAvFmmKB5drHmUFtf2nE5RNib0BMOvePtK2bfaWbp+bKisMsOhiX+OYTb+9ZlPZZbiy0VttFFwRkQzOG1TMCBMpwpMK9Qq+GEXAIXYL2tDpxdGwy73GbGAjnHGlwE/Uc49mhLFviQ2iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747962021; c=relaxed/simple;
	bh=xtpaD7HVsJFlh7tiOLocGEu9Ud8v7ZkKhAZvNZl2KIA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ICxaLlry4TWuxV006LkwGWdNnR2xwttok8QM3Uhez+T1pWg+rfypFw30a4tjhL2sgjHATNgKUw3k+aS5sdfjVaUHjyyx0/paxRDrewGJvuQRRcgGgpXB75qsvuGZBv8kpvXrlmBBg7p3kfJ+XS4/kg6XjLwGNOnzw9f6e3VZPQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bu57hg4+; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bu57hg4+"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-742cc20e11eso3918409b3a.1
        for <iommu@lists.linux.dev>; Thu, 22 May 2025 18:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747962019; x=1748566819; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Y8ehtQMuf6IARUqP5Cyf64+dJov4SLh6VlRU3VKIIQ8=;
        b=bu57hg4+w+debKwQTguGPwaEq11q2pGDrnAlz0DURZFjvToUmPr6k6qVaVOXCV9PCd
         nQ9UVFTkXS9f7Yt1eruUJIe8lshAIz2a+tZhK23io/ZSc+eOcF5EV+JigXf+0hhx2VnJ
         mSeDZUO9hiv5R3M6VFZMgAcIRB682vllQhaR9HiAHi64BhCjBNT+a+xXfthL+tfJ3aQV
         NX4ot9XPaByoFR1UpmdMWEEim3Y7J3KIgdOwu+JNL5DMPlLaaT3CiVZSB8XxNAph59cQ
         cKFld8jW3s7LivGFX5/NM9v/N4hc8FJa6GUdPcdupdGk/a0dZfCKP1FmCcc6irOX6PQe
         23NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747962019; x=1748566819;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y8ehtQMuf6IARUqP5Cyf64+dJov4SLh6VlRU3VKIIQ8=;
        b=ZSVzumPWPELyaxdiQxPadXzF4UFtor+CPk4zoRHIA02Qw8OkRAoZkViTW1YV2zmJXh
         sVcxr59IMgbMQBVcKqMxqfQKnQsss+wmVgyrJKxg0fGi1Ywl58bEhMHlwu6GLgxC92Zk
         AdbxENJmUnyiaBo8FIL7uElQsCNGSZTsLG8TIx0y71cYs1nZggaS/U0Nv7qKSelf743P
         cPBEc0hc0Aq1xnAzlOn5D49r4MYTM7lLyTlYYdVA/jOL7PWigpurwLSQtjcAlo8YeFK+
         9U72CNaVQ+BmDtOBGR3/718b5Pjy5EOD5M6sdcMMRcHb9Fwx806iszCUXb5NlDeDnIDi
         lXhA==
X-Forwarded-Encrypted: i=1; AJvYcCVJrzMrYDBRwfHG2/oWSgv+3EoA+UbK5rHhC0NmwZ3ND8FmWC4E9aH8lzhuNjkHu+896Kw08g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwNvfl8A3b20tdtX7jtWVFu0amPORrcIeikm1T6T/EvZruMAM0B
	OZCsbH+uTROaPe1NqTqIYA7GfHzoV7pKFPxlss7rZ+WFMudbxDmq6pufNGwOposxPynXZTMBPtG
	OtBvvzQ==
X-Google-Smtp-Source: AGHT+IEHm61pElXc5o66L35Mfu9cWxQa9x3UMSXO1VOYhFDjyuiVflcnZ6ZC6JzEj6wH5WWXGFCHISdtxs8=
X-Received: from pfoi12.prod.google.com ([2002:aa7:87cc:0:b0:73e:665:360])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:9144:b0:736:4d05:2e2e
 with SMTP id d2e1a72fcca58-742accc2342mr33071193b3a.6.1747962018848; Thu, 22
 May 2025 18:00:18 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 May 2025 17:59:10 -0700
In-Reply-To: <20250523010004.3240643-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250523010004.3240643-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523010004.3240643-6-seanjc@google.com>
Subject: [PATCH v2 05/59] KVM: SVM: Delete IRTE link from previous vCPU
 irrespective of new routing
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Sairaj Kodilkar <sarunkod@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	Francesco Lavra <francescolavra.fl@gmail.com>, David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Delete the IRTE link from the previous vCPU irrespective of the new
routing state, i.e. even if the IRTE won't be configured to post IRQs to a
vCPU.  Whether or not the new route is postable as no bearing on the *old*
route.  Failure to delete the link can result in KVM incorrectly updating
the IRTE, e.g. if the "old" vCPU is scheduled in/out.

Fixes: 411b44ba80ab ("svm: Implements update_pi_irte hook to setup posted interrupt")
Tested-by: Sairaj Kodilkar <sarunkod@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 4e8380d2f017..c981ce764b45 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -861,6 +861,12 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 	if (!kvm_arch_has_assigned_device(kvm) || !kvm_arch_has_irq_bypass())
 		return 0;
 
+	/*
+	 * If the IRQ was affined to a different vCPU, remove the IRTE metadata
+	 * from the *previous* vCPU's list.
+	 */
+	svm_ir_list_del(irqfd);
+
 	pr_debug("SVM: %s: host_irq=%#x, guest_irq=%#x, set=%#x\n",
 		 __func__, host_irq, guest_irq, set);
 
@@ -883,8 +889,6 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 
 		WARN_ON_ONCE(new && memcmp(e, new, sizeof(*new)));
 
-		svm_ir_list_del(irqfd);
-
 		/**
 		 * Here, we setup with legacy mode in the following cases:
 		 * 1. When cannot target interrupt to a specific vcpu.
-- 
2.49.0.1151.ga128411c76-goog

