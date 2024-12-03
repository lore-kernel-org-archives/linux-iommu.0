Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4631F6694
	for <iommu@lists.linux.dev>; Tue,  3 Dec 2024 18:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733251766; cv=none; b=mfI1bnY/Dmwl8prsr8npEQaK85+OeOS/pZ9McHukHmGC6etARCLI16O+atTleu/ZAGIzZF7zZTWTSsGuFj+BCyqeXT+4DkDMetYrfCwt2BK0TSaVCdaXQyPJ38UZQJvHkXD9/O6d3GtoQGwFYIZY5iMQOuOuXax/jYtlUnlSdTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733251766; c=relaxed/simple;
	bh=o2NlwM2yFbdxJCCdHRL1TC/2BzTfFZfHk8D7+A6P4T4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=roNu/8mMFfKBzQUy+MzIS9ZbROD2cci78veLUH4T4gbCij1Uwn+iQHi/9wdciDWHdCrZEcmCDAvCeDIFoyT+g00estXtcEpY6V6/iQMA9YGtjFa9pJi7Y61rgl9YeXF0Aa8U82SIAaXF2E50qJsdNLEO61xRkGKK2+zSA07+SWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cs/XUDFB; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cs/XUDFB"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7c6b192a39bso3982614a12.2
        for <iommu@lists.linux.dev>; Tue, 03 Dec 2024 10:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733251764; x=1733856564; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fg27t8E8/YTsGSvGelUyy0z5wa3foU/saDBYGOZ/otI=;
        b=Cs/XUDFBbW13cmduOD0VnG1iasp+qK4lW29lYNRlnJ42gzkVAp7KvmlZ1E2HCHioEE
         K8jX0tASAnK9RiqEatzEtv6yrhoVWmodzqBx0eTEC4+OghfjaGiOLXgQ69LkhcO08ig+
         YR9fvD9VK+Ddw+yIiJ9/hXK2sR1wtKLKS3VLKIR9eAnOMEOfr2hxIkHqdD0ujkUDVNQ3
         Hg579ypmg3x7oyAX/03R5mkBihbKX353ItGcfotivZJvNs3V40cm/AKghQo7foY22XAT
         +C5QBZuFs/6FHwWBH/s3+ldJAOiV9BBVTX+hTDttGEuZbHhvujuh8sfTF6Z63R95zOAd
         6GZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733251764; x=1733856564;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fg27t8E8/YTsGSvGelUyy0z5wa3foU/saDBYGOZ/otI=;
        b=czbPExpgosxT18uWqwpWuKj3KgX/BT2ty68gDJkw2UAw2z5xEFltKXcRHUPjiqxnoz
         AlZ/BZ5l+0lYesrjF9qPtcUeGqN5HFxU8h2PME8DN7p5dZ9MaGHa0rDH+sAWVkcS/z0u
         PiCQo8SWityp59ry1rzRIR5yDNiM0xASOUMiHXivv9Ly0brCUYfqu3fSDbnmjg1KNIfh
         b6vpewbCgRivyqXe4rkO7iFGI93QN4U72BUzIAnpLWf611aEcLavm+n//kobCjFOm78n
         aHes+2reJvL00sk9z+Dvgdv8jMq3qsgiDvb2u41pog3tV1R5Q6MiQGQBWyTCkKTwsk/U
         KIzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJsKfeBwtakk5cWrDPJVipir61z9wQIYp1dYHcWpSgARxWUWiiMluTfewP3d4mMmiotCNlhA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyIYTOuYOotXJw+ABXOztVQR6EQ3fuxLGxhgot2MTVsE4rvsF50
	Bz90U7fAwKvG/hpnCDKXwZgUYvKRFLUxPcOlKPgK0BZM1Mx/f1O5Aq3c5o0vKxhjBs/XD0lAaw=
	=
X-Google-Smtp-Source: AGHT+IHBk4Mhx+Lz6pTLoep3LmJoY5ePzSYd1mNIJwn5RbOVIX6A9Sus9ktbzmnbFi70ULppqMZSiRD7hQ==
X-Received: from pjbsx5.prod.google.com ([2002:a17:90b:2cc5:b0:2ea:22cd:7ff1])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a0a:b0:2ee:d433:7c50
 with SMTP id 98e67ed59e1d1-2ef0125b2aemr4533427a91.23.1733251763703; Tue, 03
 Dec 2024 10:49:23 -0800 (PST)
Date: Tue,  3 Dec 2024 18:49:06 +0000
In-Reply-To: <20241203184906.2264528-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20241203184906.2264528-1-praan@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241203184906.2264528-3-praan@google.com>
Subject: [PATCH v6 2/2] iommu/arm-smmu-v3: Log better event records
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
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 114 +++++++++++++++++---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  14 ++-
 2 files changed, 115 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 3168bb31e145..22b6ed5992cb 100644
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
+	[2] = "Input address caused fault",
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
 	event->ssv = FIELD_GET(EVTQ_0_SSV, raw[0]);
@@ -1773,9 +1798,21 @@ static void arm_smmu_decode_event(u64 *raw, struct arm_smmu_event *event)
 	event->iova = FIELD_GET(EVTQ_2_ADDR, raw[2]);
 	event->ipa = raw[3] & EVTQ_3_IPA;
 	event->fetch_addr = raw[3] & EVTQ_3_FETCH_ADDR;
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
 
-static int arm_smmu_handle_evt(struct arm_smmu_device *smmu,
+static int arm_smmu_handle_event(struct arm_smmu_device *smmu,
 			       struct arm_smmu_event *event)
 {
 	int ret = 0;
@@ -1834,9 +1871,67 @@ static int arm_smmu_handle_evt(struct arm_smmu_device *smmu,
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
+		dev_err(smmu->dev, "event: %s client: %s sid: %#x ssid: %#x iova: %#llx ipa: %#llx",
+			ARM_SMMU_LOG_EVT_STR(evt), ARM_SMMU_LOG_CLIENT(evt),
+			evt->sid, evt->ssid, evt->iova, evt->ipa);
+
+		dev_err(smmu->dev, "%s %s %s %s \"%s\"%s%s stag: %#x",
+			evt->privileged ? "priv" : "unpriv",
+			evt->instruction ? "inst" : "data",
+			evt->read ? "read" : "write",
+			evt->s2 ? "s2" : "s1", event_class_str[evt->class],
+			evt->class_tt ? (evt->ttrnw ? " ttd_read" : " ttd_write") : "",
+			evt->stall ? " stall" : "", evt->stag);
+
+		break;
+
+	case EVT_ID_STE_FETCH_FAULT:
+	case EVT_ID_CD_FETCH_FAULT:
+	case EVT_ID_VMS_FETCH_FAULT:
+		dev_err(smmu->dev, "event: %s client: %s sid: %#x ssid: %#x fetch_addr: %#llx",
+			ARM_SMMU_LOG_EVT_STR(evt), ARM_SMMU_LOG_CLIENT(evt),
+			evt->sid, evt->ssid, evt->fetch_addr);
+
+		break;
+
+	default:
+		dev_err(smmu->dev, "event: %s client: %s sid: %#x ssid: %#x",
+			ARM_SMMU_LOG_EVT_STR(evt), ARM_SMMU_LOG_CLIENT(evt),
+			evt->sid, evt->ssid);
+	}
+}
+
 static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 {
-	int i, ret;
 	u64 evt[EVTQ_ENT_DWORDS];
 	struct arm_smmu_event event = {0};
 	struct arm_smmu_device *smmu = dev;
@@ -1847,16 +1942,11 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 
 	do {
 		while (!queue_remove_raw(q, evt)) {
-			arm_smmu_decode_event(evt, &event);
-			ret = arm_smmu_handle_evt(smmu, &event);
-			if (!ret || !__ratelimit(&rs))
-				continue;
-
-			dev_info(smmu->dev, "event 0x%02x received:\n", event.id);
-			for (i = 0; i < EVTQ_ENT_DWORDS; ++i)
-				dev_info(smmu->dev, "\t0x%016llx\n",
-					 (unsigned long long)evt[i]);
+			arm_smmu_decode_event(smmu, evt, &event);
+			if (arm_smmu_handle_event(smmu, &event))
+				arm_smmu_dump_event(smmu, evt, &event, &rs);
 
+			put_device(event.dev);
 			cond_resched();
 		}
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 89fe2eee5856..0eda9d6d99e7 100644
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
@@ -778,7 +787,9 @@ struct arm_smmu_event {
 					privileged : 1,
 					instruction : 1,
 					s2 : 1,
-					read : 1;
+					read : 1,
+					ttrnw : 1,
+					class_tt : 1;
 	u8				id;
 	u8				class;
 	u16				stag;
@@ -787,6 +798,7 @@ struct arm_smmu_event {
 	u64				iova;
 	u64				ipa;
 	u64				fetch_addr;
+	struct device			*dev;
 };
 
 /* SMMU private data for each master */
-- 
2.47.0.338.g60cca15819-goog

