Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B997D2747A
	for <iommu@lists.linux.dev>; Thu, 19 Oct 2023 15:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="phP7X2Ta"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F13C433C7;
	Thu, 19 Oct 2023 15:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697729140;
	bh=2x/mtd1lDxKRGt7mE+ffi4TGn+7QuCZoZq/NudZ2row=;
	h=Subject:From:Cc:Date:In-Reply-To:References:From;
	b=phP7X2TaXqgrzDLtHYupVm0feLgZ9PTdxCle9l0R6cdmDYryBkgPjAKeQkvKYMp/e
	 Fev2lnAGS6PVHuoeSkDeySs1n9pXT20gpJkyuoaPUpud2SFB9Bw1WpwqP3DyXnERlQ
	 jxjOdjtswqCqg1Mc/fOPoxOMNgfstNjsAoaJrCpzq5gaDoET6aG+SlYRs5YTigrJ+T
	 /4w1JXRM9TIeus60IX25NVuALcwDNCrlvBLe0Z+0P36KbKqlRP7G0uJDuTsLxno21o
	 vCUyo3M32pC40zY0LBczfwNU9HnrVzCmSYaYYxi9mxH+Q3SgxmkWyLm7RT8FA54FHl
	 urvLL3Xen/UTQ==
Subject: [PATCH RFC 1/9] dma-debug: Fix a typo in a debugging eye-catcher
From: Chuck Lever <cel@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
 Chuck Lever <chuck.lever@oracle.com>
Date: Thu, 19 Oct 2023 11:25:38 -0400
Message-ID: 
 <169772913879.5232.8222328841727254479.stgit@klimt.1015granger.net>
In-Reply-To: 
 <169772852492.5232.17148564580779995849.stgit@klimt.1015granger.net>
References: 
 <169772852492.5232.17148564580779995849.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Chuck Lever <chuck.lever@oracle.com>

Cc: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 kernel/dma/debug.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 06366acd27b0..3de494375b7b 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -139,7 +139,7 @@ static const char *const maperr2str[] = {
 
 static const char *type2name[] = {
 	[dma_debug_single] = "single",
-	[dma_debug_sg] = "scather-gather",
+	[dma_debug_sg] = "scatter-gather",
 	[dma_debug_coherent] = "coherent",
 	[dma_debug_resource] = "resource",
 };


