Received: from wrqvxttq.outbound-mail.sendgrid.net (wrqvxttq.outbound-mail.sendgrid.net [149.72.167.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9314C83
	for <iommu@lists.linux.dev>; Wed, 25 Jan 2023 22:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
	h=from:subject:in-reply-to:references:mime-version:to:cc:
	content-transfer-encoding:content-type:cc:content-type:from:subject:to;
	s=s1; bh=sHEGuDI+QAsBRHQDABhGANagI0i+/Ox7a/1vEXYK3PY=;
	b=oY4iPqE0yBl/0nVlsDUz8K3Qencz96m5NjSKWs3AakkW53Yafd8qDpk2aqNePoJm3nWo
	VseGSBWv4EsVWBCFZD3YsPpdJ0K/DRn85ZHLyGqRgY5TigASzJbXisqcxUXVMGYk1WY3cU
	bkB7uZ8etxEtAyl+k/x1gbYzId9qwj/0NCucjTITqswWlQkFvSNU8i7xm5gL6EdfY6Q/3c
	vIDYwwyODTl7y+0dXkP4yYhJWn6mgITdo4p4qf+EXAYDVd5FLQYi3f+wU6ObnM1V/gVS08
	F3UuM8jsjeuzhO6vXHlN17eH7cLbpXvcyBEFTPPw1tcMfZ6I190XX8fJpr3H0oaw==
Received: by filterdrecv-8569859b9-xfh5v with SMTP id filterdrecv-8569859b9-xfh5v-1-63D1AAB7-2A
        2023-01-25 22:18:31.954514689 +0000 UTC m=+5958699.083386124
Received: from bionic.localdomain (unknown)
	by geopod-ismtpd-5-2 (SG)
	with ESMTP
	id NI2nFHi_TkuaGBqMj9k9gA
	Wed, 25 Jan 2023 22:18:20.957 +0000 (UTC)
From: Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 3/3] iommu: rockchip: Allocate tables from all available
 memory
Date: Wed, 25 Jan 2023 22:18:32 +0000 (UTC)
Message-Id: <20230125221809.3275481-4-jonas@kwiboo.se>
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
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h=2FX+CIU4kFU9zG1Gi?=
 =?us-ascii?Q?wEbP=2F5kLr6ZQf9m6wDe9ilvpgqcQh5sPBuMV6GU?=
 =?us-ascii?Q?W1ay67FN9Xi4rS28UZ8dNzfF4=2FiuyI3vYOCDjtu?=
 =?us-ascii?Q?4ykHKIr1y6V3H4fomktoifHfMvaPEgLafmJNCns?=
 =?us-ascii?Q?DD6ivvrNicWW+uiegRS16P029i7KtTcirhDRYr?=
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Robin Murphy <robin.murphy@arm.com>, Benjamin Gaignard
	<benjamin.gaignard@collabora.com>, iommu@lists.linux.dev,
	linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	Jonas Karlman <jonas@kwiboo.se>
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
 drivers/iommu/rockchip-iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index ca47f198455e..799ecc2c0d0e 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -726,7 +726,7 @@ static u32 *rk_dte_get_page_table(struct rk_iommu_domain *rk_domain,
 	if (rk_dte_is_pt_valid(dte))
 		goto done;
 
-	page_table = (u32 *)get_zeroed_page(GFP_ATOMIC | GFP_DMA32);
+	page_table = (u32 *)get_zeroed_page(GFP_ATOMIC);
 	if (!page_table)
 		return ERR_PTR(-ENOMEM);
 
@@ -1047,7 +1047,7 @@ static struct iommu_domain *rk_iommu_domain_alloc(unsigned type)
 	 * Each level1 (dt) and level2 (pt) table has 1024 4-byte entries.
 	 * Allocate one 4 KiB page for each table.
 	 */
-	rk_domain->dt = (u32 *)get_zeroed_page(GFP_KERNEL | GFP_DMA32);
+	rk_domain->dt = (u32 *)get_zeroed_page(GFP_KERNEL);
 	if (!rk_domain->dt)
 		goto err_free_domain;
 
-- 
2.39.1

