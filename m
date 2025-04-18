Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DF220C037
	for <iommu@lists.linux.dev>; Fri, 18 Apr 2025 23:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745019287; cv=none; b=hAvCrpL7uMNehO1nYeA+HUaQP7qlCpTwILtClni+RyEhoEurFfMck+w1OmzzKaxvs2vW4Y/+Gev8WAeIFz6kj+7NYCzrrFbDslvk5c1BZtuFUKp2U3Uzx8wJm7WvqEAI5P6a6WgSv0NQ3DO7V6F7syYT6NDYiU77E4WOcde3aEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745019287; c=relaxed/simple;
	bh=/cI9btJ2pRDW8/D1r6BSBLsrwInwzibSY/OebXflqb4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VP/XXWYSPLHADbxMvn+QS1ZVCdkb00zdbncs/yfbf3Yyd6yrftvctdEKdpbmiLII6WtGOuinvfiUCPebeN6GDrJc8d39ElKpCIEmF+Xt1E2BWKoilr0O2ViostCqGGv7BRE0BRoS8q20VJIXTnVkg84N7LzWyyujpIeBtyUoimY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gDV3ZZy1; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gDV3ZZy1"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2240a96112fso33926345ad.2
        for <iommu@lists.linux.dev>; Fri, 18 Apr 2025 16:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745019285; x=1745624085; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4JtSmDqLmLLHrVu8p4JnCTOegs5nwno8Ew2iHtbfmIs=;
        b=gDV3ZZy199fjPQAUbpb4XN6YHc+sr5pCIcYGLZ4HyD4QQQpNqfU/2fk86XWI618Vfn
         eBzf8YE0bHSxXA5j9gwHL+LWZNXw7nhR5OImbWF7yivaDY3XVTHZDjahUfAP8SKS0fKw
         eqHo8pvNZL0ntden8dTNFPL56t95mkJbrHwBZfZpI3chJbaPSJG3y0wq8yzc/wkA3XCj
         FJDRjP+E1eijML4ulzQesfJdsixs4nysTJpG27XSvObLiAd2udJsCT61V5CNQz8XxQOG
         MQqfJZgqb0uD0fsLQ8vdEFAdKmygSHHYT4ALDlFvzR5gZ3A4NKrQtGd9Bd1dI78F2bRy
         x64g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745019285; x=1745624085;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4JtSmDqLmLLHrVu8p4JnCTOegs5nwno8Ew2iHtbfmIs=;
        b=mV8cqP7oaJsDBUqdFYaU5vVt0r8jT1t8zqprf4//CfWrsgjzzba2wnCNJpWZygMhOi
         4OHBMQuYhZtb3lpoEYJ51y48XivAd7zfaAHUIycfBvFQRhluRNy/N7WGFGn/pS5wr/es
         k/lzUMwVFTglLyVzO1fZjID7w839qaYv7IPlkxb/JQQxof6G8WiT3GWU2c+r7Bn9mVkK
         poc4XkgnVcZQmqhZhXFG5r+kkl+B+WANbPS/+mxyds3Et7tzSyQhLNdG8xP/D5S5ukgS
         Ku0IzkT4rZBmAPq7H1zq8A8xuKHwUwx1ZpgnvcdZPG4522v0PFMnAt8xR+rJBUnMBibP
         ZY9A==
X-Forwarded-Encrypted: i=1; AJvYcCUE80JIzNZlKISER6e68l9c9PM0Hep2B5j+zpYyfvoe8/jJKQC4Sy462zJnT1/tnBLkt66kgw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwT/DItY8L/IKmWVWfak9vqdAQV+oBHdMqd/I1lqemtvOwS3kgS
	ccaDIX+0b5QoIj/UrmJbuLpGGA1LvYQtfVWmx3R5kOr2MhtJfbjLEtzNylZ4G6xXYRttRXaAXg=
	=
X-Google-Smtp-Source: AGHT+IERpRgVFdOEBK4LVqHHIZX4V9VLKyexaS8xynLxmA5Igkx9Iyn6gx6xCN0cUNauMTZv+ozjwse4iw==
X-Received: from plbli3.prod.google.com ([2002:a17:903:2943:b0:21f:56e1:c515])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2f85:b0:227:e6fe:2908
 with SMTP id d9443c01a7336-22c5361b633mr59606185ad.48.1745019285219; Fri, 18
 Apr 2025 16:34:45 -0700 (PDT)
Date: Fri, 18 Apr 2025 23:34:01 +0000
In-Reply-To: <20250418233409.3926715-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250418233409.3926715-1-praan@google.com>
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250418233409.3926715-3-praan@google.com>
Subject: [RFC PATCH v2 02/10] iommu/arm-smmu-v3: Add a helper to drain all queues
From: Pranjal Shrivastava <praan@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Mostafa Saleh <smostafa@google.com>, 
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Before we suspend SMMU, we want to ensure that all commands, events and
paging requests have been flushed by all the queues i.e. the queues are
empty. Add a helper function that waits till the queues are dained.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 46 +++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index c295837b20a1..58bfcfb0d04c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -981,6 +981,52 @@ static int arm_smmu_cmdq_batch_submit(struct arm_smmu_device *smmu,
 					   cmds->num, true);
 }
 
+static int arm_smmu_queue_poll_until_empty(struct arm_smmu_device *smmu,
+					   struct arm_smmu_queue *q)
+{
+	struct arm_smmu_queue_poll qp;
+	struct arm_smmu_ll_queue *llq = &q->llq;
+	int ret = 0;
+
+	queue_poll_init(smmu, &qp);
+	llq->val = READ_ONCE(q->llq.val);
+	do {
+		if (queue_empty(llq))
+			break;
+
+		ret = queue_poll(&qp);
+		llq->cons = readl(q->cons_reg);
+	} while (!ret);
+
+	return ret;
+}
+
+static int arm_smmu_drain_queues(struct arm_smmu_device *smmu)
+{
+	int ret;
+
+	/* cmdq */
+	arm_smmu_cmdq_shared_lock(&smmu->cmdq);
+	ret = arm_smmu_queue_poll_until_empty(smmu, &smmu->cmdq.q);
+	arm_smmu_cmdq_shared_unlock(&smmu->cmdq);
+	if (ret)
+		return ret;
+
+	/* evtq */
+	ret = arm_smmu_queue_poll_until_empty(smmu, &smmu->evtq.q);
+	if (ret)
+		return ret;
+
+	/* priq */
+	if ((smmu->features & ARM_SMMU_FEAT_PRI)) {
+		ret = arm_smmu_queue_poll_until_empty(smmu, &smmu->priq.q);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static void arm_smmu_page_response(struct device *dev, struct iopf_fault *unused,
 				   struct iommu_page_response *resp)
 {
-- 
2.49.0.805.g082f7c87e0-goog

