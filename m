Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0666442389
	for <iommu@lists.linux.dev>; Thu, 24 Sep 2026 08:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790240190; cv=none; b=X020Nm4rXXf2sWu6Fm1PiPqE7IFGXlclWmu5L4mdCrZRDw4ZbmjEu1hU/2XgJi+1PY8rFllDXksEAy45j+kLd5hlic58MEkeGQnQoliiy6P04xjSvGH0nXAd8hk0Jr2Igei1FLyn4lVo66WgZ0DAL4ERsOqvgjJlP4NPmWyZIyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790240190; c=relaxed/simple;
	bh=Cj4FjSHKBjv54u3XmmA+qTyMekhASSwlkn3EL5F2Ass=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J2NYUvet6jPG2ihQnrF5uKIFiCvM3LfawFXdVbZWC1DobIDYzOSwpPCX1NP4KBTVuOW78KIotNRU2ps7XjoXwARpz+AUAHx3iZIDvrAf6GwNybGr9r+vB5alAs8tK4dOg69wOq8lAI+1dzghL3y4sBI54pl3mQTBrpzF0SlM+zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m1XIJ58o; arc=none smtp.client-ip=209.85.208.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m1XIJ58o"
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-6aa734a721dso2604072a12.0
        for <iommu@lists.linux.dev>; Thu, 24 Sep 2026 01:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790240187; x=1790844987; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jyisHEHOouXDnRhVknZZL0KL1V1yIbby3bAAKhAOqX0=;
        b=m1XIJ58ozIV9r9AVOinTOupPFkV8KtFXDeECEfhZ9odUgGtOX0L0Ku4RIp6EG2EhHx
         wll3vVWstmSwWRhr7zcx9VRK4imlwjrA5V4Xt8mpv9z5MXZrI1NgM5q4jshc+PZGgrFZ
         nAaRsLyscQn+Ht20RIVgs4Vtp05efZ28cZUNF6Cq3SnbyhMch0euKDM4KKZaXBjGa2CK
         ytOxXwPkmFOU++TnHcJzJLEthHwtBm0Fn9sQNc1JasdzC2vsyELBu3oBNmGUVD+XmS39
         G7CHSZlh3kKnYkSCVEcjJmwxQdCmQThCi7j9lTppWEQAEC341wturF2HUXVXRz6+ZsKx
         XRoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790240187; x=1790844987;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jyisHEHOouXDnRhVknZZL0KL1V1yIbby3bAAKhAOqX0=;
        b=JtEdJB4NCZtm4mK6EjtDE/K1lSjhdKa7oppfeYTJMXEcb3Z4saZaYN0LyWnGlVgNPN
         JxjETElO8tpAmiH5ilIXKhFYRyd4RpgzQxAUMNWWep2EZbcjnMScx83o4PZaCR9KrqcJ
         0aM7I90sU5KY+jy8GLbziPYTVCs4dEMoE1aFFUsGsYVKRzJcBG5hsgXndkgfJvh5EqYF
         5+GSEIZw/ctGzt55Z51+0jjoujpBmiQNIrEmSdZOu2jvDCqUI2iEupc9oWdb+crsl1K8
         W5j2XDxz7SnhcvyOKLTKbb+jmK5raoUT8aBTYhQgKUKchp4SdeIWYJcsLKi1QlCppGw4
         CZWQ==
X-Forwarded-Encrypted: i=1; AKwUvBw13r63KoI6JsscUm+g/d3hW3sjdFkXdObObd4Ptj77CW8o0pCNV18Vf4jx4p3b7MOhnAsISg==@lists.linux.dev
X-Gm-Message-State: AFuF++n+OZ7dctI8jy+o1hX7q9TEQx+lF0yLt/m3gn/3q9kZ8vrnGH+Y
	bK9y6+4iLGhzUmTZCQ9ffXFsWK+dAkFqUiiOg1EeNhxNiCem5gUiKmJB56EU0t83c9R8OuQBOPJ
	ONFZcifKq27SzLQ==
X-Received: from edb11.prod.google.com ([2002:a05:6402:238b:b0:699:e9c8:2d72])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:5186:b0:6aa:a7f:d584 with SMTP id 4fb4d7f45d1cf-6aac90949demr1600686a12.42.1790240186819;
 Thu, 24 Sep 2026 01:56:26 -0700 (PDT)
Date: Thu, 24 Sep 2026 08:56:13 +0000
In-Reply-To: <20260924085616.300650-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260924085616.300650-1-smostafa@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260924085616.300650-3-smostafa@google.com>
Subject: [PATCH v2 2/5] iommu/arm-smmu-v3-test: Fix arm_smmu_v3_test_debug_print_used_bits()
From: Mostafa Saleh <smostafa@google.com>
To: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, jgg@ziepe.ca, 
	nicolinc@nvidia.com, praan@google.com, Mostafa Saleh <smostafa@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

arm_smmu_v3_test_debug_print_used_bits() hardcodes arm_smmu_get_ste_used()
instead of using the provided writer->ops->get_used() callback.
This caused Context Descriptors to be incorrectly parsed as STEs.

Fixes: 56e1a4cc2588 ("iommu/arm-smmu-v3: Add unit tests for arm_smmu_write_entry")
Reported-by: Sashiko <>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
index add671363c82..eae08d4d77ec 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
@@ -125,8 +125,8 @@ arm_smmu_v3_test_debug_print_used_bits(struct arm_smmu_entry_writer *writer,
 {
 	__le64 used_bits[NUM_ENTRY_QWORDS] = {};
 
-	arm_smmu_get_ste_used(ste, used_bits);
-	pr_debug("STE used bits: ");
+	writer->ops->get_used(ste, used_bits);
+	pr_debug("Entry used bits: ");
 	print_hex_dump_debug("    ", DUMP_PREFIX_NONE, 16, 8, used_bits,
 			     sizeof(used_bits), false);
 }
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

