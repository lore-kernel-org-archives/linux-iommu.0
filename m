Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57444219A90
	for <iommu@lists.linux.dev>; Fri, 23 May 2025 01:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747962072; cv=none; b=DnS4FK0WPlK/6yjwrfQx0AW1hkJS5bz2GVpHLzJAbmgnv3fzu74HnBMpoWP/Rl64lWUW+M07ABhNXhVbitCR3cNtH7xDk2eQTgSLQk++eJgXhCz09Np0uZi7ZBP29h5Myn9QBNSh+M4Jg0eksDwqdM00TDzOfL29MiA60I38Kvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747962072; c=relaxed/simple;
	bh=rr28ytoqBfvrEIg2zljySxOCv3GKwF/AvjFSbsb8WHQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U64w95kZKSZMGUD15bITOcfXOGvhzwKHNU+Uh6hsnf49COdl+679STJ/r87elKagnbqgW5xTR9eMegTkLx+o1PjUkZ1ouEHsfXSJhJBy+JCDG3wFs/tvICtgqBSTuv5zu8a0ZcW4toCCGsnkSzpEZOe9mJfc7O+ogNfyiS0GQTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cuUH5tmj; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cuUH5tmj"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-310a0668968so2255155a91.0
        for <iommu@lists.linux.dev>; Thu, 22 May 2025 18:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747962070; x=1748566870; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=w0kCfWU98XQwV041YO1Y2EVRT9qYS2hPdBh6QvqO+sc=;
        b=cuUH5tmjZEPO6c0oB9uxi5GfWHihCvlzSCXYHhExWGFbAgsWD0aXNtuRbxYCoQ7JQx
         CXeO8wOFh9RipoPgxIE5TPm9bAIeQ8ISiG0OAGhx+pfo+uVx2sNj/nNtOAehMAT41fyx
         fIjX+Lro2/zZYIFLyVx8M8ufWTvJRJnMzefCjdb1WTiCeRTZ2A1O8kurItPedC+D6r6c
         8Z5s8l7zZE3yrkfWtqcB/oCU1zOsOk6t1MLOg0P+CXR5GHSM8Kr0DO2RNi48xyQ8bPlv
         bwyJw2gQPB/cUzMssBhdqwP22mPtuJSwpuQGvESzg8tguq0C8kWK6lZTSJnZsvAgr7V4
         ROgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747962070; x=1748566870;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w0kCfWU98XQwV041YO1Y2EVRT9qYS2hPdBh6QvqO+sc=;
        b=a2ZYjwlY7VnzJ3y7BLrEbAzmn6xRQEuTBNG4WVC7fDwJbYlw6um0CR/guGoFN/hyEm
         kPxGMRc4e36z5n1sK7K0s3UE/Cn7l5hyBWLMDUoE7KSI+XgH4SXqI6LdYgBEuz+h/ML6
         v8qIpMuF3ux8aERnVAis/KLHlBJ/w0OykibMBDKDn/RwfdZ1mu9vMh4lS9Hw1I92z1p7
         M6S/rVAXRb21efD+dMtxlruFDrvI8s/eGlSnL0aH6azMEveiuRLu6M5V8mrBeSE0lvgM
         jZ9leqmR1ASZMBx8YVekHBEnVpcNz+MlkJJ5E2Pv8B+bbJkpp1JaaCGe0vX6xzTK+2PC
         qWig==
X-Forwarded-Encrypted: i=1; AJvYcCXbWeKAQAAmj+1C2Uamlte7aVeKADry2aZH+9i9hyWieAWQdFdPIS2ui1fFBdbsY07VFUk/KQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywp6dQYcWO9Z4kh/uVmEt84YlAiZ5tO47NWeH3Rj6v8+H40rMzr
	VWKqwnVIsmEJv/ENBuDu3pNQrJiFhlDgUvD3mRzx9+1E/LvwSra73a3EmlIWdchMVDgGapav5qw
	rnhDeTg==
X-Google-Smtp-Source: AGHT+IGjkNbeOSur3vbEkZXFamu+YYNEKfRbtS/EU3c2ZsJsvBusKBLrOpiwTklBFI3+nSzpA/Uw0Nr96q4=
X-Received: from pjx8.prod.google.com ([2002:a17:90b:5688:b0:30a:31eb:ec8e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:28c5:b0:2fc:a3b7:108e
 with SMTP id 98e67ed59e1d1-30e7d4fea80mr41800434a91.4.1747962070676; Thu, 22
 May 2025 18:01:10 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 May 2025 17:59:41 -0700
In-Reply-To: <20250523010004.3240643-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250523010004.3240643-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523010004.3240643-37-seanjc@google.com>
Subject: [PATCH v2 36/59] KVM: SVM: Take and hold ir_list_lock across IRTE
 updates in IOMMU
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Sairaj Kodilkar <sarunkod@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	Francesco Lavra <francescolavra.fl@gmail.com>, David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Now that svm_ir_list_add() isn't overloaded with all manner of weird
things, fold it into avic_pi_update_irte(), and more importantly take
ir_list_lock across the irq_set_vcpu_affinity() calls to ensure the info
that's shoved into the IRTE is fresh.  While preemption (and IRQs) is
disabled on the task performing the IRTE update, thanks to irqfds.lock,
that task doesn't hold the vCPU's mutex, i.e. preemption being disabled
is irrelevant.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 55 +++++++++++++++++------------------------
 1 file changed, 22 insertions(+), 33 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index f1e9f0dd43e8..4747fb09aca4 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -769,32 +769,6 @@ static void svm_ir_list_del(struct kvm_kernel_irqfd *irqfd)
 	spin_unlock_irqrestore(&to_svm(vcpu)->ir_list_lock, flags);
 }
 
-static void svm_ir_list_add(struct vcpu_svm *svm,
-			    struct kvm_kernel_irqfd *irqfd,
-			    struct amd_iommu_pi_data *pi)
-{
-	unsigned long flags;
-	u64 entry;
-
-	irqfd->irq_bypass_data = pi->ir_data;
-
-	spin_lock_irqsave(&svm->ir_list_lock, flags);
-
-	/*
-	 * Update the target pCPU for IOMMU doorbells if the vCPU is running.
-	 * If the vCPU is NOT running, i.e. is blocking or scheduled out, KVM
-	 * will update the pCPU info when the vCPU awkened and/or scheduled in.
-	 * See also avic_vcpu_load().
-	 */
-	entry = svm->avic_physical_id_entry;
-	if (entry & AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK)
-		amd_iommu_update_ga(entry & AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK,
-				    true, pi->ir_data);
-
-	list_add(&irqfd->vcpu_list, &svm->ir_list);
-	spin_unlock_irqrestore(&svm->ir_list_lock, flags);
-}
-
 int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 			unsigned int host_irq, uint32_t guest_irq,
 			struct kvm_vcpu *vcpu, u32 vector)
@@ -823,8 +797,18 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 			.vapic_addr = avic_get_backing_page_address(to_svm(vcpu)),
 			.vector = vector,
 		};
+		struct vcpu_svm *svm = to_svm(vcpu);
+		u64 entry;
 		int ret;
 
+		/*
+		 * Prevent the vCPU from being scheduled out or migrated until
+		 * the IRTE is updated and its metadata has been added to the
+		 * list of IRQs being posted to the vCPU, to ensure the IRTE
+		 * isn't programmed with stale pCPU/IsRunning information.
+		 */
+		guard(spinlock_irqsave)(&svm->ir_list_lock);
+
 		ret = irq_set_vcpu_affinity(host_irq, &pi_data);
 		if (ret)
 			return ret;
@@ -839,14 +823,19 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 			return -EIO;
 		}
 
-		/**
-		 * Here, we successfully setting up vcpu affinity in
-		 * IOMMU guest mode. Now, we need to store the posted
-		 * interrupt information in a per-vcpu ir_list so that
-		 * we can reference to them directly when we update vcpu
-		 * scheduling information in IOMMU irte.
+		/*
+		 * Update the target pCPU for IOMMU doorbells if the vCPU is
+		 * running.  If the vCPU is NOT running, i.e. is blocking or
+		 * scheduled out, KVM will update the pCPU info when the vCPU
+		 * is awakened and/or scheduled in.  See also avic_vcpu_load().
 		 */
-		svm_ir_list_add(to_svm(vcpu), irqfd, &pi_data);
+		entry = svm->avic_physical_id_entry;
+		if (entry & AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK)
+			amd_iommu_update_ga(entry & AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK,
+					    true, pi_data.ir_data);
+
+		irqfd->irq_bypass_data = pi_data.ir_data;
+		list_add(&irqfd->vcpu_list, &svm->ir_list);
 		return 0;
 	}
 	return irq_set_vcpu_affinity(host_irq, NULL);
-- 
2.49.0.1151.ga128411c76-goog

