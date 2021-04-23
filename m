Return-Path: <SRS0=1bbG=JU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97169C433B4
	for <iommu@archiver.kernel.org>; Fri, 23 Apr 2021 16:32:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35503613AF
	for <iommu@archiver.kernel.org>; Fri, 23 Apr 2021 16:32:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35503613AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DA371400DE;
	Fri, 23 Apr 2021 16:32:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qJjDyJRSflQq; Fri, 23 Apr 2021 16:32:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id B34204064A;
	Fri, 23 Apr 2021 16:32:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8E709C000E;
	Fri, 23 Apr 2021 16:32:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0943AC000B
 for <iommu@lists.linux-foundation.org>; Fri, 23 Apr 2021 16:32:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DF3BD83CD9
 for <iommu@lists.linux-foundation.org>; Fri, 23 Apr 2021 16:32:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jdS7uUM3PKcZ for <iommu@lists.linux-foundation.org>;
 Fri, 23 Apr 2021 16:32:00 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D647784358
 for <iommu@lists.linux-foundation.org>; Fri, 23 Apr 2021 16:31:59 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id h8so17971038edb.2
 for <iommu@lists.linux-foundation.org>; Fri, 23 Apr 2021 09:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6kJ8FlhkIvBN3hAcxEbXQ25VGXtMUhHi6cV3ii1KUp0=;
 b=BIM2KyfdlmoOJBEWn8EycSHf1H4YiOJFNcz+V+ZYsmN0Ydo+zD9LSnvKHYrxT3a9Xt
 CfcJOGV4uBxh9n7DtKnaZok1SFfKM0R46+6ZFkel3qHkc0JHxuxGqlqZcG9SlhDZbuiC
 RgyI6J0glPHEmeEhiEaR6cYnf+o46C8XePkD07FrjDc9hBf9HGL+j3kwfSNpILIpHutb
 Zyh5jpmOsY8XPSlmGbgGR4N/yEVvwMjjZwV6Jp3vWtkQEUNXpRdT412LF5xD+GqLprGI
 Z0zp06OAhDSHV+nzUlXJH2xTSzmFf0jJo8K4Hp1Oc2gNdtMRI1BhCSaHeM+bD72O57pf
 OMBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6kJ8FlhkIvBN3hAcxEbXQ25VGXtMUhHi6cV3ii1KUp0=;
 b=JHKRXzBrMPwEJjDU5pfUQ4YnmaIXEmGn49Ot2zhygQomTY9nEzxdoHPuICyetttb3o
 96QFIokxUBJt7ojW/c9SCGpvvAHThCMvaWPpAuUJ9/z507DUCqHFGe4pR62g0Cky03jr
 xMu9O/oMPLgc6qy27HyJO6tfvPguwouQ25HOoI0gJKzkAxooHJUwYcsoVsXJhTNpvNDv
 0e+eD0mp2S9+sW9wXgQZt8jeh4vj2jegpeAAB2SBNNcRz4sLBNHXgoD/VRA6CNFAxpnC
 9Rg2sMwKQ5CnM9sB23H09FaD8nTuCkoZAwOsdRHnq8AVbs/vC74idTHs4oji1RkERiMh
 +uEA==
X-Gm-Message-State: AOAM531OEEx12yIMR0+ijWrA+5pYNsIPUwPifpp8zGvK9UTT2KlBIHwX
 Oc5GsreSK/z/yxXRdeFj9os=
X-Google-Smtp-Source: ABdhPJwo0PJUMqTdKoZg3h9H/EVUnRTipGblS3m9p+5IZMxzILU9NtmPgnKLKdXo78vwHx/9I7cDtw==
X-Received: by 2002:a50:9f65:: with SMTP id b92mr5634913edf.19.1619195518102; 
 Fri, 23 Apr 2021 09:31:58 -0700 (PDT)
Received: from localhost ([62.96.65.119])
 by smtp.gmail.com with ESMTPSA id 16sm4361945ejw.0.2021.04.23.09.31.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Apr 2021 09:31:57 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 4/5] iommu/tegra-smmu: Add support for reserved regions
Date: Fri, 23 Apr 2021 18:32:33 +0200
Message-Id: <20210423163234.3651547-5-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210423163234.3651547-1-thierry.reding@gmail.com>
References: <20210423163234.3651547-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Will Deacon <will@kernel.org>,
 iommu@lists.linux-foundation.org, Nicolin Chen <nicolinc@nvidia.com>,
 linux-tegra@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>
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
 drivers/iommu/tegra-smmu.c | 76 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 0a281833f611..6bf7654371c5 100644
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
@@ -539,6 +540,38 @@ static void tegra_smmu_set_pde(struct tegra_smmu_as *as, unsigned long iova,
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
+	if (as->pd_dma == 0) {
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
@@ -551,6 +584,12 @@ static void tegra_smmu_set_pde(struct tegra_smmu_as *as, unsigned long iova,
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
@@ -945,6 +984,40 @@ static struct iommu_group *tegra_smmu_device_group(struct device *dev)
 	return group->group;
 }
 
+static void tegra_smmu_apply_resv_region(struct device *dev,
+					 struct iommu_domain *domain,
+					 struct iommu_resv_region *region)
+{
+	struct tegra_smmu *smmu = dev_iommu_priv_get(dev);
+	struct tegra_smmu_as *as = to_smmu_as(domain);
+
+	/*
+	 * ->attach_dev() may not have been called yet at this point, so the
+	 * address space may not have been associated with an SMMU instance.
+	 * Set up the association here to make sure subsequent code can rely
+	 * on the SMMU instance being known.
+	 *
+	 * Also make sure that the SMMU instance doesn't conflict if an SMMU
+	 * has been associated with the address space already. This can happen
+	 * if a domain is shared between multiple devices.
+	 *
+	 * Note that this is purely theoretic because there are no known SoCs
+	 * with multiple instances of this SMMU.
+	 *
+	 * XXX Deal with this elsewhere. One possibility would be to pass the
+	 * struct iommu_domain that we're operating on to ->get_resv_regions()
+	 * and ->put_resv_regions() so that the connection between it and the
+	 * struct device (in order to find the SMMU instance) can already be
+	 * established at that time. This would be nicely symmetric because a
+	 * ->put_resv_regions() could undo that again so that ->attach_dev()
+	 * could start from a clean slate.
+	 */
+	if (as->smmu && as->smmu != smmu)
+		WARN(1, "conflicting SMMU instances\n");
+
+	as->smmu = smmu;
+}
+
 static int tegra_smmu_of_xlate(struct device *dev,
 			       struct of_phandle_args *args)
 {
@@ -978,6 +1051,9 @@ static const struct iommu_ops tegra_smmu_ops = {
 	.map = tegra_smmu_map,
 	.unmap = tegra_smmu_unmap,
 	.iova_to_phys = tegra_smmu_iova_to_phys,
+	.get_resv_regions = of_iommu_get_resv_regions,
+	.put_resv_regions = generic_iommu_put_resv_regions,
+	.apply_resv_region = tegra_smmu_apply_resv_region,
 	.of_xlate = tegra_smmu_of_xlate,
 	.pgsize_bitmap = SZ_4K,
 };
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
