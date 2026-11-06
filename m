Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793990697;
	b=39WJHkbK73QMimSLqA7IHZJzjJxQgRfkkDi1z8liqtEUsWW3L8yTPtXy7Ttf9H+HcehY
	 Rak1g+tgea//SqWtPIr4Q8em9Emrg2ENZaSgFUsKP+0465WzFmLqTo/K0rcKc1JHMHfqX
	 CymTw4GnS8YL9EuShYzsUsFz1I4pya8KYAlUbPGVUtkxZ+ZmaNXs3u0tT/Uk2tTDXJJgG
	 2FYQb+6ehjHUelgDD+yo0Pedi13jFws3IsKvfir6Q/VH+5wmi2DzsXLhcJAboXnzgE7wM
	 4Y1J0GiDxHdBZNFZ/+vTatV4xIUnkaHHaxOm6dkF+NOwW23dCMRavbAYNVIeu8OgaSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793990697;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=WfkvrMyFfWctPh85aiy+xAaloqv86v8xB2TZwayuYSg=;
	b=aE6YMeiwgHGgiilmlwAfpREE893fqFSaCst/biCeKTKJPbClce1L7zlOIbfvjS/LnB+0
	 gqU5TuWJMvwg8YnYaxlLZNo6X6GaOuMaDo107o2F/QORNtZzKfznV8FbYiIeGsxcSE+Lu
	 yOTU84FrB0PUSu9+m5yBx4ofWE9iEAiFG3ij1vLDjGYqR9hvyg9FkUd5NYvC5zPuukCm4
	 iKsZq8AwZWd0VBcWc+pPjOgnIhUZqiTE9f0P9qWmRIf2qEJj50LV2W00cjDNAAf97NriU
	 I3Drq0joBCvr30xHZ0fCl0zsEsbTkkeeyS3qxheWM3J62iNm6K6/d431o8bj1MPZRSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jkCNTYB2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EEC606A334;
	Fri,  6 Nov 2026 18:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jkCNTYB2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1DFD1F008A4;
	Fri,  6 Nov 2026 18:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793990696;
	bh=WfkvrMyFfWctPh85aiy+xAaloqv86v8xB2TZwayuYSg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jkCNTYB2WaZ3fTut+CVd0HX8sjQf7B4Y+WgvOtaz+MUDeeW970RQ6zpLqqKBTDBKB
	 pXXMXsbxnqnMot1IfcEv41Oa1qwkug5fYWzNGeP+iygASd/xOWtSaPWPiq8dad+oHD
	 W5QkRbeUC3o7tyvzD9TFFTGyt468RO3PsFEZAW/iAEDMgPq6D0cn6cwq8Czdf78Te0
	 jehKV4J10F9l3/X+Yg50vLR+C/i9cwEUrLsN7SDBe4JbPXLxY4whlKmmqYi/rp8IIK
	 3dR1UkyD5JUGHzr2FJaZI283BnjDXoDRBRWBmdBY6Dmj+govVv8I5b1E1cA5DneOQr
	 t6RSknDQaXVDw==
From: Jakub Kicinski <kuba@kernel.org>
To: robin.murphy@arm.com,
	m.szyprowski@samsung.com
Cc: netdev@vger.kernel.org,
	iommu@lists.linux.dev,
	joro@8bytes.org,
	will@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
Subject: [PATCH 08/11] eth: xgbe: use dma_alloc_coherent_node()
Date: Fri,  6 Nov 2026 10:44:30 -0800
Message-ID: <20261106184433.761422-9-kuba@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106184433.761422-1-kuba@kernel.org>
References: <20261106184433.761422-1-kuba@kernel.org>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Use dma_alloc_coherent_node() in xgbe_dma_alloc_node() to place
the descriptor rings on the channel's node, instead of temporarily
changing the node of the device.

Reviewed-by: Björn Töpel <bjorn@kernel.org>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v1: no change
rfc: https://lore.kernel.org/20261027022528.633359-9-kuba@kernel.org
---
 drivers/net/ethernet/amd/xgbe/xgbe-desc.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-desc.c b/drivers/net/ethernet/amd/xgbe/xgbe-desc.c
index 7c8a19988a52..369cd00fb426 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-desc.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-desc.c
@@ -91,12 +91,8 @@ static void *xgbe_dma_alloc_node(struct device *dev, size_t size,
 				 dma_addr_t *dma, int node)
 {
 	void *mem;
-	int cur_node = dev_to_node(dev);
-
-	set_dev_node(dev, node);
-	mem = dma_alloc_coherent(dev, size, dma, GFP_KERNEL);
-	set_dev_node(dev, cur_node);
 
+	mem = dma_alloc_coherent_node(dev, size, dma, GFP_KERNEL, node);
 	if (!mem)
 		mem = dma_alloc_coherent(dev, size, dma, GFP_KERNEL);
 
-- 
2.56.0

