Return-Path: <SRS0=hwFB=ER=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD52C388F9
	for <iommu@archiver.kernel.org>; Wed, 11 Nov 2020 22:34:54 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D52152168B
	for <iommu@archiver.kernel.org>; Wed, 11 Nov 2020 22:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFxHsUIj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D52152168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8ACBD86C8E;
	Wed, 11 Nov 2020 22:34:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lyYwLH6xpqsM; Wed, 11 Nov 2020 22:34:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 52D4986C9A;
	Wed, 11 Nov 2020 22:34:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3D5E8C0889;
	Wed, 11 Nov 2020 22:34:51 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 26FC1C016F
 for <iommu@lists.linux-foundation.org>; Wed, 11 Nov 2020 22:34:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 105BD86C99
 for <iommu@lists.linux-foundation.org>; Wed, 11 Nov 2020 22:34:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x0eJgoIojhdh for <iommu@lists.linux-foundation.org>;
 Wed, 11 Nov 2020 22:34:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com
 [209.85.215.196])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9C51286C98
 for <iommu@lists.linux-foundation.org>; Wed, 11 Nov 2020 22:34:47 +0000 (UTC)
Received: by mail-pg1-f196.google.com with SMTP id w4so2398989pgg.13
 for <iommu@lists.linux-foundation.org>; Wed, 11 Nov 2020 14:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=YZG/reugvFbqj0Sn5t/P+mNzl6HJdhg/Es96Lqb5XFQ=;
 b=PFxHsUIjlvJ5kSSY8jak9mEeoz9gPFivDxCrdGKhXGyNQHFNaT2Nc7yECoi0w0v5Is
 aEgKwOc348VA/CUsYNUJwfsgar/dFIyOBz8i9tlrYeZbC7pmny4BRYY5/Pi8/G1qlAk1
 0QS+nw3cg+697M3L8Bnx36iJi8qXDVJeVMxpceWoylq03yyTWXt54/DQQ1HTWBDyFIu7
 WFdsAUfudcVEeHAwwrc1Oy2VhBaEGaG1KhRfzkvb0FO9RHGy718ngTiNe6MMnp57SNnH
 jxGJC6q9xNiRPuRF/sT0fA8JMEn742Itsocq+Z0QpPkgc5SNefUcoKuvnKqeW+m0jTsW
 VZGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=YZG/reugvFbqj0Sn5t/P+mNzl6HJdhg/Es96Lqb5XFQ=;
 b=O/bt+60W+r83DhkPIxMgdVkD353bGyzu9pYyTZ7gO1VYjZ7azUFEzDTvATx4k8liqE
 MVFL5i1SHoDmiTkbMZwFqu3uT86ehE0NfjXsQLnaMto6ypmO4aMDWYlT+za0KposBnzc
 NH5bK616abXu8gN1IDIXz4dkgwMeuUYWqNDu2PKGAanw9fDvkLdVGBlmQ4KejZRo0k0i
 hxdLJHW5q4pMfEnYmtdWEfxLu3NuQ0ui1xyUNR7erVhTyn6UYBiNAwO7WqeAyGMBEilh
 lcO2MCa7sEovZUwydRcvsb0+tNhoftpVV/KnYLo1bEcQVWpeZ7Y5LcqDbKNWTb6WOrrV
 LS2g==
X-Gm-Message-State: AOAM531ppOrCLSCxXy5tMReAHawoVAEKmic3lqTbJiaBB4yAI+L4G9FR
 YdoR+oIUQtbaP2vOzLXTvZc=
X-Google-Smtp-Source: ABdhPJxTtO3oq9Y+KOCUztZaq5q0THhWHhixzqvXM0Bh2pg1eUD77Eqn81s3qDyfnzhIpEp0FljO3g==
X-Received: by 2002:a63:6981:: with SMTP id
 e123mr24858878pgc.364.1605134087193; 
 Wed, 11 Nov 2020 14:34:47 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id a20sm3605096pff.118.2020.11.11.14.34.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2020 14:34:46 -0800 (PST)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: thierry.reding@gmail.com,
	joro@8bytes.org
Subject: [PATCH RESEND 4/5] iommu/tegra-smmu: Rework tegra_smmu_probe_device()
Date: Wed, 11 Nov 2020 14:21:28 -0800
Message-Id: <20201111222129.15736-5-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201111222129.15736-1-nicoleotsuka@gmail.com>
References: <20201111222129.15736-1-nicoleotsuka@gmail.com>
Cc: linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, jonathanh@nvidia.com
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

The bus_set_iommu() in tegra_smmu_probe() enumerates all clients
to call in tegra_smmu_probe_device() where each client searches
its DT node for smmu pointer and swgroup ID, so as to configure
an fwspec. But this requires a valid smmu pointer even before mc
and smmu drivers are probed. So in tegra_smmu_probe() we added a
line of code to fill mc->smmu, marking "a bit of a hack".

This works for most of clients in the DTB, however, doesn't work
for a client that doesn't exist in DTB, a PCI device for example.

Actually, if we return ERR_PTR(-ENODEV) in ->probe_device() when
it's called from bus_set_iommu(), iommu core will let everything
carry on. Then when a client gets probed, of_iommu_configure() in
iommu core will search DTB for swgroup ID and call ->of_xlate()
to prepare an fwspec, similar to tegra_smmu_probe_device() and
tegra_smmu_configure(). Then it'll call tegra_smmu_probe_device()
again, and this time we shall return smmu->iommu pointer properly.

So we can get rid of tegra_smmu_find() and tegra_smmu_configure()
along with DT polling code by letting the iommu core handle every
thing, except a problem that we search iommus property in DTB not
only for swgroup ID but also for mc node to get mc->smmu pointer
to call dev_iommu_priv_set() and return the smmu->iommu pointer.
So we'll need to find another way to get smmu pointer.

Referencing the implementation of sun50i-iommu driver, of_xlate()
has client's dev pointer, mc node and swgroup ID. This means that
we can call dev_iommu_priv_set() in of_xlate() instead, so we can
simply get smmu pointer in ->probe_device().

This patch reworks tegra_smmu_probe_device() by:
1) Removing mc->smmu hack in tegra_smmu_probe() so as to return
   ERR_PTR(-ENODEV) in tegra_smmu_probe_device() during stage of
   tegra_smmu_probe/tegra_mc_probe().
2) Moving dev_iommu_priv_set() to of_xlate() so we can get smmu
   pointer in tegra_smmu_probe_device() to replace DTB polling.
3) Removing tegra_smmu_configure() accordingly since iommu core
   takes care of it.

This also fixes a problem that previously we could add clients to
iommu groups before iommu core initializes its default domain:
    ubuntu@jetson:~$ dmesg | grep iommu
    platform 50000000.host1x: Adding to iommu group 1
    platform 57000000.gpu: Adding to iommu group 2
    iommu: Default domain type: Translated
    platform 54200000.dc: Adding to iommu group 3
    platform 54240000.dc: Adding to iommu group 3
    platform 54340000.vic: Adding to iommu group 4

Though it works fine with IOMMU_DOMAIN_UNMANAGED, but will have
warnings if switching to IOMMU_DOMAIN_DMA:
    iommu: Failed to allocate default IOMMU domain of type 0 for
           group (null) - Falling back to IOMMU_DOMAIN_DMA
    iommu: Failed to allocate default IOMMU domain of type 0 for
           group (null) - Falling back to IOMMU_DOMAIN_DMA

Now, bypassing the first probe_device() call from bus_set_iommu()
fixes the sequence:
    ubuntu@jetson:~$ dmesg | grep iommu
    iommu: Default domain type: Translated
    tegra-host1x 50000000.host1x: Adding to iommu group 0
    tegra-dc 54200000.dc: Adding to iommu group 1
    tegra-dc 54240000.dc: Adding to iommu group 1
    tegra-vic 54340000.vic: Adding to iommu group 2
    nouveau 57000000.gpu: Adding to iommu group 3

Note that dmesg log above is testing with IOMMU_DOMAIN_UNMANAGED.

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
Tested-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 drivers/iommu/tegra-smmu.c | 96 ++++++--------------------------------
 1 file changed, 15 insertions(+), 81 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 297d49f3f80e..f45ed43cf8db 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -797,75 +797,9 @@ static phys_addr_t tegra_smmu_iova_to_phys(struct iommu_domain *domain,
 	return SMMU_PFN_PHYS(pfn) + SMMU_OFFSET_IN_PAGE(iova);
 }
 
-static struct tegra_smmu *tegra_smmu_find(struct device_node *np)
-{
-	struct platform_device *pdev;
-	struct tegra_mc *mc;
-
-	pdev = of_find_device_by_node(np);
-	if (!pdev)
-		return NULL;
-
-	mc = platform_get_drvdata(pdev);
-	if (!mc)
-		return NULL;
-
-	return mc->smmu;
-}
-
-static int tegra_smmu_configure(struct tegra_smmu *smmu, struct device *dev,
-				struct of_phandle_args *args)
-{
-	const struct iommu_ops *ops = smmu->iommu.ops;
-	int err;
-
-	err = iommu_fwspec_init(dev, &dev->of_node->fwnode, ops);
-	if (err < 0) {
-		dev_err(dev, "failed to initialize fwspec: %d\n", err);
-		return err;
-	}
-
-	err = ops->of_xlate(dev, args);
-	if (err < 0) {
-		dev_err(dev, "failed to parse SW group ID: %d\n", err);
-		iommu_fwspec_free(dev);
-		return err;
-	}
-
-	return 0;
-}
-
 static struct iommu_device *tegra_smmu_probe_device(struct device *dev)
 {
-	struct device_node *np = dev->of_node;
-	struct tegra_smmu *smmu = NULL;
-	struct of_phandle_args args;
-	unsigned int index = 0;
-	int err;
-
-	while (of_parse_phandle_with_args(np, "iommus", "#iommu-cells", index,
-					  &args) == 0) {
-		smmu = tegra_smmu_find(args.np);
-		if (smmu) {
-			err = tegra_smmu_configure(smmu, dev, &args);
-			of_node_put(args.np);
-
-			if (err < 0)
-				return ERR_PTR(err);
-
-			/*
-			 * Only a single IOMMU master interface is currently
-			 * supported by the Linux kernel, so abort after the
-			 * first match.
-			 */
-			dev_iommu_priv_set(dev, smmu);
-
-			break;
-		}
-
-		of_node_put(args.np);
-		index++;
-	}
+	struct tegra_smmu *smmu = dev_iommu_priv_get(dev);
 
 	if (!smmu)
 		return ERR_PTR(-ENODEV);
@@ -873,10 +807,7 @@ static struct iommu_device *tegra_smmu_probe_device(struct device *dev)
 	return &smmu->iommu;
 }
 
-static void tegra_smmu_release_device(struct device *dev)
-{
-	dev_iommu_priv_set(dev, NULL);
-}
+static void tegra_smmu_release_device(struct device *dev) {}
 
 static const struct tegra_smmu_group_soc *
 tegra_smmu_find_group(struct tegra_smmu *smmu, unsigned int swgroup)
@@ -953,8 +884,21 @@ static struct iommu_group *tegra_smmu_device_group(struct device *dev)
 static int tegra_smmu_of_xlate(struct device *dev,
 			       struct of_phandle_args *args)
 {
+	struct platform_device *iommu_pdev = of_find_device_by_node(args->np);
+	struct tegra_mc *mc = platform_get_drvdata(iommu_pdev);
 	u32 id = args->args[0];
 
+	/*
+	 * Note: we are here releasing the reference of &iommu_pdev->dev, which
+	 * is mc->dev. Although some functions in tegra_smmu_ops may keep using
+	 * its private data beyond this point, it's still safe to do so because
+	 * the SMMU parent device is the same as the MC, so the reference count
+	 * isn't strictly necessary.
+	 */
+	put_device(&iommu_pdev->dev);
+
+	dev_iommu_priv_set(dev, mc->smmu);
+
 	return iommu_fwspec_add_ids(dev, &id, 1);
 }
 
@@ -1079,16 +1023,6 @@ struct tegra_smmu *tegra_smmu_probe(struct device *dev,
 	if (!smmu)
 		return ERR_PTR(-ENOMEM);
 
-	/*
-	 * This is a bit of a hack. Ideally we'd want to simply return this
-	 * value. However the IOMMU registration process will attempt to add
-	 * all devices to the IOMMU when bus_set_iommu() is called. In order
-	 * not to rely on global variables to track the IOMMU instance, we
-	 * set it here so that it can be looked up from the .probe_device()
-	 * callback via the IOMMU device's .drvdata field.
-	 */
-	mc->smmu = smmu;
-
 	size = BITS_TO_LONGS(soc->num_asids) * sizeof(long);
 
 	smmu->asids = devm_kzalloc(dev, size, GFP_KERNEL);
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
