Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DC73C942C
	for <iommu@lists.linux.dev>; Wed, 27 May 2026 22:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779920068; cv=none; b=ZxMcsV5NsI4u8EaMOOfr32RUxNs9V9ROaF6ZQRWawtY56ELEliUr3DSJdknZNQ457pPL6kRaeZHSu3IcpnrS1kBnEs2HLWhJdkxWSK26STEnM35YKDINXiudrrbQGpFgHeA6UFl5CoETPzPPDk72tIDMLjPsUKBkGGxaxU5b3NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779920068; c=relaxed/simple;
	bh=pEGxpvvAuGEkpQ0XqYwd0ie/hYW5lWWKz+XPEVa2B2w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K+Q5wjo9pLvx+8RZT7BpUnTw/LZzXyd737G8lDgpgBN1s36/DhBooWBjtb/YEbiBPBXpEXAfjvuEZWgZp/iof2TIyHqS+dggbRWkJXTU7DdZNJkp4BAmQzvzq49/IZ/4dZssYdEJHdWjThicWvK1XBlldlK0+Z49ISAo0/2B2NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mx787VqX; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mx787VqX"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c82c935e048so7481778a12.0
        for <iommu@lists.linux.dev>; Wed, 27 May 2026 15:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779920067; x=1780524867; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4i7eZYDXTe/LeahengnEklx9Y8dIPjrFEcOyyIxBlpQ=;
        b=Mx787VqXq5OVOHPVCYCPQTDUj8BC2cMtnN+fUPEr2oYhoAIO6hR7+EDY3OXlJ7Bwqo
         iVI/6Cq1FhrDGgK7eK9vRr5+cfxuBhoH24l73F2jbQ3UPS/SB1ck9sjqjzboiJ+pOogT
         wthNdsJHtZlZAptXi3f7m5oS7L5Gkou6nXK2Z+74qrW326Ru8Q/bQG6/SikxJhRBjJxG
         h+6P1BfQHOXiY1ySj7rTwNS+y56OJ5ma+5to6GEZR13sL8zOXZsilXYNAQA9lNXEGShU
         o4Qx1Keb6FZiPsao5WDFcfMs7CfOdwxD8tdBZVwj1NOD5kqAx/AfynHbB9ByC9bOPjmI
         iOww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779920067; x=1780524867;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4i7eZYDXTe/LeahengnEklx9Y8dIPjrFEcOyyIxBlpQ=;
        b=pE8Svdo8jAy0LTpNql2hE6lvXR1NZQimLB441xSR7qh0RqKrHW2BiFMyIP/OL2o0sp
         hAvu9Xoj4iMhbM1MbzarEz/kHCPBqCyAjcb3RKSHeNfq4wUTk9UA74aoj0Cq4Cwl5wSi
         aR2zLOxrnZNBzqU/RGReVIHlQHXWqVKfeeesr1GGTBmpTDm1K4ekHEwrBtowrLCXpxhK
         eg1qyNLM9+A70POoo5E4ewEmisKfkjQINalw9sQuBGqn3Qq2AN1ooqNnKkgpfxz8ovef
         I6Z5FKG4HhPo9twdyTFwTahGO7776reGTqvJHrXK0IZFm5yar9EzOaLEhALH49ahQXt3
         AIYg==
X-Gm-Message-State: AOJu0YzHHEQnKhugUsacgFTB+OMfuOf+OD7et3XhiAMGuqeiws6/UD1Y
	nOo63DZTXpyr1qfLVqu7aOmambWMMyBc1wSzYMv1rBDSYST/GduNvTLFi5u+9oc8Nam/ZxSGMgi
	gDl7V9pKPwj9SDtu9tyKscVxNwoP0W8XLJ1DM6ZxEyglebVOJMFsebYVquQmxthRDS4ix8003Ze
	2yy2tQxILNhveMmzWvKTdeKkosg0BB7g==
X-Received: from pfbmu16.prod.google.com ([2002:a05:6a00:6e90:b0:83f:24a9:a829])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a108:b0:3a2:ebfc:6bfc
 with SMTP id adf61e73a8af0-3b3296aed5bmr18621407637.17.1779920066375; Wed, 27
 May 2026 15:14:26 -0700 (PDT)
Date: Wed, 27 May 2026 22:14:02 +0000
In-Reply-To: <20260527221407.1756491-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260527221407.1756491-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260527221407.1756491-7-praan@google.com>
Subject: [PATCH v7 06/11] iommu/arm-smmu-v3: Handle gerror during suspend
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
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 93cee32f6c99..191b5b5b805c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2257,10 +2257,9 @@ static irqreturn_t arm_smmu_priq_thread(int irq, void *dev)
 
 static int arm_smmu_device_disable(struct arm_smmu_device *smmu);
 
-static irqreturn_t arm_smmu_gerror_handler(int irq, void *dev)
+static irqreturn_t arm_smmu_handle_gerror(struct arm_smmu_device *smmu)
 {
 	u32 gerror, gerrorn, active;
-	struct arm_smmu_device *smmu = dev;
 
 	gerror = readl_relaxed(smmu->base + ARM_SMMU_GERROR);
 	gerrorn = readl_relaxed(smmu->base + ARM_SMMU_GERRORN);
@@ -2300,9 +2299,17 @@ static irqreturn_t arm_smmu_gerror_handler(int irq, void *dev)
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
2.54.0.794.g4f17f83d09-goog

