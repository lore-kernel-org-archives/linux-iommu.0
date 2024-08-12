Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CA419AD8E
	for <iommu@lists.linux.dev>; Mon, 12 Aug 2024 20:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723495997; cv=none; b=lknNtKZ+0yGeSj+kF8BeUgzK7ggmpMU8gD5Z463msj7CGFrFaqELwVhwxlFXy9sqavxjVx5PDNjeyCa7JXhO4GH1YEzPyuPSasov42EF5/Y4wjMxWpL/dkjzD3Y3Nbg7WJsoOpIoZj6YKYqTEJGgO8TlxqWvnwmg+vLuJcDoVKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723495997; c=relaxed/simple;
	bh=TeYbM+CVhzHcQNp4eQLi3mHUQ9ETw2IglY5kCOkU/q4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Jqs42VIbzGuQ+o12RWx3r8dvNF6QhVGYLJi3jRaBHjov+a/eoZ/S3G6b2Wj8jV2srgApm+IrYW7HhWHJZvcDx3Z6+g7BlZydBK2H4D+dHPJITFlp40KewSYEiv3DU9Vp4qQoZckkp9gVwDCgSQ2I5fe+9Hth0ObSUR/eQ0vYB4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=waFM1L3J; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="waFM1L3J"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-690404fd230so100627247b3.3
        for <iommu@lists.linux.dev>; Mon, 12 Aug 2024 13:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723495994; x=1724100794; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DuUqrCWF/xHWcFuXKlPjIWucc9/NhZLN0OsUooYWUjg=;
        b=waFM1L3JizgMto1XNwWlSpD7DtwdJJRHgothw34TvfhXZR0FIUZzYI57+FwdmCzLGs
         2b+wAZbsfm3RQ2Pqqxe2YxwWLdNoVF2oxtQrXmxg5GlCdSqhfzcUgvDBLVU3+W/Ijmz/
         A6yIlAL7J4A0tqU65l9+ZIzEILMNbJqdYKTVOPLA5XzdmsCdJRZPZVksU3U9tgl6yHHH
         W+0baX8Z1bBRfpDAhrxD0Lr07vEWcIBReqXlrs+2omjXc9FzQZLAPfWO6lqIAC0MutS8
         4r2FnhA4TB0kC8ua74t78qUHW7TJjGUk35R33VAZCa6xbfibWQk3Ps+q9KAamfsjDw/r
         cdmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723495994; x=1724100794;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DuUqrCWF/xHWcFuXKlPjIWucc9/NhZLN0OsUooYWUjg=;
        b=POeF1OoEWYiAN0Ig8hLQFdlATwyIHY4KMVX3GxbaOfqCIKVRyKVC/QWWaL52evvIh3
         U7/MypyX/HKyft5hcDgHTwRnAp13RbBox3bcEytq8k0J7K2T6MATpSxzDQ5JY54cgr9D
         uLNcprss47huTccLHeEfFg4sedlO+aNZDqL6wdX1aPazKk5Y1tQbphns9cbC5QcRDoHN
         ZkgMt2nobrdUHIyeQ49t16sDQiuWcoIdbEmgUi+EKDKA51stAfS8QwUL9eMaU2ilV6XN
         /sGr8/dgR/CIq2nvzKOLFHoNPEv4JbGNohWAGMJic+d1OCSvctktKmEKdRgbi1DWFvXN
         zulw==
X-Forwarded-Encrypted: i=1; AJvYcCVSdJVM0WJyMwI1jh6dEORAbbvTF9nZjAX9GdN4yCcfPGO1tXm2UsOTgcXbdOj6oH5rTqkm4i/rSWD0Dp+pl4q4NxNBhmY=
X-Gm-Message-State: AOJu0YykfCtgwdkJ8gVd42AcA4DohXTokWmgVVeJNy8G6fTZ2L4B4MnK
	JarT784ue14kh2NmRF2O82ZBY1ko5+UD5CTVncBQRsmoJxWDALDwf9p9sZKkBp5F+aZGdfUszvl
	ASAzUOsXuwg==
X-Google-Smtp-Source: AGHT+IENy8kvftAeMsPnXaFLGnElxbpTX8pP3lf5fKRnJiwZqy3MmYbMOT7IN0Eau0daUlvYKEg/llpPkpn9+g==
X-Received: from mostafa.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a25:aa46:0:b0:e0b:d229:af01 with SMTP id
 3f1490d57ef6-e113ce919bdmr1758276.6.1723495994572; Mon, 12 Aug 2024 13:53:14
 -0700 (PDT)
Date: Mon, 12 Aug 2024 20:52:55 +0000
In-Reply-To: <20240812205255.97781-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240812205255.97781-1-smostafa@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240812205255.97781-3-smostafa@google.com>
Subject: [PATCH 2/2] iommu/arm-smmu-v3: Report stalled S2 events
From: Mostafa Saleh <smostafa@google.com>
To: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, will@kernel.org, robin.murphy@arm.com, 
	joro@8bytes.org
Cc: jgg@ziepe.ca, nicolinc@nvidia.com, mshavit@google.com, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

Previously, S2 stall was disabled and in case there was an event it
wouldn't be reported on the assumption that it's always pinned  by VFIO.

However, now since we can enable stall, devices that use S2 outside
VFIO should be able to report the stalls similar to S1.

Also, to keep the old behaviour were S2 events from nested domains were
not reported as they are pinned (from VFIO) add a new flag to track this.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 18 +++++++++++++-----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  2 ++
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 8d573d9ca93c..ffa865529d73 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1733,6 +1733,7 @@ static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
 	u32 sid = FIELD_GET(EVTQ_0_SID, evt[0]);
 	struct iopf_fault fault_evt = { };
 	struct iommu_fault *flt = &fault_evt.fault;
+	struct arm_smmu_domain *smmu_domain;
 
 	switch (FIELD_GET(EVTQ_0_ID, evt[0])) {
 	case EVT_ID_TRANSLATION_FAULT:
@@ -1744,10 +1745,6 @@ static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
 		return -EOPNOTSUPP;
 	}
 
-	/* Stage-2 is always pinned at the moment */
-	if (evt[1] & EVTQ_1_S2)
-		return -EFAULT;
-
 	if (!(evt[1] & EVTQ_1_STALL))
 		return -EOPNOTSUPP;
 
@@ -1782,6 +1779,15 @@ static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
 		goto out_unlock;
 	}
 
+	/* It is guaranteed that smmu_domain exists as EVTQ_1_STALL is checked. */
+	smmu_domain = to_smmu_domain(iommu_get_domain_for_dev(master->dev));
+
+	/* nesting domain is always pinned at the moment */
+	if (smmu_domain->enable_nesting) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
 	iommu_report_device_fault(master->dev, &fault_evt);
 out_unlock:
 	mutex_unlock(&smmu->streams_mutex);
@@ -3373,8 +3379,10 @@ static int arm_smmu_enable_nesting(struct iommu_domain *domain)
 	mutex_lock(&smmu_domain->init_mutex);
 	if (smmu_domain->smmu)
 		ret = -EPERM;
-	else
+	else {
 		smmu_domain->stage = ARM_SMMU_DOMAIN_S2;
+		smmu_domain->enable_nesting = true;
+	}
 	mutex_unlock(&smmu_domain->init_mutex);
 
 	return ret;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 0dc7ad43c64c..f66efeec2cf8 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -745,6 +745,8 @@ struct arm_smmu_domain {
 	spinlock_t			devices_lock;
 
 	struct mmu_notifier		mmu_notifier;
+
+	bool				enable_nesting;
 };
 
 /* The following are exposed for testing purposes. */
-- 
2.46.0.76.ge559c4bf1a-goog

