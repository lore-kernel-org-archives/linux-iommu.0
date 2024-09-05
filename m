Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0F415B541;
	Thu,  5 Sep 2024 07:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725520455; cv=none; b=FfGemoEfdXD/eZIpMR1DoT+awZ0QYIvtvnkRFshNN/8s8h1d1FF5xWyVj6vjbvd8CCcXsmfABdhIzcPGGJ7XwcCL1vPhuMvVnbCe7LmWLlSfDjnDNWMowTCo4bbsLA3eQxdmL2DwSfOhRpHeFbN8k8jmh8n8HFoBqbiHNkIrLgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725520455; c=relaxed/simple;
	bh=tu9tbaEU4ijWM0enZT92UQ4CLRzHDPCr/gNb6HsSjkg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EJCKAilM66ynODr8FDmnSaxDqtNQO1c/dETM/mONm4ooeZRS1C8QjnE79BT21xgIIHGv5AecZZUlEjIMvGAAQCbrRBVIPQZVq5JfUBTkx56nROgLZsR+3l6K5034wrLAZ2L1N/KGozo855cqRRBKHjIOR3OE5Mop3IaF80WNue0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/9MeWZN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/9MeWZN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6774AC4CEC4;
	Thu,  5 Sep 2024 07:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725520454;
	bh=tu9tbaEU4ijWM0enZT92UQ4CLRzHDPCr/gNb6HsSjkg=;
	h=From:To:Cc:Subject:Date:From;
	b=L/9MeWZNavHbMSBFbd5n1/9QcgbGq8fQ+1c+6Hy8/egjAepKq3s6/fxynaJnhQWnA
	 hD5U0xsox8h9NchTUbPwR8Dprs3S2A0NOUOtdh3lRGPKD+N5LfsooFPWxk7PV2H4gw
	 83iir5l91URXhFrvyw+Hm+ss2MYrHkdAK030561B45akpVtnmFQuDbOumeUSgi2MvD
	 aSRRmAf0fcf3Du3uns6ODcgR90VWyvd0oh2qNbMcwN3Q5K0qUHbJlcp3XmY3654ipl
	 GPAtlRoAIFkFKLAqZwyaRrLMwAjLm03G8prPPqquM+JxlJNT6be5M/ATCAAeCHB8Ud
	 y4rRnOaOaJHNQ==
From: Leon Romanovsky <leon@kernel.org>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= <nfraprado@collabora.com>
Subject: [PATCH] dma-mapping: Use IOMMU DMA calls for common alloc/free page calls
Date: Thu,  5 Sep 2024 10:14:05 +0300
Message-ID: <62ce544e41d233eb6f591514a53f2eaabf488a7b.1725519850.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

Common alloca and free pages routines are called when IOMMU DMA is used,
and internally it calls to DMA ops structure which is not available for
default IOMMU. This patch adds necessary if checks to call IOMMU DMA.

It fixes the following crash:

 Unable to handle kernel NULL pointer dereference at virtual address 0000000000000040
 Mem abort info:
   ESR = 0x0000000096000006
   EC = 0x25: DABT (current EL), IL = 32 bits
   SET = 0, FnV = 0
   EA = 0, S1PTW = 0
   FSC = 0x06: level 2 translation fault
 Data abort info:
   ISV = 0, ISS = 0x00000006, ISS2 = 0x00000000
   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
 user pgtable: 4k pages, 48-bit VAs, pgdp=00000000d20bb000
 [0000000000000040] pgd=08000000d20c1003
 , p4d=08000000d20c1003
 , pud=08000000d20c2003, pmd=0000000000000000
 Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
 Modules linked in: ipv6 hci_uart venus_core btqca
v4l2_mem2mem btrtl qcom_spmi_adc5 sbs_battery btbcm qcom_vadc_common
cros_ec_typec videobuf2_v4l2 leds_cros_ec cros_kbd_led_backlight
cros_ec_chardev videodev elan_i2c
videobuf2_common qcom_stats mc bluetooth coresight_stm stm_core
ecdh_generic ecc pwrseq_core panel_edp icc_bwmon ath10k_snoc ath10k_core
ath mac80211 phy_qcom_qmp_combo aux_bridge libarc4 coresight_replicator
coresight_etm4x coresight_tmc
coresight_funnel cfg80211 rfkill coresight qcom_wdt cbmem ramoops
reed_solomon pwm_bl coreboot_table backlight crct10dif_ce
 CPU: 7 UID: 0 PID: 70 Comm: kworker/u32:4 Not tainted 6.11.0-rc6-next-20240903-00003-gdfc6015d0711 #660
 Hardware name: Google Lazor Limozeen without Touchscreen (rev5 - rev8) (DT)
 Workqueue: events_unbound deferred_probe_work_func
 hub 2-1:1.0: 4 ports detected

 pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : dma_common_alloc_pages+0x54/0x1b4
 lr : dma_common_alloc_pages+0x4c/0x1b4
 sp : ffff8000807d3730
 x29: ffff8000807d3730 x28: ffff02a7d312f880 x27: 0000000000000001
 x26: 000000000000c000 x25: 0000000000000000 x24: 0000000000000001
 x23: ffff02a7d23b6898 x22: 0000000000006cc0 x21: 000000000000c000
 x20: ffff02a7858bf410 x19: fffffe0a60006000 x18: 0000000000000001
 x17: 00000000000000d5 x16: 1fffe054f0bcc261 x15: 0000000000000001
 x14: ffff02a7844dc680 x13: 0000000000100180 x12: dead000000000100
 x11: dead000000000122 x10: 00000000001001ff x9 : ffff02a87f7b7b00
 x8 : ffff02a87f7b7b00 x7 : ffff405977d6b000 x6 : ffff8000807d3310
 x5 : ffff02a87f6b6398 x4 : 0000000000000001 x3 : ffff405977d6b000
 x2 : ffff02a7844dc600 x1 : 0000000100000000 x0 : fffffe0a60006000
 Call trace:
  dma_common_alloc_pages+0x54/0x1b4
  __dma_alloc_pages+0x68/0x90
  dma_alloc_pages+0x10/0x1c
  snd_dma_noncoherent_alloc+0x28/0x8c
  __snd_dma_alloc_pages+0x30/0x50
  snd_dma_alloc_dir_pages+0x40/0x80
  do_alloc_pages+0xb8/0x13c
  preallocate_pcm_pages+0x6c/0xf8
  preallocate_pages+0x160/0x1a4
  snd_pcm_set_managed_buffer_all+0x64/0xb0
  lpass_platform_pcm_new+0xc0/0xe8
  snd_soc_pcm_component_new+0x3c/0xc8
  soc_new_pcm+0x4fc/0x668
  snd_soc_bind_card+0xabc/0xbac
  snd_soc_register_card+0xf0/0x108
  devm_snd_soc_register_card+0x4c/0xa4
  sc7180_snd_platform_probe+0x180/0x224
  platform_probe+0x68/0xc0
  really_probe+0xbc/0x298
  __driver_probe_device+0x78/0x12c
  driver_probe_device+0x3c/0x15c
  __device_attach_driver+0xb8/0x134
  bus_for_each_drv+0x84/0xe0
  __device_attach+0x9c/0x188
  device_initial_probe+0x14/0x20
  bus_probe_device+0xac/0xb0
  deferred_probe_work_func+0x88/0xc0
  process_one_work+0x14c/0x28c
  worker_thread+0x2cc/0x3d4
  kthread+0x114/0x118
  ret_from_fork+0x10/0x20
 Code: f9411c19 940000c9 aa0003f3 b4000460 (f9402326)
 ---[ end trace 0000000000000000 ]---

Fixes: b5c58b2fdc42 ("dma-mapping: direct calls for dma-iommu")
Reported-by: Nícolas F. R. A. Prado <nfraprado@collabora.com> #KernelCI
Closes: https://lore.kernel.org/all/10431dfd-ce04-4e0f-973b-c78477303c18@notapiano
Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 include/linux/iommu-dma.h |  8 ++++++++
 kernel/dma/mapping.c      | 12 ------------
 kernel/dma/ops_helpers.c  | 14 +++++++++++---
 3 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/include/linux/iommu-dma.h b/include/linux/iommu-dma.h
index 011e5453d56b..561d81b12d9c 100644
--- a/include/linux/iommu-dma.h
+++ b/include/linux/iommu-dma.h
@@ -10,6 +10,10 @@
 #include <linux/dma-mapping.h>
 
 #ifdef CONFIG_IOMMU_DMA
+static inline bool use_dma_iommu(struct device *dev)
+{
+	return dev->dma_iommu;
+}
 dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 			      unsigned long offset, size_t size,
 			      enum dma_data_direction dir, unsigned long attrs);
@@ -65,6 +69,10 @@ void iommu_dma_unlink_range(struct device *dev, dma_addr_t start, size_t size,
 bool iommu_can_use_iova(struct device *dev, struct page *page, size_t size,
 			enum dma_data_direction dir);
 #else
+static inline bool use_dma_iommu(struct device *dev)
+{
+	return false;
+}
 static inline dma_addr_t iommu_dma_map_page(struct device *dev,
 					    struct page *page,
 					    unsigned long offset, size_t size,
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 9ce34bd4d407..7ec3deb7630d 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -117,18 +117,6 @@ void *dmam_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
 }
 EXPORT_SYMBOL(dmam_alloc_attrs);
 
-#ifdef CONFIG_IOMMU_DMA
-static bool use_dma_iommu(struct device *dev)
-{
-	return dev->dma_iommu;
-}
-#else
-static bool use_dma_iommu(struct device *dev)
-{
-	return false;
-}
-#endif
-
 static bool dma_go_direct(struct device *dev, dma_addr_t mask,
 		const struct dma_map_ops *ops)
 {
diff --git a/kernel/dma/ops_helpers.c b/kernel/dma/ops_helpers.c
index af4a6ef48ce0..9afd569eadb9 100644
--- a/kernel/dma/ops_helpers.c
+++ b/kernel/dma/ops_helpers.c
@@ -4,6 +4,7 @@
  * the allocated memory contains normal pages in the direct kernel mapping.
  */
 #include <linux/dma-map-ops.h>
+#include <linux/iommu-dma.h>
 
 static struct page *dma_common_vaddr_to_page(void *cpu_addr)
 {
@@ -70,8 +71,12 @@ struct page *dma_common_alloc_pages(struct device *dev, size_t size,
 	if (!page)
 		return NULL;
 
-	*dma_handle = ops->map_page(dev, page, 0, size, dir,
-				    DMA_ATTR_SKIP_CPU_SYNC);
+	if (use_dma_iommu(dev))
+		*dma_handle = iommu_dma_map_page(dev, page, 0, size, dir,
+						 DMA_ATTR_SKIP_CPU_SYNC);
+	else
+		*dma_handle = ops->map_page(dev, page, 0, size, dir,
+					    DMA_ATTR_SKIP_CPU_SYNC);
 	if (*dma_handle == DMA_MAPPING_ERROR) {
 		dma_free_contiguous(dev, page, size);
 		return NULL;
@@ -86,7 +91,10 @@ void dma_common_free_pages(struct device *dev, size_t size, struct page *page,
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 
-	if (ops->unmap_page)
+	if (use_dma_iommu(dev))
+		iommu_dma_unmap_page(dev, dma_handle, size, dir,
+				     DMA_ATTR_SKIP_CPU_SYNC);
+	else if (ops->unmap_page)
 		ops->unmap_page(dev, dma_handle, size, dir,
 				DMA_ATTR_SKIP_CPU_SYNC);
 	dma_free_contiguous(dev, page, size);
-- 
2.46.0

