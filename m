Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F62322155F
	for <iommu@lists.linux.dev>; Fri,  4 Apr 2025 19:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743795630; cv=none; b=Yj3HoDlMDVBeZqDBvcl7YX5i+hIHT+/INy07XKDFMxZJ0bJfl8yBaZ/HiYBWxUXbkLVKVcVdPMmBg86LDGAMyMRbMsqwROKRjE7D0RnpHN0FJaJDjbqf8o1v68gIKhop3rVaGlrtG06VLRgW3RFI/iFur1zCKIIxE2Q/FGZXXWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743795630; c=relaxed/simple;
	bh=rV/TxCC8hJCF5joZAJwXSPguE6CTa8m1jVL3SS0Cme0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kzmjh03uboHZLZzq/5JP/QbHJLlV40CK5BRh7KIzaSMEMWdyhAaU59ZkaEwrFAixqsbe/fRcfYu7qs4ebwlTsqAxvCfvLWcPKSekAztapj1fVksf2Nd5TDEbaF9Ww56S6b5e48aX6hQvuo6MzmS9CEQkTOelUI288r4vcnfyaEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x1NpKnsp; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x1NpKnsp"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-736b5f9279cso2255742b3a.2
        for <iommu@lists.linux.dev>; Fri, 04 Apr 2025 12:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743795629; x=1744400429; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=sjXqQKjnqBAECPoVdGNanQSTET+5wQh3LMPwBf9sL3o=;
        b=x1NpKnsp57aJf+ckNs4QinieFM8rEHrsiJHvRNgR0uZNbohsxOv1Ob+vGAhuUa8n65
         avraxdHlbqh/rcwe2czz0MiZWoEr+v1Y2At5oQomMNVnCsYUvm1XGdrBJmiJJumMlN8u
         Y7S2VssumKJO2P7TtAxKEtn10u2o+M6fzRgdKlOO7jnELBFtkoea7OFbA2JtYvW/d7Ux
         GB243NZoXPbqkjrbmCck8FBZ+F2PAffixnxXTXW4ZE0tjT5yGB/DNTwN1+4Dgfosn7ne
         fGqooCyDZQFdOSJjlIw7nmcr7eMAzrf/7zZZ8aGj9FUkkCgutw0mwrX2qOMTTCgMACBl
         LQnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743795629; x=1744400429;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sjXqQKjnqBAECPoVdGNanQSTET+5wQh3LMPwBf9sL3o=;
        b=AVql/SKQw1Jnu2fOrXhnrA13+JlzVErs7fE4DptoWKuF1A56WswcCa1Pbva3CkoeYD
         hgZ7VJcml+2NM2y76xOMfObsYygkoKGCoYpV9NhHGKoq1aQjiTLYv7nDilwLICDo/xpG
         nws2tZQAVr3m4CPRQm1T9E48Geiruv5pjyIeRCR4k9k2oxWrDWA6KbchSuyNrgX4uHRp
         tN76+zPvFU1Fhz514TKi2o/aDbkAUoVoRK6elFOsO9o1uyUEgTynpGuC9Dj29ZwgT3KR
         foOkesu9JwSoKNZKpph3Pb94ul7Zov0IFEsXCyzLBo7W5IKs2GFQDPukNbOvcW+pyTSa
         J6+g==
X-Forwarded-Encrypted: i=1; AJvYcCV/gkOqc+L3JRYiH1MW+hphn5XzUof7529BG2fM9wk6kN+VhdVhEA7jzdxjbADQoGGuNeO3fw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz+wUpM4G/YNXDX4ZVUR8fj/+S5nQGccb4U+hGS3OaAdTETJJAs
	uN+AbBvZzVwAGUsvh+Aw7zQp/t8jtOEnNFekMT77iU/MKT1YLJZAOoVFnND5yKTCoPt+coR5jre
	0Ag==
X-Google-Smtp-Source: AGHT+IEUqaCv0aXLLYu+YUsh9QZmyBiS+o0qosR4x1hBOl7XnC5m3r8JWP1RCDtDT+Khu5sOogVzwMt6Cak=
X-Received: from pfbci5.prod.google.com ([2002:a05:6a00:28c5:b0:736:79d0:fd28])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:94c8:b0:1f3:1eb8:7597
 with SMTP id adf61e73a8af0-2010479b14amr7567439637.35.1743795628671; Fri, 04
 Apr 2025 12:40:28 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  4 Apr 2025 12:38:39 -0700
In-Reply-To: <20250404193923.1413163-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250404193923.1413163-25-seanjc@google.com>
Subject: [PATCH 24/67] KVM: SVM: Add a comment to explain why
 avic_vcpu_blocking() ignores IRQ blocking
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a comment to explain why KVM clears IsRunning when putting a vCPU,
even though leaving IsRunning=1 would be ok from a functional perspective.
Per Maxim's experiments, a misbehaving VM could spam the AVIC doorbell so
fast as to induce a 50%+ loss in performance.

Link: https://lore.kernel.org/all/8d7e0d0391df4efc7cb28557297eb2ec9904f1e5.camel@redhat.com
Cc: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index aba3f9d2ad02..60e6e82fe41f 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -1133,19 +1133,24 @@ void avic_vcpu_blocking(struct kvm_vcpu *vcpu)
 	if (!kvm_vcpu_apicv_active(vcpu))
 		return;
 
-       /*
-        * Unload the AVIC when the vCPU is about to block, _before_
-        * the vCPU actually blocks.
-        *
-        * Any IRQs that arrive before IsRunning=0 will not cause an
-        * incomplete IPI vmexit on the source, therefore vIRR will also
-        * be checked by kvm_vcpu_check_block() before blocking.  The
-        * memory barrier implicit in set_current_state orders writing
-        * IsRunning=0 before reading the vIRR.  The processor needs a
-        * matching memory barrier on interrupt delivery between writing
-        * IRR and reading IsRunning; the lack of this barrier might be
-        * the cause of errata #1235).
-        */
+	/*
+	 * Unload the AVIC when the vCPU is about to block, _before_ the vCPU
+	 * actually blocks.
+	 *
+	 * Note, any IRQs that arrive before IsRunning=0 will not cause an
+	 * incomplete IPI vmexit on the source; kvm_vcpu_check_block() handles
+	 * this by checking vIRR one last time before blocking.  The memory
+	 * barrier implicit in set_current_state orders writing IsRunning=0
+	 * before reading the vIRR.  The processor needs a matching memory
+	 * barrier on interrupt delivery between writing IRR and reading
+	 * IsRunning; the lack of this barrier might be the cause of errata #1235).
+	 *
+	 * Clear IsRunning=0 even if guest IRQs are disabled, i.e. even if KVM
+	 * doesn't need to detect events for scheduling purposes.  The doorbell
+	 * used to signal running vCPUs cannot be blocked, i.e. will perturb the
+	 * CPU and cause noisy neighbor problems if the VM is sending interrupts
+	 * to the vCPU while it's scheduled out.
+	 */
 	avic_vcpu_put(vcpu);
 }
 
-- 
2.49.0.504.g3bcea36a83-goog

