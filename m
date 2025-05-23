Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B823288517
	for <iommu@lists.linux.dev>; Fri, 23 May 2025 01:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747962069; cv=none; b=AKBv9MtJnK+1fJlaNAeY9l+MjoQrFyOjZujCy8DhHh2sMu2M+4Jbgyp5KfKgDYPdnrRQL0urxk3F5yw44Z1K5u+iToVzXCqx3I/nFoorcx5UR8l5tdk4Tl7zGB0VcgCLx9g2w8SSymvby2I26HhlRM2GsBN/cW8R2wRIoGrpqrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747962069; c=relaxed/simple;
	bh=D8FN8kkLx7L8tVrUTR+61zNHHfC5qjIkeg2WDBKUnVA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KH8aRmDFhFK4TR1Yp4e9TdjqT6ecCJIjuPUaeO0ueC6H426R76Ny4qboHwtGZaPeV1PCx93N/R/0eoKnTTHwY0IisKgJLKDkHhKMMkN4BcaX4uJAkOOpP9BfDsNGih3mGNZT0J03t+ayWlQ/Y6p2l8Jcg6fCGQZRLkDDDyMAH3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OC31/hYC; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OC31/hYC"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-30e9e81d4b0so8246672a91.3
        for <iommu@lists.linux.dev>; Thu, 22 May 2025 18:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747962066; x=1748566866; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=a8iEK4WECydE0ey1yGfRxrlymXScvl+S1HRsDMKm8xs=;
        b=OC31/hYCdsd/WTEfh50jXxAi+ComkAXiGGhEj86SX+VSXooHVp+ScsdOXGBzsG/iZu
         DdFZWJfna6qhcRHBEYktvWbnK7WzUdK5/le7ufJgcQcKxO9ebr3rilkRjuTCzkjsarjN
         +Ne8SdXZLJpiJ9Q2MTYyxWiOs1cLBv4MaWGLLV0Vtv+q7bwt8vcBhGQcTHgef0glGvlk
         iY6xRX7joVQDJNXH1FviG/QGgdHQsToN7WEAxvgvZonrEPgADlXoOKLbrrAl0xqNqHZ/
         tho+WVlQ5botF1oRAyZypwsqaFC7020jy/Z9ESLk+s2TfQbk0iM9xsyuXbzHTSJ8uEgf
         q20Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747962066; x=1748566866;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a8iEK4WECydE0ey1yGfRxrlymXScvl+S1HRsDMKm8xs=;
        b=WLfuq4Lp+DxYHmiXT3TYF9QSvzpvJ5RzHgH+2xVfDCp2JmYRKGucV8518XRq91UCCB
         XP8bLY3907/gJUfv6GgtkEht8xrdwNIRO5cDFM8q6uwYn0CBXk/XaTJFkWilh7Sv/1dw
         kE0vxCbG/jODIbSzd3g+4kdeGD/5R03j1/BBArFfBXJwzbfKim3036r34imKUI/6ehn6
         CVdv1JF0hAd4iNO//4cf4WNfeEdL2l936u7MVG09joT7AJyqD1B15YEHqAMsQzHYqwme
         G4PtXU58lQNAaTweaioIhiPlwHG3rBDXPFxiKOyRUHgxPvhpXqId6SHI7wI930hv95Cw
         7fPw==
X-Forwarded-Encrypted: i=1; AJvYcCWquiBJiNS1LWwKWpr+rDnZutIaBYTDrVd9wzhglczRIIdo0U047H66dpBqTnHo6N2DDC3TjA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxRr8wFJMJJbbnBpbM7JpQWfyBo/VNxRAUnh9lPhR/aRpaBAut2
	NFVjnF15I1awGabtVoaRZbnIQfJIvOReNF3BbhidT8M+iCFgSQJdJR3tO708epaS0Ii64Ti0FD/
	tcGdDtw==
X-Google-Smtp-Source: AGHT+IHwPMZGzfvW4HHKJ8l4pKBM2HZBGdDFPBOti30bJ3R5xYNqLd2qkSG+uTsnts5TsJg7XZvkaLmeguw=
X-Received: from pjp15.prod.google.com ([2002:a17:90b:55cf:b0:2ea:5084:5297])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3b8f:b0:2ff:6608:78cd
 with SMTP id 98e67ed59e1d1-30e830fbe31mr42654796a91.9.1747962065843; Thu, 22
 May 2025 18:01:05 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 May 2025 17:59:38 -0700
In-Reply-To: <20250523010004.3240643-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250523010004.3240643-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523010004.3240643-34-seanjc@google.com>
Subject: [PATCH v2 33/59] KVM: x86: Skip IOMMU IRTE updates if there's no old
 or new vCPU being targeted
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Sairaj Kodilkar <sarunkod@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	Francesco Lavra <francescolavra.fl@gmail.com>, David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Don't "reconfigure" an IRTE into host controlled mode when it's already in
the state, i.e. if KVM's GSI routing changes but the IRQ wasn't and still
isn't being posted to a vCPU.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/irq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kvm/irq.c b/arch/x86/kvm/irq.c
index 3a0f28e98429..67fc8901d15f 100644
--- a/arch/x86/kvm/irq.c
+++ b/arch/x86/kvm/irq.c
@@ -542,6 +542,9 @@ static int kvm_pi_update_irte(struct kvm_kernel_irqfd *irqfd,
 			vcpu = NULL;
 	}
 
+	if (!irqfd->irq_bypass_vcpu && !vcpu)
+		return 0;
+
 	r = kvm_x86_call(pi_update_irte)(irqfd, irqfd->kvm, host_irq, irqfd->gsi,
 					 vcpu, irq.vector);
 	if (r) {
-- 
2.49.0.1151.ga128411c76-goog

