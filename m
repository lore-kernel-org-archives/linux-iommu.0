Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CCA2E92DE
	for <iommu@lists.linux.dev>; Wed, 11 Jun 2025 22:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749682093; cv=none; b=LVnPdcwDM0SGxnaXJLPNwo7ZddIRb/UcJNOtfUhplhSl6kONJaAvavl+T4/+CS55MvBAcjqftJC2M00k3ft337beLptHZf2iwSqn8qluVmu+zoSPCo9XBNuVLjFnV12SGUoeVRJv11me2wAjW7ydGiE5tPVYUriDPr0JO3F3qHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749682093; c=relaxed/simple;
	bh=yZZtRbcWnuqwQyat4VhI1SVpbjBljsz8F13Q0oWxmXQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Rhcf+BcUl49HfmekbjI7NEp6rhuRRIAjDK3DR1OGpA4hB1xypAJgPsgn+JdApvmTcNkIp34fjGSAd8PxIECXzRHCANYJBoe5AhuPZdbJ7n8LO2KWkB7vynUw6bT0jr+uBOphdOpp0SRdCP+A7vxlgOnkk3C9zojOqIK7G8qJtg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IxIPxEJa; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IxIPxEJa"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-311f4f2e6baso327648a91.0
        for <iommu@lists.linux.dev>; Wed, 11 Jun 2025 15:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749682092; x=1750286892; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=mEZsLhf6SxJ64ydA6t/wQOktcm5LeFVwzcPjAJ4nCGM=;
        b=IxIPxEJaWFn7VbWht/QDOl9A9SCftW+9RQqQAuOgnMetNC7Mlv/HBqV0v9VQ5DaG6D
         8HYFH+yCsexFj1Dp7mynOuCzgq4mLeGphc6+OJid+XKPnFJl8pSmoOqNXPJw0bxJVBZk
         7Ii9yLtttXsfCBTuBhU10upKtwP58KtlIgAjDvzWdI8m83mhdd8iJPPguwFvtEb2lmUx
         vmdg7onUux5PmL5fMhLR6yTOxQ44OOdDfiScuw88AvD+vgnuTnmpOuV0wAUsD3Otu4gW
         zNsC68sDrSmn/Xv74GDqkLdCaghzFViag4BuFy8FQvjz3C/fh+ROiyNNwgrt5bn5cwLr
         hWRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749682092; x=1750286892;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mEZsLhf6SxJ64ydA6t/wQOktcm5LeFVwzcPjAJ4nCGM=;
        b=XwUR8QC6k5yHk1LgFgbbUqG37IyGnPeE1XVZAgWa5XA7Svnyyj55DOcxK5ZR8QT6wE
         YL8QxnNoXITWhqQpJ6QQ5aM4/03YXZj8NSPWDJPN8xGDzp4l4SPk42TKHAGf5w2xhCf+
         D9GHQdCjIlP8QPRY44z4dGHHXVJ5AKgbvvyoAGwc0FTkQy4RAPq/4PLlDGYP0vMsxpQh
         heZ4ZpL9XDOzxUQssDpKZO+pIX19uIZNuxyxTpU9bErHvsMiEEdj29NnU7H+ckoKbFmP
         9txY/HZApX2Jfg6tXRb3JC4WqtvTxW7lG0EqM1gPZGr9PfnbcO8SZLIMxl7iKa9SeAiy
         0jfA==
X-Forwarded-Encrypted: i=1; AJvYcCWNNXVd4po2wm+CRaPbXli8ZvFdgEiyIfzlpl9XMfhJwF98HUqDfKuF6uCJWm2RGFrz5Su/3g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxbSgB6rl/JUCpazbr9MB8x7lODnI+5AUNZObN8fp8hDUT6Z36Y
	yLyEbm3nzMrmkoxTiqdXGmeoEC51HF/jy5OGTMMyxF5PMOz1gi3MVlvej4hGRIbh3xC321RhHYf
	3S56skw==
X-Google-Smtp-Source: AGHT+IFg24zPNL3KiBl4z/DNOHqd2KhvvGrjl3yLgrTD6GwXkCuqSf7mQ8rAwENd7T74FPlQ31IQOCRlfVY=
X-Received: from pjwx3.prod.google.com ([2002:a17:90a:c2c3:b0:2fc:c98:ea47])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:c2d0:b0:312:def0:e2dc
 with SMTP id 98e67ed59e1d1-313c068d18amr1292249a91.7.1749682091962; Wed, 11
 Jun 2025 15:48:11 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 11 Jun 2025 15:45:47 -0700
In-Reply-To: <20250611224604.313496-2-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250611224604.313496-2-seanjc@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250611224604.313496-46-seanjc@google.com>
Subject: [PATCH v3 44/62] KVM: SVM: Don't check for assigned device(s) when
 updating affinity
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

Don't bother checking if a VM has an assigned device when updating AVIC
vCPU affinity, querying ir_list is just as cheap and nothing prevents
racing with changes in device assignment.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 2e3a8fda0355..dadd982b03c0 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -847,9 +847,6 @@ static inline int avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int cpu
 
 	lockdep_assert_held(&svm->ir_list_lock);
 
-	if (!kvm_arch_has_assigned_device(vcpu->kvm))
-		return 0;
-
 	/*
 	 * Here, we go through the per-vcpu ir_list to update all existing
 	 * interrupt remapping table entry targeting this vcpu.
-- 
2.50.0.rc1.591.g9c95f17f64-goog

