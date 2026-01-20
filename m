Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6F036CDE5;
	Tue, 20 Jan 2026 06:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768891404; cv=none; b=q06xO7XEBX1rFI8cCS1CC0a35CoTAQw8yFZS+8hfR/Au1/f6XlZRuYuSXAMqPWVkv0R3YHeG61n4JIXke1dGNVorFM35zi7mq02KzIE0d+ix/Jdy8lkgzxfE5GahQn/k7sLqsl67oOb1y2cWEoYSKLkf4/LwLcoCuKCjs6hpg+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768891404; c=relaxed/simple;
	bh=fXqBeANeANyqIBfh9xTfBVpuJiDNRuy2sOT6ZNznJXM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Lf/fxREjSgVQwFFeHoY/sP9z4z5JLKgt5WpQ1aRYrcOkVwlHuwHV3HeBSBwUReJGQKBWJV/y9qZYNLQUBzzJQGcW8B6MaKXW+gKNk2mFi1wA12tdBr30z6OCbrPxprYGM6kJB9Z4lWmO43ZRsXm0I2/T2m+B4O+Ky9oBp9XYLBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FkTbO84t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FkTbO84t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 785F2C19423;
	Tue, 20 Jan 2026 06:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768891402;
	bh=fXqBeANeANyqIBfh9xTfBVpuJiDNRuy2sOT6ZNznJXM=;
	h=From:To:Cc:Subject:Date:From;
	b=FkTbO84t0lXCTbD7BtoBVc8kXF2FKQeYZ1mi/kiCVmD3srEYrU20sJhBaKQwpAtlV
	 YpZRi1kTDaTRs89YScExX2/IG5PxqWhAt2+lHqaD6nHywVGqSAYGZ4rFg73CebDRI1
	 OtuMvvcx+Eq14397ETWDPkRjdSraznOrWAAcC67UmQM0+3o9A27CuDY1+NL241HBu7
	 beDatetyw0G+gbH1FgIygbnJDnxPl7yqpxLZJqdpaKstDLsPUKnToy0RTwQn5yQxLC
	 gR5B3vqCXD5ClWNDjExVt4kekPwUqssjn3CTgzy6zkXZdpVzUYbGcUL99aoJ4dhh+6
	 h2At01Kg5/Pvg==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-coco@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	will@kernel.org,
	robin.murphy@arm.com,
	suzuki.poulose@arm.com,
	jgg@ziepe.ca,
	steven.price@arm.com,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Subject: [PATCH 1/2] dma-direct: Validate DMA mask against canonical DMA addresses
Date: Tue, 20 Jan 2026 12:12:54 +0530
Message-ID: <20260120064255.179425-1-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On systems that apply an address encryption tag or mask to DMA addresses,
DMA mask validation must be performed against the canonical DMA address.
Using a non-canonical (e.g. encrypted or unencrypted) DMA address
can incorrectly fail capability checks, since architecture-specific
encryption bits are not part of the device’s actual DMA addressing
capability. For example, arm64 adds PROT_NS_SHARED to unencrypted DMA
addresses.

Fix this by validating device DMA masks against __phys_to_dma(), ensuring
that the architecture encryption mask does not influence the check.

Fixes: b66e2ee7b6c8 ("dma: Introduce generic dma_addr_*crypted helpers")
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 kernel/dma/direct.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 8e04f72baaa3..a5639e9415f5 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -580,12 +580,12 @@ int dma_direct_supported(struct device *dev, u64 mask)
 
 	/*
 	 * This check needs to be against the actual bit mask value, so use
-	 * phys_to_dma_unencrypted() here so that the SME encryption mask isn't
+	 * __phys_to_dma() here so that the arch specific encryption mask isn't
 	 * part of the check.
 	 */
 	if (IS_ENABLED(CONFIG_ZONE_DMA))
 		min_mask = min_t(u64, min_mask, zone_dma_limit);
-	return mask >= phys_to_dma_unencrypted(dev, min_mask);
+	return mask >= __phys_to_dma(dev, min_mask);
 }
 
 static const struct bus_dma_region *dma_find_range(struct device *dev,
-- 
2.43.0

