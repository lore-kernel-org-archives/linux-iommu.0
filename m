Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63693A4F32;
	Thu, 20 Aug 2026 19:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787253128; cv=none; b=dpil4v6MkPAlQCn56An83QrU23RlmP6R9PALJenm7G+ypfygNU23hBdv7zymWnzoWN0UguPI4XDBqk5HYuHbfEDMoTirbg6y17KBRqrBJryUkQRyTGjybx4AkZf5imO3FZ8ZkjRqu4d6TD4PCE9ED2l0Z4oSeDKYdMUy6SNxfQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787253128; c=relaxed/simple;
	bh=eOP+RA4mnWGtFVmDZnso+934UzTGqKnTNVZ92PuZ8Bc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AeTWdaW5q5j/zk6bb3qp8bOaGCCL3i5ajVf/MxjjoWjCcmz9wb7TU3GXqlyg6GD4+JTW3VnSksICV+nGJmnTCQXdsMpKkede/vGr/xc2wA9ZLAW4V89JRA58K9q+CY2gqKKELZpuqM+j2vmHc4Om2taz0vJ75FDS3e2O1ywQhu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eO5QPypk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eO5QPypk"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 442C0C2BCB3;
	Thu, 20 Aug 2026 19:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787253128;
	bh=eOP+RA4mnWGtFVmDZnso+934UzTGqKnTNVZ92PuZ8Bc=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=eO5QPypkD5JbvqoQcnM+FyUJ/ZRfE15b+GHfCW/iHiw/vSHEIemIzizL+tqqXUgnW
	 eS1bmB2/j9Yecj/m+9OcNdPeD4BaAzzIrghbCf0Ltprnblvjnh4WHB2J0PEcI1Bt3y
	 u4oXUdRs8gqrH0MQuU/LfVnyYVEvKdjfd3ZpOSTw2MknsbxSwsimMNkvHJj6KOPmgo
	 dktzW+AD9hnBi0HywbrGn2HOzk1JI2ikoNuCy91XYeDKIQQH4TZtsnlxIsG/fwuMTB
	 V5ipaEviUNX8CWuXrWZk0u/IO2F4D9YWRVyQS8JWG7mK6iSYybQJu2VW2dP0TtPNvf
	 YNdlYeSxknsuA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF34C5DF89;
	Thu, 20 Aug 2026 19:12:08 +0000 (UTC)
From: Markuss Broks via B4 Relay <devnull+markuss.broks.gmail.com@kernel.org>
Subject: [PATCH 0/4] IOMMU driver improvements for modern Exynos SysMMUs
Date: Thu, 20 Aug 2026 22:12:04 +0300
Message-Id: <20260820-exynos-iommu-fixes-v1-0-6bbcd673bb15@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMUQqDMBCE4avIPndhG0TEq5Q+tHHSrmBSslUU8
 e7G9vFj+GcjQ1YYddVGGbOaplhwvVTk34/4AmtfTE5cI60TxrLGZKxpHCcOusAYgrpvgwQvDZX
 wk/EbSne7/23Tc4D/nk+07wdZ0Jc7dgAAAA==
X-Change-ID: 20260820-exynos-iommu-fixes-e0e4d8f0fc06
To: Marek Szyprowski <m.szyprowski@samsung.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Markuss Broks <markuss.broks@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787253126; l=2066;
 i=markuss.broks@gmail.com; s=20260803; h=from:subject:message-id;
 bh=eOP+RA4mnWGtFVmDZnso+934UzTGqKnTNVZ92PuZ8Bc=;
 b=ISPOHNvudmR8znZALCiIIFA6iPpiCNxVuLytNm3IHeDKPyijmVlhi5VGISK+wzWdDUObCBnFt
 bF++bdKHIZQAXUKtRHk49vIbKTWhQjlf4dJI0ha3F3Vt0gwgRVZNcuV
X-Developer-Key: i=markuss.broks@gmail.com; a=ed25519;
 pk=oKzGUTm30BCDqinRMpiHQqByOx1mp2mwmhg80Mv7Zg4=
X-Endpoint-Received: by B4 Relay for markuss.broks@gmail.com/20260803 with
 auth_id=911
X-Original-From: Markuss Broks <markuss.broks@gmail.com>
Reply-To: markuss.broks@gmail.com

Newer SysMMU v7+ instances can lack BLOCK mode: CAPA1 bit 15 reports
that the CTRL_BLOCK function is not implemented, and MMU_STATUS never
reports a blocked state. The SysMMUs on Exynos 8835 are such
instances.

The driver currently assumes blocking always works, with two
consequences on such hardware:

The enable path writes CTRL_BLOCK first, which there acts as a plain 
enable and starts translation before the page table base is programmed.

Worse, both TLB invalidation paths gate the invalidation writes on
sysmmu_block() succeeding, which it never does - so every unmap silently
skips the invalidation. A stale TLB entry is a valid entry pointing
at a freed page, so nothing ever faults: the device reads back garbage
and its writebacks corrupt whatever the kernel has since reused those pages for.
 
This was tracked down on Exynos 8835 with the MFC, where the
first decoder session of a boot worked and later sessions produced
garbage along with random kernel memory corruption.
Patches 1-3 add detection of the capability bit and adapt the enable
sequence and the invalidation paths, matching the vendor driver's
handling of these parts. Patch 4 is an independent debugging
improvement: decode the v7 fault transaction info word (AxID/AxLEN),
which identifies the issuing port when a master containing several
DMA engines faults.

Tested on the Samsung Galaxy Tab S9 FE (Exynos 8835/Exynos 1380).

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
---
Markuss Broks (4):
      iommu/exynos: detect SysMMUs without BLOCK mode
      iommu/exynos: fix the enable sequence for no-block SysMMUs
      iommu/exynos: fix TLB invalidation for no-block SysMMUs
      iommu/exynos: decode the v7 fault transaction info

 drivers/iommu/exynos-iommu.c | 37 +++++++++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)
---
base-commit: 415606a7be939835db9b0d6b711887586646346d
change-id: 20260820-exynos-iommu-fixes-e0e4d8f0fc06

Best regards,
--  
Markuss Broks <markuss.broks@gmail.com>


