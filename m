Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F8B1C6F74
	for <iommu@lists.linux.dev>; Tue, 27 Aug 2024 19:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724787093; cv=none; b=Pox71b6/JoitlySc2J9Ki4x7mnX5+LENg17QFn8d7PFSdCHiZyzuL504IRNxNr3KWQ32DFOpY1wM+1IWZ2gemNYj2h+GFNPeV1jE+IQfnp83eIJ0BYi69AadLg5mm5V1SHde/iU4ZxmzISq3gDd7cMlwXiC55nIuVsfoVRP2JG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724787093; c=relaxed/simple;
	bh=3BA8x2F73yu/uVIyIgCBByfG4Kuhbjd6luJcZ6w06WQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Pnxv3HiLzYxDgRyy0WwWdFhGe9PrO3QPyBoo60rIiNVZxFMoZkPjLufwUDQQlUFwFPyin6YHGiPJqLp3alApFdKaqnzbXs7vjj16oHguyBVKHgrWp0onMP28qG6mh/7JRmL3rlvYb5C0CphvaO1YpOLyp+5sYb+h9RsVhXx1aUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b0s3t+Bt; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b0s3t+Bt"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ad97b9a0fbso118370407b3.0
        for <iommu@lists.linux.dev>; Tue, 27 Aug 2024 12:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724787091; x=1725391891; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=I7sTHTpX2Dj5vSLceRdmkmf3ibqLqeBtzJphPdjG+rg=;
        b=b0s3t+BtpLxOZotGOGEVQt7G8QTdGa0Xo7A/Jam/gv/IS2KW1f2t3CFi7muYmRJpEp
         3tXdtVCVvZU/epwPYQS+U8fhjcZMX4bdcI1Dy8lb7ryVV+qGbSIwX5LFTmxwmMKpuyD2
         5X1I4DWd+b3fSv9OBV2inGVBs0xOacBCtSkBf26r4WgTNlwMJ/9HEAYACPi4/p71I51t
         w2nhGNh5Xeo16Ssl8D2eugcJ6Hdc58VO/MKlcNdi1W1W35rp/P52t27hwjDeoxdmNUUS
         vDaS3VLl4f5plaRYNEmVl5xcVOxxR/VA0lb8jNMyi6iPtKc3tgTMST8xZ986HTIeN6f0
         owlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724787091; x=1725391891;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I7sTHTpX2Dj5vSLceRdmkmf3ibqLqeBtzJphPdjG+rg=;
        b=Cr/QDnz6UWWFh4CeHkGozjAhFpRSrDs47hPK5p5J0vx1E0xVU/JOSUYwzNXklwxF7l
         Vt8YA3QrxzrS0J8rlbMIDFxw2kfhy4v2TdLYfRyulNRLf71r7GVJj5+ZLUAOM/G4405Z
         Tme4WVGkdoFrupBkKOE1+VzswpI6rtzKviYG2jZj2n7BKPye8j0Knn2yLzf0V54m5YRj
         QFJMpf6fTgTjG2jo12u4WsaMqVZttnaiCKxnqzstCaPkKgtphfRIqt3fnJKJhuDingk1
         R6kJIozMisFfQ+7B1h6j+pfc2BR4NUJZ1tqPi6u++eZ2ylxmrVl7JxzNxwgeGbvCpqGw
         HzRg==
X-Forwarded-Encrypted: i=1; AJvYcCXiOXGIN4TUBV3Ztwm+KH6++71l2NVgyfvsIRcfH0YAiX3suZIIVG+jiqqvJZ5tXwylD+62wA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzjcFk2gcXwb2GDedF2c4/5eI/X2r483j65Krb1xxNvET+RCFvf
	KLtOgzf/HAG+8NVM8h0Xx20+12QqULbDOr4qVK7ADeeMvPnMVb0dPCA6P1ai1vO2bGtD1lpI+g=
	=
X-Google-Smtp-Source: AGHT+IGaKZCmC8FBZ4UCrrcEXtSkZxXYj/oNLsHo0MiYkfu80HXx2iiWlasalONDXoRNXc7ma/viKNzNqA==
X-Received: from praan.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:3e89])
 (user=praan job=sendgmr) by 2002:a05:690c:2f0e:b0:650:93e3:fe73 with SMTP id
 00721157ae682-6c627f06589mr1217047b3.5.1724787091387; Tue, 27 Aug 2024
 12:31:31 -0700 (PDT)
Date: Tue, 27 Aug 2024 19:30:26 +0000
In-Reply-To: <20240827193026.3993039-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240827193026.3993039-1-praan@google.com>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <20240827193026.3993039-3-praan@google.com>
Subject: [PATCH v2 2/2] iommu/arm-smmu-v3: Adopt arm_smmu_event in handlers
From: Pranjal Shrivastava <praan@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>
Cc: Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Modify the event handler routines to leverage `struct arm_smmu_event`

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 39 ++++++++-------------
 1 file changed, 15 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 65160b52d944..e33f73079a2a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1746,17 +1746,14 @@ arm_smmu_find_master(struct arm_smmu_device *smmu, u32 sid)
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
@@ -1767,46 +1764,40 @@ static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
 	}
 
 	/* Stage-2 is always pinned at the moment */
-	if (evt[1] & EVTQ_1_S2)
+	if (event->stage)
 		return -EFAULT;
 
-	if (!(evt[1] & EVTQ_1_STALL))
+	if (!(event->raw[1] & EVTQ_1_STALL))
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
 
-	mutex_lock(&smmu->streams_mutex);
-	master = arm_smmu_find_master(smmu, sid);
-	if (!master) {
-		ret = -EINVAL;
-		goto out_unlock;
-	}
+	if (!event->master)
+		return -EINVAL;
 
-	ret = iommu_report_device_fault(master->dev, &fault_evt);
-out_unlock:
-	mutex_unlock(&smmu->streams_mutex);
+	ret = iommu_report_device_fault(event->master->dev, &fault_evt);
 	return ret;
 }
 
@@ -1915,7 +1906,7 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 		while (!queue_remove_raw(q, evt)) {
 
 			arm_smmu_get_evt_info(smmu, evt, &event);
-			ret = arm_smmu_handle_evt(smmu, evt);
+			ret = arm_smmu_handle_evt(smmu, &event);
 			if (!ret || !__ratelimit(&rs))
 				continue;
 
-- 
2.46.0.295.g3b9ea8a38a-goog

