Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473902701D2
	for <iommu@lists.linux.dev>; Mon, 28 Jul 2025 17:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753725215; cv=none; b=FtUNQp9eEmb/ejhSUql0vD+jOABJ8vwyNw7jKGghVwlt8YGUCt/aVTU6r16ZqxJdsf4L/mqWhAtO1SloFH8706kHHlwYnrWNDa1mZGHOlHz2gkNqS3NZjFjBvsQax3WQOYjFZTs8K27tVBxVH+KEXOEorseUT4Zy5iFPiDrB6fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753725215; c=relaxed/simple;
	bh=J1SjK0vWeBplkdbTTJcUjjcnej2Z63ZcY6P/gYDg268=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uj4AmnBraZPNxjBB1xiB7dc/SSVClrOqrN87ojCoJ/VLDHJ7ZwOpi6brGbbxhDHR8ipsK26qaF7+zbCqJF9UAMBf8t747Oq1xo7f8lV+gwiqggnAJWUOtIVlKP0srkbhMl5Q1HIXV+UUqqCYr5jOqa9w0RVikUkioNlXVMyoQw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XUdXQ9jd; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XUdXQ9jd"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-455f79a2a16so34727265e9.2
        for <iommu@lists.linux.dev>; Mon, 28 Jul 2025 10:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753725211; x=1754330011; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZeRx7vP/138KQFxr0SX14a6MVSvUsa68vsZQFRiGNJw=;
        b=XUdXQ9jdjgTr3NS7/crZLpUFUUwQig+gaPL+8X/h14yoDB6czlwQMz2ijka53QmDE6
         e+RnPbk8CIkuTFqMz6EgwsLjymCNxb0pbgqFijQMAYIbv0EJ5L5HBTBrv54pyChRk4GR
         0XJm5XWo/LLalf9/HjwtBhH1wf+NcplnjA6QO4RJyVtTTGfdFHPQyNce//gdvbvfYYuq
         JstjVR5Cxj+ux9Q6bf8d8CM/OU38H+KBjxLYNen1Ax6C1LlsYTflUTBeMfaPXyWKiFWB
         QQ8Y6jcwTdGUBQz1AS6Sl/DWo7DDnkZl6Sa/2dd1yutwSx9Eah/ne0ASoYiCU0q6LfpL
         JNQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753725211; x=1754330011;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZeRx7vP/138KQFxr0SX14a6MVSvUsa68vsZQFRiGNJw=;
        b=etCkI8LC/dPIwte62gz1Ir84mq04gXA37BHI5971hpIWA1MOmpysqso2nRDUIYbAJV
         oVTjfYnuV2z2we6DXQ7qfsjSYwF7BndWgUU8XFhyv7RSCOcSmG6Ii/BHh4hHhjOBJ1uM
         Un8bLHcAYnXaJsACjAI+dhiQW6r8Z+6SBXhvbzz9IMfU6+79u/NgBpvmW7rOqHpruJsa
         30lUpQ6KrIf+d151nG1FSCE9gVaqxa0DeDCDHPUAKPQ0ZVIo2E0lmId5hbFyB/w01diu
         MsNwyr/3H6UOJCO1/DdcSwEsmApcnNTf3MnTj0e+uzKQAyx3QlwCGVpH50oR4KFFFQ4l
         AfCg==
X-Forwarded-Encrypted: i=1; AJvYcCXhjpmEoXGVxmWo7ul8vn0yFHpQ13Vg3OyaWa44zGAapSt0SBU0Qjg9FGMqvTolTrie4r5VcQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YysTgJWkNZRWy12RykCs6+vytrwPRbR3sFTxvWuWYPGaaX2etYO
	fP4ySk88z5pOAUZP7H/7Cv6ln9XYLLtUPZF6Hc6OGhwleD1W28xUswtn+S5FufaRD8EGhDpDUuN
	kRLXUvYRZ7+3xtw==
X-Google-Smtp-Source: AGHT+IE1QKRH8xd41th/Qwnod5XKPsVgVqg7Mv68PdXhnIKZKddzbjKbt+QRa+9zTDVfDxi6tBL2YQdZsrDI2Q==
X-Received: from wmsp14.prod.google.com ([2002:a05:600c:1d8e:b0:456:c7c:3165])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:138c:b0:456:58e:318e with SMTP id 5b1f17b1804b1-458852534ecmr52353185e9.30.1753725211674;
 Mon, 28 Jul 2025 10:53:31 -0700 (PDT)
Date: Mon, 28 Jul 2025 17:52:48 +0000
In-Reply-To: <20250728175316.3706196-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250728175316.3706196-1-smostafa@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250728175316.3706196-2-smostafa@google.com>
Subject: [PATCH v3 01/29] KVM: arm64: Add a new function to donate memory with prot
From: Mostafa Saleh <smostafa@google.com>
To: linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Cc: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, 
	will@kernel.org, robin.murphy@arm.com, jean-philippe@linaro.org, 
	qperret@google.com, tabba@google.com, jgg@ziepe.ca, mark.rutland@arm.com, 
	praan@google.com, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

Soon, IOMMU drivers running in the hypervisor might interact with
non-coherent devices, so it needs a mechanism to map memory as
non cacheable.
Add ___pkvm_host_donate_hyp() which accepts a new argument for prot,
so the driver can add KVM_PGTABLE_PROT_NORMAL_NC.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |  1 +
 arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 11 +++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
index 5f9d56754e39..52d7ee91e18c 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
@@ -36,6 +36,7 @@ int __pkvm_prot_finalize(void);
 int __pkvm_host_share_hyp(u64 pfn);
 int __pkvm_host_unshare_hyp(u64 pfn);
 int __pkvm_host_donate_hyp(u64 pfn, u64 nr_pages);
+int ___pkvm_host_donate_hyp(u64 pfn, u64 nr_pages, enum kvm_pgtable_prot prot);
 int __pkvm_hyp_donate_host(u64 pfn, u64 nr_pages);
 int __pkvm_host_share_ffa(u64 pfn, u64 nr_pages);
 int __pkvm_host_unshare_ffa(u64 pfn, u64 nr_pages);
diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index 8957734d6183..861e448183fd 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -769,13 +769,15 @@ int __pkvm_host_unshare_hyp(u64 pfn)
 	return ret;
 }
 
-int __pkvm_host_donate_hyp(u64 pfn, u64 nr_pages)
+int ___pkvm_host_donate_hyp(u64 pfn, u64 nr_pages, enum kvm_pgtable_prot prot)
 {
 	u64 phys = hyp_pfn_to_phys(pfn);
 	u64 size = PAGE_SIZE * nr_pages;
 	void *virt = __hyp_va(phys);
 	int ret;
 
+	WARN_ON(prot & KVM_PGTABLE_PROT_X);
+
 	host_lock_component();
 	hyp_lock_component();
 
@@ -787,7 +789,7 @@ int __pkvm_host_donate_hyp(u64 pfn, u64 nr_pages)
 		goto unlock;
 
 	__hyp_set_page_state_range(phys, size, PKVM_PAGE_OWNED);
-	WARN_ON(pkvm_create_mappings_locked(virt, virt + size, PAGE_HYP));
+	WARN_ON(pkvm_create_mappings_locked(virt, virt + size, prot));
 	WARN_ON(host_stage2_set_owner_locked(phys, size, PKVM_ID_HYP));
 
 unlock:
@@ -797,6 +799,11 @@ int __pkvm_host_donate_hyp(u64 pfn, u64 nr_pages)
 	return ret;
 }
 
+int __pkvm_host_donate_hyp(u64 pfn, u64 nr_pages)
+{
+	return ___pkvm_host_donate_hyp(pfn, nr_pages, PAGE_HYP);
+}
+
 int __pkvm_hyp_donate_host(u64 pfn, u64 nr_pages)
 {
 	u64 phys = hyp_pfn_to_phys(pfn);
-- 
2.50.1.552.g942d659e1b-goog

