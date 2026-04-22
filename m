Received: from out203-205-221-245.mail.qq.com (out203-205-221-245.mail.qq.com [203.205.221.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB92F388E40
	for <iommu@lists.linux.dev>; Wed, 22 Apr 2026 09:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776850146; cv=none; b=hllkWSNWBCi9olGzYZWb1yaQYiDx0Zft242TTUTyCaBcuf+rKOxB72DipY6hgM6YhZ/dxQDLwfFyi8nxieqPmK3n2x4J8UmfZcEkEw5N5GcIbR6nThdrcD/CfjXBADnUN4JtqA8ChlORuKn3pYT0gSPqm5w05hACc+/78XOaXYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776850146; c=relaxed/simple;
	bh=5DKj+loyYLzbVp/lVvp0Rz/1T2Z2FcckTEFu+cHbO1o=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=E6QNYNnKKQFgrAmUW4tgoUBiVkJiz4kiPjV1jT5PVUaXemnU+emIZgCXOgWZAp4y8SoDhV9+944JBPgQ9CygcSDCR1bDS7QlQi7MGO/KmGKT84FsWfYuHTEI79c7/EF8vTzjT2yN1GfHLHRZOu4LZ8onFqh7ZAqv9BRdYUEa5d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=hG1d0IPj; arc=none smtp.client-ip=203.205.221.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="hG1d0IPj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1776850135;
	bh=My6EacjSNjmZHU0CTpNvEYFjVGs69rZoNa95xb2tQH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hG1d0IPj/EyGS5LZMAA6yIpL1c8xXk4rWtgLrNGHimeE0qcN5W5sSXpxH5FN5OJn/
	 BZneeaUHe5uQQqh6S20EqP1eFg8Ixf8DGx+ARanhRTYvsM5DUmolan2RIUUpb+ZEbi
	 xEqg9o3FRJIb49u7ANOxUo7srsCc3Y5WwMsC0n4I=
Received: from LAPTOP-LEO.yizhu.local ([61.169.175.90])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id 735968E0; Wed, 22 Apr 2026 17:28:53 +0800
X-QQ-mid: xmsmtpt1776850133tw656rhmy
Message-ID: <tencent_361CADF43F93DCA4D5489881006382FF4006@qq.com>
X-QQ-XMAILINFO: MIoti6gokNxFG89lDdt/Ih6wjJqL2qXZRDgYysB5haN0dSdvhD8KKtT4+mwQ2K
	 s0SsaXzcyN4ptUbs/odxnD+TBA3tSKEMyQ2HInL4H0n9sfmqlbn53bjcJlZM5ad7sjq6+Ev6CxmZ
	 Ozn2c0sXUl5yps02x95b/CrXVubw5B3ZSRrymB+o70of8X9ASlUqUMcZ1aZzX0MWHPR+nvjIv9re
	 wkqC6xFLqlWdOh7mUE90TFnC9IIjTfkCa0fdwNAQKMxD9aamVwUhwbBClWCjiAtrxt8z9zmz3u1N
	 /jauqWukPI7W10c/iu6AQyVrDenlzMIH6VcQKQdAN4WVHQPUm4tiMqwK/pqB1Kc30JDoxVJYrGea
	 qWXEdbidWzLUGiDjU+SureWFBYe8Gj9p5NQ3tcXCVY51ge27/lKos/i02qAWzGvE/hkN3SZ+ZmGL
	 1qghN10rVbZh/ho2ZV71BmTJ3Ax4sJjA3iBwesCUpjbJ3FthON2vYXzYko9ZWMlJTT0NpQLoU7/w
	 G9XDLDwfPlAUT8TZSRZM8U7opKV9pUo3ESLM0xBBJsrBX6shmxjcQuS2Ufp1h8C1UclZMhWsCrhB
	 xw+G2xs3bUP472D7u2Hq/Hd2NyuDbYbnPnEJ7Hc12prmMeNVUgNPXO3yZj2YJmUCykDBkhRFqHil
	 JB59BcO0jh8sGz7yv6ktx9yYzRjDZFE0ZeyiHXhm/9UBmKmzE/1y/AxsIbmBJ/VXlSz0djroXLCb
	 BjKEg0qbr5FEfRJ9laXtLsqvyuj2grcl0w1xglagmO+x+KnK9lZ7Eu36pgj56Za+IBnTbauJ1SIB
	 lO5fknXIwLaSP4sqjbxIxJzbnLlEH5i/WRkEsqEpWNK5Srjuw+cqe1dvfCegrdaZhSYOUqIvVPrH
	 1nEHrXab6y3oQoj6CbNlvOQFmX40ZYX5CcGocEmAqrm4MmlHyFiClaepOCkY3rTzpetirijVlzYZ
	 mqzrnZr3zmTx46MfStKCxIgk1r/vFIYgZkjBIZjVQ1tHqeJFSuvMtPoraNpjQx7OWMLmdwvBNO7F
	 lAxPoQlPIikfX/5MVzqxeCFKKUPIYhVdfnCIZCG2SrRpPtRQT5BhT6cMbXxiaDmfl3pRENh068oq
	 mPKgAvYBo3xQq3h21dTAitDGRuQVRWqAbXeNE7WTQi5NnZnKAK9gd78sLeXlNDcOy1rJxm24cX8T
	 Xzbw2r754Bfl2v3k4VP1YTxN+O
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: Leo Jiang <leo.jiang1224@foxmail.com>
To: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Leo Jiang <leo.jiang1224@foxmail.com>
Subject: [PATCH v2] iommu/arm-smmu-v3: Limit queue allocation retry boundary to PAGE_SIZE
Date: Wed, 22 Apr 2026 17:28:52 +0800
X-OQ-MSGID: <20260422092852.1824220-1-leo.jiang1224@foxmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <tencent_DA99B62735469A0CD219E9FC73E234A47309@qq.com>
References: <tencent_DA99B62735469A0CD219E9FC73E234A47309@qq.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In arm_smmu_init_one_queue(), the driver attempts to allocate the largest
supported queue and retries by halving the size on failure. Currently,
the retry logic allows the allocation to fall below PAGE_SIZE if the
PAGE_SIZE attempt fails.

While dmam_alloc_coherent() can theoretically return allocations smaller
than a page in certain configurations, it is preferable to limit the
retry boundary to PAGE_SIZE for SMMUv3 queues to align with the
original design intent.

This patch ensures the retry loop terminates when qsz reaches PAGE_SIZE,
per the feedback from the maintainer.

Signed-off-by: Leo Jiang <leo.jiang1224@foxmail.com>
---
v2:
- Use real name "Leo Jiang".
- Remove code comments as suggested by Will.
- Limit the queue allocation retry boundary to PAGE_SIZE

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index e8d7dbe495f0..4a0b15b1d4d2 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4418,7 +4418,7 @@ int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
 		qsz = ((1 << q->llq.max_n_shift) * dwords) << 3;
 		q->base = dmam_alloc_coherent(smmu->dev, qsz, &q->base_dma,
 					      GFP_KERNEL);
-		if (q->base || qsz < PAGE_SIZE)
+		if (q->base || qsz <= PAGE_SIZE)
 			break;
 
 		q->llq.max_n_shift--;
-- 
2.34.1

