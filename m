Return-Path: <SRS0=roZV=HU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC2CC433E0
	for <iommu@archiver.kernel.org>; Thu, 18 Feb 2021 22:06:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F39764EB4
	for <iommu@archiver.kernel.org>; Thu, 18 Feb 2021 22:06:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F39764EB4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B439560674
	for <iommu@archiver.kernel.org>; Thu, 18 Feb 2021 22:06:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cnLNTjO7i_-W for <iommu@archiver.kernel.org>;
	Thu, 18 Feb 2021 22:06:32 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
	id 49CDB605CD; Thu, 18 Feb 2021 22:06:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9A37760672;
	Thu, 18 Feb 2021 22:06:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7377DC000E;
	Thu, 18 Feb 2021 22:06:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9A5A3C000D
 for <iommu@lists.linux-foundation.org>; Thu, 18 Feb 2021 22:06:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8E7D5605CD
 for <iommu@lists.linux-foundation.org>; Thu, 18 Feb 2021 22:06:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lYmgkYD-n9C7 for <iommu@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 22:06:25 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
 id 7B66060672; Thu, 18 Feb 2021 22:06:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 057A960673
 for <iommu@lists.linux-foundation.org>; Thu, 18 Feb 2021 22:06:23 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id o7so2081331pgl.1
 for <iommu@lists.linux-foundation.org>; Thu, 18 Feb 2021 14:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=GDOrF8R+0kkQi1QXHaOe+2aJ/te9SJscPtuXTt7HTNI=;
 b=j+EHKboLuIIXk/dGnc3IYjkffuISWd6xyHYgLGGeaZT/KW/ok8iLYjK8LBU6vJU65f
 IDR0kHwEJIpBI+fyLV4/r9Q/3st8cesr6nlt4jyuHGDxAdKjUeL5RgOQYe5a6xhdT6Vs
 R24fA0o64+vg55bl5BomHTpEi0K7jndmfCMBawRSKY615PrT5lAhW9yao+Qe13BBjees
 9GBXEd7v2GR3NiGM3nmw+JfvAZgogaEtC/esyivoncZmZ2RVPU37eYeIJdeobhcMrKqd
 nsgK5Hd5Y4CHBa31x9XSp/5H63vVC372blY2IYuKybJ7hhszV3qaI1Bx9AS0WTCVrpSV
 wO1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=GDOrF8R+0kkQi1QXHaOe+2aJ/te9SJscPtuXTt7HTNI=;
 b=rcljWG7SqZJDidpmK595wd/XgA1yLEj6ByispxoL6veXXqEWInxvFdFIzS+9ngyVSI
 d2AUY2TGl1sjjEgoUOAXNdrBdAdHtnee40Ftjl2pWKPD8GsAoAvWa07R6Uxy7vAK2i/w
 bQVwrt9BlA/QKJxBZ5zWFJ1PUMal9QKFMeiH73gIcem6l1aBe1MqbBdYCTmh91q6ivfm
 LK1JRvnCrdiRGqrK19VwQvv3KVNtCwoN33J1ekOCleDmEuBoM9Os0uO4BtN4bSM5bDQ0
 tYSzM/qFdRV4QU4Lhfy3F/aatlyc15WryDUpN/YNqx8AQODJrwpLX+n6a3mO8dyUM7Ub
 6GVw==
X-Gm-Message-State: AOAM530zq597EeFmbzORq21q1Lz8YncuesZA65j2+Ky5lhSDI/Mm7xET
 0jgRprPzasdr62nkFRINNhQ=
X-Google-Smtp-Source: ABdhPJw0o0lXeErESM+F+xggbe9pJYOvMFtuIcadqV4IoKbpV8Xto2cxsVav9LkhA5+YnLYYmtK8Lw==
X-Received: by 2002:a62:e105:0:b029:1db:6f3e:7a56 with SMTP id
 q5-20020a62e1050000b02901db6f3e7a56mr6421437pfh.62.1613685983339; 
 Thu, 18 Feb 2021 14:06:23 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id u17sm7443251pgh.72.2021.02.18.14.06.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Feb 2021 14:06:22 -0800 (PST)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: joro@8bytes.org, thierry.reding@gmail.com, will@kernel.org,
 guillaume.tucker@collabora.com
Subject: [PATCH] iommu/tegra-smmu: Fix mc errors on tegra124-nyan
Date: Thu, 18 Feb 2021 14:07:02 -0800
Message-Id: <20210218220702.1962-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 jonathanh@nvidia.com, linux-tegra@vger.kernel.org, digetx@gmail.com
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Commit 25938c73cd79 ("iommu/tegra-smmu: Rework tegra_smmu_probe_device()")
removed certain hack in the tegra_smmu_probe() by relying on IOMMU core to
of_xlate SMMU's SID per device, so as to get rid of tegra_smmu_find() and
tegra_smmu_configure() that are typically done in the IOMMU core also.

This approach works for both existing devices that have DT nodes and other
devices (like PCI device) that don't exist in DT, on Tegra210 and Tegra3
upon testing. However, Page Fault errors are reported on tegra124-Nyan:

  tegra-mc 70019000.memory-controller: display0a: read @0xfe056b40:
	 EMEM address decode error (SMMU translation error [--S])
  tegra-mc 70019000.memory-controller: display0a: read @0xfe056b40:
	 Page fault (SMMU translation error [--S])

After debugging, I found that the mentioned commit changed some function
callback sequence of tegra-smmu's, resulting in enabling SMMU for display
client before display driver gets initialized. I couldn't reproduce exact
same issue on Tegra210 as Tegra124 (arm-32) differs at arch-level code.

Actually this Page Fault is a known issue, as on most of Tegra platforms,
display gets enabled by the bootloader for the splash screen feature, so
it keeps filling the framebuffer memory. A proper fix to this issue is to
1:1 linear map the framebuffer memory to IOVA space so the SMMU will have
the same address as the physical address in its page table. Yet, Thierry
has been working on the solution above for a year, and it hasn't merged.

Therefore, let's partially revert the mentioned commit to fix the errors.

The reason why we do a partial revert here is that we can still set priv
in ->of_xlate() callback for PCI devices. Meanwhile, devices existing in
DT, like display, will go through tegra_smmu_configure() at the stage of
bus_set_iommu() when SMMU gets probed(), as what it did before we merged
the mentioned commit.

Once we have the linear map solution for framebuffer memory, this change
can be cleaned away.

[Big thank to Guillaume who reported and helped debugging/verification]

Fixes: 25938c73cd79 ("iommu/tegra-smmu: Rework tegra_smmu_probe_device()")
Reported-by: Guillaume Tucker <guillaume.tucker@collabora.com>
Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---

Guillaume, would you please give a "Tested-by" to this change? Thanks!

 drivers/iommu/tegra-smmu.c | 72 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 71 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 4a3f095a1c26..97eb62f667d2 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -798,10 +798,70 @@ static phys_addr_t tegra_smmu_iova_to_phys(struct iommu_domain *domain,
 	return SMMU_PFN_PHYS(pfn) + SMMU_OFFSET_IN_PAGE(iova);
 }
 
+static struct tegra_smmu *tegra_smmu_find(struct device_node *np)
+{
+	struct platform_device *pdev;
+	struct tegra_mc *mc;
+
+	pdev = of_find_device_by_node(np);
+	if (!pdev)
+		return NULL;
+
+	mc = platform_get_drvdata(pdev);
+	if (!mc)
+		return NULL;
+
+	return mc->smmu;
+}
+
+static int tegra_smmu_configure(struct tegra_smmu *smmu, struct device *dev,
+				struct of_phandle_args *args)
+{
+	const struct iommu_ops *ops = smmu->iommu.ops;
+	int err;
+
+	err = iommu_fwspec_init(dev, &dev->of_node->fwnode, ops);
+	if (err < 0) {
+		dev_err(dev, "failed to initialize fwspec: %d\n", err);
+		return err;
+	}
+
+	err = ops->of_xlate(dev, args);
+	if (err < 0) {
+		dev_err(dev, "failed to parse SW group ID: %d\n", err);
+		iommu_fwspec_free(dev);
+		return err;
+	}
+
+	return 0;
+}
+
 static struct iommu_device *tegra_smmu_probe_device(struct device *dev)
 {
-	struct tegra_smmu *smmu = dev_iommu_priv_get(dev);
+	struct device_node *np = dev->of_node;
+	struct tegra_smmu *smmu = NULL;
+	struct of_phandle_args args;
+	unsigned int index = 0;
+	int err;
+
+	while (of_parse_phandle_with_args(np, "iommus", "#iommu-cells", index,
+					  &args) == 0) {
+		smmu = tegra_smmu_find(args.np);
+		if (smmu) {
+			err = tegra_smmu_configure(smmu, dev, &args);
+			of_node_put(args.np);
 
+			if (err < 0)
+				return ERR_PTR(err);
+
+			break;
+		}
+
+		of_node_put(args.np);
+		index++;
+	}
+
+	smmu = dev_iommu_priv_get(dev);
 	if (!smmu)
 		return ERR_PTR(-ENODEV);
 
@@ -1028,6 +1088,16 @@ struct tegra_smmu *tegra_smmu_probe(struct device *dev,
 	if (!smmu)
 		return ERR_PTR(-ENOMEM);
 
+	/*
+	 * This is a bit of a hack. Ideally we'd want to simply return this
+	 * value. However the IOMMU registration process will attempt to add
+	 * all devices to the IOMMU when bus_set_iommu() is called. In order
+	 * not to rely on global variables to track the IOMMU instance, we
+	 * set it here so that it can be looked up from the .probe_device()
+	 * callback via the IOMMU device's .drvdata field.
+	 */
+	mc->smmu = smmu;
+
 	size = BITS_TO_LONGS(soc->num_asids) * sizeof(long);
 
 	smmu->asids = devm_kzalloc(dev, size, GFP_KERNEL);
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
