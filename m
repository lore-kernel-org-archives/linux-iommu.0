Return-Path: <SRS0=p9ZB=5X=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B2E3C2BB85
	for <iommu@archiver.kernel.org>; Tue,  7 Apr 2020 18:38:33 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CB5F2076E
	for <iommu@archiver.kernel.org>; Tue,  7 Apr 2020 18:38:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CB5F2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id EBD18221B5;
	Tue,  7 Apr 2020 18:38:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o01yVYvRk-co; Tue,  7 Apr 2020 18:38:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id BFEC222128;
	Tue,  7 Apr 2020 18:38:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AC82CC1D8D;
	Tue,  7 Apr 2020 18:38:15 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9F79DC1D8E;
 Tue,  7 Apr 2020 18:38:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9B6E185C47;
 Tue,  7 Apr 2020 18:38:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tzpjmstALT5R; Tue,  7 Apr 2020 18:38:04 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 08A4F85F2D;
 Tue,  7 Apr 2020 18:38:04 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 667F868C; Tue,  7 Apr 2020 20:37:54 +0200 (CEST)
From: Joerg Roedel <joro@8bytes.org>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Kukjin Kim <kgene@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 Andy Gross <agross@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Clark <robdclark@gmail.com>,
 Heiko Stuebner <heiko@sntech.de>,
 Gerald Schaefer <gerald.schaefer@de.ibm.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [RFC PATCH 31/34] iommu/exynos: Create iommu_device in struct
 exynos_iommu_owner
Date: Tue,  7 Apr 2020 20:37:39 +0200
Message-Id: <20200407183742.4344-32-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200407183742.4344-1-joro@8bytes.org>
References: <20200407183742.4344-1-joro@8bytes.org>
Cc: linux-s390@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-rockchip@lists.infradead.org,
 iommu@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>,
 linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org
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

From: Joerg Roedel <jroedel@suse.de>

The 'struct exynos_iommu_owner' is an umbrella for multiple SYSMMU
instances attached to one master. As such all these instances are
handled the same, they are all configured with the same iommu_domain,
for example.

The IOMMU core code expects each device to have only one IOMMU
attached, so create the IOMMU-device for the umbrella instead of each
hardware SYSMMU.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/exynos-iommu.c | 96 +++++++++++++++++++++++++++---------
 1 file changed, 73 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 186ff5cc975c..86ecccbf0438 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -235,6 +235,8 @@ struct exynos_iommu_owner {
 	struct list_head controllers;	/* list of sysmmu_drvdata.owner_node */
 	struct iommu_domain *domain;	/* domain this device is attached */
 	struct mutex rpm_lock;		/* for runtime pm of all sysmmus */
+
+	struct iommu_device iommu;	/* IOMMU core handle */
 };
 
 /*
@@ -274,8 +276,6 @@ struct sysmmu_drvdata {
 	struct list_head owner_node;	/* node for owner controllers list */
 	phys_addr_t pgtable;		/* assigned page table structure */
 	unsigned int version;		/* our version */
-
-	struct iommu_device iommu;	/* IOMMU core handle */
 };
 
 static struct exynos_iommu_domain *to_exynos_domain(struct iommu_domain *dom)
@@ -625,18 +625,6 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
 	data->sysmmu = dev;
 	spin_lock_init(&data->lock);
 
-	ret = iommu_device_sysfs_add(&data->iommu, &pdev->dev, NULL,
-				     dev_name(data->sysmmu));
-	if (ret)
-		return ret;
-
-	iommu_device_set_ops(&data->iommu, &exynos_iommu_ops);
-	iommu_device_set_fwnode(&data->iommu, &dev->of_node->fwnode);
-
-	ret = iommu_device_register(&data->iommu);
-	if (ret)
-		return ret;
-
 	platform_set_drvdata(pdev, data);
 
 	__sysmmu_get_version(data);
@@ -1261,6 +1249,8 @@ static int exynos_iommu_add_device(struct device *dev)
 	}
 	iommu_group_put(group);
 
+	iommu_device_link(&owner->iommu, dev);
+
 	return 0;
 }
 
@@ -1282,18 +1272,82 @@ static void exynos_iommu_remove_device(struct device *dev)
 			iommu_group_put(group);
 		}
 	}
+	iommu_device_unlink(&owner->iommu, dev);
 	iommu_group_remove_device(dev);
 
 	list_for_each_entry(data, &owner->controllers, owner_node)
 		device_link_del(data->link);
 }
 
+static int exynos_iommu_device_init(struct exynos_iommu_owner *owner)
+{
+	static u32 counter = 0;
+	int ret;
+
+	/*
+	 * Create a virtual IOMMU device. In reality it is an umbrella for a
+	 * number of SYSMMU platform devices, but that also means that any
+	 * master can have more than one real IOMMU device. This drivers handles
+	 * all the real devices for one master synchronously, so they appear as
+	 * one anyway.
+	 */
+	ret = iommu_device_sysfs_add(&owner->iommu, NULL, NULL,
+				     "sysmmu-owner-%d", counter++);
+	if (ret)
+		return ret;
+
+	iommu_device_set_ops(&owner->iommu, &exynos_iommu_ops);
+
+	return 0;
+}
+
+static void exynos_iommu_device_remove(struct exynos_iommu_owner *owner)
+{
+	iommu_device_set_ops(&owner->iommu, NULL);
+	iommu_device_sysfs_remove(&owner->iommu);
+}
+
+static int exynos_owner_init(struct device *dev)
+{
+	struct exynos_iommu_owner *owner = dev->archdata.iommu;
+	int ret;
+
+	if (owner)
+		return 0;
+
+	owner = kzalloc(sizeof(*owner), GFP_KERNEL);
+	if (!owner)
+		return -ENOMEM;
+
+	ret = exynos_iommu_device_init(owner);
+	if (ret)
+		goto out_free_owner;
+
+	ret = iommu_device_register(&owner->iommu);
+	if (ret)
+		goto out_remove_iommu_device;
+
+	INIT_LIST_HEAD(&owner->controllers);
+	mutex_init(&owner->rpm_lock);
+	dev->archdata.iommu = owner;
+
+	return 0;
+
+out_remove_iommu_device:
+	exynos_iommu_device_remove(owner);
+out_free_owner:
+	kfree(owner);
+
+	return ret;
+}
+
 static int exynos_iommu_of_xlate(struct device *dev,
 				 struct of_phandle_args *spec)
 {
-	struct exynos_iommu_owner *owner = dev->archdata.iommu;
 	struct platform_device *sysmmu = of_find_device_by_node(spec->np);
 	struct sysmmu_drvdata *data, *entry;
+	struct exynos_iommu_owner *owner;
+	int ret;
 
 	if (!sysmmu)
 		return -ENODEV;
@@ -1302,15 +1356,11 @@ static int exynos_iommu_of_xlate(struct device *dev,
 	if (!data)
 		return -ENODEV;
 
-	if (!owner) {
-		owner = kzalloc(sizeof(*owner), GFP_KERNEL);
-		if (!owner)
-			return -ENOMEM;
+	ret = exynos_owner_init(dev);
+	if (ret)
+		return ret;
 
-		INIT_LIST_HEAD(&owner->controllers);
-		mutex_init(&owner->rpm_lock);
-		dev->archdata.iommu = owner;
-	}
+	owner = dev->archdata.iommu;
 
 	list_for_each_entry(entry, &owner->controllers, owner_node)
 		if (entry == data)
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
