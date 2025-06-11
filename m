Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1CF2D323F
	for <iommu@lists.linux.dev>; Wed, 11 Jun 2025 22:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749682049; cv=none; b=VDDZFRBwSZKXQSvg8IPqytSZPiWft6d5Mf/uA81Kuwvqcbw7b26+TsvKmb7ZluRDd1fQYkN7xd3U7AXeS8M5vJPGQKR9iKaD2OcldP5eT4Jw10HO2PXN7adW08+P8aDIYiGYAjNZdj0yuBHaafpHpGuWd56vdRk2whKglbdcKCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749682049; c=relaxed/simple;
	bh=J6zOinbkdgKylugz+qVBm+Q6AqKeqc/V4kq3h/NovvU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PrnTG4HWpl0AgOhNbvkQp7KoJPzTlVJnX8zNG14DktqftSN+Wt0mgPxXYTq5VXbviaY7agNryHB0mmLRigzcfIszX+a7PNxmyABf7cumaDNJGHmTktYM3veVLovjno1HVUrmGbUsQNJHiRptr70Zn7PAgFA2gSJCPRPp5SO19k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s/dXYUYU; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s/dXYUYU"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b26db9af463so265736a12.2
        for <iommu@lists.linux.dev>; Wed, 11 Jun 2025 15:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749682047; x=1750286847; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=trIKCr3BKTnnj1sqkKg+yTyCPFnaZ4cJOVW948+vsJc=;
        b=s/dXYUYUh3bZzUY35XbbpgZmFtIvYAydm94/4itaQ2GKedPxvDzdMqFAIRlgvR+Ltm
         bY98z9RrKhkPrsuXhD2vDSF+Jz7+KeXPlyYVlr2dAHKM9BNZJI1P6jW0c0t/NkAUq2zh
         r/+Z61gjT7Lwl7x/S3MnDDxQ2ijYYXFqmohO0DcYstzQpXYZB0D6JHwoBJyG91GOWz0H
         un1MfBLNj2FVJGIuogChfRnh5rFSa/Qhfs6FCs1ZiSZP9qGIZP2inhLHHyv2AROdAVDj
         CMPVSHjRLslOkvoTVlIKUFjtgf3C/PflNAWPV0sS/IsGsqpmsb2PNs4iPOAHWu07r9H4
         HxeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749682047; x=1750286847;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=trIKCr3BKTnnj1sqkKg+yTyCPFnaZ4cJOVW948+vsJc=;
        b=C4F2AdlrrNyqcBxB250lhlMFShKgpUS8eA2/cVrvRi4jPskqBusOWX8ZWRqIUl6857
         9Jxu2jzUV05lo7co3r2+9mE9uWTHNMQc3xRqtplduoF4L/R39l1E6zBGjR6BRO5kDKEi
         dwRkXh6C/RITTaDnKSRoKmdqS1Vj0pXgb081iuVUge+mvsr4Mm/Tk2w2Aa+oZjNZAy5O
         PtVVsm8BmTgxqVz57M+3zmZnj8LIV+BqkaM+eemIBD1LJL2MwRDn9prEMNb8Ile54kEU
         2tsRUcFAAtYIspFdlclWo/Ox9cPofViS/P6fAB6fWaAY7kC5R6aIF36arMaqyLxFbD/e
         xsOw==
X-Forwarded-Encrypted: i=1; AJvYcCXP3wznByvEUo/wdXxgdbiaEAEhyR+uVSFcn31AX0lrafpsOC6uapahyIbDAi9a1Km/BeO5ww==@lists.linux.dev
X-Gm-Message-State: AOJu0Yypcm/5T31kjOc5J94JYmkQTDMVWvH5AUE5XD7/7v38d5LVYH7c
	Als/XbGirS97OxSobT9DGws7R9IfDb/Obe+HxyrKobIUjxRm9mEF1XQHCIaeJRljcpUV+2IzaHv
	oJBBypA==
X-Google-Smtp-Source: AGHT+IF+r3WoBv41JnZ3zMdtBzjsIX3MU1bEitF46j7ZacLy0t9sYOOvunU4WNhpDLaXzfE8bRA/KcgnWWk=
X-Received: from pji7.prod.google.com ([2002:a17:90b:3fc7:b0:312:3b05:5f44])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3508:b0:312:eaea:afa1
 with SMTP id 98e67ed59e1d1-313c08cfd2emr946409a91.29.1749682047052; Wed, 11
 Jun 2025 15:47:27 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 11 Jun 2025 15:45:21 -0700
In-Reply-To: <20250611224604.313496-2-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250611224604.313496-2-seanjc@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250611224604.313496-20-seanjc@google.com>
Subject: [PATCH v3 18/62] KVM: SVM: Disable (x2)AVIC IPI virtualization if CPU
 has erratum #1235
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Joerg Roedel <joro@8bytes.org>, 
	David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
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
2.50.0.rc1.591.g9c95f17f64-goog

