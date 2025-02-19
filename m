Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDCE1DE8A9;
	Wed, 19 Feb 2025 09:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739956438; cv=none; b=OoJH4v7XKjWrr/ymTowE5qjvrHvKYXBCzNkPNtuesdoESQUxF+54N8/R+o0nHbr9pQi6a0i4lW1eh14/QA7iHlwHb7yXKMXoeNoRxjhYv1Qc5o4ntojhIcjY5jXUzr0Z7CMoaeBjT6T0Q5ACd13LIxhmld1Mm6eiSXFfWxxBPz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739956438; c=relaxed/simple;
	bh=XTPomKjOfo5fAZ/BQxA/LrGkWT2afQunCwLoYv6XiKI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=vEbuEXRDnpOsnDKgWGO3QPYb8qZrxO3L2Xn9/EUUUKzJiJZ8rNYZCICrjpBbipYrNVY24ThddjiY4ydU1HnsZDXMUv9V2iHcxoZrPhC+3XawBWHRRoltbSXDc7SnVkSRiI3vz27P7XQ6x2xXY/0dgfv2Hdt6g1ACgN13hfArZD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dsBx5Lty; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dsBx5Lty"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C268BC4CEE7;
	Wed, 19 Feb 2025 09:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739956437;
	bh=XTPomKjOfo5fAZ/BQxA/LrGkWT2afQunCwLoYv6XiKI=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=dsBx5LtyRMxy0v6pW1s1GfSsluBHyxc2OhwGoiOeYJ5GMVOWsFGDUDEWPExjzfIYR
	 xIgHJptMDAW6LzBGhbcirhXVghCFTE7KcJZ4etQWjUTb/z6UDSC5STNPlrB8ek4ghC
	 kBGWacCy7oeRkMnEHyky7BrxPtNzINqNqKKlS8GCUhQbPwKSZa7ONZT7b19d8WW1zf
	 o2gpGMDo8DR3+L/S1k9m6C6AFzgj4cxpSilGtWzk9OiuScB7WYCsOTD5etBtZKze+Z
	 JUhtXX3Pk7RqOkYCI4dhyEvId6lF2lz1Jl+FKCdLx54m5x9p833O0NnR0dF0gg7qMe
	 0FgLjyAlfQbmg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE1BAC021AA;
	Wed, 19 Feb 2025 09:13:57 +0000 (UTC)
From: Sasha Finkelstein via B4 Relay <devnull+fnkl.kernel.gmail.com@kernel.org>
Date: Wed, 19 Feb 2025 10:13:53 +0100
Subject: [PATCH] iommu/io-pgtable-dart: Only set subpage protection disable
 for DART 1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250219-dart2-no-sp-disable-v1-1-9f324cfa4e70@gmail.com>
X-B4-Tracking: v=1; b=H4sIANCgtWcC/x3MMQqAMAxA0atIZgM1oqJXEYfWRg1IlUZEkN7d4
 viG/19QjsIKQ/FC5FtUjpBRlQXMmw0ro/hsIEONoapHb+NFGA7UE72odTvjUjemo9k537eQyzP
 yIs9/HaeUPitxVDtlAAAA
X-Change-ID: 20250219-dart2-no-sp-disable-f35072cbbd96
To: Sven Peter <sven@svenpeter.dev>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Hector Martin <marcan@marcan.st>, Rob Herring <robh@kernel.org>, 
 Janne Grunau <j@jannau.net>
Cc: Joerg Roedel <jroedel@suse.de>, asahi@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Asahi Lina <lina@asahilina.net>, 
 Sasha Finkelstein <fnkl.kernel@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739956436; l=1398;
 i=fnkl.kernel@gmail.com; s=20241124; h=from:subject:message-id;
 bh=4vIOKtPg+OtkD6k1fuo7D/3yWj1rRgyOMiGeGabXJoQ=;
 b=2XvYZiLPQ55QTshLqUD4aTt/pUSerHvszW6QhuxyTNjK/hq2NYquR+5dssye/dFu6aJEtq/su
 c/ZlgVVyC4ICgNDsQpVVlQtMaUH4ApO55G9hM21HQQvekVzMzpLohQw
X-Developer-Key: i=fnkl.kernel@gmail.com; a=ed25519;
 pk=aSkp1PdZ+eF4jpMO6oLvz/YfT5XkBUneWwyhQrOgmsU=
X-Endpoint-Received: by B4 Relay for fnkl.kernel@gmail.com/20241124 with
 auth_id=283
X-Original-From: Sasha Finkelstein <fnkl.kernel@gmail.com>
Reply-To: fnkl.kernel@gmail.com

From: Asahi Lina <lina@asahilina.net>

Subpage protection can't be disabled on t6000-style darts,
as such the disable flag no longer applies, and probably
even affects something else.

Fixes: dc09fe1c5edd ("iommu/io-pgtable-dart: Add DART PTE support for t6000")
Signed-off-by: Asahi Lina <lina@asahilina.net>
Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
---
 drivers/iommu/io-pgtable-dart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/io-pgtable-dart.c b/drivers/iommu/io-pgtable-dart.c
index c004640640ee50d01dd54c38e89162c0fcb1988f..06aca9ab52f9a811a2608ae75155a36919799c74 100644
--- a/drivers/iommu/io-pgtable-dart.c
+++ b/drivers/iommu/io-pgtable-dart.c
@@ -135,7 +135,6 @@ static int dart_init_pte(struct dart_io_pgtable *data,
 	pte |= FIELD_PREP(APPLE_DART_PTE_SUBPAGE_START, 0);
 	pte |= FIELD_PREP(APPLE_DART_PTE_SUBPAGE_END, 0xfff);
 
-	pte |= APPLE_DART1_PTE_PROT_SP_DIS;
 	pte |= APPLE_DART_PTE_VALID;
 
 	for (i = 0; i < num_entries; i++)
@@ -211,6 +210,7 @@ static dart_iopte dart_prot_to_pte(struct dart_io_pgtable *data,
 	dart_iopte pte = 0;
 
 	if (data->iop.fmt == APPLE_DART) {
+		pte |= APPLE_DART1_PTE_PROT_SP_DIS;
 		if (!(prot & IOMMU_WRITE))
 			pte |= APPLE_DART1_PTE_PROT_NO_WRITE;
 		if (!(prot & IOMMU_READ))

---
base-commit: 2408a807bfc3f738850ef5ad5e3fd59d66168996
change-id: 20250219-dart2-no-sp-disable-f35072cbbd96


