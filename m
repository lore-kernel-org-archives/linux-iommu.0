Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2365740B0F7
	for <iommu@lists.linux.dev>; Tue, 28 Jul 2026 21:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785273090; cv=none; b=teJbek0tNRoh/PGAwWJEHGe6LJiIC4so1ESOwkAuqD1Ov9pwo7FThok7E+HcqiYbtbpvlzmjZcj4U9dGxAfoqeThW/q72FatUmjbLe89rnxHUgoun7rBScGijNkRa/O+Wac2g9J3kdgJRngk7EZfuTlyVY6gfwRSBgz9OnreFT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785273090; c=relaxed/simple;
	bh=gbSEZlF6LdABfGVlYjC1pRNYV3FZjleneyQQW5GXQQs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=BF1KKxwAo/YzquGdOIdfkteJjgfxbN0SQ6TJHeRDqsabxPSXgX7eoVf2+h0wBaYRYalBhUB5aru8lhYntIL18F8MOQehza47HBiwFOPOiTqLguM6nP4ve8ARkJUg1WLtnoXMnqUlDwT3w6ifiZOnxthYb6XfMve8AkTNI8H5DlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oY5L90os; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oY5L90os"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e4758ab46so229423a91.0
        for <iommu@lists.linux.dev>; Tue, 28 Jul 2026 14:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785273088; x=1785877888; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=E+3703fePyNSfsNt+o4YS0n51IZygR9Sm6Ij5ITQEeM=;
        b=oY5L90osKVO7/5CdnY0vezQinUe2LM++PcrZIOJTuOIAVIP/ZXQ08vYDRA5l5e/7X/
         3xSsfxqTHsakCbbRMckuTX4kv9dYUpbUmXY7oZLSTagXiSXvJZ0/7V8gUw7AcK88dhke
         736/jU0ueFcsU1qUSe/RB7n2vBpfXGeviTcP4LsHjbg8uqOays+4A221XZ0c1C01KxT0
         L8Hge9wK76qbK1Htox5XEc3RRRJ4gsEnzH35OtyHIPTxuclJ8K5Zu6ZLR6KPIvN1eIeR
         WNhK2iND5G5XynUDJmDGknk7uSgrSBWRwUighCyrZdsHhhNRGQl+zcI15JzPAmGKsFsC
         hs9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785273088; x=1785877888;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E+3703fePyNSfsNt+o4YS0n51IZygR9Sm6Ij5ITQEeM=;
        b=ZOhL6RIHjwLYpA4ojQvEj4DkbsxhvZ0rzgtpUk5w3ccascUXrweYD1TS1dfU5S1eyX
         0Revf2SdlEBU5BRLXhUUGOdbVafdxiAbZ5JBZHWNjWR02OWh/GxN6n8Ei3cpabD5vAuc
         iSxsXK08vYZlU/j6bFKz+qEkNJnekxIQcbOaJ/itLNgH7qWnNR0mpN/Ye3GCHLwBseCm
         GWCacDuANQddbg5FE6iOdSYs7phfmimdOjBA3DJNp8rDaarLTUuR2GNQA2inbMyF4cEA
         uU0Wpz+jF+RQ8jeeA+ORvxtUft8NIrlkYryOPDe39aw0BFDYxIMtpmj0G+MCgpuJaSJb
         n+FQ==
X-Gm-Message-State: AOJu0YyUIkLXXz7PevuBO83JIESgM2CWtBvDEqcViPACfPlcmjDLmDm4
	WpSreqJEv3E4FFAA+4EGQ8BfXVp8F8Njk3MVNQlUQKpbOzc6SlMSf+WXZ8fLCPqtPXkYp1O8BLT
	dK+BevY/wki4T0zcsruM5L8OTzwbpYyAIsShyd0D/NphrEgEQhXbz851fhLI26AmtdavosGv9gU
	8hFK3hVWYjQ0M8JoO1iQVLxzZBieTl6Q==
X-Received: from pgwa5.prod.google.com ([2002:a65:6545:0:b0:c99:d21a:f6b1])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7288:b0:3bf:6c08:2b27
 with SMTP id adf61e73a8af0-3c8ba5cdbc6mr4598322637.47.1785273087910; Tue, 28
 Jul 2026 14:11:27 -0700 (PDT)
Date: Tue, 28 Jul 2026 21:11:23 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.487.gaf234c4eb3-goog
Message-ID: <20260728211123.1059708-1-praan@google.com>
Subject: [PATCH] iommu/arm-smmu-v3: Convert to use atomic poll timeout
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	linux-arm-kernel@lists.infradead.org, Pranjal Shrivastava <praan@google.com>, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

The arm_smmu_write_reg_sync() helper is currently implemented using
readl_relaxed_poll_timeout() (that relies on usleep_range() internally)
which becomes a critical issue when used in the gerror irq handler.

If the SMMU hits a gerror and enters Service Failure Mode
(GERROR_SFM_ERR), the gerror handler calls arm_smmu_device_disable() in
hard-irq context. This becomes a problem as arm_smmu_device_disable()
inevitably calls arm_smmu_write_reg_sync() which might attempt to sleep
inside a hard-irq context.

Fix this by converting the arm_smmu_write_reg_sync to use the
readl_relaxed_poll_timeout_atomic() polling helper.

(Discovered while running Sashiko locally on another patch series).

Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: 48ec83bcbcf5 ("iommu/arm-smmu: Add initial driver support for ARM SMMUv3 devices")
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index a10affb483a4..f8f8193d0830 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4533,8 +4533,9 @@ static int arm_smmu_write_reg_sync(struct arm_smmu_device *smmu, u32 val,
 	u32 reg;
 
 	writel_relaxed(val, smmu->base + reg_off);
-	return readl_relaxed_poll_timeout(smmu->base + ack_off, reg, reg == val,
-					  1, ARM_SMMU_POLL_TIMEOUT_US);
+	return readl_relaxed_poll_timeout_atomic(smmu->base + ack_off, reg,
+						reg == val, 1,
+						ARM_SMMU_POLL_TIMEOUT_US);
 }
 
 /* GBPA is "special" */
-- 
2.55.0.487.gaf234c4eb3-goog

