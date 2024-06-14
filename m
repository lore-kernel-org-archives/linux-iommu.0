Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0592B4962E
	for <iommu@lists.linux.dev>; Fri, 14 Jun 2024 14:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718374957; cv=none; b=eJtXZJ81ptFmzNA359bkgZqGAJuxi/26L+SfIddl2aEwAfBgGquXZWy93CzQFTIXHuQscEVqZbeq9NBbvevuvPRUOJF2aFLQaprwdNOVn5f35RGPBdLZAOBlymeAgyZnFB8OtIDXcVkt6NVF6TDUIMo0Sf6k+PmsJnYiaVVcXvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718374957; c=relaxed/simple;
	bh=Q7a++o7eiwUm8M0irLfARJWMrYHyrc7Ai/QKurMYIDk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=k7uoU/xDyx9rCKVmjS9pm2CIMukRqyO9pEWYR7KtdBfTx0QoTpo9U/GveT8u3ce8A24dcnoIzndc7OCCIWTb9V8A5wc+Xp9LL8/MIzN6V3EAeMN7Q6/8BZ8EYvLLJZ+KccVb0U6vDzWhrP8I6h9cdkEyVlH1C56QD4ISs/RT9w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=muSsFOBu; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="muSsFOBu"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1f70509b811so16766615ad.1
        for <iommu@lists.linux.dev>; Fri, 14 Jun 2024 07:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1718374955; x=1718979755; darn=lists.linux.dev;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wDCzcwoY+7Urqf0z9zEneV8CU/qabdLYOlq0L2NAoPg=;
        b=muSsFOBuip86tRNCJH1tMsK+0OhZhivnEDqPi3219wlZGIE4AC7sCU+FlguVW5r5ef
         Q+tqriHWiP9ZYl5b6/8czvelRNvRUm2l0w6cePERTLk2tknCKKJmwFVDNZUfRPqcC7hF
         GufBPFNZ6CiOhgyqGkxglXYCbiKi5ST7F5Dltq8Jpst6XUUn6mZmB/nO6q2WfXUlV3Ls
         ReerB3mUJLOu7/qVxUEo1C8staGXzkrtP//MUS53veHJ1DLBXonk+661HeYCr8Mf3AMP
         +KZBJgsKZ0gOCC1xhvzkXvm63gzXf6XrQ2mYD8PD4bJpCrKi4vZUXbxTjna8VqZ2r4tN
         7xYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718374955; x=1718979755;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wDCzcwoY+7Urqf0z9zEneV8CU/qabdLYOlq0L2NAoPg=;
        b=ZfFTxCzGtJKwRHoqb0yEaMkIWlWaU2V2fheFUcydvmmjkZ0+38iWZD3C0yu9HFdSok
         xjcIQgDZqVs8Bv82OqsI6ctTrrlXAu0zXs70OL5m4r5tVCL1Lkk1kXoIrHm0XVDPtYt4
         T6Un6RcpZSqwrf8b237fJW21rXs44FbIZS7b1WNSe2n//pDI3LQlew/xHDTXsucKg0G3
         mRobV98kMNea7ngNeMjGuben7cdlpuE1wVsHuapLjPahYbLfKhnxIerNuZl/Yl8WFBUo
         lA6+tSyshGMD4pDU7zL1S6I9hOab1fqwyRbbkhvnnAgqwG2yr5QZtBv7136VxcjOg62I
         qbsA==
X-Forwarded-Encrypted: i=1; AJvYcCWiTkJBmFxPUDLiE/lxsTR1zP6cV170cgZmrgPBGLGbkM+yQpOnScXkKPx8t1ozteQ+fIniKeYKfnw3TqH+Mq8qWyNY7RE=
X-Gm-Message-State: AOJu0Yzgb/n4fEYq5uGmbtJwWruNvU6mOSPv6a2Ah8GYlkY3cHvOL3kl
	t96sbawsAsXJxtBp4jo2AYEQI/KNXoJoziNW0LTRTQD5Ni56TrUPM5R3O88dzCI=
X-Google-Smtp-Source: AGHT+IFNWiib9Mbp3WUeDaTWc2pLd5fn9/fMVeRdDHjkyMdQAAUYNKmmTVlC+NReoIyOXuSV1VHXpQ==
X-Received: by 2002:a17:902:f68e:b0:1f7:2849:183f with SMTP id d9443c01a7336-1f8625c243amr33675115ad.1.1718374955357;
        Fri, 14 Jun 2024 07:22:35 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e559d9sm32522005ad.35.2024.06.14.07.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 07:22:35 -0700 (PDT)
From: Zong Li <zong.li@sifive.com>
To: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	tjeznach@rivosinc.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org
Cc: Zong Li <zong.li@sifive.com>
Subject: [RFC PATCH v2 10/10] iommu:riscv: support nested iommu for get_msi_mapping_domain operation
Date: Fri, 14 Jun 2024 22:21:56 +0800
Message-Id: <20240614142156.29420-11-zong.li@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240614142156.29420-1-zong.li@sifive.com>
References: <20240614142156.29420-1-zong.li@sifive.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

Return the iommu_domain that should hold the MSI cookie.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 drivers/iommu/riscv/iommu.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index d08eb0a2939e..969a0ba32c9e 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -1689,10 +1689,22 @@ static int riscv_iommu_cache_invalidate_user(struct iommu_domain *domain,
 	return ret;
 }
 
+static struct iommu_domain *
+riscv_iommu_get_msi_mapping_domain(struct iommu_domain *domain)
+{
+	struct riscv_iommu_domain *riscv_domain = iommu_domain_to_riscv(domain);
+
+	if (riscv_domain->s2)
+		return &riscv_domain->s2->domain;
+
+	return domain;
+}
+
 static const struct iommu_domain_ops riscv_iommu_nested_domain_ops = {
 	.attach_dev	= riscv_iommu_attach_dev_nested,
 	.free		= riscv_iommu_domain_free_nested,
 	.cache_invalidate_user = riscv_iommu_cache_invalidate_user,
+	.get_msi_mapping_domain = riscv_iommu_get_msi_mapping_domain,
 };
 
 static int
-- 
2.17.1

