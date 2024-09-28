Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D888101E2
	for <iommu@lists.linux.dev>; Sat, 28 Sep 2024 00:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727484735; cv=none; b=rnfbblpBljZw/eCkpiaiz+Oo+xJf2BLWN71gcaKfDV0/8oP4kRbk+7qF3H1cYU0YqfshTx+xaXJYnCb6sb5ngsYRLMpbOpwTzg9O+OD9EeGUkU4UfWXl4dWSBSlBYyEVwi4WfANYwbJiOFUzo/6mlE9iV3IKir+kRXRTXUdkP4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727484735; c=relaxed/simple;
	bh=BpU4hwsiStguL41j6Qn+48PB1l2AANh32O73Np+rv6A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eKSpCcRm/PE/HHs9fKcTjXnHIYq1883h/tQ3hRtGBNmyYLOzp/nn/b2Fr4VUfl0GdT4WiXFmuT4mc7ajsKbLM4n765DVg2TA3FF5zM+RVmmsaIkDXGPRNgZgJFNt0OOcmEt1VintxZghoIOusL7rmsW1y9EW4yRC14GcZOZXhJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0++F2YSz; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0++F2YSz"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e2605ce4276so2627551276.3
        for <iommu@lists.linux.dev>; Fri, 27 Sep 2024 17:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727484733; x=1728089533; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wQ0jmBYIIbELrk6dJIUae6lDYZ8w4HZPhS2KvB8kQKA=;
        b=0++F2YSzSvqm2d6AQA9eb3ANkqYKVFex9zXEgnqayEjkRpZNE63m+etUukzG1nk2Fi
         I5FTISdLry8Px8DIAX0fojLV6Ozd4V2qqwN+tYsmeeg8jmARpu51H2R5xBRjgWwlNGVt
         r4YmR37v2fq316pFJp/duco/pXgLQXa94Xu0jLAUbNXEw8q96r4FLlW+qjjh8Th5VBRP
         gfprgLtQDE1mawkHej3BcCohG0AHduhUz442FOx4KbiikN3QH20XqC9wVK9MAgmaHKSX
         QnIgsOIdFZsxw3UOm91gR/4VVMv81XIbsiXJKzKV4yiwt+FzwJ1qRY6C+MIXi7XAU0oq
         udFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727484733; x=1728089533;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wQ0jmBYIIbELrk6dJIUae6lDYZ8w4HZPhS2KvB8kQKA=;
        b=neeArhfg5TPyJAutkKhYXPnpl2DuLqwMqcVg/KDK8f8Hl5mxqjjrzhs+NpgHlQPcnD
         2ABGpct0W3NnUeMvLFvhMKwDBltLwJwoTalX2zlhMd9foWmwVPXJo7jV1x+c+5j56zIY
         E5CIx3JAl3TFE9SiMf9mzQhZLoq4Sda+J30BE1G+QELlzZeX0nJvI7TPr/S4jjuj2xFs
         Dv5GT6peiRWzpefWZasj57GeD5HBJlNICHo4jrpgC9JqIVV2ILYJZzj5YwH1j/JU7yzK
         BwWWzDlZTx6hD9DxQn1T4+KCSvHi5by1YzdWL/9po7ykncMKjuDhq0/k038kqKUeOxph
         SG6A==
X-Forwarded-Encrypted: i=1; AJvYcCXmkXRmaAbgcVReTItl+ddVVL7KhyMDaWWxMtC+raR3dnS/kmjN/cphWSPkWxZradsq5GYVnQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxhmX9ibCIXyULQonEwD4n7J46a6JPhTNwQaAA3CLgyJzPJRe1M
	WSSqCqcZITxTJLoxT+1jT/Dx7XwWwJllAqQIKMqqC6lCGsIj8LHk6s0i9doKMYRGOhDGm+vq4w=
	=
X-Google-Smtp-Source: AGHT+IFf3/iHpesSMtpeHxG3v7CVIw6Qw+opqV9x24V//WjOTEGWuDxDI+vj1+V3MAktGN5qcWYm1adbTA==
X-Received: from praan.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:3e89])
 (user=praan job=sendgmr) by 2002:a25:fc06:0:b0:e25:c8fc:b78c with SMTP id
 3f1490d57ef6-e2604c7ea2amr2934276.9.1727484733160; Fri, 27 Sep 2024 17:52:13
 -0700 (PDT)
Date: Sat, 28 Sep 2024 00:51:43 +0000
In-Reply-To: <20240928005143.2378938-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240928005143.2378938-1-praan@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20240928005143.2378938-3-praan@google.com>
Subject: [PATCH v3 2/2] iommu/arm-smmu-v3: Adopt arm_smmu_event in handlers
From: Pranjal Shrivastava <praan@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>
Cc: Mostafa Saleh <smostafa@google.com>, Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Modify the event handler routines to leverage `struct arm_smmu_event`.
Log the event within the `arm_smmu_handle_evt` routine.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 35 ++++++++++-----------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 2b2949bd2d26..3c326f3a038a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1845,17 +1845,14 @@ static void arm_smmu_dump_event(struct arm_smmu_device *smmu,
 }
 
 /* IRQ and event handlers */
-static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
+static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, struct arm_smmu_event *event)
 {
 	int ret = 0;
 	u32 perm = 0;
-	struct arm_smmu_master *master;
-	bool ssid_valid = evt[0] & EVTQ_0_SSV;
-	u32 sid = FIELD_GET(EVTQ_0_SID, evt[0]);
 	struct iopf_fault fault_evt = { };
 	struct iommu_fault *flt = &fault_evt.fault;
 
-	switch (FIELD_GET(EVTQ_0_ID, evt[0])) {
+	switch (event->id) {
 	case EVT_ID_TRANSLATION_FAULT:
 	case EVT_ID_ADDR_SIZE_FAULT:
 	case EVT_ID_ACCESS_FAULT:
@@ -1865,42 +1862,45 @@ static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
 		return -EOPNOTSUPP;
 	}
 
-	if (!(evt[1] & EVTQ_1_STALL))
+	if (!event->stall)
 		return -EOPNOTSUPP;
 
-	if (evt[1] & EVTQ_1_RnW)
+	if (event->read)
 		perm |= IOMMU_FAULT_PERM_READ;
 	else
 		perm |= IOMMU_FAULT_PERM_WRITE;
 
-	if (evt[1] & EVTQ_1_InD)
+	if (event->instruction)
 		perm |= IOMMU_FAULT_PERM_EXEC;
 
-	if (evt[1] & EVTQ_1_PnU)
+	if (event->privileged)
 		perm |= IOMMU_FAULT_PERM_PRIV;
 
 	flt->type = IOMMU_FAULT_PAGE_REQ;
 	flt->prm = (struct iommu_fault_page_request) {
 		.flags = IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE,
-		.grpid = FIELD_GET(EVTQ_1_STAG, evt[1]),
+		.grpid = FIELD_GET(EVTQ_1_STAG, event->raw[1]),
 		.perm = perm,
-		.addr = FIELD_GET(EVTQ_2_ADDR, evt[2]),
+		.addr = event->iova,
 	};
 
-	if (ssid_valid) {
+	if (event->ssid_valid) {
 		flt->prm.flags |= IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
-		flt->prm.pasid = FIELD_GET(EVTQ_0_SSID, evt[0]);
+		flt->prm.pasid = event->ssid;
 	}
 
 	mutex_lock(&smmu->streams_mutex);
-	master = arm_smmu_find_master(smmu, sid);
-	if (!master) {
+	event->master = arm_smmu_find_master(smmu, event->sid);
+	if (!event->master) {
 		ret = -EINVAL;
+		event->master_name = "(unassigned sid)";
 		goto out_unlock;
 	}
 
-	ret = iommu_report_device_fault(master->dev, &fault_evt);
+	ret = iommu_report_device_fault(event->master->dev, &fault_evt);
 out_unlock:
+	if (ret)
+		arm_smmu_dump_event(smmu, event);
 	mutex_unlock(&smmu->streams_mutex);
 	return ret;
 }
@@ -1949,11 +1949,10 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 		while (!queue_remove_raw(q, evt)) {
 
 			arm_smmu_get_evt_info(smmu, evt, &event);
-			ret = arm_smmu_handle_evt(smmu, evt);
+			ret = arm_smmu_handle_evt(smmu, &event);
 			if (!ret || !__ratelimit(&rs))
 				continue;
 
-			arm_smmu_dump_event(smmu, &event);
 			cond_resched();
 		}
 
-- 
2.46.1.824.gd892dcdcdd-goog

