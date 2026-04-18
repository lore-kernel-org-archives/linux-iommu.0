Received: from out203-205-221-191.mail.qq.com (out203-205-221-191.mail.qq.com [203.205.221.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E4B33F589
	for <iommu@lists.linux.dev>; Sat, 18 Apr 2026 05:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776490331; cv=none; b=kJxq+5b+hDmKs7xgxzgJhxq2vU/3zVc4ofzrS0nvRIxXmRbjQ96AZ/72Ij9mQ8VvHYcxM9NZkU9bkdiBEgMPnTFUdoE+ntbqSC/Zz1L4pfJPYIGG6P5DuwmT+UfxPaGpC2ZxAfG9ftgJllyzyRPnot1i4sLujnPu86XhvwKRS20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776490331; c=relaxed/simple;
	bh=hLUZWCpzrQPlve3BmbqzjBUv7G3XjzcJ3CaCIQoDRvM=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=M1GpFqFBGrmstqbz7CYJPM35ZxMH83Rbbb/4tYJxi9U0cbHQ/mwWDynYKqddcJV0dhO8+rUWHxXglH1h+7CLkEeqdGjpRuIx+1Ga9fgY2PPXA3SuAfVRAUJuIS7/MRy3jr+RUDtWiZ+bFd+ZlANOljiULcuov4+ID0fKMQHU1zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=Q5LRrIG0; arc=none smtp.client-ip=203.205.221.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="Q5LRrIG0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1776490318;
	bh=LdrA3t6CKBZ6X0V7Cw36ls6aaMYWbmXBN3bXm4X4X7k=;
	h=From:To:Cc:Subject:Date;
	b=Q5LRrIG01ub5uM1CVFpaP7FAg6Rw1AZCWKlHX11rD2ZZxNj+jLFB0I5ZBCD1cwD9x
	 Jxg3qR3RlQD16yS9oXvu16amL+LHhwVF9YoknDO4A4MSpQEWncly/7NWmMteAx+g5W
	 M/SZeSOGcXGYHMeHccMaGhsv15WHw9S/MgEblABs=
Received: from LAPTOP-P7BTVCHO.localdomain ([139.226.117.101])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 7F7AB6F5; Sat, 18 Apr 2026 13:31:55 +0800
X-QQ-mid: xmsmtpt1776490315tkgb75b7n
Message-ID: <tencent_F6E384A40D990A279B460A0CDE1927FDF509@qq.com>
X-QQ-XMAILINFO: MjYvZRNXAeJ25d95iAtKQZf3C0ExXzZ1i0gnEKyxm1V6xRD0sB01FGsAFyfH9g
	 KzUNLG3t03F/3P9HzZdQxabE26gbbh3uPlZoeYruRowKZz0rOQ3dRQmLkliVLYQAvI8qbmEi4GJg
	 vZeR0J+o74er4xVgNWdLyVC9X52YT/F8ZKH/CQOa+SQw36fwY+Nv4LtlHJFNxtdoTzWvay8yk0mZ
	 B9Y55K8qVbpSJp5lTWWfR9tWzmPSC8lYmnEdRRXDlc+NZnzhkGgrpLhNsvciKQzuWgdkpFrAiDpz
	 b6Z3VwTrLGGmsA0k8OifW6XutuqudsvaqNvyl4kGr0hrjgZm/ALVlRN2Naxgn1fTHjpXH5wqeEel
	 cwQ/aoao3S2zBOXE1knBfyUbrrXotcBddI45AZSsGUnCAWPVtxd6KjscnGdPYZCWnOPSiYGEGODl
	 F9Aq8d82+5y65TsSt+PyA1hYEHaydEwnVMV1MSkhxz7o0LXW+WExELZFvpQ196FPR+2Yu+y6h/eJ
	 utwA9IwOVqP8p1LVGS6OAkeo+CwNwN/KorAccULi73wvS5l9v9uvReOuAiVWTH9AzIqr5/XP4acl
	 A08N1ukRIg+pXvKI5rh0zAAxftpLbkiIKV+9Nz5skxi67yNtysqmokATKAH/DjurWMrr53wzrnyB
	 ZHr8lC1QH/kO6dADlAsW2oGY9McUnKUNBuFThQymG3V9xTL30zj9pr4O3pzYMDebQFcK/hRGMX+B
	 fvnLa49at/Yo2eyUBzZyhKIbDE1OnSBm3Wala/q/9+fw7A+yqfnCNmxIllB654Dga14rwGyj5OQZ
	 cjv4q7KHv8ZZYljSnQ5DwvoE2BYTDTc9sy2WNo+QbOEgZBDt7e9ZCbglqgATxnW2Kj68IAeboEmf
	 endak0IcMcczHLBCgyi4ZI+qv9PHFJFKO0XgspwEnJPi59bWVvfU1O5hMS9hr5UeFUJcRt+eLLo7
	 5mNeeSkrl0QB6hBfO+ooRVQxSUOa8Xy6S7ACYmlscApaTLDhTA8fdIdFAfl+VaN+RnLYCmYC4D5I
	 ww68xyJibIMpsJ3c0m6Sw5ggUNA95WRN/xqWatHeIORhohTMfqVHuaRDm0lS/AZN99S/vPjE7lzm
	 Dwe+/gq9Tqe3l5mUSbzvV+4wRpEBGHy0T7UVz7K5YY5802VVgxSVmk5KIdeaTZFmpBgdSk
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: leo.jiang1224@foxmail.com
To: will@kernel.org
Cc: robin.murphy@arm.com,
	joro@8bytes.org,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	LoserJL <leo.jiang1224@foxmail.com>
Subject: [PATCH] iommu/arm-smmu-v3: Stop queue allocation retry at PAGE_SIZE
Date: Sat, 18 Apr 2026 13:31:43 +0800
X-OQ-MSGID: <20260418053143.27878-1-leo.jiang1224@foxmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: LoserJL <leo.jiang1224@foxmail.com>

In arm_smmu_init_one_queue(), the loop reduces max_n_shift if
dmam_alloc_coherent() fails. However, since dmam_alloc_coherent()
allocates at least PAGE_SIZE, retrying with a smaller size after
a PAGE_SIZE failure is logically redundant.

Moreover, if a sub-page retry were to succeed due to concurrent memory
release, the hardware would be configured with a smaller queue depth
despite a full page being allocated. This leads to inefficient memory
usage and unnecessary hardware performance limitation.

Terminate the loop once qsz reaches PAGE_SIZE to ensure logical
consistency and optimal hardware configuration.

Signed-off-by: LoserJL <leo.jiang1224@foxmail.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index e8d7dbe495f0..e0ec118ff560 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4418,7 +4418,14 @@ int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
 		qsz = ((1 << q->llq.max_n_shift) * dwords) << 3;
 		q->base = dmam_alloc_coherent(smmu->dev, qsz, &q->base_dma,
 					      GFP_KERNEL);
-		if (q->base || qsz < PAGE_SIZE)
+		/*
+		 * If allocation succeeds, we're done. If it fails, only retry
+		 * if the requested size is still larger than a page. Since
+		 * dmam_alloc_coherent() allocates at least PAGE_SIZE, retrying
+		 * with a sub-page size is logically redundant and could lead
+		 * to sub-optimal hardware configuration.
+		 */
+		if (q->base || qsz <= PAGE_SIZE)
 			break;
 
 		q->llq.max_n_shift--;
-- 
2.43.0

