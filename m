Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A97229B0C
	for <iommu@lists.linux.dev>; Fri,  4 Apr 2025 19:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743795627; cv=none; b=ptejOZj+9DqZ2jsn6BwG8fn8T2NDKeGjnoSRkBNxt5a43dT4Ml4V39IxDzSDVwYJR2lfY7x3fYCxVnCfocAsSExDCcc4CuLsMjuyOnTZo6tGh8n79TxEOo7JPraOi2xjyoMlneATyyZkKswsF8wBcOgZzstB5KfEl9v7ZUqvRp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743795627; c=relaxed/simple;
	bh=UU0Srm9ir/IuonBFXeQo8x1rxrol77G2fsdv1A/P49Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ffynnwqvb+licYAt3UBK/IktgDyhK3156wNbyMBLge2HHw2qrp6ndkzPrT3WhNrjoh16yXVyY+mn146m78GtVgt4vNjO2EKpJ5cfDkBk+13C7HTLOL5zr9i6ft+J5BJDouyja1No3n7tTSZVvlpdKRm6uI4PVd+nqv8AH7eCUXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qrAny7Ic; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qrAny7Ic"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-739071bdf2eso1813456b3a.2
        for <iommu@lists.linux.dev>; Fri, 04 Apr 2025 12:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743795625; x=1744400425; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=lSWfLEFHgxrxwFBenufoQIAU5IDy2E3h/30rrI47RK0=;
        b=qrAny7Ic23KvkUZ1BrPrzOwsBGhmHw0L7JwQaPnvvjwUvydH3OLD5zu5kUlK9ucdJq
         o6ERZ9iral78op3E3Si3hGFV9TZj0iy6zdC7S0w3JoQTDLToDJr9A3PwljeNwxGS2U6S
         gqXkK1U6Sy5JzYGkv+1+26p5ePlHLplQnU4pEA6J1tkfd4D0GbLXyr9As8LdJ5IlTBgs
         obih94yPg/evK5ZSeLl3DEjbrm2TFbFk85HlwrzSzcZwmGyZcINZx2b+GM6PMZSDEbX4
         Cb9jtuQbI1c1haKj9D4enL7Gn4GVJAhIJwJwmf/k3MhQ6bF/FkadB52GPwvyg1NUE6JC
         pgig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743795625; x=1744400425;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lSWfLEFHgxrxwFBenufoQIAU5IDy2E3h/30rrI47RK0=;
        b=LqHX+Xi7fsOYh0cev4WrNh/aywzW9ZgkG2H6Nd1uKhH+SRhKYLZgA6hSdH4RXKYELR
         dACHSm9MN+udzZ8AbPHvKUotGSECxBmwNPFmQ2WYQxjPqjLAfGSwkXgcMM/LD3v7eIGI
         uul+iblVZ/Ufyd3uCacn92YpmZ5TEPLsfVhUE1m+oK+06X6rURy61v8ddVkit3WPG0bU
         m3aPAjt944ChKTAdHwxhmpKsSV11A3TdJJbiv6/ZCUOraJbyHFg9kzqt3zFee1aVa1EX
         ++iL6P+ee3Y/Yyi/NfASrzcrBI5LU06u+LsAQ2/GE0380mqG1zMz5UBFHe00gmKIkwnN
         SKlQ==
X-Forwarded-Encrypted: i=1; AJvYcCX17PyWB1zi2hrOtBacarGlyRhMZHU7X4tODanoSmVlRZXcX1A+n2pN9tOGJEQ6vg9rENXUzg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxLcFriY4KJeoNwC/hXw/LpZ/YsgWGkRQleL7DGGjYrZUglvtHF
	u71yC7zXNztc+Y60YUPo5d7Ssi9miKPXMhBtSioTOafo8VyGz67sRh0E8mN63+XGvsrj5/bMHJa
	nmQ==
X-Google-Smtp-Source: AGHT+IEtlaa9i6xhVrmng7fmvBFIIniBMBstQlCiIyFf9+8ses6o9CMRLUsjMBJaIcUpUnWLOYu2dil1vbU=
X-Received: from pgc8.prod.google.com ([2002:a05:6a02:2f88:b0:af8:c3c6:e3f1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:168e:b0:1f5:59e5:8ad2
 with SMTP id adf61e73a8af0-20113c7136bmr786221637.24.1743795625080; Fri, 04
 Apr 2025 12:40:25 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  4 Apr 2025 12:38:37 -0700
In-Reply-To: <20250404193923.1413163-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250404193923.1413163-23-seanjc@google.com>
Subject: [PATCH 22/67] KVM: SVM: Disable (x2)AVIC IPI virtualization if CPU
 has erratum #1235
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Maxim Levitsky <mlevitsk@redhat.com>

Disable IPI virtualization on AMD Family 17h CPUs (Zen2 and Zen1), as
hardware doesn't reliably detect changes to the 'IsRunning' bit during ICR
write emulation, and might fail to VM-Exit on the sending vCPU, if
IsRunning was recently cleared.

The absence of the VM-Exit leads to KVM not waking (or triggering nested
VM-Exit) of the target vCPU(s) of the IPI, which can lead to hung vCPUs,
unbounded delays in L2 execution, etc.

To workaround the erratum, simply disable IPI virtualization, which
prevents KVM from setting IsRunning and thus eliminates the race where
hardware sees a stale IsRunning=1.  As a result, all ICR writes (except
when "Self" shorthand is used) will VM-Exit and therefore be correctly
emulated by KVM.

Disabling IPI virtualization does carry a performance penalty, but
benchmarkng shows that enabling AVIC without IPI virtualization is still
much better than not using AVIC at all, because AVIC still accelerates
posted interrupts and the receiving end of the IPIs.

Note, when virtualizaing Self-IPIs, the CPU skips reading the physical ID
table and updates the vIRR directly (because the vCPU is by definition
actively running), i.e. Self-IPI isn't susceptible to the erratum *and*
is still accelerated by hardware.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
[sean: rebase, massage changelog, disallow user override]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index eea362cd415d..aba3f9d2ad02 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -1199,6 +1199,14 @@ bool avic_hardware_setup(void)
 	if (x2avic_enabled)
 		pr_info("x2AVIC enabled\n");
 
+	/*
+	 * Disable IPI virtualization for AMD Family 17h CPUs (Zen1 and Zen2)
+	 * due to erratum 1235, which results in missed GA log events and thus
+	 * missed wake events for blocking vCPUs due to the CPU failing to see
+	 * a software update to clear IsRunning.
+	 */
+	enable_ipiv = enable_ipiv && boot_cpu_data.x86 != 0x17;
+
 	amd_iommu_register_ga_log_notifier(&avic_ga_log_notifier);
 
 	return true;
-- 
2.49.0.504.g3bcea36a83-goog

