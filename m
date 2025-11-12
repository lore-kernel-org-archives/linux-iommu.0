Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1201B25D53B;
	Wed, 12 Nov 2025 14:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762956493; cv=none; b=GuLRIuYSINeQ41peQl1AOei9xG/9EWrfcKOrTuwSXlo7FHFO2uQhZC7me61oZIubJB0mJzocEwrE7gnEFla9tpzbgHRSfQgRVFfijjoLFmSEDVySR7hj7IQuh0dBBLXWUzrrVVBlqHNkwb9Xo6dnWbg8bx3INzGBLSzprCZeD2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762956493; c=relaxed/simple;
	bh=s1xMXXiBPwfvg3iSd3rAsY19fv5HJet/mRzbD2n1XQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XweQQ1iRj0pPC5UjoxPdgss4V2msF/zeQqMw1b7bY+cymiurRnnb0XzzoAGbDGYkvEJ92yaJ1GvGOPuxuaOITHDqapsdmE5uY1yZ9FIx/kYFqGoSqOjHz0BVHUlDTWoLH2ktElPeRKZ3O/4vKdq4nNIG+XElKgHVq2CDodFoCCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E49DC19421;
	Wed, 12 Nov 2025 14:08:10 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] genpt: Make GENERIC_PT invisible
Date: Wed, 12 Nov 2025 15:08:05 +0100
Message-ID: <48381c47930d98380871458ca471ea5a7a89aafc.1762956447.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no point in asking the user about the Generic Radix Page
Table API:
  - All IOMMU drivers that use this API already select GENERIC_PT when
    needed,
  - Most users probably do not know what to answer anyway.

Fixes: 7c5b184db7145fd4 ("genpt: Generic Page Table base API")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/iommu/generic_pt/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/generic_pt/Kconfig b/drivers/iommu/generic_pt/Kconfig
index c88971675662feb5..ce4fb478691457e1 100644
--- a/drivers/iommu/generic_pt/Kconfig
+++ b/drivers/iommu/generic_pt/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 menuconfig GENERIC_PT
-	bool "Generic Radix Page Table"
+	bool "Generic Radix Page Table" if COMPILE_TEST
 	help
 	  Generic library for building radix tree page tables.
 
-- 
2.43.0

