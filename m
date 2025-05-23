Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EC42D29C3
	for <iommu@lists.linux.dev>; Fri, 23 May 2025 01:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747962089; cv=none; b=HVOYmuRw6hL9+Mt+dlakwdYj0RImJ2LZ7hTZXAnzaTAIymaq5MJ1NmLpfWJmTRYqxTSsZh3Ge8AQFAV+iWLSc2Qk+4gfucbNnhP/qyq3eOMMNHw/doIXOZQuVl2B9T35OzZ01BVaSFRvlsv2P+inL6TOr3vvIlLE7P+WFT/f1T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747962089; c=relaxed/simple;
	bh=8SrQ+oKGvvTIJysid8Rxw5XPwDm17oKx2xAyAvAXgIw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qlVh0XHyZoHqBxHV57EDX/Fa0g5GB4wbMMoHuOGU6kv95vcvgIE4nbIJWvyHX012c2N/nQGD/mew9YF0AULwn43o9lA0xNnLPdppYrD0eNxx2CAfbtJtQ0hqu73RA7Z2HZ0mvUlVcqS6fkyWoeKPTaTL/7ldPa3lgQ5zvgUjB3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ulftJ56e; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ulftJ56e"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-232340ba283so4275335ad.0
        for <iommu@lists.linux.dev>; Thu, 22 May 2025 18:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747962086; x=1748566886; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Nv/wXOYxNnKgHAHyhi8Vk/t+dWw1N4nnlsKYjly3sjA=;
        b=ulftJ56esPU7LWni0It9N6R2XHoU70oSAE2qyeXTFJZSdDQnaRlWgGmH9A7aCh9pJW
         MuXEIJJJsktWPSm3cldNNxmHPAvP9rPiTo/59yhtKlz5PptzvpA7fgbamyumAr3Z9lTd
         RXfZM4Fbdo7gBblFXftNSroX8qU197+kf+eaAWFeukZ49PMdpRbTjBTCxwEWbQNCrNvq
         /nncisg1ykooEyDrw4CBhyDP3AVkKtr9tL1svn4FjkkghoOB8EfcWiM9kh/V6wgkv8d3
         Mjqmdl+leikwOsRQArF3yhRADYsWQw0Z41lYtk3LjbRH/lpdEENtvXILFr9kdO+8+NOO
         BHhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747962086; x=1748566886;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nv/wXOYxNnKgHAHyhi8Vk/t+dWw1N4nnlsKYjly3sjA=;
        b=mWf9CJHZ5bIfLyggXfSM2gZ+uXzwH8xbw13KxJ4seGyIbb45aAnc3tbHbgIH8F973t
         C7lvPRZJMcAa729rPcWICit4jg78jisQnP2YMTkDYtDl9ay0xGW+pszqWwmTJAGhkhJe
         JWdJLnSB/LY6KBt2QzFdBzrilVYP5njmO0GxoE+YkH5w2fjPkKurR7Cbcj5Qy60h/TS+
         gfoEmAyU/jB9cOU+vwZZBdkkxTuB9vZ2n10yDr10UBkp8N1lx/IA8KYlvW2UbIiOHmjd
         zZxZfHJhADGF5j3STdCLnH+Ai+zoaJRyoGSpz2VcRZvckb8qlY47THB3rEatk6DG5xtL
         N/OA==
X-Forwarded-Encrypted: i=1; AJvYcCWV+z2FubcFMqwlfh6rYzRAn7FkfmZbXayoUwaRw3yTfRFuO9SJKVc8GZD7oEG4n+eyqR3GUw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxPnCwKfu3ATK05YCNMBMCfKeygKJMORxJgFV+iKdTKwnvKbsH6
	SJacGRyb30DlvsC1Dh6o6Zr3gs27Tbg0YAcaz6d6EX4ty3O6gi3JfrM87PKzL3T1x0yT1K9Peaa
	dd4xsVg==
X-Google-Smtp-Source: AGHT+IF3/E0iVH/vlMLWt9XVgizbCsZM8J/q2ciZDlo+jMfmZ18HWLQgxdx78gP0A2Hywms02HUD6gsHXw4=
X-Received: from pjbnd7.prod.google.com ([2002:a17:90b:4cc7:b0:2fa:1fac:2695])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:46cb:b0:231:fc4b:c04
 with SMTP id d9443c01a7336-233f06ba057mr20489615ad.17.1747962086040; Thu, 22
 May 2025 18:01:26 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 May 2025 17:59:50 -0700
In-Reply-To: <20250523010004.3240643-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250523010004.3240643-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523010004.3240643-46-seanjc@google.com>
Subject: [PATCH v2 45/59] KVM: SVM: Process all IRTEs on affinity change even
 if one update fails
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Sairaj Kodilkar <sarunkod@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	Francesco Lavra <francescolavra.fl@gmail.com>, David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

When updating IRTE GA fields, keep processing all other IRTEs if an update
fails, as not updating later entries risks making a bad situation worse.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 6048cd90e731..24e07f075646 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -849,12 +849,10 @@ static inline int avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int cpu
 	if (list_empty(&svm->ir_list))
 		return 0;
 
-	list_for_each_entry(irqfd, &svm->ir_list, vcpu_list) {
+	list_for_each_entry(irqfd, &svm->ir_list, vcpu_list)
 		ret = amd_iommu_update_ga(cpu, irqfd->irq_bypass_data);
-		if (ret)
-			return ret;
-	}
-	return 0;
+
+	return ret;
 }
 
 void avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
-- 
2.49.0.1151.ga128411c76-goog

