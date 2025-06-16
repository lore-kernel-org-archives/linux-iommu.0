Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6969BA42
	for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 20:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750105947; cv=none; b=jmRb8h6lt++xoe6UO7yJy5NzQVv/txK0/txYrXQ6ncZZ7uuIVLxL7toZotzCEhgbAf9mLDNpvav/0eZTkzgMqohWX56JlbWY5o9k9ytIGukEkcnCQ9UHhwrVmofMpUAyzrJEViF2n8mXLdutO5NzAuiHBRESNO7hzFvLInfmOYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750105947; c=relaxed/simple;
	bh=w8KHEbG1TZLgT1OfMG65vcXY0OfuJCje1MnIABH1Kng=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MNvUu3qeX5td6msbyfJBPDxhdoeq2sAAv4PD5FjlMrlrDesZMc2VnKACjgCKAvUx5HgRAVY8efoxJhuIu/nQlMtVw0PAXrzCKUynAChV5qDZUnHUMX9oYCRs70uDlHjaFWjRmG4wYaMQQiTL18E2bVa05lLO+MEpnj6LW5QuCUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wuj6Rsa+; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wuj6Rsa+"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-31202bbaafaso4511080a91.1
        for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 13:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750105945; x=1750710745; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=du4nMh6splsfYaUs3cCSjE8DXINrcEXTShL6ty2kr5M=;
        b=wuj6Rsa+ckNPMtIp0t9/HujBlP09CsCb/tXC6lOvLsXFZzyjAWZ8X2hpvmEOJXrGjf
         dCkCPiFDm8HUomlNEP1KRneG8JQVjLzXumfV/dySoCbFJZ3UaynrvcZEfRSyxyHHlNOb
         HCF3NQ+oD1KIP7Lb9rDWDMZk+cOJLebCsR/9k1A4uailNjV5cile5W6yhzeLo8yJz2H1
         nPC8KHnYxJ/QdyHDZZxqY+gTcTB9fvzN1uZQkF4g7hr5jXjtad6tc6urDM3LfgqRfXhk
         BWayb0frICH0ZqeEZIIyCjwYVZDpMZWhDoATb5nwkOurRnYbhXWBoIp9rjiGvzO+Ma7m
         NmfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750105945; x=1750710745;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=du4nMh6splsfYaUs3cCSjE8DXINrcEXTShL6ty2kr5M=;
        b=fR3ixZH6x/5eJqBo6aYvbXbdSH98Illhf7xC7dlVwY/xhFaBck7TaSe5uGI3MSjUOy
         5jJrtDaxe98jGortloV3kg45OkZCI9FKMVFmfibD5/8KoufX9X+cBhNd1HRnmkDYkVD9
         3SQX41fSltO0cx41IE1A/L/VqHeSLMxYdudXjt9wRS5kDrysXD/BvzBMTElK8J3l/kMh
         +cUieWAC9X1ERwIfWtgCjlRnQFzaB1i3whyMghDI62UmZKcrnTejdYM3ZYhSQLdQfErv
         /kZpUbEGSOkZ7SoH+KH/6htT+fJBlNbDebMdTgqDxL4KtXdvWc7FqXnf05ocgPzXVPFC
         v8tg==
X-Forwarded-Encrypted: i=1; AJvYcCU2kwxtZlewCExewP8hB2dGNqBeaVwRql6Bd5A0Fhl+r2eSeAzI2mbk9nh7aneiklu/H9aSbQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwvKu3ZRdrQ5j35vFAOa+jNFJqsZ27cxDjpTSWtAGrbhTGwyN7P
	UHtKz/4PKmcaXGMCTf3LM4qL+2vbYOV11U8l/JDU63uIo819u0WWlRPHyDlwp6RGiod8KWSkG7F
	Jew==
X-Google-Smtp-Source: AGHT+IHdvG+lpiFHH+koqoRpsxHWxholOdaI95jYy+Dd3hlvcxFUsXsx6MYNxF60BhqUDxQIz0xUZaQDRg==
X-Received: from pjbip12.prod.google.com ([2002:a17:90b:314c:b0:314:626:7b97])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1d81:b0:313:352f:6620
 with SMTP id 98e67ed59e1d1-313f1be63ebmr15136453a91.4.1750105945121; Mon, 16
 Jun 2025 13:32:25 -0700 (PDT)
Date: Mon, 16 Jun 2025 20:31:43 +0000
In-Reply-To: <20250616203149.2649118-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250616203149.2649118-1-praan@google.com>
X-Mailer: git-send-email 2.50.0.rc2.692.g299adb8693-goog
Message-ID: <20250616203149.2649118-3-praan@google.com>
Subject: [RFC PATCH v3 2/8] iommu/arm-smmu-v3: Add a helper to drain cmd queues
From: Pranjal Shrivastava <praan@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Mostafa Saleh <smostafa@google.com>, 
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Before we suspend SMMU, we want to ensure that all commands have been
flushed by all the queues i.e. the queues are empty. Add a helper
function that polls till the queues are dained.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 40 +++++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  3 ++
 2 files changed, 43 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index f19a77708d2c..0df1b17a09cc 100644
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
index dd1ad56ce863..461f1958e574 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -965,6 +965,9 @@ int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
 int arm_smmu_cmdq_init(struct arm_smmu_device *smmu,
 		       struct arm_smmu_cmdq *cmdq);
 
+int arm_smmu_queue_poll_until_empty(struct arm_smmu_device *smmu,
+				    struct arm_smmu_queue *q);
+
 static inline bool arm_smmu_master_canwbs(struct arm_smmu_master *master)
 {
 	return dev_iommu_fwspec_get(master->dev)->flags &
-- 
2.50.0.rc2.692.g299adb8693-goog

