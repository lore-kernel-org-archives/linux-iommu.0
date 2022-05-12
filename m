Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27827C433FE
	for <iommu@archiver.kernel.org>; Thu, 12 May 2022 19:01:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C891540132;
	Thu, 12 May 2022 19:01:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q1UqfXawye5x; Thu, 12 May 2022 19:01:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9F8BC400D0;
	Thu, 12 May 2022 19:01:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7AF39C0032;
	Thu, 12 May 2022 19:01:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 91C10C002D
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 19:01:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 716F7400D0
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 19:01:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id en82KiLruGFv for <iommu@lists.linux-foundation.org>;
 Thu, 12 May 2022 19:01:17 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7709540144
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 19:01:17 +0000 (UTC)
Received: by mail-lf1-x12f.google.com with SMTP id d19so10729275lfj.4
 for <iommu@lists.linux-foundation.org>; Thu, 12 May 2022 12:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=in4n6yNdl0/TA88lWGR+mLZXfmd4yDMsoLU1LfHbMpA=;
 b=VldBZhrmCg/tqslxw2qNSHOqRW9/XVWxX3SMuQXvT7R+PIiQfjuTAp1cW1wqNZd5WH
 KmrMn0t33uWqimbKlmm5uNlGBF9AhGf457xuLPkE4DNwHG+VveKArz6m4yAkoNpl/ypg
 rmYoIVu9skcUKMsKz7i/e5ixfPIPrzv0ik6uNuXBkUEhfBLWcqGmo+a0cx0qR5pHuHyz
 8r/2UHvHkOTfsslYrrrgnfSbpWp1YDK0WNJXiXoD0W6AZKheX4k7LoetbFZY7lQlaTpk
 X9J09AGTDL3dWAI9eKYJChMD1IktbXQrEy0GjgAM4vt0pnISFdfZ2vZb5VmlzJP/0iyH
 tF8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=in4n6yNdl0/TA88lWGR+mLZXfmd4yDMsoLU1LfHbMpA=;
 b=rEzlfzS/3pDeF1dQojr+00QlZuPNwehPWv/zDb+U5PI7jqv/ozL8aE2UmiF2K4SofY
 sdus3GsOLtQFCK73wDpcVuIBjw2wqPn5SerUf24B0vLsu4ilu9/8U+Gd0MZ1A9NneltS
 DWeByUOSxj/pR8ChabpFKDec99EebZMhWUtghlUNKWEt06uZ6Es1ryR3tZ04hm/NzlkJ
 eJjZ3bHa20vbT05MFl9WBUI/eK9cNAqnBpw8ZoI6iuathT7HVMp0Z1OOzS8ZSxCjnwpq
 uTM1ab9CHlsRhlvYBuWlWqw/e1x8Z6Hqp7b8f7pr4KkQL+cirB3BD4AqIz8Qjsmh/7ew
 lUOg==
X-Gm-Message-State: AOAM530+EOFzcsNzHdT9EHQPQp5WUjZiqBSwYfnNVXiu5rqzPN78biN3
 HnNgoEk3CrtcWoOQX7mRS5A=
X-Google-Smtp-Source: ABdhPJzQu3cY5QwC6URs68TB/8wTiIXioaNqbY6gHps5ySKJxE/6MeaS2+aNOL1FRP2DOFxNnqoPxA==
X-Received: by 2002:a05:6512:479:b0:471:feb0:104a with SMTP id
 x25-20020a056512047900b00471feb0104amr819648lfd.272.1652382075281; 
 Thu, 12 May 2022 12:01:15 -0700 (PDT)
Received: from localhost ([62.96.65.119]) by smtp.gmail.com with ESMTPSA id
 l5-20020ac25545000000b0047255d2111esm57312lfk.77.2022.05.12.12.01.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 May 2022 12:01:12 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
	Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v5 4/5] iommu/tegra-smmu: Add support for reserved regions
Date: Thu, 12 May 2022 21:00:51 +0200
Message-Id: <20220512190052.1152377-5-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220512190052.1152377-1-thierry.reding@gmail.com>
References: <20220512190052.1152377-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Will Deacon <will@kernel.org>,
 Sameer Pujar <spujar@nvidia.com>, iommu@lists.linux-foundation.org,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, linux-tegra@vger.kernel.org,
 Janne Grunau <j@jannau.net>, Robin Murphy <robin.murphy@arm.com>
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

From: Thierry Reding <treding@nvidia.com>

The Tegra DRM driver currently uses the IOMMU API explicitly. This means
that it has fine-grained control over when exactly the translation
through the IOMMU is enabled. This currently happens after the driver
probes, so the driver is in a DMA quiesced state when the IOMMU
translation is enabled.

During the transition of the Tegra DRM driver to use the DMA API instead
of the IOMMU API explicitly, it was observed that on certain platforms
the display controllers were still actively fetching from memory. When a
DMA IOMMU domain is created as part of the DMA/IOMMU API setup during
boot, the IOMMU translation for the display controllers can be enabled a
significant amount of time before the driver has had a chance to reset
the hardware into a sane state. This causes the SMMU to detect faults on
the addresses that the display controller is trying to fetch.

To avoid this, and as a byproduct paving the way for seamless transition
of display from the bootloader to the kernel, add support for reserved
regions in the Tegra SMMU driver. This is implemented using the standard
reserved memory device tree bindings, which let us describe regions of
memory which the kernel is forbidden from using for regular allocations.
The Tegra SMMU driver will parse the nodes associated with each device
via the "memory-region" property and return reserved regions that the
IOMMU core will then create direct mappings for prior to attaching the
IOMMU domains to the devices. This ensures that a 1:1 mapping is in
place when IOMMU translation starts and prevents the SMMU from detecting
any faults.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/iommu/tegra-smmu.c | 47 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 2f2b12033618..93879c40056c 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -10,6 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/of_iommu.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
@@ -471,6 +472,7 @@ static void tegra_smmu_as_unprepare(struct tegra_smmu *smmu,
 	tegra_smmu_free_asid(smmu, as->id);
 
 	dma_unmap_page(smmu->dev, as->pd_dma, SMMU_SIZE_PD, DMA_TO_DEVICE);
+	as->pd_dma = 0;
 
 	as->smmu = NULL;
 
@@ -534,6 +536,38 @@ static void tegra_smmu_set_pde(struct tegra_smmu_as *as, unsigned long iova,
 	struct tegra_smmu *smmu = as->smmu;
 	u32 *pd = page_address(as->pd);
 	unsigned long offset = pd_index * sizeof(*pd);
+	bool unmap = false;
+
+	/*
+	 * XXX Move this outside of this function. Perhaps add a struct
+	 * iommu_domain parameter to ->{get,put}_resv_regions() so that
+	 * the mapping can be done there.
+	 *
+	 * The problem here is that as->smmu is only known once we attach
+	 * the domain to a device (because then we look up the right SMMU
+	 * instance via the dev->archdata.iommu pointer). When the direct
+	 * mappings are created for reserved regions, the domain has not
+	 * been attached to a device yet, so we don't know. We currently
+	 * fix that up in ->apply_resv_regions() because that is the first
+	 * time where we have access to a struct device that will be used
+	 * with the IOMMU domain. However, that's asymmetric and doesn't
+	 * take care of the page directory mapping either, so we need to
+	 * come up with something better.
+	 */
+	if (WARN_ON_ONCE(as->pd_dma == 0)) {
+		as->pd_dma = dma_map_page(smmu->dev, as->pd, 0, SMMU_SIZE_PD,
+					  DMA_TO_DEVICE);
+		if (dma_mapping_error(smmu->dev, as->pd_dma))
+			return;
+
+		if (!smmu_dma_addr_valid(smmu, as->pd_dma)) {
+			dma_unmap_page(smmu->dev, as->pd_dma, SMMU_SIZE_PD,
+				       DMA_TO_DEVICE);
+			return;
+		}
+
+		unmap = true;
+	}
 
 	/* Set the page directory entry first */
 	pd[pd_index] = value;
@@ -546,6 +580,12 @@ static void tegra_smmu_set_pde(struct tegra_smmu_as *as, unsigned long iova,
 	smmu_flush_ptc(smmu, as->pd_dma, offset);
 	smmu_flush_tlb_section(smmu, as->id, iova);
 	smmu_flush(smmu);
+
+	if (unmap) {
+		dma_unmap_page(smmu->dev, as->pd_dma, SMMU_SIZE_PD,
+			       DMA_TO_DEVICE);
+		as->pd_dma = 0;
+	}
 }
 
 static u32 *tegra_smmu_pte_offset(struct page *pt_page, unsigned long iova)
@@ -846,7 +886,6 @@ static struct iommu_device *tegra_smmu_probe_device(struct device *dev)
 		smmu = tegra_smmu_find(args.np);
 		if (smmu) {
 			err = tegra_smmu_configure(smmu, dev, &args);
-
 			if (err < 0) {
 				of_node_put(args.np);
 				return ERR_PTR(err);
@@ -864,7 +903,9 @@ static struct iommu_device *tegra_smmu_probe_device(struct device *dev)
 	return &smmu->iommu;
 }
 
-static void tegra_smmu_release_device(struct device *dev) {}
+static void tegra_smmu_release_device(struct device *dev)
+{
+}
 
 static const struct tegra_smmu_group_soc *
 tegra_smmu_find_group(struct tegra_smmu *smmu, unsigned int swgroup)
@@ -968,6 +1009,8 @@ static const struct iommu_ops tegra_smmu_ops = {
 	.probe_device = tegra_smmu_probe_device,
 	.release_device = tegra_smmu_release_device,
 	.device_group = tegra_smmu_device_group,
+	.get_resv_regions = of_iommu_get_resv_regions,
+	.put_resv_regions = generic_iommu_put_resv_regions,
 	.of_xlate = tegra_smmu_of_xlate,
 	.pgsize_bitmap = SZ_4K,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
-- 
2.36.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
