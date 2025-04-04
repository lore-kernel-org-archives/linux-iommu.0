Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AD7221542
	for <iommu@lists.linux.dev>; Fri,  4 Apr 2025 19:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743795597; cv=none; b=ZQYJBOqIr7xWGJHQBkQONhpzMSf6vEEoTHeCCo7//yis4MfZWTn52kBPbjrhrPGXzIucg0KVdNg23+I6ioSfF30eHEJSx1RnuGBAv23I79oLo1ckZr5Ju4q2aFcTWbawm/nF27kfoAvHhr6TjzZW8pTPagfyitajHbyQeR6icrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743795597; c=relaxed/simple;
	bh=El/LUiSqQ2qSjpNZ7D93xQ4xLdhReczWf1b9uZIPSLc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sV94odjt9r/I6VjeTtlZ3sXLcMTgBlCEqxXrzWhKb4UFVSyJOVHPy0DoOftWC3g3lVx/SD+7lhlGKz3uajpCOnPecjG53J2nBNqNbO4KY//EHaim4oHOIyoJhFJQl+ViYadFjW88SzaSSWcM/jl86UPLOA7YMfVMkB8wJLPHIw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aleg/4W7; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aleg/4W7"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-73720b253fcso2037073b3a.2
        for <iommu@lists.linux.dev>; Fri, 04 Apr 2025 12:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743795596; x=1744400396; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=9j6UAaWlpuGUtNDZ5PloVVAXeMJcTkL+Ix626QW6lmA=;
        b=aleg/4W7nnXkWhUD6Xtx35C6DJoE10MLVOYFSgHYV3bLeSTkveI6Cj1ZCP7Wl4k9tB
         ouLgDiT8dyD+3JA8FqxcfHC6B1+KSv+FVwoMv0PJmKZfZntf34ovLvOfbmpS/Yyu4TJa
         LuNwLmBcOlf8yIMbkEUxUpGQUqB/HAUPe0dRnoHxLgdo8he88/Jr7KCUtomSeXsjuFBv
         kneKgupO40+17/Rkbm9V0xQ+v4rDemIN8QXXbM7G5fiybtW84lE3q9lDkkB26qECHpqM
         6yyt1i5QldX53PMl2u/ShvbqxXnzznbxDoq8RJM2uCwO9q2yQoG7fBci0ufUOQEKw0MQ
         7vgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743795596; x=1744400396;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9j6UAaWlpuGUtNDZ5PloVVAXeMJcTkL+Ix626QW6lmA=;
        b=fOQcZ9lmOcFvtZ81Y2LZVzZH3XhUySKveEB6QmNl4aXRln2dUqXgvKUZGnCapIshe9
         De5yqW2X1tnmPKmq7SrMkbFezLpYc5+pPzPpj9WsXIDQo6VVzktqpFTSQm6OshDv9j/3
         0AASsd9rRtujJKDrGg82nMqi7wE8ir0qCGliimgDm4vMD1oEYU2xbiShElawixp9Q25R
         nk392g0SbGySQoP4NhYqCUwQG695xrtzSKE7bVP69U/sx80rFfH3ejN0IBLekC434a0+
         gEbPCkVPuxdzQ7xoWzy/9Wtocy7p8J5HcSAypQOSSWGbfT/vzwxBS4T2w9GadHKuxaXt
         o1cA==
X-Forwarded-Encrypted: i=1; AJvYcCX9LNvoR7wuHKpvScE+uAw1SmwNw+AccsAb70LMHBL3xQoygl26O813867p9gOEqMFb8uduqQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwnJY5A5JuUhVup8tL6YaJsKbf4296tt7oIOORKei5/Mrj5fcRE
	M+GLDp6DOy054elGKKvq7vUE6V78901gR5QWkkUEXyB3wu8tq97XB/Hs+PuBsnLn9XDZQF3Vqwj
	taQ==
X-Google-Smtp-Source: AGHT+IHxE6ieJP/dqM4OtZ03l/OzhOac1l4SZVj083VbfNgDZX7xJqOUlyT5SF6DOaOv2f4SNNau/XxOkn4=
X-Received: from pfbjo41.prod.google.com ([2002:a05:6a00:90a9:b0:736:3cd5:ba36])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3a0f:b0:736:4e0a:7e82
 with SMTP id d2e1a72fcca58-739e6ff6b10mr4756745b3a.10.1743795595718; Fri, 04
 Apr 2025 12:39:55 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  4 Apr 2025 12:38:20 -0700
In-Reply-To: <20250404193923.1413163-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250404193923.1413163-6-seanjc@google.com>
Subject: [PATCH 05/67] iommu/amd: Return an error if vCPU affinity is set for
 non-vCPU IRTE
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Return -EINVAL instead of success if amd_ir_set_vcpu_affinity() is
invoked without use_vapic; lying to KVM about whether or not the IRTE was
configured to post IRQs is all kinds of bad.

Fixes: d98de49a53e4 ("iommu/amd: Enable vAPIC interrupt remapping mode by default")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 drivers/iommu/amd/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index cd5116d8c3b2..b3a01b7757ee 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3850,7 +3850,7 @@ static int amd_ir_set_vcpu_affinity(struct irq_data *data, void *vcpu_info)
 	 * we should not modify the IRTE
 	 */
 	if (!dev_data || !dev_data->use_vapic)
-		return 0;
+		return -EINVAL;
 
 	ir_data->cfg = irqd_cfg(data);
 	pi_data->ir_data = ir_data;
-- 
2.49.0.504.g3bcea36a83-goog

