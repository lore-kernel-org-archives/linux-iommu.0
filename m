Return-Path: <SRS0=qGVY=DL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E6ABC4727F
	for <iommu@archiver.kernel.org>; Sun,  4 Oct 2020 22:45:11 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13A962065D
	for <iommu@archiver.kernel.org>; Sun,  4 Oct 2020 22:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jW+udd2/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13A962065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id AEFD585381;
	Sun,  4 Oct 2020 22:45:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UWy32P07iVW2; Sun,  4 Oct 2020 22:45:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id BF398853B9;
	Sun,  4 Oct 2020 22:45:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 936FDC0895;
	Sun,  4 Oct 2020 22:45:07 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AEA88C0051
 for <iommu@lists.linux-foundation.org>; Sun,  4 Oct 2020 22:45:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A5F8E853B9
 for <iommu@lists.linux-foundation.org>; Sun,  4 Oct 2020 22:45:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Xx15yDzPGCI4 for <iommu@lists.linux-foundation.org>;
 Sun,  4 Oct 2020 22:45:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com
 [209.85.210.196])
 by whitealder.osuosl.org (Postfix) with ESMTPS id F1D5E85381
 for <iommu@lists.linux-foundation.org>; Sun,  4 Oct 2020 22:45:05 +0000 (UTC)
Received: by mail-pf1-f196.google.com with SMTP id d6so5345169pfn.9
 for <iommu@lists.linux-foundation.org>; Sun, 04 Oct 2020 15:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Qf45Jazhnw0AWQkWquvjrDOvbvMExg67USrpZGI37ZQ=;
 b=jW+udd2/4F14aVvfzcWbJlMOSrs29d/NsRoba0M2iNM8OvKRpPM7ivzeR1SjpywUrL
 8vD359RzcgC1zDQry8L2yBd7Yrt+VO62WYfTFOVRqlcUIwMpUwrCcX/SwA7l9tPd/TrK
 vHvbvWdOjEvxkNYi9t6bgFdnqVSjKZfTIKEKKvxmVeC7YaUExGyBhzGRL6kwxoWr6nFM
 ey5fFiaMo1T9X0Wwn+tfWHxS1Aug1sNN3vy3d+kF+f6+z/LjYDk/RQWrUWs8owvFxvSK
 gXlXCvY/YQDeBXiVH+q4swCpWaif7jJSPeJHQ9E97hs1zEBSSfClkMtK/DllJIxzPGw/
 pnmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Qf45Jazhnw0AWQkWquvjrDOvbvMExg67USrpZGI37ZQ=;
 b=IK8IqOE6PA74z9BcfSvdkGrjXg7pCeH0JF8v6RYXeZ2pb8D7T251No8QkZ6n7vqwnO
 Be7qz43fHSSNkiiZzxhYAvm8wCav/yD3oJ0Ov6t09oF7DHiOhc3cQHRsqanxvMZzKILC
 VUaV+A9rRUxSkP7TyeQ74NMAefeUi8m4vJs0qHOIa52z0fQ697BQRpz5RhaROH7G58Al
 lIjXlUCCOdu6P+5gTfauGdSdPNZXg+cgrQ15iH1XBAY9tsxHxjrvSgqyPKisrAcscZYA
 brv0Lo89IFEB9i3xFS80R03ZpJxIjjh9J84LZk9ZMBT/qQnI5hsWBFxR5C9MTy2lSDCq
 BZKw==
X-Gm-Message-State: AOAM531UqsnHAJ5ueJle+IwHsmg4q2vnDJRnunSoPmwDOjQlKrgJDmAw
 sMtZnmZc9BAt7RgE+VvMz4c=
X-Google-Smtp-Source: ABdhPJwg1OstrsEfqzgNeEikSkjxOX/tqMbxN7Jr5u8AUcZlZkRbcrp2egWbxXa1TEHG1uLkevZhbA==
X-Received: by 2002:aa7:8885:0:b029:142:2501:39ea with SMTP id
 z5-20020aa788850000b0290142250139eamr4427245pfe.57.1601851505561; 
 Sun, 04 Oct 2020 15:45:05 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id d129sm9073236pfc.161.2020.10.04.15.45.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2020 15:45:05 -0700 (PDT)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: thierry.reding@gmail.com,
	joro@8bytes.org,
	digetx@gmail.com
Subject: [PATCH v6 1/3] iommu/tegra-smmu: Use fwspec in
 tegra_smmu_(de)attach_dev
Date: Sun,  4 Oct 2020 15:38:35 -0700
Message-Id: <20201004223837.15303-2-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201004223837.15303-1-nicoleotsuka@gmail.com>
References: <20201004223837.15303-1-nicoleotsuka@gmail.com>
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

In tegra_smmu_(de)attach_dev() functions, we poll DTB for each
client's iommus property to get swgroup ID in order to prepare
"as" and enable smmu. Actually tegra_smmu_configure() prepared
an fwspec for each client, and added to the fwspec all swgroup
IDs of client DT node in DTB.

So this patch uses fwspec in tegra_smmu_(de)attach_dev() so as
to replace the redundant DT polling code.

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
Tested-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---

Changelog
v5->v6:
 * Added Dmitry's Reviewed-by and Tested-by
v4->v5:
 * Removed "index" and "err" assigning to 0
v3->v4:
 * Seperated the change, as a cleanup, from the rework patch
v1->v3:
 * N/A

 drivers/iommu/tegra-smmu.c | 56 ++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 33 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 6a3ecc334481..297d49f3f80e 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -484,60 +484,50 @@ static void tegra_smmu_as_unprepare(struct tegra_smmu *smmu,
 static int tegra_smmu_attach_dev(struct iommu_domain *domain,
 				 struct device *dev)
 {
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct tegra_smmu *smmu = dev_iommu_priv_get(dev);
 	struct tegra_smmu_as *as = to_smmu_as(domain);
-	struct device_node *np = dev->of_node;
-	struct of_phandle_args args;
-	unsigned int index = 0;
-	int err = 0;
-
-	while (!of_parse_phandle_with_args(np, "iommus", "#iommu-cells", index,
-					   &args)) {
-		unsigned int swgroup = args.args[0];
-
-		if (args.np != smmu->dev->of_node) {
-			of_node_put(args.np);
-			continue;
-		}
+	unsigned int index;
+	int err;
 
-		of_node_put(args.np);
+	if (!fwspec)
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
-	unsigned int index = 0;
-
-	while (!of_parse_phandle_with_args(np, "iommus", "#iommu-cells", index,
-					   &args)) {
-		unsigned int swgroup = args.args[0];
+	unsigned int index;
 
-		if (args.np != smmu->dev->of_node) {
-			of_node_put(args.np);
-			continue;
-		}
-
-		of_node_put(args.np);
+	if (!fwspec)
+		return;
 
-		tegra_smmu_disable(smmu, swgroup, as->id);
+	for (index = 0; index < fwspec->num_ids; index++) {
+		tegra_smmu_disable(smmu, fwspec->ids[index], as->id);
 		tegra_smmu_as_unprepare(smmu, as);
-		index++;
 	}
 }
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
