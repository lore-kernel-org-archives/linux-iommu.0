Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81333A5445;
	Thu, 20 Aug 2026 19:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787253129; cv=none; b=U1znQECq2mvDeHdOoXx5U9UxFzeOplvIIVQwJkJoy1DvHGcnZiRciwn4TSYBEOMgeaShh+ZWlCRkNY9Rzrjd9jsnxG1wqGu0R4FvHac2O6W7SbWHMzVd+nR3JYGEmhQz1TpFxSL7q+kqI4kMHyODbkSf55clGxbA54vdEOghVBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787253129; c=relaxed/simple;
	bh=28WNZql7k9NGuBzPlZkL9rdF4eUy8pQ98jiA00AuOyQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GMJQUIBdu3MMLck3010tt0StIflW6Jl5J749plDdJSt4jy7RGd6J2ZkTJENiMQqXUDzl5mb4em5dBBBVnXAt17pUo5PjUFYdEMBrpuFO1hWEd+/TIvBL6lmYD/JMZajiK2GF6AjZPHvhsILnJ8CW/JsZ2NjXMlBDIWEXLvK7KVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ThkQITMf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ThkQITMf"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B609DC2BD01;
	Thu, 20 Aug 2026 19:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787253128;
	bh=28WNZql7k9NGuBzPlZkL9rdF4eUy8pQ98jiA00AuOyQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ThkQITMfrqFTbdWc7HesZUPTfIPVoWj44oiUzNsWvmxZgMqhFXkUKWTN2eq4ME0CL
	 q/Pl6mZQUDNYmUUPgbTnjM5HySPVPNL1ftErVL+q3Ord+3qzlCIVugyCOSB6LAO51/
	 v8eBHW8hw2UKV1aT71GXjfvwMvVoOAj/ML3LHtro5ydQFK+5LZSrNQhSR5g4HSKAL0
	 SLlbTZY61xyAdJlc5ROvSIkCxqEgktuy6+hLr57W9NBVEw8TIuPklobyVwlrCMnhjY
	 ixPeSQmLbgvvEMjAvGOUr2l0HipKM97wZFU/30euOLjT0NZgYz3teVhPVLyFvmT9Rp
	 7wKeFkKSq+PSg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3965C5DF89;
	Thu, 20 Aug 2026 19:12:08 +0000 (UTC)
From: Markuss Broks via B4 Relay <devnull+markuss.broks.gmail.com@kernel.org>
Date: Thu, 20 Aug 2026 22:12:08 +0300
Subject: [PATCH 4/4] iommu/exynos: decode the v7 fault transaction info
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260820-exynos-iommu-fixes-v1-4-6bbcd673bb15@gmail.com>
References: <20260820-exynos-iommu-fixes-v1-0-6bbcd673bb15@gmail.com>
In-Reply-To: <20260820-exynos-iommu-fixes-v1-0-6bbcd673bb15@gmail.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Markuss Broks <markuss.broks@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787253126; l=2986;
 i=markuss.broks@gmail.com; s=20260803; h=from:subject:message-id;
 bh=ds2FwQf93t6aWc7pL7d/0AcQafl2TKcR73r3avK3lF8=;
 b=YUghpcT3gXo+61EMw7hA+qlTiMj8yjh8tzM6VDTi7YPQ3VKz8u0bFvtG0QjbiBNKUcMwHH56R
 lT9X87yn00mAy1WcXOJKoOOwxQsnmgcSMKU4sIwgXItFBMqnTdANjT/
X-Developer-Key: i=markuss.broks@gmail.com; a=ed25519;
 pk=oKzGUTm30BCDqinRMpiHQqByOx1mp2mwmhg80Mv7Zg4=
X-Endpoint-Received: by B4 Relay for markuss.broks@gmail.com/20260803 with
 auth_id=911
X-Original-From: Markuss Broks <markuss.broks@gmail.com>
Reply-To: markuss.broks@gmail.com

From: Markuss Broks <markuss.broks@gmail.com>

The v7+ fault registers carry a transaction-info word alongside the
faulting address, but it is only used to derive the read/write
direction and then thrown away.  Keep it and print it: AxID identifies
which port inside the master issued the faulting transaction, which is
the only way to tell apart the several DMA engines a single block can
contain, and the remaining bits of the raw word are implementation
defined and worth having in a fault report.

Define the known fields of the word instead of open-coding the masks;
this also names the direction bit the driver was already testing as a
bare BIT(20).

Gate the print on the variant having a fault_info register, so older
SysMMUs are unaffected.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
---
 drivers/iommu/exynos-iommu.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 29b27c7e400a..0bca3662fdc2 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -8,6 +8,7 @@
 #define DEBUG
 #endif
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/dma-mapping.h>
 #include <linux/err.h>
@@ -144,6 +145,9 @@ static u32 lv2ent_offset(sysmmu_iova_t iova)
 #define CAPA0_CAPA1_EXIST		BIT(11)
 #define CAPA1_VCR_ENABLED		BIT(14)
 #define CAPA1_NO_BLOCK_MODE		BIT(15)
+#define FAULT_INFO_AXID			GENMASK(15, 0)
+#define FAULT_INFO_AXLEN		GENMASK(19, 16)
+#define FAULT_INFO_WRITE		BIT(20)
 
 /* common registers */
 #define REG_MMU_CTRL		0x000
@@ -194,6 +198,7 @@ struct sysmmu_fault {
 	sysmmu_iova_t addr;	/* IOVA address that caused fault */
 	const char *name;	/* human readable fault name */
 	unsigned int type;	/* fault type for report_iommu_fault() */
+	u32 info;		/* raw transaction info (v7+ only) */
 };
 
 struct sysmmu_v1_fault_info {
@@ -360,7 +365,8 @@ static int exynos_sysmmu_v7_get_fault_info(struct sysmmu_drvdata *data,
 
 	fault->addr = readl(SYSMMU_REG(data, fault_va));
 	fault->name = sysmmu_v7_fault_names[itype % 4];
-	fault->type = (info & BIT(20)) ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ;
+	fault->type = (info & FAULT_INFO_WRITE) ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ;
+	fault->info = info;
 
 	return 0;
 }
@@ -558,6 +564,12 @@ static void show_fault_information(struct sysmmu_drvdata *data,
 		dev_name(data->master),
 		fault->type == IOMMU_FAULT_READ ? "READ" : "WRITE",
 		fault->name, fault->addr);
+	/* AxID identifies the issuing port inside the master */
+	if (data->variant->fault_info)
+		dev_err(data->sysmmu, "transaction info %#010x: AxID %#lx, AxLEN %lu\n",
+			fault->info,
+			FIELD_GET(FAULT_INFO_AXID, fault->info),
+			FIELD_GET(FAULT_INFO_AXLEN, fault->info));
 	dev_dbg(data->sysmmu, "Page table base: %pa\n", &data->pgtable);
 	ent = section_entry(phys_to_virt(data->pgtable), fault->addr);
 	dev_dbg(data->sysmmu, "\tLv1 entry: %#x\n", *ent);

-- 
2.55.0


