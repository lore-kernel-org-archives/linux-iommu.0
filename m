Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D9B23ED52
	for <iommu@lists.linux.dev>; Fri,  4 Apr 2025 19:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743795675; cv=none; b=IEOweKuMCjP+P1TSPH1lsS/7dbZ/BUjai2I3q3ywF4MQZD2x9cjOLV7Y/PkqrcVnhQhCgwtX2rPawpzgqoa1xs35kHo5ENrk9C84gX86aSNyeBQqP4oa4Lvl4VmYrrv28BN8E9OjxZUp632oR5Lzxjh5eW96XkQoJP/4+AUzdCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743795675; c=relaxed/simple;
	bh=3h3/C9YU3IZR0FXEihfejCqK39egcENO1wsqs30Mu1Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Dc0DwNzRSrgIxxYlxpqF52Kv2xBYxYV92zQEUnfn8zb/nzwhbBFwfb3SrIJPRmBNHXOmZrbRkBYZpJhQejXO9brZgFtg7O/by9OAb9nwyYMO8zUEPEMd7nNpe0LmA5sA64lbdvFdxobS3Bw9Iv16pWz35NRm9HZWUGe3d3/Jy3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lTjTqWjE; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lTjTqWjE"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2254e500a73so18988625ad.0
        for <iommu@lists.linux.dev>; Fri, 04 Apr 2025 12:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743795673; x=1744400473; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=uuRDDxMTWx+BF71z7vaA3qXiBqaodPZrLAgFj2n/0Bs=;
        b=lTjTqWjE+AOI5OG9n7bvM9UoZD2Fy2BNZ+uisvisUqih1GYpRExVS6tXqSaTANg7FV
         HJONexS4ssg5OzfKNrondfD/8ikEG/oxBmBIeImrGKrwSjJDwNty5765z80viHgbm10E
         XMSSz46l+M6EqPlykANOhQmBd3rD3sWY+q7I5OnFB7XDAAsVwlF++dnSSYrzQabQrUw2
         6uUF3EcfvQf/M8+aCuEbHs9uEAQNwyYgWkPFSwbC4UE5kot0JcUgnPKOse7MOcjVxEuo
         DketwKzKaJRb+SRRNdMDbNl4SJMmdptsP5A2W6ZADkg/qvWX8r9DKyml5vdKKFqhlpiz
         jCHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743795673; x=1744400473;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uuRDDxMTWx+BF71z7vaA3qXiBqaodPZrLAgFj2n/0Bs=;
        b=uIa6hn4cmadmW4DMR1jHbfkNA5QaUJ+Xql6dIIexFv6Gog7m75UwQGl45fo4CVAXfl
         UlrhJznYt4KsewMc6xwvNVhuAXtn27aZVH1YHOtELBLe9jDG7bUHP66sK71+Jn5CukTv
         W1Ehk5Y+POXUhkY/uFSP9hcbBABaudRg477P1qYiBezSGcGoW0XuwZ5v/St++UQpGe8G
         /H/I/opkwjC+MSP3ZTXff7dENX09ZzHZnuUBm0rLwZqvtMK4RVaS0p9AlLvbRQgu++lw
         mBayBKCUp9phLs9WxX+OHi3spUEz7yzHXMalN1p9ypo/DML+05Eh2FeikX4oAQ/er/vB
         /6Yg==
X-Forwarded-Encrypted: i=1; AJvYcCV65zE+XRhEIXmtMk9H3MQVxSCHXoe6rhJ+UE94yWg0Rq2e8Bd4UaubJ4plMQ4FdMQWt0/qCA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxaLeX7q5mw9dO/BmxgO4oK7VoJZRlObAInQXP+77wvJ7sTSFpu
	SlmR4jo9IP/zyI3pI1kO5DESuM0l7pYRiiWioEO1p23D8JE/BxfXdkqVA6gryGF6n3CuBx98jCF
	afg==
X-Google-Smtp-Source: AGHT+IFSp8K6EjfmJQcrgpgFBVLlZAq7RswmqqBmwpyX1fWpzhgHdhXeMKdwMt6K9nj4ZqJ5N5KBfrQfg5c=
X-Received: from pfbfd38.prod.google.com ([2002:a05:6a00:2ea6:b0:736:9c55:9272])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:230f:b0:223:517c:bfa1
 with SMTP id d9443c01a7336-22a8a0a3a59mr56780835ad.38.1743795673360; Fri, 04
 Apr 2025 12:41:13 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  4 Apr 2025 12:39:05 -0700
In-Reply-To: <20250404193923.1413163-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250404193923.1413163-51-seanjc@google.com>
Subject: [PATCH 50/67] KVM: SVM: WARN if (de)activating guest mode in IOMMU fails
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

WARN if (de)activating "guest mode" for an IRTE entry fails as modifying
an IRTE should only fail if KVM is buggy, e.g. has stale metadata.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 620772e07993..5f5022d12b1b 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -733,10 +733,9 @@ void avic_apicv_post_state_restore(struct kvm_vcpu *vcpu)
 	avic_handle_ldr_update(vcpu);
 }
 
-static int avic_set_pi_irte_mode(struct kvm_vcpu *vcpu, bool activate)
+static void avic_set_pi_irte_mode(struct kvm_vcpu *vcpu, bool activate)
 {
 	int apic_id = kvm_cpu_get_apicid(vcpu->cpu);
-	int ret = 0;
 	unsigned long flags;
 	struct amd_svm_iommu_ir *ir;
 	struct vcpu_svm *svm = to_svm(vcpu);
@@ -752,15 +751,12 @@ static int avic_set_pi_irte_mode(struct kvm_vcpu *vcpu, bool activate)
 
 	list_for_each_entry(ir, &svm->ir_list, node) {
 		if (activate)
-			ret = amd_iommu_activate_guest_mode(ir->data, apic_id);
+			WARN_ON_ONCE(amd_iommu_activate_guest_mode(ir->data, apic_id));
 		else
-			ret = amd_iommu_deactivate_guest_mode(ir->data);
-		if (ret)
-			break;
+			WARN_ON_ONCE(amd_iommu_deactivate_guest_mode(ir->data));
 	}
 out:
 	spin_unlock_irqrestore(&svm->ir_list_lock, flags);
-	return ret;
 }
 
 static void svm_ir_list_del(struct kvm_kernel_irqfd *irqfd)
-- 
2.49.0.504.g3bcea36a83-goog

