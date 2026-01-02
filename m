Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E04427FD4F;
	Fri,  2 Jan 2026 15:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767369095; cv=none; b=ggwN3asM6ik90yyXn1fIknVwFKUVfB5ojIqYF15+h0zCojkfCXEgfbc6QKoiidxjtWbg+M54Ll4GCCHO7NZOAYVQIPgtBhUVQETbldCUXK/pBwKZk6aenPMjDze9PB7HoQ5bylvkfvp1u7hnndOHf+1jiBlLw9ZJbsuzBF5vVC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767369095; c=relaxed/simple;
	bh=iYPJud/873VON8+inP5iz8iNqST5H80MwfuO7ZGPVrg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EyQh5Hi7VTISKrQUxNWWqI8gA8SKtLziS7cXCmIfp469iJONbtfT1xPh9IwxJyrI0zPgbVMBQ4vcoIva0oYl4HMlFtIotbiA3p0mwcqLUKq+/Lhuy1yWjdHX6484c5iRQR7hFF7ZG6nZzcq/YV08zkRK8r9m8d8EGs+Yra5z9yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AY3YjpdS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AY3YjpdS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3911DC116B1;
	Fri,  2 Jan 2026 15:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767369094;
	bh=iYPJud/873VON8+inP5iz8iNqST5H80MwfuO7ZGPVrg=;
	h=From:To:Cc:Subject:Date:From;
	b=AY3YjpdSAIBK1rIB7qCSD9L2ebwCwqJ5bUkeY2WCW/i8mUxw27BWDyxC1yEPLuXly
	 Qyd07nvqlTpHU4T6CgFzvTIUf4EboQQ2VzV7WqYG3T+17mWre0USmgZQ3MMUol550h
	 00Lt+rp/hMThaIvUMVCBszx4XirFCedGuDgOAkaKB0Fth3FdqIkv8MSaWU7sev0Z30
	 OzokU0swaADXKTWzXgXBs9f6zioHNniy9Dc2syJsMybL3v17Yt7zC8A4crkSLFJSZ4
	 fhQSmlev4idjySeh/79iqlgBnK1VXWw1ut82cTtOUy4dsz922XeFGOaC1DmaqZoTMy
	 ynnPuNI6D9Uzg==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Arnd Bergmann <arnd@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Subject: [PATCH] dma-direct: Skip cache prep for HighMem coherent allocations
Date: Fri,  2 Jan 2026 21:21:18 +0530
Message-ID: <20260102155118.2551804-1-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dma_direct_alloc() calls arch_dma_prep_coherent() to clean any dirty
cache lines from the kernel linear alias before creating a coherent
remapping.

HighMem pages have no kernel alias mapping, so there are no alias cache
lines to clean. Skip arch_dma_prep_coherent() for HighMem allocations.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 kernel/dma/direct.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 50c3fe2a1d55..ffa267020a1e 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -272,7 +272,8 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 			prot = pgprot_decrypted(prot);
 
 		/* remove any dirty cache lines on the kernel alias */
-		arch_dma_prep_coherent(page, size);
+		if (!PageHighMem(page))
+			arch_dma_prep_coherent(page, size);
 
 		/* create a coherent mapping */
 		ret = dma_common_contiguous_remap(page, size, prot,
-- 
2.43.0

