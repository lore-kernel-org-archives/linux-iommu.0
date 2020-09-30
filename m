Return-Path: <SRS0=Vh7E=DH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791B7C47420
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 00:35:52 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AB8D2076D
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 00:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pxhfrzpq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AB8D2076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8AFB186FEC;
	Wed, 30 Sep 2020 00:35:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WIMEHM-S88kk; Wed, 30 Sep 2020 00:35:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6B10186FF8;
	Wed, 30 Sep 2020 00:35:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5893DC0895;
	Wed, 30 Sep 2020 00:35:50 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ECE59C0051
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 00:35:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E3D1486769
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 00:35:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MnH5FgmXzigg for <iommu@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 00:35:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com
 [209.85.210.195])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 07F5586764
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 00:35:46 +0000 (UTC)
Received: by mail-pf1-f195.google.com with SMTP id o20so6533322pfp.11
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 17:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=0JKwq4xWqRDtKY/505TBB9qcW7wqaAmrqQLYgVgG3P8=;
 b=Pxhfrzpqn07811bKPdiORj40VYqKBMUrQZAYaShO63bptEqeBCoDTq8ZXWpvtyAzlU
 bEt0JLNwWs0qYndjSUJUVa364RMNEAolTMlQtIpVM28XO4n8HpjM7lFD0sk5KtCN/ral
 8S0jk/Kr32HbXJ5lg8OC849/gxvM+2cZwixDvnZkT0iBtJnF1U78uYt1bfaoQPEySwsG
 059weps1GxE7Q5B69fglKbTTWfp5rdRo6uM/oBGkAt3p+29GkdWvN0Zu78rNLu6D7xEZ
 mUO+6h6zKfF2zQUJSQ4HJ1wTCwJfTotEFoEUWuJUTDbZzt6YgchtWc+OiFG7Yyf47McF
 DQvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=0JKwq4xWqRDtKY/505TBB9qcW7wqaAmrqQLYgVgG3P8=;
 b=MBaLrb96bYQRnhOJLuwjrC0PdB6gL76ZMN8/ViBj/QvLQJpVZ+d2GzkQ5C60dMwwNa
 DccTckrjHCNbfpPDMlMzpHKnmkeXpdOJhKh8Xd/DjGwR2favzPi7uP/adKKTAZQUS/So
 BwN4WQH3XQkRTc9IECiYbsqnZLWv+fAtUu2NfdKgpv8aOsx9SYVrcg0SJPhOyCx7Hkic
 4lQNZ17FkUfnpu0RIZSr/GK3KR44KhvuNK4o4Z/weK26GvkrpOHosRdxxVUDgosf6eds
 n6Kg7ecsP/HSEyiEljTz+09KeIZaGWU5ftZVZuP2w+r/4uh8jVolLkNtoW8Y2UZUCut8
 BzyQ==
X-Gm-Message-State: AOAM531Fjz3o1iVFUZnGin4rwmejELqyDlKTcA+ZN/1lpNT6y0sxw0+O
 UtKyXGEUvPShn/t7dWRxi4agImva/C4=
X-Google-Smtp-Source: ABdhPJwoJYNqTW64FEhXuMlCDahgdopeFsqNGFYmWOTHBylaP+JP0dayCAoR4EWqiGLAVSXU+IyTlA==
X-Received: by 2002:a63:ff4e:: with SMTP id s14mr126562pgk.137.1601426146506; 
 Tue, 29 Sep 2020 17:35:46 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id x185sm6904738pfc.188.2020.09.29.17.35.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 17:35:46 -0700 (PDT)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: thierry.reding@gmail.com, joro@8bytes.org, krzk@kernel.org,
 digetx@gmail.com
Subject: [PATCH v2 2/3] iommu/tegra-smmu: Rework .probe_device and .attach_dev
Date: Tue, 29 Sep 2020 17:30:12 -0700
Message-Id: <20200930003013.31289-3-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200930003013.31289-1-nicoleotsuka@gmail.com>
References: <20200930003013.31289-1-nicoleotsuka@gmail.com>
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

Additionally, as new helper function tegra_get_memory_controller()
is introduced, there's no need to poll the iommus property in order
to get mc->smmu pointers or SWGROUP id.

This patch reworks .probe_device() and .attach_dev() by doing:
1) Using fwspec to get swgroup id in .attach_dev/.dettach_dev()
2) Removing DT polling code, tegra_smmu_find/tegra_smmu_configure()
3) Calling tegra_get_memory_controller() in .probe_device() instead
4) Also dropping the hack in .probe() that's no longer needed.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---

Changelog
v1->v2
 * Replaced in .probe_device() tegra_smmu_find/tegra_smmu_configure()
   with tegra_get_memory_controller call.
 * Dropped the hack in tegra_smmu_probe().

 drivers/iommu/tegra-smmu.c | 144 ++++++++++---------------------------
 1 file changed, 36 insertions(+), 108 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 6a3ecc334481..cf4981369828 100644
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
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct tegra_mc *mc = tegra_get_memory_controller();
 
-		of_node_put(args.np);
-		index++;
-	}
+	/* An invalid mc pointer means mc and smmu drivers are not ready */
+	if (IS_ERR_OR_NULL(mc))
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
