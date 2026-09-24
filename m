Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE272E975E
	for <iommu@lists.linux.dev>; Thu, 24 Sep 2026 08:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790240188; cv=none; b=R/THJtvRm+NXXElJrxf+AS9I6u7fVQW8vo9Gut8zmIQOyTMFdG+ccmgbSxeSTmhX+OmFXIiPqiSAVEYuzU8QubZuIyQOhs5MeXM+OolV7qocS2LKy69yDNgxaey5aWqJS5ntQAcOyN6l4Ge+mewAS6IGQngXaLD9j3eNnFIRcoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790240188; c=relaxed/simple;
	bh=H4Hye3lEwum8JrGKKwmVp17OxeoL2fynOKi0O96y8bs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=R64DnqtEqDRl2NRd8BqNGDr/j5ls3E1toMI+WMH+wCw9cKB3465GVGyOTS89wpETYq46eJO73JJ4Ql8Lhg74/qEYgZeruI8R0IAS6RVstE9EEmWWE00GsRqyc28RFqJXQszf6aoXFdsPBgGNQsvhNcznCepcQPqv9fHebl8WluI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EqaEC7Lk; arc=none smtp.client-ip=209.85.221.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EqaEC7Lk"
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-486e90b59a6so1048980f8f.3
        for <iommu@lists.linux.dev>; Thu, 24 Sep 2026 01:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790240185; x=1790844985; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7LSd8Ovvvgudslzcc9mvhRx3yyqB59TfcDqoB3H0gGE=;
        b=EqaEC7Lk8RKI/Vkjwj6cfaMlIo3E+Gg0gxaLWNwLeNk7zjcQleBbrp1GmEGMaSaii5
         VFrsEDI5KwkfZCSHRF0850/C+SkQFYo8rLxOhrBe5S7lKJNTrFYDu1/r6GyhBY8UOBkz
         qd9XHzcSydXt16C7LyLL7Bng2jO7b0c2FF3uZudmoovVYH6C8MPWYPSryKeiJTiGpew0
         miLLpvDatHu5eo8WkXC5ILd1IB9xAv7O0NkxvJuVr3nr2EKUFfORkPzIEN7SlTUISBMu
         wavQJFYkVNLcfsOl6I/yL6LInRvtuas2WaWIyTDk49XynIIQZDsOuFGNKgTwJowS4PDA
         PpLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790240185; x=1790844985;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7LSd8Ovvvgudslzcc9mvhRx3yyqB59TfcDqoB3H0gGE=;
        b=p7N0bxhA4K44se+fq/u+qhDylNpmxiFfJTyGpIlm3saWcdSBQLJSWib7PkSE9SOyNY
         cUiUmEnErXsm5sAD+RKHbcmsTrkIXWMWqluxXPvu5sMlJpxlLF74fPorSs3Ij5/0wfxw
         fsmkEBGHFPVdD4WGIm/e88kwwHhzAuho2cxufeaYhJiCpq/T2dkcEUcQBlozwjTau+WX
         9x1szTI8JuyBNWmoBRGMRHZmwLOM25nBxDQ9e86ANgeltAStFmLr/5Zb9c+v+OLMrpqt
         W6wksGTyLNmRgFs6ukadTC4/WQSDBHBzHDDWGjHMjdYzzkEWRBfGetKJ+dBh+5T5CNFO
         76fQ==
X-Forwarded-Encrypted: i=1; AKwUvBy4J3IKrWkCU/xJGLEdY7tMoWeWlAteDv2M8DSnn5EKUiio8gFIjhSQgLN5YQnU2dIHZsz3Jg==@lists.linux.dev
X-Gm-Message-State: AFuF++mHIsu+5JUbL/YQUvFAbu3Tam+JfzGNn3bR0iMiNwuqFSlefyXF
	XsM2ftN6jvuHyGdkM1Ddt98prHrV3JuQqjQOPeLO07W+u9L78tjr1X0yysNr/73os/UEBt22Sfx
	tJKXc6pMNISG0Jg==
X-Received: from wrhm8.prod.google.com ([2002:a05:6000:1808:b0:487:2121:9f6c])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:41ee:b0:487:221f:65b8 with SMTP id ffacd0b85a97d-4887177530cmr2877325f8f.50.1790240184346;
 Thu, 24 Sep 2026 01:56:24 -0700 (PDT)
Date: Thu, 24 Sep 2026 08:56:11 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260924085616.300650-1-smostafa@google.com>
Subject: [PATCH v2 0/5] iommu/arm-smmu-v3: Fixes reported by Sashiko
From: Mostafa Saleh <smostafa@google.com>
To: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, jgg@ziepe.ca, 
	nicolinc@nvidia.com, praan@google.com, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

While running sashiko locally on the pKVM SMMUv3 driver patches, it
reported some pre-existing issues in the SMMUv3 driver (the RB tree
corruption and a missing NULL check) and given that this is not the
first time a pre-existing issue appears in the driver from sashiko,
I went ahead and passed the whole driver to Sashiko which reported a
dozen of other issues(except the last one in this series), I included
fixes for bugs I believe are true or worth fixing (others were mostly
missing NULL checks or bizarre HW/FW configs I don't think are needed).

I also sorted the patches based on severity from the most critical to
the least, so it is easier to apply a prefix if some bugs are too
theoretical

Changes in v2:
v1: https://lore.kernel.org/all/20260828125409.1921538-1-smostafa@google.com/
- Drop patches 2 and 3 as they are fixed by other patches on the list
- Collect Rbs

Mostafa Saleh (5):
  iommu/arm-smmu-v3: Ensure L2 tables are visible before L1 ptrs
  iommu/arm-smmu-v3-test: Fix arm_smmu_v3_test_debug_print_used_bits()
  iommu/arm-smmu-v3-test: Add missing error checks for inv array
  iommu/arm-smmu-v3-test: Fix OOB in arm_smmu_v3_invs_test_verify()
  iommu/arm-smmu-v3-test: Fix UBSAN error

 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c  | 19 ++++++++++++++++---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  6 ++++++
 2 files changed, 22 insertions(+), 3 deletions(-)

-- 
2.56.0.rc1.315.gc6ed9934b7-goog

