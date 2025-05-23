Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8532080F4
	for <iommu@lists.linux.dev>; Fri, 23 May 2025 01:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747962040; cv=none; b=LeSBzIXvAe3FcMjY3QCf322YJSRQQwDihOTxCYM8/0gOBXA1VtNunhFD8BCVw+7Kz0W+Hi7Z1kPa1bjY+H1VNifVWDWvoFcKvD8vj94c1bSLOrG06X3KLaLTs1ysFYDV/te9/TdvLKzw1dOKN4i6FSX7agLZ/p8HreLO4W0TeOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747962040; c=relaxed/simple;
	bh=nHqa6WlMR0U01OJANRFGYwjUMNRNK2ND6QPMEXp4N18=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gVS/g7HOhYV3TCmvl+JGyZPyWbj+vv1mleyWEFcG9fJojUWj1zqG2YimFXjF/m6ENE9eyxaiBmoNdOQRkEptAAgOmEqmHrvR2JGL2RFo2yWOLg3PXTep3BSX/vuShfBXWPQSlifm9GkejL35WEpN4nJchXtnvQuZIm6bsGVGZ+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d5x0NkLR; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d5x0NkLR"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-30e9e81d4b0so8246130a91.3
        for <iommu@lists.linux.dev>; Thu, 22 May 2025 18:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747962038; x=1748566838; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=CxW6KKsPctpa5xxKfQSk3XBX60R5QhwquqFgbTrtuqU=;
        b=d5x0NkLRN+2pMPeVkspE0fFaj7aRJQa3qLGZOGgPzqkE3AmOOCgW6NxtmuOX9MPfMB
         eGvOyBm9xkNU/2QQypSjK1hjgrwUjYBEpJIuf0IZlX+WnuCO+Xftw31rFof0GCzw/7rh
         VWo9kxUzw+Pe1LBLKYapS+Hl9FYs2i8zcXi0QKvlSw5Y8Lguqjo8f62NdIyNwWdBPtYa
         bwNRuCyUWDM6wdOGL7FiCBuxihrYUmvlfl0dYVkBmCDAGO64/d0BTuNsfu0eDUWuVIOO
         sJKXhJeLdXgRcWnVp4rnNKL7qfWYRQfq6advtdJT0x0iNJc/gxPRBocYt94JkZB2LkK0
         2Ntg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747962038; x=1748566838;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CxW6KKsPctpa5xxKfQSk3XBX60R5QhwquqFgbTrtuqU=;
        b=NZRNAyn1oWuwX8cx3UkVtBvLlwR5mTNpAadkFcu8OCIW1pVVVYFNXErkpjbxmof56K
         2ucKKK5dtkajupUsJKoQl+ajdoDnynZUsId92D1tthfOjQNvBlRzZJZJ9sH9ZcwXjT18
         IplLtCxpygqTFFJpU+z66JTJPQOax/Ges7+ycdH2gmfqJuSQy2mroA1eO+x3ea5qm6Yj
         Vbg5HWZMA8W+AGzSBz0sG30XT8jymp5pfjX63mr+0IO8pC7S2SYzMLxGNkbJWFs+uGPd
         gBBnKRjW+SLFD4EcYxFY1StUs7krhehIpqcmjt93bOgXmSugehvI7ZmbQvT/2cx00jF5
         99fw==
X-Forwarded-Encrypted: i=1; AJvYcCVNZ7gbgbrBFFUxifa90Ql/R1y+yfZ/mT5UmzFj0Doq2dZliSQgHqgx116HuyzMR1zV/VbUew==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz/tJZZj/bFcqZs9eBQAwJPnfsK3a/ofC1rGIBYpdGI6j/XjecK
	v8/B5+iddMwesWIVo3iZBLU8e9bn6i6YiVBeygnQn4lUIPfIQGgA/SUc4mqipqh8C/7VYwc3Xi9
	JY7mUzg==
X-Google-Smtp-Source: AGHT+IHk8lbSET1s/ssqemmnc/hWnJF6h21Rp292LM1IvL/agAUDkDm3aH+8vSocZT0JgbvOwlT/Y0l6Lss=
X-Received: from pjbsi11.prod.google.com ([2002:a17:90b:528b:b0:30a:7c16:a1aa])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1dc2:b0:2ee:b2e6:4276
 with SMTP id 98e67ed59e1d1-30e8322593dmr39301128a91.27.1747962038018; Thu, 22
 May 2025 18:00:38 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 May 2025 17:59:21 -0700
In-Reply-To: <20250523010004.3240643-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250523010004.3240643-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523010004.3240643-17-seanjc@google.com>
Subject: [PATCH v2 16/59] KVM: SVM: Disable (x2)AVIC IPI virtualization if CPU
 has erratum #1235
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Sairaj Kodilkar <sarunkod@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	Francesco Lavra <francescolavra.fl@gmail.com>, David Matlack <dmatlack@google.com>
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
index 48c737e1200a..bf8b59556373 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -1187,6 +1187,14 @@ bool avic_hardware_setup(void)
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
2.49.0.1151.ga128411c76-goog

