Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DB4383B1
	for <iommu@lists.linux.dev>; Fri,  9 Aug 2024 17:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723224444; cv=none; b=a+A4T5u+k4xhQm15nPlwfCwakHTvwN3vr/4Cw6jioKvOgjjo9DkvFKO1MuQ+ptxntr3RJ8fUq6lZxdgeQcacrfulXe1uaL7cdzk5y15sJWhqVkcpFO6AiUL74fb6nodZ/wHWUSYndHiKpz2SRnxtUc59VAbE7BXUKXMudR7XisY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723224444; c=relaxed/simple;
	bh=FlHstR73F4adrjgCHMFGjSYm9SWWKnD0W2zVjuzFlJk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cVtFeD/gDpMZk0Cj0Jbk37TOpFkhxsf5lkeRNHPYQaroOw+EGy7M061f7lHnA1cLM/8k9SbMxdzj4BxuJvxF1RrmCdtc3nmuAjEHn7JilEy1BiaSDv6CKxzVa2ysURMnxl5JvEYv2FSP8SjhKajPKv2GQUnMuOZgGj+oyZRuWm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eyo7T0zY; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eyo7T0zY"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fee6435a34so19978545ad.0
        for <iommu@lists.linux.dev>; Fri, 09 Aug 2024 10:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723224441; x=1723829241; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WQPvShp7okcQ7JAAqXTExHsdJANgIA/pYy+7v5WQOgw=;
        b=Eyo7T0zYYsYcdmU2VVVMmYRgDHVKVp8sFetMbnu9kB8WpYHOR0dnb3N72/LUohwbM6
         59QBF2jwb02OgGgXoagwITEW265UeajWRZ/TfH8TmxnPoHWyC1g5AJQVNpTrnfeq0hoN
         cM2LJub2NjF5jdyqrvBTeT0uy7aLw9GEVfcSYTOx4kXZWOheyTZbYq0WGA+fevp7FZOQ
         73x7fDFSVXpUCO+oJ7pcQVg0cvOVpCvtNjFdcBbpaQ7MW7ZB2xsZu2GfGrW+8LUXtx7m
         hPLH7zZvqtcNglM/bj6n3BjilavrSAdB6vo4sJy/YmvkDTgxAYMfxmog3KW5cZbMc2LL
         32nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723224441; x=1723829241;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WQPvShp7okcQ7JAAqXTExHsdJANgIA/pYy+7v5WQOgw=;
        b=vEJ16rj20eCpQgxxBkpe4lQXTdS7EVdrBWw8Smu0CRujnhtzFtEdClhJy4f+nwk1cR
         ZqVIEmdFHoBd3oQZO0gdUQqImN2cgpAuAj8x1OPHKAa1xv+9Lwobh8pxrz4GS3+RxzGy
         xoN17VMyp4SRqmCsIm7QKCQlMe7iOLfWDeyqNDBtahjCbHmyg8KEYPD8Khf1XHW6gMM8
         peh2N51oNiWXXSp66A2tWU8llU5uU36frlPW2X4UFpMNT3Im1yMt+XMwJWWJCS2S3F5u
         Zt3RFxioluayCC/yVn3EKrG+TYhi6lxYlbGkey9rLo4IOtWbuwzXdO7T5XoTzRIpNU6i
         WEZw==
X-Gm-Message-State: AOJu0YzIrEi1Ns88YZIWoRBa52XvdBTVXs+C2mRaKjy20XxsT2kPWBdp
	CxsbWGybcR01NuvzJfSvh4UKws7MySG1vcZSYBvfLe9pzQpVvgKPTZEaXw==
X-Google-Smtp-Source: AGHT+IEkjgGPg89j21Z6sTTJq8iGEXpSiujWsxC7JsiG4AHSF1ZSDSAZTLb4PrewOtx7fnimA5C9Jg==
X-Received: by 2002:a17:903:2308:b0:1fb:8cab:ccc9 with SMTP id d9443c01a7336-200ae5cf9aemr27913985ad.45.1723224441376;
        Fri, 09 Aug 2024 10:27:21 -0700 (PDT)
Received: from localhost ([2a00:79e1:2e00:1301:12e9:d196:a1e9:ab67])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bba0db27sm56455ad.239.2024.08.09.10.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 10:27:20 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: iommu@lists.linux.dev
Cc: Rob Clark <robdclark@chromium.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Georgi Djakov <quic_c_gdjako@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Pranjal Shrivastava <praan@google.com>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM SMMU DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] iommu/arm-smmu: Un-demote unhandled-fault msg
Date: Fri,  9 Aug 2024 10:27:14 -0700
Message-ID: <20240809172716.10275-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rob Clark <robdclark@chromium.org>

Previously this was dev_err_ratelimited() but it got changed to a
ratelimited dev_dbg().  Change it back to dev_err().

Fixes: d525b0af0c3b ("iommu/arm-smmu: Pretty-print context fault related regs")
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
We have crash telemetry watching for "Unhandled context fault", so we
want to preserve this error msg.

 drivers/iommu/arm/arm-smmu/arm-smmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 723273440c21..8321962b3714 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -417,7 +417,7 @@ void arm_smmu_read_context_fault_info(struct arm_smmu_device *smmu, int idx,
 void arm_smmu_print_context_fault_info(struct arm_smmu_device *smmu, int idx,
 				       const struct arm_smmu_context_fault_info *cfi)
 {
-	dev_dbg(smmu->dev,
+	dev_err(smmu->dev,
 		"Unhandled context fault: fsr=0x%x, iova=0x%08lx, fsynr=0x%x, cbfrsynra=0x%x, cb=%d\n",
 		cfi->fsr, cfi->iova, cfi->fsynr, cfi->cbfrsynra, idx);
 
-- 
2.46.0

