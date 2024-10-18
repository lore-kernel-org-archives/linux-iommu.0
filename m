Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6B18472
	for <iommu@lists.linux.dev>; Fri, 18 Oct 2024 18:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729274465; cv=none; b=BKDkKIbCJkpKJq7U6xUm1Ir/8KjXV6Rwl2cd1Mfsh4geq8puevdgTG59EUUyuISxOYwegolYf/Cw17L11dL8mlXR9dwnhwrT3QOiqk76VAyzmFSwT55zMINQ6jURH5PkylXDSKT34BB5iaeBnymHmmJzVDpNSSoK9Fb8s5BeXTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729274465; c=relaxed/simple;
	bh=uE3tvppI6cLJ2MagXo+PHfNHb8pG0y52w8hA9ApdSw0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Yu7zb63G93X89fGeWZUCZ13CqIE78/x9eqLOjH8aJn+m78+kLOxn72d7sRK82fhIr51v8kQPcmwzT3Gwh1f9j3HSiYyb+ybNNc/llrEUwlSQy/HlLyxD1WwkyV3SvTyyk6o1TO6sx7834sp15LwHHDPDRMCVDNz5EdyaaiAQ9fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vtXO3xPf; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vtXO3xPf"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e290222fde4so3211783276.1
        for <iommu@lists.linux.dev>; Fri, 18 Oct 2024 11:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729274462; x=1729879262; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=j93LaxvN3cW8w10WefOIVGbr8urMrBiecd7XBLIYz0s=;
        b=vtXO3xPfCD1v0AfAoPrqcISOdlPy+WjBO6gfa6igYosI9UfQ1TXjEQheqpDVXL3/yQ
         MOLKRWHhsNZN+EytPiY4bul/o6eFWSodIGvC1TFzzf3WKjupN7XkpE5ldfze14uMNNcZ
         4J1nsqKyRLBxQKs5+3LJsiDjzfvsryfR/sgKVR4/FYTI2u+s0F4xfAj7GOwgV1JbhqqD
         haqL/NUupjOnF5GIhE9e3jI5wq/uW3I9ItEvwhiJNRTmy5JbNjVZxWWfK3UPE6xXlzUR
         8V8lb06XMpfwuCXydrr01q/KXBkgT2Q0yrpTwkIm0YB1woQvk2RwXHeMWdyGjv1wqDIG
         SidA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729274462; x=1729879262;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j93LaxvN3cW8w10WefOIVGbr8urMrBiecd7XBLIYz0s=;
        b=fEb9dziiZVDX4c5zdMAUk2kOyhLXUfJe2gomZFecgOQoCmIQ9u6uNSZDKcdCXlB5Qk
         Q7z/BsPfp7POEyYfR1TISeffAQtj7QNB9YkABKQAIQBWGOwg37MhB3ANz3XjHKxQvsN9
         58RYfUKOna1ZEfiAM51Re62B/KUc2vrF+Gz8UvAxD9p5neHymwU0i8Sq9R/XS+53YtMQ
         5GoDHt6advMnUYxpmUhnC+P56Jzju7YCdmV1LOj5ONpo5HYM4E5PCOeHMiNPO8/Kijpd
         WkrYRMFAerMxNcmgRbW6XDWPlxc4DplTjiycVGVfaVdTQICZ3o62OS9E2mcvEeWuqLon
         Fdvw==
X-Forwarded-Encrypted: i=1; AJvYcCVymXrXwpPhsFT7uTQkRUaWMIm+K0EzsQXSmPBD6E/ck/IOLLoVqyTPEd1J+WiF78qdGdJNKg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx8d+kd6IuwLV55bVPSQDKJGj8EFyEojZ9vgkdJO9KQIUk852ho
	DlpFfhiX2uXDszjg4FF+/pH2+xZSikyZrD1LZrl8GpqlwankyAXZ1IxFsJqoyhyEN5i8SVx1nw=
	=
X-Google-Smtp-Source: AGHT+IG8Ggfb7jPbkUt6PLwxNz5rW/vyJp47atrjmmKmwXmoGDUki9IT6NVPWNaXKuhyb44onv8yxAm2Rg==
X-Received: from praan.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:3e89])
 (user=praan job=sendgmr) by 2002:a25:abcf:0:b0:e29:6df8:ef58 with SMTP id
 3f1490d57ef6-e2bb12e5045mr7256276.4.1729274462098; Fri, 18 Oct 2024 11:01:02
 -0700 (PDT)
Date: Fri, 18 Oct 2024 18:00:22 +0000
In-Reply-To: <20241018180022.807928-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20241018180022.807928-1-praan@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241018180022.807928-4-praan@google.com>
Subject: [PATCH v4 3/3] iommu/arm-smmu-v3: Avoid redundant master lookup in events
From: Pranjal Shrivastava <praan@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>
Cc: Mostafa Saleh <smostafa@google.com>, Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev, 
	Jason Gunthorpe <jgg@nvidia.com>, Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Remove the call to `arm_smmu_find_master` in `arm_smmu_handle_evt`.

The call was primarily to retrieve `master->dev` ptr for reporting iommu
device faults. Since this info is already available in the `event->dev`
field, we no longer need to lookup the master to fetch the dev pointer.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 4477cf86cb8e..3eebc0856086 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1841,11 +1841,8 @@ static void arm_smmu_dump_event(struct arm_smmu_event *evt, struct ratelimit_sta
 /* IRQ and event handlers */
 static int arm_smmu_handle_evt(struct arm_smmu_event *event)
 {
-	int ret = 0;
 	u32 perm = 0;
-	struct arm_smmu_master *master;
 	struct iopf_fault fault_evt = { };
-	struct arm_smmu_device *smmu = event->smmu;
 	struct iommu_fault *flt = &fault_evt.fault;
 
 	switch (event->id) {
@@ -1885,17 +1882,14 @@ static int arm_smmu_handle_evt(struct arm_smmu_event *event)
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
 
 static void arm_smmu_get_event_from_raw(struct arm_smmu_device *smmu,
-- 
2.47.0.rc1.288.g06298d1525-goog

