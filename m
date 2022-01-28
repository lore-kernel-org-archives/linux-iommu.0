Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F931C433F5
	for <iommu@archiver.kernel.org>; Fri, 28 Jan 2022 10:50:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8C9FC40462;
	Fri, 28 Jan 2022 10:50:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2BOlNe1W4eIZ; Fri, 28 Jan 2022 10:50:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E6F0740463;
	Fri, 28 Jan 2022 10:50:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 97749C001A;
	Fri, 28 Jan 2022 10:50:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9DAF7C000B
 for <iommu@lists.linux-foundation.org>; Fri, 28 Jan 2022 10:50:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8471E40942
 for <iommu@lists.linux-foundation.org>; Fri, 28 Jan 2022 10:50:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MUKsg2sbGIoD for <iommu@lists.linux-foundation.org>;
 Fri, 28 Jan 2022 10:50:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0283E4093F
 for <iommu@lists.linux-foundation.org>; Fri, 28 Jan 2022 10:50:02 +0000 (UTC)
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.206])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JlZ310Wymz67dnT;
 Fri, 28 Jan 2022 18:49:33 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Fri, 28 Jan 2022 11:49:58 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 28 Jan 2022 10:49:57 +0000
To: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>
Subject: [PATCH] iommu: Fix some W=1 warnings
Date: Fri, 28 Jan 2022 18:44:33 +0800
Message-ID: <1643366673-26803-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

The code is mostly free of W=1 warning, so fix the following:

drivers/iommu/iommu.c:996: warning: expecting prototype for iommu_group_for_each_dev(). Prototype was for __iommu_group_for_each_dev() instead
drivers/iommu/iommu.c:3048: warning: Function parameter or member 'drvdata' not described in 'iommu_sva_bind_device'
drivers/iommu/ioasid.c:354: warning: Function parameter or member 'ioasid' not described in 'ioasid_get'
drivers/iommu/omap-iommu.c:1098: warning: expecting prototype for omap_iommu_suspend_prepare(). Prototype was for omap_iommu_prepare() instead

Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
index 50ee27bbd04e..06fee7416816 100644
--- a/drivers/iommu/ioasid.c
+++ b/drivers/iommu/ioasid.c
@@ -349,6 +349,7 @@ EXPORT_SYMBOL_GPL(ioasid_alloc);
 
 /**
  * ioasid_get - obtain a reference to the IOASID
+ * @ioasid: the ID to get
  */
 void ioasid_get(ioasid_t ioasid)
 {
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 8b86406b7162..75741ce748d5 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -980,17 +980,6 @@ static int iommu_group_device_count(struct iommu_group *group)
 	return ret;
 }
 
-/**
- * iommu_group_for_each_dev - iterate over each device in the group
- * @group: the group
- * @data: caller opaque data to be passed to callback function
- * @fn: caller supplied callback function
- *
- * This function is called by group users to iterate over group devices.
- * Callers should hold a reference count to the group during callback.
- * The group->mutex is held across callbacks, which will block calls to
- * iommu_group_add/remove_device.
- */
 static int __iommu_group_for_each_dev(struct iommu_group *group, void *data,
 				      int (*fn)(struct device *, void *))
 {
@@ -1005,7 +994,17 @@ static int __iommu_group_for_each_dev(struct iommu_group *group, void *data,
 	return ret;
 }
 
-
+/**
+ * iommu_group_for_each_dev - iterate over each device in the group
+ * @group: the group
+ * @data: caller opaque data to be passed to callback function
+ * @fn: caller supplied callback function
+ *
+ * This function is called by group users to iterate over group devices.
+ * Callers should hold a reference count to the group during callback.
+ * The group->mutex is held across callbacks, which will block calls to
+ * iommu_group_add/remove_device.
+ */
 int iommu_group_for_each_dev(struct iommu_group *group, void *data,
 			     int (*fn)(struct device *, void *))
 {
@@ -3032,6 +3031,7 @@ EXPORT_SYMBOL_GPL(iommu_aux_get_pasid);
  * iommu_sva_bind_device() - Bind a process address space to a device
  * @dev: the device
  * @mm: the mm to bind, caller must hold a reference to it
+ * @drvdata: opaque data pointer to pass to bind callback
  *
  * Create a bond between device and address space, allowing the device to access
  * the mm using the returned PASID. If a bond already exists between @device and
diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 91749654fd49..980e4af3f06b 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1085,7 +1085,7 @@ static __maybe_unused int omap_iommu_runtime_resume(struct device *dev)
 }
 
 /**
- * omap_iommu_suspend_prepare - prepare() dev_pm_ops implementation
+ * omap_iommu_prepare - prepare() dev_pm_ops implementation
  * @dev:	iommu device
  *
  * This function performs the necessary checks to determine if the IOMMU
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
