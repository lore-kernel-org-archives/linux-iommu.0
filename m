Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027ED2D8DA1
	for <iommu@lists.linux.dev>; Fri, 23 May 2025 01:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747962096; cv=none; b=Yq3hIx3jjIDufubjTZfkr1PJ4wV+PBeCMEeah6yhw5X4+fpeUrZ5T55E/rWT/wxr3LertL899PnEHnESu+7XyqWwv3fK0QjTSQk4uN+n+mhqKq65+zKyfcet1sUxeC97XCLV+E+BBsZbwISAeRWT1T3Ir+1GizYGdM7YeyOKVhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747962096; c=relaxed/simple;
	bh=WVXURqeG3/UNWGnPr4lCT0UQc8N7VixIfadV+aR9WaQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Nu9j0NfX5pdW4UuEwDMsvKs/c9ZUj0qv0rnhlNUWpv5jXpUC6Ic6bMPyDX47u8R9gT+E0ObXm9zofm9EbdMRpaKu4xdI8MhLBZdhzt7s5nQMJ1zvH/7yM2bw5MlZk35ssdnL+5PugqD6TK2ZhYr7kq8SRllIspMnML/OnI8175k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w5zRdqsq; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w5zRdqsq"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-30e8aec4689so7804507a91.0
        for <iommu@lists.linux.dev>; Thu, 22 May 2025 18:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747962094; x=1748566894; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=cN9xzWmJm1SC3MYFl35NGHuTlOxpMSXq5/uxL1rDnZU=;
        b=w5zRdqsqjF3JWWYD4+gNPq/ZyauUZrHtPQ2OlMSbhg/m0SRMXcgbfvsaGDkICPCo3z
         unAJvCWqFeD8rTxlIgKTVCWiTZuFXZ2Fo2lsctqHZkB6XJ+gE1lIRvNJxJ9oGZMBJzSg
         zmoUC253iL5ZfMafn0zzWiqi4oczddMunxLq4kHpEdt8Z+vy1c4AiyOzTaMbrFpVPHo/
         i6B8hMeSChZRE3g5m48nU1zd2OQoWPo0xUg1Er6ZSij0C1Z5M55tNzzyQY6tyWU6h+5S
         LuO6wdX37FHM8KrYkiU8/EbZ5gpgYbQcqDFfyhjBUq6lRB6VgVKjSgRJshUAbT61lz8Z
         heWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747962094; x=1748566894;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cN9xzWmJm1SC3MYFl35NGHuTlOxpMSXq5/uxL1rDnZU=;
        b=Y33XAD1tYMZXkBp0EJc9DgU2tPGuK0thkaHQSQxSsu20QangBOC+VJY3UApKfSeIBw
         oDh99rmq1OmsBmAoOVGPJ6AxLYKI+BYoo4e+obuIhi8iL5uDpmbGaVDxIS9TN2TVI6+s
         K0c/KAG32MNUWQ/oqAsqJbqoel4ayabzO1ZhnTsySVijazcE3hRohm78m38QrEQBpZy1
         zqKzboZjDJuRIRPTtVVLimVXFF+Zz8B6nbemLvEmiNTe+SkEY05WsuodOa7KTBDt2PX+
         OmgjNR2xgRA7HJ6p+yVJcEzN3crALUytGZtk6RmTXKenrlR+XWXqSMofn7vZLyhITkI+
         zxNg==
X-Forwarded-Encrypted: i=1; AJvYcCVUs+LG9GNJw12an+Ls1dbotxJ4gB+3mOzYPSlzF2/wDxXyfP4I2GfWaeI2g3YhTk/Bk5H1CA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzKJrLi4hYsF2Rv/4gqoP3PLKEwARYiy3F7H5bQAPNjgVWAEv1Q
	3SPqc/vymmSFMteVYynU0fNYAHDoldQ8EP1xwCboqL1sddg0bQce3Lr1P1N7KBA76zFVHkdP3xF
	N05fXgQ==
X-Google-Smtp-Source: AGHT+IFprTymTRANY7N/PSfhfS9BlgTEeP5l7IBzmCyjwM1JbIF1IL97OX8WDdXl0zNwJCd+TJHfF3OvfiE=
X-Received: from pjbnc5.prod.google.com ([2002:a17:90b:37c5:b0:30e:5bd5:880d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3bc8:b0:2ee:c291:765a
 with SMTP id 98e67ed59e1d1-310e96c5a47mr1898327a91.8.1747962094614; Thu, 22
 May 2025 18:01:34 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 May 2025 17:59:55 -0700
In-Reply-To: <20250523010004.3240643-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250523010004.3240643-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523010004.3240643-51-seanjc@google.com>
Subject: [PATCH v2 50/59] KVM: SVM: WARN if ir_list is non-empty at vCPU free
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Sairaj Kodilkar <sarunkod@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	Francesco Lavra <francescolavra.fl@gmail.com>, David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Now that AVIC IRTE tracking is in a mostly sane state, WARN if a vCPU is
freed with ir_list entries, i.e. if KVM leaves a dangling IRTE.

Initialize the per-vCPU interrupt remapping list and its lock even if AVIC
is disabled so that the WARN doesn't hit false positives (and so that KVM
doesn't need to call into AVIC code for a simple sanity check).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 5 +++--
 arch/x86/kvm/svm/svm.c  | 2 ++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index d1f7b35c1b02..c55cbb0610b4 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -704,6 +704,9 @@ int avic_init_vcpu(struct vcpu_svm *svm)
 	int ret;
 	struct kvm_vcpu *vcpu = &svm->vcpu;
 
+	INIT_LIST_HEAD(&svm->ir_list);
+	spin_lock_init(&svm->ir_list_lock);
+
 	if (!enable_apicv || !irqchip_in_kernel(vcpu->kvm))
 		return 0;
 
@@ -711,8 +714,6 @@ int avic_init_vcpu(struct vcpu_svm *svm)
 	if (ret)
 		return ret;
 
-	INIT_LIST_HEAD(&svm->ir_list);
-	spin_lock_init(&svm->ir_list_lock);
 	svm->dfr_reg = APIC_DFR_FLAT;
 
 	return ret;
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 56d11f7b4bef..2cd991062acb 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1497,6 +1497,8 @@ static void svm_vcpu_free(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
+	WARN_ON_ONCE(!list_empty(&svm->ir_list));
+
 	svm_leave_nested(vcpu);
 	svm_free_nested(svm);
 
-- 
2.49.0.1151.ga128411c76-goog

