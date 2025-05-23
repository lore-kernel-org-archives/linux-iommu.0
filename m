Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664412D29B7
	for <iommu@lists.linux.dev>; Fri, 23 May 2025 01:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747962087; cv=none; b=As9uDpEA+0bdQJzPtcrz7Gq3QeE9rGpncdKpDascz8tQzNjkdVOH/VUFWvOIb+zpLq0FuWfdNieiHEccq2tthzPtmAFAVi3j8ptJHyvgoXgsomnhce0GlRrPP+YUg2IH76H/B4ObiSFkrJcfADx81Avtq0IPvxO4SyHZDp6pjbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747962087; c=relaxed/simple;
	bh=55qjTgWoCAqQ0qlezLcudUP6UhJvdAn22WKHfJ6neN0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aC/H0PYctwMMi5xW7jCLO69mtQAknk4Z231GW31yrEDrkhXJXtD1zIuXD+sJhNW6jyrYMhwNWRLeH5K7BFhG3FC/gtV48O+JmcdANOdxg1mIu9tPT9uqWz2BeGF9oLqrw4rmw8bQbtkltzMpMqXtiX7WEbbS5IaYM/oPmHsOo8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xJcIO6WQ; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xJcIO6WQ"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-30ebf91d150so7040209a91.0
        for <iommu@lists.linux.dev>; Thu, 22 May 2025 18:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747962085; x=1748566885; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=gUhbzbIFz6N1ly0iEWpzNSdv8WcFPzr+G6Brn0aKnfs=;
        b=xJcIO6WQpzRZPXCq+jlYD0ZDsaowudaKNf0cpxwEohoZImjGVR7pwePywpgggXbQKh
         FUzcItQgX0O/dEix4h+vFCfFbKQox+FF+jgIpcFUqjO+LZmUZhQ5fViY+X4DThP4OpCF
         gPICq1DlC1QDYeeiL8GoRyR1n+AP+6C+q7tM+OhXJaND802tHbUesm11Q9ASfwgKTvv7
         CPKV39d/miIIDX+IgHx/Lg6V4w48sIHSi4/EyV/zNDqz16zenLkJ9ORrwVqh8siqIrXd
         vKr5MiHfOlCKozLoLC/AEyOP/5YvJCgIfjKg0MVLZv0JUa3cpncFizb+l4P1L+2cxFua
         dDbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747962085; x=1748566885;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gUhbzbIFz6N1ly0iEWpzNSdv8WcFPzr+G6Brn0aKnfs=;
        b=csb4GdTIQnHrYJfP1cDv9+V/Dl8Bxg5dVEW6YF6Q/IdzO4J5OdJ6HdzQmGPnv5xS9I
         m5S7nVwCA42fsyOO/mAb845IcczDs/knUP2N3NFUly1MMCpn3tcoVp0CxOQHfD2Wj+Ti
         OV2EsnkX1kzHuoXx8id01GsqynlN/4hjUNZtpmvweabGw0dUDlOfRqrVZZ95r/ad28Rn
         K8x8titUUEUWI7RGzFRGA+Pysl+XDu0A7OPx0hJM6LjygxF/P/I+0VwEgK+6ZGtORtYB
         bjQkQxybI2AO39QfwO/piTZyZ+LrYc/nhYV376peWxu6qIvecvFRRnKHAaH3hoODFwl+
         39Ng==
X-Forwarded-Encrypted: i=1; AJvYcCWtw2I3Gn5vy22yE36W0BNMTp7MMOzlU7y/vI2SD5mwr+djqd28dzCC1Xdgg7+7xiD5KJ9B4A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxM+I4mdm1r+7ymC+BsvMRBqQuET4HuErbE+ylORYExGKVdbXqY
	lZLBNHNtPWrK+ea4l+uDFknZSW04mYsFZH7F17VoqSgAis50LONwzMehg7HCF2nhhBGjKkMcIFk
	LLGsd/g==
X-Google-Smtp-Source: AGHT+IFmNcRCVGsHwu2ASi0oy2rdhg/Fb0rUQuE9H39VclrV/Td0/+Bcwnto5U4Ohf9/HGIiubwzMKlglKw=
X-Received: from pjbnb5.prod.google.com ([2002:a17:90b:35c5:b0:30a:8ffa:9154])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:17d0:b0:2ff:53ad:a0ec
 with SMTP id 98e67ed59e1d1-30e7d57f38bmr34769259a91.21.1747962084260; Thu, 22
 May 2025 18:01:24 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 May 2025 17:59:49 -0700
In-Reply-To: <20250523010004.3240643-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250523010004.3240643-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523010004.3240643-45-seanjc@google.com>
Subject: [PATCH v2 44/59] KVM: SVM: WARN if (de)activating guest mode in IOMMU fails
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
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
2.49.0.1151.ga128411c76-goog

