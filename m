Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D92537F0E4
	for <iommu@lists.linux.dev>; Mon, 19 Jan 2026 14:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768832574; cv=none; b=BvdPUJZN8sYz9JeByh3EcffsGo1G1Ys3zHWXpqTTYgcjswcLNb9GD+j9EcpGeKX86EkGz3PYOdxgod339fc5X4i0OR7AguhIajS1/dKUNs+DmYvM5IaAOYeKWMsWG5OWSmLcMIuBDyCdDfJb4ARD2+Y4QQbu2WlsrSZg8kxFAHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768832574; c=relaxed/simple;
	bh=zVvQkXwd/3IoS8G7uj5HLDfm5GyLxOaaz04WfzmMwD0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=FvpBGP9YUdj4CVVeFjFR9pn7sl8biJ0cr2aA0CVGV7eHDlCcwS2506pQmG3kUcASPKhUYjP8yoSjZQwSutqolgYs8PJrZQU7RlyZek8ywd+DxcjvbMyCuRiDIWmvN7r6Fpr/C4158hGMeQhYdM0QsAi4kK9If8lHn5RqDfC/JAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2jIyuvyp; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2jIyuvyp"
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-64c62f69defso4527405a12.1
        for <iommu@lists.linux.dev>; Mon, 19 Jan 2026 06:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768832571; x=1769437371; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b8pkyldJ+pGAVMQEprScMwPOOPhYPwuYlRTxB+xChvE=;
        b=2jIyuvyp/ipLbdwLeBam3hS/ZIXF0Y/KFc430LlYHi9xgzXO/Mdf+OKYyD89eipt0f
         LEUrw2BMO6+TwOgBXWJLPkEyppo95YI3CXHtGrmYME9eP6lxzc+7NbvA1corkn6mIV/u
         nSUuJ/jarG3Kb9Nh1okuPPUTygLRyj4myJz5w4ho2IqDN6wwiM1I/tP7pOL3/Wk+pV+U
         U+nsq9qVHdglC5NyCa5EDvI7jxzvisqcpMdYaHZN7OOJduAoyMbYIIgJB2yOG23YKPvL
         XQFyXlElFhIjGYVVWy7hmF/po7me8QucmsevysWJHAMxaycDopQ/OA19qlJ7ldBJUIMR
         HkWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768832571; x=1769437371;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b8pkyldJ+pGAVMQEprScMwPOOPhYPwuYlRTxB+xChvE=;
        b=uxJT41wORWGVRe950WtIRsTQGH9AWiNqQPtcYicizyJ4oSXIC1uhQCI9kamERkZh95
         h5peLyvV/RV4tVAekK0Ok8lbjP7XRvGJoRipJzw8C/C/WNhoeEhlxVeTzUfylTCOmTW+
         vjVeaH56j20cgJVsl6JvdsD/QT63/bnR6diHDIT5n24CuD16b76OfwO+stnFk/8Tmm0G
         Bs3jZMlcyK2/dTLyQR8Bq00NtUxuYo8nsGCFx9WX3lVh+a+j5DKaeGxXWG6qEG0UN/kf
         x4cnwK5rIi7W4nNclDv28Z6j5lR6irmjIZoLcN4nee7L7n4hkHaAXOjSLpW7GAjilAyH
         rLnw==
X-Forwarded-Encrypted: i=1; AJvYcCX5Tmb5pXCdLOiGdveM4uI0Pd1yt2O9h1lrHQirv9SncUDa09kTgET7b9xa3lyJPY+sl0ajpw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzppfjHCLgEvAvvPNcuUJ77v8oTp6OACWBy2M5+2GeMFtRFtvFY
	CuhQmGpX4IL4YaDETAKo4iTvmH73gKCSpWiuqq9fezNS5xhwuf10A09HKfNlvh1JhZEha+GkW4Y
	kBAzDg7fiFw8a9Q==
X-Received: from edwf2.prod.google.com ([2002:a05:6402:1502:b0:650:9d8c:ee30])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:90a:b0:64d:88c:c2ca with SMTP id 4fb4d7f45d1cf-65452bd56f7mr8686719a12.28.1768832570709;
 Mon, 19 Jan 2026 06:22:50 -0800 (PST)
Date: Mon, 19 Jan 2026 14:22:44 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260119142246.3821052-1-smostafa@google.com>
Subject: [PATCH 0/2] iommu: debug-pagealloc: Remove pfn_valid() usage
From: Mostafa Saleh <smostafa@google.com>
To: linux-mm@kvack.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Cc: corbet@lwn.net, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com, mhocko@suse.com, 
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org, 
	xiaqinxin@huawei.com, baolu.lu@linux.intel.com, rdunlap@infradead.org, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

This is a small fix for the new config IOMMU_DEBUG_PAGEALLOC based
on the discussion:
https://lore.kernel.org/linux-iommu/CAFgf54pBAUm3ao-UJksiuGKtvv4wzRyFq_uKwLe0H1ettO4DLQ@mail.gmail.com/

Where it was concluded that pfn_valid() is not enough to validate
physical addresses before access to page_ext.

The first patch introduces a new function in page_ext that takes a
physical address as an argument, and the second patch uses it instead
of calling pfn_valid() and phys_to_page()

Benchmarks with the new implementation can be found in:
https://lore.kernel.org/linux-iommu/20260114164322.787125-1-smostafa@google.com/

This series applies to iommu/core tree.

Mostafa Saleh (2):
  mm/page_ext: Add page_ext_get_phys()
  iommu: debug-pagealloc: Use page_ext_get_phys()

 drivers/iommu/iommu-debug-pagealloc.c | 31 ++++++++++++---------------
 include/linux/page_ext.h              |  6 ++++++
 mm/page_ext.c                         | 23 ++++++++++++++++++++
 3 files changed, 43 insertions(+), 17 deletions(-)

-- 
2.52.0.457.g6b5491de43-goog

