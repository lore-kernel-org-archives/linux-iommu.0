Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4770327A446
	for <iommu@lists.linux.dev>; Fri, 23 May 2025 01:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747962054; cv=none; b=He2RSUp6D3Jg1bVS6MAyWcpouO21EPAtpHwh4L6JK9SoS/DsHLqsOlyqYLhMd73YmV8zZN1dFP3tiWjjsI/zGwEjJnijTuEzVpx2CS00RoEm8JoWcgH6PKVepUlWxNct78/tGfI5N5t8oWaKpnl0LZxzNJjur6xxgvEHxjEe/W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747962054; c=relaxed/simple;
	bh=jRCSdoFCqMKn8jTYzEDiHtmp4OccuyujV8O7UeMdZj8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TuvvL/qCK3R1pmrrCpPQkup2AG7qNgI/aErwMzmrpORDXNevwvcL1Mc30PtVp8ogecSmxZpsNjDf4fuzSUTo+sd2n0qNJvnLOM7Mhic7qFenPM4AoCGK0Pf9ZmaivzYUtL2kDLa9RU8BWy91POz0p6E5QrPv5OoJEA9rbfTijS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OMqboJ6c; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OMqboJ6c"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-30e74ee960aso6839075a91.3
        for <iommu@lists.linux.dev>; Thu, 22 May 2025 18:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747962053; x=1748566853; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=hG0IAIiIYv3kAH9AK2gcTVyZB3y4/6He2P464UJI1dU=;
        b=OMqboJ6cv67+dlaqvQ+A+hdjbJp3zpfjDt81g3YSTLWpNzz85XZkszjrwJu9xzK6Eb
         hv/F8FlrDfMv5Um3Fr+yH+ZyylotlACuHB9q/qgKmJaF70TYQtoMOJTzY9jrBtAv9jHn
         mjlVvneWEdKlzkROIpjbmgvw/E5sqTYC9EKmcPqaINjSE7+MITeOyxm9Sd6YbdNr8BYR
         WLAeYCtGAXK45IVhYnirBXurVsd6aslCIr7dyNwHRRLh725Zu3+TRad+M6YuhNlCqIxp
         KrR/BFZO6xN/XaxjOwMSlJmwVu+4YlKjfeIcu0QIFFqz3M4HJCXxrVA0l1KeJRt278fH
         WQ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747962053; x=1748566853;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hG0IAIiIYv3kAH9AK2gcTVyZB3y4/6He2P464UJI1dU=;
        b=w3lHhS3h7cQ2H08Z7i/op9CDvUAMsR/YMWZifEympoNE1FfOqIkjajYYhQwRveq6vc
         LqZDuj8LFgvGi7phKYbyjjfWR29Bnn4Oo5kk18+MepmB55aSe9SAognblYbeOADCIkly
         ZVgBEXtdfCepKRcg7nBbagTAfLQFqN0oluuev45n6UHXE664bRrDIXjlhb4z7+h+JQ94
         3Ww7q1juiFzoZnlMevBRVnK7xGyXsZtOgAKKuwNBWzk4Akzn7vb9dLRJBxhrdE58JyFZ
         L1E3UIdvhuxn300pTNU2KShDMsqEOQ8QoRfmmUIZyISz/a56ppnj/zRgTcBH4tB7Y8U5
         lxrg==
X-Forwarded-Encrypted: i=1; AJvYcCXDuHqmc3/XB7jT/5gmAjhKQO2+BD+swiNdScDynULNgEn91ylSPdSY0truy8NutFdPlzVVJQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzyYSQw8M050N9Pvf+9KZIjhv87MuCvVnems82GdShvUQZIn/kA
	cP9CtueFtZP6NCBv01JW0hWo6e8LHUYO3eSd0a6trOSImZOKToZXI51rjHKq2x7Pfc3FK28x/eo
	XyBiAHg==
X-Google-Smtp-Source: AGHT+IGmy5pPbJfwDE9rf/Cqih7MqBWbBVfwVzubGvYONxB6zdFJ/6ZU0L0cNDAY5jG/p/nKPtIes2/D6Og=
X-Received: from pjb6.prod.google.com ([2002:a17:90b:2f06:b0:2f8:49ad:406c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:57e8:b0:30a:255c:9d10
 with SMTP id 98e67ed59e1d1-30e830e87f6mr38952255a91.8.1747962052715; Thu, 22
 May 2025 18:00:52 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 May 2025 17:59:30 -0700
In-Reply-To: <20250523010004.3240643-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250523010004.3240643-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523010004.3240643-26-seanjc@google.com>
Subject: [PATCH v2 25/59] KVM: x86: Nullify irqfd->producer after updating IRTEs
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Sairaj Kodilkar <sarunkod@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	Francesco Lavra <francescolavra.fl@gmail.com>, David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Nullify irqfd->producer (when it's going away) _after_ updating IRTEs so
that the producer can be queried during the update.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/irq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kvm/irq.c b/arch/x86/kvm/irq.c
index 3f75b8130c3b..6374a7cf8664 100644
--- a/arch/x86/kvm/irq.c
+++ b/arch/x86/kvm/irq.c
@@ -549,7 +549,6 @@ void kvm_arch_irq_bypass_del_producer(struct irq_bypass_consumer *cons,
 	 * KVM must relinquish control of the IRTE.
 	 */
 	spin_lock_irq(&kvm->irqfds.lock);
-	irqfd->producer = NULL;
 
 	if (irqfd->irq_entry.type == KVM_IRQ_ROUTING_MSI) {
 		ret = kvm_x86_call(pi_update_irte)(irqfd, irqfd->kvm, prod->irq,
@@ -558,10 +557,10 @@ void kvm_arch_irq_bypass_del_producer(struct irq_bypass_consumer *cons,
 			pr_info("irq bypass consumer (token %p) unregistration fails: %d\n",
 				irqfd->consumer.token, ret);
 	}
+	irqfd->producer = NULL;
 
 	spin_unlock_irq(&kvm->irqfds.lock);
 
-
 	kvm_arch_end_assignment(irqfd->kvm);
 }
 
-- 
2.49.0.1151.ga128411c76-goog

