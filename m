Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D85327C158
	for <iommu@lists.linux.dev>; Fri, 23 May 2025 01:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747962060; cv=none; b=jMN81eWX8hxBnrhx7SW81LZz2hycU0pxwSM1dVKpzKsMOQDSK9Gys49v6iyf8CYg7y8EnRHyhf+oLKiM6Vp41EPH5HQ+y8HmPPQqixKiRUvUzmia93QT6p7EzopPLAc3UF0sPf/s+WIhUjl3pdAorv4G/l4mcI9TimDvx1qIwOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747962060; c=relaxed/simple;
	bh=3cDGPT4Fs5i3llYV6N7Z3zsG/IoHE6e+aDJIWGzC/ns=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o9qB0kJl7+AcKJwV6p+o6ehY1Cft3d6b6GcWxL9o2Y6jqf7aXoUAG9jP7PwMLkRjT4iAnucaiBhx0QMKXodH7nTF/O/i8vcP8P5B7zxocuetlmkv5d1F1hl2H+mk5kkOHbxPaE3HU0b8OODNW10XW2zRWEcWH606T4TC0trBrXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dNy6yvpL; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dNy6yvpL"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-30e6980471cso6962464a91.1
        for <iommu@lists.linux.dev>; Thu, 22 May 2025 18:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747962058; x=1748566858; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=MOfqSC9jfe6qWef3o61heciDY2fzEzj3IP2K1ebfjaE=;
        b=dNy6yvpLhm5yKeLxI9gFd061c2dg0M6xuZuRN2o1JT31IelvMTFlRPO0LCiOtyVmiF
         X3yismeo37QRti9V+A64l2rEPmlePWpeog/t1yI0MjYDTCnn/gUgYPJW9MzxKfRamblj
         haDWdDp6LIEZE+/A/7qd6Gzcrq5OzbTgCsE7bjnfKlD5fsK+NYBrrgoDmhHydKKNunmJ
         r2vnDHWYJyTKK3KdpKNPUPOwQc9zvKUfuozYfAAcCsUNGT9EVRrpj6LuAlDlVD2L7iFf
         ejO1IH4H76jTxo7uNk3aYFK7CcEBKIcKDkTb2lHHNJ2ZjpAu4mgO0iWSA9+QYShZrnpr
         88rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747962058; x=1748566858;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MOfqSC9jfe6qWef3o61heciDY2fzEzj3IP2K1ebfjaE=;
        b=peGis992YKNRfqYpMyyM3aK0/h8alIhUBauKOYYXpwFhanskmQCyNqBgYeZUzuNi0b
         LWXf542n6L9iQA0/mMNLgY94T7/39bgAqSe/gpWwHFGlOospjqmUeuQJdk6VqTCa+7po
         XxhfqZBbw/8qhVpkPMEePnYdcr2n0z0NBW9MjN9BePiBdF5ujGP2OIDmVzzN/XTAWv0U
         a8SeJ3Twge/htFJFJN+dCg56MqZOez9pQcdXFqtiBCe/DG6V0DcvbxcJNQV/H7t5iICt
         ceLGHWX5Tw1E4/GbDeNiMAwi131XJrda/lrIIyAmvho0GyqyLmqoQWGjILTRXbdhDCWY
         P+Ew==
X-Forwarded-Encrypted: i=1; AJvYcCWNb5Y+EbHT8LJbaMj9GHfA3zpbZzr5tE5PP3jrIp1+KlBfNUd2DMHxXtW1Dotq7YGAwIOxig==@lists.linux.dev
X-Gm-Message-State: AOJu0YyRyAviydMtFAgowne7fA5MqqjA7IjStDTvDrJM2rpt0NZrdNL/
	0J33THNl87qhBRHZmWuCyIbgHRbgsWxMuP7n5JxKUzhe012e9581kyeYMykES6IpBJPTcCmM58S
	qZcp5dQ==
X-Google-Smtp-Source: AGHT+IGbnIYZKIV7+UM33kPe0GOe3t9BK31wvtSS50odFLwVDGUrD18GfGcmK5AWEuZ0hAkPUYG529hmiGs=
X-Received: from pja13.prod.google.com ([2002:a17:90b:548d:b0:2ef:786a:1835])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3b86:b0:30e:8c5d:8f8
 with SMTP id 98e67ed59e1d1-30e8c5d09b3mr44883074a91.14.1747962057767; Thu, 22
 May 2025 18:00:57 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 May 2025 17:59:33 -0700
In-Reply-To: <20250523010004.3240643-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250523010004.3240643-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523010004.3240643-29-seanjc@google.com>
Subject: [PATCH v2 28/59] KVM: SVM: Clean up return handling in avic_pi_update_irte()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Sairaj Kodilkar <sarunkod@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	Francesco Lavra <francescolavra.fl@gmail.com>, David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Clean up the return paths for avic_pi_update_irte() now that the
refactoring dust has settled.

Opportunistically drop the pr_err() on IRTE update failures.  Logging that
a failure occurred without _any_ context is quite useless.

Tested-by: Sairaj Kodilkar <sarunkod@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index d8d50b8f14bb..a0f3cdd2ea3f 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -807,8 +807,6 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 			unsigned int host_irq, uint32_t guest_irq,
 			struct kvm_vcpu *vcpu, u32 vector)
 {
-	int ret = 0;
-
 	/*
 	 * If the IRQ was affined to a different vCPU, remove the IRTE metadata
 	 * from the *previous* vCPU's list.
@@ -838,8 +836,11 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 			.is_guest_mode = true,
 			.vcpu_data = &vcpu_info,
 		};
+		int ret;
 
 		ret = irq_set_vcpu_affinity(host_irq, &pi);
+		if (ret)
+			return ret;
 
 		/**
 		 * Here, we successfully setting up vcpu affinity in
@@ -848,20 +849,9 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 		 * we can reference to them directly when we update vcpu
 		 * scheduling information in IOMMU irte.
 		 */
-		if (!ret)
-			ret = svm_ir_list_add(to_svm(vcpu), irqfd, &pi);
-	} else {
-		ret = irq_set_vcpu_affinity(host_irq, NULL);
+		return svm_ir_list_add(to_svm(vcpu), irqfd, &pi);
 	}
-
-	if (ret < 0) {
-		pr_err("%s: failed to update PI IRTE\n", __func__);
-		goto out;
-	}
-
-	ret = 0;
-out:
-	return ret;
+	return irq_set_vcpu_affinity(host_irq, NULL);
 }
 
 static inline int
-- 
2.49.0.1151.ga128411c76-goog

