Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A971CFBA
	for <iommu@lists.linux.dev>; Thu, 26 Mar 2026 00:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774483238; cv=none; b=DSmsIazpfH0xgSPrqZmPjB6aC6V8RRz9XwvZph3/wonqutzcrIOZwjkxtVIvy1UCwousdThewq9rSyhKzFFd27cpxonW6Y7USWmJHk4yqHkiw4wXbZDR+5oIjw+o9IxcFhEpSaH8VZDYu1RCHDwALYgU/qLfdd0RxviAsdTVFuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774483238; c=relaxed/simple;
	bh=qwvTL42BDcFULmnKoBMzpNxHK7p1OFM4y03qL6wI3I4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KfN95qWNDB0bdAuy9JwfC4LI/eZ1CqDcl7t3hqiWN8dCQPOs9MFeYA22z7AivQwsxpfw7dhwTDUz0t63qGSfmO6ZEhStfLjiW5V+RPAusQQWOFsqKhEPtjpDhQluIenq3/9OxzWRb7Fp0xkRLAUfeKS8gM+LL603yHaI/bB23NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jXJoegks; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jXJoegks"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2aeab6ff148so23725ad.1
        for <iommu@lists.linux.dev>; Wed, 25 Mar 2026 17:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774483236; x=1775088036; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=egLlHgbzaEDLUh0OxhOmcIu0qYz69gvCFyp0euXVgS0=;
        b=jXJoegkstk20vlS4wk3gscYlv0RjUy4/8IDFkp/KHT5yBD6UGmeTrL8M3aV8ZJdqm1
         CkAzL0udU6evI6aIWXquCKYHPJlirYj/xb7/mEAQDVbZwJkRWtiP2Ysnddq1Cer30q+k
         pMK5Xg7nmwsUcxzQDwzIGsarxINa8pZtYXVwr3LtwZZ+zBFNcXthjAcLoCJe3mgF3eAL
         smMU7ywjTSCqb3kdpBG32iK6qvp6ZRinPoxOdBLvKd/O5fBGYPsJ3OCATQQ450FNrW9x
         uC0K+yF4jY1imbc7z7E4djp4PO4bb25wL2oHC5T2r6MQYVB5X8iq9I4/Gydn2JdpqJIm
         L6UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774483236; x=1775088036;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=egLlHgbzaEDLUh0OxhOmcIu0qYz69gvCFyp0euXVgS0=;
        b=i8dP7m4BcrzqEKzsERiSBL46j23TIEPvOWFyieZtobpdWjxcoDjFGk2wHyQgU3uIri
         6YtTGhjzjyI4xvasJvznON5XUrMRVq6JckVEUwUXvmsUoYAncdRBcEZJQ96tWBtyUbHG
         BJB3OqFYyHPdxcLyTmsZ77Ma1EwD2a/vfdH3bMA6NQ+KF/Yw74IRdZJTSsuJrRJW8W9/
         P/9QrAnfP/DZA2frYESM1fplcTs72GkfsRuxH8qEXuu6t3oyR2I1X4bC4TEMOeQDE0Zr
         m6EmFS867+MNp4VKFhk48U8+/TGM4By0SePpOmmn5KInHpUfnFmKQc5d13GHVjfaANHV
         pQbw==
X-Gm-Message-State: AOJu0Yy81w26DOqQiB9PCGXdc2NAogmTss+KNXK+9T1dKTKDd+c45SiL
	OAgrAwxQb9VLV87YB46nlnsH/+BMU4585xvGknyAjJfZaePs30pI81DlOp1q3vQW2Q==
X-Gm-Gg: ATEYQzw4np5xiHrHxPRUSTwMC0GyKasZNdkNNTlCZNPsK4xV+ihXmzyPOkjLTsEVxsn
	C8zaNU/W39iaIjWO0+FMhMV2H+38BFE0VNuC3rlgRJj2zY4MecUuzxpUFefeVSr+l8bhwbuB1pr
	15ASzOh+y8j2Hfgj97HBVdWEW+wKRkaEY0tTKnYj65xLHx+CUVQnoComAf2mi0nYxWLsNMN8EJs
	nyf9oa9Q2QYYeGxZkJcDpAt5FvBUXziXgkxloMSRZDsW5iZeZkq2v85G6UM4i6iQOflqjq3DY/T
	1wnhmwrfifi34qzEWuuib3vzD6xwwFYJzuogdAkkJ1v6kL0c6FdlNj23RFV1MJ1sN9GIupuOJDS
	rA/d8vLJm3S5n66zTc2TDyYniqWclPx2mk/vDDgkhB+QrqhC1px18CZuDigCNJT6ELfO7WI7QVi
	Cyikuk5//H/KaERFUZDYC5bWAhT+7FTUZYKxcTFH2xP6dWZMsiY4WbaGA/5iQY3g==
X-Received: by 2002:a17:902:fc47:b0:294:ecba:c8e with SMTP id d9443c01a7336-2b0c1156918mr426855ad.3.1774483235172;
        Wed, 25 Mar 2026 17:00:35 -0700 (PDT)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc7b233fsm9973065ad.32.2026.03.25.17.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 17:00:34 -0700 (PDT)
Date: Thu, 26 Mar 2026 00:00:30 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>, 
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
	Ankit Soni <Ankit.Soni@amd.com>, syzbot+453eb7add07c3767adab@syzkaller.appspotmail.com
Subject: Re: [PATCH] iommufd/selftest: Add missing driver_ops for AMDV1 mock
 domain
Message-ID: <acR3ALalHiM02Jt1@google.com>
References: <20260325094615.2420522-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260325094615.2420522-1-praan@google.com>

On Wed, Mar 25, 2026 at 09:46:15AM +0000, Pranjal Shrivastava wrote:
>syzbot found that allocating a mock domain with AMDV1 format could
>cause a WARN_ON because the selftest enabled DYNAMIC_TOP without
>providing the required driver_ops.
>
>Initialize a spinlock (top_lock) and dummy callbacks in the mock
>driver to satisfy the generic PT requirements.
>
>Fixes: dcd6a011a8d5 ("iommupt: Add map_pages op")
>Reported-by: syzbot+453eb7add07c3767adab@syzkaller.appspotmail.com
>Closes: https://lore.kernel.org/all/69c1d50b.a70a0220.3cae05.0001.GAE@google.com/
>Signed-off-by: Pranjal Shrivastava <praan@google.com>
>---
> drivers/iommu/iommufd/selftest.c | 23 +++++++++++++++++++++++
> 1 file changed, 23 insertions(+)
>
>diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
>index 9607416f8069..960c5aee4a09 100644
>--- a/drivers/iommu/iommufd/selftest.c
>+++ b/drivers/iommu/iommufd/selftest.c
>@@ -119,6 +119,7 @@ struct mock_iommu_domain {
> 		struct pt_iommu_amdv1 amdv1;
> 	};
> 	unsigned long flags;
>+	spinlock_t top_lock;
> };
> PT_IOMMU_CHECK_DOMAIN(struct mock_iommu_domain, iommu, domain);
> PT_IOMMU_CHECK_DOMAIN(struct mock_iommu_domain, amdv1.iommu, domain);
>@@ -129,6 +130,26 @@ to_mock_domain(struct iommu_domain *domain)
> 	return container_of(domain, struct mock_iommu_domain, domain);
> }
>
>+static void mock_domain_change_top(struct pt_iommu *iommu_table,
>+				   phys_addr_t top_paddr,
>+				   unsigned int top_level)
>+{
>+	/* The selftest doesn't have real hardware */
>+}
>+
>+static spinlock_t *mock_domain_get_top_lock(struct pt_iommu *iommu_table)
>+{
>+	struct mock_iommu_domain *mock =
>+		container_of(iommu_table, struct mock_iommu_domain, iommu);
>+
>+	return &mock->top_lock;
>+}
>+
>+static const struct pt_iommu_driver_ops mock_driver_ops = {
>+	.change_top = &mock_domain_change_top,
>+	.get_top_lock = &mock_domain_get_top_lock,
>+};
>+
> struct mock_iommu_domain_nested {
> 	struct iommu_domain domain;
> 	struct mock_viommu *mock_viommu;
>@@ -445,6 +466,8 @@ mock_domain_alloc_pgtable(struct device *dev,
> 	if (!mock)
> 		return ERR_PTR(-ENOMEM);
> 	mock->domain.type = IOMMU_DOMAIN_UNMANAGED;
>+	spin_lock_init(&mock->top_lock);
>+	mock->amdv1.iommu.driver_ops = &mock_driver_ops;
>
> 	mock->amdv1.iommu.nid = NUMA_NO_NODE;
>
>-- 
>2.53.0.1018.g2bb0e51243-goog
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
