Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102B0184537;
	Wed, 11 Sep 2024 10:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726049711; cv=none; b=WiQHSyOT/bP6JHbKPVZus542qui+SEI+Oj6paB8h0IRV2a5AyQUcaRcKzvz4Rk8BW0r/xF7EB484xAu39F0luRi5D8xn1m7fhyyG/PMtQkzZw2jYysTQEdrPACH1+iHOBtEcogXRpBRTS2UszuqB/4hiN2AuLuuXyVvPylbszXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726049711; c=relaxed/simple;
	bh=DAMKbgwWxd9dDYqi9WPl/GTEEQsd85DacUpoLmSVOZg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bZQ5X9sNrkrqgWGcMC5m5o9nyoJCA9qG6EQO7EaIP5+z3keoB3K+YaSmB4oHwCJAwiyjxcLa5/GL6RlMa6WFPO1SLmAD1j08eMJ8zMmsHLnlRgaxyTv6mS/iJSp3zirfBeSSMuQPQn0Nji49iJdGx4OzYCR6arMpPRXqlMzTfzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ddTDojby; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ddTDojby"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EC7FC4CEC5;
	Wed, 11 Sep 2024 10:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726049709;
	bh=DAMKbgwWxd9dDYqi9WPl/GTEEQsd85DacUpoLmSVOZg=;
	h=From:To:Cc:Subject:Date:From;
	b=ddTDojbyulzML1RA6HLSZ4DBlpmiF41R9g7YepxZFw5bS0SegerVIwfh5grLsoDPC
	 hnviQ+HkFDHnlwdLzneu3zu9auY06pcohfFBDcmDmCBPuDX5gecQqM0Ked/Vm4uClE
	 tgDWfUoJGBVUH4LK3FMgSAkJUnKFNUJ6QQVvb87C2YHi6GS67AFEunRBY/jrmDDMCV
	 cHKL8q640+eAZpRKXo8bTWmmE3hVMo7OHh9+BcnuDrHNjZqtfckjEZdGOg1+dTVv4E
	 ZGtRDefg3bsJYtBCEvh78vtXobJibbcBLOC5WcpcbN5ZmfFv4CnTvTzDs7lizMJnFw
	 oblCDvx8NtKNA==
From: Leon Romanovsky <leon@kernel.org>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>
Subject: [PATCH] dma-mapping: reliably inform about DMA support for IOMMU
Date: Wed, 11 Sep 2024 13:15:00 +0300
Message-ID: <7bbedc085ce87b121b9d0cb33eca8fba2fbdddbc.1726049194.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

If the DMA IOMMU path is going to be used, the appropriate check should
return that DMA is supported.

Fixes: b5c58b2fdc42 ("dma-mapping: direct calls for dma-iommu")
Closes: https://lore.kernel.org/all/181e06ff-35a3-434f-b505-672f430bd1cb@notapiano
Reported-by: Nícolas F. R. A. Prado <nfraprado@collabora.com> #KernelCI
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 kernel/dma/mapping.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 1a7de37bd643..38d7b3239dbb 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -824,6 +824,9 @@ static int dma_supported(struct device *dev, u64 mask)
 
 	if (WARN_ON(ops && use_dma_iommu(dev)))
 		return false;
+
+	if (use_dma_iommu(dev))
+		return true;
 	/*
 	 * ->dma_supported sets the bypass flag, so we must always call
 	 * into the method here unless the device is truly direct mapped.
-- 
2.46.0

