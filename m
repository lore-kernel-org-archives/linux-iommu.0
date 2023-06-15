Received: from s.wrqvtzvf.outbound-mail.sendgrid.net (s.wrqvtzvf.outbound-mail.sendgrid.net [149.72.126.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732A9EAF9
	for <iommu@lists.linux.dev>; Thu, 15 Jun 2023 20:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
	h=from:subject:in-reply-to:references:mime-version:to:cc:
	content-transfer-encoding:content-type:cc:content-type:from:subject:to;
	s=s1; bh=InoMtFPn0qTi9rWJ9dL8ZNuMI6SUv/MQcYAVE6/OKuo=;
	b=HiCP8luTDml4dCPktTvI4G2UlOh2JqkOCf/aGXztdfKU9pDKYRW1eYvbwGA77RClrwUq
	ALcRzlSdAjaPwSy12HtHnldT3u/ghdJxx8AVijFBmON6CitofS5IIg7T6xmDyCL9r8mkYu
	Pn31l4ZYbpCyYAuAjOtSgiIJN/+HHf9XwCoLUOJJrkMwkO3KKAIKmdl2Qq0X7c8PnkPNEX
	EeSiTxErTQHQW384TL3a/ErkaCV3oCRTFsTRw9DEepQHGT6MwvTCaRveHm1JBEjtURvBfm
	hKsrYjTBfjHGnjzSrfnZVxqNmPSVEmMiTMVwrX81/HPVVZMCn0HNbhG71JEU7dTw==
Received: by filterdrecv-84b96456cb-bvsrh with SMTP id filterdrecv-84b96456cb-bvsrh-1-648B7046-1F
        2023-06-15 20:10:46.550315811 +0000 UTC m=+3097935.073942733
Received: from bionic.localdomain (unknown)
	by geopod-ismtpd-5 (SG)
	with ESMTP
	id iwNkUP0QQjuksV59p23YJg
	Thu, 15 Jun 2023 20:10:46.259 +0000 (UTC)
From: Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 1/3] iommu: rockchip: Fix discovery table address encoding
Date: Thu, 15 Jun 2023 20:10:46 +0000 (UTC)
Message-Id: <20230615201042.2291867-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230615201042.2291867-1-jonas@kwiboo.se>
References: <20230615201042.2291867-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-SG-EID: 
 =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h2WrMIoUX2Eyj8rSF?=
 =?us-ascii?Q?yVoSoz7tVbeJqQR7WFNCHUyheNyk=2FbPq147L39v?=
 =?us-ascii?Q?x2smspVWTq7LOi9K7FyO33CWUW1L7UjaFU0PxU9?=
 =?us-ascii?Q?fY9A+OC1M8IOdbdEZzZCoiDvYMfc65Jklo2gDZ3?=
 =?us-ascii?Q?I8swnGg=2FCN8pinLBCG7mX1cyNc7dNb+rAPZ3pv?=
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Heiko Stuebner <heiko@sntech.de>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>, Joerg Roedel <jroedel@suse.de>
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
correctly. Also update the bit layout comment for the page address.

These changes render the dte_addr_phys and dma_addr_dte ops unused
and will be removed in a following patch.

Fixes: 227014b33f62 ("iommu: rockchip: Add internal ops to handle variants")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2:
- replace currently with correctly in commit message

 drivers/iommu/rockchip-iommu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 4054030c3237..d46319f77e5c 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -278,8 +278,8 @@ static u32 rk_mk_pte(phys_addr_t page, int prot)
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
@@ -577,7 +577,7 @@ static void log_iova(struct rk_iommu *iommu, int index, dma_addr_t iova)
 	page_offset = rk_iova_page_offset(iova);
 
 	mmu_dte_addr = rk_iommu_read(base, RK_MMU_DTE_ADDR);
-	mmu_dte_addr_phys = rk_ops->dte_addr_phys(mmu_dte_addr);
+	mmu_dte_addr_phys = rk_ops->pt_address(mmu_dte_addr);
 
 	dte_addr_phys = mmu_dte_addr_phys + (4 * dte_index);
 	dte_addr = phys_to_virt(dte_addr_phys);
@@ -967,7 +967,7 @@ static int rk_iommu_enable(struct rk_iommu *iommu)
 
 	for (i = 0; i < iommu->num_mmu; i++) {
 		rk_iommu_write(iommu->bases[i], RK_MMU_DTE_ADDR,
-			       rk_ops->dma_addr_dte(rk_domain->dt_dma));
+			       rk_ops->mk_dtentries(rk_domain->dt_dma));
 		rk_iommu_base_command(iommu->bases[i], RK_MMU_CMD_ZAP_CACHE);
 		rk_iommu_write(iommu->bases[i], RK_MMU_INT_MASK, RK_MMU_IRQ_MASK);
 	}
-- 
2.40.1

