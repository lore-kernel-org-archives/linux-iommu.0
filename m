Return-Path: <SRS0=mVMG=CN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F5AC43461
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 13:00:19 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CFFC2074A
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 13:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JbEna7qF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CFFC2074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7E11E86CAF;
	Fri,  4 Sep 2020 13:00:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WBbkum54iyyg; Fri,  4 Sep 2020 13:00:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8ACE186AE8;
	Fri,  4 Sep 2020 13:00:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6021EC07FF;
	Fri,  4 Sep 2020 13:00:18 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EA419C0051
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 13:00:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id DA03D85DC0
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 13:00:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n2QC5Irsrf3W for <iommu@lists.linux-foundation.org>;
 Fri,  4 Sep 2020 13:00:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com
 [209.85.208.65])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 262FC86365
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 13:00:14 +0000 (UTC)
Received: by mail-ed1-f65.google.com with SMTP id l17so5954301edq.12
 for <iommu@lists.linux-foundation.org>; Fri, 04 Sep 2020 06:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=keLbDlRCCkTw+4uCImLB+l3YHIhG5at3E8Eao1jgek0=;
 b=JbEna7qF1Kra6ud6bc2esI8lnTMme7Fzo48XnHl66N0POR3hNgtQ+FMmW0ogne5tJ7
 IyTo5fWNoy+mR41dayeSx3I+YxVDbdy1iGEENanII1JFeEbptA2udOyt9jnVjxcKblcO
 JRwJPZhcR/+kVSO41ju7lIX/5PDPGRJSgBjp6BcnXxAzO6+s6Tsh1W2/1zhbcqKQazEX
 adgIoY+eT3lRSNu/rbst15T6pOaL2ffexVdMfr8LbkACFTixincy0J48f3yNMZsYV2Tu
 wtXBfEZhavFl/55YkfJVHnPZAQBOAa6DqxoVZcFzNQfNzgxUa/xzaoD0/EZm/yVrq1db
 aykA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=keLbDlRCCkTw+4uCImLB+l3YHIhG5at3E8Eao1jgek0=;
 b=O8/ktpaKoyn+pCxdxOjfuvGCDjYjwnnkIrM8V7Oi0NLwu1HzFAvW3zt8Ojtd9WjJEz
 HHRt/lGWgMrcB7HsexWJVeY1stjUQA1eaG1JTJzbXUDF/Jszx85/QNfNnamUHCCzuEWp
 qLqtWHizxwtIToo6K7HOnOk6sQJjhSBTJxTbftUn1qLCfbQYWYsC7PuNS2nrZW0IjrZv
 5gE4Hsd6JK+53mGMwX5fqYeDWTZdtEFh7lbacdJqwxljo4WGD6t7A+HvnIV5McZ8MmnR
 1f51G9ssQHTHJ67oN1AnNn5nT0Yw2NJT4AxNi770Mng/62fvjZ4IqwpMF0eOihmcNDra
 M9wA==
X-Gm-Message-State: AOAM5332mkDQTfc32lAnerwA2of7pNUCf0SjzxRBtmgOK3SfkFXt8c4i
 DyXCw3fCEWGMkK4N3lQay4M=
X-Google-Smtp-Source: ABdhPJxvLmJPvP+pnSifzUpXIegVqJ9MJ4+JjS2wKcZWhz+Zg93+BnFhnJDvy8kZf0x7j8dF0cDSrg==
X-Received: by 2002:a05:6402:1c91:: with SMTP id
 cy17mr8693433edb.366.1599224412278; 
 Fri, 04 Sep 2020 06:00:12 -0700 (PDT)
Received: from localhost ([62.96.65.119])
 by smtp.gmail.com with ESMTPSA id j92sm6114867edc.82.2020.09.04.06.00.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 06:00:11 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [RFC 4/4] iommu/tegra-smmu: Add support for reserved regions
Date: Fri,  4 Sep 2020 15:00:00 +0200
Message-Id: <20200904130000.691933-4-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200904130000.691933-1-thierry.reding@gmail.com>
References: <20200904130000.691933-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 Will Deacon <will@kernel.org>
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
I'm sending this out as RFC because there's a few hacks in here to make
this work properly and I'm not fully happy with this yet (see sections
marked with XXX).

Thierry

 drivers/iommu/tegra-smmu.c | 115 +++++++++++++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 2574e716086b..33abc1527ac4 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -9,6 +9,7 @@
 #include <linux/iommu.h>
 #include <linux/kernel.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
@@ -530,6 +531,38 @@ static void tegra_smmu_set_pde(struct tegra_smmu_as *as, unsigned long iova,
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
@@ -542,6 +575,12 @@ static void tegra_smmu_set_pde(struct tegra_smmu_as *as, unsigned long iova,
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
@@ -882,6 +921,79 @@ static struct iommu_group *tegra_smmu_device_group(struct device *dev)
 	return group;
 }
 
+static void tegra_smmu_get_resv_regions(struct device *dev, struct list_head *list)
+{
+	struct of_phandle_iterator it;
+	int err;
+
+	if (!dev->of_node)
+		return;
+
+	of_for_each_phandle(&it, err, dev->of_node, "memory-region", NULL, 0) {
+		struct iommu_resv_region *region;
+		struct resource res;
+
+		err = of_address_to_resource(it.node, 0, &res);
+		if (err < 0) {
+			dev_err(dev, "failed to parse memory region %pOFn: %d\n",
+				it.node, err);
+			continue;
+		}
+
+		region = iommu_alloc_resv_region(res.start, resource_size(&res),
+						 IOMMU_READ | IOMMU_WRITE,
+						 IOMMU_RESV_DIRECT);
+		if (!region)
+			return;
+
+		dev_dbg(dev, "reserved region %pR\n", &res);
+		list_add_tail(&region->list, list);
+	}
+}
+
+static void tegra_smmu_put_resv_regions(struct device *dev,
+					struct list_head *list)
+{
+	struct iommu_resv_region *entry, *next;
+
+	list_for_each_entry_safe(entry, next, list, list)
+		kfree(entry);
+}
+
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
@@ -902,6 +1014,9 @@ static const struct iommu_ops tegra_smmu_ops = {
 	.map = tegra_smmu_map,
 	.unmap = tegra_smmu_unmap,
 	.iova_to_phys = tegra_smmu_iova_to_phys,
+	.get_resv_regions = tegra_smmu_get_resv_regions,
+	.put_resv_regions = tegra_smmu_put_resv_regions,
+	.apply_resv_region = tegra_smmu_apply_resv_region,
 	.of_xlate = tegra_smmu_of_xlate,
 	.pgsize_bitmap = SZ_4K,
 };
-- 
2.28.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
