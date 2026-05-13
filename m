Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E19D3ADB99
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 21:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778709177; cv=none; b=e9hvkiSOMgH+mN3BB1lSyNEZmv4LXUpHC0a9RBQ2XQB3pgyct/h9E3sy8VR13aeA52uVDV0lAMja0wrbOKDxtnwJhoZPBGWjmOSn7zLzzLQLiVtUZvgnvdUX+SW3zUmO/tGgBjIZfu1gS3pB9VgwK/D25B0/Nb5DExsuflW+C7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778709177; c=relaxed/simple;
	bh=+OczJGrSk8p/b3s2p7AbRUIvZaBMC0oHxGZgBms07fs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S7C4soz/pswrply2+imVjEsY89kh7bAWXa245pMmGEniCqHV1UJL0YpLysUUpnYiRk/3IbtriNgSET9Xu3IU9rkfPtFiE0RJheBV3S/KfzJdirfVUGudQA3w5nfslkAeqpRIIp/d74lX9rSGc7/KGGxlDEshf9rJV6Tt8ZiOYbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iOxxJTEM; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iOxxJTEM"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-45d7293c595so401790f8f.1
        for <iommu@lists.linux.dev>; Wed, 13 May 2026 14:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778709175; x=1779313975; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B4gZFEOmN4BitsxINTjrbRsNtg0gv58NYoTuWrSbwJg=;
        b=iOxxJTEMI/6EUwCtgAskNVYs5Vs4KcIp81i2q3dib67gtfZ/+Qo4lYNUeAVWEERzz4
         sxsSSN/sW9POsEVHsqJqbqPJucgOC/VR+qJARqJ/3L8r4pkAStTK0FNFQ/aJZlyTeFXT
         KzIEptroF9GqWTxla0GXGelq6wGdcbRHIJVsk4KOLit8RTjn5DIckorDior3B0yDhyWi
         YBTBiRvMWjcv1Ifav3nFypp7rBE6gNgGomHlUASmdc7+z1mHtX47aMp6qR5fwVRh+czA
         4/FmNNuj6ZLMle+/mM+e46eoPBK5myZMvetjWOZ5p4Std/P/nQtL/qztbEtOtVVHWRpu
         4L5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778709175; x=1779313975;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B4gZFEOmN4BitsxINTjrbRsNtg0gv58NYoTuWrSbwJg=;
        b=AH+EysNQe1bx8goy4KNpqOgo/283t48CLjLAaG3lGbbcipeiy9dS4yOqg/xVhZ1yAp
         XXwBNv6CUPZIK8XXAf7W9mLSesSpaBMqrzVUXVGGbpJsVNxp3wD+9IAULCEV4Tr4W81S
         ZUuq97ynLr4PqZ+t/NAkFDBrmCc378uDeV/xZizF0gTSp37o5HJgOxDXPwmSHBiMC48E
         fmqfJXCS0x+rfEs27cenasSTjgiG02/KsZm0fXoVUfPo36CRkMBa+QWPo9P1bGVkkP2v
         uIBAJz5P2oQb4gHr2HKfPhg80h66KuB0+/RbLRLgdN37Km8QjrxeyEZYTZJa4eD9LF//
         BajQ==
X-Gm-Message-State: AOJu0YzjEAn8Of2GSvWtYgbQ9dDYIEGNPai71VxzwzgiznovSKji3IC1
	q14LTAMDmVLJBysvYCh9eJGVjeFRp3UI8rNHHAYhq9mp5XuL7h7mKuaPqhfz5nv0aUmKUMQBTvt
	da5tbm7wsOiBJ4AmUqIUxQlXc9tYbdB/eOc9FlazS/iGmzx6GeUohuUDAKfAeEgeWppiP6SxF50
	rukuaRKMeCc9362sQ81/aJdjy7CRgSm4FdTLijVb+qX6nkYg==
X-Received: from wroe2.prod.google.com ([2002:adf:ef02:0:b0:43d:6fc6:5521])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2486:b0:44b:e349:e6bc with SMTP id ffacd0b85a97d-45c77b7bacdmr7661958f8f.3.1778709174704;
 Wed, 13 May 2026 14:52:54 -0700 (PDT)
Date: Wed, 13 May 2026 21:52:03 +0000
In-Reply-To: <20260513215203.3852661-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260513215203.3852661-1-smostafa@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260513215203.3852661-4-smostafa@google.com>
Subject: [PATCH 3/3] iommu/io-pgtable-arm: Use address conversion consistently
From: Mostafa Saleh <smostafa@google.com>
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: robin.murphy@arm.com, will@kernel.org, joro@8bytes.org, jgg@ziepe.ca, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Use consistent address conversions in the driver:
- virt_to_phys(): For all virtual to physical address conversion,
  convert __pa users as we don=E2=80=99t need to rely on it type casting.
- phys_to_virt(): For all physical to virtual address conversion,
  similarly, convert __va users.

That changes nothing at all. However, it will be useful when
compiling this file for the KVM hypervisor as it can cleanly
replace virt_to_phys/phys_to_virt

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/io-pgtable-arm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.=
c
index 86b23aa04324..476c0e25631a 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -143,7 +143,7 @@
 #define ARM_MALI_LPAE_MEMATTR_WRITE_ALLOC 0x8DULL
=20
 /* IOPTE accessors */
-#define iopte_deref(pte,d) __va(iopte_to_paddr(pte, d))
+#define iopte_deref(pte, d) phys_to_virt(iopte_to_paddr(pte, d))
=20
 #define iopte_type(pte)					\
 	(((pte) >> ARM_LPAE_PTE_TYPE_SHIFT) & ARM_LPAE_PTE_TYPE_MASK)
@@ -429,7 +429,7 @@ static arm_lpae_iopte arm_lpae_install_table(arm_lpae_i=
opte *table,
 	arm_lpae_iopte old, new;
 	struct io_pgtable_cfg *cfg =3D &data->iop.cfg;
=20
-	new =3D paddr_to_iopte(__pa(table), data) | ARM_LPAE_PTE_TYPE_TABLE;
+	new =3D paddr_to_iopte(virt_to_phys(table), data) | ARM_LPAE_PTE_TYPE_TAB=
LE;
 	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_NS)
 		new |=3D ARM_LPAE_PTE_NSTABLE;
=20
--=20
2.54.0.563.g4f69b47b94-goog

