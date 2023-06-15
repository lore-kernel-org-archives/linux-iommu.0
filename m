Received: from s.wrqvtzvf.outbound-mail.sendgrid.net (s.wrqvtzvf.outbound-mail.sendgrid.net [149.72.126.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3311CEAF8
	for <iommu@lists.linux.dev>; Thu, 15 Jun 2023 20:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
	h=from:subject:in-reply-to:references:mime-version:to:cc:
	content-transfer-encoding:content-type:cc:content-type:from:subject:to;
	s=s1; bh=/qL4tWH5vlfUGDltwgczmV318twf9yMJvn1JbUu8GiY=;
	b=Oci/zWt4tgI1SRFLzpYzM1/YhWgKLN++0kQB/UrIyGdcxHE9JjapDGiGKk4efPOZLgf9
	R3H+LI+3oeIyEUf+h2WAi9ni5//WfQGwSAOruYTyMjLZS5z3IuPi3t7QGAWKacHelM1JwA
	7GwXbbL37UEi/aTaJ4i8eNECvwYkE4hYAhicBv4gsVPMGDUyGaK/IuBCSYfExxwi2L2kOY
	eyOA7DEIvALtozWTqML2K25reBwoAKSVs0boFeBnvry3XNkLXJkcWncRpR5tcQo8v4Td1x
	CKAvvto5ebEeVCvNt4wjGv+O/wcCEI1T53uGb/wFi1PFtZ1I10XNtddq1ouhDF+A==
Received: by filterdrecv-65f68489c8-xfp5j with SMTP id filterdrecv-65f68489c8-xfp5j-1-648B7048-2B
        2023-06-15 20:10:48.817052942 +0000 UTC m=+3098087.423003092
Received: from bionic.localdomain (unknown)
	by geopod-ismtpd-5 (SG)
	with ESMTP
	id UaAYmYNhTEmHCxT9KxKCWA
	Thu, 15 Jun 2023 20:10:48.624 +0000 (UTC)
From: Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 3/3] iommu: rockchip: Allocate tables from all available
 memory
Date: Thu, 15 Jun 2023 20:10:49 +0000 (UTC)
Message-Id: <20230615201042.2291867-4-jonas@kwiboo.se>
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
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0hwSnsPxsggRhT=2FD+A?=
 =?us-ascii?Q?9yEtkGRht4pdol+jy3k6QpCorymp5gRwI4WQaU7?=
 =?us-ascii?Q?3dOcXB8iUX5JPwAso4KvAGCmmGsdC8z451Tq4=2FJ?=
 =?us-ascii?Q?Vhj+uM7AsPr4fayZNWBvWvNdu2GZTS+GOlC09Gi?=
 =?us-ascii?Q?apMnPgJd8kJ0myn5b4yf6MB1hHOiueYb75pamR?=
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Heiko Stuebner <heiko@sntech.de>
Cc: Benjamin Gaignard <benjamin.gaignard@collabora.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org, Jonas Karlman <jonas@kwiboo.se>
X-Entity-ID: P7KYpSJvGCELWjBME/J5tg==
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii

Newer Rockchip SoCs, RK356x and RK3588, support more then 4GB of memory.
However, the RK IOMMU driver is using the GFP_DMA32 flag to limit
allocation of the discovery and page tables into memory below 4GB.

Let's remove this limitation now that the discovery table address is
correctly configured for addresses above 4GB.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2:
- no change

 drivers/iommu/rockchip-iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 62be9bf42390..46498fc382ee 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -727,7 +727,7 @@ static u32 *rk_dte_get_page_table(struct rk_iommu_domain *rk_domain,
 	if (rk_dte_is_pt_valid(dte))
 		goto done;
 
-	page_table = (u32 *)get_zeroed_page(GFP_ATOMIC | GFP_DMA32);
+	page_table = (u32 *)get_zeroed_page(GFP_ATOMIC);
 	if (!page_table)
 		return ERR_PTR(-ENOMEM);
 
@@ -1076,7 +1076,7 @@ static struct iommu_domain *rk_iommu_domain_alloc(unsigned type)
 	 * Each level1 (dt) and level2 (pt) table has 1024 4-byte entries.
 	 * Allocate one 4 KiB page for each table.
 	 */
-	rk_domain->dt = (u32 *)get_zeroed_page(GFP_KERNEL | GFP_DMA32);
+	rk_domain->dt = (u32 *)get_zeroed_page(GFP_KERNEL);
 	if (!rk_domain->dt)
 		goto err_free_domain;
 
-- 
2.40.1

