Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C25235280;
	Thu, 27 Mar 2025 05:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743053340; cv=none; b=e+61z+QU33W24Mzood6RWJVE+RDKE5VnV2JB9BkqKecpcGYssh3N5BWUxQyNwdYPFikiTrQxt+SypTmiy8sW9pcNW+sSdDT9dnecukFQSUvviZWqZLkq3Zw0S9Mfh3PYM9ub5ZPEaRC3dqC15pwC4Or2nWtq9SWrb2EoLV1Q/h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743053340; c=relaxed/simple;
	bh=JQkF6jA2QUs6Cz9bhUGfJtAYxGyaYqob+SEALNJvCrU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eYTMq8s4VS9e8Jig91C1DB+3qxi+g7fHq1LFRr9zstY+DfVc8tLqp1pg4c83X8+Gq73KSMUOyf+ABUUESTOcyv4CZppoOimMhbjs25iUUC7fV/abcSwyBXUulAMD/41cZ/pkVhviUGBVhNTX7uGaSCK1nQg7hgtWkKFjIAjjWH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sUpoxKLy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sUpoxKLy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20EFFC4CEDD;
	Thu, 27 Mar 2025 05:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743053339;
	bh=JQkF6jA2QUs6Cz9bhUGfJtAYxGyaYqob+SEALNJvCrU=;
	h=From:To:Cc:Subject:Date:From;
	b=sUpoxKLy9tfZl8MfzcBnq6cJDmNzeQ2MU03W3wqq9A5kXil3+y1pAsUVX+wSgUQXu
	 8uARaMjqPpCivavKgECofXUEz2upNK254ehtf7kaOnljTAVK+FOr4q1/2c8lEeklhO
	 WB8onFw+2XSdUjSXBNVAttlqurvUG8T9rbnMir5npEqd+rcnTLNJs4SI4eNOQcno+X
	 0XIdKxjxoJyif1gVRqA9Z8en5VtivcCcQ4AmB4TuEgLpEnbuVSKqJJIXtRIGN0oCT3
	 mVan7oa1719i3HNcvYXlELMVs4iPRiXJxtSHwkBkc41/bbBwJgb/6B8KWR/g/G3prG
	 59LKv+5DuIOsg==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	Peter Zijlstra <peterz@infradead.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH] iommu: Convert unreachable() to BUG()
Date: Wed, 26 Mar 2025 22:28:46 -0700
Message-ID: <0c801ae017ec078cacd39f8f0898fc7780535f85.1743053325.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bare unreachable() should be avoided as it generates undefined behavior,
e.g. falling through to the next function.  Use BUG() instead so the
error is defined.

Fixes the following warnings:

  drivers/iommu/dma-iommu.o: warning: objtool: iommu_dma_sw_msi+0x92: can't find jump dest instruction at .text+0x54d5
  vmlinux.o: warning: objtool: iommu_dma_get_msi_page() falls through to next function __iommu_dma_unmap()

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Closes: https://lore.kernel.org/314f8809-cd59-479b-97d7-49356bf1c8d1@infradead.org
Reported-by: Paul E. McKenney <paulmck@kernel.org>
Closes: https://lore.kernel.org/5dd1f35e-8ece-43b7-ad6d-86d02d2718f6@paulmck-laptop
Fixes: 6aa63a4ec947 ("iommu: Sort out domain user data")
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 drivers/iommu/dma-iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 7b2734de2ba9..6054d0ab8023 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1753,7 +1753,7 @@ static size_t cookie_msi_granule(const struct iommu_domain *domain)
 	case IOMMU_COOKIE_DMA_MSI:
 		return PAGE_SIZE;
 	default:
-		unreachable();
+		BUG();
 	};
 }
 
@@ -1765,7 +1765,7 @@ static struct list_head *cookie_msi_pages(const struct iommu_domain *domain)
 	case IOMMU_COOKIE_DMA_MSI:
 		return &domain->msi_cookie->msi_page_list;
 	default:
-		unreachable();
+		BUG();
 	};
 }
 
-- 
2.48.1

