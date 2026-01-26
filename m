Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1B126E6F4
	for <iommu@lists.linux.dev>; Mon, 26 Jan 2026 15:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769440332; cv=none; b=fxJY4j6ea8O8+gE+J47XaOA7K41u3gwP6N5jyb5hxd8b0V2Gggjdw/XKCLXZn19wFPbUJ53klsXin5E229dBBMCo8QedNWQWWv7jjjVv54OfJFMKZF6qR92I6mEVOkptWqZod5sOD6t32kNvdLsqj3GC1A3ii3qCiQI7XIKJbL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769440332; c=relaxed/simple;
	bh=8K4kf8T7S6NQBD/ROl0DQKPBAqq2YP31zP3Nyq6Yezw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aBJQqzxbi2vSGUPWg1eDwdsDR7kU29p09v+2eIP5jif9S8rI6ZDdHYesdoQ5i6S+MDteUHauR1GT5isY7xuxm6gh/1tO4jpHvPQFnC6TcVjD4A2jxsBQS60rpZsyiGjoerqDsqHMyTmV4Vfwe/WKmJaLhNgiaqDxxLT/YVVJxBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mymc6730; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mymc6730"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b62da7602a0so2881841a12.2
        for <iommu@lists.linux.dev>; Mon, 26 Jan 2026 07:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769440331; x=1770045131; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=G1AnEUCMxT70fiZLra2PBAU9BhA7GGWBpcFd8Vk7MRQ=;
        b=Mymc6730cDaXoEJ0AGbxwJMdS0e/UaRgZnpKlTJIBJGnlORn5X4w4Z+gbYybsRNdhW
         AR1vl+kOUFO5Q8YTfK9cH6p4TjNg8+4KKVJW2lyka5F0z6ZLwpDwTErtG0SilY0U1AxD
         aYoKEAsflgABOZRmrBXRZUvclvFXvTOFTEn0bU0oU5dDSEn7H4BAPmm1ySw6ORAKHoNn
         2bbtWjiRDsnknbdqPX0MnUNIgWOBoANn2jnuUvTTiScNV/z5XdOdZUqb94w9ZfG2E4IF
         YaUCbdECne3YYQhkGdZprMYIXUsLI7H/FK68ag9NzTk7gYB70xvYV/zwrDabXrtnJYND
         U86Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769440331; x=1770045131;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G1AnEUCMxT70fiZLra2PBAU9BhA7GGWBpcFd8Vk7MRQ=;
        b=m1gtal4l80SRSZ649hRMlExTxZgw9OrWCJvncEd3UPL0oge6btS38f4B0eypVHuCwA
         AesdQ7mSZJsesM89G9Lq6yAUSREYvkFhlVlyGcgaj3JK8wsQP836Qse7XD3t7JvILIdP
         dqzs8Z5Uf3F4xJT37TK8LBJDeByNrHGETl2L1zvEN+fqVhk6kER/CCpDS8YUCLVQigvM
         K/i7ti9GfcTaru5mDfqFjHFwCEVkZVPuoDIMdlNG3N00oJmMWHe/KlL0YryElfcmCoVc
         /ccoq8uWEkTobXvbvQ1Z02WlHHK8DPaadR5/Jjck12zIxDh23ja9/N9ngGCYi6P/aAaj
         qo7w==
X-Gm-Message-State: AOJu0YzDSkye7qbmgi4M1JOUMKdPVeu/MlU0UdVXhlCYqQ3lr8Qo9oAy
	4cJMwp5UNtUj2UmJ8mvVPlseVDVx8z4JZI7yxnr7xqfcGcDI5wz/KmrvLVVwEU8QmoAmSe0z1+k
	PNh8H4NMFkndAaoud9clhpgX4+5zXQpQtz1noSRmNw/zsWDelsEOmjvA49D/16VK4qYBpaS5UHn
	LwI21OniF8Svsaq9bhxtjRxJ366qwAQQ==
X-Received: from pga2.prod.google.com ([2002:a05:6a02:4f82:b0:c63:5610:9a42])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6485:b0:35e:5a46:2d68
 with SMTP id adf61e73a8af0-38e9f0e9df3mr3879012637.9.1769440330563; Mon, 26
 Jan 2026 07:12:10 -0800 (PST)
Date: Mon, 26 Jan 2026 15:11:51 +0000
In-Reply-To: <20260126151157.3418145-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260126151157.3418145-1-praan@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260126151157.3418145-5-praan@google.com>
Subject: [PATCH v5 04/10] iommu/tegra241-cmdqv: Restore PROD and CONS after resume
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	Ashish Mhetre <amhetre@nvidia.com>, Sairaj Kodilkar <sarunkod@amd.com>, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ashish Mhetre <amhetre@nvidia.com>

PROD and CONS indices for vcmdqs are getting set to 0 after resume.
Because of this the vcmdq is not consuming commands after resume.
Fix this by restoring PROD and CONS indices after resume from
saved pointers.

Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index 38d637fde86e..6a951386baad 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -507,6 +507,8 @@ static int tegra241_vcmdq_hw_init(struct tegra241_vcmdq *vcmdq)
 
 	/* Configure and enable VCMDQ */
 	writeq_relaxed(vcmdq->cmdq.q.q_base, REG_VCMDQ_PAGE1(vcmdq, BASE));
+	writel_relaxed(vcmdq->cmdq.q.llq.prod, REG_VCMDQ_PAGE0(vcmdq, PROD));
+	writel_relaxed(vcmdq->cmdq.q.llq.cons, REG_VCMDQ_PAGE0(vcmdq, CONS));
 
 	ret = vcmdq_write_config(vcmdq, VCMDQ_EN);
 	if (ret) {
-- 
2.52.0.457.g6b5491de43-goog

