Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A178235C3A
	for <iommu@lists.linux.dev>; Thu, 12 Dec 2024 18:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026735; cv=none; b=ZZqgI++diWqhcsJS8xtdJ3UcMIzdw5uqQ7oIrXyByFPhzRGcnLi2LJYut9YlbkcU5kBiRuNa0cTa6bzW86B/dIbg/w8gLEHCrm95w+17T5KoQhqPeeRx8dx4tBw//MvBQfVFZDJRUjymWkm/Tj85d5ayG/LKBuJKD5Q2RrIKjws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026735; c=relaxed/simple;
	bh=LQ7osqA/9T45zp9pKA7tsvG8dh0AD4hAzw8bzt47krI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TGuqmniSZa+M5Fyc5eBr6yEPVHG7VRa6P22skyrozDE+e780bkCALPqvdeg/Pb6IrlIf0+VJhyh4elv4NH+YUQZd1RqWhI0oATD8DfLX+srAtcv6RYxEdC26La66X2mlTEsLOLvLxPNBE/nThOq1JdfwfsyR2XIN2M79ID+cCPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tNJ+g5Vp; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tNJ+g5Vp"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-386321c8f4bso579671f8f.0
        for <iommu@lists.linux.dev>; Thu, 12 Dec 2024 10:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734026732; x=1734631532; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iNmbzxfQZlpDuPsHWgM61suzSUM5uzL/JDk4UedkmbE=;
        b=tNJ+g5VpfzjMa8yb2bmm9ubzBOF3xc2wUuvc1gFKQi9iDVy6Unp4kV0cvc7kPYqCo3
         r/usziRb9OI5iBQXuxCw+2n78NubdZ93BslA3SoQ3u0Odr2B+wRzc4tOnQrT+MXJMjBC
         I63h1JEFbaEaUqUN62dllilbw7s7q03Q2RrroBhXBMrfy36cVAiyNbwB1ykBxkns94LJ
         d043DrMDQRwEr5T6wOevwT4xSMFGXy97QAQRVjBffbofXp4q3P+2bxgogeC5bMTTci/G
         GIn3H3RaxsZ1yMr5DicqFiL1skA1tANPnciDuAI3AvJWMsEm3CPSz50GEEwj1gK8UzFk
         Sl0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734026732; x=1734631532;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iNmbzxfQZlpDuPsHWgM61suzSUM5uzL/JDk4UedkmbE=;
        b=e+Us8JAPti229rkYZpxo6zeHeCf1/e6OWsLfbqeBCJ4LkaAgpi8ThtKBpXKv3P2HaS
         qllEFPhfKM8x98D7wVb+Z9bwzVnuxSUxLujtMa4VXvAT4D6USHI2c6NkneOqbGJeDhGt
         DQvIoDOnGT94nxSuuujCMiTvLxP3V0LAAYNDPuI7Pp6G9dJm2QiBar5Gb7C9DX7ZCsDF
         wSO3WoBGr1lMj2Fr++nkewfj5rrC1+qcp/SjQzxWvVawWyRjVySxjSejJ+t/r/AO4N+o
         KmkbA1o7BJXMOih2IuoI27iWthkbh7qSITcyMf687cYbQz/EPitwdj9KDZYtAc0W1TeF
         xhJw==
X-Gm-Message-State: AOJu0YylDiJoi4wXjxHu5BXqqHSJ37bL0PHzGYfDtURlaUMs2g3WbAQ0
	It9FsrVJ7r3ASqjnPbhBBGTP6BVV9FjlknK0TPQ7pXRpIccyIcPARP66aXmlGgI6jedyAE5clGV
	/Hlwe+uUptYe5SwALcb60Vkms1cey+0VogyT6RW1enVL79z/HFPtumnLUhJADtpiU4BqcR8qmTO
	JeQUY206jEhL0/C/UFJRX3rh/HG98yLjZemml3rgeuIA==
X-Google-Smtp-Source: AGHT+IG5u7MltLTltlnPqAoPYJ0zedPyLXzvE96q5dJmxhMlV9Kb2g6bQvckMYIYAkBMBY1CEWyusiJQB7JM4g==
X-Received: from wmnb15.prod.google.com ([2002:a05:600c:6cf:b0:436:1995:1888])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2802:b0:385:df6d:6fc7 with SMTP id ffacd0b85a97d-3864ce9f30amr4398431f8f.25.1734026731871;
 Thu, 12 Dec 2024 10:05:31 -0800 (PST)
Date: Thu, 12 Dec 2024 18:03:47 +0000
In-Reply-To: <20241212180423.1578358-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20241212180423.1578358-1-smostafa@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241212180423.1578358-24-smostafa@google.com>
Subject: [RFC PATCH v2 23/58] KVM: arm64: iommu: Support power management
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

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

Add power domain ops to the hypervisor IOMMU driver. We currently make
these assumptions:

* The register state is retained across power off.
* The TLBs are clean on power on.
* Another privileged software (EL3 or SCP FW) handles dependencies
  between SMMU and endpoints.

So we just need to make sure that the CPU does not touch the SMMU
registers while it is powered off.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 arch/arm64/kvm/hyp/nvhe/iommu/iommu.c | 33 ++++++++++++++++++++++++++-
 include/kvm/iommu.h                   |  3 +++
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c b/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c
index a6e0f3634756..fbab335d3490 100644
--- a/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c
+++ b/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c
@@ -375,10 +375,41 @@ phys_addr_t kvm_iommu_iova_to_phys(pkvm_handle_t domain_id, unsigned long iova)
 	return phys;
 }
 
+static int iommu_power_on(struct kvm_power_domain *pd)
+{
+	struct kvm_hyp_iommu *iommu = container_of(pd, struct kvm_hyp_iommu,
+						   power_domain);
+
+	/*
+	 * We currently assume that the device retains its architectural state
+	 * across power off, hence no save/restore.
+	 */
+	kvm_iommu_lock(iommu);
+	iommu->power_is_off = false;
+	kvm_iommu_unlock(iommu);
+	return 0;
+}
+
+static int iommu_power_off(struct kvm_power_domain *pd)
+{
+	struct kvm_hyp_iommu *iommu = container_of(pd, struct kvm_hyp_iommu,
+						   power_domain);
+
+	kvm_iommu_lock(iommu);
+	iommu->power_is_off = true;
+	kvm_iommu_unlock(iommu);
+	return 0;
+}
+
+static const struct kvm_power_domain_ops iommu_power_ops = {
+	.power_on	= iommu_power_on,
+	.power_off	= iommu_power_off,
+};
+
 /* Must be called from the IOMMU driver per IOMMU */
 int kvm_iommu_init_device(struct kvm_hyp_iommu *iommu)
 {
 	kvm_iommu_lock_init(iommu);
 
-	return 0;
+	return pkvm_init_power_domain(&iommu->power_domain, &iommu_power_ops);
 }
diff --git a/include/kvm/iommu.h b/include/kvm/iommu.h
index 6ff78d766466..c524ba84a9cf 100644
--- a/include/kvm/iommu.h
+++ b/include/kvm/iommu.h
@@ -3,6 +3,7 @@
 #define __KVM_IOMMU_H
 
 #include <asm/kvm_host.h>
+#include <kvm/power_domain.h>
 #include <linux/io-pgtable.h>
 #ifdef __KVM_NVHE_HYPERVISOR__
 #include <nvhe/spinlock.h>
@@ -51,6 +52,8 @@ struct kvm_hyp_iommu {
 #else
 	u32				unused;
 #endif
+	struct kvm_power_domain		power_domain;
+	bool				power_is_off;
 };
 
 #endif /* __KVM_IOMMU_H */
-- 
2.47.0.338.g60cca15819-goog

