Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7124E296BCF
	for <iommu@lists.linux.dev>; Sun, 30 Nov 2025 19:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764531924; cv=none; b=WSOAxo/GYxQiVFk1xe2+s5pSA9KFLEXZoxbgMUICGfHfCOE2oFoR01dU+Xr8CNhNC0be5z6JW34M4Dd79EHMfwy0vQwSCP+7bh0AbShvkkM+HoTBpKt6/f4mVXblZnM6pl75LQWNlRcrkhJstkoaV/WB4Bd9kgKVVgaijRrmSu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764531924; c=relaxed/simple;
	bh=WfVkj8pEntebpBsg4mVtXPLRxLG+3qfn6UXm3jIrd0U=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tO6LB3g0ivMXbklha4Ova+Uu/1y1i6sJYdUK07D26IcLavWnweqWqtapxDz+VXLPOBq9Cvpp3KebbMPwOCYN+dCU/AVFQ+Gzsmu4cgf6tDkRratshy+VYRcCyvSuJPrmPeNaFc8fka0DFq5drADEvp/wUcKDdrjgPpor9bs0+Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yuMk5GHc; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yuMk5GHc"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-477c49f273fso39343745e9.3
        for <iommu@lists.linux.dev>; Sun, 30 Nov 2025 11:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764531921; x=1765136721; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VpKzwW+DrSxITLrqVUpcZpbwlWPuuva1N93VFVuU3gQ=;
        b=yuMk5GHcaLme5EkWB33glrd4qDbrp0Hs7vVHOkY75wolMJgPFy2cAFkZUSSgMl0QFa
         guOBBeh9ZyIP/6u6QMzoHmIWvjX99zpIxcuPsnd2v5TJlQgxKw0ZnOtGSrd35XBxqaFI
         Y9LTg/tEHa7D7lWTqgX/wNrqZZEm/I63wcDnZaRQCCsqyCPRBMdOER1tWIT3BrNVCd+G
         5PuQEP3yS5BxbLUP+QNjkASgie3OMFDyPFSeTB6Q/G/oULtL8/5kD1VxJFNhUqTvsg1D
         8CjY3Ggkv0hdX78uBfZHcdpFqb+JN7PfgcMXp6t82qgyTNy+lgSw3sbg24qmIzRakQeC
         B45g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764531921; x=1765136721;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VpKzwW+DrSxITLrqVUpcZpbwlWPuuva1N93VFVuU3gQ=;
        b=mSm/4QUujIwItKUQ9N4Foqu+157GheicuCIqRflpriAh42L+xhdtJ0kLUxAHwjrdhC
         YjMTXeNKgsb+p6kmPjgzXZb55jUtD3vBypn65uxEFQLfxg8Ct4OFrYWyrMqJ+bTkC64H
         ChaZMZmGIizCoq2DGia4Lm72mi7nMzMTXJk4hyXbv2Yt5Ycr6RBK19FVn8yF/CWfRrjc
         0qyj6FwnegnOdrTrAKs2j1QyX9JQ1JU6h1r14IWyPV6wFmYNgfeA+Xak44JyOi+SheDf
         nYqouva91oQMs+ePTIXmOOGvPIWNzoe4AYe89/dYMci9uq7qXBdxlOcTchHXg9paF0WL
         GgcQ==
X-Gm-Message-State: AOJu0YxRCzAbPMjgMVmZnt3OxKHOdufrhxUC6tiE8Z+8FQXk/ADESD04
	dGK+/hfMt/chZhDhXAlOQr0zmc7yD3IX/mA6M5VNwbvOiAvbQn7pZ7rPbHpr7PPf5f0aa/172Y4
	WvRZRNUP5mxbLL8boSl1VFX8I2q6HeDBfOs903U3tVO5h8vyuYMO0xu/buG3k2rp8dYQt2O3Le3
	WgQzMxH8LpPfO138nozcPMczKXMXcKO9LQRXzoIAJ/aM37MA==
X-Google-Smtp-Source: AGHT+IGX+La27FykkneboKedWl3FbPZ7fIp0DKL/wu8LaMWfDRdIsROXD63+Az5xZoHNsgdO2DB82IvlLgkaUQ==
X-Received: from wmom17.prod.google.com ([2002:a05:600c:4611:b0:477:40c1:3e61])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:354b:b0:46f:b327:ecfb with SMTP id 5b1f17b1804b1-477c0184c45mr341232415e9.9.1764531920917;
 Sun, 30 Nov 2025 11:45:20 -0800 (PST)
Date: Sun, 30 Nov 2025 19:45:06 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.487.g5c8c507ade-goog
Message-ID: <20251130194506.593700-1-smostafa@google.com>
Subject: [PATCH] iommu/io-pgtable-arm: Add misisng concatenated PGD cases
From: Mostafa Saleh <smostafa@google.com>
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: robin.murphy@arm.com, will@kernel.org, joro@8bytes.org, 
	Mostafa Saleh <smostafa@google.com>, Tomasz Nowicki <tnowicki@google.com>
Content-Type: text/plain; charset="UTF-8"

arm_lpae_concat_mandatory() assumes that OAS >= IAS which is not
correct for SMMUs supporting AArch32, and have OAS = 32/36 bits,
as IAS would be 40 bits.

In that case, concatenation is mandatory in some cases.
Document those and add the checks, this can be simplified; instead
of adding extra checks we can say that concatenation is mandatory for:
- 4K, start level = 0 and OAS <= 42 bits.
- 16K, start level = 1 and OAS <= 40 bits.
Which cover all the missing cases.

Reported-by: Tomasz Nowicki <tnowicki@google.com>
Fixes: 4dcac8407fe1 ("iommu/io-pgtable-arm: Fix stage-2 concatenation with 16K")
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/io-pgtable-arm.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index e6626004b323..ecf27e86b429 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -223,6 +223,8 @@ static inline int arm_lpae_max_entries(int i, struct arm_lpae_io_pgtable *data)
  *   b) 40 bits PA size with 16K: use level 2 instead of level 1 (16 tables for ias = oas)
  *   c) 42 bits PA size with 4K: use level 1 instead of level 0 (8 tables for ias = oas)
  *   d) 48 bits PA size with 16K: use level 1 instead of level 0 (2 tables for ias = oas)
+ *   f) 32/36 bits PA size with 4K and 40 bits IAS: use level 1 instead of level 0
+ *   g) 32/36 bits PA size with 16K and 40 bits IAS: use level 2 instead of level 1
  */
 static inline bool arm_lpae_concat_mandatory(struct io_pgtable_cfg *cfg,
 					     struct arm_lpae_io_pgtable *data)
@@ -234,13 +236,13 @@ static inline bool arm_lpae_concat_mandatory(struct io_pgtable_cfg *cfg,
 	if ((ARM_LPAE_GRANULE(data) == SZ_16K) && (data->start_level == 0))
 		return (oas == 48) || (ias == 48);
 
-	/* Covers 2.a and 2.c */
+	/* Covers 2.a, 2.c and 2.f */
 	if ((ARM_LPAE_GRANULE(data) == SZ_4K) && (data->start_level == 0))
-		return (oas == 40) || (oas == 42);
+		return (oas <= 42);
 
-	/* Case 2.b */
+	/* Case 2.b and 2.g */
 	return (ARM_LPAE_GRANULE(data) == SZ_16K) &&
-	       (data->start_level == 1) && (oas == 40);
+	       (data->start_level == 1) && (oas <= 40);
 }
 
 static dma_addr_t __arm_lpae_dma_addr(void *pages)
-- 
2.52.0.487.g5c8c507ade-goog

