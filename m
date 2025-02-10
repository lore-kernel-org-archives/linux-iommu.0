Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2456D25C6E5
	for <iommu@lists.linux.dev>; Mon, 10 Feb 2025 19:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739216425; cv=none; b=sQVdYChQssleMSR6HzZt2zVRKIH+0mUhqjRdAcnh7C8QOXqfAA5TpOMux7hvrU+if2DGcIBJggFRhwsdC5CH7hTR++2xFwH4YJQvvl05zMRyCw+Y3uvOhPL4ET4owwQYDyIlNGlsamZI9Z3TrC15XfnwnSVrkVSGnDrfqg8hEho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739216425; c=relaxed/simple;
	bh=DPdvKhQ3kbgTp3Fn2VyCCGlV/g2DDrlKViyHLbfPM1o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EEn2RaRDpWbiyb+oH7b3tgRN7l6p4k3vz4AV5KNDAl/Xwq3BDGsAlSk7hudcPmyDB/zbe8g0jN8rCBR1C39xHkoa+DnyNeWLDh3s6KV0yckcOFD3aYk48l1uaS3cOk1wSAFrtlFybZlSW7X7+dw4aAxWP68/klKlbFEniKjiHtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io; spf=pass smtp.mailfrom=rosenzweig.io; dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b=tllRQVac; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosenzweig.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b="tllRQVac"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosenzweig.io;
	s=key1; t=1739216421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SPT9rgj0rLpckhACaCzlKgGeeCb7MV3HiAZFcPnjPCo=;
	b=tllRQVac7aKjW2rAIx9zhjYgi3keo7pIMJVAyv9DPj9OLvDEc2qwDn/EGjJy7Cp68AeeVG
	meyL9UWkzu0Tl6WW1e8ETEYsIeY6gmt+aBvfwfjak5T1P2UPcZl/fkj+HoXdoo4eSK0aet
	kirFTxP+VoV8bo18i7Tg17IgrNpSenV4ODzdY2iNO3iwvvAFNjwCjqzVNuFri9pDQIqS+R
	UyZHSTm5//LLl7MAR7rtGyfvjDpRZ1tSlMrXPSN6gzU0VLrBU9VeqDDiDElEZja/Q8M1Lu
	/Q19d3lYFID7XJBT5atjBpYL6cJ07UUV6xcX16JP+Bvec4EMlIONvOCGvHj6qQ==
From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Date: Mon, 10 Feb 2025 14:39:53 -0500
Subject: [PATCH 1/5] iommu/dart: Track if the DART is locked
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250210-locked-dart-v1-1-5d97fe247f35@rosenzweig.io>
References: <20250210-locked-dart-v1-0-5d97fe247f35@rosenzweig.io>
In-Reply-To: <20250210-locked-dart-v1-0-5d97fe247f35@rosenzweig.io>
To: Sven Peter <sven@svenpeter.dev>, Janne Grunau <j@jannau.net>, 
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2311; i=alyssa@rosenzweig.io;
 h=from:subject:message-id; bh=DPdvKhQ3kbgTp3Fn2VyCCGlV/g2DDrlKViyHLbfPM1o=;
 b=kA0DAAgB/v5QWgr1WA0ByyZiAGeqVhmhMAEDsg2LrpEFYFtHpvoi59s/jPPOHIcYInI9JT71g
 IkCMwQAAQgAHRYhBENe4JuwrwDQHar2OP7+UFoK9VgNBQJnqlYZAAoJEP7+UFoK9VgNwJMQAKJm
 FqkCYR0CPS075sM8jAaNwH61RG7jWysqRhdrd9RWnY90Ni9DTozTZTBpYHGqjlvU39F0nC70WPU
 LfTQcqV8PiymZ30FpxyPpRynmJwrw6FjDhQNI3xJy9KLEjy0GqoNwwjYVFUdftXoPetPjGo2bv/
 L0mY2vXCS0aPvoPOA9Y2iJOEjpAiHlC+XYAkZaDzbsDTIiXHPj3NzLEi3y/d13fxWw4YGX1uHHd
 0mYyd0ymPgb8An9pwmL2Q75NgVJdPRYKdY/ZhlMbUfd6h/EYRleKkZNW13Lpk2M8Nnxdc852dPD
 0HJdmn0h1UpRjuIkY32hA6gzmFXj77jpcOsqRkEmVDS5nCvrGv3aL5J3vxUjqbeXoENGeSOtZQT
 vx5xVm0J+ueuwPZRqZxK0yUkP3sqU8Nvwa5znSSOzDVAwQ4aLqpYHXYrChHbn6MVWYd8yC7vR6j
 xZbVGQqU4FUiDHJEr+HMvyOb9TlvSFuWuFtXBnH49YNxFtDqNT8eZZA/4ADIDMUGWBlIbkp/1kl
 trouAk/ftwx9TuM5CxccxVng79ULPOfbfOPMonaWkjf9TAEU6pq0SFh/lI1Vd6iRLVyuJBh9BXQ
 1VrnET6L1lVXVO7CW0CSiYLWFIcGylH4C4fcDLgL5AZqTApbaK7pkdVmrUrzfdOAmgPYxAnDiJd
 KwjO5
X-Developer-Key: i=alyssa@rosenzweig.io; a=openpgp;
 fpr=435EE09BB0AF00D01DAAF638FEFE505A0AF5580D
X-Migadu-Flow: FLOW_OUT

Some DARTs are locked at boot-time. That means they are already
configured and we cannot change their configuration, which requires
special handling. Locked DARTs are identified in the configuration
register. Check this bit when probing and save the result so we can
handle accordingly.

Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
---
 drivers/iommu/apple-dart.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index 95ba3caeb40177901086076416874b9905a1f40a..460cf96bc8001e051916f356d5d175b35e36c608 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -197,6 +197,7 @@ struct apple_dart_hw {
  * @lock: lock for hardware operations involving this dart
  * @pgsize: pagesize supported by this DART
  * @supports_bypass: indicates if this DART supports bypass mode
+ * @locked: indicates if this DART is locked
  * @sid2group: maps stream ids to iommu_groups
  * @iommu: iommu core device
  */
@@ -217,6 +218,7 @@ struct apple_dart {
 	u32 pgsize;
 	u32 num_streams;
 	u32 supports_bypass : 1;
+	u32 locked : 1;
 
 	struct iommu_group *sid2group[DART_MAX_STREAMS];
 	struct iommu_device iommu;
@@ -1076,6 +1078,11 @@ static irqreturn_t apple_dart_t8110_irq(int irq, void *dev)
 	return IRQ_HANDLED;
 }
 
+static bool apple_dart_is_locked(struct apple_dart *dart)
+{
+	return !!(readl(dart->regs + dart->hw->lock) & dart->hw->lock_bit);
+}
+
 static int apple_dart_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -1143,6 +1150,7 @@ static int apple_dart_probe(struct platform_device *pdev)
 		goto err_clk_disable;
 	}
 
+	dart->locked = apple_dart_is_locked(dart);
 	ret = apple_dart_hw_reset(dart);
 	if (ret)
 		goto err_clk_disable;
@@ -1165,9 +1173,9 @@ static int apple_dart_probe(struct platform_device *pdev)
 
 	dev_info(
 		&pdev->dev,
-		"DART [pagesize %x, %d streams, bypass support: %d, bypass forced: %d] initialized\n",
+		"DART [pagesize %x, %d streams, bypass support: %d, bypass forced: %d, locked: %d] initialized\n",
 		dart->pgsize, dart->num_streams, dart->supports_bypass,
-		dart->pgsize > PAGE_SIZE);
+		dart->pgsize > PAGE_SIZE, dart->locked);
 	return 0;
 
 err_sysfs_remove:

-- 
2.48.1

