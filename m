Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90052E414
	for <iommu@lists.linux.dev>; Tue, 28 Jan 2025 19:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738091128; cv=none; b=IhXjCHXwcSuJxN5XP6HGZj561Z51PlhMp+xG0PXMcQabC8jW50jkLntLB6Wz1bYi3WszmZB2vPWl1AICJRo8J+Q+gFjdwFs6mBytdNSiqPFSJNs44SNnIzqtLqktCb3YoORPVLSVELlLl+7aIpQ+3z/xbV0WkcSOwrHSz968JVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738091128; c=relaxed/simple;
	bh=U6vfu1Ic2n4x0uQMrSBYDoBX9xlOOQPHAGU0Y1ohGZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BPec7hU4stm6SmVBFMgdnhDmgZD2b7Kn60Bmzl6KS7ZvbttONcWRNVvmkuI3loEw+GTHez9uzmMB7I62K/PXKfOiMa+GF+e6jImrba2Mzgs1ZmMMfMxeuMCMZwgLKClj9xuQLEbfbKq8NHDVHCskpYzlViLgA3i7a/PbMdyxqHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=dEPdR2V1; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="dEPdR2V1"
Received: from eahariha-devbox.5bhznamrcrmeznzvghz2s0u2eh.xx.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3CA56203718F;
	Tue, 28 Jan 2025 11:05:26 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3CA56203718F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738091126;
	bh=RfBBmuLdOy5mahGRqkbSR6+wV9ui8Rc7eTY/vYKqoj8=;
	h=From:To:Cc:Subject:Date:From;
	b=dEPdR2V1aet1KlVQjX84y2mBVXD901cHkJHy/j5jPsqWMlhR1vLH+1PdOEef/Ws6d
	 QG3MrhsvN/jyHjBjooFJ0hAC4FL/N7O7WYHEkH7OFuUu4+vhVVDZ8A0xHhnRV3CPBW
	 IszM2BLZwh8HvAiialg2XybZxfDnWnAngazykltE=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev (open list:IOMMU SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: Easwar Hariharan <eahariha@linux.microsoft.com>
Subject: [PATCH] iommu: Fix a spelling error
Date: Tue, 28 Jan 2025 19:05:21 +0000
Message-ID: <20250128190522.70800-1-eahariha@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 drivers/iommu/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 870c3cdbd0f62..60aed01e54f27 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1756,7 +1756,7 @@ static int iommu_get_def_domain_type(struct iommu_group *group,
 		group->id);
 
 	/*
-	 * Try to recover, drivers are allowed to force IDENITY or DMA, IDENTITY
+	 * Try to recover, drivers are allowed to force IDENTITY or DMA, IDENTITY
 	 * takes precedence.
 	 */
 	if (type == IOMMU_DOMAIN_IDENTITY)
-- 
2.43.0

