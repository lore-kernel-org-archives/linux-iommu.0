Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE8F32AAA9
	for <iommu@lists.linux.dev>; Mon, 17 Nov 2025 18:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763405311; cv=none; b=haUYVomzCQda3zl/WVIe33CK7Mn0ZcHaApbYwuoZG4oZpqJ3V7zbL3CPByVx4bg6KaL6Ia4AjZaNKGLMZ7shIb/2TtF1LfNT6qj3zsHP7O+sS/TyFHIf+sOTsS1da/aZ1geLsF/2zTpIoAStst+DcmakMn0/QwCyPGu9Qswf97g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763405311; c=relaxed/simple;
	bh=4IqE8xy28CzdZK+AF2L6odntz8pjMNLJKCMqqsIJDbk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YVUM7CSziWIlrKeBt2Q1CpW4wiP3+BPnznhRvE+UR3QMNDGzX0pFRmMyZFUBorHLck2IIurP1RkFTruCsKOB/AaI7IwiyO7829r/7Re7JSqOqZqQuRBetW6urREsfmP+euQUNOb3urJ5nNjlfkaaKxGolP0qVFbaDP+A3LbsumA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D3u5JaIs; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D3u5JaIs"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4775d8428e8so55307115e9.0
        for <iommu@lists.linux.dev>; Mon, 17 Nov 2025 10:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763405307; x=1764010107; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gey9r3BX8+q00LlBjzU+MZugMloP0I19eNAirMDKs/Y=;
        b=D3u5JaIspObfjT/d6Bg5fPscKwOSHGxslKwpUR8UM7KgOCKSUNmjrupKCnQJPErhEh
         rZA2v8QpVDAMw+K4vY5Rcvq8ywwet1hIVZbGcWS9UgMZoX6FiNwbuOyCxLYd4Iix+3tO
         HVRJhVmlYG/5RcMZ/egBQvvSFHZqbOU4wlyKZc9Qj68P1SKAWCBkhwWbNYyXbLkOLxWO
         PUUUDG/A6jhXMnfrmRHkZXGLafBbe8AwfvYzbhIUZZD7KiAXLznI98jFAlLNEWhInvNA
         SSx+x19zr8LesEtPgi2S71L5OmfhUe/SbQwlvxYA9svVCMW/OTuYnOTCNkTeur+gmiUH
         biIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763405307; x=1764010107;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gey9r3BX8+q00LlBjzU+MZugMloP0I19eNAirMDKs/Y=;
        b=Rl9TUmJF2gd8sQeHuWBtQzb/mUJ9+3SG/FLfGMAzwZ82rM22H4AdnV4rF9UOsvvsfB
         ufDDBjcWO17QMk3WV9C0sejs8l+pC6FrVVrDx672tCEUJk9U3lmJKJNeOneRrV0dl2oB
         Kw6mmGGQa/iOta6u/83fxaYK2ytqA93WcLlpJsYc2RtoM+5s3Yy6tTmUs6qpngp+6He4
         zCJrHdFUpKZu5dPiJCrnld3CAGM5JZM/fP5AySTNuu7fKxSm3nK58E0zhp5wDa1NtUfA
         tUxMtenxeXNtmuF0dN8w9NL83svvVJUXrbNTwAO4FUI0qbeEzBRnZ6f6sS44WRRvK4xI
         pFqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuxUDR5m/CuAdZ3DWvODbjAMolRj7Tlwa/OjUEsZjxuGn5d0UBYWpzKiZUHghEAtvz3uZytQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyprNjm2CwCorEwvEIqtLw1xoO3ocS2FcMyY4YGYPlrP/ZA1wYD
	VJhi8eXqGeFSi2PAClsoHcxCfUZXthxf4FMab8cPoJ6n8NCSvXoGyIPc4Z6g6NiYRcYyRzTfbNb
	NHVqQ3dGxxxrnPQ==
X-Google-Smtp-Source: AGHT+IELZ+q3N1lhluRpg0RwaEHfI9/MWh02IHmoZQ//qg9i+LZm5h9SGh+IdmhWZuUmmhd2BHNm41tOgYJ4fA==
X-Received: from wmqt6.prod.google.com ([2002:a05:600c:1986:b0:46e:37d6:c1a6])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4f93:b0:46e:7247:cbc0 with SMTP id 5b1f17b1804b1-4778fe6654dmr122626225e9.18.1763405307068;
 Mon, 17 Nov 2025 10:48:27 -0800 (PST)
Date: Mon, 17 Nov 2025 18:47:48 +0000
In-Reply-To: <20251117184815.1027271-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20251117184815.1027271-1-smostafa@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251117184815.1027271-2-smostafa@google.com>
Subject: [PATCH v5 01/27] KVM: arm64: Add a new function to donate memory with prot
From: Mostafa Saleh <smostafa@google.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kvmarm@lists.linux.dev, iommu@lists.linux.dev
Cc: catalin.marinas@arm.com, will@kernel.org, maz@kernel.org, 
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, joro@8bytes.org, jean-philippe@linaro.org, jgg@ziepe.ca, 
	praan@google.com, danielmentz@google.com, mark.rutland@arm.com, 
	qperret@google.com, tabba@google.com, Mostafa Saleh <smostafa@google.com>
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
index ddc8beb55eee..434b1d6aa49e 100644
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
 
+	WARN_ON((prot & KVM_PGTABLE_PROT_RWX) != KVM_PGTABLE_PROT_RW);
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
2.52.0.rc1.455.g30608eb744-goog

