Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9192594AA
	for <iommu@lists.linux.dev>; Wed, 11 Jun 2025 22:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749682023; cv=none; b=uFu0tD0qBiRsy20+dBm5kHwndiHu5RC5RE3GbDpc9xCGyrC/pzpkjAoGxMhMsvvyX14QUPwa/6Z/fhv3bt/9s/DGDDP8Us3ZI1xRojtGl3PtIO9r73LFAJoAbM592SwVafR62ayUFOYjpZ5S9g/VkdliBHgXra+bVQ6nbBrGzvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749682023; c=relaxed/simple;
	bh=3RinVstCvuPOndpP2qbzIU1WkDpDfa7DXhIJNaW07EI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NdBZ+kel628LT4pGSYWvjIcdwZzgUEtN4qGy1MwRoxEgjKbWiTVhmgh8IUuk/aetgy6bSOeSDxdvLNnZ7Nh4Vu9YILJGd/LJK6qsjwFc1XcBsuAHtnQgBCkWgLq2rXcVabDI81xas2e5ryQM6RHhRtUf7n7X8u+F406dnIPESGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Eonm80cB; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Eonm80cB"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3139c0001b5so313922a91.2
        for <iommu@lists.linux.dev>; Wed, 11 Jun 2025 15:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749682019; x=1750286819; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=J8/39YMW2TnSu0vcgq5sLc/aWRKEr8Y6tOCzdbkWep0=;
        b=Eonm80cBIWPCL2RSpvStf9nNuoSUoCjKVGSsiCQVRM/lQFDXctf3mdQRq698dT4PES
         6Kuo9UVn8OjACkXWCk0mIMk2lWhuqBl59zyfDcSLpvzolfHZMjx3adw7Y3uTktAQ9TRP
         T0hQ/DlApbHn+asoqQVUsOdYbstGdXOeGvUWQiozYCyOeZDjq8rSprxuxSGzTzPPXyEn
         yJBKJmMn2xKt5EFldBFW/MbZYkXOC3XJsOnbnqfq1miashrE9Fyqr8OFVZofytjNle0A
         WT1dtnOL0KTQ9IZ8iUTrNcOBzWs49cIpy3KBgnF9s35cgTquLuFQ65xjhG5J50eEqmX5
         G/qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749682019; x=1750286819;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J8/39YMW2TnSu0vcgq5sLc/aWRKEr8Y6tOCzdbkWep0=;
        b=WGZ4/TvzV8o+eKIGieBSyS+0LlEWO9RWlddFYrqm1+IHohh29RdTX3AVyu583RAXxh
         /I/waCKSUAE+vXQh6jIxSyFcTZj3B3yNb2m96EvfBHU1h4IseWTiv7fQOZIZPnKYiAqH
         G2+4xBVdNFyk9CJE7usYTCK+PTwBgnZfIwi+lcpWVhNmqiVlMqJ42AIjV+Un0YcefMg9
         z9FZRH4AyDwW1cvkJWK6yxBrmROSpxdmzBeRa7vrWLtQuKp1ji3WM68sq+ReJdUphLCw
         s56lx6AefaHPB6u662nu10ohDA6pwxoBRBRRbhb/RljdpRpHRFoDgQQPlz7a/15bjhNl
         Yf3g==
X-Forwarded-Encrypted: i=1; AJvYcCVJ3WGHHqfM5Tkvtai8ALxPzSwbsOAbcHmwAEd/viJ0mIeXeWia3TjTOTRA50WTI7UJf4rP1A==@lists.linux.dev
X-Gm-Message-State: AOJu0YwuaD8AvueZwnudVqOwHRmyXeTeEe5JjRP2qLBs8pNT397yMp2s
	Tl+aM0s+xW06VHxkUrkDTbCrP+rzCMy6OK4h07YOENgy5pghDs90I04udvPyKx/NQsji41T9Gdy
	PjJwvrg==
X-Google-Smtp-Source: AGHT+IE4n+pz35x0pb/YvabbWEbD1z+qTn+f+8VFoLc/qnaff30Vgk2g7VglikeaFDWzSwKhNVkNo49sz8M=
X-Received: from pjbpa3.prod.google.com ([2002:a17:90b:2643:b0:311:46e:8c26])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3902:b0:311:abba:53c9
 with SMTP id 98e67ed59e1d1-313bfba1132mr1720309a91.7.1749682019303; Wed, 11
 Jun 2025 15:46:59 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 11 Jun 2025 15:45:05 -0700
In-Reply-To: <20250611224604.313496-2-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250611224604.313496-2-seanjc@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250611224604.313496-4-seanjc@google.com>
Subject: [PATCH v3 02/62] KVM: arm64: WARN if unmapping vLPI fails
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

WARN if unmapping a vLPI in kvm_vgic_v4_unset_forwarding() fails, as
failure means an IRTE has likely been left in a bad state, i.e. IRQs
won't go where they should.  WARNing in arch code will eventually allow
dropping all the plumbing a similar WARN in kvm_irq_routing_update(),
and thus avoid having to plumb back a return code just to WARN.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/arm64/kvm/vgic/vgic-v4.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kvm/vgic/vgic-v4.c b/arch/arm64/kvm/vgic/vgic-v4.c
index 193946108192..86e54cefc237 100644
--- a/arch/arm64/kvm/vgic/vgic-v4.c
+++ b/arch/arm64/kvm/vgic/vgic-v4.c
@@ -546,6 +546,7 @@ int kvm_vgic_v4_unset_forwarding(struct kvm *kvm, int host_irq)
 		atomic_dec(&irq->target_vcpu->arch.vgic_cpu.vgic_v3.its_vpe.vlpi_count);
 		irq->hw = false;
 		ret = its_unmap_vlpi(host_irq);
+		WARN_ON_ONCE(ret);
 	}
 
 	raw_spin_unlock_irqrestore(&irq->irq_lock, flags);
-- 
2.50.0.rc1.591.g9c95f17f64-goog

