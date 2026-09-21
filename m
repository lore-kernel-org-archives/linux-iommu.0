Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EA84963B0
	for <iommu@lists.linux.dev>; Mon, 21 Sep 2026 12:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789993067; cv=none; b=lLxKMpeFYm51Rg+Mi6y9T8WPvdk5H1eN70+urFi4nhDeY1S6WFCZunKSUeIqe4fWOLkdVGPg9AhcFu7N6+dYcKy3Fh2RyBMtpZjAywVTFzJjd3ZZqGZBk9UnLGFXJY2uxuAHWKRH4PWkbiJGzg8pTa77VMrYAP/HomPh0AmFQUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789993067; c=relaxed/simple;
	bh=rzJRF5WmGq7Bxi0zsjCgIoOokhqpSiImWxSiLoJIvJc=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=IcqRBMHtDF1n2tjgCz9+0ZVOTAjQGHAdB3h3qSXKkjhDGy9TcAfvhGHVyZiDpomxZtqWMpM0XyOtNwuwBiwgFaMgUhioRfjYtMymEm9U9J0lbPhbe0/TFue0UKaTZdeebSGjTPCOhihvSffLeF8U/szWu+vyZVv23GByh15V7IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=fSfUq+yI; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="fSfUq+yI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1789993053;
	bh=XavhzQr4VzmWd4Gut7X0rOtPYvCGyPMIEIKU9C9TmK0=;
	h=From:To:Cc:Subject:Date;
	b=fSfUq+yIEXvBtQ6G65u7pVYi9kXRiK2iRJoKa6hJRTd1s2FiG7vb4qEmHYGotRDYx
	 bAKw5AhSEm0U3wXeI9x+3JsOGhT/TZuNqGGS9ZNtYbKaVuIzv7Y9XFyl44hZ9mn0eG
	 /uoC75/9h2G5SiFe+pXz9ucM01qpN6UU0l3pqBwg=
Received: from RE0700.barrietech.com ([183.156.165.242])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 45DB3E18; Mon, 21 Sep 2026 20:17:29 +0800
X-QQ-mid: xmsmtpt1789993049t1yb1seja
Message-ID: <tencent_4392079B5C29406B923C037A7E66DD338005@qq.com>
X-QQ-XMAILINFO: MRMtjO3A6C9X29aUms/wkM2a3TG0IvKdvfY2aRLFDQQl2s8lj9cjBlvjwtb16J
	 KIYuGhAaWx8FZW7rP2C1DFX4lrDvtLuauytgZv25Ficwe+vM2ZSghpJJVXoxSi5bWPa5hennos0C
	 MiCaP/DYKMBdrGy5aXrKZmrabvG+zzNGLe5cr/qfME6QgQYb//isr6OtZ2fTV9JMmVVbZoqr5DO9
	 UxewZUMBlGViwZ7jJ1ZaFlvhs/7V4bV8Qt+DOK38+SClH1JAByUJ3cxuQ+xRY1XvlsmUrTQ3voGf
	 lPwCRx4BzHFbxgP9diF1e2DePgRTvquiirO53MHDrii48KVtcONMQA8WMs5UL396ooL2bDn0ICGd
	 IENHebzaiQyk5Rac0fqnQW/WIP4aeUR84mMK5Xldvn9Vcp6+sSYKydXqCvqEe3CMSEIedSdMHZEH
	 9OpB4HdsD6jWxEy+PxwvYd4mzniHkoXYbt+o2Y+9IbnoxYRLieS9NNPgaEbAS5CwLpVEGpR2DNnr
	 Q5WMo2wqv39+yKC7XoX38x7ezAceVZJfLdzCJ/8HRwEgrBTppd3GIQIrSZ+TQa/FpKam9pFNRUuk
	 NohROcbuSuWkqDh7lu8eufR6z4esQUjET1pmf9K1WpjUk8jIKFHNtS9x+qA71o4ZEMtrw7fmXyAu
	 UTCUPkEyefXB1bzgaQjWsneH0+uZKqYvpGU9ZUwIXZjnFEbf0DfcTC8AG+DqDgcLys9bMlZxJNX9
	 5nYPo0z+fSdoejGh5iY1ZVyP+nZYS8XOXVW3gpYjfPJS9DLK8hoB06dBWrF5HGCcbWiHD2/FordF
	 HwpAB20+Z/cC+xfEMqHz+JNWpY54sYEcLcrObIGBvMxHBUW6mWnrklgkox5m4PuVxHXpLr/CG7YF
	 zGHuuS53itATt1FrKHE6+8mez+G/E13O9NvZqNTr9dZ21t7B3AB6GBLcVWhBo2ELWqRo6KFYJq9n
	 ew3aNqA1jY4mX8lS2KO1DLUM/XvimSTx5bXtW5gR0QkEG08ab7+IO1xq5H7qrHTmmzPIFPzf4Mda
	 69GE/GDCbRBeZO5lwNX27f9rud68Z7N5twfIS/1MnCLBikNmqIum4yH05YLSm7CKYunHfhSeRyEh
	 AlDFSSzUW4SflXa6w=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
From: zhoumin <teczm@foxmail.com>
To: will@kernel.org,
	joro@8bytes.org
Cc: robin.murphy@arm.com,
	jgg@ziepe.ca,
	nicolinc@nvidia.com,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	teczm@foxmail.com,
	stable@vger.kernel.org
Subject: [PATCH] iommu/arm-smmu-v3: Skip unlinked duplicate stream nodes on removal
Date: Mon, 21 Sep 2026 20:17:27 +0800
X-OQ-MSGID: <20260921121727.630136-1-teczm@foxmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A master's firmware stream ID list can contain duplicates, for example
for PCI devices behind an aliasing bridge. arm_smmu_insert_master()
accepts these IDs when the existing stream belongs to the same master,
but does not link the duplicate stream's rb_node into the SID tree.

Both arm_smmu_remove_master() and the insertion error path nevertheless
call rb_erase() for every stream in their respective ranges. Erasing a
zero-initialized, unlinked node can clear the tree root, losing SID to
master mappings for other devices sharing the SMMU and leaving the tree
inconsistent for subsequent operations.

Mark skipped duplicate nodes with RB_CLEAR_NODE() and skip them in both
removal paths. Set the marker after sorting the stream array, since it
contains the node's own address. Keep the stream array and num_streams
unchanged to preserve existing STE, invalidation and single-stream
feature checks.

Fixes: b00d24997a11 ("iommu/arm-smmu-v3: Fix iommu_device_probe bug due to duplicated stream ids")
Cc: stable@vger.kernel.org
Signed-off-by: zhoumin <teczm@foxmail.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 5732f3ba0122..2627d496921e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4141,8 +4141,10 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 					->master;
 
 			/* Bridged PCI devices may end up with duplicated IDs */
-			if (existing_master == master)
+			if (existing_master == master) {
+				RB_CLEAR_NODE(&new_stream->node);
 				continue;
+			}
 
 			dev_warn(master->dev,
 				 "Aliasing StreamID 0x%x (from %s) unsupported, expect DMA to be broken\n",
@@ -4154,7 +4156,8 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 
 	if (ret) {
 		for (i--; i >= 0; i--)
-			rb_erase(&master->streams[i].node, &smmu->streams);
+			if (!RB_EMPTY_NODE(&master->streams[i].node))
+				rb_erase(&master->streams[i].node, &smmu->streams);
 		kfree(master->streams);
 		kfree(master->build_invs);
 	}
@@ -4174,7 +4177,8 @@ static void arm_smmu_remove_master(struct arm_smmu_master *master)
 
 	mutex_lock(&smmu->streams_mutex);
 	for (i = 0; i < fwspec->num_ids; i++)
-		rb_erase(&master->streams[i].node, &smmu->streams);
+		if (!RB_EMPTY_NODE(&master->streams[i].node))
+			rb_erase(&master->streams[i].node, &smmu->streams);
 	mutex_unlock(&smmu->streams_mutex);
 
 	kfree(master->streams);
-- 
2.53.0

