Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F2E349CDE
	for <iommu@lists.linux.dev>; Mon,  1 Jun 2026 21:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780351158; cv=none; b=a12MIeoIDY0E1ZHo97GNOzC6tixx3qGjAPihEoCVTiT1PaH+DLe2jLXjzOhYK/Wb9xiNP9ZyUzPo8Bl+Q8iOlYbNs/8JpkLfaEE9lxwyU3vIHu/NedNUzcuoRhB5osEoWy75FwQ35Gvu9S5iTGhOJpAR+cJ/uo+twHju/JHK3aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780351158; c=relaxed/simple;
	bh=g9e0sDMVO0k5kOIkn8abVHSS+bqNU7BswulrEbpxnK8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Uoe1J7WA6c7amOQIxUwhAyP56ftzEHweVd5CbL5OSyZBma+upp17kH8aBhUPUvRbxE2ccWmGFf1qZUpGMaSdrFM5vkj2Ock7jn7eR6caO1UthVuY6dCRC9F1vkm7viMRC7vhRUgtUifuam9MNZcWHQfQ0o5D/nzrBp9BPVB0zuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jkIxCx7E; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jkIxCx7E"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c85a2bf5388so966269a12.1
        for <iommu@lists.linux.dev>; Mon, 01 Jun 2026 14:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780351157; x=1780955957; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ONuLftC1PjDeNO3J1MQAL3fybeR67R0JRra2ClbgQzQ=;
        b=jkIxCx7E4xPTWR7W8HvWCsp8/no6jGDtaqcDP/V1N1J8Gk1+c9xCoIoBm0hG5BH5iu
         jb1S6qkZnPjqVZxf1u067BKYzcGysI5yqtiOFe5PjQK8FSm2i6RlUWw/dc1t1kqhWbUb
         1MFfZf7pqfGZOpfb1a6MDY12FZkkr5JytDNu9qy97QZtzxvg9IT/LPF8Bc+oL1DjUzF1
         wFJjop8MXGdwg3rn02dJHRiFZDQeikMQx2ZIrjR8f7zYgA6Fex4HC7jiCMp5sf1zjlvv
         9Ll2TGpYEJ9MZnBcknZlBiTmxEO9mbfcvFo0/QGE06Oi2A4a03zD4QFoBOaatCrbwLs5
         rZTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780351157; x=1780955957;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ONuLftC1PjDeNO3J1MQAL3fybeR67R0JRra2ClbgQzQ=;
        b=hqrHHXwv/eyvIFuaqSdufElR9MKLzk2QgwOQYvGBqd/Zblw9iNkOwK9nnhGbzvdZYt
         u/U1RZU/8fsOz7Eqswr4ZAG+4c8/nVtHFFhg4Fye0PRLq0n9IGW5g7TLjgCz6fx0cUHH
         Ct0RBM3xwTo1p2CjZav6bdYsTbqegyzdwqznYUATVrbj5vVSxUNBb75FF8VSnNQpsIS1
         swOgu9HZJY12zifJ/rFEXy2e33Kb0Pma/BgUUVrPp5CXBQn5LTsSBXuf+qvn6ego9u7G
         rd6hZYRK68PSjE1XO1V8KX1F0P2SXVhikEjD8QFElT8RFWApE/4lYHrhM4M8x/+BpMYW
         YyBQ==
X-Gm-Message-State: AOJu0Yz1N6O6qTFY0qqKtq7OYbutDG/Nw7gXg3b4caETO+G78iNVqKfw
	qfoUIyYbfsPV+krYzJ43dsKn/VtmgQynpjHsUcCdnSOQOTmXsB2LSW64LfMIMzjmLuKBw/gwo4s
	7bOdqs2am12K58u70k2KL2Gh6UUnsy7xAF3p2HPovwRNb5/7rDgmuUPUJp4bYAYQDjDG8T+gavU
	5r46n29lf28iSHznXCz5SKfzzsh3dY2w==
X-Received: from pfbgj13.prod.google.com ([2002:a05:6a00:840d:b0:842:b0e:cf17])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:288b:b0:83e:ccd6:2dc8
 with SMTP id d2e1a72fcca58-842255cf64fmr11905631b3a.27.1780351156167; Mon, 01
 Jun 2026 14:59:16 -0700 (PDT)
Date: Mon,  1 Jun 2026 21:58:59 +0000
In-Reply-To: <20260601215909.3958732-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260601215909.3958732-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260601215909.3958732-3-praan@google.com>
Subject: [PATCH v8 02/12] iommu/arm-smmu-v3: Add a helper to drain cmd queues
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	Ashish Mhetre <amhetre@nvidia.com>, linux-arm-kernel@lists.infradead.org, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Before we suspend SMMU, we want to ensure that all commands (especially
ATC_INV) have been flushed by the CMDQ, i.e. the CMDQs are empty.
Add a helper function that polls till the queues are dained.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 34 +++++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  3 ++
 2 files changed, 37 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 3dad2c2d3283..0e77ef1e4523 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -884,6 +884,40 @@ static int arm_smmu_cmdq_batch_submit(struct arm_smmu_device *smmu,
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
+	int ret;
+
+	/*
+	 * Since this is only called from the suspend callback where
+	 * exclusive access is ensured as CMDQ_PROD_STOP_FLAG blocks new
+	 * command submissions to the cmdq, we can skip the cmdq locking.
+	 */
+	ret = arm_smmu_queue_poll_until_empty(smmu, &smmu->cmdq.q);
+
+	return ret;
+}
+
 static void arm_smmu_page_response(struct device *dev, struct iopf_fault *unused,
 				   struct iommu_page_response *resp)
 {
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 16353596e08a..c855ab4962ed 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1165,6 +1165,9 @@ int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
 int arm_smmu_cmdq_init(struct arm_smmu_device *smmu,
 		       struct arm_smmu_cmdq *cmdq);
 
+int arm_smmu_queue_poll_until_empty(struct arm_smmu_device *smmu,
+				    struct arm_smmu_queue *q);
+
 static inline bool arm_smmu_master_canwbs(struct arm_smmu_master *master)
 {
 	return dev_iommu_fwspec_get(master->dev)->flags &
-- 
2.54.0.1013.g208068f2d8-goog

