Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E38B24889B
	for <iommu@lists.linux.dev>; Fri,  4 Apr 2025 19:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743795689; cv=none; b=Hna4/6YToZ96PfgBQ7sHP3nxA7ifuuiDU5uZQPJWv4V8qtayPsdbnfD07JG+XK+hd1+Q0wmf1w5Cx3c6mX2l1mWfkLVapPFVVfKBuAMF4Bjd2bsDxYECBsAhQ9xml6pHSfN1QiHGNNQRjejcULjKl2GBeksd0NDO77Pu0QGtYNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743795689; c=relaxed/simple;
	bh=oILWHlZoymAyC2X3yedwJsSZpaT6PkdFe55df8DN2A8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lL2xADxif2HfzeKz6pfOeAEY9/NRyC0WA4wkh4Ow4gAoxByUgFVqSEutvlFfsLa7o264dt5LqKGAoEM3AHlv1dMw1Fqrdo8gqCfMluW853zv4PNmiH324wLFGg4N2vow6kYSyegGFU25fzLSZZxvOWLPCr40QLPdXEVSYHFhmjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SR0T+g1u; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SR0T+g1u"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2240c997059so29575665ad.0
        for <iommu@lists.linux.dev>; Fri, 04 Apr 2025 12:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743795687; x=1744400487; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=tpUGu5WACeQY+DXaIgbcGZ/fnmY4/g2Rj2L2cuTjvC4=;
        b=SR0T+g1u9W5zj/v7H5QzKD5dA+Z+A6yKr3ZVmMDV/SQtcM4HORFM3YnwUfcNSqcxs6
         ti01FGLZ/xV+Hjk8kSvsXhuV3QnI4XfRdXqSuHSPpr5t/5ZLoUXtwXo5hCqT4TKbi4bp
         NgxZcR4SoJim8TKlY3kVZWCy14ixGcnkBLnBYd/iyjTECpag85IqVAiRhvLnTwVBxVdt
         N/BZbFWm3GH9CKqODhoMGbLUhigfT2yJw4N0kY8BZF13SCQX/5Wvf5OnGUc6rM64twwF
         n1SlibfW5FJnoxhYPpjzeG7IUypf8/YnXyMfwIqBJeGqduLRfHPGQFZng1q4IDryCVQX
         6fNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743795687; x=1744400487;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tpUGu5WACeQY+DXaIgbcGZ/fnmY4/g2Rj2L2cuTjvC4=;
        b=wqIuZXRlKhWLa86+0Kv4QbYKpdhKtTgxXK0aUAaiRuk65GWN0myLq4XXrjlfOLYY2R
         ehTeB9ygUMFJXQEYTBGkyqt8bsA9gId2WwXu9lPJc6pDPSqIOUUmaNFEXZNJ+BBecmGe
         z86p/xdp08O/LyBQR2it75hbzEJ2sQdWfv3AMqI7G45rGIV8BoqyHu1zsh5MUQDMV2JF
         i+cLXHHGywtq+3hWTkPe5qOL/8p9da6igfi3T4TQYJ2V0uy4NZdJvI7gBK+cxrsqeh9u
         C6I3aTTj44ks7fHUMqVLvX7fc44/lRDCLrhOynLX5vRZOIun49rxkVA8HHvEWleH2xPQ
         2aVw==
X-Forwarded-Encrypted: i=1; AJvYcCVeChPF0kcolS3jcI0UZNnOplMNXd6cpk3mcm15j8/Hx3cuWpsKDBhoM3cPclJJ6JZY+JjjMw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxufR6gE1taIu4+ebpyavFWMcJihmBXAuF6ttnIySOYSDzDWNS0
	Y1l99+pZrh6uZqgnnhKv6ZfdNR4Gz0MLZDDaMeI3y4uZ4RAUYtdTJ0HgZEo6xKwnIpVsJlKba/u
	ImQ==
X-Google-Smtp-Source: AGHT+IGWIJW5oXdpll4D4kyUc6CqYVXv1H9LdsgiZOQiFY8S/63oNQDk+1VKkmtwRbHnjm+dtN9Wq0qn+Vk=
X-Received: from plbkx14.prod.google.com ([2002:a17:902:f94e:b0:223:f59e:ae50])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d589:b0:224:76f:9e44
 with SMTP id d9443c01a7336-22a954f9e33mr7330205ad.8.1743795686999; Fri, 04
 Apr 2025 12:41:26 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  4 Apr 2025 12:39:13 -0700
In-Reply-To: <20250404193923.1413163-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250404193923.1413163-59-seanjc@google.com>
Subject: [PATCH 58/67] KVM: VMX: WARN if VT-d Posted IRQs aren't possible when
 starting IRQ bypass
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

WARN if KVM attempts to "start" IRQ bypass when VT-d Posted IRQs are
disabled, to make it obvious that the logic is a sanity check, and so that
a bug related to nr_possible_bypass_irqs is more like to cause noisy
failures, e.g. so that KVM doesn't silently fail to wake blocking vCPUs.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/posted_intr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/posted_intr.c b/arch/x86/kvm/vmx/posted_intr.c
index 457a5b21c9d3..29804dfa826c 100644
--- a/arch/x86/kvm/vmx/posted_intr.c
+++ b/arch/x86/kvm/vmx/posted_intr.c
@@ -262,7 +262,7 @@ bool pi_has_pending_interrupt(struct kvm_vcpu *vcpu)
  */
 void vmx_pi_start_bypass(struct kvm *kvm)
 {
-	if (!kvm_arch_has_irq_bypass())
+	if (WARN_ON_ONCE(!vmx_can_use_vtd_pi(kvm)))
 		return;
 
 	kvm_make_all_cpus_request(kvm, KVM_REQ_UNBLOCK);
-- 
2.49.0.504.g3bcea36a83-goog

