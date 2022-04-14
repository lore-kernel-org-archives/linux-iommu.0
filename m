Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 870DCC433F5
	for <iommu@archiver.kernel.org>; Thu, 14 Apr 2022 12:42:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 26C5A84177;
	Thu, 14 Apr 2022 12:42:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VGU_8y6_zlab; Thu, 14 Apr 2022 12:42:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1392484174;
	Thu, 14 Apr 2022 12:42:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F0DACC0033;
	Thu, 14 Apr 2022 12:42:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0658EC002C
 for <iommu@lists.linux-foundation.org>; Thu, 14 Apr 2022 12:42:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DFA2C4190E
 for <iommu@lists.linux-foundation.org>; Thu, 14 Apr 2022 12:42:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XcqYP5FeZ-XD for <iommu@lists.linux-foundation.org>;
 Thu, 14 Apr 2022 12:42:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0B6594190A
 for <iommu@lists.linux-foundation.org>; Thu, 14 Apr 2022 12:42:52 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 25A44139F;
 Thu, 14 Apr 2022 05:42:52 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com
 [10.1.196.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2B9943F70D;
 Thu, 14 Apr 2022 05:42:50 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Subject: [PATCH 02/13] iommu: Move bus setup to IOMMU device registration
Date: Thu, 14 Apr 2022 13:42:31 +0100
Message-Id: <e607a32be8e84c56d65160902f4bd3fb434ee9d3.1649935679.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.28.0.dirty
In-Reply-To: <cover.1649935679.git.robin.murphy@arm.com>
References: <cover.1649935679.git.robin.murphy@arm.com>
MIME-Version: 1.0
Cc: jean-philippe@linaro.org, zhang.lyra@gmail.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 thierry.reding@gmail.com, linux-arm-kernel@lists.infradead.org,
 gerald.schaefer@linux.ibm.com
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

Move the bus setup to iommu_device_register(). This should allow
bus_iommu_probe() to be correctly replayed for multiple IOMMU instances,
and leaves bus_set_iommu() as a glorfied no-op to be cleaned up next.

Note that although the handling of errors from bus_iommu_probe() looks
inadequate, it is merely preserving the well-established existing
behaviour. This could be improved in future - probably combined with
equivalent cleanup for iommu_device_unregister() - but that isn't a
priority right now.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/iommu.c | 50 ++++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 13e1a8bd5435..51205c33c426 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -175,6 +175,14 @@ static int __init iommu_subsys_init(void)
 }
 subsys_initcall(iommu_subsys_init);
 
+static int remove_iommu_group(struct device *dev, void *data)
+{
+	if (dev->iommu && dev->iommu->iommu_dev == data)
+		iommu_release_device(dev);
+
+	return 0;
+}
+
 /**
  * iommu_device_register() - Register an IOMMU hardware instance
  * @iommu: IOMMU handle for the instance
@@ -197,6 +205,22 @@ int iommu_device_register(struct iommu_device *iommu,
 	spin_lock(&iommu_device_lock);
 	list_add_tail(&iommu->list, &iommu_device_list);
 	spin_unlock(&iommu_device_lock);
+
+	for (int i = 0; i < ARRAY_SIZE(iommu_buses); i++) {
+		struct bus_type *bus = iommu_buses[i];
+		const struct iommu_ops *bus_ops = bus->iommu_ops;
+		int err;
+
+		WARN_ON(bus_ops && bus_ops != ops);
+		bus->iommu_ops = ops;
+		err = bus_iommu_probe(bus);
+		if (err) {
+			bus_for_each_dev(bus, NULL, iommu, remove_iommu_group);
+			bus->iommu_ops = bus_ops;
+			return err;
+		}
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(iommu_device_register);
@@ -1654,13 +1678,6 @@ static int probe_iommu_group(struct device *dev, void *data)
 	return ret;
 }
 
-static int remove_iommu_group(struct device *dev, void *data)
-{
-	iommu_release_device(dev);
-
-	return 0;
-}
-
 static int iommu_bus_notifier(struct notifier_block *nb,
 			      unsigned long action, void *data)
 {
@@ -1883,27 +1900,12 @@ static int iommu_bus_init(struct bus_type *bus)
  */
 int bus_set_iommu(struct bus_type *bus, const struct iommu_ops *ops)
 {
-	int err;
-
-	if (ops == NULL) {
-		bus->iommu_ops = NULL;
-		return 0;
-	}
-
-	if (bus->iommu_ops != NULL)
+	if (bus->iommu_ops && ops && bus->iommu_ops != ops)
 		return -EBUSY;
 
 	bus->iommu_ops = ops;
 
-	/* Do IOMMU specific setup for this bus-type */
-	err = bus_iommu_probe(bus);
-	if (err) {
-		/* Clean up */
-		bus_for_each_dev(bus, NULL, NULL, remove_iommu_group);
-		bus->iommu_ops = NULL;
-	}
-
-	return err;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(bus_set_iommu);
 
-- 
2.28.0.dirty

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
