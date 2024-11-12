Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EDD20C00C
	for <iommu@lists.linux.dev>; Tue, 12 Nov 2024 08:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731400241; cv=none; b=WgLVRvn6L4fCPfcBHsJqMMdlhJgnUlwR/qc8xnVjtKx7Nya+uodX8406YRMYCHawqhd4ntyYTjLBE7vwP4NaVwk4TN9yRwyyAeJgGSY1CPFeooOqb1RhTtfCB5vn9I61VNb0SAwG4moAlmiePJ1jMcK6uKe5863aeiHnPfsUhK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731400241; c=relaxed/simple;
	bh=x0oAu4oR8Nau1OTqbx7fa7HX7tfnrZ2Ko7UjqwMn29M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L8p2FYXWb1JvLIGvTpken7/67Bz89k38uBUPGOlJr46g5eIE/UkBN0FfHWWgcaAqQN7ndLxK2HzeHNDG0wZYIl2Hi5zCxVeo9xKURrjITrBxNySObKk8QFhsSihjzpLwHLoqnw4lneJrk2Tr/84DlW2pstIkHBFtzdgVaxJtxhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UOI7xmf4; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UOI7xmf4"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e28fc60660dso8092074276.0
        for <iommu@lists.linux.dev>; Tue, 12 Nov 2024 00:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731400239; x=1732005039; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0KEk7zNtYQd5HBvj5dlqK8FmIt5ccbp34KzRwZWJS1s=;
        b=UOI7xmf4kSXm6Nur0elAwmVSd+qAfX2cvyJn1GJ38/kNzuvmBzEYDoD72U43pbr6f3
         gLF+2cRyB5JLe0hxf4riUvpOxYgdyVkI8xNr8aFwcInXdpayNu92W6n07627oG4QiHBi
         s4FZj6VROU+eeOdH66ANizWV/PF2OrBD3Zk553T3sr82pF/3Em8u9jGWPrqXDzjo4E/7
         PF/4vfT/bFH7NhjcsK0GXeh7te/0nuvisX6Zj7tx7rEL0d5fuzx56dKlXR5lx8/Rq4Gd
         nAfl5NOoDgTmFYhxod34GxOzHlRJUn3k1nC/bTnLu5AOzO+KOqTTvHYSUV/eeNHlLWRf
         BztA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731400239; x=1732005039;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0KEk7zNtYQd5HBvj5dlqK8FmIt5ccbp34KzRwZWJS1s=;
        b=Cr4osN26l+s7MoJETOxYvriOIQXKA/XhZx+jrXyHpM6IJSV2TcewyD3hmYmTdub2de
         J3eOZMYC3PmzTwBq7ne1s1VThVdDXr/UENdaqIxLEQ/sOsAYPqbuKXgY180+mVg1txrY
         E/8zpjIPMzOx3qavjsk6c1rNBpydtx9j6sN4jIJIL53YJ/rIcf87jwKf9cPzOukMJ2s1
         ml0Xtc/yhaPTvHMEwolKO0vl2OiQslI3b4qgoov9InMeHhaWVHseUlE3Kh9dKDgs8kOa
         d54YSxPdZ/Q94FwrG0fcLzSMAIatRIrSZDv+rvJY4sariY23d9DYoOfoIKaLqEf9/VMe
         KDzw==
X-Forwarded-Encrypted: i=1; AJvYcCUxN3wJzzbAw9PJMUiQklRwgaZKSido974ZQxAdm8qsj+O3DWS6nikQtUMtIQ5y9yk1tD1UuQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyfsTmArRtCtXRfC9l9hHd2pP/OquCtaYHAEX4YXXJlWrNAPaOu
	vXwblA/EdjvB01p11mbv/2XmJ0G183xfpzcbbSs1NzFvE7ZuWRY/10skk/G4iRNPILuhXRaYHQ=
	=
X-Google-Smtp-Source: AGHT+IFrV5h9eQ/OIVQfzePOgJRDnSq4kIzQsXNcmJ2LoQ17UYGNFeGRH4Ixz99FZ8Soo2XagS9aaO00qw==
X-Received: from praan.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:3e89])
 (user=praan job=sendgmr) by 2002:a25:bfc5:0:b0:e25:6701:410b with SMTP id
 3f1490d57ef6-e337f8c911dmr54370276.5.1731400239024; Tue, 12 Nov 2024 00:30:39
 -0800 (PST)
Date: Tue, 12 Nov 2024 08:30:17 +0000
In-Reply-To: <20241112083018.1662104-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20241112083018.1662104-1-praan@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241112083018.1662104-3-praan@google.com>
Subject: [PATCH v5 2/3] iommu/arm-smmu-v3: Log better event records
From: Pranjal Shrivastava <praan@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>
Cc: Mostafa Saleh <smostafa@google.com>, Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev, 
	Jason Gunthorpe <jgg@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Currently, the driver dumps the raw hex for a received event record.
Improve this by leveraging `struct arm_smmu_event` for event fields
and log human-readable event records with meaningful information.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 110 ++++++++++++++++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  14 ++-
 2 files changed, 112 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index e1b69aa04382..c0ecd74efe58 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -83,6 +83,28 @@ static struct arm_smmu_option_prop arm_smmu_options[] = {
 	{ 0, NULL},
 };
 
+static const char * const event_str[] = {
+	[EVT_ID_BAD_STREAMID_CONFIG] = "C_BAD_STREAMID",
+	[EVT_ID_STE_FETCH_FAULT] = "F_STE_FETCH",
+	[EVT_ID_BAD_STE_CONFIG] = "C_BAD_STE",
+	[EVT_ID_STREAM_DISABLED_FAULT] = "F_STREAM_DISABLED",
+	[EVT_ID_BAD_SUBSTREAMID_CONFIG] = "C_BAD_SUBSTREAMID",
+	[EVT_ID_CD_FETCH_FAULT] = "F_CD_FETCH",
+	[EVT_ID_BAD_CD_CONFIG] = "C_BAD_CD",
+	[EVT_ID_TRANSLATION_FAULT] = "F_TRANSLATION",
+	[EVT_ID_ADDR_SIZE_FAULT] = "F_ADDR_SIZE",
+	[EVT_ID_ACCESS_FAULT] = "F_ACCESS",
+	[EVT_ID_PERMISSION_FAULT] = "F_PERMISSION",
+	[EVT_ID_VMS_FETCH_FAULT] = "F_VMS_FETCH",
+};
+
+static const char * const event_class_str[] = {
+	[0] = "CD fetch",
+	[1] = "Stage 1 translation table fetch",
+	[2] = "Input address caused fault ",
+	[3] = "Reserved",
+};
+
 static int arm_smmu_domain_finalise(struct arm_smmu_domain *smmu_domain,
 				    struct arm_smmu_device *smmu, u32 flags);
 static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master);
@@ -1757,8 +1779,11 @@ arm_smmu_find_master(struct arm_smmu_device *smmu, u32 sid)
 }
 
 /* IRQ and event handlers */
-static void arm_smmu_decode_event(u64 *raw, struct arm_smmu_event *event)
+static void arm_smmu_decode_event(struct arm_smmu_device *smmu, u64 *raw,
+				  struct arm_smmu_event *event)
 {
+	struct arm_smmu_master *master;
+
 	event->id = FIELD_GET(EVTQ_0_ID, raw[0]);
 	event->sid = FIELD_GET(EVTQ_0_SID, raw[0]);
 	event->ssv = raw[0] & EVTQ_0_SSV;
@@ -1772,6 +1797,18 @@ static void arm_smmu_decode_event(u64 *raw, struct arm_smmu_event *event)
 	event->class = FIELD_GET(EVTQ_1_CLASS, raw[1]);
 	event->iova = FIELD_GET(EVTQ_2_ADDR, raw[2]);
 	event->ipa = raw[3];
+	event->ttrnw = FIELD_GET(EVTQ_1_TT_READ, raw[1]);
+	event->class_tt = false;
+	event->dev = NULL;
+
+	if (event->id == EVT_ID_PERMISSION_FAULT)
+		event->class_tt = (event->class == EVTQ_1_CLASS_TT);
+
+	mutex_lock(&smmu->streams_mutex);
+	master = arm_smmu_find_master(smmu, event->sid);
+	if (master)
+		event->dev = get_device(master->dev);
+	mutex_unlock(&smmu->streams_mutex);
 }
 
 static int arm_smmu_handle_evt(struct arm_smmu_device *smmu,
@@ -1833,9 +1870,65 @@ static int arm_smmu_handle_evt(struct arm_smmu_device *smmu,
 	return ret;
 }
 
+static void arm_smmu_dump_raw_event(struct arm_smmu_device *smmu, u64 *raw,
+				    struct arm_smmu_event *event)
+{
+	int i;
+
+	dev_err(smmu->dev, "event 0x%02x received:\n", event->id);
+
+	for (i = 0; i < EVTQ_ENT_DWORDS; ++i)
+		dev_err(smmu->dev, "\t0x%016llx\n", raw[i]);
+}
+
+#define ARM_SMMU_EVT_KNOWN(e)	((e)->id < ARRAY_SIZE(event_str) && event_str[(e)->id])
+#define ARM_SMMU_LOG_EVT_STR(e) ARM_SMMU_EVT_KNOWN(e) ? event_str[(e)->id] : "UNKNOWN"
+#define ARM_SMMU_LOG_CLIENT(e)	(e)->dev ? dev_name((e)->dev) : "(unassigned sid)"
+
+#define ARM_SMMU_EVT_LOG_PFX	"Event %#x received: %s\n\tclient: %s sid: %#x ssid: %#x\n"
+#define ARM_SMMU_EVT_LOG_FMT(e) (e)->id, ARM_SMMU_LOG_EVT_STR(e), \
+				ARM_SMMU_LOG_CLIENT(e), (e)->sid, (e)->ssid
+
+#define ARM_SMMU_EVT_LOG(dev, evt, msg, ...)    \
+	dev_err(dev, ARM_SMMU_EVT_LOG_PFX msg "\n", ARM_SMMU_EVT_LOG_FMT(evt), ##__VA_ARGS__)
+
+static void arm_smmu_dump_event(struct arm_smmu_device *smmu, u64 *raw,
+				struct arm_smmu_event *evt,
+				struct ratelimit_state *rs)
+{
+	if (!__ratelimit(rs))
+		return;
+
+	arm_smmu_dump_raw_event(smmu, raw, evt);
+
+	switch (evt->id) {
+	case EVT_ID_TRANSLATION_FAULT:
+	case EVT_ID_ADDR_SIZE_FAULT:
+	case EVT_ID_ACCESS_FAULT:
+	case EVT_ID_PERMISSION_FAULT:
+		ARM_SMMU_EVT_LOG(smmu->dev, evt,
+				 "\tiova %#llx ipa %#llx\n\t%s | %s | %s | %s | %s%s\n\t%sSTAG: %#x",
+				 evt->iova, evt->ipa, evt->privileged ? "Priv" : "Unpriv",
+				 evt->instruction ? "Inst" : "Data",
+				 evt->read ? "Read" : "Write",
+				 evt->s2 ? "S2" : "S1", event_class_str[evt->class],
+				 evt->class_tt ? (evt->ttrnw ? " | TTD Read" : " | TTD Write") : "",
+				 evt->stall ? "Stall | " : "", evt->stag);
+		break;
+
+	case EVT_ID_STE_FETCH_FAULT:
+	case EVT_ID_CD_FETCH_FAULT:
+	case EVT_ID_VMS_FETCH_FAULT:
+		ARM_SMMU_EVT_LOG(smmu->dev, evt, "\tFetch Address: %#llx", evt->ipa);
+		break;
+
+	default:
+		ARM_SMMU_EVT_LOG(smmu->dev, evt, "");
+	}
+}
+
 static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 {
-	int i, ret;
 	u64 raw_evt[EVTQ_ENT_DWORDS];
 	struct arm_smmu_event evt = {0};
 	struct arm_smmu_device *smmu = dev;
@@ -1847,16 +1940,11 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 	do {
 		while (!queue_remove_raw(q, raw_evt)) {
 
-			arm_smmu_decode_event(raw_evt, &evt);
-			ret = arm_smmu_handle_evt(smmu, &evt);
-			if (!ret || !__ratelimit(&rs))
-				continue;
-
-			dev_info(smmu->dev, "event 0x%02x received:\n", evt.id);
-			for (i = 0; i < EVTQ_ENT_DWORDS; ++i)
-				dev_info(smmu->dev, "\t0x%016llx\n",
-					(unsigned long long)raw_evt[i]);
+			arm_smmu_decode_event(smmu, raw_evt, &evt);
+			if (arm_smmu_handle_evt(smmu, &evt))
+				arm_smmu_dump_event(smmu, raw_evt, &evt, &rs);
 
+			put_device(evt.dev);
 			cond_resched();
 		}
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index abb543d987f6..33bcea7fc03d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -437,10 +437,18 @@ static inline unsigned int arm_smmu_cdtab_l2_idx(unsigned int ssid)
 
 #define EVTQ_0_ID			GENMASK_ULL(7, 0)
 
+#define EVT_ID_BAD_STREAMID_CONFIG	0x02
+#define EVT_ID_STE_FETCH_FAULT		0x03
+#define EVT_ID_BAD_STE_CONFIG		0x04
+#define EVT_ID_STREAM_DISABLED_FAULT	0x06
+#define EVT_ID_BAD_SUBSTREAMID_CONFIG	0x08
+#define EVT_ID_CD_FETCH_FAULT		0x09
+#define EVT_ID_BAD_CD_CONFIG		0x0a
 #define EVT_ID_TRANSLATION_FAULT	0x10
 #define EVT_ID_ADDR_SIZE_FAULT		0x11
 #define EVT_ID_ACCESS_FAULT		0x12
 #define EVT_ID_PERMISSION_FAULT		0x13
+#define EVT_ID_VMS_FETCH_FAULT		0x25
 
 #define EVTQ_0_SSV			(1UL << 11)
 #define EVTQ_0_SSID			GENMASK_ULL(31, 12)
@@ -452,6 +460,7 @@ static inline unsigned int arm_smmu_cdtab_l2_idx(unsigned int ssid)
 #define EVTQ_1_RnW			(1UL << 35)
 #define EVTQ_1_S2			(1UL << 39)
 #define EVTQ_1_CLASS			GENMASK_ULL(41, 40)
+#define EVTQ_1_CLASS_TT			0x01
 #define EVTQ_1_TT_READ			(1UL << 44)
 #define EVTQ_2_ADDR			GENMASK_ULL(63, 0)
 #define EVTQ_3_IPA			GENMASK_ULL(51, 12)
@@ -777,7 +786,9 @@ struct arm_smmu_event {
 					privileged	: 1,
 					instruction	: 1,
 					s2		: 1,
-					read		: 1;
+					read		: 1,
+					ttrnw		: 1,
+					class_tt	: 1;
 	u8				id;
 	u8				class;
 	u16				stag;
@@ -785,6 +796,7 @@ struct arm_smmu_event {
 	u32				ssid;
 	u64				iova;
 	u64				ipa;
+	struct device			*dev;
 };
 
 /* SMMU private data for each master */
-- 
2.47.0.277.g8800431eea-goog

