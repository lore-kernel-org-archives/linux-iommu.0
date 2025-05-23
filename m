Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C733521CC41
	for <iommu@lists.linux.dev>; Fri, 23 May 2025 01:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747962024; cv=none; b=AU1//b60346X/nvPg5rZntUMP3qpSO99+L5JIFVOkSeh3lSssD+FTnzadB7ODMI5BKK8m5sHLNtZs7n4zNnxaek6oxwXhuwv1yDLFWcl4qlQJ5CDlloFcIHIrqdLCbOVVo6QgDOaYLexHJVxVEGqvbz+uoGBxOv54YGeROQ6FPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747962024; c=relaxed/simple;
	bh=aNmoBC5BL5ItcJ/WDwb3zDPcOis7QcSa1BwF4a2ekgY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RR6529ZNjAgTuPZN5vhxWeb+cPm+zgHIUuwYBU0O+EyL01UhdktVhytQqufuMjHmVYtrK0AMvF1x9iA/PKIr97qolepHeX4IlNfvgJyijE0TdMMQ6GOguHk0WvyoXeNaCsBKPJOVNIS1j/p8UT+Q7HopJbXCOhpdyhJzHIa5hPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U6Bg0Sl6; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U6Bg0Sl6"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-30e8346b49cso7253164a91.0
        for <iommu@lists.linux.dev>; Thu, 22 May 2025 18:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747962021; x=1748566821; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=RwZHc1ywJBDFGfINHhpI7dwV0ed9uFhVGKRmUUyRiuk=;
        b=U6Bg0Sl6iGVM9WfrRC3mdNnRqTfY3lTU1NVepB8sxruf5PImO4nDmPabfG5P46lra0
         PN8Dlk1irOVrNnYiQKX1joSOf3MH2UXErszvB4oeu/0nArWJh5vS21zOkKJA1j+aemkG
         avrrw06r2ce3UJG8nGJZdPhyifAN5YPflh+MILWJYqfRnsba4lcvXfLzUqUcWs2YAsPb
         hQsWJ0vBxRqJZTPRjrZiBMyBTIfq5Ehci6s3ng0WfqJ5snVVXhnEqvvZmjaCYC2UXPyG
         5hNxbgIpRF82VgiHTobn8VBi6VuPP4oaKK6WThBEFjeRAUzmBs9cso0P/UsG+UaZISHM
         gzmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747962021; x=1748566821;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RwZHc1ywJBDFGfINHhpI7dwV0ed9uFhVGKRmUUyRiuk=;
        b=kfyCqMAZzwTD8v8k2HubGzIoNwz/WZx+pI7YOHrfcPstoKMxdufIfgTvtuTj18oxuW
         xu+/CjAkARp3+xyWZgx7zmxSu328BQcZw0PrVvgnMP/D+9htkqO3DYuHoKIUFddh2TyG
         LMxQBY5vjz34DzJqUfs5TIpappJeYVRVhmsrVP2gG1EN/X29OvvLU00CHdQecjXAT5Qs
         nVzGZMKggACvPgP/DbWSUTD17AdBKztgpPgGGuh2ZPR7QSqSDbeyotl9hBW4EltksQjC
         Su/zNij/ACNSfhUTYv2d5EboJdL7sfHklD/G2p29cBY/X0Y8WnUiJ6Rait4BelvukJSr
         iZBg==
X-Forwarded-Encrypted: i=1; AJvYcCW9BcdBywE59F/eEDppttYj3WrRkhAeDkCVUhi/LMtUuWc9UA2pOALyIsMLL6xPs/GeZHqMNg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyhdiSTTlWSuK61/quaGfHuysI1aaU6LHY3xKxyWmMRADWNWNOO
	vecjt2Tw1wg4MoG9wxESHW7XVtjv4Cje1YckLHAA6Gy3sLxoI52h8YdIDaIgp+YLPIR5hlEKALD
	u5y1ttw==
X-Google-Smtp-Source: AGHT+IFArGigRbQ3xY6m7aPjNKtLLh8N+euULRawZd3DzF9QWqKL/5ofHFtPHZbDhE4jbFVVScTN2jPKnTM=
X-Received: from pjbsg3.prod.google.com ([2002:a17:90b:5203:b0:301:1ea9:63b0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:35ca:b0:2ee:f440:53ed
 with SMTP id 98e67ed59e1d1-30e83228de0mr33805240a91.31.1747962021097; Thu, 22
 May 2025 18:00:21 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 May 2025 17:59:11 -0700
In-Reply-To: <20250523010004.3240643-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250523010004.3240643-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523010004.3240643-7-seanjc@google.com>
Subject: [PATCH v2 06/59] KVM: SVM: Drop pointless masking of default APIC
 base when setting V_APIC_BAR
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Sairaj Kodilkar <sarunkod@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	Francesco Lavra <francescolavra.fl@gmail.com>, David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Drop VMCB_AVIC_APIC_BAR_MASK, it's just a regurgitation of the maximum
theoretical 4KiB-aligned physical address, i.e. is not novel in any way,
and its only usage is to mask the default APIC base, which is 4KiB aligned
and (obviously) a legal physical address.

No functional change intended.

Tested-by: Sairaj Kodilkar <sarunkod@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/svm.h | 2 --
 arch/x86/kvm/svm/avic.c    | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index ad954a1a6656..89a666952b01 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -260,8 +260,6 @@ struct __attribute__ ((__packed__)) vmcb_control_area {
 
 #define AVIC_DOORBELL_PHYSICAL_ID_MASK			GENMASK_ULL(11, 0)
 
-#define VMCB_AVIC_APIC_BAR_MASK				0xFFFFFFFFFF000ULL
-
 #define AVIC_UNACCEL_ACCESS_WRITE_MASK		1
 #define AVIC_UNACCEL_ACCESS_OFFSET_MASK		0xFF0
 #define AVIC_UNACCEL_ACCESS_VECTOR_MASK		0xFFFFFFFF
diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index c981ce764b45..5344ae76c590 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -244,7 +244,7 @@ void avic_init_vmcb(struct vcpu_svm *svm, struct vmcb *vmcb)
 	vmcb->control.avic_backing_page = bpa & AVIC_HPA_MASK;
 	vmcb->control.avic_logical_id = lpa & AVIC_HPA_MASK;
 	vmcb->control.avic_physical_id = ppa & AVIC_HPA_MASK;
-	vmcb->control.avic_vapic_bar = APIC_DEFAULT_PHYS_BASE & VMCB_AVIC_APIC_BAR_MASK;
+	vmcb->control.avic_vapic_bar = APIC_DEFAULT_PHYS_BASE;
 
 	if (kvm_apicv_activated(svm->vcpu.kvm))
 		avic_activate_vmcb(svm);
-- 
2.49.0.1151.ga128411c76-goog

