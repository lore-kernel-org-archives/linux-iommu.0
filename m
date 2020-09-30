Return-Path: <SRS0=Vh7E=DH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69D2C4727F
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 08:48:39 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60EE120739
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 08:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JNnGOUGZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60EE120739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 32ECE84EED;
	Wed, 30 Sep 2020 08:48:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dEeRkQg6eNxg; Wed, 30 Sep 2020 08:48:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id BD42D847AB;
	Wed, 30 Sep 2020 08:48:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A9238C0890;
	Wed, 30 Sep 2020 08:48:37 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6FEFDC016F
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 08:48:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6A8B687204
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 08:48:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tQNlDj+q-rFB for <iommu@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 08:48:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com
 [209.85.215.194])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 8385986FCF
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 08:48:35 +0000 (UTC)
Received: by mail-pg1-f194.google.com with SMTP id g29so701593pgl.2
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 01:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=iLw5ELAX+q+E1rzUi9gP7bU1W2lzUQwDoXoPLAOAlak=;
 b=JNnGOUGZV7PZBIj6KHv+yMLoQVCmr1vlVLiP9vTbcB6vqES2f+nsP/Hp0dxioVeskM
 FHUJXlK6D72Jn4TzqJIDeDKtEjwax7wFXsUJXnhkIeHr1fS6lbNJapNDLReWoPZw7Dcr
 eQrIDbRjQbOKmA1XHkhd1ZcAEQHrfyEddVSYU10YawoLpTPuFq2LARpFu0y9tzOJIo+K
 XwQK3UYnXMFePbppxeJ+lDx1Rzrjus6zK4A3ByD26Qlv0QEWe51sLLATNITmn1glYqVG
 yG8U3px+5afaNlUnvwGgI48jMq30MOw+2Eh/9i5C9ySl8/vymDNGQvpnge+llOQ6VEGg
 yN8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=iLw5ELAX+q+E1rzUi9gP7bU1W2lzUQwDoXoPLAOAlak=;
 b=GgJ2YHJR5hyGaXyUow8Hc8Ny1O+qi1QUrpRJ4MVpUXpYV/rtzDnbLJotZhOAFnqIeX
 ZFnFdwqV9vBpg2cCC6Pjx3qt2EDZbkrOQc15gzAAL4zWqY1HyrLXRMcQ9WJ5W52V745k
 5AF8pvZr8Jop3niaBlQKaak+Rohwu2hPnI0b3pQfRla5Gb07zJ26MWpZjQ5PHIas/Eya
 7t0Rs82EMjfumtThPbyGCCQ+7kWAHYVXNzbI2cLzTkx6fSqUPRsKrqxH1SRRJvIhZe5q
 HS+JW1LV5+Otrk8Ha6Q4S20hdKrw0ENB33+j3Pm23JiIshQjtnOLqpSFbnDpakwAJXyK
 L2uw==
X-Gm-Message-State: AOAM53065G8bh6xGUXdlBj6iHsbRUaZr6TLJNKERMtGb/AGAbMv7iuYF
 2C3Q2eIq1SVA2MEIHS77jNU=
X-Google-Smtp-Source: ABdhPJx0Gk4V8SBSFF3wo71cX6m0weomIeo1QRTBNnUcBDV+uYHbErkR1hGtbKZ2hUvKc3zgWaYBfA==
X-Received: by 2002:aa7:9f04:0:b029:13e:d13d:a13b with SMTP id
 g4-20020aa79f040000b029013ed13da13bmr1687485pfr.35.1601455714980; 
 Wed, 30 Sep 2020 01:48:34 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id d17sm1505830pfq.157.2020.09.30.01.48.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2020 01:48:34 -0700 (PDT)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: thierry.reding@gmail.com, joro@8bytes.org, krzk@kernel.org,
 digetx@gmail.com
Subject: [PATCH v3 2/3] iommu/tegra-smmu: Rework .probe_device and .attach_dev
Date: Wed, 30 Sep 2020 01:42:57 -0700
Message-Id: <20200930084258.25493-3-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200930084258.25493-1-nicoleotsuka@gmail.com>
References: <20200930084258.25493-1-nicoleotsuka@gmail.com>
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, jonathanh@nvidia.com
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

Previously the driver relies on bus_set_iommu() in .probe() to call
in .probe_device() function so each client can poll iommus property
in DTB to configure fwspec via tegra_smmu_configure(). According to
the comments in .probe(), this is a bit of a hack. And this doesn't
work for a client that doesn't exist in DTB, PCI device for example.

Actually when a device/client gets probed, the of_iommu_configure()
will call in .probe_device() function again, with a prepared fwspec
from of_iommu_configure() that reads the SWGROUP id in DTB as we do
in tegra-smmu driver.

Additionally, as a new helper devm_tegra_get_memory_controller() is
introduced, there's no need to poll the iommus property in order to
get mc->smmu pointers or SWGROUP id.

This patch reworks .probe_device() and .attach_dev() by doing:
1) Using fwspec to get swgroup id in .attach_dev/.dettach_dev()
2) Removing DT polling code, tegra_smmu_find/tegra_smmu_configure()
3) Calling devm_tegra_get_memory_controller() in .probe_device()
4) Also dropping the hack in .probe() that's no longer needed.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---

Changelog
v2->v3
 * Used devm_tegra_get_memory_controller() to get mc pointer
 * Replaced IS_ERR_OR_NULL with IS_ERR in .probe_device()
v1->v2
 * Replaced in .probe_device() tegra_smmu_find/tegra_smmu_configure()
   with tegra_get_memory_controller call.
 * Dropped the hack in tegra_smmu_probe().

 drivers/iommu/tegra-smmu.c | 144 ++++++++++---------------------------
 1 file changed, 36 insertions(+), 108 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 6a3ecc334481..636dc3b89545 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -61,6 +61,8 @@ struct tegra_smmu_as {
 	u32 attr;
 };
 
+static const struct iommu_ops tegra_smmu_ops;
+
 static struct tegra_smmu_as *to_smmu_as(struct iommu_domain *dom)
 {
 	return container_of(dom, struct tegra_smmu_as, domain);
@@ -484,60 +486,50 @@ static void tegra_smmu_as_unprepare(struct tegra_smmu *smmu,
 static int tegra_smmu_attach_dev(struct iommu_domain *domain,
 				 struct device *dev)
 {
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct tegra_smmu *smmu = dev_iommu_priv_get(dev);
 	struct tegra_smmu_as *as = to_smmu_as(domain);
-	struct device_node *np = dev->of_node;
-	struct of_phandle_args args;
 	unsigned int index = 0;
 	int err = 0;
 
-	while (!of_parse_phandle_with_args(np, "iommus", "#iommu-cells", index,
-					   &args)) {
-		unsigned int swgroup = args.args[0];
-
-		if (args.np != smmu->dev->of_node) {
-			of_node_put(args.np);
-			continue;
-		}
-
-		of_node_put(args.np);
+	if (!fwspec || fwspec->ops != &tegra_smmu_ops)
+		return -ENOENT;
 
+	for (index = 0; index < fwspec->num_ids; index++) {
 		err = tegra_smmu_as_prepare(smmu, as);
-		if (err < 0)
-			return err;
+		if (err)
+			goto disable;
 
-		tegra_smmu_enable(smmu, swgroup, as->id);
-		index++;
+		tegra_smmu_enable(smmu, fwspec->ids[index], as->id);
 	}
 
 	if (index == 0)
 		return -ENODEV;
 
 	return 0;
+
+disable:
+	while (index--) {
+		tegra_smmu_disable(smmu, fwspec->ids[index], as->id);
+		tegra_smmu_as_unprepare(smmu, as);
+	}
+
+	return err;
 }
 
 static void tegra_smmu_detach_dev(struct iommu_domain *domain, struct device *dev)
 {
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct tegra_smmu_as *as = to_smmu_as(domain);
-	struct device_node *np = dev->of_node;
 	struct tegra_smmu *smmu = as->smmu;
-	struct of_phandle_args args;
 	unsigned int index = 0;
 
-	while (!of_parse_phandle_with_args(np, "iommus", "#iommu-cells", index,
-					   &args)) {
-		unsigned int swgroup = args.args[0];
-
-		if (args.np != smmu->dev->of_node) {
-			of_node_put(args.np);
-			continue;
-		}
-
-		of_node_put(args.np);
+	if (!fwspec || fwspec->ops != &tegra_smmu_ops)
+		return;
 
-		tegra_smmu_disable(smmu, swgroup, as->id);
+	for (index = 0; index < fwspec->num_ids; index++) {
+		tegra_smmu_disable(smmu, fwspec->ids[index], as->id);
 		tegra_smmu_as_unprepare(smmu, as);
-		index++;
 	}
 }
 
@@ -807,80 +799,26 @@ static phys_addr_t tegra_smmu_iova_to_phys(struct iommu_domain *domain,
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
+	struct tegra_mc *mc = devm_tegra_get_memory_controller(dev);
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 
-		of_node_put(args.np);
-		index++;
-	}
+	/* An invalid mc pointer means mc and smmu drivers are not ready */
+	if (IS_ERR(mc))
+		return ERR_PTR(-EPROBE_DEFER);
 
-	if (!smmu)
+	/*
+	 * IOMMU core allows -ENODEV return to carry on. So bypass any call
+	 * from bus_set_iommu() during tegra_smmu_probe(), as a device will
+	 * call in again via of_iommu_configure when fwspec is prepared.
+	 */
+	if (!mc->smmu || !fwspec || fwspec->ops != &tegra_smmu_ops)
 		return ERR_PTR(-ENODEV);
 
-	return &smmu->iommu;
+	dev_iommu_priv_set(dev, mc->smmu);
+
+	return &mc->smmu->iommu;
 }
 
 static void tegra_smmu_release_device(struct device *dev)
@@ -1089,16 +1027,6 @@ struct tegra_smmu *tegra_smmu_probe(struct device *dev,
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
