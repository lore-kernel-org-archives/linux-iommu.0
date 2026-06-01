Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D6236A358
	for <iommu@lists.linux.dev>; Mon,  1 Jun 2026 21:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780351166; cv=none; b=AHmz12bdPMmEwHjnZ/WJH9lA/p+2yd3g2JgCOInkQwGZTu58rDpqaKKWJKSlIgXYLjYgDLP8A0iN2EYjitjgam6QF6V3jgCzMbM1GQpbah+bo1OTIPBuFy24L/Bk1F2AzmF5zISrEHNbWZk3Dqcl0FdRlzfN5PRrHjEgmI1XK28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780351166; c=relaxed/simple;
	bh=F+Z9ele8f0S9ST0Lg/gYed5EsCxr9DQpkqWEDwYCjws=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=i7ZqX3HAc8msOXb8E558d0txKqtOugygUZi18kuQSuSJyBSktDxJzDQksxTJiofvO0/nr93ruIbmS8U9mdl7KrGYlB5QWFy/JoTaq6ITRKMbKsKETTp42H3Hl+GruVyiuw7cneDIyj1WDcw2WibSfQb0k71gM2W/4gxz3SqehpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j9GLVGMS; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j9GLVGMS"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c850ff84ddfso14398173a12.2
        for <iommu@lists.linux.dev>; Mon, 01 Jun 2026 14:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780351165; x=1780955965; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TXEmkT3t0xuH0zfh1Vnq+1ZXPrn8uKJhrEd+Wqg5YrQ=;
        b=j9GLVGMSSgNpag6Pu6KNIhswOpC6o6aJkPhFKXDOxfDqQBTbzk632V2xkVyCkM8tPq
         Ytz1ZIxAK9fVbundSlkzpyjtUtfA8Spg38JfCcWQ3BQSrMcUL+NK+3zPh95rflwPWXdq
         HCDTSAu4zVgSrMv0937vch+GHW8jJN9WM6SVO4+diURLR/BJ11j2w1CrE6V7CZVdUbdL
         NE+tKHtl1HE9gZxNIaRBirRrwhcHj+FOB/wXnra0dXnS8STEx6v2gPnCOT+XItPxK1Ks
         FpAGtbpICg3L3e1K4zjRAaLpi7uL8R78yhc4Civypl7HtrGvF8a8r7JRJdyZgR0zmMHY
         bFvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780351165; x=1780955965;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TXEmkT3t0xuH0zfh1Vnq+1ZXPrn8uKJhrEd+Wqg5YrQ=;
        b=auOfRK2dabZybmMd+U79TWFDt7odcjFttYpDx92zEHzngrZBssqxTqQcWQQXcLslAV
         QER2tEoozSkioIhPvxR/w+i7Lgl+3qjka3Dt/YK/Ohoc68CQY8MYQU7w1YpuC+WDdMYW
         m7OuhGImHZJK/kjgvUNMSzk1vZfDnL4823PdNkHn5TSSYMtBUTYn7qWNnAsgAH/A2aTV
         k3pJQzvxeAC+TGqWVRh+/aMZCqkqkhwfzIPwIXNtBo2XlB0uXFf6Y/RIKwJt9HOKOY43
         fDnp1wRQXcMsGuP1wGNGZZPgn4o2wQjs+NbkzOkw9NoraR3R9B44nPolWNkVvPRrRukp
         7ucw==
X-Gm-Message-State: AOJu0YyXnUGihnTgaINdqi+J46CZ52swNHdhDt/5JP4U1dj1dNfJ9ssv
	/sbn7HsMZhqDPje2c2Rnrwg+hjOzamMl5e/6MtO9ezQ3ldWbqAhoMhiQPdaUvrH7yOHiDUQ09mU
	JxRpCiQsO9iHfpTR6k86xHlBZuai195Fq0IESSS71EbPD1jCjvXwl9KFx4Hq+/ovMrated9BnYh
	KCDAsUPYen5BuHXOWZRL3pblHfnKk0HQ==
X-Received: from pgbdr2.prod.google.com ([2002:a05:6a02:fc2:b0:c79:599a:d8e3])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:e58d:b0:3b3:be1b:733e
 with SMTP id adf61e73a8af0-3b4280a4e36mr13722143637.23.1780351164578; Mon, 01
 Jun 2026 14:59:24 -0700 (PDT)
Date: Mon,  1 Jun 2026 21:59:03 +0000
In-Reply-To: <20260601215909.3958732-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260601215909.3958732-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260601215909.3958732-7-praan@google.com>
Subject: [PATCH v8 06/12] iommu/arm-smmu-v3: Handle gerror during suspend
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	Ashish Mhetre <amhetre@nvidia.com>, linux-arm-kernel@lists.infradead.org, 
	Pranjal Shrivastava <praan@google.com>, Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

The GERROR register's state might be lost when the SMMU is powered down
during runtime suspend. Handle any pending errors before suspending.

Refactor the gerror handling logic into a helper function and invoke it
from the runtime suspend callback after disabling the SMMU. This ensures
that any late-breaking gerrors are logged and ack'ed before the hardware
state is lost.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 93cee32f6c99..6c8631e2f153 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2257,10 +2257,10 @@ static irqreturn_t arm_smmu_priq_thread(int irq, void *dev)
 
 static int arm_smmu_device_disable(struct arm_smmu_device *smmu);
 
-static irqreturn_t arm_smmu_gerror_handler(int irq, void *dev)
+/* Lockless; must ensure that there are no concurrent callers */
+static irqreturn_t arm_smmu_handle_gerror(struct arm_smmu_device *smmu)
 {
 	u32 gerror, gerrorn, active;
-	struct arm_smmu_device *smmu = dev;
 
 	gerror = readl_relaxed(smmu->base + ARM_SMMU_GERROR);
 	gerrorn = readl_relaxed(smmu->base + ARM_SMMU_GERRORN);
@@ -2300,9 +2300,17 @@ static irqreturn_t arm_smmu_gerror_handler(int irq, void *dev)
 		arm_smmu_cmdq_skip_err(smmu);
 
 	writel(gerror, smmu->base + ARM_SMMU_GERRORN);
+
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t arm_smmu_gerror_handler(int irq, void *dev)
+{
+	struct arm_smmu_device *smmu = dev;
+
+	return arm_smmu_handle_gerror(smmu);
+}
+
 static irqreturn_t arm_smmu_combined_irq_thread(int irq, void *dev)
 {
 	struct arm_smmu_device *smmu = dev;
-- 
2.54.0.1013.g208068f2d8-goog

