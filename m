Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E49238C1B
	for <iommu@lists.linux.dev>; Mon, 26 Jan 2026 03:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769397907; cv=none; b=Cwm5KooYDrck5gfP7Q1FNTFP57hvHmkeL/HEooJ6GHPKKjZW+ykeJ/Qru/dzLI2CHSLazW7E+5tlMNealjr7Gmtso3IlDNAONJ3CC7Unwy/ac0wcisPmoXnamJzQ2RBNmzTQajw17S6I9l6oT1qVirqiOjOg1LBMGJpDb5Fpg/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769397907; c=relaxed/simple;
	bh=Wb/1806JX5ZDd+gkPfJCdqC8CXS+470hMV/l2nYk+eM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XO9OFvdC2cv4wrdiTpqXihT4XvwftbX9VpQg1dLPOux1Ajgg2VcwifT0QfrGgkVPeYhNVhWss2NDvWK7AgwmY8uE3nm+JLk/8jdRQF0tc9b2wMRCdXlmolGkG01ttwObrBfei5G2hAWRvV7M+thXwhyDM7BgJgsa3S3xsx/QD6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DYpenhpf; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DYpenhpf"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769397903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OMlaoi7tSt7CVjJxHL+zf/2m1PUPHLUtx7FBZlEPf1c=;
	b=DYpenhpfwEtKYtNaI2nGYZD/7KPKpzBFL8X/SwpIjscicHwGNOsP/HKVB6Jol04RjKThj8
	GqFKppreQUZOVmIXS2kyV5vk2Pdp+/XH5y/CUyuIEeA2tD3mosETIq4JZTVeg+UIFwcm6S
	jaMnOKqU42kZS1YsiToxmioo3gA9r5A=
From: Fushuai Wang <fushuai.wang@linux.dev>
To: jgg@ziepe.ca,
	kevin.tian@intel.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	nicolinc@nvidia.com
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	wangfushuai@baidu.com,
	syzbot+a0c841e02f328005bbcc@syzkaller.appspotmail.com
Subject: [PATCH] iommufd: Initialize batch->kind field in pfn_batch
Date: Mon, 26 Jan 2026 11:24:38 +0800
Message-Id: <20260126032438.63303-1-fushuai.wang@linux.dev>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Fushuai Wang <wangfushuai@baidu.com>

The commit 3114c674401e ("iommufd: Allow MMIO pages in a batch")
added a new 'kind' field to struct pfn_batch but failed to initialize
it.

This leads to KMSAN detecting uninitialized-value usage when
batch->kind is first read in batch_add_pfn_num():
	iopt_pages_unfill_xarray+0x86/0x1660
	iopt_area_remove_access+0x508/0x650

Initialize batch->kind to BATCH_CPU_MEMORY in batch_clear{_array}.

Fixes: 3114c674401e ("iommufd: Allow MMIO pages in a batch")
Reported-by: syzbot+a0c841e02f328005bbcc@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6975b1f4.a00a0220.33ccc7.001f.GAE@google.com/T/
Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
---
 drivers/iommu/iommufd/pages.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index dbe51ecb9a20..064f2cf32cc1 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -289,6 +289,7 @@ static void batch_clear(struct pfn_batch *batch)
 	batch->end = 0;
 	batch->pfns[0] = 0;
 	batch->npfns[0] = 0;
+	batch->kind = BATCH_CPU_MEMORY;
 }
 
 /*
@@ -309,6 +310,7 @@ static void batch_clear_carry(struct pfn_batch *batch, unsigned int keep_pfns)
 			 (batch->npfns[batch->end - 1] - keep_pfns);
 	batch->npfns[0] = keep_pfns;
 	batch->end = 1;
+	batch->kind = BATCH_CPU_MEMORY;
 }
 
 static void batch_skip_carry(struct pfn_batch *batch, unsigned int skip_pfns)
-- 
2.36.1

