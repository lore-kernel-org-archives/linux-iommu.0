Received: from xvfrqvdb.outbound-mail.sendgrid.net (xvfrqvdb.outbound-mail.sendgrid.net [168.245.72.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406754C83
	for <iommu@lists.linux.dev>; Wed, 25 Jan 2023 22:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
	h=from:subject:mime-version:to:cc:content-transfer-encoding:
	content-type:cc:content-type:from:subject:to;
	s=s1; bh=kGke5edPgidw4Kgicc640oZCu6fsWxaSyhE/gDaRI2Q=;
	b=XblzpKJ8soEMLVg+yUpF3JphdhMNLnsBDfRn0P6AXv0bhSpCAxtIRdbkCfjgnYADXq6B
	35OQVMYQ/Qs8AX3wEmVmtFshtvuNhRQsFhIk671Tf8i9/C2vqpCaccOferEhTngQWtfqkJ
	lZto9omIW91SSahOh9m3ezYKDaOHJa+mPTpU7A4M8oOyKCF8P0U3mYi6Gc42wHiSxJ3SJp
	hb+EQ/5M8PrMYQGixiTitEZmmQ6i6Ek9IIPtqkB6b3K/8ydXDG02H3iaRTGByACeccTu40
	Fu/p9rswK/mqfqqhdxQ5z4StF6MP11eWNNx3PHuGXg7L7k0J4GNNoycbiAbtjUEA==
Received: by filterdrecv-6c4ccfbdd8-lnbvl with SMTP id filterdrecv-6c4ccfbdd8-lnbvl-1-63D1AAA4-15
        2023-01-25 22:18:12.410596366 +0000 UTC m=+3739926.770958580
Received: from bionic.localdomain (unknown)
	by geopod-ismtpd-5-2 (SG)
	with ESMTP
	id hX57VA6qR36DCkAP3QyLzg
	Wed, 25 Jan 2023 22:18:11.960 +0000 (UTC)
From: Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 0/3] iommu: rockchip: Fix discovery table address encoding
Date: Wed, 25 Jan 2023 22:18:12 +0000 (UTC)
Message-Id: <20230125221809.3275481-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-SG-EID: 
 =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h+b6OdEgqdo0FKrYj?=
 =?us-ascii?Q?=2FBcwrsVdNRHqB+3oeHwdNZpVrS5W5rxt4OxE4e9?=
 =?us-ascii?Q?6T+9x5PVTw5l1hZ=2FeEI5COV2toxaK+K9H7APC38?=
 =?us-ascii?Q?NC+JCNjSdmhu9kdYYBBIDqRUTaRr6qHcKdoFdKa?=
 =?us-ascii?Q?SHSZ1w+FRJ2WC0LBd=2FyXYE5vWmX2i4JjLyJVQr?=
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Robin Murphy <robin.murphy@arm.com>, Benjamin Gaignard
	<benjamin.gaignard@collabora.com>, iommu@lists.linux.dev,
	linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	Jonas Karlman <jonas@kwiboo.se>
X-Entity-ID: P7KYpSJvGCELWjBME/J5tg==
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii

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

Jonas Karlman (3):
  iommu: rockchip: Fix discovery table address encoding
  iommu: rockchip: Remove unused variant ops
  iommu: rockchip: Allocate tables from all available memory

 drivers/iommu/rockchip-iommu.c | 45 +++++-----------------------------
 1 file changed, 6 insertions(+), 39 deletions(-)

-- 
2.39.1

