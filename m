Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0A4242EFF
	for <iommu@lists.linux.dev>; Thu, 12 Dec 2024 18:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026805; cv=none; b=ilWzMZE4vQ3uInySySlLdomgVTyAAK/+AC+Iw4PUo51um6uUjgk9+BxtNUF7IgzJ90+AMlDq5641J5CSgRF/mGN02a/t2OX2MjJgUc7m04sQUO9dUCGXgKDGZfysrFk+cuoYyH/mOGZvT3XJ4bqsNZ5d36pdwDpNzwpPcGtZlS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026805; c=relaxed/simple;
	bh=P++rIyJ+yBr2b2PG0f2OKkeFdIE8TkpF4epFXwZ2v60=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ubgIwEKEEcBMdiDVNJNPQCo6pZkGkNeviCTJROmbo7FhFnalURWETwYqCL41o5JRutb77/ugRo3FnyHmmNcfrGcp+tBf/qwF7zpHwDbhsjLkkDojSLajWuEYUDfgIUgaNLI7ie9vUPlXOLiTug4TSoarPmOz36oHGa2AwXATvsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GR/AyBdm; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GR/AyBdm"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3862e986d17so428708f8f.3
        for <iommu@lists.linux.dev>; Thu, 12 Dec 2024 10:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734026803; x=1734631603; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tyZdzXRtf8rptaiCXBMnMziyj8QgYtzTFp7Z15tvNkk=;
        b=GR/AyBdmbKtpK0nTz4kKA1nwAulKMZusC2MTMuzMa/BF41hRVjzHExFck57bpCvqeW
         ZaiWmggaGB+GJN0Dz6tO3DNQYspW8lj9TtmhkAFwaUIo86/hsd9VIzEvyKwCGVaDA6pJ
         epqyLJPvNUhxDwXkV71O3k87IVOSqJwiV9hphM0IQSCYSomI3G1Rt4YNRjxiEb2Fkgri
         h57kJoY6jF17J4G1FikypR6uNqFq7VfyY9ybxRTdaJc0EXxlFP4mhEsHxqVTFWpbX2ml
         nIf4OlxUaqFJotq/rYni7BuJqVo2uU+a9dWGoeVsFDU3NG1YFBngDsD1/8bnRXGdo0Cz
         AIQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734026803; x=1734631603;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tyZdzXRtf8rptaiCXBMnMziyj8QgYtzTFp7Z15tvNkk=;
        b=uUaIKfHe7Ijvhfd278L4WvciSBPBw4UcyYJZKeX9yJcEMWPr5m343pPZyZsU9gjSOl
         4CDE2meG5nAgeg++izvOcNhSPVekvv15Fn6GXPnyW6PB1eMW+1yedAMdaNBPaXNUOPmR
         kt4tLGL1RYs1WOq7nKfUCqh0pa3bb448/X7a81RHk4IswH1OSPq63+416ZMQ4b9GdDyg
         aMzvS0zC3pXnkMlysjBvW7AW+ANLNy8ykod9gWyTTv9c8xOxJv/SDrCVjZx7y5JFmXFj
         NkiyWCQEpzZrOYQMOHKnC0mG3dY8d06YAJhElPlzbeH0ni4oPo6t0Fx2KA3Kii+Gzfxn
         erOA==
X-Gm-Message-State: AOJu0YxXwQjLyRfou5p9zV/rEMGjpQoSeneQ4xLQjMHCshepg9vlv+tv
	k/oc9o9dPv0GOS5fQbRtqRizS5jkUkYTeRb2Jnmc4cWItZCx4l3pdeqHmQ8CtHjqGrGCYq9dQAi
	GkgIBmunZS035qyZdaFgPvMkLkbV4DkHVuPiLl7kZXgQdrdrW8utJk4PcdI7Um/jC2O4gY79FJB
	QsWIGg6XwveR94PHVSQDdvaX9ykrJkR3oyKpBFl5Tmiw==
X-Google-Smtp-Source: AGHT+IEWuyPM5Tx5DrErgHedylcB+E6oTYTHFOjRcJ9mqKpISiuwj0ormAbEHASo9YOkKlzy9zSUKaeU8xtaEA==
X-Received: from wmbay15.prod.google.com ([2002:a05:600c:1e0f:b0:434:ff52:1c7])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:5886:0:b0:385:faad:bfb9 with SMTP id ffacd0b85a97d-3864ce8644emr6392550f8f.8.1734026802739;
 Thu, 12 Dec 2024 10:06:42 -0800 (PST)
Date: Thu, 12 Dec 2024 18:04:21 +0000
In-Reply-To: <20241212180423.1578358-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20241212180423.1578358-1-smostafa@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241212180423.1578358-58-smostafa@google.com>
Subject: [RFC PATCH v2 57/58] iommu/arm-smmu-v3-kvm: Implement sg operations
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

Implement the new map_sg ops which mainly populate the kvm_iommu_sg
and pass it in the hypervisor.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c   | 93 +++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c
index e987c273ff3c..ac45455b384d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c
@@ -445,6 +445,96 @@ static phys_addr_t kvm_arm_smmu_iova_to_phys(struct iommu_domain *domain,
 	return kvm_call_hyp_nvhe(__pkvm_host_iommu_iova_to_phys, kvm_smmu_domain->id, iova);
 }
 
+struct kvm_arm_smmu_map_sg {
+	struct iommu_map_cookie_sg cookie;
+	struct kvm_iommu_sg *sg;
+	unsigned int ptr;
+	unsigned long iova;
+	int prot;
+	gfp_t gfp;
+	unsigned int nents;
+};
+
+static struct iommu_map_cookie_sg *kvm_arm_smmu_alloc_cookie_sg(unsigned long iova,
+								int prot,
+								unsigned int nents,
+								gfp_t gfp)
+{
+	int ret;
+	struct kvm_arm_smmu_map_sg *map_sg = kzalloc(sizeof(*map_sg), gfp);
+
+	if (!map_sg)
+		return NULL;
+
+	map_sg->sg = kvm_iommu_sg_alloc(nents, gfp);
+	if (!map_sg->sg)
+		return NULL;
+	map_sg->iova = iova;
+	map_sg->prot = prot;
+	map_sg->gfp = gfp;
+	map_sg->nents = nents;
+	ret = kvm_iommu_share_hyp_sg(map_sg->sg, nents);
+	if (ret) {
+		kvm_iommu_sg_free(map_sg->sg, nents);
+		kfree(map_sg);
+		return NULL;
+	}
+
+	return &map_sg->cookie;
+}
+
+static int kvm_arm_smmu_add_deferred_map_sg(struct iommu_map_cookie_sg *cookie,
+					    phys_addr_t paddr, size_t pgsize, size_t pgcount)
+{
+	struct kvm_arm_smmu_map_sg *map_sg = container_of(cookie, struct kvm_arm_smmu_map_sg,
+							  cookie);
+	struct kvm_iommu_sg *sg = map_sg->sg;
+
+	sg[map_sg->ptr].phys = paddr;
+	sg[map_sg->ptr].pgsize = pgsize;
+	sg[map_sg->ptr].pgcount = pgcount;
+	map_sg->ptr++;
+	return 0;
+}
+
+static int kvm_arm_smmu_consume_deferred_map_sg(struct iommu_map_cookie_sg *cookie)
+{
+	struct kvm_arm_smmu_map_sg *map_sg = container_of(cookie, struct kvm_arm_smmu_map_sg,
+							  cookie);
+	struct kvm_iommu_sg *sg = map_sg->sg;
+	size_t mapped, total_mapped = 0;
+	struct arm_smccc_res res;
+	struct kvm_arm_smmu_domain *kvm_smmu_domain = to_kvm_smmu_domain(map_sg->cookie.domain);
+
+	do {
+		res = kvm_call_hyp_nvhe_smccc(__pkvm_host_iommu_map_sg,
+					      kvm_smmu_domain->id,
+					      map_sg->iova, sg, map_sg->ptr, map_sg->prot);
+		mapped = res.a1;
+		map_sg->iova += mapped;
+		total_mapped += mapped;
+		/* Skip mapped */
+		while (mapped) {
+			if (mapped < (sg->pgsize * sg->pgcount)) {
+				sg->phys += mapped;
+				sg->pgcount -= mapped / sg->pgsize;
+				mapped = 0;
+			} else {
+				mapped -= sg->pgsize * sg->pgcount;
+				sg++;
+				map_sg->ptr--;
+			}
+		}
+
+		kvm_arm_smmu_topup_memcache(&res, map_sg->gfp);
+	} while (map_sg->ptr);
+
+	kvm_iommu_unshare_hyp_sg(sg, map_sg->nents);
+	kvm_iommu_sg_free(sg, map_sg->nents);
+	kfree(map_sg);
+	return 0;
+}
+
 static struct iommu_ops kvm_arm_smmu_ops = {
 	.capable		= kvm_arm_smmu_capable,
 	.device_group		= arm_smmu_device_group,
@@ -463,6 +553,9 @@ static struct iommu_ops kvm_arm_smmu_ops = {
 		.unmap_pages	= kvm_arm_smmu_unmap_pages,
 		.iova_to_phys	= kvm_arm_smmu_iova_to_phys,
 		.set_dev_pasid	= kvm_arm_smmu_set_dev_pasid,
+		.alloc_cookie_sg = kvm_arm_smmu_alloc_cookie_sg,
+		.add_deferred_map_sg = kvm_arm_smmu_add_deferred_map_sg,
+		.consume_deferred_map_sg = kvm_arm_smmu_consume_deferred_map_sg,
 	}
 };
 
-- 
2.47.0.338.g60cca15819-goog

