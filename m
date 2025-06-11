Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBB82EAD1E
	for <iommu@lists.linux.dev>; Wed, 11 Jun 2025 22:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749682102; cv=none; b=K/Ya6T6ywz98jIQpkTgXtb0pmxNBF1QrSQxqWPXh8hyJ/NqqxYsMl1WczS7YDIZ2THRUy1Tg+spGd0MgvmsEzkrY2OgNT0cfBR3LZTFrQNCUoL/76eFKfZ10CYSEBH8/EgQHdrx+59r8Bpf+w1fWCLDp5Q46uTmtjjizYwmLdGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749682102; c=relaxed/simple;
	bh=CDdmw6dFL6wn+8FcljdzaGx8a8PnN2FcUrIylCf+kXA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AZhUIYnbLHScbU5wmxTgsbWQW4tw5aiWvroId2qFU8dYRnmAnIptsHnUSabH/hpKHLiWPivV8EGWZWW6VNvNyHZyj+6GQ84XiKX+rXSjVJ/UFZOMSI5fXaTJ5JI/P/oNtJ6drmSXHeLpvYft4E0c4XNkbPa+4lEoiOhMU6BJ/+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HN6rAomq; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HN6rAomq"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7398d70abbfso375789b3a.2
        for <iommu@lists.linux.dev>; Wed, 11 Jun 2025 15:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749682099; x=1750286899; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=PBmMQxjdJ9cFQvfjWX4n11ei39HpxV6UN/bk9QZ1bLc=;
        b=HN6rAomqBoJOnmK7bo1qh74XARh65hAY4zv2qMOsbx5IU3lnR3v9a9xpCQCaTeyRoO
         73giR5z8NIXkW5e8FPhChKsTTlbE3SG+NjQXT4tv5Z5ovyOUbqYm6ByLaFeECCPWR8hf
         yYoiFc8uBsAPvhgXWJyl0SGqyNs9YHw10gCHJ2VixS/92pjBWLF1cwockqo89nV6CScX
         NfrcPGzhwb9DLN4339qxBFP6ptuqVhTi0qI/NxlYr7V1f86jlRwiwIb9i8Np7RiH1862
         ASmazr0cNxrhEmJtBOJQamFnj0S0dbh0S9ihlF1jaFEA02MH6/cxRS8KiaK/aHQmLZnw
         /+xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749682099; x=1750286899;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PBmMQxjdJ9cFQvfjWX4n11ei39HpxV6UN/bk9QZ1bLc=;
        b=Iza+0+0/bUYw1xmOAWwFuDi6ThckkfwvgG87gjYmzOpHweM9/IBORs7U2FXEaMXmxm
         cQn45ziSXiy8GBOBDjpPvAZLyL46qpLPAxU0LFpcxZEn2qj3wOoO6YgTj9QW9clarsRb
         yZErpHKGJgWPiJ2v/8ku3XDb7Ke2NEIpDTrUXAX7ag2fQ+Tca62mpQeuedraCe1UQW3f
         mnS+rQhAY4thQQ8g0Vs3MiCXRrN5QOJCRKA4+5UDlNqWPcbCxqW4qurMzzaxLV7NMoq9
         CDF/Ct96poVrsO5BOmrjlDq87Eb8o6W24gewVCLsE47FCHkoETZIV0iRcfPFCbP59Ssi
         2f/g==
X-Forwarded-Encrypted: i=1; AJvYcCWu+tudL7conw0OTZ7KxKtrJGCHkiKsgxd5kkikqeby2d4H8X5/T7Etzb6T48jUIysW0Dz+Xw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxv/mmDvCdyLZk+/MMdUaznsL9zdthLkepq2Cs0gx+w7ALDa5Jb
	ckRkazAJHf2ZCSsApAshvVpjWLqynSLlAf6EBuI2PzkSduNtlyKhyV2hNUU3iH6zHtdlMScTcUR
	G8yO0nA==
X-Google-Smtp-Source: AGHT+IEBM47Uz2X6xS0CCAIos8ahR8hfvX5maaZpinfB8zlXBAyKSgRG4LiJD4Zyz26rgc00CLciKxSYoFk=
X-Received: from pfbk13.prod.google.com ([2002:a05:6a00:b00d:b0:746:21fd:3f7a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1387:b0:73e:30dc:bb9b
 with SMTP id d2e1a72fcca58-7486cb721aemr6046845b3a.2.1749682098847; Wed, 11
 Jun 2025 15:48:18 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 11 Jun 2025 15:45:51 -0700
In-Reply-To: <20250611224604.313496-2-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250611224604.313496-2-seanjc@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250611224604.313496-50-seanjc@google.com>
Subject: [PATCH v3 48/62] KVM: SVM: WARN if updating IRTE GA fields in IOMMU fails
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

WARN if updating GA information for an IRTE entry fails as modifying an
IRTE should only fail if KVM is buggy, e.g. has stale metadata, and
because returning an error that is always ignored is pointless.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 24e07f075646..d1f7b35c1b02 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -834,9 +834,8 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 	return irq_set_vcpu_affinity(host_irq, NULL);
 }
 
-static inline int avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int cpu)
+static void avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int cpu)
 {
-	int ret = 0;
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct kvm_kernel_irqfd *irqfd;
 
@@ -847,12 +846,10 @@ static inline int avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int cpu
 	 * interrupt remapping table entry targeting this vcpu.
 	 */
 	if (list_empty(&svm->ir_list))
-		return 0;
+		return;
 
 	list_for_each_entry(irqfd, &svm->ir_list, vcpu_list)
-		ret = amd_iommu_update_ga(cpu, irqfd->irq_bypass_data);
-
-	return ret;
+		WARN_ON_ONCE(amd_iommu_update_ga(cpu, irqfd->irq_bypass_data));
 }
 
 void avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
-- 
2.50.0.rc1.591.g9c95f17f64-goog

