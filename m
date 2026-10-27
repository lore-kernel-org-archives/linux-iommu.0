Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793067981;
	b=o5P/SQVLfSa1HwdXxVSCHSYZ2j6MnhLVd8UyGDvQNf8ol5wAyvBndwAdxpfrAbADii6R
	 VdbjNB1hsLE8G6sL3wz+FPFdp3RQg1bMtXA2g2uO55xhPYnXoAphUAEs2ke4zfMXmIyoy
	 9FZ00Jqu+azF3BRbxClYROXdSiVwF96ZXH2zv6iLB2I5/U7VTunU5bv72DL+5Inp0fdDW
	 IHFYPu9M9Tkm9TvgVWeNV0GMVRR7BKWp2IPKhMe6O4gNqpShw58JZGvrrXfrqqpMX+vkc
	 W8SYEOU6mw3gf2PVANLeUVjMmd7jgl+nU3inj+RGUwoWTM7hzc2ngGO+Xi+FtSYDZzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793067981;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=WbuCZPg7LYGXmJwGaFCk6Kk9Ioa72ZlJTCfm3Uszomc=;
	b=pjfcOOHK5YWWXCcu58WEGozJfGRBpcdOSmunurPAu+2EzYbsvYOiwe4G38JCPf1XWElD
	 IC4a4ahAl56DW6r3H8HdZLw6dLeypscjzvzG9bT4ceRnIDPnWrKqiwV0puK1b67NYWO6C
	 cyAOypN04mGSJy+etO/Ng/vv0R+kTtPVYnxah52CH85yoE9fY8vjvr7FGVjbk5E7KN2Nj
	 sQWT+eqbmvaiaGxBSRhc9rhanopkovINio6SqkyIjIQoBV+OAHg10PNxPS1VbwTez8Arq
	 dqjix4bEG1Ly7mXStCSd0nQ7r8kEZ2nJgYbBMh6hrDfS0TvYtoeFQizQZp7BevAYQag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OWhA5QWp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EDF606A326;
	Tue, 27 Oct 2026 02:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OWhA5QWp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC2511F031E4;
	Tue, 27 Oct 2026 02:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793067971;
	bh=WbuCZPg7LYGXmJwGaFCk6Kk9Ioa72ZlJTCfm3Uszomc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OWhA5QWp9ganmKoTTlmhmDblXUvTtXQR0HOCkUzoqo5afOZxcEw+fCnDQLY/cGd+T
	 M1+b0kRakXkm2rT9P6EcYic9nKwxOLBRzISTYggR2VFe9BU1OQh60hOM9E18egwIfW
	 OEivsebVI89xKlB4roxpwc9nwS6pW+0JLv2Y7AoXLQZWrjrRLPW1s2BDpO9CEz7/I9
	 paP5w+azokBso+LyPLdZN4/TH/DkUDoMcanjiyClbT9HDv+NvrlnLNXINEACma7C1l
	 6Q0kuGMYLX6hNOmg2km8KBnAnCWruUCLK2N98/f8k+SFUjOtqj5VkQLwH0esf9OnVH
	 TIHa4yAlkBOag==
From: Jakub Kicinski <kuba@kernel.org>
To: robin.murphy@arm.com,
	m.szyprowski@samsung.com
Cc: tglx@kernel.org,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	joro@8bytes.org,
	will@kernel.org,
	leon@kernel.org,
	mbloch@nvidia.com,
	iommu@lists.linux.dev,
	netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC 08/11] eth: xgbe: use dma_alloc_coherent_node()
Date: Mon, 26 Oct 2026 19:25:25 -0700
Message-ID: <20261027022528.633359-9-kuba@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027022528.633359-1-kuba@kernel.org>
References: <20261027022528.633359-1-kuba@kernel.org>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use dma_alloc_coherent_node() in xgbe_dma_alloc_node() to place
the descriptor rings on the channel's node, instead of temporarily
changing the node of the device.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
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

