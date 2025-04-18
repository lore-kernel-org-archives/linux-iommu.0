Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D57920C037
	for <iommu@lists.linux.dev>; Fri, 18 Apr 2025 23:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745019322; cv=none; b=PFK4xtnn3K6f3B2m9O/JN4LUTPBqM8cuicCSycjPhEcSpKkO/SRUDI+JrHT97sMXxAiNzgWtDZy+a3PmFggVG3ncX3upVSHi2OvRxpoKJ/bMlacmmyEH1EBwslaRiKZ8fAsxuCUjwG2fGPA7zDN5lV6mWzNw0qh8rMZTZ856oxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745019322; c=relaxed/simple;
	bh=9it2/k5C63JPnpxsGJqYtWUDC8Xje0kj/zvfZGiQwOg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j5adsHWGWoAyMEDsFoTAPwMx9vLAf1gVh8nE80oiRDKg0h55Tha0KQefLsP9cgmehw/CHEgX0RUGBKs5zFY2eMQGnSrsVwda+q7IH0TW4s8EcffCFC/tg1Ei21/IsLCBhvlWNYEvaRITfRztbNkhEHa4h7TewqFcqoUSsje8wB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eE/lL6md; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eE/lL6md"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-af5a8c67707so1429642a12.1
        for <iommu@lists.linux.dev>; Fri, 18 Apr 2025 16:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745019320; x=1745624120; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3usH/V24i8Ii9NjlaiYWG0zfm2QsGt4m6/0Zg3ZU+FA=;
        b=eE/lL6md/Ie67oRb/clww4d6N7hTRof0Fo/TSuSrfcIkwzOI3rSG4Bp4+VtxWzlZdi
         owpgu4H8MhfU7+1+mTRd47XWXkJwvdtGJCUFwpi+9OHw7gmeGF6Cz1EBduhuwMnKbY4v
         Nen6K6ejK0L5mjfCZl11F/8bpDvk4P3V//X61724rQawhnMTyXlfqgqB8FS3z0+fE0v2
         R6FOpl9Z7Ci1lATHYOrb3xglSF6leSh2uWg5fIuWTp5+NhsdlUGihvELYQaGnjpzg/td
         LGX/H7V1Mrec+VKCQhorvh9e2w51QbikHduvHGo1pHfgIO1NR1iUma9Ix96jRrFDzqGr
         q9eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745019320; x=1745624120;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3usH/V24i8Ii9NjlaiYWG0zfm2QsGt4m6/0Zg3ZU+FA=;
        b=lKbAknKEJzPYVNjDgFMDK1qAPKsmFyup78nL59XuLp9m9k8VrIuW8zAG0gO6MYTpun
         pZt/hByEJ+azUw9kZA3lpk3u4hbiv7opB+qKkZaGPH2FGgb+rdPfGNPt/U7wPxxnV8mv
         jYr12E6NGbdR1EhZC5ZqxtNBLnBR9V53+yvVkju8Lz1T7755QP6fpMcYjLdfjsVp7Qpf
         lvJRU10yZhpXWYQlX6PL8nPKLRrVRHP9itKxSIWz7qdb58B8Dh/7i9RtRbRqpUnQsRGC
         uevLNwQ/n6FWmcVr0dkQac93AsFB+VQp0AOeyWA7huM64F19Q01rdJGQYoOTVdReHG7a
         CUhg==
X-Forwarded-Encrypted: i=1; AJvYcCWQ3f4qRYwPDepo3hbgjTZRs74OWHbHOTDSb9TiQuhUW4K/VTvXTxCeLVZzcx+gSEodog1/Cg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwcENt27RCHumvjVd4GV965vd6C6ADLevbXr7hoRcEnXfs8pgfy
	IIm2DuDEq1CL+uwP8MxQeieYUZWwX2EMCwVnMxj4yDWcqWb35TC8SUoitN/elMwfmmW4dXNfQA=
	=
X-Google-Smtp-Source: AGHT+IHpEWw9+4nvHduMdRl6+r4GEuzNSY3qCPF8Sr70WCmYuVBLPBfSxloHuM5a/evuz4dkRlqVH33xHg==
X-Received: from pgnp11.prod.google.com ([2002:a63:7f4b:0:b0:af8:cf0d:14cd])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:c68e:b0:1f5:7d57:8322
 with SMTP id adf61e73a8af0-203cbd21244mr5861306637.26.1745019320417; Fri, 18
 Apr 2025 16:35:20 -0700 (PDT)
Date: Fri, 18 Apr 2025 23:34:07 +0000
In-Reply-To: <20250418233409.3926715-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250418233409.3926715-1-praan@google.com>
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250418233409.3926715-9-praan@google.com>
Subject: [RFC PATCH v2 08/10] iommu/arm-smmu-v3: Avoid suspend when user owns DMA
From: Pranjal Shrivastava <praan@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Mostafa Saleh <smostafa@google.com>, 
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Suspending the smmu is unsafe if any attached devices belong
to iommu groups claimed by user-space (via VFIO etc.), as a DMA may
be ongoing or initiated at any time. The smmu must remain powered ON to
handle potential DMA requests originating from the user-space context.

Introduce a helper `arm_smmu_suspend_is_safe()` using the previously
added `insecure_attachments` list. If the check fails (list is not empty),
defer the suspend ensuring the SMMU remains active while it's potentially
needed by user-space for DMA.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 18 ++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  2 +-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 2b51665d5ca6..7099c0cbf5fe 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -5040,11 +5040,29 @@ static void arm_smmu_device_shutdown(struct platform_device *pdev)
 	arm_smmu_device_disable(smmu);
 }
 
+static bool arm_smmu_suspend_is_safe(struct arm_smmu_device *smmu)
+{
+	unsigned long flags;
+	bool is_empty;
+
+	spin_lock_irqsave(&smmu->attach_lock, flags);
+	is_empty = list_empty(&smmu->insecure_attachments);
+	spin_unlock_irqrestore(&smmu->attach_lock, flags);
+
+	return is_empty;
+}
+
 static int __maybe_unused arm_smmu_runtime_suspend(struct device *dev)
 {
 	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
 	int ret;
 
+	/* Refuse to suspend if user-space controls DMA */
+	if (!arm_smmu_suspend_is_safe(smmu)) {
+		dev_err(smmu->dev, "Suspend deferred due to unsafe DMA owners\n");
+		return -EAGAIN;
+	}
+
 	/*
 	 * Since suspend is invoked when all clients have been suspended,
 	 * we don't expect more cmds or events to be added to the queues.
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 5ab60ae7ff91..28fddc07ab49 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -796,7 +796,7 @@ struct arm_smmu_device {
 	struct rb_root			streams;
 	struct mutex			streams_mutex;
 
-	/* Insecure Attach handles */
+	/* Insecure attach handles */
 	struct list_head		insecure_attachments;
 	/* Lock for the list */
 	spinlock_t			attach_lock;
-- 
2.49.0.805.g082f7c87e0-goog

