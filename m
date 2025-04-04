Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D3823E324
	for <iommu@lists.linux.dev>; Fri,  4 Apr 2025 19:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743795673; cv=none; b=OOSwjBRBJogbXxjnYAIKfmrJCgq6cXl0aP+ijFnjdd0H4aQY7QNT+wSKCEuC3u7HZ9jwvdkp8U1mXLQWmvT9Y4/xVNRZ29jrWEA9TYzUHWcm8KVbN+Kh6P8LwA/a6vVLSl4kWleNYJ+jl6CxjzSZCajSRUYRdUfhwHK7iltaz2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743795673; c=relaxed/simple;
	bh=KYPkJmO2WKGa6Hqkv2jcYDUkv0LZapz25ye+QSx983M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PZl20tAQJXfAtMWMCUcGK0jzFpq/r2rWKKnvkAdliOv40JyY7CyDDD9zqEFeqPNYgwQlhJakE4/zfR2y91uKE4WKGEk11PgYHjnT0cLK9B0JbZ4Beyebm0JO+ptEHT09inevHvjWGSJ4mAgu0Be2OM7A9gHmyHZsZUbxAx74bNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LjA7Tt9M; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LjA7Tt9M"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7394792f83cso1891397b3a.3
        for <iommu@lists.linux.dev>; Fri, 04 Apr 2025 12:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743795671; x=1744400471; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=BuUmn/v/nxN4sDhjuaKZdNs4Kj9VqwHUaANP0XC6c7s=;
        b=LjA7Tt9METUdL3BXkBW1VtUxD3Kn90K15x48fjnf/o1duK+D1mGNjmpwEajqz74kjx
         1+DsonzDoBQ8LkOMcmXgc9OcynMbl1omSIR7sg3I+xo4tfyfS8MLSt/zRsXLwwG72f2L
         2y0ezBOYJyw7Ch+4yTMntH8rxxtnQYuh5Pa0YbyzF+vs0lxxOy/UhdM6+qETZp1PsVsn
         lhfHcTWhQhJuQcgyzBSlVivmerO/SMbiqUzAmlhYudmLQQlMVfz4Fox723Mk9Lk6hgT0
         295S5tiVU46Pd/ExVaPfeuPot+IAPKParqZKY4AyjIuELlCfHmeATcEt7XfEy2uNdKHP
         Hx/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743795671; x=1744400471;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BuUmn/v/nxN4sDhjuaKZdNs4Kj9VqwHUaANP0XC6c7s=;
        b=CaqiDsrR9pshQp8yx4FhL7pZZ3dD2O3ni2u+jjGbnyz63T9YHNgOlX8K2IcJNHrLhQ
         9qffvaoEJz4yEUrGQEHiIW3wAcatxABUxvSelr/ybidZE4NN4NlKY3Q9UKgyxjQ05tgN
         MfGB612ciIF6LFI2+0AYGE82TA+SohD/IKvT7uVsSBdr3meKeonXqGKzhPjx6/PA7ot/
         ZXS3GZfpvsBE0Nc6t/hZHjTSQYQs+vrH0FX3cMhrJM6eCcxAB3FDpuZQiN99ABJCmBek
         pCEb306BkIvxyS4cds0yvG1LzyTnXC6yLJdZdn8Buo7PlGr70A3Ua0quCS0r1KrI6nw2
         ASoA==
X-Forwarded-Encrypted: i=1; AJvYcCUhR8Aw+kJ5nd64vPnErZ0nw0Vhaxmg+BB5iYL0gIOeVpkehp6j0kJll6N911/7hJp++Dm1ow==@lists.linux.dev
X-Gm-Message-State: AOJu0YzJQPVB79kJNgmgHMBHEhs0EEEfyt8f78OaN54+ka6Sn3MkeLvS
	Hl6vtLJk3VAd4VQnxFZog2A+GGtDrgfpMzh3arygSQ8d/qcMCzMFqvgtj4C6E3VtDNfpmdndXhp
	2Jw==
X-Google-Smtp-Source: AGHT+IGn6VyFDYgNExRPxop+TDl4ttE1iIR8bH26Vp9Pjy1Orp1wUriDPA6oU50ESKKN1WjXv/GYXHS2yHo=
X-Received: from pfbjw34.prod.google.com ([2002:a05:6a00:92a2:b0:730:5761:84af])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4653:b0:736:a540:c9ad
 with SMTP id d2e1a72fcca58-73b6b8f82e9mr711650b3a.20.1743795671518; Fri, 04
 Apr 2025 12:41:11 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  4 Apr 2025 12:39:04 -0700
In-Reply-To: <20250404193923.1413163-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250404193923.1413163-50-seanjc@google.com>
Subject: [PATCH 49/67] KVM: SVM: Don't check for assigned device(s) when
 activating AVIC
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	David Matlack <dmatlack@google.com>
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
index fc06bb9cad88..620772e07993 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -741,9 +741,6 @@ static int avic_set_pi_irte_mode(struct kvm_vcpu *vcpu, bool activate)
 	struct amd_svm_iommu_ir *ir;
 	struct vcpu_svm *svm = to_svm(vcpu);
 
-	if (!kvm_arch_has_assigned_device(vcpu->kvm))
-		return 0;
-
 	/*
 	 * Here, we go through the per-vcpu ir_list to update all existing
 	 * interrupt remapping table entry targeting this vcpu.
-- 
2.49.0.504.g3bcea36a83-goog

