Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB79D20C037
	for <iommu@lists.linux.dev>; Fri, 18 Apr 2025 23:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745019313; cv=none; b=u0xPLZSB5psDSlGZ/mRx3FJblwmDFHBr8EQ3/G//Lir5PqYGPWstL5fuPu/dMIkIHrA64v2oVpcBpDrdJEaYcvkSmU1U0K7kYKvGh9WiqXj6svdIIVaW0NLQqcvvQHccfsk1Yb+zerZkbeTOwNV/CY+5kPJdFA2G9kJszG7EfkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745019313; c=relaxed/simple;
	bh=QBLiGJ7bEscurzIXSMIeDG90SrdxHviHvQU7a4qW3pQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MUu7iGOIZ8hRMbhKv7eIAQYFEFYS0jOclJaSakhzdMmRyOV5yg6QH5Nw4WIGIFpEtlIse1ooOHwdq0eO6I0xWGfK9+BDGLvpQzcWU2ZYVsognRwuoofeAqrV+gJuURundzxedU9Pg0KioQu/EJdbPAJxKmSpEcw3S54e1i2ihxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JY1yZx9K; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JY1yZx9K"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7395d07a3dcso1686508b3a.3
        for <iommu@lists.linux.dev>; Fri, 18 Apr 2025 16:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745019310; x=1745624110; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yAY2OGABEqpCk6fdijUnO4aQ71axxRCBESBytLsg8MM=;
        b=JY1yZx9K+ccYsu88QSXrGgiPbnJ1HiPOceQ+znbQP+Aj2iatahxjUcKye4iAcm1OAY
         62QNJ0OHL77n6ZjJm18mrnVrv5xd9myOF8dF5GeR1/yI5xJ7KxGlg3MlvOsOX4QeXUSr
         XoPtaRVQedT7y8RE6cpjxETe9oq5B46A+7IQqUXke6SDDeEqsdZ9KvfL8sNIL+XJou7j
         DisAnh0tXdYT3LtdNr63ARFEKxxTDlC1HXFz8U1/KWcswaJNIm8Gk+FHRjHeqmf4tDNv
         8iEYYRdDZbizb+hL5BeO9FxPVvBikWZ4RN9pZGTeiXw4wW7/wHy/W807kmhhz+sciDRY
         iNBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745019310; x=1745624110;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yAY2OGABEqpCk6fdijUnO4aQ71axxRCBESBytLsg8MM=;
        b=NaE3bYy2UGe074wsepGR7DI2AZePiJaNXwFzcAPqiHbjwjn6gVL7D+dyPejGRzcwCG
         Zr8Ty8nUXME59vsHhXXtOeC/YbHVl/rjeA9BFvFEp3q15TRjxB1KaO3SJzkTrNHHTs3X
         Wg75yCyLjbcpQJLq0O0W1dlYC3IZQr63OlJHBMzPK1cu/zM1dtPrhxRf018nDoM5URR3
         zwsgpU9Yq2KGX2K1sYy7dPPK4V7vr+el/6tMdLKHZO/DPgqDpNAhfyKcVmKNtng2QsNh
         ZeCA+DWNH4ao5jEC00iDFc4itEZtgNYO42CIbkjl2mBpimXMm5VzRnGt1Fy338z96APp
         q37w==
X-Forwarded-Encrypted: i=1; AJvYcCX1hPPcPcwb24/RrocpRNGUIgDcIqarsiRZyJU89WnXFdYgMYgbtJgvKRISHzrz7F+XtTd3hw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxbGPq1c12EXxTJkL1X28HQiEfAGxwDP9esIbzmQW4vVVBD0Qq0
	s8CwP+H7YBKrsq0Ghw3KGIRwGCS7tbhtLu5kFUc5A+e0CN7oM89gSdHEFCpzdds8lKz7GEHBGg=
	=
X-Google-Smtp-Source: AGHT+IGtzra6NRObJD7KB/m4LCTSQm3vS39m2Axs+BMfLavzn7XRCNVxph82KtppiXogDaRFAmF4bDYVIA==
X-Received: from pfbfa9.prod.google.com ([2002:a05:6a00:2d09:b0:739:9e9:feea])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:aca:b0:736:a7e3:d4ab
 with SMTP id d2e1a72fcca58-73dc141116cmr4979260b3a.5.1745019309949; Fri, 18
 Apr 2025 16:35:09 -0700 (PDT)
Date: Fri, 18 Apr 2025 23:34:05 +0000
In-Reply-To: <20250418233409.3926715-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250418233409.3926715-1-praan@google.com>
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250418233409.3926715-7-praan@google.com>
Subject: [RFC PATCH v2 06/10] iommu: Add a helper to check for user ownership
From: Pranjal Shrivastava <praan@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Mostafa Saleh <smostafa@google.com>, 
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

The existing function iommu_group_dma_owner_claimed() checks if DMA
ownership for a group has been claimed, but it cannot distinguish
between kernel clients and user-space clients like VFIO. This is because
its underlying mechanism (based on group->owner_cnt) can reflect claims
from both user-space (e.g. iommu_group_claim_dma_owner()) and kernel
clients like iommu_device_use_default_domain() during really_probe.

Introduce a new helper iommu_group_dma_owner_user() which allows the
callers to specifically determine if a iommu_group is owned by the
user-space.

The function checks the group->owner field which is exclusively managed
by the iommu_group_claim_dma_owner() OR iommu_device_claim_dma_owner(),
instead of relying on the iommu_group->owner_cnt. Both the
*_claim_dma_owner APIs are ONLY called by vfio and iommufd, indicating
user-space's DMA ownership for the said iommu_group.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/iommu.c | 19 +++++++++++++++++++
 include/linux/iommu.h |  1 +
 2 files changed, 20 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 4f91a740c15f..91d520d76e0d 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3348,6 +3348,25 @@ bool iommu_group_dma_owner_claimed(struct iommu_group *group)
 }
 EXPORT_SYMBOL_GPL(iommu_group_dma_owner_claimed);
 
+/**
+ * iommu_group_dma_owner_kernel() - Query if kernel owns the group dma
+ * @group: The group.
+ *
+ * This provides status query on a given group. It is racy and only for
+ * non-binding status reporting.
+ */
+bool iommu_group_dma_owner_user(struct iommu_group *group)
+{
+	void *user;
+
+	mutex_lock(&group->mutex);
+	user = group->owner;
+	mutex_unlock(&group->mutex);
+
+	return user ? true : false;
+}
+EXPORT_SYMBOL_GPL(iommu_group_dma_owner_user);
+
 static void iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
 				   struct iommu_domain *domain)
 {
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ccce8a751e2a..57b27c912a9c 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1132,6 +1132,7 @@ void iommu_device_unuse_default_domain(struct device *dev);
 int iommu_group_claim_dma_owner(struct iommu_group *group, void *owner);
 void iommu_group_release_dma_owner(struct iommu_group *group);
 bool iommu_group_dma_owner_claimed(struct iommu_group *group);
+bool iommu_group_dma_owner_user(struct iommu_group *group);
 
 int iommu_device_claim_dma_owner(struct device *dev, void *owner);
 void iommu_device_release_dma_owner(struct device *dev);
-- 
2.49.0.805.g082f7c87e0-goog

