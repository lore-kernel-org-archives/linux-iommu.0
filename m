Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AE122FAD4
	for <iommu@lists.linux.dev>; Thu, 12 Dec 2024 18:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026723; cv=none; b=Rg60SUa90lo6Yzbtw7hP92ly8wfaUv6pHBu9Yit1kcumwJzDJiqi7QV6F9LzyA1XtF0Ql/gWG4pA2YOz/TPFKi+FhuXqbLdPIKEmPdDdvXIEZoTeIEeghD0CsfkUKHu5v0ap61okPrUpm0afco3Yitm0oTinrdpekSnETOou80g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026723; c=relaxed/simple;
	bh=7DeqoP+0h4J/nlEoKq6qxUg79CviM0U7ODp/Jiv7XFU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IehA4SVOD/0O0FR9QaVIEwYALHAHjRY5+cv/9gW8cIjBsTlDrnYYjRfHMsc/5sCzrFusVS5EB71anRt0lEU3DbGfoc3qQJxlgyf9lxnFu98IIjN71zrsvM8KKO33z+0xflEux+Gjph1XyKpJrm470CTDYDtpY7cEkgT+we8fZsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eqizRCSQ; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eqizRCSQ"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43610eba55bso8218825e9.3
        for <iommu@lists.linux.dev>; Thu, 12 Dec 2024 10:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734026719; x=1734631519; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=r96D7jtEo6iMT7XaPgJfnXzgjFVNWq31bg+JNNbd33c=;
        b=eqizRCSQ5dn2kgUT+YBOpSs8FBNYXMxhSH5CqnAcFNt7L80a1gNQ0d7Z9L8moBUDkq
         nUXSCBg2xPJyMXNM55Wl3a+gx/e6di2lQZrhwNvKW7l2lfVmdxzIxOwQIghiHhFwzQEv
         C9Oax8C/VJ3xEkbU5L6o5ppdYZozp86TvgU2Xei0lZXtuSNs0JcJSAlPGevP5OUDlccP
         dbhCLS5iuHMTwg6tqljwycncZVavQh3S94eQyPVlPXHOPDasJCrFokleC1QVXp+UYFV7
         Sb3aD5E4xsajQTVysVpcTbHC3QfiKztqWcr/PVNCPChyYE0aC0e696kWzn7kZBpRpwv0
         EjBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734026719; x=1734631519;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r96D7jtEo6iMT7XaPgJfnXzgjFVNWq31bg+JNNbd33c=;
        b=umKgdSzI5NULEXozfoMQvXaY6IUyYTMnngiLyeXprE/lswN2fL+v9/bhF0FlTHDprK
         ZyHVPP4onctj4HHxxOuLP6GW/tM8VBMbDv00Nliul2wsy4eM4CVzH1I7mSzJZEmMi6ex
         Cprb7qY1FRYvNAh+KZ1PUZA+/oPl/Zoo/AoISFLW6jbpyoL7g9wxlVDiurmxrmH8UDW2
         tLiHRk0cV8WNQy6XAVj2M7JQBVugQj0sOQM97RJitqLA51YrkW7QSfsgN0Ez+RmREFdB
         UL5qLM8vQuAGriHI4C3+94jm/a07wKgy51nxV8+hpdDnROSCcx9uVuifoA/Co2Ir/9qk
         DISw==
X-Gm-Message-State: AOJu0YzlzdN5ve0E1kJ9nMmVJQXdY98NXflPcli5sbJd/VsmMLe0jmNy
	ziyfr2r7WwL6w0JzCBbVAgtmZej4ReXs5Xjhv4FYYtM6wkG6+erq3jRo9VTUVUBav1u+5o4iBYL
	KeK6VsY3TghpOOgtS6xhcSAczEN+gTd2vx5fdKTaKfGw3BjmpsNbG5gRmPj4Mte5NHxvRnD/eZw
	m1Oxr4Sr4HzzRzIWuNb8kOMYvmvtX7CKtJrN831cli9g==
X-Google-Smtp-Source: AGHT+IHOlQVhqOBCLyKRJBicSu0YdgpRP9Z8cEsxdD6v5Zy8WYvPT3uz4gGoRc3GnnVzZTWZ+pU892qsZdg7uQ==
X-Received: from wmhj22.prod.google.com ([2002:a05:600c:3016:b0:434:fe74:1bd5])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3593:b0:435:294:f1c8 with SMTP id 5b1f17b1804b1-43622883637mr32346155e9.28.1734026719225;
 Thu, 12 Dec 2024 10:05:19 -0800 (PST)
Date: Thu, 12 Dec 2024 18:03:41 +0000
In-Reply-To: <20241212180423.1578358-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20241212180423.1578358-1-smostafa@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241212180423.1578358-18-smostafa@google.com>
Subject: [RFC PATCH v2 17/58] KVM: arm64: iommu: Add {attach, detach}_dev
From: Mostafa Saleh <smostafa@google.com>
To: iommu@lists.linux.dev, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: catalin.marinas@arm.com, will@kernel.org, maz@kernel.org, 
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, robdclark@gmail.com, joro@8bytes.org, 
	robin.murphy@arm.com, jean-philippe@linaro.org, jgg@ziepe.ca, 
	nicolinc@nvidia.com, vdonnefort@google.com, qperret@google.com, 
	tabba@google.com, danielmentz@google.com, tzukui@google.com, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

Add attach/detach dev operations which are forwarded to the driver.

To avoid racing between alloc/free domain and attach/detach dev,
the refcount is used.

Although, as IOMMU attach/detach are per-IOMMU and would require
some sort of locking, nothing in the IOMMU core code need the lock
so delegate that to the driver to use locks when needed and the
hypervisor only guarantees no races between alloc/free domain.

Also, add a new function kvm_iommu_init_device() to initialise common
fields of the IOMMU struct, which is only the lock at the moment.
The IOMMU core code will need to use the lock next for power
management.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 arch/arm64/kvm/hyp/include/nvhe/iommu.h | 29 +++++++++++++
 arch/arm64/kvm/hyp/nvhe/iommu/iommu.c   | 56 ++++++++++++++++++++++++-
 include/kvm/iommu.h                     |  8 ++++
 3 files changed, 91 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/iommu.h b/arch/arm64/kvm/hyp/include/nvhe/iommu.h
index 8f619f415d1f..d6d7447fbac8 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/iommu.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/iommu.h
@@ -35,10 +35,39 @@ struct kvm_iommu_ops {
 	int (*init)(void);
 	int (*alloc_domain)(struct kvm_hyp_iommu_domain *domain, int type);
 	void (*free_domain)(struct kvm_hyp_iommu_domain *domain);
+	struct kvm_hyp_iommu *(*get_iommu_by_id)(pkvm_handle_t iommu_id);
+	int (*attach_dev)(struct kvm_hyp_iommu *iommu, struct kvm_hyp_iommu_domain *domain,
+			  u32 endpoint_id, u32 pasid, u32 pasid_bits);
+	int (*detach_dev)(struct kvm_hyp_iommu *iommu, struct kvm_hyp_iommu_domain *domain,
+			  u32 endpoint_id, u32 pasid);
 };
 
 int kvm_iommu_init(void);
 
+int kvm_iommu_init_device(struct kvm_hyp_iommu *iommu);
+
+static inline hyp_spinlock_t *kvm_iommu_get_lock(struct kvm_hyp_iommu *iommu)
+{
+	/* See struct kvm_hyp_iommu */
+	BUILD_BUG_ON(sizeof(iommu->lock) != sizeof(hyp_spinlock_t));
+	return (hyp_spinlock_t *)(&iommu->lock);
+}
+
+static inline void kvm_iommu_lock_init(struct kvm_hyp_iommu *iommu)
+{
+	hyp_spin_lock_init(kvm_iommu_get_lock(iommu));
+}
+
+static inline void kvm_iommu_lock(struct kvm_hyp_iommu *iommu)
+{
+	hyp_spin_lock(kvm_iommu_get_lock(iommu));
+}
+
+static inline void kvm_iommu_unlock(struct kvm_hyp_iommu *iommu)
+{
+	hyp_spin_unlock(kvm_iommu_get_lock(iommu));
+}
+
 extern struct hyp_mgt_allocator_ops kvm_iommu_allocator_ops;
 
 #endif /* __ARM64_KVM_NVHE_IOMMU_H__ */
diff --git a/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c b/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c
index ba2aed52a74f..df2dbe4c0121 100644
--- a/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c
+++ b/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c
@@ -127,6 +127,19 @@ handle_to_domain(pkvm_handle_t domain_id)
 	return &domains[domain_id % KVM_IOMMU_DOMAINS_PER_PAGE];
 }
 
+static int domain_get(struct kvm_hyp_iommu_domain *domain)
+{
+	int old = atomic_fetch_inc_acquire(&domain->refs);
+
+	BUG_ON(!old || (old + 1 < 0));
+	return 0;
+}
+
+static void domain_put(struct kvm_hyp_iommu_domain *domain)
+{
+	BUG_ON(!atomic_dec_return_release(&domain->refs));
+}
+
 int kvm_iommu_init(void)
 {
 	int ret;
@@ -210,13 +223,44 @@ int kvm_iommu_free_domain(pkvm_handle_t domain_id)
 int kvm_iommu_attach_dev(pkvm_handle_t iommu_id, pkvm_handle_t domain_id,
 			 u32 endpoint_id, u32 pasid, u32 pasid_bits)
 {
-	return -ENODEV;
+	int ret;
+	struct kvm_hyp_iommu *iommu;
+	struct kvm_hyp_iommu_domain *domain;
+
+	iommu = kvm_iommu_ops->get_iommu_by_id(iommu_id);
+	if (!iommu)
+		return -EINVAL;
+
+	domain = handle_to_domain(domain_id);
+	if (!domain || domain_get(domain))
+		return -EINVAL;
+
+	ret = kvm_iommu_ops->attach_dev(iommu, domain, endpoint_id, pasid, pasid_bits);
+	if (ret)
+		domain_put(domain);
+	return ret;
 }
 
 int kvm_iommu_detach_dev(pkvm_handle_t iommu_id, pkvm_handle_t domain_id,
 			 u32 endpoint_id, u32 pasid)
 {
-	return -ENODEV;
+	int ret;
+	struct kvm_hyp_iommu *iommu;
+	struct kvm_hyp_iommu_domain *domain;
+
+	iommu = kvm_iommu_ops->get_iommu_by_id(iommu_id);
+	if (!iommu)
+		return -EINVAL;
+
+	domain = handle_to_domain(domain_id);
+	if (!domain || atomic_read(&domain->refs) <= 1)
+		return -EINVAL;
+
+	ret = kvm_iommu_ops->detach_dev(iommu, domain, endpoint_id, pasid);
+	if (ret)
+		return ret;
+	domain_put(domain);
+	return ret;
 }
 
 size_t kvm_iommu_map_pages(pkvm_handle_t domain_id,
@@ -236,3 +280,11 @@ phys_addr_t kvm_iommu_iova_to_phys(pkvm_handle_t domain_id, unsigned long iova)
 {
 	return 0;
 }
+
+/* Must be called from the IOMMU driver per IOMMU */
+int kvm_iommu_init_device(struct kvm_hyp_iommu *iommu)
+{
+	kvm_iommu_lock_init(iommu);
+
+	return 0;
+}
diff --git a/include/kvm/iommu.h b/include/kvm/iommu.h
index 10ecaae0f6a3..6ff78d766466 100644
--- a/include/kvm/iommu.h
+++ b/include/kvm/iommu.h
@@ -45,4 +45,12 @@ extern void **kvm_nvhe_sym(kvm_hyp_iommu_domains);
 #define KVM_IOMMU_DOMAINS_ROOT_ORDER_NR	\
 	(1 << get_order(KVM_IOMMU_DOMAINS_ROOT_SIZE))
 
+struct kvm_hyp_iommu {
+#ifdef __KVM_NVHE_HYPERVISOR__
+	hyp_spinlock_t			lock;
+#else
+	u32				unused;
+#endif
+};
+
 #endif /* __KVM_IOMMU_H */
-- 
2.47.0.338.g60cca15819-goog

