Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3907DC433F5
	for <iommu@archiver.kernel.org>; Mon,  4 Apr 2022 11:33:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DA05D40256;
	Mon,  4 Apr 2022 11:33:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9FNzvmdk6G1R; Mon,  4 Apr 2022 11:33:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5B29940241;
	Mon,  4 Apr 2022 11:33:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2B039C002C;
	Mon,  4 Apr 2022 11:33:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F273DC0012;
 Mon,  4 Apr 2022 11:33:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D1CB84022A;
 Mon,  4 Apr 2022 11:33:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 20RIgRhB5Fha; Mon,  4 Apr 2022 11:33:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A702F401B2;
 Mon,  4 Apr 2022 11:33:10 +0000 (UTC)
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KX7rX4qvzz67Lqc;
 Mon,  4 Apr 2022 19:31:08 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Mon, 4 Apr 2022 13:33:08 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 4 Apr 2022 12:33:05 +0100
To: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>
Subject: [PATCH RESEND v5 3/5] iommu: Allow iommu_change_dev_def_domain()
 realloc same default domain type
Date: Mon, 4 Apr 2022 19:27:12 +0800
Message-ID: <1649071634-188535-4-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1649071634-188535-1-git-send-email-john.garry@huawei.com>
References: <1649071634-188535-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: jean-philippe@linaro.org, jasowang@redhat.com, mst@redhat.com,
 linuxarm@huawei.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org
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
From: John Garry via iommu <iommu@lists.linux-foundation.org>
Reply-To: John Garry <john.garry@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Allow iommu_change_dev_def_domain() to create a new default domain, keeping
the same as current.

Also remove comment about the function purpose, which will become stale.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/iommu/iommu.c | 49 ++++++++++++++++++++++---------------------
 include/linux/iommu.h |  1 +
 2 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 0dd766030baf..10bb10c2a210 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2863,6 +2863,7 @@ u32 iommu_sva_get_pasid(struct iommu_sva *handle)
 }
 EXPORT_SYMBOL_GPL(iommu_sva_get_pasid);
 
+
 /*
  * Changes the default domain of an iommu group that has *only* one device
  *
@@ -2873,10 +2874,6 @@ EXPORT_SYMBOL_GPL(iommu_sva_get_pasid);
  *
  * Returns 0 on success and error code on failure
  *
- * Note:
- * 1. Presently, this function is called only when user requests to change the
- *    group's default domain type through /sys/kernel/iommu_groups/<grp_id>/type
- *    Please take a closer look if intended to use for other purposes.
  */
 static int iommu_change_dev_def_domain(struct iommu_group *group,
 				       struct device *prev_dev, int type)
@@ -2929,28 +2926,32 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
 		goto out;
 	}
 
-	dev_def_dom = iommu_get_def_domain_type(dev);
-	if (!type) {
+	if (type == __IOMMU_DOMAIN_SAME) {
+		type = prev_dom->type;
+	} else {
+		dev_def_dom = iommu_get_def_domain_type(dev);
+		if (!type) {
+			/*
+			 * If the user hasn't requested any specific type of domain and
+			 * if the device supports both the domains, then default to the
+			 * domain the device was booted with
+			 */
+			type = dev_def_dom ? : iommu_def_domain_type;
+		} else if (dev_def_dom && type != dev_def_dom) {
+			dev_err_ratelimited(prev_dev, "Device cannot be in %s domain\n",
+					    iommu_domain_type_str(type));
+			ret = -EINVAL;
+			goto out;
+		}
+
 		/*
-		 * If the user hasn't requested any specific type of domain and
-		 * if the device supports both the domains, then default to the
-		 * domain the device was booted with
+		 * Switch to a new domain only if the requested domain type is different
+		 * from the existing default domain type
 		 */
-		type = dev_def_dom ? : iommu_def_domain_type;
-	} else if (dev_def_dom && type != dev_def_dom) {
-		dev_err_ratelimited(prev_dev, "Device cannot be in %s domain\n",
-				    iommu_domain_type_str(type));
-		ret = -EINVAL;
-		goto out;
-	}
-
-	/*
-	 * Switch to a new domain only if the requested domain type is different
-	 * from the existing default domain type
-	 */
-	if (prev_dom->type == type) {
-		ret = 0;
-		goto out;
+		if (prev_dom->type == type) {
+			ret = 0;
+			goto out;
+		}
 	}
 
 	/* We can bring up a flush queue without tearing down the domain */
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 9208eca4b0d1..b141cf71c7af 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -63,6 +63,7 @@ struct iommu_domain_geometry {
 					      implementation              */
 #define __IOMMU_DOMAIN_PT	(1U << 2)  /* Domain is identity mapped   */
 #define __IOMMU_DOMAIN_DMA_FQ	(1U << 3)  /* DMA-API uses flush queue    */
+#define __IOMMU_DOMAIN_SAME	(1U << 4)  /* Keep same type (internal)   */
 
 /*
  * This are the possible domain-types
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
