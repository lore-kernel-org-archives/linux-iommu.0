Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EF221D3F9
	for <iommu@lists.linux.dev>; Fri,  4 Apr 2025 19:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743795591; cv=none; b=Mgd0Nk/P9+eEMGqu7wQQEN9brYh5jkm2lYf94n0fTPxouXliUuhUEvXrNoQW5xM91bg86sA/jym1hRCBWphFbmiDmORYwMtLvOxpHouWTdv7ptAeuk8Sd2t25t4/QIq7LnMT/jMqSe4B70Zmqybrf1FFvgn46DuHA5c5kUfgnMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743795591; c=relaxed/simple;
	bh=IYgl0oz7WYCethX5zdLJOxQN9YYu60K0fmwKqhu1/aQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YoY+2gvIU9Xg6n5hg5g4r9tpvyVzXjEmMkBtfO0FakF9MWoLwm1c9crK9dMxByms9vUgei+lSmsalLk37PqyZQhWo4r02tfGK8MJzxEdQUJT12OhlS38thDW2naBYt5laUpkELWM+OL1NSFDBLUmIuSDwdfySCBlSo+jzsmXGT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HK+tkryc; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HK+tkryc"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-736abba8c5cso3046166b3a.2
        for <iommu@lists.linux.dev>; Fri, 04 Apr 2025 12:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743795589; x=1744400389; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=G03Ks9vMONlbd+61V/+Erd91vdrZg3/ZspQO1qdkUD0=;
        b=HK+tkrycuLHAxHYgsrBnG+4Qjcpui5DoGLRMQwxv0L+DXdi352f365wXlP/rZD8178
         XTUnvA5b9PvPfFEiGpMpJp8YDvXSRh3Q2D1bt3P3zCu7E/rbOSyd0mamp7HAIYvTMEri
         EMRC9sqz/26GXUAT1shD/je/M6QHvEhysPtH6b/4+I6MiYhAsdh13ZekALP3wXMQPBCK
         FTz8Yo1o5X5ZUTZ5xTkTVoFCQCgDYHRrT3uj/xU5rbarmYqatOkGoiVxETNkqciCi98p
         gPB/oZ9OiqTTxR7ujC6QtECha/Tg51o/rFPVkfFKJ8z0NZTUBqg+Ce5+43DkaI/gzZd9
         qqIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743795589; x=1744400389;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G03Ks9vMONlbd+61V/+Erd91vdrZg3/ZspQO1qdkUD0=;
        b=SJ/J4gHx6VqgjItEiPiXaMxoYLPYId5I3R01ko7QFlqkuhdmWkuHzon+UbjULLOqoW
         NM/EBc4f6ujw0vFYIdt3R2TO8S/cH0WSFJm41j6f/a8mXYOMffm3Bt/QXgZk3uo+fyh8
         MkTTD0b89+ssqRsM5TqcY/wG5QWcpXtaykcyHKK65kmDs9duiMlYaOrWBjt5cRR6RasT
         4vMcIO7Omgm3/exFsIn3qAQncHBcN27wj5qYgWvHf3IZ+a17IXxP0oqUfNijtKSMwWcW
         8xMcqnjtfQI5hfxtxCuoZpa9cJ8lgDiX4LSEYo+Qdeb7lZdxIxCZoCoAIdys4HF0feq2
         8ZfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXksZi+wOP0aAez9sj0XuL0Z8QeuYMGbabAAkJjE70XHfyGDTJM6mEIGiKt4POl0o8OS8PLCg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxW9Lt7l4zOWLJBT8bcH+QVhH8emDSsBLxokuA6GJ81zZfueQND
	j4wEtxFnTBnMZI6e5kumJIJ5ENy/BecOVZ5wubXCwpmFXq5zWzC0uPrCgoD6clnRigaqOeUgvgo
	msw==
X-Google-Smtp-Source: AGHT+IEW58Ax+7aXM/+czWYm3zsW3qa9UnEokKAJbXbZCPS8kr/NGoPhwa56A0X88mWfGU8rBiSmwQt9o2Q=
X-Received: from pfbhj4.prod.google.com ([2002:a05:6a00:8704:b0:730:7c5b:2e2b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1411:b0:736:ff65:3fd0
 with SMTP id d2e1a72fcca58-739e7113667mr5072766b3a.16.1743795588965; Fri, 04
 Apr 2025 12:39:48 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  4 Apr 2025 12:38:16 -0700
In-Reply-To: <20250404193923.1413163-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250404193923.1413163-2-seanjc@google.com>
Subject: [PATCH 01/67] KVM: SVM: Allocate IR data using atomic allocation
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Allocate SVM's interrupt remapping metadata using GFP_ATOMIC as
svm_ir_list_add() is called with IRQs are disabled and irqfs.lock held
when kvm_irq_routing_update() reacts to GSI routing changes.

Fixes: 411b44ba80ab ("svm: Implements update_pi_irte hook to setup posted interrupt")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 901d8d2dc169..a961e6e67050 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -820,7 +820,7 @@ static int svm_ir_list_add(struct vcpu_svm *svm, struct amd_iommu_pi_data *pi)
 	 * Allocating new amd_iommu_pi_data, which will get
 	 * add to the per-vcpu ir_list.
 	 */
-	ir = kzalloc(sizeof(struct amd_svm_iommu_ir), GFP_KERNEL_ACCOUNT);
+	ir = kzalloc(sizeof(struct amd_svm_iommu_ir), GFP_ATOMIC | __GFP_ACCOUNT);
 	if (!ir) {
 		ret = -ENOMEM;
 		goto out;
-- 
2.49.0.504.g3bcea36a83-goog

