Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236CF19AD4F
	for <iommu@lists.linux.dev>; Mon, 12 Aug 2024 20:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723495994; cv=none; b=q8trnll6IFPIVjJXncFoc7/BPhgWEAnSgk1/QBjjzGtiXBqYZ/IAehPQBFcBGxkAYwdyO/06LU+0djDbqU2z988BeIMC0f69/blBqCMUVWms/x91TPI2G8k1wSe5atyxM1tsF+DeYvY8luPidhqwDphDcNeZxXvTJj6Z3MDQQIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723495994; c=relaxed/simple;
	bh=AO7ZaM0rV8gCeZFa0CDgjrQUyGvXxJgF5ZrE/xJh6Xk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZQnpy2++q2AUdw7svpFVXFjDZeWUu1MvOKDSFmSfoOvur4dBHzu25GGPXoerSlV0ybaZ1DSciN6yUqn8H88sY19jfhjCcl24vrSdQFOoCEyOkoLrVjLTn1I+5j6+z/QbNbxDJ9wk39il6R9KYDrrFMu7X3W2Y9qJrfkm8rXStb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d7LbnlRq; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d7LbnlRq"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-428207daff2so32459095e9.0
        for <iommu@lists.linux.dev>; Mon, 12 Aug 2024 13:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723495991; x=1724100791; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6XoN+HaFS5yfD0CNRqQpWijMjbiOviXEPumC1NW+kKU=;
        b=d7LbnlRqgGwmP0qolxVap5VsdAYn0itGfeSG8XC2kBVRsrlcISNdJ9fJ+a6/no6aPe
         b1HuIhDErWV4MzAzBd51fdgMkQgRTb+xwdhLCkOmGlyPdQ0jtf84AH/N26o6o/t/k61H
         mWXwpHh5I35+fBh0NvfU3gy/fe5q1ruCAAZ5oAxU1ELjmoLXHQONDHoB1WyUl5F5V1NX
         l5/0xbgOY4fN4P4mVtzrBoXkskXPPJqr0oXNpLB/AC+dOmYnaC+NRsMYK5909Oh5O4mb
         GeG6pBBqAKxo14nzc/+bPebi3Tg+X3gXnkLYilyl5EuxyxY6fQ5Oj7naOoCG0u8Tnj5D
         tuBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723495991; x=1724100791;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6XoN+HaFS5yfD0CNRqQpWijMjbiOviXEPumC1NW+kKU=;
        b=Pryl5IB1QcQZvWsOqqdP63vVfOV2Rtz/+w9n4SdrecUBH03xfxouNOtWO1Ol+0fI2U
         1m3JAqhInLFLL9ZGoZI/mkcYqHuqmhbdpecY5SrT4q6qiywOLJ2eDayR3u79WfPbypGk
         IgqirJxmbLNPnEYf4QBd4Jom31KLMKm0k7nqNzUYSXVDkbQWmBhEuF0igUrwjzDWlVJU
         buL6niMmxovGrZgSkGeM+Rysw6w8lPI9j3eR7ke7T7d5df63svXaFbv4WDX74jFdt2EP
         8BbV6baHR4yBz2SeSVyG0VNJGi1GIDObjVPwIobzxMNU0BPU/qBFGfoVGO7o5y5qoUQK
         YpBg==
X-Forwarded-Encrypted: i=1; AJvYcCXevCygKiZ0PieYwEmBbrgP34igJuZJngYPsK58x/nL8q6OPdvs/dgyptL4H8a7iRWRjhA9MriyyKJwt2Zt0bAppHfEc3o=
X-Gm-Message-State: AOJu0YwmVxw6Fwr6WPee+8Y0SV6YDoB8JXLfRRDOUEhbpddz2pH5q7nh
	n3fcUWaoN4fQrTO+mNYmdQ1e6ZDCkgIXDxYnzHZyw+vFcn5Dc7bxAGonSL069ghlcBk83N/NBdJ
	87oqwspapQg==
X-Google-Smtp-Source: AGHT+IFttRPjHqcCMA/MGAc53YWP+S1ssedfHB7twOrXF8ji7+KWw2xkkyaVB0s2fmulVPed+0z3LTjiheg2UQ==
X-Received: from mostafa.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a7b:c304:0:b0:426:59d7:dcc4 with SMTP id
 5b1f17b1804b1-429d48b0061mr30705e9.7.1723495991252; Mon, 12 Aug 2024 13:53:11
 -0700 (PDT)
Date: Mon, 12 Aug 2024 20:52:54 +0000
In-Reply-To: <20240812205255.97781-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240812205255.97781-1-smostafa@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240812205255.97781-2-smostafa@google.com>
Subject: [PATCH 1/2] iommu/arm-smmu-v3: Match Stall behaviour for S2
From: Mostafa Saleh <smostafa@google.com>
To: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, will@kernel.org, robin.murphy@arm.com, 
	joro@8bytes.org
Cc: jgg@ziepe.ca, nicolinc@nvidia.com, mshavit@google.com, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

S2S must be set when stall model is forced "ARM_SMMU_FEAT_STALL_FORCE".
But at the moment the driver ignores that, instead of doing the minimum
and only set S2S for =E2=80=9CARM_SMMU_FEAT_STALL_FORCE=E2=80=9D we can jus=
t match what
S1 does which also set it for =E2=80=9CARM_SMMU_FEAT_STALL=E2=80=9D and the=
 master
has requested stalls.
This makes the driver more consistent when running on different SMMU
instances with different supported stages.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 5 +++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/ar=
m/arm-smmu-v3/arm-smmu-v3.c
index a31460f9f3d4..8d573d9ca93c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1562,6 +1562,11 @@ void arm_smmu_make_cdtable_ste(struct arm_smmu_ste *=
target,
 		(cd_table->cdtab_dma & STRTAB_STE_0_S1CTXPTR_MASK) |
 		FIELD_PREP(STRTAB_STE_0_S1CDMAX, cd_table->s1cdmax));
=20
+	/* S2S is ignored if stage-2 exists but not enabled. */
+	if (master->stall_enabled &&
+	    smmu->features & ARM_SMMU_FEAT_TRANS_S2)
+		target->data[0] |=3D FIELD_PREP(STRTAB_STE_2_S2S, 1);
+
 	target->data[1] =3D cpu_to_le64(
 		FIELD_PREP(STRTAB_STE_1_S1DSS, s1dss) |
 		FIELD_PREP(STRTAB_STE_1_S1CIR, STRTAB_STE_1_S1C_CACHE_WBRA) |
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/ar=
m/arm-smmu-v3/arm-smmu-v3.h
index 14bca41a981b..0dc7ad43c64c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -267,6 +267,7 @@ struct arm_smmu_ste {
 #define STRTAB_STE_2_S2AA64		(1UL << 51)
 #define STRTAB_STE_2_S2ENDI		(1UL << 52)
 #define STRTAB_STE_2_S2PTW		(1UL << 54)
+#define STRTAB_STE_2_S2S		(1UL << 57)
 #define STRTAB_STE_2_S2R		(1UL << 58)
=20
 #define STRTAB_STE_3_S2TTB_MASK		GENMASK_ULL(51, 4)
--=20
2.46.0.76.ge559c4bf1a-goog

