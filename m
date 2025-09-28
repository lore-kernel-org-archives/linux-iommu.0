Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2011725C81F
	for <iommu@lists.linux.dev>; Sun, 28 Sep 2025 19:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759086466; cv=none; b=beFGdNXtJ07Jrm4bIFdC/sJpZexOkFvn9QQ9PVhGIL1ed7zOPNpJyPpyGhyKiDRe8Fb6GmNaeHel2gZRaTJuVvbWh6iPQ0hhG96L1jph6hUPnhDZ0Tneyx9Yc1t+kJO1p1EPWlWWP20CvR6SdnuHX+jw07miCVvOkFHRznEo5Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759086466; c=relaxed/simple;
	bh=TwkDwodBUCdAT08Dx1368hcmJsMEk9iOzMuO3YTeHgw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pgFpJtv0kzmh7Xg5wgbgJCXYl5aLXY+/SJNCIYtcLyI1QuPNYwlIKAjWv3xH+kxPF1+UXKX+V6MbhPDR87t8gC8tFuE7wt5LoSHi11nPbuk3xU4LrJ5qWMWj1mfe58h1o1gSOpu+Xz3g6rCuHN+GqA4ODv1pzu0o1hpdJbdygwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sr7i81qu; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sr7i81qu"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7810912fc31so3027594b3a.3
        for <iommu@lists.linux.dev>; Sun, 28 Sep 2025 12:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759086464; x=1759691264; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IKcQOPAuV/AfXb11Bbc+ExvF6Mw54uI2kbWY/7dTIhc=;
        b=sr7i81quzx9d5Yt6xdVCGakRn5WIdUMUvBkm3f1/uUIGK95rHfJ0JxOsN76090hZli
         mfaaDsBWZ96qGwSb8/lYuy5EYL/fS+gbZe0phhG9j3udOe+B1Sl17/gqUQPHyTyCjYbv
         Kz0Wep3YUg0mmWHCig07b3CLseSvBlh8FBORYnX+h8YxCMpt5uzU/qWDuSu76DqmZrBd
         Xx8OBPeB/FyqrpBSVli9B2Wkrk5pwWRIRkqWzACmttJFXViIQbOVu/JbbiPTsx0b0b3d
         8rLDnMS/DnW3PtCt+o2nnntm3mxljD00cRhTbCpXOOOEHpKUeJpItVjqc0y9NBOBs337
         nUYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759086464; x=1759691264;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IKcQOPAuV/AfXb11Bbc+ExvF6Mw54uI2kbWY/7dTIhc=;
        b=Vh8pIn5EDyv2d4YtuKhFRFm64XGac8VMQge6QLAwPvz7NNZhpuie6jEHkH4wAyWBMQ
         vzwklPaNxoO9LbXjnrFOMwOdMyDyzkgJ0WHgZQZ6xt3iQ5iUTmKHOcctCsTidk1eWDts
         /U2BIJNH6JWCxw1uiHe/SXMpfRYQmRyWl4loWrWnM8Nm4F4B8NtGQPAs3a9UBf4+28IG
         GfsqZlVMOArAp2TP5Y/kHWrFEwfQsNuME8buCw21cFzuQbJ2oMho584lJaXbjHt25IE2
         K95YnLYMDejpjkWFXjPLIBd/3y+mHest9VXTAbRdpLYZK03c5qsRq+gS9LQVkxj4bntW
         A92Q==
X-Forwarded-Encrypted: i=1; AJvYcCXH22Pdd8j7ViQqS3I/bP1kGbBruVYtHIRQ4mRPP09jDU1baKxc+KzEznuj74/pAlVxOV1USg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwB3erKURNtvh/tjZ4g4A6PJYYqzktlS7qi6hmL/foNOlX/2n5P
	VRH3rjhXHmm9Jp4flObX3rATDLwCB0QYrToNzJDy4zO5hrND7YdZvZlsb4MTgUGqwUuqcMaHAls
	P/ky/b2KBuZYs1g==
X-Google-Smtp-Source: AGHT+IHDYriJ2CM6vbXXafroWapgFfQBlAXQ04VVe+gXkI/tWSYoUN/rx+IsvTB3qwxKgNIrgENnlZqvrAEbqw==
X-Received: from pfwz13.prod.google.com ([2002:a05:6a00:1d8d:b0:781:2040:d72b])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:8cb:b0:77f:efd:829b with SMTP id d2e1a72fcca58-780fceba2ffmr14102660b3a.22.1759086464308;
 Sun, 28 Sep 2025 12:07:44 -0700 (PDT)
Date: Sun, 28 Sep 2025 19:06:10 +0000
In-Reply-To: <20250928190624.3735830-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250928190624.3735830-1-skhawaja@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250928190624.3735830-3-skhawaja@google.com>
Subject: [RFC PATCH 02/15] iommu: Add rw_semaphore to serialize live update state
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

Introduce a rw_semaphore to protect the IOMMU live update state.

When a live update operation (prepare, cancel, etc.) is in progress, the
underlying state of the IOMMU subsystem (e.g., the set of active
hardware units, the state of preserved domains) must not be changed by
concurrent events.

This semaphore acts as a subsystem-wide lock to serialize the LUO
callbacks against any other code path that might modify this state,
such as IOMMU hardware hotplug.

The LUO callbacks take a write lock, as they modify the live update
state. Other code paths should take a read lock to check if a live
update is in progress.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/iommu.c | 4 ++++
 include/linux/iommu.h | 9 +++++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 060ebe330ee1..bfa7c8653720 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2052,6 +2052,10 @@ struct iommu_domain *iommu_paging_domain_alloc_flags(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(iommu_paging_domain_alloc_flags);
 
+#ifdef CONFIG_LIVEUPDATE
+DECLARE_RWSEM(liveupdate_state_rwsem);
+#endif
+
 void iommu_domain_free(struct iommu_domain *domain)
 {
 	switch (domain->cookie_type) {
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index c30d12e16473..d23d078f7c18 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -598,6 +598,15 @@ __iommu_copy_struct_to_user(const struct iommu_user_data *dst_data,
 	__iommu_copy_struct_to_user(user_data, ksrc, data_type, sizeof(*ksrc), \
 				    offsetofend(typeof(*ksrc), min_last))
 
+#ifdef CONFIG_LIVEUPDATE
+extern struct rw_semaphore liveupdate_state_rwsem;
+#define guard_liveupdate_state_read() guard(rwsem_read)(&liveupdate_state_rwsem)
+#define guard_liveupdate_state_write() guard(rwsem_write)(&liveupdate_state_rwsem)
+#else
+#define guard_liveupdate_state_read()
+#define guard_liveupdate_state_write()
+#endif /* CONFIG_LIVEUPDATE */
+
 /**
  * struct iommu_ops - iommu ops and capabilities
  * @capable: check capability
-- 
2.51.0.536.g15c5d4f767-goog

