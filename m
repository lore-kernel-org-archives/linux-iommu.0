Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A27277C91
	for <iommu@lists.linux.dev>; Wed, 11 Jun 2025 22:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749682095; cv=none; b=WDy66Ium9HHuJgHO987m71uu9rXiFyaPQDPL70c6sZl0aMpU6X/YBSLOaPmmHsRpn5IsXfL4p8XrYS9mmng3XvjlOmK9YclUzOyvAQk5Ur0D0IdhSRoM56RK4WN+XOtDjln3HGUTvTvLqWwRh1JK54gQ5L/obb1mQxd+Ckkxeeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749682095; c=relaxed/simple;
	bh=5uhQSLawC2qU5tV2gH8Qd+5+MUnVHTVb+tyLOzTBT7E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aB3xUnr5DtkOiXioRQHctxpRI+WeUbd2IBYU1qMzmIBWKXWlUhdOHgNXK8usnGnzTbC4C2MzUcgi5bC4pTFKcPyQ3br98+sGRa9YBW5talbiowYPJtjZEuA8BxxCRzoMIZHgj2ALBcQRRY1rpTp135lIHyCmokxCCzx+JHfpZp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cItv5r2c; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cItv5r2c"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-311f4f2e761so311469a91.2
        for <iommu@lists.linux.dev>; Wed, 11 Jun 2025 15:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749682093; x=1750286893; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=xaTt4Giap+1J1lFwTOaDaJBf68Rv5IWBO561HkZo+gI=;
        b=cItv5r2cqPJAdXZiP8mcRgJ+apVAmbEb+mThKNMNWTYd8GFFZSpHhahHDNWHJS1Dbv
         +DgriHfWCmaFNw8ZvyX9nUzP7M6kLbckJj/ogb1SvgWDhFWqZZgeB/eQhCMGujy8/ZXT
         4eZG4gTiFsqy27wfSKBmaWAqisXlaPy7wXFrLpq5J+Xlc4okCo3i7Dr9gOAKn7aKxWhH
         Wb4DG6AR7Iv+GxBXO4F1pvjUnP4zU5x2qcd84AirJluh5dcuU1mWq4bSVjksA2AYqXoP
         tlXYulQ1ZGfKOw5qXBKLIF0p/cL1QYN81qWEZo3YarfAWp+1AsKIWDDfK2Q36HgTYoXz
         ve/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749682093; x=1750286893;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xaTt4Giap+1J1lFwTOaDaJBf68Rv5IWBO561HkZo+gI=;
        b=PqPod59vCZTgoHLUDsWU7HVt0xfAy/CpgVkjK8LBR2stOYM/EcOSDNyTKk54kZm+VO
         NaC2qF8/q8Lp3nUboPdRAjwdIhUz7Dq/Rz9ZeR4XUHmL/Ktfbn8ibRyNtt4okqhA9CLU
         RwiB7hZvGzP+Zy5PFdQNPQ9B0c/uv8C5WIbfvsSoelMDY6VpJF6cd9orQ83Xnzi1qaw0
         FOWQA2Qo+s/C5UqfyutO/9nKWR7fgLWy1+XmVEoqyJMY/nuN7put9Q+vjAB4MeraePLc
         S1tTQNSwcXpdtSS5xXvl8BrVR5elW8FqBp9Dhk0Y9LIXFO2qOtZ7BSEcaiCIBYESLlv5
         +itw==
X-Forwarded-Encrypted: i=1; AJvYcCUBqXHszHuwbJmXvh4+eidQeSKxWqbgUPxILSI/c/NypHRi9s/nwocYYwu7EdYfm7CBWP9+Eg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwkQNdwFET5yHMhKptwOucl19v5Hgp1qh0s5K9CzYPAkPCPprzB
	59mh64g8uNZGIf9qO/GnIuWG1r8udkevcbKyiJ+7WQEeF/jiQ8uKJ2sV9AFnn9qUhtf9XxLGkXZ
	lQoz2fQ==
X-Google-Smtp-Source: AGHT+IGf03w35WpWXu537xHWr4U/N7R14xnxNpvZmT8HfbsZ9X3mUH7UkRwX/TiEroCP15FbAA6qEaYzrj4=
X-Received: from pjtd16.prod.google.com ([2002:a17:90b:50:b0:312:dbc:f731])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5408:b0:311:9c9a:58ca
 with SMTP id 98e67ed59e1d1-313c0688525mr1173665a91.8.1749682093424; Wed, 11
 Jun 2025 15:48:13 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 11 Jun 2025 15:45:48 -0700
In-Reply-To: <20250611224604.313496-2-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250611224604.313496-2-seanjc@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250611224604.313496-47-seanjc@google.com>
Subject: [PATCH v3 45/62] KVM: SVM: Don't check for assigned device(s) when
 activating AVIC
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

Don't short-circuit IRTE updating when (de)activating AVIC based on the
VM having assigned devices, as nothing prevents AVIC (de)activation from
racing with device (de)assignment.  And from a performance perspective,
bailing early when there is no assigned device doesn't add much, as
ir_list_lock will never be contended if there's no assigned device.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index dadd982b03c0..ab7fb8950cc0 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -732,9 +732,6 @@ static int avic_set_pi_irte_mode(struct kvm_vcpu *vcpu, bool activate)
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct kvm_kernel_irqfd *irqfd;
 
-	if (!kvm_arch_has_assigned_device(vcpu->kvm))
-		return 0;
-
 	/*
 	 * Here, we go through the per-vcpu ir_list to update all existing
 	 * interrupt remapping table entry targeting this vcpu.
-- 
2.50.0.rc1.591.g9c95f17f64-goog

