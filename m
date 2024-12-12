Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DF123D433
	for <iommu@lists.linux.dev>; Thu, 12 Dec 2024 18:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026766; cv=none; b=Tz9PseOtrU5JvkeHBxqGNb/B4kYkAW5qHmQNjgMyvF1oR0Gtdw/TVdD79jdGZh+EGVhsf8/qQNK9bOvWb13X5mi0n1ymR+9hQw7TKHI4Zn5/NccAA271IWwqMzolk9VFvH/i2YlW22EBnJs55KJvlLroas5u0VILY3oC4wGmUlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026766; c=relaxed/simple;
	bh=4pTaI/CYWux8bwQf8488d85bbrFrWoEK4phm9j4oRok=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=E/uKNzYSVxqDe5J5AK9WrVhprhX0M/y+n84FnXVRSVneZlJbJOs4rPAjiQjh+SBcXLKJKfjX3GxOY/ivw4G7WLLYzrjKeqXtDv4dCsVSJ1LtijbR9Xo+/b1Mgvh8aMWPwMV2R9UmIwdVlMLoEp7Fhj+KFQ2jfSXLzb1EIYuWO/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RI0gnKcQ; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RI0gnKcQ"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4361ac607b6so7286475e9.0
        for <iommu@lists.linux.dev>; Thu, 12 Dec 2024 10:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734026763; x=1734631563; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YmBCnVYtGke08HK2kECtnnkNQ3abN9ao4VlCDDt7BzU=;
        b=RI0gnKcQ+B5JYVLKzCffttRYmwplhhxLb1mDxz5NNwJUWNjYydAsuVlUVaQ536WLXv
         srBX+iC+ySk7NtheSPIH6UJ72v/f1pKidUeLji9Jv5ICbv2E9OlZcpsomKUALKsaOnFc
         1bTwFQeby0X6H/tjUkKukqG8a7CRU5Xjg8nJ5brQlC2oVlL3xZ09rgGChYBX3KW2XZDG
         /vvmTRgU/WG2A7pR7N8rnQKGule82M0UZdiy2aYctkPXXWf5LJ8iUO2DQK7ZqjWq6299
         hfB91KE2PzdKTA+uk4ngbLdw+r96TSgHdP18ps6UetX75B+NUjN5R0ZyTvzssr4aXWmu
         n44A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734026763; x=1734631563;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YmBCnVYtGke08HK2kECtnnkNQ3abN9ao4VlCDDt7BzU=;
        b=xLfZF8wLkEKur5ifvvbQEw8YQjltXK7FbUhc+EzBmuANU45vBPeW64sw6BmQAhzaiQ
         7KDd/AFG3YiRrm7oQ/RAkuoz/j0FIP79519Aj0MyAo4Qo8w38IqNQqTAGbri9hOcGsqR
         HF+l9zlWDB2BxsEWKQ5zJSx2uHzeSPeuPlQVfShB24l+6X+knub5S8h7jFdssGy0pgBb
         rsB9w8+kwWgmGXfWRVvQtmGFBCVwYU/kz7ricssYjlNZPaT/MWdO3wb6JPsocjXyL5++
         afZG34bu/FVvCkh1A9XrU6iL+/RO2pSmAx3ZsGFO1V1yen8O7X8zixsqfPRo0D6l4RPH
         HYTA==
X-Gm-Message-State: AOJu0YydH3xHnVdl0s5BW8DfPY0R0feXwXhIfiiQjJdnAuSOf/Rxb28h
	nVr7JXY7Zi6M4zQ/S5rnfHsujVzHtc6TtpOojpKNQc8KxTIjERuftZlYRrsVXK94M+PS4cKZQK+
	KmtH7iLAbInywCadrCHXVh0bOImBYZUh6dww5TO34fPImUW3GQK926GRnY7mfmLRZEas686nx9o
	iKRFsUozdUVr6Jc+wF6b6WiqyiiACxNguBE1BRiy9qow==
X-Google-Smtp-Source: AGHT+IEPQay9Y8CPc4NCAf9wmXyxCMeYXXSRQnwHxxS/TYx9u0H9ZZe4g9YLXll0aeY364hkPCkt35VntGEZQg==
X-Received: from wmma26.prod.google.com ([2002:a05:600c:225a:b0:434:f299:5633])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1c82:b0:434:a815:2b57 with SMTP id 5b1f17b1804b1-4362286399fmr35483095e9.20.1734026763212;
 Thu, 12 Dec 2024 10:06:03 -0800 (PST)
Date: Thu, 12 Dec 2024 18:04:02 +0000
In-Reply-To: <20241212180423.1578358-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20241212180423.1578358-1-smostafa@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241212180423.1578358-39-smostafa@google.com>
Subject: [RFC PATCH v2 38/58] iommu/io-pgtable-arm: Add post table walker callback
From: Mostafa Saleh <smostafa@google.com>
To: iommu@lists.linux.dev, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: catalin.marinas@arm.com, will@kernel.org, maz@kernel.org, 
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, robdclark@gmail.com, joro@8bytes.org, 
	robin.murphy@arm.com, jean-philippe@linaro.org, jgg@ziepe.ca, 
	nicolinc@nvidia.com, vdonnefort@google.com, qperret@google.com, 
	tabba@google.com, danielmentz@google.com, tzukui@google.com, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a callback for postable, this would be used by pKVM to
cleanup tables next.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/io-pgtable-arm-common.c | 15 ++++++++++++++-
 include/linux/io-pgtable-arm.h        |  2 ++
 include/linux/io-pgtable.h            |  2 ++
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/io-pgtable-arm-common.c b/drivers/iommu/io-pgtable-arm-common.c
index 4fc0b03494e3..076240eaec19 100644
--- a/drivers/iommu/io-pgtable-arm-common.c
+++ b/drivers/iommu/io-pgtable-arm-common.c
@@ -523,6 +523,13 @@ static int visit_pgtable_walk(struct io_pgtable_walk_data *walk_data, int lvl,
 	return 0;
 }
 
+static void visit_pgtable_post_table(struct arm_lpae_io_pgtable_walk_data *data,
+				     arm_lpae_iopte *ptep, int lvl)
+{
+	if (data->visit_post_table)
+		data->visit_post_table(data, ptep, lvl);
+}
+
 static int arm_lpae_pgtable_walk(struct io_pgtable_ops *ops, unsigned long iova,
 				 size_t size, struct io_pgtable_walk_common *walker)
 {
@@ -530,6 +537,7 @@ static int arm_lpae_pgtable_walk(struct io_pgtable_ops *ops, unsigned long iova,
 	struct io_pgtable_walk_data walk_data = {
 		.data = walker,
 		.visit = visit_pgtable_walk,
+		.visit_post_table = visit_pgtable_post_table,
 		.addr = iova,
 		.end = iova + size,
 	};
@@ -562,7 +570,12 @@ static int io_pgtable_visit(struct arm_lpae_io_pgtable *data,
 	}
 
 	ptep = iopte_deref(pte, data);
-	return __arm_lpae_iopte_walk(data, walk_data, ptep, lvl + 1);
+	ret = __arm_lpae_iopte_walk(data, walk_data, ptep, lvl + 1);
+
+	if (walk_data->visit_post_table)
+		walk_data->visit_post_table(data, ptep, lvl);
+
+	return ret;
 }
 
 static int __arm_lpae_iopte_walk(struct arm_lpae_io_pgtable *data,
diff --git a/include/linux/io-pgtable-arm.h b/include/linux/io-pgtable-arm.h
index 9e5878c37d78..c00eb0cb7e43 100644
--- a/include/linux/io-pgtable-arm.h
+++ b/include/linux/io-pgtable-arm.h
@@ -21,6 +21,8 @@ struct io_pgtable_walk_data {
 	struct io_pgtable_walk_common	*data;
 	int (*visit)(struct io_pgtable_walk_data *walk_data, int lvl,
 		     arm_lpae_iopte *ptep, size_t size);
+	void (*visit_post_table)(struct arm_lpae_io_pgtable_walk_data *data,
+				 arm_lpae_iopte *ptep, int lvl);
 	unsigned long			flags;
 	u64				addr;
 	const u64			end;
diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index da50e17b0177..86226571cdb8 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -193,6 +193,8 @@ struct arm_lpae_io_pgtable_walk_data {
 	u64 ptes[4];
 	int level;
 	void *cookie;
+	void (*visit_post_table)(struct arm_lpae_io_pgtable_walk_data *data,
+				 arm_lpae_iopte *ptep, int lvl);
 };
 
 /**
-- 
2.47.0.338.g60cca15819-goog

