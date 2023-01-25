Received: from xtrwsqbh.outbound-mail.sendgrid.net (xtrwsqbh.outbound-mail.sendgrid.net [167.89.100.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4251379C6
	for <iommu@lists.linux.dev>; Wed, 25 Jan 2023 22:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
	h=from:subject:in-reply-to:references:mime-version:to:cc:
	content-transfer-encoding:content-type:cc:content-type:from:subject:to;
	s=s1; bh=v/+7TIKYeL3kSElncchHEqaouv/ZY1YfqWgkjj3Wl8c=;
	b=lG96mQWWdWgwMCw2+oIkuZjnI+KQC/mIrcJdO6BxadIf1FWJvJRMCJMI3nFxpdh/1jw4
	RyNi+903jOXwy3eHQNVVluXBRKDdgkYk8W7S0dI86YBjCu7UhBm0KgNHoWor3nO4DH0Lo1
	qHpwW1cEM5nMw7jcoc0qRyQW+oQ390mwGDF50yNaLJwDV2ZcLbxS+wBlnVribstX9OI4at
	epcImt3UejXSGdstAu5cLVBlTR3g4C2wtxY5SIfssjXA2R7fhYI5gllHsZYCkqgjwIxEGG
	W3YSbHv60yUK2kNMHimtLTI7m1X+Ti6BOIeV/vdOmJVeGyLctv/WxQaUBhGF67dQ==
Received: by filterdrecv-8569859b9-97x8c with SMTP id filterdrecv-8569859b9-97x8c-1-63D1AAA4-23
        2023-01-25 22:18:12.571250041 +0000 UTC m=+5958685.948296575
Received: from bionic.localdomain (unknown)
	by geopod-ismtpd-5-2 (SG)
	with ESMTP
	id jPjw9qkGQaSNJoFiiH0Fjw
	Wed, 25 Jan 2023 22:18:12.364 +0000 (UTC)
From: Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 1/3] iommu: rockchip: Fix discovery table address encoding
Date: Wed, 25 Jan 2023 22:18:12 +0000 (UTC)
Message-Id: <20230125221809.3275481-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230125221809.3275481-1-jonas@kwiboo.se>
References: <20230125221809.3275481-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-SG-EID: 
 =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0hzE9y3ON40KepxhFB?=
 =?us-ascii?Q?b7izHX1JjXxyuEqDlHxxqRyDUjHN6Q7El3VcYON?=
 =?us-ascii?Q?IjJcWc2HkzGQB9uZ1ZUBAwtO2Uy94ebmA5WmwUc?=
 =?us-ascii?Q?KdHdutd19gGnwDs1wnHeKwL8Equsk0ySpnS9=2FOX?=
 =?us-ascii?Q?0OP6cEsvbsNMcvuFqgWDw0VBzlQQi8E=2Fxp9qGL?=
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Robin Murphy <robin.murphy@arm.com>, Benjamin Gaignard
	<benjamin.gaignard@collabora.com>, iommu@lists.linux.dev,
	linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	Jonas Karlman <jonas@kwiboo.se>
X-Entity-ID: P7KYpSJvGCELWjBME/J5tg==
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii

The address to the discovery table is currently encoded using the
following bit layout.

 31:12 - Address bit 31:0
 11: 4 - Address bit 39:32

This is also the bit layout used by the vendor kernel.

However, testing has shown that addresses to the discovery/page tables
and memory pages are all encoded using the same bit layout.

IOMMU v1:
 31:12 - Address bit 31:0

IOMMU v2:
 31:12 - Address bit 31:0
 11: 8 - Address bit 35:32
  7: 4 - Address bit 39:36

Change to use the mk_dtentries ops to encode the discovery table address
currently. Also update the bit layout comment for the page address.

These changes render the dte_addr_phys and dma_addr_dte ops unused
and will be removed in a following patch.

Fixes: 227014b33f62 ("iommu: rockchip: Add internal ops to handle variants")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/iommu/rockchip-iommu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index f30db22ea5d7..3f92b95e6b67 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -277,8 +277,8 @@ static u32 rk_mk_pte(phys_addr_t page, int prot)
 /*
  * In v2:
  * 31:12 - Page address bit 31:0
- *  11:9 - Page address bit 34:32
- *   8:4 - Page address bit 39:35
+ * 11: 8 - Page address bit 35:32
+ *  7: 4 - Page address bit 39:36
  *     3 - Security
  *     2 - Writable
  *     1 - Readable
@@ -576,7 +576,7 @@ static void log_iova(struct rk_iommu *iommu, int index, dma_addr_t iova)
 	page_offset = rk_iova_page_offset(iova);
 
 	mmu_dte_addr = rk_iommu_read(base, RK_MMU_DTE_ADDR);
-	mmu_dte_addr_phys = rk_ops->dte_addr_phys(mmu_dte_addr);
+	mmu_dte_addr_phys = rk_ops->pt_address(mmu_dte_addr);
 
 	dte_addr_phys = mmu_dte_addr_phys + (4 * dte_index);
 	dte_addr = phys_to_virt(dte_addr_phys);
@@ -966,7 +966,7 @@ static int rk_iommu_enable(struct rk_iommu *iommu)
 
 	for (i = 0; i < iommu->num_mmu; i++) {
 		rk_iommu_write(iommu->bases[i], RK_MMU_DTE_ADDR,
-			       rk_ops->dma_addr_dte(rk_domain->dt_dma));
+			       rk_ops->mk_dtentries(rk_domain->dt_dma));
 		rk_iommu_base_command(iommu->bases[i], RK_MMU_CMD_ZAP_CACHE);
 		rk_iommu_write(iommu->bases[i], RK_MMU_INT_MASK, RK_MMU_IRQ_MASK);
 	}
-- 
2.39.1

