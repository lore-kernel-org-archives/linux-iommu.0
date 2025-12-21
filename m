Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2727429D280;
	Sun, 21 Dec 2025 16:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766333418; cv=none; b=E/SqJ9IcXa5srpevKQP/67W4iinL765PO1RlnpfpMKqK5cpwesWiQsXhrVAPJgsOibDgAvUo1jkO1KX6VYLdJheM9/2RuR8mdPSO/1CT1ZFeBCxYM3NBtnqx32wvBaq7o4JNvnVqMZJ/SEbcT1BKeF/gD8fxf4hWXJSCz8MuYJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766333418; c=relaxed/simple;
	bh=CB4aj8Ej1l+k6PqCI3aIeCMU554y9nDxVDxaN9tCZlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qfW8F+TuoVOkUBBtb3hwfK/BElmWwl4OCxj/dv1mOlw144rrLRC9xC7tTAEV1f04moo/matkaEAQIpIJ4UW48sXJD95k/SyzMO7oQhDJg2bEjw+nbxJ1ID0Vv6UwiZhYrZw8yerbH8QV8Kr/2iEV1ii8cMehKXIh8SSf6JoJoe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9GKC6cW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9GKC6cW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B2C3C4CEFB;
	Sun, 21 Dec 2025 16:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766333418;
	bh=CB4aj8Ej1l+k6PqCI3aIeCMU554y9nDxVDxaN9tCZlM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l9GKC6cWdBAuxYv0jS9qtJS5s4rmZOmXrDRVe/IC1DcCAtW4Laffq5NDs8qTFghRX
	 nlO51AWU0C38a1U1DwI37OCes1SMMOkxdSFWro8jOQEahbesFZVaa+DP5uZXhgSbnV
	 LJD332tIGD516kfT+ZpjgFASIQW3fDirjFC/uEc051IXfXqS8pso08vzzWjuFLXxry
	 ar3wa8Ej9Tfxddewtbcw1UqVe+Y1YC8W4P1aztH0ZcCP0U/V7pyKUQu+DKylNM6QVs
	 MaXkIsnZtJ2LlcojBN1wmUfxRXku+1r7aACL/r7+Euo3FOroI2g8t7Wg8q4lF1pjS8
	 iBGbow9QixRMQ==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-coco@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	will@kernel.org,
	maz@kernel.org,
	tglx@linutronix.de,
	robin.murphy@arm.com,
	suzuki.poulose@arm.com,
	akpm@linux-foundation.org,
	jgg@ziepe.ca,
	steven.price@arm.com,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Subject: [PATCH v2 4/4] dma: direct: set decrypted flag for remapped dma allocations
Date: Sun, 21 Dec 2025 21:39:20 +0530
Message-ID: <20251221160920.297689-5-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251221160920.297689-1-aneesh.kumar@kernel.org>
References: <20251221160920.297689-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Devices that are DMA non-coherent and need a remap were skipping
dma_set_decrypted(), leaving buffers encrypted even when the device
requires unencrypted access. Move the call after the remap
branch so both paths mark the allocation decrypted (or fail cleanly)
before use.

Fixes: f3c962226dbe ("dma-direct: clean up the remapping checks in dma_direct_alloc")
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 kernel/dma/direct.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 3448d877c7c6..a62dc25524cc 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -271,9 +271,6 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	if (remap) {
 		pgprot_t prot = dma_pgprot(dev, PAGE_KERNEL, attrs);
 
-		if (force_dma_unencrypted(dev))
-			prot = pgprot_decrypted(prot);
-
 		/* remove any dirty cache lines on the kernel alias */
 		arch_dma_prep_coherent(page, size);
 
@@ -284,10 +281,11 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 			goto out_free_pages;
 	} else {
 		ret = page_address(page);
-		if (dma_set_decrypted(dev, ret, size))
-			goto out_leak_pages;
 	}
 
+	if (dma_set_decrypted(dev, ret, size))
+		goto out_leak_pages;
+
 	memset(ret, 0, size);
 
 	if (set_uncached) {
-- 
2.43.0

