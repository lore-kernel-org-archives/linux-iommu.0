Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6312E92C3
	for <iommu@lists.linux.dev>; Wed, 11 Jun 2025 22:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749682097; cv=none; b=XLl6WzZb1vmhmFEWBiPikH6q5gorRzVWWN+QJyUDsVZ8BgymUr3Wejg6+vdwtnJjaYETVqJAcWhUBJK4uXFbZqI7ARZxFBt34EVXz3Fyc8I8aqebDhD5qEkeu/A0T0KY6YlNaq5BG7A/RjCo3oXzaLgKdNlYjpnqImwm0UzGnK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749682097; c=relaxed/simple;
	bh=sZKpR+29jrgmDW8zj3gsPXr7vmaepNsrgM7wJ6uDWQw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Pzo7x/lrA+zmKRVGADmDI+rSaTiqq70bh9E1s2S4zf3fTWxxjrIVo4psKugS0DR6ubt0UmYEws2p7ZTJhnpnUv5hu2wsTH9mDek+rh99hZBBbX3ffRVJjetDSJKqfNjb7qajTgo7RZ+vHQg4aMGeGaKx+VDv0qhPOhyu3WT32HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PfpR471F; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PfpR471F"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b2fcbd76b61so236590a12.3
        for <iommu@lists.linux.dev>; Wed, 11 Jun 2025 15:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749682095; x=1750286895; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=8FnMVkTP7732/rGDqsdkPg9eAdht5jy1QJRhPQZX9sI=;
        b=PfpR471FUkG7wDJwp7FmDCHGcRr593NvQHTHBfbeK1GCoQWVN29alNNgZbYec6A1Cu
         z/vUNy2PzBimhWiyziB036gNirDb6ayv76OkrJhUmuriNmLOZasb3cppYi2tX6TdbFzf
         cYNbKBCsa0D9BXXOUS7Y5NEws54tDbWnKFkOtjoyjlLjdImmnVwXEGlEpeKB7h8RiqMF
         Xr2HoP2lFuDoDkJB98pehS1cNVV4pDs/iqliCMg42luPK1NIdsRpfmar56xf1E4dH0VQ
         cQMoSN4/UTYXUO13VhqbXi+KEzZAU4s13E9I/PwRVs6ozqxL8D6tSxCwfR7vEGsJaKmn
         Z6NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749682095; x=1750286895;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8FnMVkTP7732/rGDqsdkPg9eAdht5jy1QJRhPQZX9sI=;
        b=t8E76y4q9EHhk7mK/U6mB4gqCzRaLizQhoHogupcGgqw61j8kMP2fkzRLt5akyZdiP
         iqDzOPj4+iXgoeqZFiTIWNPMcDquCZHUTI+eH2buXqast+hWmw7ti49VIjRzZn0FnBy6
         /EXnxHSAUeK3/odgqt/JOj7RKHhgnAbwziEDkvWmPVMcVRofe+NfPiMt2rHAewxjy6IB
         ITTd511guaLmAd3H/7dKGZSAM1ZWoOYKcSldj8ZxqbciiY3PCl9ZjavgDGTrnS15wquh
         jhHprflcNmfdDpiSJkRko/xt087NKn+F4Z304aKCb+1d4zZxMtzT6tigsVwZvuFN+HT/
         41SA==
X-Forwarded-Encrypted: i=1; AJvYcCV1j5yX7AVWqLDYaYzWO5uLZIwc4G6ver015+KelXnWhSzaSkWa0Qo42o+qAqDAVkrwwGMbjA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyw3hOzd8lnvAQYcKsDWoI4/MWKweJWhGukcXFytRsfdjT65KT7
	wqTphrPFexDRBKYpzxXicoqIyr3aWP/Lcc+HHQdd9jd730ZxFOsKDvDtsr83kKFar0caTZ3limW
	djUxx7w==
X-Google-Smtp-Source: AGHT+IEkxrCdp03yXvohQUC5aX3+y16xZeqjkREhnIK0pQh5uO/LXqt4ZRF8KMwqJnvnYQVw6yQOWD1N5g8=
X-Received: from pgbfp15.prod.google.com ([2002:a05:6a02:2cef:b0:b2e:c392:14f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:32a4:b0:204:4573:d854
 with SMTP id adf61e73a8af0-21f9b6b34afmr672683637.9.1749682095254; Wed, 11
 Jun 2025 15:48:15 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 11 Jun 2025 15:45:49 -0700
In-Reply-To: <20250611224604.313496-2-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250611224604.313496-2-seanjc@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250611224604.313496-48-seanjc@google.com>
Subject: [PATCH v3 46/62] KVM: SVM: WARN if (de)activating guest mode in IOMMU fails
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

WARN if (de)activating "guest mode" for an IRTE entry fails as modifying
an IRTE should only fail if KVM is buggy, e.g. has stale metadata.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index ab7fb8950cc0..6048cd90e731 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -724,10 +724,9 @@ void avic_apicv_post_state_restore(struct kvm_vcpu *vcpu)
 	avic_handle_ldr_update(vcpu);
 }
 
-static int avic_set_pi_irte_mode(struct kvm_vcpu *vcpu, bool activate)
+static void avic_set_pi_irte_mode(struct kvm_vcpu *vcpu, bool activate)
 {
 	int apic_id = kvm_cpu_get_apicid(vcpu->cpu);
-	int ret = 0;
 	unsigned long flags;
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct kvm_kernel_irqfd *irqfd;
@@ -742,16 +741,15 @@ static int avic_set_pi_irte_mode(struct kvm_vcpu *vcpu, bool activate)
 		goto out;
 
 	list_for_each_entry(irqfd, &svm->ir_list, vcpu_list) {
+		void *data = irqfd->irq_bypass_data;
+
 		if (activate)
-			ret = amd_iommu_activate_guest_mode(irqfd->irq_bypass_data, apic_id);
+			WARN_ON_ONCE(amd_iommu_activate_guest_mode(data, apic_id));
 		else
-			ret = amd_iommu_deactivate_guest_mode(irqfd->irq_bypass_data);
-		if (ret)
-			break;
+			WARN_ON_ONCE(amd_iommu_deactivate_guest_mode(data));
 	}
 out:
 	spin_unlock_irqrestore(&svm->ir_list_lock, flags);
-	return ret;
 }
 
 static void svm_ir_list_del(struct kvm_kernel_irqfd *irqfd)
-- 
2.50.0.rc1.591.g9c95f17f64-goog

