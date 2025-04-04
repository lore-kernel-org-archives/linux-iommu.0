Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666EF223707
	for <iommu@lists.linux.dev>; Fri,  4 Apr 2025 19:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743795610; cv=none; b=OdV2uJK9Q0d92E9n0m3lB/uydN/Qprfs8THpEKd8N4GOO7pZ6Cu2wMykQAvVOvaDAggwibUpcJTxDaEmz7uHh7iTtpXbYKHidhvDVTNhc8JwQXhHA74ivF6EKDf3lY109aoJgPdkClXIHl8fKPoeyH2uzpfAZNoMnfrywOjKkzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743795610; c=relaxed/simple;
	bh=uzlVEbR4BTmFkBjn23KnqXJ/yIeZSAO1hkc8JxEHwWA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VVj7EcZH93dsBFFuL6avO0A6ETH6V0U8f8Vvuu+kNsvUme341b2eVl575pUvm+OHsstAOt3RiPFfd/5enbf6PWyqmvV621vzrNsG6ku0MAB/pDw4QiqKHG+jVN4SS+m7rMh8g8k0Md90acPff49ysr+QpEWs2A3ccgKmyf2Wd4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OESoQBaa; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OESoQBaa"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-736cd27d51fso2260407b3a.2
        for <iommu@lists.linux.dev>; Fri, 04 Apr 2025 12:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743795607; x=1744400407; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=8U7fbiDc3fD3nWCIa5Kamzu6n5Z7wqEoDo9I5vrK7FA=;
        b=OESoQBaa1FeRyS18HKunkJntRERqnOfP66+FUVZac10pphZR9Vc2l5FAJSrWtvQOXq
         jjXrL5jHorqrft80qi2jeMfb7uisbcxIwzyz2Gm4Jz5s0tDpvye+lo91olu4PI8dgudA
         6k2ECdhET+LQycfs/ePyF+9k3wev2PnP+ePzOqo9ng8rQgLr7Rh+4JIWq5S2yVDnq2LR
         s7lkCF1xI4mic3lhEriMboWotTc2nlp3DOUKS3oYS5GmtDiE0mKi3+EZDxExd8ZsqTyp
         TBNjr+guknBbQkNcFdKqcq/5kQwN6HUHZKalYj1tk7iTsEQ6nFxw0FFcjegPED2V6Bnp
         DXFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743795607; x=1744400407;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8U7fbiDc3fD3nWCIa5Kamzu6n5Z7wqEoDo9I5vrK7FA=;
        b=M4V4OkwPnQUSt905a2NRTudWtE7XVRg/KEwFPBeS8K8Yi89gxYNUeZPil5FvtPQKB0
         JqKjLjprTT6KCCqpnh9IsZvFRA2xXVd0DihgClFtrbIWgHMHBRS9dkV2wldVGNpXsgJj
         Rcg8ZOsCaigbfVoNANBGZaoxTTXD6C9iXTUjGfP4B2ELjI64Z8X8ver9sIk/TX7l1v7H
         2pbYKrmN+r378z6B8+mHxjC2rwixDiNUOnEYluMfiSOqHq9dWuP3apc3ZNRAv+Bd/dQD
         8fYNirtShU7S1LkkkxKsDqr5aafjVJ1gmzAXDDsFMJCh2Rr/YfSpEVcH8t5Z6n10upQM
         cClg==
X-Forwarded-Encrypted: i=1; AJvYcCVSslzFax+cLirIaD5BU26YrzOROvVyZp4JiNC+ydnqJIax9crYmin5jw7jZ4lNn5PT+/Ho0A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzjyySt2Ev0jgFEPK4e7ucyqN3saf3SWpY559lsCCZfi6xyjIXr
	f79ITxMTrctDApPGOTaBUp3IiW/boiPREa4XXIp06SY5bW5s0bToRprjUeZ1YZucNMLb5XOgy/V
	n6g==
X-Google-Smtp-Source: AGHT+IH1FWkdivy4S+bLPUdZ+zOkMlZOgSIPe0C8D80kAIF34VnktZoafbX6YO039dybyFyARTj7CbbGk/k=
X-Received: from pfxa1.prod.google.com ([2002:a05:6a00:1d01:b0:730:90b2:dab])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:561a:b0:1f5:9330:2a18
 with SMTP id adf61e73a8af0-2010801c42emr4738241637.23.1743795607614; Fri, 04
 Apr 2025 12:40:07 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  4 Apr 2025 12:38:27 -0700
In-Reply-To: <20250404193923.1413163-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250404193923.1413163-13-seanjc@google.com>
Subject: [PATCH 12/67] KVM: SVM: Drop pointless masking of default APIC base
 when setting V_APIC_BAR
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Drop VMCB_AVIC_APIC_BAR_MASK, it's just a regurgitation of the maximum
theoretical 4KiB-aligned physical address, i.e. is not novel in any way,
and its only usage is to mask the default APIC base, which is 4KiB aligned
and (obviously) a legal physical address.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/svm.h | 2 --
 arch/x86/kvm/svm/avic.c    | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index 9b7fa99ae951..9d3f17732ab4 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -254,8 +254,6 @@ struct __attribute__ ((__packed__)) vmcb_control_area {
 
 #define AVIC_DOORBELL_PHYSICAL_ID_MASK			GENMASK_ULL(11, 0)
 
-#define VMCB_AVIC_APIC_BAR_MASK				0xFFFFFFFFFF000ULL
-
 #define AVIC_UNACCEL_ACCESS_WRITE_MASK		1
 #define AVIC_UNACCEL_ACCESS_OFFSET_MASK		0xFF0
 #define AVIC_UNACCEL_ACCESS_VECTOR_MASK		0xFFFFFFFF
diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index e9ded2488a0b..69bf82fc7890 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -253,7 +253,7 @@ void avic_init_vmcb(struct vcpu_svm *svm, struct vmcb *vmcb)
 	vmcb->control.avic_backing_page = bpa & AVIC_HPA_MASK;
 	vmcb->control.avic_logical_id = lpa & AVIC_HPA_MASK;
 	vmcb->control.avic_physical_id = ppa & AVIC_HPA_MASK;
-	vmcb->control.avic_vapic_bar = APIC_DEFAULT_PHYS_BASE & VMCB_AVIC_APIC_BAR_MASK;
+	vmcb->control.avic_vapic_bar = APIC_DEFAULT_PHYS_BASE;
 
 	if (kvm_apicv_activated(svm->vcpu.kvm))
 		avic_activate_vmcb(svm);
-- 
2.49.0.504.g3bcea36a83-goog

