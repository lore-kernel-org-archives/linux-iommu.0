Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DE8215075
	for <iommu@lists.linux.dev>; Fri, 23 May 2025 01:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747962021; cv=none; b=BKEr6S974Jo2GhA3BFtX/j0TLrdQv1LFMlwFwBVI37ArubuYY9eigaUEOt9jkwb7PXIbc+gZxy6L6Ilndhy5kICWRtRkrQ6cTXPB2XnAejpEIWscFihb35WcU2+wThRoRipNCOq1mlZxsvzHcBsuBawF+ZdJxpCKryRK4lByvIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747962021; c=relaxed/simple;
	bh=oo94zQ9KP44wU971cBBIeljSw8H5jEienGLBcJLhnEk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M4HhscIX5qbrEudSGJpz+LUa/ItMcH2V1y9FUplWSFqEO2kysgFSmbQaD43ZL54YC25nMHTFcVhPNSk8MoEqmPYV9Ub7C/RyjObyXMdueHNnJl+lR/4MkEwIxiblhLPy3IVyGrz/p7vDCEcQazYUnaf6SSccbmcYuEnVVNboohk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m6RWbBE1; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m6RWbBE1"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-742c6140589so371827b3a.1
        for <iommu@lists.linux.dev>; Thu, 22 May 2025 18:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747962017; x=1748566817; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Qq62gkgLP+wVktrApN5Abqg6uzedhCCWd9aEc00+u+w=;
        b=m6RWbBE1RhB8xeZKaqW+0xkmJtpa7tep0gHIfm89kPmiP1pRPPemQrwx4qYyrFf+jm
         MRal4FAvk3MUui4lbzhor0lc7fh2wWetHA6H13P7jXRgcDkSCDdYv9jVHHiRa+I8IwIu
         RKUToo+cXu6GVIJZlSme7Eya4cfsAxbcy4gnJ5QNURpgXcu6dAeSp8apeie09cPkZUvz
         7WRlLIsSrJz+qKdEDGQw/V03uEnqLbT7S7gHX/V0UuHBk41Wcnq9N8SGY1ggF+PpZNmp
         QWj8bmwmO9YgFXh0prQOHQHb71KNYRt2sqOUntEbLwguixsXHTJV0PAZY0taz7UrFYxc
         Dzyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747962017; x=1748566817;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qq62gkgLP+wVktrApN5Abqg6uzedhCCWd9aEc00+u+w=;
        b=VxRH5f5rWs8z5D1Nmu9MZF0ciy9UuLmCkJ1xrIHzA6o51vDZqIU/mlmHoBb4P9YMLy
         XjL6cHkFFgoYFzsqDbifVjXDhjdaNQVy2Hj8wD/ccmxICANRLQlKNemwIarlGPQPpOk6
         k0Xw6KzrJdp8R/CXeyydTgixZgX1sI7k1aLZ9Ts5ArWNHkS/hqssxaWEMC1ZKYVZbSZM
         z3idPSVST7XsFh15pK6v+oiBOGrISF6mbZ5lNcyxNMefhYrqh3Yy/hHXK2XFOU/BvnZo
         fF4D3AHBek9B7+9Tjg85ilCdtBn44u9pAZXt3dpLenKnlyJkyw+N5IZRiv7OnWZGA1W4
         1mmA==
X-Forwarded-Encrypted: i=1; AJvYcCX6oXYwSIXwaAfu7KrCjgyh755Y1/vb881fvZ9hvtaM1liLPPv00bT0636glq+rkvwXaaVwGA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyUWY4GYAi8hkUlmd9qtcGJ3NWBTFFQiOD+sa07uFn3zrlXePNH
	eJ+RWlVI9a0TaY7nTcr+NcAkqTvpw9fSmu+3rJ87NE68g3jn35lJGTNi5rt+yNfakwMSTmyrUxO
	HMp5SkA==
X-Google-Smtp-Source: AGHT+IGuYoObsP1SNouvA21unXNvbU7VlCtk1/aF9baeg7tLlY7NAY16P1XuLv+D0VMCs09pXt7is6cf1ZE=
X-Received: from pfqz29.prod.google.com ([2002:aa7:9e5d:0:b0:740:6f6:7346])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2d8c:b0:73b:ac3d:9d6b
 with SMTP id d2e1a72fcca58-745ece00f2cmr2255014b3a.4.1747962017305; Thu, 22
 May 2025 18:00:17 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 May 2025 17:59:09 -0700
In-Reply-To: <20250523010004.3240643-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250523010004.3240643-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523010004.3240643-5-seanjc@google.com>
Subject: [PATCH v2 04/59] iommu/amd: KVM: SVM: Delete now-unused
 cached/previous GA tag fields
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Sairaj Kodilkar <sarunkod@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	Francesco Lavra <francescolavra.fl@gmail.com>, David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Delete the amd_ir_data.prev_ga_tag field now that all usage is
superfluous.

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Tested-by: Sairaj Kodilkar <sarunkod@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c             |  2 --
 drivers/iommu/amd/amd_iommu_types.h |  1 -
 drivers/iommu/amd/iommu.c           | 10 ----------
 include/linux/amd-iommu.h           |  2 +-
 4 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index ed7374f0bd5a..4e8380d2f017 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -938,9 +938,7 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 		/**
 		 * Here, pi is used to:
 		 * - Tell IOMMU to use legacy mode for this interrupt.
-		 * - Retrieve ga_tag of prior interrupt remapping data.
 		 */
-		pi.prev_ga_tag = 0;
 		pi.is_guest_mode = false;
 		ret = irq_set_vcpu_affinity(host_irq, &pi);
 	}
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 5089b58e528a..57a96f3e7b84 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -1060,7 +1060,6 @@ struct irq_2_irte {
 };
 
 struct amd_ir_data {
-	u32 cached_ga_tag;
 	struct amd_iommu *iommu;
 	struct irq_2_irte irq_2_irte;
 	struct msi_msg msi_entry;
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index f34209b08b4c..f23635b062f0 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3887,23 +3887,13 @@ static int amd_ir_set_vcpu_affinity(struct irq_data *data, void *vcpu_info)
 	ir_data->cfg = irqd_cfg(data);
 	pi_data->ir_data = ir_data;
 
-	pi_data->prev_ga_tag = ir_data->cached_ga_tag;
 	if (pi_data->is_guest_mode) {
 		ir_data->ga_root_ptr = (pi_data->base >> 12);
 		ir_data->ga_vector = vcpu_pi_info->vector;
 		ir_data->ga_tag = pi_data->ga_tag;
 		ret = amd_iommu_activate_guest_mode(ir_data);
-		if (!ret)
-			ir_data->cached_ga_tag = pi_data->ga_tag;
 	} else {
 		ret = amd_iommu_deactivate_guest_mode(ir_data);
-
-		/*
-		 * This communicates the ga_tag back to the caller
-		 * so that it can do all the necessary clean up.
-		 */
-		if (!ret)
-			ir_data->cached_ga_tag = 0;
 	}
 
 	return ret;
diff --git a/include/linux/amd-iommu.h b/include/linux/amd-iommu.h
index 062fbd4c9b77..1f9b13d803c5 100644
--- a/include/linux/amd-iommu.h
+++ b/include/linux/amd-iommu.h
@@ -19,8 +19,8 @@ struct amd_iommu;
  */
 struct amd_iommu_pi_data {
 	u32 ga_tag;
-	u32 prev_ga_tag;
 	u64 base;
+
 	bool is_guest_mode;
 	struct vcpu_data *vcpu_data;
 	void *ir_data;
-- 
2.49.0.1151.ga128411c76-goog

