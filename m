Received: from s.wrqvtbkv.outbound-mail.sendgrid.net (s.wrqvtbkv.outbound-mail.sendgrid.net [149.72.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAB6EAF8
	for <iommu@lists.linux.dev>; Thu, 15 Jun 2023 20:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
	h=from:subject:mime-version:to:cc:content-transfer-encoding:
	content-type:cc:content-type:from:subject:to;
	s=s1; bh=If/pDcNZHjKHg2xr7fPICwEYrvkMiPF0Yu0cd9xm+8c=;
	b=GozorMfIUTKX2p3yMPpaBV0J/anZcRNzQgygrAoAMUjiXVA02nBHk2H3MTrL64UPq0dK
	IW61phWauueZvWEkTK4KTjgePv9b92oV9I8Ez81pzG7hub3pPoWkXydF6hbp1N6f6FvJlm
	D+tKbsk6sW4+Y0evTou3YOc+ycEPTDXxcRJbyuBdPty63gSiFnSFM5NshpkYxuT/Cx5SMD
	o5I1gfiEqF9FS56eCG5eB7eNGPrpbsmfLmbM8yMUmz05oEd/GvvYB9gqKHWuOe9vT3twAJ
	0j4CLyM9I/5f6eC8tddHTrMHudrlc6DvtTTsOzKHgLgwbgkiF/34Pn40nODWvSPQ==
Received: by filterdrecv-77869f68cc-lcgp6 with SMTP id filterdrecv-77869f68cc-lcgp6-1-648B7045-14
        2023-06-15 20:10:45.330247636 +0000 UTC m=+3098087.523654011
Received: from bionic.localdomain (unknown)
	by geopod-ismtpd-5 (SG)
	with ESMTP
	id M8m6e9nORhaWVL_Bj7hb3A
	Thu, 15 Jun 2023 20:10:44.821 +0000 (UTC)
From: Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 0/3] iommu: rockchip: Fix discovery table address encoding
Date: Thu, 15 Jun 2023 20:10:45 +0000 (UTC)
Message-Id: <20230615201042.2291867-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-SG-EID: 
 =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h7eTuGAfP89fgI7Mo?=
 =?us-ascii?Q?5nZ7wt3U4bGdn6ikkP5Zd3dO0neB=2F5LK2JyiBDO?=
 =?us-ascii?Q?u29YKFWbCeBwjYkAy19YoMXMyir3tW064N650=2F+?=
 =?us-ascii?Q?UHQKIRJs5nJqE0NE1JvlC9kV2qLpWLjE8Vj37ty?=
 =?us-ascii?Q?eHIdNOAI8Ct1brgdtzpx716NFLho7ZgbPiw2R=2F?=
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Heiko Stuebner <heiko@sntech.de>
Cc: Benjamin Gaignard <benjamin.gaignard@collabora.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org, Jonas Karlman <jonas@kwiboo.se>
X-Entity-ID: P7KYpSJvGCELWjBME/J5tg==
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii

This is a re-send of a series sent out in January, see [1].

The address to the discovery table is currently encoded using an
incorrect bit layout when configured into the MMU_DTE_ADDR reg.

This currently do not cause any issue because the discovery and page
tables is allocated in memory below 4GB thanks to the GFP_DMA32 flag.

Testing has shown that the discovery table address should be encoded
using the same bit layout as the page table and memory page addresses.

Removing the GFP_DMA32 on a RK3568 with 8GB of memory will result in:

[    0.907236] rk_iommu fe043e00.iommu: Page fault at 0x00000000ff801000 of type read
[    0.907264] rk_iommu fe043e00.iommu: iova = 0x00000000ff801000: dte_index: 0x3fe pte_index: 0x1 page_offset: 0x0
[    0.907281] rk_iommu fe043e00.iommu: mmu_dte_addr: 0x000000010189a000 dte@0x000000010189aff8: 0x1722101 valid: 1 pte@0x0000000101722004: 0x2c01107 valid: 1 page@0x0000000102c01000 flags: 0x106

This series fixes this by using the existing mk_dtentries instead of the
dma_addr_dte ops to encode the discovery table address, removes unused
ops and finally removes the GFP_DMA32 flag to allow for discovery and
page tables to be allocated in memory above 4GB.

Changes in v2:
- no changes, rebased on next-20230615

This series can also be found at [2].

[1] https://lore.kernel.org/all/20230125221809.3275481-1-jonas@kwiboo.se/
[2] https://github.com/Kwiboo/linux-rockchip/commits/next-20230615-iommu

Jonas Karlman (3):
  iommu: rockchip: Fix discovery table address encoding
  iommu: rockchip: Remove unused variant ops
  iommu: rockchip: Allocate tables from all available memory

 drivers/iommu/rockchip-iommu.c | 45 +++++-----------------------------
 1 file changed, 6 insertions(+), 39 deletions(-)

-- 
2.40.1

