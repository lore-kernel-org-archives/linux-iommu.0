Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E54D154A0
	for <iommu@lists.linux.dev>; Thu,  3 Aug 2023 10:14:27 +0000 (UTC)
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-cf4cb742715so809006276.2
        for <iommu@lists.linux.dev>; Thu, 03 Aug 2023 03:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691057666; x=1691662466;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xOWJ0lqxCqyUuPaPvlunqjXsmwJAIBAp4YS6BHDu6Oc=;
        b=q8ilSnaU6t9HzGSP25lQgwS3HkEavJ1kpDRxanKDeMxMFpXMt79mwz5/LyAooJlDvA
         ZFkcNzkxOdJkn+mQlAQajTVdFv7/wktHRMWl9+jtmycAuPJQ443dGFHW9mHfYob5d0dR
         5gCKHa5Mr+kyEbJAgDyNiqFHQG8H2exc8qDgBJSYDg23RNV0TbdqhxbIdbAAfRYb1jMH
         hgM5mz2RHJacrXX1YxLeqEnyi0WI3oxPjjDRLSX5c3zy/nPep2zhTSl0jYzYmZaboMSF
         Yc8Hk93qM/6eAhy29HnpU9HJeSdlYmBnHfXx9w9kfu8bDRKPI6LjT6pzgjlkK/ioJoFh
         nk/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691057666; x=1691662466;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xOWJ0lqxCqyUuPaPvlunqjXsmwJAIBAp4YS6BHDu6Oc=;
        b=J/3Vj6NtDTD7rILrwcKwMCy4gFsrRpyot0WKZ4MwqVuWrtOY9zJOnP+vgyQTTHzDwf
         KppbawAqbSacy5Nh48WrgInFPl5jGy54DQrgoiep7XzUT8A1QOJ/FUve4Sc+2spBh6HB
         Mn66fnlvLmVFccKoX7IfB7DS0glWdbdiR0B8D48YKCidyIcFePwScPsv5y54nM9iaJ/T
         /dGQ0c9skXGn6i0x+3M+yTYLsweTzJU7tKJTwoQv7GFpheMf0gx5Ys3v9+5DVrQn6avb
         0pNz4rfgPISlTD16BqzJcQbgQCF1J579DLA2EiPpyHHCw0lbmtkD0L040c3I03xd+f0+
         r0Pg==
X-Gm-Message-State: ABy/qLaZZOZv7dc7PI3pVEStyn5QrEIrZIRoFymj2CiuX+x/0tDWdPCd
	1yvoDaUDUtsqzDUFJrdpi+53mQp12Au09JnEcOnRYhck0YiwmOt0liwsBoxUCPbHdE4zT9FlI/N
	vtPqVVtocLUbLkSQ3A0HNN1nE8j47nl9Ko46a/TJ9fQb673KNOhTICJMLv5ki+5w=
X-Google-Smtp-Source: APBJJlFvhgXCXZP9pdYDhKfOUVlYdwH/SmwuHsXAcZhU925R9DHZabK6vjqUogAiaEDk0wFB/8skMjsyTC09
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:39d1:8774:b733:6210])
 (user=mshavit job=sendgmr) by 2002:a25:2042:0:b0:cb6:6c22:d0f8 with SMTP id
 g63-20020a252042000000b00cb66c22d0f8mr142117ybg.4.1691057665928; Thu, 03 Aug
 2023 03:14:25 -0700 (PDT)
Date: Thu,  3 Aug 2023 18:12:25 +0800
In-Reply-To: <20230803101351.1561031-1-mshavit@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230803101351.1561031-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230803181225.v5.5.I6f3fb0734ef5ef746ae7c9b27f632f506197eb30@changeid>
Subject: [PATCH v5 5/6] iommu/arm-smmu-v3: Free pasid domains on iommu release
From: Michael Shavit <mshavit@google.com>
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: baolu.lu@linux.intel.com, will@kernel.org, jgg@nvidia.com, 
	jean-philippe@linaro.org, robin.murphy@arm.com, nicolinc@nvidia.com, 
	Michael Shavit <mshavit@google.com>
Content-Type: text/plain; charset="UTF-8"

The iommu core doesn't guarantee that pasid domains will be detached
before the device is released.

Track the list of domains that a master is attached to with PASID, so
that they can be freed when the iommu is released.

Signed-off-by: Michael Shavit <mshavit@google.com>
---

Changes in v5:
- New commit: Free attached pasid domains on release_device() call

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 22 +++++++++++++++------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 10 +++++++++-
 2 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 7b296458dafec..5fd6c4d4f0ae4 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2587,6 +2587,9 @@ static int arm_smmu_set_dev_pasid(struct iommu_domain *domain,
 	mutex_unlock(&arm_smmu_asid_lock);
 
 	master->nr_attached_pasid_domains += 1;
+	list_add(&attached_domain->list_in_master,
+		 &master->attached_domains);
+
 	return 0;
 }
 
@@ -2786,6 +2789,7 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 	master->dev = dev;
 	master->smmu = smmu;
 	INIT_LIST_HEAD(&master->bonds);
+	INIT_LIST_HEAD(&master->attached_domains);
 	dev_iommu_priv_set(dev, master);
 
 	ret = arm_smmu_insert_master(smmu, master);
@@ -2825,16 +2829,21 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 static void arm_smmu_release_device(struct device *dev)
 {
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+	struct arm_smmu_attached_domain *attached_domain;
+	struct arm_smmu_domain *smmu_domain;
+	unsigned long flags;
 
 	if (WARN_ON(arm_smmu_master_sva_enabled(master)))
 		iopf_queue_remove_device(master->smmu->evtq.iopf, dev);
 	if (WARN_ON(master->nr_attached_pasid_domains != 0)) {
-		/*
-		 * TODO: Do we need to handle this case?
-		 * This requires a mechanism to obtain all the pasid domains
-		 * that this master is attached to so that we can clean up the
-		 * domain's attached_domain list.
-		 */
+		list_for_each_entry(attached_domain, &master->attached_domains, list_in_master) {
+			smmu_domain = attached_domain->domain;
+			spin_lock_irqsave(&smmu_domain->attached_ssids_lock, flags);
+			list_del(&attached_domain->list);
+			list_del(&attached_domain->list_in_master);
+			kfree(&attached_domain->list_in_master);
+			spin_unlock_irqrestore(&smmu_domain->attached_ssids_lock, flags);
+		}
 	}
 
 	arm_smmu_detach_dev(master);
@@ -2995,6 +3004,7 @@ static void arm_smmu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 		    attached_domain->ssid != pasid)
 			continue;
 		list_del(&attached_domain->list);
+		list_del(&attached_domain->list_in_master);
 		master->nr_attached_pasid_domains -= 1;
 		kfree(attached_domain);
 		break;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 433f58bd99dd2..efa428629f4d9 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -689,9 +689,15 @@ struct arm_smmu_stream {
 	struct rb_node			node;
 };
 
-/* List of {masters, ssid} that a domain is attached to */
+/*
+ * List of {masters, ssid} that a domain is attached to, and conversely of
+ * domains that a master is attached to.
+ */
 struct arm_smmu_attached_domain {
+	/* List node arm_smmu_domain*/
 	struct list_head	list;
+	/* List node in arm_smmu_master*/
+	struct list_head	list_in_master;
 	struct arm_smmu_domain  *domain;
 	struct arm_smmu_master  *master;
 	int			ssid;
@@ -714,6 +720,8 @@ struct arm_smmu_master {
 	struct list_head		bonds;
 	unsigned int			ssid_bits;
 	unsigned int			nr_attached_pasid_domains;
+	/* Locked by the iommu core using the group mutex */
+	struct list_head		attached_domains;
 };
 
 /* SMMU private data for an IOMMU domain */
-- 
2.41.0.585.gd2178a4bd4-goog

