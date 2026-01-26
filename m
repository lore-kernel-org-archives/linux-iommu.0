Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481B933B6E7
	for <iommu@lists.linux.dev>; Mon, 26 Jan 2026 15:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769440340; cv=none; b=FbUkHvSPkOMeGatrRtdgjvYHFz8JWI34Xh0/aJ4uHOYHTaSzlp+0s0vyPGlPDcpbNBMHheSKt0kxBV635n1ehcPgqO5BLzwuwS33qM8uNvKBPkk1arVOd3ezbeZ9L9t5GV6p9fZKS4FH1pP3zXUFHL7pIC05CfpKsj8Y5gjbXZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769440340; c=relaxed/simple;
	bh=14OyH9rwHPVHmmgdYB+h7sgMzxKAO69FB/7LFT/ABLo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YGRmCdR3rcjnOBz4sUGGp0AN5v2iLuCvSh7HnuOeSuaSiR4zgNyY+Sm1hIhtmTfo/B4/PpIbWv+P7VtEAxEalTiX1Q0OOky2XSA6zZQePi9dkXaEk7Fhgcdny7lsYOCA5wSvrlH9euqX8TBAPIfmf3FdJKGoDY91fBvH3Sq0TzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ffFCJqFY; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ffFCJqFY"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c551e6fe4b4so2835383a12.3
        for <iommu@lists.linux.dev>; Mon, 26 Jan 2026 07:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769440338; x=1770045138; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3weyg6Gl1cCC3xIKZhHroJkdckJtCf3wo/gkviyKnyQ=;
        b=ffFCJqFYlIJZHnSvgDbclRNUiw0eG9YgF2+mWEc8rx1ah6XdLi4Sp3vb6a6P/2BqLr
         Kd/+ACE0852zm5L153HakdN22OxxbE9sZoGSKfLJ1fNgIWpk4tONoFGVNdAlwsY+Q2n/
         T5euFUDcfJm82uQgJ6ue66woTiJdZoOSvQJ1y3Tjf60fLOneg9L+3zN6tL4/Ou0CbUPx
         p6hS51/ty2InXngybjIcVsLK1FYE0EWBp6QlplO5c/HATpkShIgxgH/277MQEvSAKe1n
         w6uZRtNDQiRy4QTUbSs5KV/6+z9KrZZxqFPvNosE6niy1lbpIiTRSxn5Eu1i9r35J8QQ
         +9tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769440338; x=1770045138;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3weyg6Gl1cCC3xIKZhHroJkdckJtCf3wo/gkviyKnyQ=;
        b=knAzkprHECLYwSAi3kd0jfdkb62ASXW5SZTDgNg0UyiNsh2n5tviym17vobUsIFZhu
         qugQe12HIPh80u0YpyeESJX0SER/ZCqMZaUJjVeM/GxX4Sv8Qkg/wb5pzLRqdeoby8ki
         ox1FnaKL0oPyPTN0bLBwPuO1COHXmeVXDi4QLdP6HijVvJ6hUGo6C3/jJ+rQQNqB3n/r
         zafHfUOcT8ITbgq2WFGcF8LqeXh8qe38YsTHwZfFpQbXUeAjnsdFY6S7Ow/eU8DcGUdU
         dWkXQMa5NEk+HdH5D/3E9EsspYDles51+gD05wX8+p/xYcOHY6LSfqa0GwimZQj3rKeT
         E1tg==
X-Gm-Message-State: AOJu0Yy4nh9cN3qoKj96xuoiYAqEuf+ibpVMQOzZjscg+5Po879pto8/
	YCia6blnFUmPYgiWiNP4tUAaGnWvhozE1dCSKw1kpy/srMk6Q2M88QJCVNgPXTq+0NxmqJRLm6P
	sr/EhKjV8xX93r7lc6meyP6tMPzn8tCDDCWB0FeI0jU+OcKND4rokWrqqP6y4iXyfN5QuA7M+Tt
	g+rWy1vqu+R7Zpt6OT1Y90H2pit5VRvA==
X-Received: from pjbqd5.prod.google.com ([2002:a17:90b:3cc5:b0:34e:5512:a3fc])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1dcd:b0:341:8b2b:43c
 with SMTP id 98e67ed59e1d1-353c416b930mr3846112a91.18.1769440338368; Mon, 26
 Jan 2026 07:12:18 -0800 (PST)
Date: Mon, 26 Jan 2026 15:11:55 +0000
In-Reply-To: <20260126151157.3418145-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260126151157.3418145-1-praan@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260126151157.3418145-9-praan@google.com>
Subject: [PATCH v5 08/10] iommu/arm-smmu-v3: Handle gerror during suspend
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	Ashish Mhetre <amhetre@nvidia.com>, Sairaj Kodilkar <sarunkod@amd.com>, 
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
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 19339ac9095b..22782025d0f0 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2202,10 +2202,9 @@ static irqreturn_t arm_smmu_priq_thread(int irq, void *dev)
 
 static int arm_smmu_device_disable(struct arm_smmu_device *smmu);
 
-static irqreturn_t arm_smmu_gerror_handler(int irq, void *dev)
+static irqreturn_t arm_smmu_handle_gerror(struct arm_smmu_device *smmu)
 {
 	u32 gerror, gerrorn, active;
-	struct arm_smmu_device *smmu = dev;
 
 	gerror = readl_relaxed(smmu->base + ARM_SMMU_GERROR);
 	gerrorn = readl_relaxed(smmu->base + ARM_SMMU_GERRORN);
@@ -2245,9 +2244,17 @@ static irqreturn_t arm_smmu_gerror_handler(int irq, void *dev)
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
@@ -5158,6 +5165,10 @@ static int __maybe_unused arm_smmu_runtime_suspend(struct device *dev)
 
 	/* Disable everything */
 	arm_smmu_device_disable(smmu);
+
+	/* Handle any pending gerrors before powering down */
+	arm_smmu_handle_gerror(smmu);
+
 	dev_dbg(dev, "Suspended smmu\n");
 
 	return 0;
-- 
2.52.0.457.g6b5491de43-goog

