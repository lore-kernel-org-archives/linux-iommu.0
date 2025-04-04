Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DAD23CEF9
	for <iommu@lists.linux.dev>; Fri,  4 Apr 2025 19:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743795672; cv=none; b=qxAUZMHKg8Z5tHOzTPgjGSOM1qfyH2YtG3JoDBk/+anMUNJKrNw+Znd9njzE356UFMuVChPfV2DlRNCYfDsVQyASDLcCqLmtfjdFqXsKNf7miWyhofRuZKcYfop0N0c7jXvMkMardzLqohYHMyLR8FSpNEtfj6pnEbTknFFGUeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743795672; c=relaxed/simple;
	bh=Jfmk9VzNRAADpmMGwdwa2xyHxXIJHx3CDbGZTsxqH1I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kieJefsDzMA6cOlK3BiPXXgP8YlDKoX9vn4NtgxCYCSWPs7v8pJywdlZhXlMCA6xEGihs+AQttt6ghZ7syRWosPuZ4vvowdvw263Y1zGvd38VD41hA1qDNYnqYyZO9H5MDfq0VoTAUng826AgYj9GyaM/iyzwV2M6/laV30IaEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qcVnjC0b; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qcVnjC0b"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-736abba8c5cso3047458b3a.2
        for <iommu@lists.linux.dev>; Fri, 04 Apr 2025 12:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743795670; x=1744400470; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=8P0F5+eRvzI1lxgpOCwvPttxPqLphUaIWfDndZq8iLM=;
        b=qcVnjC0beLkXeoUxeD0Ab3tb6WRzBn1jSTHjA7GE8G+g4gsJtgmy63iOG61nj4WK00
         k5ieOOjgdAD9FHBKNe0Hjp8P3US0pujmc6B9423Ato1c4tsRIxlOlahLSXeocnvCj4YA
         WpxBNZxOAQeewty6TEknU20ZeqK+/0qcn7CeVWidG2i6318iCD9VF82W47tRHhjRj76z
         VLJLYZG1quJJoaaYTDmTUa5zpbch+sYmPZMhkjeMcSVIoRVKESMgQ2O01jyeIg/13OfF
         BZPlaCYN1SFKDkPKIvlKrrPYdli7CedF9Wvz/OwMa1mnNrjqAStZy9dc80nxgR924NVE
         RmCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743795670; x=1744400470;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8P0F5+eRvzI1lxgpOCwvPttxPqLphUaIWfDndZq8iLM=;
        b=DHcCpHmyadjZvsYJmP5VXkbOJ0iMCeqR1Dx0/Dyf6En+WagOEZkM5SO+ORJSc2N/R9
         4BAEfFBLGDvQ9AG3+HRLgSxLVVPehZOc3RH7iasl7Ri6N1L5lnS8mu7m0CY3NjD9YLQd
         +fT99UKvc2+L0lSqeh2rJXN+ofUT/9+OA5X1RaXAOVnVlZLfLDN7TDuw1SzYHQnfpld2
         zHKpq9rIW7gDcxb9DSprWM6iUDZeUSW1TIOpa7mp1utO5+TDV6as7eO0T/4WPia3mPZz
         D9EAueu/9M+TTlpVFUaOzD8KH/jB/4l9EcaXLve/wan7P/6MTgKSOmEjwVWA9TvlWOp6
         WRIw==
X-Forwarded-Encrypted: i=1; AJvYcCXYqyg8gBaoWG1PHSXNKV+QetuLMmAf92KMkMDkMj+dp0KKeCeJispm/SRBxU6fJih2TG6VmQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxeWBFQcRAFFxctWWPpKkBuMpWie2Td85uTYfe9jmXee2/Cfi2c
	6Uq8bRqcdcqYQFQsac0hDAqnLKtd6Xwv7EQWQEmQS4Cvq38jMeZ+59UNNqIvexb8Zf08gKg71sa
	fjg==
X-Google-Smtp-Source: AGHT+IFM3a33R0/JqO8ZtaGkbV0mf76n3eZC+Ea2CS6FZilzIUeDNAaxDWzQnYTCiWaEXSrdeYzp/CG211k=
X-Received: from pfbho2.prod.google.com ([2002:a05:6a00:8802:b0:736:b315:f15e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:aa7:8893:0:b0:736:4704:d5da
 with SMTP id d2e1a72fcca58-739e7161560mr4999839b3a.22.1743795669704; Fri, 04
 Apr 2025 12:41:09 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  4 Apr 2025 12:39:03 -0700
In-Reply-To: <20250404193923.1413163-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250404193923.1413163-49-seanjc@google.com>
Subject: [PATCH 48/67] KVM: SVM: Don't check for assigned device(s) when
 updating affinity
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Don't bother checking if a VM has an assigned device when updating AVIC
vCPU affinity, querying ir_list is just as cheap and nothing prevents
racing with changes in device assignment.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 04bc1aa88dcc..fc06bb9cad88 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -857,9 +857,6 @@ static inline int avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int cpu
 
 	lockdep_assert_held(&svm->ir_list_lock);
 
-	if (!kvm_arch_has_assigned_device(vcpu->kvm))
-		return 0;
-
 	/*
 	 * Here, we go through the per-vcpu ir_list to update all existing
 	 * interrupt remapping table entry targeting this vcpu.
-- 
2.49.0.504.g3bcea36a83-goog

