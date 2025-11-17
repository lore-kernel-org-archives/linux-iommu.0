Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A90313287
	for <iommu@lists.linux.dev>; Mon, 17 Nov 2025 19:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763406902; cv=none; b=sd4pJWMmPL2wK3NAV+2LCw1pdP2Y17cp+DQ3pnAOd8G9x/sFs6BGq/StRHGsRNNmZPOQmbF6WFo0XzAnoGpJ4SswXD1E8NzGHaM9Sh0YCClyUw9cf468KOwFjpGEAtbX++upiT1xSFVignCdh5vBPzoUIXT5jK2jDhUz4WpyVtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763406902; c=relaxed/simple;
	bh=em0BG7e+W1t0EXaKoxaSvNjZz+2dl0lZ4MIFIwMzwPE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o6wwGz3IXzub9dryKBp9Xixf02opoyWO0EZDphtECgCsz529QGTSn0l1I0a0LPm7amv3ZPgVPkqz+ZKij4XizviPX27CAILSFdsiC14n8A/IpiZqHxqTrZEm19bg6/3XZwZt8lrZdnza757tLPK9MjLYtA3+rzM+HCKlBNCYhbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=axMDSf9e; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="axMDSf9e"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-34188ba5990so14405426a91.0
        for <iommu@lists.linux.dev>; Mon, 17 Nov 2025 11:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763406900; x=1764011700; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oD/lqiEb/YuTnx4+VMIYuu4sYNORLotHbiSMrochMhM=;
        b=axMDSf9eMVgw34sAv2HCu3o6W52dDEEAn+WslUyU2gfETJIO4sJg4f0SVKVMbT3mRd
         ymTZG9FOtAl5bK9w3IZh36mLAp7fkoHNqtkJ/UNDHPwHZz++5k0pdqjjjvTORylbDMbx
         9CETL8L7WC8PmJp/uVFmzO33EjbNOGVsO8IW4aBLc+3OeUzc2SviqjdTM2k9kYhn3NXo
         45hGO22NLWZ/kg1tHpwNqKHyHY2SCfxRZFYDOAh1BZ5UUrdmUIRibIOgFueJJRaGqv3A
         GKmXtnHEnRPW8c3f9EYXY/sSuygiy4ZVSD09gpe0Ef0+ppphdGQlQynCC9DBGfMMEDa+
         PqdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763406900; x=1764011700;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oD/lqiEb/YuTnx4+VMIYuu4sYNORLotHbiSMrochMhM=;
        b=K9i6FLnDuKjfefhtpUeiTXdyHJ3ubBJ2ZKewAEv7z71L7bJgrFanFfOQVTJgs/Tcag
         vOHqacQDStO7sU6z8xZEtsv/i7MYV7xa+3rxgoKHDedoeq3/Eu0Y7xIoOG810oJX03SP
         ZhXSDwvdRfiUcsu+PB8kN7O1Dbc4/CvcOuIx6wBINI3orv2zL7BxHrkdVshFY/xHGJk4
         oZ2Y/gbHEFGPuEmsl0c00PyfmMHw3YTjvwYr3lM1KDFN89nxuZd/enHT9K/ULuk7lKx3
         tMgMmXTB+WzW7JIZTtiC41AlAG+JddSCf2x+eDCw0rYoVJqKOzKwVpEPIKUFmFMQ+M7/
         Omew==
X-Gm-Message-State: AOJu0Yzn2Id8VwRBhN7/sNIhQgfe0aTAfE2+19pehV+XwmAXdyiSdt6H
	XzLrzQ+lOJoh0DkMDnUb5a/srX2jquBxD1WgOuuOX23ctdhYOhjaVegddV7qrdzSA8RfrXty20G
	habdjhA72xQWUMdmb883C3oHIAMJYIiMvZopoD4KRDKsd8UXDCh4jRPi37eXwN+b1758AqCTAtS
	zZ4ralznftTZWZEbHiamUgyy0vrTNLrA==
X-Google-Smtp-Source: AGHT+IE8MbVMScoN4k46xBq4t+gr66V67BQFj5ybzVMQo59gMwmpsG3ndn9qdExxJGQBguEsi5ikEEqI9A==
X-Received: from pjbjs21.prod.google.com ([2002:a17:90b:1495:b0:33b:dbe2:7682])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5243:b0:330:6f13:53fc
 with SMTP id 98e67ed59e1d1-343fa732c1bmr14272992a91.27.1763406900430; Mon, 17
 Nov 2025 11:15:00 -0800 (PST)
Date: Mon, 17 Nov 2025 19:14:27 +0000
In-Reply-To: <20251117191433.3360130-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20251117191433.3360130-1-praan@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251117191433.3360130-3-praan@google.com>
Subject: [PATCH v4 2/8] iommu/arm-smmu-v3: Add a helper to drain cmd queues
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Before we suspend SMMU, we want to ensure that all commands (especially
ATC_INV) have been flushed by the CMDQ, i.e. the CMDQs are empty.
Add a helper function that polls till the queues are dained.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 40 +++++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  3 ++
 2 files changed, 43 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index c5efd9713775..c50cd975920e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -981,6 +981,46 @@ static int arm_smmu_cmdq_batch_submit(struct arm_smmu_device *smmu,
 					   cmds->num, true);
 }
 
+int arm_smmu_queue_poll_until_empty(struct arm_smmu_device *smmu,
+				    struct arm_smmu_queue *q)
+{
+	struct arm_smmu_queue_poll qp;
+	struct arm_smmu_ll_queue *llq = &q->llq;
+	int ret = 0;
+
+	queue_poll_init(smmu, &qp);
+	do {
+		if (queue_empty(llq))
+			break;
+
+		ret = queue_poll(&qp);
+		WRITE_ONCE(llq->cons, readl_relaxed(q->cons_reg));
+
+	} while (!ret);
+
+	return ret;
+}
+
+static int arm_smmu_drain_queues(struct arm_smmu_device *smmu)
+{
+	struct arm_smmu_cmdq *cmdq = &smmu->cmdq;
+	unsigned long flags;
+	int ret;
+
+	/*
+	 * Since this is only called from the suspend callback, we
+	 * should be able to acquire the exclusive lock without failing.
+	 */
+	arm_smmu_cmdq_exclusive_trylock_irqsave(cmdq, flags);
+	ret = arm_smmu_queue_poll_until_empty(smmu, &smmu->cmdq.q);
+	arm_smmu_cmdq_exclusive_unlock_irqrestore(cmdq, flags);
+
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static void arm_smmu_page_response(struct device *dev, struct iopf_fault *unused,
 				   struct iommu_page_response *resp)
 {
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index ae23aacc3840..b52ea821361e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -983,6 +983,9 @@ int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
 int arm_smmu_cmdq_init(struct arm_smmu_device *smmu,
 		       struct arm_smmu_cmdq *cmdq);
 
+int arm_smmu_queue_poll_until_empty(struct arm_smmu_device *smmu,
+				    struct arm_smmu_queue *q);
+
 static inline bool arm_smmu_master_canwbs(struct arm_smmu_master *master)
 {
 	return dev_iommu_fwspec_get(master->dev)->flags &
-- 
2.52.0.rc1.455.g30608eb744-goog

