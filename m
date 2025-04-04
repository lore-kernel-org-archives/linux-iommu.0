Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B1B22A80E
	for <iommu@lists.linux.dev>; Fri,  4 Apr 2025 19:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743795633; cv=none; b=Ry7eoMoaKkKUMMio7nfewVYAp6akQDPLs+ycLFmERC4WfMPvR0F3aYcTcrwXbRL6vsB1WxLB34k3lwZn6g+AwOSbasmiKmKoX0Pa4Ty3a76jomVAl5kgmn28Xcemyf82OzB1viht1+ywHQzLrWH2dl7YDEGlFv/TwydC1zj9K78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743795633; c=relaxed/simple;
	bh=GcrLyi9xBIguGpiJMp1JCAHPfFvSGIO53FCtS2La3bs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JMBZPZLka8o2/5tuJ1UnXd5wVVN1Ld/uaV9Sf0PY6Q9VN4U1BvYNdhl2RgzfmNyYQcK+ObGBZlqu6WjBjSO4GZHwde2Z5vy8Q9BN7qJdhe/cfv7ynaaNH1DiKJswfb76DB6CvxgS9reWgEv714c1Pw6TYFXIKyn6Y2hyCTcA3NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q66W0kBU; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q66W0kBU"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-736c7d0d35aso3405804b3a.1
        for <iommu@lists.linux.dev>; Fri, 04 Apr 2025 12:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743795630; x=1744400430; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=jTJa+0GMh1FOB5V2QWRVxqPwy6X90M/TcdXJcK5fQGI=;
        b=Q66W0kBUbhmO+NWKyBp2d1EEd2Xj2AfH41bq48ntao8g0UaRo+aDDKVldb5keWs983
         3VqJhX8YcG2ZK5JqAcVnMVTuinNGzrXlMRrjyEfwe6zV+UBqndmK3OCaTrrog2TXDduz
         W/RUjsJGULkNqArtRImQd4wPs2u8m32eOXhFW3dZ6MpybhxOt8/iv6iK2Yc99ahvKaBB
         WXMLSrkmYtN7o6pmppGWdF5fYn0fRdRxeRNlqsy0ntzvjHHWqzjupP2MH2ly9BFAvjXo
         yneCz1xT4vWSKQkKyPfSAHoKZUgt9yDw6Ohb6V+UJWiJEsZSJAcOen4nq+PCROR+KJJZ
         f/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743795630; x=1744400430;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jTJa+0GMh1FOB5V2QWRVxqPwy6X90M/TcdXJcK5fQGI=;
        b=nPQBcqa8M1R05A9nVHFbN89kjgYhl8YgOD/9OxlZB9m4zC6xKBY4Xfauc3fbM15coe
         aecfKnVrXy7qkI6I/TLQ36ZD1tKWCSO+J8ZHlODIsvIjSLu+PUNJKOPDFeDPL1HAfwW4
         rx0w7C+UQwgSA6hxblu87z1syclwn5OWy0/MNXlQKOQdXa6r9WbwF35kPY/j/OdAyyjv
         iFspfkFM9EvkDn0Ise+JKMf4gReOOpB57lMRfDcazbabeuTmYKz5ueuPXgk9ZAxHne1+
         556tKy7zEEwQ+Nscr1yulJEb7zM7uXj+UG6NuVk+j0LUBVD7t9UEuKCSjOp4ZFTy/Vgo
         o7YA==
X-Forwarded-Encrypted: i=1; AJvYcCVuVmwrO6po7pqe6suWn5Oii9sJFtx7VcRmXh3EUx4JXUwUB6viYke/eIcP/8rby1FwK8SGYg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzI8+aK6edn1OOHL0myfkgUTN8zLtXnK88MXuqiWkLq79AaPP8f
	fnHSOZdD+nbP9eCC1tooUH9XutvMXdy9Yv5ThoFDZwEF1RohGk3uMx34TRFK8qXtsAi4j4qJEwQ
	VXg==
X-Google-Smtp-Source: AGHT+IGhg+PLOqwTVlNOH/ZHSestonJxLIS9XPyg7d4ccwd3Cs3DaoNuv6SgS+NEw0wff6EG1vq5naWWQyE=
X-Received: from pfxa29.prod.google.com ([2002:a05:6a00:1d1d:b0:736:a983:dc43])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:aa7:888c:0:b0:736:4644:86ee
 with SMTP id d2e1a72fcca58-73b6aa72dedmr737441b3a.14.1743795630419; Fri, 04
 Apr 2025 12:40:30 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  4 Apr 2025 12:38:40 -0700
In-Reply-To: <20250404193923.1413163-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250404193923.1413163-26-seanjc@google.com>
Subject: [PATCH 25/67] iommu/amd: KVM: SVM: Use pi_desc_addr to derive ga_root_ptr
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Use vcpu_data.pi_desc_addr instead of amd_iommu_pi_data.base to get the
GA root pointer.  KVM is the only source of amd_iommu_pi_data.base, and
KVM's one and only path for writing amd_iommu_pi_data.base computes the
exact same value for vcpu_data.pi_desc_addr and amd_iommu_pi_data.base,
and fills amd_iommu_pi_data.base if and only if vcpu_data.pi_desc_addr is
valid, i.e. amd_iommu_pi_data.base is fully redundant.

Cc: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c   | 7 +++++--
 drivers/iommu/amd/iommu.c | 2 +-
 include/linux/amd-iommu.h | 1 -
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 60e6e82fe41f..9024b9fbca53 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -902,8 +902,11 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 
 			enable_remapped_mode = false;
 
-			/* Try to enable guest_mode in IRTE */
-			pi.base = avic_get_backing_page_address(svm);
+			/*
+			 * Try to enable guest_mode in IRTE.  Note, the address
+			 * of the vCPU's AVIC backing page is passed to the
+			 * IOMMU via vcpu_info->pi_desc_addr.
+			 */
 			pi.ga_tag = AVIC_GATAG(to_kvm_svm(kvm)->avic_vm_id,
 						     svm->vcpu.vcpu_id);
 			pi.is_guest_mode = true;
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 4f69a37cf143..635774642b89 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3860,7 +3860,7 @@ static int amd_ir_set_vcpu_affinity(struct irq_data *data, void *vcpu_info)
 
 	pi_data->prev_ga_tag = ir_data->cached_ga_tag;
 	if (pi_data->is_guest_mode) {
-		ir_data->ga_root_ptr = (pi_data->base >> 12);
+		ir_data->ga_root_ptr = (vcpu_pi_info->pi_desc_addr >> 12);
 		ir_data->ga_vector = vcpu_pi_info->vector;
 		ir_data->ga_tag = pi_data->ga_tag;
 		ret = amd_iommu_activate_guest_mode(ir_data);
diff --git a/include/linux/amd-iommu.h b/include/linux/amd-iommu.h
index 062fbd4c9b77..4f433ef39188 100644
--- a/include/linux/amd-iommu.h
+++ b/include/linux/amd-iommu.h
@@ -20,7 +20,6 @@ struct amd_iommu;
 struct amd_iommu_pi_data {
 	u32 ga_tag;
 	u32 prev_ga_tag;
-	u64 base;
 	bool is_guest_mode;
 	struct vcpu_data *vcpu_data;
 	void *ir_data;
-- 
2.49.0.504.g3bcea36a83-goog

