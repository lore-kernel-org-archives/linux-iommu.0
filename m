Return-Path: <SRS0=C308=ZZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA4BC43141
	for <iommu@archiver.kernel.org>; Tue,  3 Dec 2019 11:48:09 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB4B020684
	for <iommu@archiver.kernel.org>; Tue,  3 Dec 2019 11:48:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB4B020684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 970DC87A0A;
	Tue,  3 Dec 2019 11:48:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JKySivhusW3D; Tue,  3 Dec 2019 11:48:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5717287A14;
	Tue,  3 Dec 2019 11:48:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3A900C1799;
	Tue,  3 Dec 2019 11:48:08 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 06F9AC087F
 for <iommu@lists.linux-foundation.org>; Tue,  3 Dec 2019 11:48:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id E70E987A2E
 for <iommu@lists.linux-foundation.org>; Tue,  3 Dec 2019 11:48:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rK2irH6S95bv for <iommu@lists.linux-foundation.org>;
 Tue,  3 Dec 2019 11:48:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 1A3FA87A14
 for <iommu@lists.linux-foundation.org>; Tue,  3 Dec 2019 11:48:05 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 523B6AF93;
 Tue,  3 Dec 2019 11:48:03 +0000 (UTC)
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To: andrew.murray@arm.com, maz@kernel.org, linux-kernel@vger.kernel.org,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Tariq Toukan <tariqt@mellanox.com>, Rob Herring <robh+dt@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 bcm-kernel-feedback-list@broadcom.com, Eric Anholt <eric@anholt.net>,
 Stefan Wahren <wahrenst@gmx.net>, Shawn Lin <shawn.lin@rock-chips.com>,
 Heiko Stuebner <heiko@sntech.de>, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v4 8/8] linux/log2.h: Use roundup/dow_pow_two() on 64bit
 calculations
Date: Tue,  3 Dec 2019 12:47:41 +0100
Message-Id: <20191203114743.1294-9-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203114743.1294-1-nsaenzjulienne@suse.de>
References: <20191203114743.1294-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Cc: linux-arm-kernel@lists.infradead.org,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, mbrugger@suse.com,
 devicetree@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-pci@vger.kernel.org, phil@raspberrypi.org, jeremy.linton@arm.com,
 linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-rpi-kernel@lists.infradead.org, james.quinlan@broadcom.com,
 netdev@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 linux-rockchip@lists.infradead.org, "David S. Miller" <davem@davemloft.net>,
 Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, Len Brown <lenb@kernel.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

The function now is safe to use while expecting a 64bit value. Use it
where relevant.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/acpi/arm64/iort.c                        | 2 +-
 drivers/net/ethernet/mellanox/mlx4/en_clock.c    | 3 ++-
 drivers/of/device.c                              | 3 ++-
 drivers/pci/controller/cadence/pcie-cadence-ep.c | 3 ++-
 drivers/pci/controller/cadence/pcie-cadence.c    | 3 ++-
 drivers/pci/controller/pcie-brcmstb.c            | 3 ++-
 drivers/pci/controller/pcie-rockchip-ep.c        | 5 +++--
 kernel/dma/direct.c                              | 2 +-
 8 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 33f71983e001..9950c9757092 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -1090,7 +1090,7 @@ void iort_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size)
 		 * firmware.
 		 */
 		end = dmaaddr + size - 1;
-		mask = DMA_BIT_MASK(ilog2(end) + 1);
+		mask = roundup_pow_of_two(end) - 1;
 		dev->bus_dma_limit = end;
 		dev->coherent_dma_mask = mask;
 		*dev->dma_mask = mask;
diff --git a/drivers/net/ethernet/mellanox/mlx4/en_clock.c b/drivers/net/ethernet/mellanox/mlx4/en_clock.c
index 024788549c25..23dcb18224d4 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_clock.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_clock.c
@@ -33,6 +33,7 @@
 
 #include <linux/mlx4/device.h>
 #include <linux/clocksource.h>
+#include <linux/log2.h>
 
 #include "mlx4_en.h"
 
@@ -252,7 +253,7 @@ static u32 freq_to_shift(u16 freq)
 {
 	u32 freq_khz = freq * 1000;
 	u64 max_val_cycles = freq_khz * 1000 * MLX4_EN_WRAP_AROUND_SEC;
-	u64 max_val_cycles_rounded = 1ULL << fls64(max_val_cycles - 1);
+	u64 max_val_cycles_rounded = roundup_pow_of_two(max_val_cycles);
 	/* calculate max possible multiplier in order to fit in 64bit */
 	u64 max_mul = div64_u64(ULLONG_MAX, max_val_cycles_rounded);
 
diff --git a/drivers/of/device.c b/drivers/of/device.c
index e9127db7b067..7259922d2078 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -11,6 +11,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/slab.h>
 #include <linux/platform_device.h>
+#include <linux/log2.h>
 
 #include <asm/errno.h>
 #include "of_private.h"
@@ -149,7 +150,7 @@ int of_dma_configure(struct device *dev, struct device_node *np, bool force_dma)
 	 * set by the driver.
 	 */
 	end = dma_addr + size - 1;
-	mask = DMA_BIT_MASK(ilog2(end) + 1);
+	mask = roundup_pow_of_two(end) - 1;
 	dev->coherent_dma_mask &= mask;
 	*dev->dma_mask &= mask;
 	/* ...but only set bus limit if we found valid dma-ranges earlier */
diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
index 1c173dad67d1..72eda0b2f939 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
@@ -10,6 +10,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/sizes.h>
+#include <linux/log2.h>
 
 #include "pcie-cadence.h"
 
@@ -65,7 +66,7 @@ static int cdns_pcie_ep_set_bar(struct pci_epc *epc, u8 fn,
 	 * roundup_pow_of_two() returns an unsigned long, which is not suited
 	 * for 64bit values.
 	 */
-	sz = 1ULL << fls64(sz - 1);
+	sz = roundup_pow_of_two(sz);
 	aperture = ilog2(sz) - 7; /* 128B -> 0, 256B -> 1, 512B -> 2, ... */
 
 	if ((flags & PCI_BASE_ADDRESS_SPACE) == PCI_BASE_ADDRESS_SPACE_IO) {
diff --git a/drivers/pci/controller/cadence/pcie-cadence.c b/drivers/pci/controller/cadence/pcie-cadence.c
index cd795f6fc1e2..b1689f725b41 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.c
+++ b/drivers/pci/controller/cadence/pcie-cadence.c
@@ -4,6 +4,7 @@
 // Author: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
 
 #include <linux/kernel.h>
+#include <linux/log2.h>
 
 #include "pcie-cadence.h"
 
@@ -15,7 +16,7 @@ void cdns_pcie_set_outbound_region(struct cdns_pcie *pcie, u8 fn,
 	 * roundup_pow_of_two() returns an unsigned long, which is not suited
 	 * for 64bit values.
 	 */
-	u64 sz = 1ULL << fls64(size - 1);
+	u64 sz = roundup_pow_of_two(size);
 	int nbits = ilog2(sz);
 	u32 addr0, addr1, desc0, desc1;
 
diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 7ba06a0e1a71..e705d9d73030 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -627,7 +627,8 @@ static inline int brcm_pcie_get_rc_bar2_size_and_offset(struct brcm_pcie *pcie,
 		return -ENODEV;
 
 	*rc_bar2_offset = -entry->offset;
-	*rc_bar2_size = 1ULL << fls64(entry->res->end - entry->res->start);
+	*rc_bar2_size = roundup_pow_of_two(entry->res->end -
+					   entry->res->start + 1);
 
 	/*
 	 * We validate the inbound memory view even though we should trust
diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
index d743b0a48988..83665f5f804a 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -16,6 +16,7 @@
 #include <linux/platform_device.h>
 #include <linux/pci-epf.h>
 #include <linux/sizes.h>
+#include <linux/log2.h>
 
 #include "pcie-rockchip.h"
 
@@ -70,7 +71,7 @@ static void rockchip_pcie_prog_ep_ob_atu(struct rockchip_pcie *rockchip, u8 fn,
 					 u32 r, u32 type, u64 cpu_addr,
 					 u64 pci_addr, size_t size)
 {
-	u64 sz = 1ULL << fls64(size - 1);
+	u64 sz = roundup_pow_of_two(size);
 	int num_pass_bits = ilog2(sz);
 	u32 addr0, addr1, desc0, desc1;
 	bool is_nor_msg = (type == AXI_WRAPPER_NOR_MSG);
@@ -176,7 +177,7 @@ static int rockchip_pcie_ep_set_bar(struct pci_epc *epc, u8 fn,
 	 * roundup_pow_of_two() returns an unsigned long, which is not suited
 	 * for 64bit values.
 	 */
-	sz = 1ULL << fls64(sz - 1);
+	sz = roundup_pow_of_two(sz);
 	aperture = ilog2(sz) - 7; /* 128B -> 0, 256B -> 1, 512B -> 2, ... */
 
 	if ((flags & PCI_BASE_ADDRESS_SPACE) == PCI_BASE_ADDRESS_SPACE_IO) {
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 6af7ae83c4ad..056886c4efec 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -53,7 +53,7 @@ u64 dma_direct_get_required_mask(struct device *dev)
 {
 	u64 max_dma = phys_to_dma_direct(dev, (max_pfn - 1) << PAGE_SHIFT);
 
-	return (1ULL << (fls64(max_dma) - 1)) * 2 - 1;
+	return rounddown_pow_of_two(max_dma) * 2 - 1;
 }
 
 static gfp_t __dma_direct_optimal_gfp_mask(struct device *dev, u64 dma_mask,
-- 
2.24.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
