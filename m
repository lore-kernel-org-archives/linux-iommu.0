Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A268F26C3BD
	for <iommu@lists.linux.dev>; Sun, 28 Sep 2025 19:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759086477; cv=none; b=bSjrv+r9dRorw8LCw3PjW7ynTx+vsKzXwqlIrX5v7BVcAI8iGMp6sFxjwuD80THaA9wlWu9xnM8/KAm5Vt7B23shZguWvtLBSvp2K91lSBIkZhKF+ss70AmYtLJ0e5V1jBV7EnkS3VO1S+Hucwr84bGXsd/urStDoJPrv4PPb6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759086477; c=relaxed/simple;
	bh=jkmwgnL7BhvDTNRmHeg8Vg8AsLanY9NZX4iIKwYAEYk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qxxTmiHONPOj78/zPuHBCKIccipkOE3a0DMkFN87oQMEOKSUuHAKnG7nY3NExzLi9jn5YQwm6ersWKVGIJ1N6avpt722Ysq6Z4Iy032Jlo760sn7RpdtMFPQ7RvM59Jggca+xdic9bsXDGcQHhulq3cKsixi6+fPiazDJHIrC2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=layp7VZ0; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="layp7VZ0"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-780fdbbdd20so4103222b3a.1
        for <iommu@lists.linux.dev>; Sun, 28 Sep 2025 12:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759086475; x=1759691275; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ucXCpHZHap8YpvFOrTnapJK/l5FI9kkW9aB4eroyCmw=;
        b=layp7VZ0XY6CmevqfThEWCEkxuxL0tNMI/j98nvHQcz5jcAiba0Dtsu8F1TW5Tma0H
         lqRVVaYwT/vkuH5+4j9uMfv0B/hm9aOTMU3I0GNAzzATf2mWdZWY28myKxjObIvfdINF
         933zJ+OhT/3ZGDEe1M6USUbqZfqZcvM9Oeh5t3MOk6BfETEAEPuuTduxDi9VaPOZ90Lz
         NfcTwi4xdy790EqAo7mVSj9JDN0A6fQXJtz4xyPdXEBGbM0Y0HAL+078wGb1UkPWXJ7o
         5swN9EpVG8KKs3WOGiCW12y7rjYDyT1bM3yeu5r+MUMFiZH1uZ5I3Jx5mGlWfFu0c7hM
         bk2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759086475; x=1759691275;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ucXCpHZHap8YpvFOrTnapJK/l5FI9kkW9aB4eroyCmw=;
        b=tqBpdRCbtWQy1mj1BYDr2v2fsCyOnuHlXAvHMF2LdOl2/PYsQzkF+mTTXUR01+flFU
         GroTVFnqMLRL3ciaU8Xrp+He47QTJCAaXCabYS5Ii3Jv/F0GVrZ75Gsxv/eYH+xEw+sh
         xaZt1vaoKWqM3WCZ4rBofZaHRSzZF/fUvkUavJZNM+uGSV4FPm1MRpJ36P4yzIJG4iZA
         JnHWISXrVmTeCQgzsW6iTebR/NTqFfGEPm7ZQS1bRB2cleE6iHsHOy1ofGIG70gsvVR4
         AroQ8e9O4nbgZRy2DI/5sOANKYEU27JpMeFtnkag7b2xU0Bjn6H4mNBAExV07JLwyfIQ
         6lew==
X-Forwarded-Encrypted: i=1; AJvYcCVOZeXWBD9HyWmzQxDI8ajGQDJcaxIycuLrmp33MEuhLHNNuAeozO8RG599vm50AsfFZNiBeA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxUu116lB2pGpP02WoMrBlOAPgEAWL7u8dv4v3U9lJCdBpO5YOK
	THlowXz4OPvYmWTuVYbyh0aF+VkWiG6i8+0qbqOwrD5PjjwtYoR0L9H9IimBIlYo/UV8bvhHczK
	XUGgBNQxxu4mGRg==
X-Google-Smtp-Source: AGHT+IHCtCjCjURftUd42BI8Xn94s+m6l5b6UgXQA8KkQXHy6gXqsx21JjwsoB3Xl8hB9g8pCQfv/F4XvBfXyg==
X-Received: from pfbhk3.prod.google.com ([2002:a05:6a00:8783:b0:781:65e:cee5])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:240d:b0:76e:885a:c32c with SMTP id d2e1a72fcca58-780fceda55bmr14907781b3a.26.1759086474819;
 Sun, 28 Sep 2025 12:07:54 -0700 (PDT)
Date: Sun, 28 Sep 2025 19:06:17 +0000
In-Reply-To: <20250928190624.3735830-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250928190624.3735830-1-skhawaja@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250928190624.3735830-10-skhawaja@google.com>
Subject: [RFC PATCH 09/15] iommu/vt-d: Add live update freeze callback
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev
Cc: Samiullah Khawaja <skhawaja@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com, zhuyifei@google.com, 
	Chris Li <chrisl@kernel.org>, praan@google.com
Content-Type: text/plain; charset="UTF-8"

The iommu_ser needs to be updated during freeze to set the physical
address of the iommu_units and devices array as the virtual addresses
will not be valid after kexec in the next kernel.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/intel/liveupdate.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/iommu/intel/liveupdate.c b/drivers/iommu/intel/liveupdate.c
index fb214736aa3c..a7d9b07aaada 100644
--- a/drivers/iommu/intel/liveupdate.c
+++ b/drivers/iommu/intel/liveupdate.c
@@ -258,10 +258,21 @@ static void intel_liveupdate_finish(struct liveupdate_subsystem *handle, u64 dat
 	pr_warn("Not implemented\n");
 }
 
+static int intel_liveupdate_freeze(struct liveupdate_subsystem *handle, u64 *data)
+{
+	struct iommu_ser *ser = __va(*data);
+
+	ser->iommu_units_phys = __pa(ser->iommu_units);
+	ser->devices_phys = __pa(ser->devices);
+
+	return 0;
+}
+
 static struct liveupdate_subsystem_ops intel_liveupdate_subsystem_ops = {
 	.prepare = intel_liveupdate_prepare,
 	.finish = intel_liveupdate_finish,
 	.cancel = intel_liveupdate_cancel,
+	.freeze = intel_liveupdate_freeze,
 };
 
 static struct liveupdate_subsystem intel_liveupdate_subsystem = {
-- 
2.51.0.536.g15c5d4f767-goog

