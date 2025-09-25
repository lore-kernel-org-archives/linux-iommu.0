Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3652DEA95;
	Thu, 25 Sep 2025 15:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758814302; cv=none; b=mKgOuj1u46srHz7Bp5KtYVvNh1Ry2nuuwnn04SwK4Eyr+QEZB0JjUjQit3+ZldsNDJVf1apbDTtZiKnrTL+ur5lcbNLPpntdiAzZ7DkCr7k3DaMz34t0ta/qhSog2dKouu+xuTRLYV4rAwPz4xRqFvOFW/SwIN1+SO6vDUfks4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758814302; c=relaxed/simple;
	bh=bTv4ugKbMV2P88hk+d4vjRcHZtAVA4nJuvTaCUaltgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=abDEUzd13HSyjF7KT/xX0rVT+MNdOLgYbMiQWmrFZ/tC88esRz2WgEdRThYTMiJ1wnozHueVqCDonOyWTKHhI9PvHBqsZScPRtKWdB0BpDax+O65jOXuz+DdoeqEbp7UJxnCbl6DcP08qv1efmvNs02i4B9mEkqSYwCR/3S3I4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TE0NJJws; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TE0NJJws"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24ADAC116B1;
	Thu, 25 Sep 2025 15:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758814302;
	bh=bTv4ugKbMV2P88hk+d4vjRcHZtAVA4nJuvTaCUaltgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TE0NJJwsAhyXFnA0pSUSMzZF8+o0o11CHFXPOYmZ03d8IAgcNkS8coDxusOBucBYB
	 oSmFiDXBzZCJiebq1x4GntJ+T/QEbix8RRgJWSUTbLnD6rWFryIaZHbmlQ9MiyEn8o
	 Fv7fPFXlWieeiQpTd6sBTp3gBmu/bZxMmcnrqcnq0mZAgvRm2WDyx0DN3+C+wXzxi4
	 IMMGWxPw+/Om+7YilvOdDy9c3otxgpYhQh+VQbqT3lNtXO6Da0N4EgBaaj/cWoj5Tn
	 X7re6DEgA/QyUOrFXGWV048hscoX+w8bksHKOmcNe1o3dF8f2q9q2WW3SupKbpiZiK
	 H4Qlm/x0m1aOA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v1nwV-000000001rb-0PHI;
	Thu, 25 Sep 2025 17:31:35 +0200
From: Johan Hovold <johan@kernel.org>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 2/2] iommu: tegra: enable compile testing
Date: Thu, 25 Sep 2025 17:31:20 +0200
Message-ID: <20250925153120.7129-3-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20250925153120.7129-1-johan@kernel.org>
References: <20250925153120.7129-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There seems to be nothing preventing this driver from being compile
tested so enable that to increase build coverage.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/iommu/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 70d29b14d851..da7d7495c8a8 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -247,7 +247,7 @@ config SUN50I_IOMMU
 
 config TEGRA_IOMMU_SMMU
 	bool "NVIDIA Tegra SMMU Support"
-	depends on ARCH_TEGRA
+	depends on ARCH_TEGRA || COMPILE_TEST
 	depends on TEGRA_AHB
 	depends on TEGRA_MC
 	select IOMMU_API
-- 
2.49.1

