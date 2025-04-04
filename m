Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE8C22332A
	for <iommu@lists.linux.dev>; Fri,  4 Apr 2025 19:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743795608; cv=none; b=L0SEgqJ4/jyKPrnp/4/Co3/UYA9ltz9qB1fsYB4ZxeF42MPXi4+ngnGvbUCtnCMgmph23XCaCzctkTTPJ7aTRnzaxUVMJyuXy57D2ikjImCHXificfmInHz48aZeIvE9lYwS5OTWYnhvZhu2T6JvT4hh9lt//opsBDzNZ/VP7yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743795608; c=relaxed/simple;
	bh=ymgLNvDMBazjcOWHdM4TRBB8fRza/15wPWUAsosttHc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WZOxByxtx8SYKN2NN4XxwbQqxhjzA1avVeW5j1c+88VJo4T7K4Gs2wj/4DNSALJgPGoze9ha0jgtcajPrfDehAbw1jQaE86TJGr288y/skY2TqvzKeQiGGdvN62csQU/ugPWSsuzpTTG8W+Ts0fIN3GNx9EhE2zPp1010ftOh2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4qZ7Hb4l; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4qZ7Hb4l"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-736c7d0d35aso3405450b3a.1
        for <iommu@lists.linux.dev>; Fri, 04 Apr 2025 12:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743795606; x=1744400406; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=FiKuf+KLGMevEl1JcUq8+wDFjGbG6tG3veWOyXB7Hl0=;
        b=4qZ7Hb4lPeLX3lD32DmY/owoa+6iQCYeg7Q9tsXIiayZNBw0QtSXpys/szt1vvLQTb
         j0fV5lW8kuyrGCS52bWYw33rFhAou0aWHQ0Oz6nH9jrdhuOirlXz/IPgoLPHWklt5Rlc
         vMVI8mZjooN4dkZJe8xcScoUx52x5k32eOV91PD5wilC2rNBq7Xzj7/LdI47mPe50uN3
         yWmnpWc/rbf+AE3/MbNJ+kTF6F3e+5zV1DLAeNHElnwwxELLUBUuF4Ux4JCmxUzo0VqH
         pKImYE4zUFKDsv0cBy5on4jeAZbugdOZgQM7CA9VO2P9qz8rVeQHeBb3aYCPTbQzkZSc
         M3Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743795606; x=1744400406;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FiKuf+KLGMevEl1JcUq8+wDFjGbG6tG3veWOyXB7Hl0=;
        b=ix2ppn58VpGo1oa34DalT/GUSRDy2KWSFDqRYJQwvg2tPSnX5p/XNfR/caTP49XWp7
         7L3/Sr+/vL5jzFDCmbzlqwmGb5JZW4uevILBIBgmEca0QX13f+gSoSFg4VwOhXx4Jtie
         zP43ITVYeetrq0lhf4bgGv6rumCe0P0+nrTLE6iOdGir+w7603E0KBkIlxkIh4gPVBQR
         v7Ky6nRLaQ38KLnW1HkqkEzoOqxYEOkAn5Z8W6M2/kN+LcMqmAvPhk5DOFR7PZXWyWRi
         rOjCOOKaqyKhtKdi+G1e9x1X/tubV1WxNBUAb+0AUiUVYF+TfS/LAT2IG6YHBzc6NyJv
         BuaA==
X-Forwarded-Encrypted: i=1; AJvYcCVcBmpWBSXICGwkmbKpyKjKBKh3xKxnbZ6sAlKOpmNYp3afERjEswCMOBb+0p7hMAC7j8Dy0Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YyQHSL85dg+IAlF33XlRVMm0EIJGFQqitNUt8TMVfdVHzTIMOMk
	ERliNHjb8FoKxIUX2GBaNiwe0wX63RaPSut8Tn186bwcu5fIEm4SvHuXuH4WjlGJiTuigG+tgPC
	7Vg==
X-Google-Smtp-Source: AGHT+IFtyda/QQ9X0Y9KdE3cg1eDpGK8RDILaxqr6131sPdJg3+eJBnN0Hdt1DkeEPmuLwr7hr23wisO9LY=
X-Received: from pfoi21.prod.google.com ([2002:aa7:87d5:0:b0:732:6c92:3f75])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1941:b0:736:4e02:c543
 with SMTP id d2e1a72fcca58-73b6aa3d952mr644845b3a.9.1743795605825; Fri, 04
 Apr 2025 12:40:05 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  4 Apr 2025 12:38:26 -0700
In-Reply-To: <20250404193923.1413163-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250404193923.1413163-12-seanjc@google.com>
Subject: [PATCH 11/67] KVM: SVM: Delete IRTE link from previous vCPU
 irrespective of new routing
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Delete the IRTE link from the previous vCPU irrespective of the new
routing state.  This is a glorified nop (only the ordering changes), as
both the "posting" and "remapped" mode paths pre-delete the link.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 02b6f0007436..e9ded2488a0b 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -870,6 +870,12 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 	if (!kvm_arch_has_assigned_device(kvm) || !kvm_arch_has_irq_bypass())
 		return 0;
 
+	/*
+	 * If the IRQ was affined to a different vCPU, remove the IRTE metadata
+	 * from the *previous* vCPU's list.
+	 */
+	svm_ir_list_del(irqfd);
+
 	pr_debug("SVM: %s: host_irq=%#x, guest_irq=%#x, set=%#x\n",
 		 __func__, host_irq, guest_irq, set);
 
@@ -892,8 +898,6 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 
 		WARN_ON_ONCE(new && memcmp(e, new, sizeof(*new)));
 
-		svm_ir_list_del(irqfd);
-
 		/**
 		 * Here, we setup with legacy mode in the following cases:
 		 * 1. When cannot target interrupt to a specific vcpu.
-- 
2.49.0.504.g3bcea36a83-goog

