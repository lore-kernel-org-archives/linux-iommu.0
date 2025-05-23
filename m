Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C71224231
	for <iommu@lists.linux.dev>; Fri, 23 May 2025 01:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747962032; cv=none; b=SuVrlvvllDA0Sux3bDlj94JD1okogRaWJ1qls9WRKsCjlUCXuxmT0U/G8AF4uUfIYqfGjmXkuLCBIRYP09lObzDfVG7JEIJEIHlpslCDJXve+XghfiB/OrmTUuccfegLekyvr0rWHGfNo8q4NivxV1JiigKrJ9HQGfHi3gvE+K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747962032; c=relaxed/simple;
	bh=NmtIJk+NXuVQcgcHe/OX20tZuAMC4d7N9CttC/YW7ug=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JOwcghKWoCF+xUveW1zRY167LwBPATCksub4YiWARLvWxLk9YhX30IZIT2yvzVj72c78W6VyJhRMf3CcMxLV7b8ifDW7xgkOgWC3g0q/FHR416rmq5pQTi53ElPcHM5NcI+D94CInugNdwMeHulxElqpNCBdc116cJAVQGRxcsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZVrVnPQY; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZVrVnPQY"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7429fc0bfc8so324968b3a.1
        for <iommu@lists.linux.dev>; Thu, 22 May 2025 18:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747962030; x=1748566830; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=qvU0dOld0vUayuYrP2inmYflxGewHdZ05MuEuDFSsRI=;
        b=ZVrVnPQYXjK4yDHfH43kUbXOdld+ahtZ6poV0u+MQtH8YTQOQgkJp1qm1lETVqZA7w
         HbHCw8+7zNZcf9wqEl8qTRGJOYFso+qL7GOoy+I9QPRoAR/GPQn5Wsey2EUvpsxu4hp7
         4mO7oyUC6RmfA5O7QIn9BMSPpB4fzZcZ8rYXMcawCleOJ+jV/TGxw9ifZLMheM56BH0A
         LH9VFywbDbYDfG0sYiyU6cEqPcltWLUncolJs2qZx5BXYGVdy5mnN3bJC8qAd3yBtxbp
         fsUg8eMj1Sk+IcPlG6pvcYw2bX1gWuBj5ic3UEiMg678UtfvijlYEYVzrD54y7Ge+kq0
         i3Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747962030; x=1748566830;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qvU0dOld0vUayuYrP2inmYflxGewHdZ05MuEuDFSsRI=;
        b=cvaKGeWjzGDLV7ZS7VShtpvhO/5P3Z+Wa9ki6tRyM6je8jrIHUls4QcOOuuXiav4mY
         HFgerqDpV/t6UVXNHDJFXoEtt7+W8PUF81BhFRC3VFf8jCXKjK29glgL9wkmaDgximJX
         uVwqFz6I+g+g5lMFfhqfr2lLgYNW1QC2RHHjohIEjppJ2QUkGAXPW8dtVsTp6hKVBrO2
         22Xd6vH9R3NJi1rZzU81vnm6TNfTLxGlknT0vO3Wc7UbB1ZryxF6/Fz/EgptW9E/cXWG
         +sg9eWc7QKkWUzQgDQy7K30kxXCQsOvijvw3264Bu2StrrH32m36hfNf1EKKQTG7tY2p
         JIeg==
X-Forwarded-Encrypted: i=1; AJvYcCVt5zRSoLu7W78GglsKn3Wn7+4lIkTBdwxKjd99IYAHiuK+YCkzld2mErtpobVdgysLV2Gjow==@lists.linux.dev
X-Gm-Message-State: AOJu0YzPlbkZk2s0PMVs1dIfE+yOVPuaTWJklgIeyrxiw0K1R/3g20IN
	KxtMgdU1faGAkIAS+IeEDWoAqvhidTzbqEm3FROoHX2ME2OvK0bF5VzgvlzmPOMSvloEL/dAJ4I
	H1sT65A==
X-Google-Smtp-Source: AGHT+IHUAkRGBcbeHEZC8d5MhipzP08zCSRQ2GxGmkCxhyIuuWUqgFNrdbfXKGFZCAm/KodkxoGK3IgwYXs=
X-Received: from pgah21.prod.google.com ([2002:a05:6a02:4e95:b0:b26:f984:15bc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:78e:b0:1f0:e6db:b382
 with SMTP id adf61e73a8af0-21877a3a205mr2221344637.8.1747962029662; Thu, 22
 May 2025 18:00:29 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 May 2025 17:59:16 -0700
In-Reply-To: <20250523010004.3240643-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250523010004.3240643-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523010004.3240643-12-seanjc@google.com>
Subject: [PATCH v2 11/59] KVM: SVM: Drop redundant check in AVIC code on ID
 during vCPU creation
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Sairaj Kodilkar <sarunkod@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	Francesco Lavra <francescolavra.fl@gmail.com>, David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Drop avic_get_physical_id_entry()'s compatibility check on the incoming
ID, as its sole caller, avic_init_backing_page(), performs the exact same
check.  Drop avic_get_physical_id_entry() entirely as the only remaining
functionality is getting the address of the Physical ID table, and
accessing the array without an immediate bounds check is kludgy.

Opportunistically add a compile-time assertion to ensure the vcpu_id can't
result in a bounds overflow, e.g. if KVM (really) messed up a maximum
physical ID #define, as well as run-time assertions so that a NULL pointer
dereference is morphed into a safer WARN().

No functional change intended.

Tested-by: Sairaj Kodilkar <sarunkod@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 37 +++++++++++++++----------------------
 1 file changed, 15 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index f0a74b102c57..948bab48083b 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -256,26 +256,12 @@ void avic_init_vmcb(struct vcpu_svm *svm, struct vmcb *vmcb)
 		avic_deactivate_vmcb(svm);
 }
 
-static u64 *avic_get_physical_id_entry(struct kvm_vcpu *vcpu,
-				       unsigned int index)
-{
-	u64 *avic_physical_id_table;
-	struct kvm_svm *kvm_svm = to_kvm_svm(vcpu->kvm);
-
-	if ((!x2avic_enabled && index > AVIC_MAX_PHYSICAL_ID) ||
-	    (index > X2AVIC_MAX_PHYSICAL_ID))
-		return NULL;
-
-	avic_physical_id_table = page_address(kvm_svm->avic_physical_id_table_page);
-
-	return &avic_physical_id_table[index];
-}
-
 static int avic_init_backing_page(struct kvm_vcpu *vcpu)
 {
-	u64 *entry, new_entry;
-	int id = vcpu->vcpu_id;
+	struct kvm_svm *kvm_svm = to_kvm_svm(vcpu->kvm);
 	struct vcpu_svm *svm = to_svm(vcpu);
+	u32 id = vcpu->vcpu_id;
+	u64 *table, new_entry;
 
 	/*
 	 * Inhibit AVIC if the vCPU ID is bigger than what is supported by AVIC
@@ -291,6 +277,9 @@ static int avic_init_backing_page(struct kvm_vcpu *vcpu)
 		return 0;
 	}
 
+	BUILD_BUG_ON((AVIC_MAX_PHYSICAL_ID + 1) * sizeof(*table) > PAGE_SIZE ||
+		     (X2AVIC_MAX_PHYSICAL_ID + 1) * sizeof(*table) > PAGE_SIZE);
+
 	if (WARN_ON_ONCE(!vcpu->arch.apic->regs))
 		return -EINVAL;
 
@@ -309,9 +298,7 @@ static int avic_init_backing_page(struct kvm_vcpu *vcpu)
 	}
 
 	/* Setting AVIC backing page address in the phy APIC ID table */
-	entry = avic_get_physical_id_entry(vcpu, id);
-	if (!entry)
-		return -EINVAL;
+	table = page_address(kvm_svm->avic_physical_id_table_page);
 
 	/* Note, fls64() returns the bit position, +1. */
 	BUILD_BUG_ON(__PHYSICAL_MASK_SHIFT >
@@ -319,9 +306,9 @@ static int avic_init_backing_page(struct kvm_vcpu *vcpu)
 
 	new_entry = avic_get_backing_page_address(svm) |
 		    AVIC_PHYSICAL_ID_ENTRY_VALID_MASK;
-	WRITE_ONCE(*entry, new_entry);
+	WRITE_ONCE(table[id], new_entry);
 
-	svm->avic_physical_id_cache = entry;
+	svm->avic_physical_id_cache = &table[id];
 
 	return 0;
 }
@@ -1004,6 +991,9 @@ void avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	if (WARN_ON(h_physical_id & ~AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK))
 		return;
 
+	if (WARN_ON_ONCE(!svm->avic_physical_id_cache))
+		return;
+
 	/*
 	 * No need to update anything if the vCPU is blocking, i.e. if the vCPU
 	 * is being scheduled in after being preempted.  The CPU entries in the
@@ -1044,6 +1034,9 @@ void avic_vcpu_put(struct kvm_vcpu *vcpu)
 
 	lockdep_assert_preemption_disabled();
 
+	if (WARN_ON_ONCE(!svm->avic_physical_id_cache))
+		return;
+
 	/*
 	 * Note, reading the Physical ID entry outside of ir_list_lock is safe
 	 * as only the pCPU that has loaded (or is loading) the vCPU is allowed
-- 
2.49.0.1151.ga128411c76-goog

