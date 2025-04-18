Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6681520C037
	for <iommu@lists.linux.dev>; Fri, 18 Apr 2025 23:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745019316; cv=none; b=YNRWw4Q6DE8s8WO02dAFwZNOxt3hicK7seT0bY5AX9EBwwA20OwTqWk0GU50ydFH4gQM9oy/WmgGjULyRvIE/skYZ+cBN5ex5x073ccpj+DCKK3p/dlSM7ylkb1UOYtw0iKnuwS4lvCIGRQm9QuvFBoGL6K8fYLu1lVQ35T5LdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745019316; c=relaxed/simple;
	bh=qA7QkvsuROPertKMD44lD79Fu9uXGwQaSx4ofWuPY34=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VF0JCmTPxv74Hbero0O3D8cX8g9c9/bv6OtbX7TE4jlqh/88A/FGahkbQRQdsw58etrnEtbAAWxVSLR8T74lPd6E0TOshxHePOZ0AJW4DFrFNzxHcowIBuKDrliwd3LxXlzPXm3KGCAo0WOfrwctFPXgtsgmHg9h/nimgTJgSbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lt1mfVoI; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lt1mfVoI"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2265a09dbfcso34009375ad.0
        for <iommu@lists.linux.dev>; Fri, 18 Apr 2025 16:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745019315; x=1745624115; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vmrpWMhTMzXpYKtToUCpiflm8ifcap1KNtvgqeaGML0=;
        b=lt1mfVoI/pwCsNOCu6l9ukMZPu3Zh3KfQWkzChN63n7i3tKn78SUViJYBaG8mZnoUb
         59JbEWoxvsHo1R+hsLIm1An0wVm9eNiqIz5TfPA9TJBqg7kNr1KTVYMCUfp5gr+OwZxK
         9AtNmpPZ+hQirTeIHwSSXaMm/fiqy+o8LYWfZ9ZlxrSWhdUDUKOazXFBzAlvmjjTaHZi
         Yz+ePHaU2x4Cr4PO5UGsn5/mAabUwB0suNdKZmlIGiVeB4Y+kE7kvpvBlaQBA7REPIrt
         96PdndUvTmTqm9yczJB44dnR/9V1dLjtHLwWPsNvtGNWoX3mI3x5K8diXNwgtEd5q7bL
         AUpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745019315; x=1745624115;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vmrpWMhTMzXpYKtToUCpiflm8ifcap1KNtvgqeaGML0=;
        b=EqD0HEGHqQEx59l/uwgYQq6qCJf5ZChz8JnuirTuYxrMP9u7sjOuAW3ofoiPmzqX0m
         NWuCiYov8GOpkp18tksL7ES8kJ44WdM+vhkKWNw5753ZyoLLr9hz1Uw/HIZ3PJyxSXb3
         hKWMWWBXnhLMt9HMbjZw21oQAfbNR1ww7j/AojtxEW+02hbVX6qD7AELCSsZk6XhlaXh
         G5ZEcP+2umh+ZZDuX/2voFTaLvFjAWY5yQuUGLFa230IWGLaGIKObDnSfiNnU2aL3hCg
         txBKFCqEn1K7aTOqNixw/VqyeiOqbS/DTtsIavu5+KIGGE0zFhLbZqath2B0JHyQFA7D
         xQiw==
X-Forwarded-Encrypted: i=1; AJvYcCXqq6HkDmdEpKfZqWFffrRYe81mUdyT0vgmaZTtSN0v61c/ZAICumoznkCe+BU06FK8F4gASQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxTMtcIQWq7Awxq7zkdHHeIeGCoFbMzFdaXWbEyKrsNC1GukU9y
	bUMChRHA2rwdkb3mM8oexsFJ9bT4lsfioXpPOVleldRAEJiY793t2VZa+mq9Ym+ihiqAyeHmFw=
	=
X-Google-Smtp-Source: AGHT+IHm3u1IrXNitUcii05oJ8QKi4RA6LgMgsA0QvCEwDrhFaa4UWvzj4LqlJ5xBh81ECjxrB1JQzljQA==
X-Received: from pfij16.prod.google.com ([2002:aa7:8010:0:b0:73d:65cb:b18b])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:41c9:b0:223:52fc:a15a
 with SMTP id d9443c01a7336-22c536075c2mr59619395ad.33.1745019314961; Fri, 18
 Apr 2025 16:35:14 -0700 (PDT)
Date: Fri, 18 Apr 2025 23:34:06 +0000
In-Reply-To: <20250418233409.3926715-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250418233409.3926715-1-praan@google.com>
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250418233409.3926715-8-praan@google.com>
Subject: [RFC PATCH v2 07/10] iommu/arm-smmu-v3: Track masters with user-owned groups
From: Pranjal Shrivastava <praan@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Mostafa Saleh <smostafa@google.com>, 
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Track smmu masters (client devices) which belong to user-owned IOMMU
groups as determined by `iommu_group_dma_owner_user`. This allows the
driver to identify attachments where DMA is controlled by user-space.

This tracking provides the necessary infrastructure for setting up
power management policies to help decide if it's safe to power-down the
smmu if an attachment belongs to a user-space controlled group.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 69 +++++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 10 +++
 2 files changed, 79 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 3052ce1a419a..2b51665d5ca6 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3018,6 +3018,62 @@ void arm_smmu_attach_commit(struct arm_smmu_attach_state *state)
 	arm_smmu_remove_master_domain(master, state->old_domain, state->ssid);
 }
 
+static int arm_smmu_insert_insecure_master(struct arm_smmu_device *smmu,
+					   struct arm_smmu_master *master)
+{
+	struct arm_smmu_unsafe_master *umaster;
+	unsigned long flags;
+
+	umaster = kzalloc(sizeof(umaster), GFP_KERNEL);
+	if (!umaster)
+		return -ENOMEM;
+	umaster->master = master;
+
+	spin_lock_irqsave(&smmu->attach_lock, flags);
+	list_add_tail(&umaster->masters, &smmu->insecure_attachments);
+	spin_unlock_irqrestore(&smmu->attach_lock, flags);
+
+	return 0;
+}
+
+static struct arm_smmu_master *
+arm_smmu_find_insecure_master(struct arm_smmu_device *smmu,
+			      struct arm_smmu_master *master)
+{
+	struct arm_smmu_unsafe_master *iter, *umaster = NULL;
+	unsigned long flags;
+
+	spin_lock_irqsave(&smmu->attach_lock, flags);
+	list_for_each_entry(iter, &smmu->insecure_attachments, masters) {
+		if (iter->master == master) {
+			umaster = iter;
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&smmu->attach_lock, flags);
+
+	return umaster ? umaster->master : NULL;
+}
+
+static void arm_smmu_remove_insecure_master(struct arm_smmu_device *smmu,
+					    struct arm_smmu_master *master)
+{
+	struct arm_smmu_unsafe_master *iter, *tmp, *node_to_free = NULL;
+	unsigned long flags;
+
+	spin_lock_irqsave(&smmu->attach_lock, flags);
+
+	list_for_each_entry_safe(iter, tmp, &smmu->insecure_attachments, masters) {
+		if (iter->master == master) {
+			list_del(&iter->masters);
+			node_to_free = iter;
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&smmu->attach_lock, flags);
+	kfree(node_to_free);
+}
+
 static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 {
 	int ret = 0;
@@ -3041,6 +3097,16 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	if (smmu_domain->smmu != smmu)
 		return ret;
 
+	/* Check if the master is owned by user */
+	if (iommu_group_dma_owner_user(dev->iommu_group)) {
+		if (!arm_smmu_find_insecure_master(smmu, master))
+			arm_smmu_insert_insecure_master(smmu, master);
+
+	} else if (arm_smmu_find_insecure_master(smmu, master)) {
+		/* Remove if the master isn't user-owned anymore */
+		arm_smmu_remove_insecure_master(smmu, master);
+	}
+
 	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
 		cdptr = arm_smmu_alloc_cd_ptr(master, IOMMU_NO_PASID);
 		if (!cdptr)
@@ -3944,6 +4010,9 @@ static int arm_smmu_init_structures(struct arm_smmu_device *smmu)
 	mutex_init(&smmu->streams_mutex);
 	smmu->streams = RB_ROOT;
 
+	INIT_LIST_HEAD(&smmu->insecure_attachments);
+	spin_lock_init(&smmu->attach_lock);
+
 	ret = arm_smmu_init_queues(smmu);
 	if (ret)
 		return ret;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index d4ac6adc6a30..5ab60ae7ff91 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -795,6 +795,11 @@ struct arm_smmu_device {
 
 	struct rb_root			streams;
 	struct mutex			streams_mutex;
+
+	/* Insecure Attach handles */
+	struct list_head		insecure_attachments;
+	/* Lock for the list */
+	spinlock_t			attach_lock;
 };
 
 struct arm_smmu_stream {
@@ -803,6 +808,11 @@ struct arm_smmu_stream {
 	struct rb_node			node;
 };
 
+struct arm_smmu_unsafe_master {
+	struct list_head		masters;
+	struct arm_smmu_master		*master;
+};
+
 struct arm_smmu_vmaster {
 	struct arm_vsmmu		*vsmmu;
 	unsigned long			vsid;
-- 
2.49.0.805.g082f7c87e0-goog

