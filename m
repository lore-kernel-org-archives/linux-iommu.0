Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155A72C376C
	for <iommu@lists.linux.dev>; Fri, 23 May 2025 01:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747962084; cv=none; b=d6QTNux+eJ+OLWTacSJK6gNZDNxIP1PkQbI/dawspys2pNPe4O6A8HdseKxhttOHoq4viziUmo6CcZiPHUWAvp4L7mUC/+FEhelOCjl28Vod/uzGO3n8Cah0nvw2hB2SHMclFxMLqoecPsjvHv6n4mxzWu9ZlTb+odhP+AdjmTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747962084; c=relaxed/simple;
	bh=Z00yQ0PQn26W+YkvG1/+a4jEvueuLPaetcdy4ijqCYQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GrVACt/q8RfyJ/vDQGCB2ShrpkgXFS60VC3vNcQgHfjd9upBMo6mLOWPnNdfmO2whlvotcbtNygG+T9cOuflexX2/r/0mkKz8UfblboCOBWerciko5J1WoJjEOSQmej1t6cSH98xJjZ8Q61QCzQJEo1MTXxOpOdjCet7uwVvHc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bujxshu9; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bujxshu9"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-30a39fa0765so12955225a91.3
        for <iommu@lists.linux.dev>; Thu, 22 May 2025 18:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747962082; x=1748566882; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=zrysmAdotRY3tUKAweOx9pfjToN/g2hJE4Ng9AMbRtg=;
        b=bujxshu9vXOS39bY81moqiChRrhWv7S75h6peN59lGwXX+V5jT+Nc7aNYZjK2PkDuG
         ORR9UP+qTB+U/eEiGLakZ4tuq14jqYfGP+iryUSLa9VcKXZ5ugsJZGwsak3OYp5z2UE7
         lJQxOxs/ngFLUqUltsfU+zaBP3/zaXJFlDqD/XDezZmlUUKgtCUf+Z67IjlMFSGezDXw
         8hBtMenX2S1NXwLEV8wjmcvagetxXbMf6Gh3WycPZzAGIW3OyPYCyqL9nEZdekh6rlUj
         8Vh1CdfxQEs525hPpwHp5c9WKxXkDyqJMpy/eMXWmi3sh2fLdkB0fnUhqC22KWuXKmbI
         HJUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747962082; x=1748566882;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zrysmAdotRY3tUKAweOx9pfjToN/g2hJE4Ng9AMbRtg=;
        b=OCDCzPng+TIdHAEcwuI0Zu86vz1k5ni7GgbZiJtrCSF2nY1N4OcJCw9ui+VkqlwMMX
         FSVPN2VwDtPXPoUX8rP/KVFI14f5Z67O24+LD3LOqitg9FwD2+0NE1uwDYNwToNVkZlN
         BClfLjPBzidc2GzVH9P3pQu2qfa+IAO+A4hr0fXJuP5m6ii+Y0O4n1Vv71XkFWBUg2As
         +NVkxbFAdkp8OpHzsRDq4n/vOiBB3jop81yKIeTiCrs2JPQpy9dh1TUzrNUkP8zeBqXO
         gPukDRV3wcIOoB8/4caFcvAyG6wFKgUgVWJr4HBKwJlUtNlLj37OSqiwv+az5jNHIrnk
         Y5QQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiiIShxosyBwe4TtXLLL+GTmfx4LtgAmlzGo4NJG6n+ikcaS0SPZ047eLFM2bzQ05lvssAPg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyGF808GNTsDYe4IqTInmCaeUJKmDQPjF8hfvfA11+T8MNmlpA8
	4c0VbfG9DLIAFJDNs/8NIBJmMP4dppC5/c+XGQnaf/Y1G7gYbc19nRnaHla/tuWlMJAFC2kaS0/
	PbdUjsQ==
X-Google-Smtp-Source: AGHT+IFYYw2vNKO7X1E4jTH8MJBys/Xi26XTWV4xJAxpgqO4gyT9OdqFXK5/A1nwW8HDjPEMRjulaYFMODU=
X-Received: from pjbsn4.prod.google.com ([2002:a17:90b:2e84:b0:2fc:aac:e580])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:394d:b0:2ee:d024:e4fc
 with SMTP id 98e67ed59e1d1-30e7d5bb433mr48333499a91.33.1747962082505; Thu, 22
 May 2025 18:01:22 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 May 2025 17:59:48 -0700
In-Reply-To: <20250523010004.3240643-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250523010004.3240643-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523010004.3240643-44-seanjc@google.com>
Subject: [PATCH v2 43/59] KVM: SVM: Don't check for assigned device(s) when
 activating AVIC
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
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
2.49.0.1151.ga128411c76-goog

