Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0E720C00E
	for <iommu@lists.linux.dev>; Tue, 12 Nov 2024 08:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731400246; cv=none; b=r1WKv/SQ5XUOufKnXWuyScnDdmDV3icwZx9WaR/qxZuCmelggGnfpyL6wzSqNigOxkduhikl71Yfp+5xLBtN2Qy++I2CbxJscYOhytgvnkdsLgetAyMPcDU9/vf1KlEMDLC+HFtyKCWD0xzdD2klXjA2mQgjVkGS1gqPxCD2xMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731400246; c=relaxed/simple;
	bh=lrj1dS9BHDGyx7JzuAfy6DaRQG80E5Kqh65nyjp2nng=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d0yP34040pqZbarYQ6Xj8ppo7yTbo9DQ9wPffW4V8bQtsHp0bS9wGVaS1xwCiXeWY3Awermi48gdbnIZI6suNc5fN4YxzG401em1RVETU6NfNxWgaUdjvtT2E4rq+y7W+ET1bbeE8w63TksIqUMHMmm2XgXYfppJl4+Oh6E6/go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VtHtkUvD; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VtHtkUvD"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e30ceaa5feeso9101984276.2
        for <iommu@lists.linux.dev>; Tue, 12 Nov 2024 00:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731400244; x=1732005044; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yKB4dTAL3LeSFoGrqcde49KkOLLY+yODjstF6KDpW1A=;
        b=VtHtkUvDb1H7kHIW3VByV6aDmWljoKSgk9WP/lWoycCSNMNQIVNmfmKHX4q2v3VwL8
         1bSJPcbvtKSa8pCZQL2GiGCLWpPqzsh/6er5yXcgEwl9Vg5gwOAtvsRrQahTMUHk3qct
         Ft+2gNBxhiowY1+Tpc0/55RUOdWM5wR+jCn3UClaWMzcw+Tt+JrHkmQeIHLJbBtGbSEU
         J+KaDPMx191CdzD6K8q47bxvO4V0E6OSQZEAPjrR+TJ0gKtoqaOp6xUrlB7fxwflAatC
         vDq9o9CLBCqfAu/a0563VntW/ppWd8DNvuOHearABZ8AM8pUlu+mkYOQblX+sBhfBNbQ
         Nyuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731400244; x=1732005044;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yKB4dTAL3LeSFoGrqcde49KkOLLY+yODjstF6KDpW1A=;
        b=Ux2+7Ub0xxJ22wUh3cPMmMbLECH8LrLrrp2Aou8dfcf70rAD2ZrMeQIr4usFi8qj/K
         fZd/6yswNY444buR5yA6oL/XJXG3SVds15n5utTcQ+ybQ27kG2NZ0YFzmK2/O3mLxdoC
         9gynA1VhlRWye3bNjZxat8ipCThCMeAf+DV13VX7swkMhsv9Pjkj2FdPlhlRMg8UVD2t
         bhp00Jmm1atd8qn6P1bp73r4whSiV6P7oPIGuNnPLrvlAJFJlsbI1Ogrli3JN9pg0hcM
         XGo5EHjERFm5kmp36cK2lmVNEbZWx72LzhRLlf/6ZxLF1Xgs1q7fp+2AJuI+YX7fWDOJ
         7y2w==
X-Forwarded-Encrypted: i=1; AJvYcCXqmQQ4SSa44xddIg9tzEead2TIEvnYfhT1bwAh/ylii7UvI0Fib+IeN48oTiUe3MlNd77o3g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzW9nA52UM6qH6NL7rchgpMoEQHQflTO8hDePZBCuAA7sae3q4+
	fnKLjPXTfaQVX6hDxykdZ8PMQGn403joyyHSUr0N3j0246PxWPlkilrw3Amy2haM70mcVxui7A=
	=
X-Google-Smtp-Source: AGHT+IFV/HvSKUNihH9vtthSPsdHaVZCjfFvly32OElVt6pmJYbcv4o9CgPm69/EYxysi+NzqvSOfflzyw==
X-Received: from praan.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:3e89])
 (user=praan job=sendgmr) by 2002:a5b:70a:0:b0:e28:e6a1:fc53 with SMTP id
 3f1490d57ef6-e337f8c6c5dmr47177276.5.1731400244450; Tue, 12 Nov 2024 00:30:44
 -0800 (PST)
Date: Tue, 12 Nov 2024 08:30:18 +0000
In-Reply-To: <20241112083018.1662104-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20241112083018.1662104-1-praan@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241112083018.1662104-4-praan@google.com>
Subject: [PATCH v5 3/3] iommu/arm-smmu-v3: Avoid redundant master lookup in events
From: Pranjal Shrivastava <praan@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>
Cc: Mostafa Saleh <smostafa@google.com>, Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev, 
	Jason Gunthorpe <jgg@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Remove the call to `arm_smmu_find_master` in `arm_smmu_handle_evt`.

The call was primarily to retrieve `master->dev` ptr for reporting iommu
device faults. Since this info is already available in the `event->dev`
field, we no longer need to lookup the master to fetch the dev pointer.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index c0ecd74efe58..ddb7850b098c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1814,9 +1814,7 @@ static void arm_smmu_decode_event(struct arm_smmu_device *smmu, u64 *raw,
 static int arm_smmu_handle_evt(struct arm_smmu_device *smmu,
 			       struct arm_smmu_event *event)
 {
-	int ret = 0;
 	u32 perm = 0;
-	struct arm_smmu_master *master;
 	struct iopf_fault fault_evt = { };
 	struct iommu_fault *flt = &fault_evt.fault;
 
@@ -1857,17 +1855,14 @@ static int arm_smmu_handle_evt(struct arm_smmu_device *smmu,
 		flt->prm.pasid = event->ssid;
 	}
 
-	mutex_lock(&smmu->streams_mutex);
-	master = arm_smmu_find_master(smmu, event->sid);
-	if (!master) {
-		ret = -EINVAL;
-		goto out_unlock;
-	}
+	/*
+	 * If the master wasn't found while reading the event or
+	 * get_device() returned NULL, we shouldn't report a fault.
+	 */
+	if (!event->dev)
+		return -EINVAL;
 
-	ret = iommu_report_device_fault(master->dev, &fault_evt);
-out_unlock:
-	mutex_unlock(&smmu->streams_mutex);
-	return ret;
+	return iommu_report_device_fault(event->dev, &fault_evt);
 }
 
 static void arm_smmu_dump_raw_event(struct arm_smmu_device *smmu, u64 *raw,
@@ -1927,6 +1922,7 @@ static void arm_smmu_dump_event(struct arm_smmu_device *smmu, u64 *raw,
 	}
 }
 
+
 static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 {
 	u64 raw_evt[EVTQ_ENT_DWORDS];
-- 
2.47.0.277.g8800431eea-goog

