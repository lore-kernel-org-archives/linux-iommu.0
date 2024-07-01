Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2EC16D4FA
	for <iommu@lists.linux.dev>; Mon,  1 Jul 2024 16:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719850849; cv=none; b=Qllf24nj4io04c6NPAcvAvwZPaffRdXUUzyyqmZdbfURyHniPfHpWedz1uX1cSo0yoWUb6bTCLGsML3dZF0RXC1m7K3/iDYkFP0aVKLDNCmkY3BfNKHcdw18ePqURX8B86fO8zIke6PTST4xsSxkQPnixdS9ZITIo3CcHSmVvbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719850849; c=relaxed/simple;
	bh=S8trBRWU4Awt2Hdyx4x16x7C3F21AJMjvj1VIrEa89I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PPisnf/lYZUVdzaaRPGyT3UqE2pD1Ma9NRYMcEfwXc53hw+wFKeNXMs+p2mX4oE9O3qp1rHQdwPCWmGcYFfxCEKQM5elbmJHWOLFEPVLzIWyTUdVCvQphjVrXHfatH38240yIuOZ6zq0Xr0T1UsXewIJhE1k1cQHU2jIOql33p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xs4RPrUT; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xs4RPrUT"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-37636c38d6aso14733765ab.3
        for <iommu@lists.linux.dev>; Mon, 01 Jul 2024 09:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719850846; x=1720455646; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OWZgmKDZRrdhr1uUXK85/zqvq+/aZOrwP+oxnXRYvAE=;
        b=Xs4RPrUTGjgPYLZri/p0LLPix4JTvwCo53Wc4fslc9KzbkaTK4HIFig4we9y4B8YaE
         q0mRp7pZQoYyp45RJGe9te741XxSS4A9wVprX4qKkeqlD23YFSeIe7prEf1A7DJSNLZ6
         1Ll87Labm60E4TcQIz2541xM7rjvdG0erQDmejjV3GFXF9iOudLMh2imR+D3/ZsUKqgH
         RtSuCdgPQVbsh5xGQAmxKYlmWP87YoA+k3G3CpoLyNjUr73WZAyFEibzWYpH65n7v3+V
         323WPclIqnfTPcrEnTVfhsP0N10wd9K34UgqGeIz75mwXyAN7Lz0BwfmYZQRMio3E15k
         yqFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719850846; x=1720455646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OWZgmKDZRrdhr1uUXK85/zqvq+/aZOrwP+oxnXRYvAE=;
        b=ZfzZ+zwXWek3ejPdPkoUbJ0ky8sSI4gOXDcpo4wIcOl+52nL2cqGQA7vlIAIQ9isCm
         ikauc6yjcuz8VJAxTiirZu6M+SJ2KJ74bO8O31zbKbWJI5RNWT6clsdIVjSIjCKl8lFX
         Ox041Rpsa+jscfZmHiMtumawzUb6ewCXzNPc0XOXeY8nnnQ11Apls4OssKixWOs47yC+
         uJASVaiKRkjG+Qq+yeDzelSOYQqRnIZwXqEceK5b7NsXLBjRaR26YXjrhWVU9vJ8I9lC
         j0PM2XH7t4knHoyo6mf1Ieq1JypBBcq6ff3JMGei54SeUj92KJZ0ZxueFw68bEkVHgRt
         42RA==
X-Gm-Message-State: AOJu0Yw1WdTkW3rOOpT+LIArflxzttSumtBWahn0d7dK9zn0xY0Iw0Kw
	0KlJciu6PP3pDnPK4zHPjVLMxdNR4iinpyKGwP0Yj/xlOJFdXCd115Upxg==
X-Google-Smtp-Source: AGHT+IF4Q6jy5QIuCLxDiDWQRsnx6iHXwtvUgTE2lXBFYwEqB80Yt/8yPSYVyA6IBWuuR1iGqEUB/Q==
X-Received: by 2002:a05:6e02:1645:b0:373:7f70:bb8f with SMTP id e9e14a558f8ab-37cd2bedbf5mr95954605ab.22.1719850846207;
        Mon, 01 Jul 2024 09:20:46 -0700 (PDT)
Received: from localhost ([2a00:79e1:2e00:1301:e1c5:6354:b45d:8ffc])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c6c8ec501sm5246854a12.68.2024.07.01.09.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 09:20:45 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: iommu@lists.linux.dev
Cc: linux-arm-msm@vger.kernel.org,
	Stephen Boyd <swboyd@chromium.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Pranjal Shrivastava <praan@google.com>,
	Rob Clark <robdclark@chromium.org>,
	Rob Clark <robdclark@gmail.com>,
	Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM SMMU DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 2/3] iommu/arm-smmu-qcom-debug: Do not print for handled faults
Date: Mon,  1 Jul 2024 09:20:11 -0700
Message-ID: <20240701162025.375134-3-robdclark@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240701162025.375134-1-robdclark@gmail.com>
References: <20240701162025.375134-1-robdclark@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rob Clark <robdclark@chromium.org>

Handled faults can be "normal", don't spam dmesg about them.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c
index e4ee78fb6a66..681fbdfc325d 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c
@@ -419,10 +419,6 @@ irqreturn_t qcom_smmu_context_fault(int irq, void *dev)
 	tmp = report_iommu_fault(&smmu_domain->domain, NULL, iova,
 				 fsynr & ARM_SMMU_CB_FSYNR0_WNR ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ);
 	if (!tmp || tmp == -EBUSY) {
-		dev_dbg(smmu->dev,
-			"Context fault handled by client: iova=0x%08lx, fsr=0x%x, fsynr=0x%x, cb=%d\n",
-			iova, fsr, fsynr, idx);
-		dev_dbg(smmu->dev, "soft iova-to-phys=%pa\n", &phys_soft);
 		ret = IRQ_HANDLED;
 		resume = ARM_SMMU_RESUME_TERMINATE;
 	} else {
-- 
2.45.2

