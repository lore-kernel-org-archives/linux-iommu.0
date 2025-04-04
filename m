Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E619224E4A9
	for <iommu@lists.linux.dev>; Fri,  4 Apr 2025 19:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743795692; cv=none; b=oQPhDcSNCaTuTvvohinglyPTY+yJtRF+hjnW0hHOaY98hdGIRRRuIzWUDyII145peoR/1YB6a0D9ALfRcZKotRqo1ZSaLJXmzQvhWoBMBgp0EqzOqjx6clfIbpx0Vvwg6Cn096ZLwqSkwDb2MKMrK4JUKCoa3uVnCpnriKJ4jro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743795692; c=relaxed/simple;
	bh=LM/a78fswUxarIaB9yJdchQ9AVFZwyJ7vf9uPLLFAxs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LlaKd25FrQklQGf2xkCyU/aX25BiYgJjCgsgwu7ZigLImGb5XP7iSchQ51VeBGRh9sJmCB6YcCCY5iy/GpF8oVY1ovIcdjJAXgxmVYpCQmah+mTsqH8VfV3g4ACPWsSfMOKuctWbWOSDGdV81ySmpTQldnzz7Th911N61AvcksU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lM4tmKoU; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lM4tmKoU"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7394772635dso1803303b3a.0
        for <iommu@lists.linux.dev>; Fri, 04 Apr 2025 12:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743795690; x=1744400490; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=WUo/P/nbSyKSB7hDI08Ajk4szbLYpfhAgRQ1J5OUkMU=;
        b=lM4tmKoUWYDm72se37lJwrCkSuBzS7G+UerKJ9WhfZkxyUXNMa+fd512btrGTEcqfh
         cErkW2RST9lMmJAoZis0CKOsVhMvAHEc7eLeXIzSFZ8HuaUzzEZYtPj9Gh9E65hXA0sF
         hpdmWK7VZW8cDAWKE8fowwiE2NfnmdbshdR26e96o4zPWIWwpLvb08Fkx4cPSEybBVV8
         FZfmEGbsbZkoiGKb7SmxSAVJJeSNSwCj5AVICwG530ZZ7K5bfm3vFBi/kVEyg8egli/w
         iGWHi0zTu6lUtC9YZauO4JrvG1T+IftgE6RyM8pNe7c3CmzZjNvIpvPD4SnSylyv9eDO
         YAPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743795690; x=1744400490;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WUo/P/nbSyKSB7hDI08Ajk4szbLYpfhAgRQ1J5OUkMU=;
        b=QuQpPirs2t7WHDVv7dYl8HWkR3vEQBpuNVcCMyAnXiKZe6QZJb5myMlA2MH99fdA/Y
         kKNenaI+MrlOKABBUp4GkRHVARHjaXSnIs7KgJJqXGlN5Ff/fQYc7Lk7OaRIoB753bMu
         yvUtr8n3nDJN/4/vasQyF5KeCHKzM2Zi8U5sbLE2cfTr669OrppmbebC0wOvaX3cpvoA
         Ied/fNno6fx+QMCzD80x50gRS2RPZHzH3kRP/d1RhjG0OhuSavfWHO4ICBhqf2vynbjm
         jqqW5EFU/OI/dvj9A5E8ePaevucumaQsEmzkqaEhn/bzjTvTNL/wiejApnMD4SlzMwMp
         CY8w==
X-Forwarded-Encrypted: i=1; AJvYcCWShLwxGVoakd0WGiFlTZt+nUa+XqCntRUvli80zG5dScD++QYUv9chjWTIG9O9W1CffxWSZA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxU71libnEa1UJGyHZwgMlfmnAR1yD+p8R5fF10D2uml84mIUT5
	9T5dJratyY2VLRb2VqGRv/jH3q794VSDauyyhaJN7SMna/n/PHIAZvzCHWe9l8KEcH/jAjprWGT
	rJQ==
X-Google-Smtp-Source: AGHT+IFrffkAJKPjpzU/UB+RZgd+9eYfpIMh5YaMNutNyipzajp2Id7VaNjJc8C8Wc5drn94Lg1LW0x5Xkw=
X-Received: from pfbld6.prod.google.com ([2002:a05:6a00:4f86:b0:737:30c9:fe46])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:130a:b0:725:96f2:9e63
 with SMTP id d2e1a72fcca58-739e4b7b2bdmr6930633b3a.24.1743795690483; Fri, 04
 Apr 2025 12:41:30 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  4 Apr 2025 12:39:15 -0700
In-Reply-To: <20250404193923.1413163-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250404193923.1413163-61-seanjc@google.com>
Subject: [PATCH 60/67] iommu/amd: WARN if KVM calls GA IRTE helpers without
 virtual APIC support
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

WARN if KVM attempts to update IRTE entries when virtual APIC isn't fully
supported, as KVM should guard all such calls on IRQ posting being enabled.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 drivers/iommu/amd/iommu.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index a881fad027fd..2e016b98fa1b 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3793,8 +3793,10 @@ int amd_iommu_update_ga(int cpu, void *data)
 	struct amd_ir_data *ir_data = (struct amd_ir_data *)data;
 	struct irte_ga *entry = (struct irte_ga *) ir_data->entry;
 
-	if (!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir) ||
-	    !entry || !entry->lo.fields_vapic.guest_mode)
+	if (WARN_ON_ONCE(!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir)))
+		return -EINVAL;
+
+	if (!entry || !entry->lo.fields_vapic.guest_mode)
 		return 0;
 
 	if (!ir_data->iommu)
@@ -3813,7 +3815,10 @@ int amd_iommu_activate_guest_mode(void *data, int cpu)
 	struct irte_ga *entry = (struct irte_ga *) ir_data->entry;
 	u64 valid;
 
-	if (!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir) || !entry)
+	if (WARN_ON_ONCE(!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir)))
+		return -EINVAL;
+
+	if (!entry)
 		return 0;
 
 	valid = entry->lo.fields_vapic.valid;
@@ -3842,8 +3847,10 @@ int amd_iommu_deactivate_guest_mode(void *data)
 	struct irq_cfg *cfg = ir_data->cfg;
 	u64 valid;
 
-	if (!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir) ||
-	    !entry || !entry->lo.fields_vapic.guest_mode)
+	if (WARN_ON_ONCE(!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir)))
+		return -EINVAL;
+
+	if (!entry || !entry->lo.fields_vapic.guest_mode)
 		return 0;
 
 	valid = entry->lo.fields_remap.valid;
-- 
2.49.0.504.g3bcea36a83-goog

