Return-Path: <SRS0=cnVx=DD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18A2C4727F
	for <iommu@archiver.kernel.org>; Sat, 26 Sep 2020 08:12:37 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D6F82177B
	for <iommu@archiver.kernel.org>; Sat, 26 Sep 2020 08:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TsMf55c7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D6F82177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1D6C48756D;
	Sat, 26 Sep 2020 08:12:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ja1qYNi+fBRA; Sat, 26 Sep 2020 08:12:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 148618752B;
	Sat, 26 Sep 2020 08:12:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EFBCEC0895;
	Sat, 26 Sep 2020 08:12:35 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 535C3C0051
 for <iommu@lists.linux-foundation.org>; Sat, 26 Sep 2020 08:12:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 4E739874DF
 for <iommu@lists.linux-foundation.org>; Sat, 26 Sep 2020 08:12:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HUs5CaJyNhWs for <iommu@lists.linux-foundation.org>;
 Sat, 26 Sep 2020 08:12:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com
 [209.85.216.65])
 by hemlock.osuosl.org (Postfix) with ESMTPS id DEB6D874BA
 for <iommu@lists.linux-foundation.org>; Sat, 26 Sep 2020 08:12:32 +0000 (UTC)
Received: by mail-pj1-f65.google.com with SMTP id fa1so682183pjb.0
 for <iommu@lists.linux-foundation.org>; Sat, 26 Sep 2020 01:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=4N2RU9Ug7heB8a6NcMVwTlvvnh89jdIRun82jXeq3G8=;
 b=TsMf55c7ja55kZb8XRYBn19eKpbGNQUAiN6GDEdfxyh/MeijTAdLF1J82dBA5m+kik
 j0KlgcvcvtfminbRImgiomnQaQKZDrqPqt5m+v/axnh1cIW7z44+B3vVWBURr+91G/v5
 OvRfulPc5r/km0NLdYrJMNktEnDA63LI7fZEdrC/Xg5KsnNsjwvKxztlSDLxy21ChhZI
 pBt1yvaiT3rB0xwl5P7eCiul5FhvPKe96fBisMwe63KtwFCC3452B7ibydP9GE5xM96d
 t1D3/epKaiORAwbUG/cu2fMlXbOdk8ypg5RLmcyOx3HVXQ/wY8Iz44RPO/qj2qA1gwp3
 njAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=4N2RU9Ug7heB8a6NcMVwTlvvnh89jdIRun82jXeq3G8=;
 b=b3zWmwrCH1iKXwQuQ2zi5JdAbx8/y3jHkl/mPIQZb6nYZSClSnuPkeveFaxCrhoXwJ
 L90dLH3yNM/xCGRUz0QnV2ovYNFt3pACTphCi3snBesvOGXx1ZMVTL2Aa7h09XBi1V/b
 0+/ug28iW1hJX6gDKdZJYLx9Tw/IZzsvl8qbwheeHgcaibuKv/AjUHCuIDAtk2R35MkV
 g05t6ZPRGnk/KJ/2gb5zw4F5xmWQ3vGaMlfSNsU9SHAgcTtylZ9AGLgubLlla0Jd5+an
 mVRAbU9R0sM2E6nRoKw253mSfQys3afrQ3PxSyJSOkXcQanM12UJkWCLKsZKLYVnWBYw
 CGgQ==
X-Gm-Message-State: AOAM530tyahgJNg0CYVpQMytUza1/6Q76CafnZhH+amgjgXkzJpn7uus
 A/g2P8e/EA2v0h0xaJgQFu8=
X-Google-Smtp-Source: ABdhPJwEPdNila3vp3a63sOLkMJAbK9eU0IlCNDn4Y5WBmWj6jjkznuUsugSZPjO284NVlXgV/QGww==
X-Received: by 2002:a17:90a:d512:: with SMTP id
 t18mr1205484pju.106.1601107952502; 
 Sat, 26 Sep 2020 01:12:32 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id i1sm4833497pfk.21.2020.09.26.01.12.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2020 01:12:32 -0700 (PDT)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: thierry.reding@gmail.com,
	joro@8bytes.org,
	krzk@kernel.org
Subject: [PATCH 4/5] iommu/tegra-smmu: Add PCI support
Date: Sat, 26 Sep 2020 01:07:18 -0700
Message-Id: <20200926080719.6822-5-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200926080719.6822-1-nicoleotsuka@gmail.com>
References: <20200926080719.6822-1-nicoleotsuka@gmail.com>
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

This patch simply adds support for PCI devices.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 drivers/iommu/tegra-smmu.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 97a7185b4578..9dbc5d7183cc 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -15,6 +15,7 @@
 #include <linux/spinlock.h>
 #include <linux/dma-iommu.h>
 #include <linux/dma-mapping.h>
+#include <linux/pci.h>
 
 #include <soc/tegra/ahb.h>
 #include <soc/tegra/mc.h>
@@ -935,6 +936,7 @@ static struct iommu_group *tegra_smmu_device_group(struct device *dev)
 	const struct tegra_smmu_group_soc *soc;
 	struct tegra_smmu_group *group;
 	int swgroup = fwspec->ids[0];
+	bool pci = dev_is_pci(dev);
 	struct iommu_group *grp;
 
 	/* Find group_soc associating with swgroup */
@@ -961,7 +963,7 @@ static struct iommu_group *tegra_smmu_device_group(struct device *dev)
 	group->smmu = smmu;
 	group->soc = soc;
 
-	group->group = iommu_group_alloc();
+	group->group = pci ? pci_device_group(dev) : iommu_group_alloc();
 	if (IS_ERR(group->group)) {
 		devm_kfree(smmu->dev, group);
 		mutex_unlock(&smmu->lock);
@@ -1180,6 +1182,19 @@ struct tegra_smmu *tegra_smmu_probe(struct device *dev,
 		return ERR_PTR(err);
 	}
 
+#ifdef CONFIG_PCI
+	if (!iommu_present(&pci_bus_type)) {
+		pci_request_acs();
+		err = bus_set_iommu(&pci_bus_type, &tegra_smmu_ops);
+		if (err < 0) {
+			bus_set_iommu(&platform_bus_type, NULL);
+			iommu_device_unregister(&smmu->iommu);
+			iommu_device_sysfs_remove(&smmu->iommu);
+			return ERR_PTR(err);
+		}
+	}
+#endif
+
 	if (IS_ENABLED(CONFIG_DEBUG_FS))
 		tegra_smmu_debugfs_init(smmu);
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
