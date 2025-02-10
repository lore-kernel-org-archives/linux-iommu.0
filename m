Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A3624C66C
	for <iommu@lists.linux.dev>; Mon, 10 Feb 2025 19:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739216430; cv=none; b=S4wqQa4sKKN6iuHpiZW0tUDEa4I5+5U01yHu9xJQX4E2CPr4hDQhZDpeGcWm898CwfPhDfAHHIZEkrkL0iK4b/a8sQB8mtmHbZos9yZAlfV33L3V9Yc45wH//xL6ypqhpw7iuv8binZL3nqHVKjjQrIFhD/vcMgs95brqSYGEH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739216430; c=relaxed/simple;
	bh=Q2X3fPKVvdzr1B3hHwj4E/4Mk7pqhs1UeDt0uJfgsNE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NO/Fquqp2Ln1va2a7wsMWCO+uVpgspVraArSS+ZpXpalihDzSnPyke7tzh/iLm5546V7OJxnkpMSZ8G67yDgGiRRvInF76pBKbe0OtD3zk57KvhswChCbpTGApCpNVM1Hhj7vrrGzw1dTX1ISAR6GNh1ilFXzRGz2gvlDZDfSps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io; spf=pass smtp.mailfrom=rosenzweig.io; dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b=d9bfjWKu; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosenzweig.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b="d9bfjWKu"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosenzweig.io;
	s=key1; t=1739216426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Occ2Auitkp4TNvTqlmdDCEbjvoCr3RaS62RKSPjLibw=;
	b=d9bfjWKuGE6S10cVSNw9w48WqXMUZBcGuoaR9zleSEB3XvbuAzC4YlbGcc2ewqroMo5mca
	elLQz7k9lFnDVTTaiyq7QJnP1epkIm6bLx/+8tHS1MbY+FzPSCi6D7CeXDEAktN3z6MLik
	damm9V/imb6ZqferHa0FWI/tlbvfpYFb13iC8CpOjlQyuayo04qb3V5X50TGnXAtd8lT32
	P7DfX8rVNnOgAH7LdRYMxKMxg5azLSvPtJoCumZ8L8D2xNTHcUJ+oRSKbPe7L5BGHHig8S
	5wLVjx41NtZC+lhECott69vlwiFAmIU+oscASzZq5MnIg1rkiS0DxY+xXrQB1Q==
From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Date: Mon, 10 Feb 2025 14:39:56 -0500
Subject: [PATCH 4/5] iommu/dart: Reject identity domain for locked DARTs
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250210-locked-dart-v1-4-5d97fe247f35@rosenzweig.io>
References: <20250210-locked-dart-v1-0-5d97fe247f35@rosenzweig.io>
In-Reply-To: <20250210-locked-dart-v1-0-5d97fe247f35@rosenzweig.io>
To: Sven Peter <sven@svenpeter.dev>, Janne Grunau <j@jannau.net>, 
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>
X-Developer-Signature: v=1; a=openpgp-sha256; l=781; i=alyssa@rosenzweig.io;
 h=from:subject:message-id; bh=Q2X3fPKVvdzr1B3hHwj4E/4Mk7pqhs1UeDt0uJfgsNE=;
 b=owEBbQKS/ZANAwAIAf7+UFoK9VgNAcsmYgBnqlYZblhzlpiuLR3xbq+t6xWjNWkzODbgWUFF5
 Fs8N4cPjwOJAjMEAAEIAB0WIQRDXuCbsK8A0B2q9jj+/lBaCvVYDQUCZ6pWGQAKCRD+/lBaCvVY
 DfbXD/9R9X6kCnXTZvOwa5wliwk7U6TDTvgktXgigweVT9oIXCaiqPqOzuaP147ASN3CDzU+Hym
 HkKienPTMPBI8OUUsO7EH/fC9njHeIxIht6fiz1MHV23cmySLs9fgevS0rXk6+JMjQDWviAhbA6
 en0KYZA0ZEe7VRGlgqGZKDhMmwtbOp9QQMOkvNC6UKxQymcwaipOSuG8JZNIDtt5PJZt8zglc6P
 Bst0ZY4KogoLg5lXWoirtipWmtjE6LXFB27ggVATt6OxOTbSp/bgghq9pU7gMlpjtneOQe+BmH4
 KV8FGp6Bsipd11gUJPx+qVLWBc6pTmLmkiJsR4Q4Yt2gDmJC5DEnpX6BB4Zh0Y1lLNQyIvqHOq/
 tFangOvZ2w5JR7pbSNFLVo5A/7Sn3KRT6LZjC8oS5P3WvPTs+v4thCPjx07G9vKLTngzUI+ao2r
 B/L8n1NOusN93T1127AGB/+n+hPeEVxX7xv7rP4xgkpfNMAHqPKjOHFhBwheOBQ25T2e/PJx462
 I2qkNPtIHvCvsJIF5fPaf4HObzeY+quJp7eiGXkqHyQwGvbO3H2CX9dRJkgpjtNLYWUv0Sp0TIg
 OffyZwpGvQHldBCXuxjpnYA1vJP3LVFDf8VSR+O4qpSVoL/IbjYG5gFp1RbbsNPV66svskh0aB8
 mmyCRBY9jh67snQ==
X-Developer-Key: i=alyssa@rosenzweig.io; a=openpgp;
 fpr=435EE09BB0AF00D01DAAF638FEFE505A0AF5580D
X-Migadu-Flow: FLOW_OUT

This cannot work.

Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Signed-off-by: Janne Grunau <j@jannau.net>
---
 drivers/iommu/apple-dart.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index 9c6f780dc7220096ed6bba692fa1a4bd859b0d61..29b627b38e8c37afd2b6a72865f43d24b633834a 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -681,6 +681,9 @@ static int apple_dart_attach_dev_identity(struct iommu_domain *domain,
 	if (!cfg->stream_maps[0].dart->supports_bypass)
 		return -EINVAL;
 
+	if (cfg->stream_maps[0].dart->locked)
+		return -EINVAL;
+
 	for_each_stream_map(i, cfg, stream_map)
 		apple_dart_hw_enable_bypass(stream_map);
 	return 0;

-- 
2.48.1

