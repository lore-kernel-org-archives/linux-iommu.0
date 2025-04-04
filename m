Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698DA22E403
	for <iommu@lists.linux.dev>; Fri,  4 Apr 2025 19:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743795650; cv=none; b=q/nP62fFBf42y/APl14LsS5p0tHsz+MSTX7ioEEQTEXCW/5E1HQm1gEe+u17MMp1sM4jDOh0Tl1B99HHXM/gRCKifnDDu2GvdzfvXi7t1Y7gyzbUxKBkIpXU2yk9Rc3F+KOy5Lt2vm0WL9A9vcSOxaH2Y2H7KVhctGaGGSGws5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743795650; c=relaxed/simple;
	bh=IzCJp621ChpF3CQ8d6txaWCGos/Pxg81tWUUPEDnhso=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TM/5OWUOLmJJ7Ubnqp11AiEHqIMN5QGFUh1kVUUpHhNEQE//yzeRPCF/oIQbyJBxZPInsjztAmioag0Mk46UJgU2Esop+UJZvRlHOmFW9Kx6baOyeQNcrCEZQRNnUQWJNzMmO6j4L4IJP36x2i7HtVXC6EYZ5KnrgDDKQQ5OvyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vmeP0W1o; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vmeP0W1o"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-af972dd0cd6so1649025a12.1
        for <iommu@lists.linux.dev>; Fri, 04 Apr 2025 12:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743795647; x=1744400447; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=KYDMvc/wv5loDVXS9Aa0v44uXiIbogLzadPCYMuhYAo=;
        b=vmeP0W1ofXJEyOhjJ/pG68rhCuMKHpzWFSys1zzjAGHu68jl2jtyzNkMSMKwEShjMq
         RDkXxqrqNOxiTvhmdsS+sMEBGmwdnsM3xyv3q8NOHhqbBqkdg+dymnrFa+NW+5k7RfkY
         guBDI7X6+DO9WMkpDGC9pcnOxPEV7/lO8cJ8r32FxpvxH+ha+FlbiSit0Lv2M2XUNPSx
         1gjs4dw1wRGNNrSr9P7oUB6YUSQZX8/9qdheSZa/wnTxjWpAPu1loNBDrJR/xifQVVaZ
         qFRjogsKXWUJGd1rvWUw2d92QMUztZKZaj7nOF9zwJwVz2iZx89R/c/vkKOT51dkvwD+
         VF9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743795647; x=1744400447;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KYDMvc/wv5loDVXS9Aa0v44uXiIbogLzadPCYMuhYAo=;
        b=IRxtMe401ssvLdK0KOtEgBKtdlYVkxKR7T/rSyDfv/A+ZpR+Nt+5962g+2Ko2Di3ET
         iukS3s+ZOkgbBpobWTvxNGbY61sH+IKiXkh3rMfOf/WAb6VyYEMUFo5SZr+vxPlz7yE2
         KcZGeOQBFz1djQgAIowtyidR2DUBOxaK7LZ25X4i7IcJRMJFwZfbkkRwhTQdvVRstaPk
         tynStjtb4+cDzjJVkZgQIqIjxm90gZFpPa1wOzwpJ+AiOaQV5HNZOUGWpm9+n8Gm+aX1
         Ur1sunaDJF4GnFyP18Nm15uYTF7zF2297vYSRgKM4ZptzaHgTPhN+S3na9A1iRUClUgs
         F9pw==
X-Forwarded-Encrypted: i=1; AJvYcCXQqAyyFmPi6W6Kz+Q57xSovy2Tvi6pDu8NykxD88cWKmvQ4V21WaGcqEs6GZnN6WEcHrRm/Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz8dncRt7yNw1GtzlcJYaMlsDNeFvk9zIS6it4iNyHaCw1Xz0sn
	8D9YK+YEwFN0+/B3xvOm2zygEIWBPulIYkj7U3Pp6SZC81IUrAChEfT+/gytSshDbvG+MHiq0Sq
	LPw==
X-Google-Smtp-Source: AGHT+IErXqsvd0WDpARxVffQQIxJmZ1gHBUNSi2cCsl6CNRLxY8uKCXZMQn+YonfMwuOH2OZCDTOEAintT4=
X-Received: from pfbay40.prod.google.com ([2002:a05:6a00:3028:b0:730:7b0c:592c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3102:b0:1f5:80eb:846d
 with SMTP id adf61e73a8af0-20107efed2bmr5565765637.10.1743795647339; Fri, 04
 Apr 2025 12:40:47 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  4 Apr 2025 12:38:50 -0700
In-Reply-To: <20250404193923.1413163-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250404193923.1413163-36-seanjc@google.com>
Subject: [PATCH 35/67] KVM: SVM: Clean up return handling in avic_pi_update_irte()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Clean up the return paths for avic_pi_update_irte() now that the
refactoring dust has settled.

Opportunistically drop the pr_err() on IRTE update failures.  Logging that
a failure occurred without _any_ context is quite useless.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index dcfe908f5b98..4382ab2eaea6 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -817,8 +817,6 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 			struct kvm_kernel_irq_routing_entry *new,
 			struct kvm_vcpu *vcpu, u32 vector)
 {
-	int ret = 0;
-
 	/*
 	 * If the IRQ was affined to a different vCPU, remove the IRTE metadata
 	 * from the *previous* vCPU's list.
@@ -848,8 +846,11 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 			.is_guest_mode = true,
 			.vcpu_data = &vcpu_info,
 		};
+		int ret;
 
 		ret = irq_set_vcpu_affinity(host_irq, &pi);
+		if (ret)
+			return ret;
 
 		/**
 		 * Here, we successfully setting up vcpu affinity in
@@ -858,20 +859,9 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 		 * we can reference to them directly when we update vcpu
 		 * scheduling information in IOMMU irte.
 		 */
-		if (!ret)
-			ret = svm_ir_list_add(to_svm(vcpu), irqfd, &pi);
-	} else {
-		ret = irq_set_vcpu_affinity(host_irq, NULL);
+		return svm_ir_list_add(to_svm(vcpu), irqfd, &pi);
 	}
-
-	if (ret < 0) {
-		pr_err("%s: failed to update PI IRTE\n", __func__);
-		goto out;
-	}
-
-	ret = 0;
-out:
-	return ret;
+	return irq_set_vcpu_affinity(host_irq, NULL);
 }
 
 static inline int
-- 
2.49.0.504.g3bcea36a83-goog

