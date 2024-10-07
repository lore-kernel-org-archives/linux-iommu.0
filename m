Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29D018BC35
	for <iommu@lists.linux.dev>; Mon,  7 Oct 2024 08:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728290661; cv=none; b=J2GN8vu+mPba1V2IUmU5sY4p/LpUAN0ib3qoICvLqv8wzFhmLmgeM00vPQpNMvs31PhCMLTXWiRzG+p8zN+sByRGq2gqr+LoIxqxxJjA0UetmQk1ZBJB0a8mv90xyoskf5NEwZJpccf6ntRlq8HraetJ3CuvqAX/Hh7DcDBLKm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728290661; c=relaxed/simple;
	bh=mKRi/Ji2Fh1sjMKYDaFTsQoiTO1y9q7Tkh+RFrSPlx8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uj+xXwV4GUuwq4cIY6VG1kPinATNSsu8nCmG1ct/5WmZreFWuoZY+59w4ULaCt3X7ZGNeh7cpPWlN+CuTmVCcfBR877AIIFg8OvlwiFH3401vE/FCjcn0IihV+naEvlQe8xnlDz4O3UnbvRWHZNOl5zWimupYo9EhPZnQNrTBkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jViPrngp; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jViPrngp"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37cd8972738so2781487f8f.3
        for <iommu@lists.linux.dev>; Mon, 07 Oct 2024 01:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728290657; x=1728895457; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3LHi3FSgqeToo0bAXx9OkGGmGc4N8ZNIJ0FVCvSLrAE=;
        b=jViPrngpfG2Dw6BzMVdXgFPFuigl86nZqTRt32qzB+IfP2AAvyFpP9ntvi7SlDKNJJ
         pWc81o2SEhEzmVhPOtBITBexVkMcB48DjNRFdlLzzfoCY5gC6hNnH7AIw6xkLart2p9z
         qXkBByKOVeluDuJ+Qei8J5ncd0feX23MhghQPIk1F7TiDR/KB97YuCM61ab9Ud3i9CN5
         SJsRxNB0wolT6Bay2gtxvBwcImZdGDZe1Mi+Tk5IoLKwwQgUGefPKs7QcdsmzfCFsH4U
         H0D5NPjSqzXRE8v8bOSmI/rDNoj2KisS9e+CjDAT1+r369wprLpDniHSYvoo0JmJll9R
         Xesw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728290657; x=1728895457;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3LHi3FSgqeToo0bAXx9OkGGmGc4N8ZNIJ0FVCvSLrAE=;
        b=tqnh0Ahb6IHd3ajjjXoKKKohNS7A9oDdX2gaHvjmOTLlgfuOgakk2lT3ek/URmLDr7
         P7Wl2IUFqpFso5Svuy6IHD4d+JjrEZLF2ogtPDDlM4f4ckIHm/pjAm18jenrMULYKCTW
         2kSrszcOjEyb/TbkGRC8qV+3BQpNs08DQgbD0mGv+vCSTjEYXs6egusERSiRFMqOQFhu
         HaJn4WiLGDXneZrMOXKS6KeUdGcWud7j843s8JZoF6USXEME2Ye51TH8BiguprHYzoNs
         ADxjjgg/ItgK/1Ex75Uos7dfdSL6EdsNTmNorw4Zwr7nTiByz4eLxu5pbV+sNAPoLSYs
         1iuw==
X-Gm-Message-State: AOJu0Yy8Uu/bTEtdX1SkpYMCQazVB8U1ND/uz9Al4dih1KUVlBYJ7BBf
	VygukrRpTgZW72KU5Pf9TCyaywLAbcIkkTueJmOWHHzVNEIWUmdZQSTQnlsRxqg=
X-Google-Smtp-Source: AGHT+IGPW8AlxiTySRc6I/+8scs6PQYUwE3ih2A5K7OfKFBkNDD6AHxmZ1xsS/wmALuniaK6EpqCcA==
X-Received: by 2002:a05:6000:1046:b0:37c:d4a4:3c2 with SMTP id ffacd0b85a97d-37d0eb0be52mr5063548f8f.49.1728290657279;
        Mon, 07 Oct 2024 01:44:17 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1695ebe8sm5196528f8f.79.2024.10.07.01.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 01:44:16 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH] iommu/amd: Use atomic64_inc_return() in iommu.c
Date: Mon,  7 Oct 2024 10:43:31 +0200
Message-ID: <20241007084356.47799-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use atomic64_inc_return(&ref) instead of atomic64_add_return(1, &ref)
to use optimized implementation and ease register pressure around
the primitive for targets that implement optimized variant.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/amd/iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 8364cd6fa47d..074effba7fbe 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1230,7 +1230,7 @@ static int iommu_completion_wait(struct amd_iommu *iommu)
 	if (!iommu->need_sync)
 		return 0;
 
-	data = atomic64_add_return(1, &iommu->cmd_sem_val);
+	data = atomic64_inc_return(&iommu->cmd_sem_val);
 	build_completion_wait(&cmd, iommu, data);
 
 	raw_spin_lock_irqsave(&iommu->lock, flags);
@@ -2890,7 +2890,7 @@ static void iommu_flush_irt_and_complete(struct amd_iommu *iommu, u16 devid)
 		return;
 
 	build_inv_irt(&cmd, devid);
-	data = atomic64_add_return(1, &iommu->cmd_sem_val);
+	data = atomic64_inc_return(&iommu->cmd_sem_val);
 	build_completion_wait(&cmd2, iommu, data);
 
 	raw_spin_lock_irqsave(&iommu->lock, flags);
-- 
2.46.2

