Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71931C4332F
	for <iommu@archiver.kernel.org>; Mon, 25 Apr 2022 12:42:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0A5B9409F7;
	Mon, 25 Apr 2022 12:42:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kT4Kc_yV3Rwa; Mon, 25 Apr 2022 12:42:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A508F4024A;
	Mon, 25 Apr 2022 12:42:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7652EC0032;
	Mon, 25 Apr 2022 12:42:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9A0C0C002D
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 12:42:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 85ECF4048F
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 12:42:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v2YjQUAetzPf for <iommu@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 12:42:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id D57424032A
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 12:42:12 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 22446113E;
 Mon, 25 Apr 2022 05:42:12 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com
 [10.1.196.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AEB763F5A1;
 Mon, 25 Apr 2022 05:42:10 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org
Subject: [PATCH v4 1/4] iommu: Introduce device_iommu_capable()
Date: Mon, 25 Apr 2022 13:42:02 +0100
Message-Id: <8407eb9586677995b7a9fd70d0fd82d85929a9bb.1650878781.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.35.3.dirty
In-Reply-To: <cover.1650878781.git.robin.murphy@arm.com>
References: <cover.1650878781.git.robin.murphy@arm.com>
MIME-Version: 1.0
Cc: michael.jamet@intel.com, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, YehezkelShB@gmail.com,
 iommu@lists.linux-foundation.org, mario.limonciello@amd.com,
 andreas.noever@gmail.com, mika.westerberg@linux.intel.com, hch@lst.de
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

iommu_capable() only really works for systems where all IOMMU instances
are completely homogeneous, and all devices are IOMMU-mapped. Implement
the new variant which will be able to give a more accurate answer for
whichever device the caller is actually interested in, and even more so
once all the external users have been converted and we can reliably pass
the device pointer through the internal driver interface too.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v4: Hold off changing the internal callback interface for now

 drivers/iommu/iommu.c | 23 +++++++++++++++++++++++
 include/linux/iommu.h |  6 ++++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index f2c45b85b9fc..780c11734979 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1906,6 +1906,29 @@ bool iommu_present(struct bus_type *bus)
 }
 EXPORT_SYMBOL_GPL(iommu_present);
 
+/**
+ * device_iommu_capable() - check for a general IOMMU capability
+ * @dev: device to which the capability would be relevant, if available
+ * @cap: IOMMU capability
+ *
+ * Return: true if an IOMMU is present and supports the given capability
+ * for the given device, otherwise false.
+ */
+bool device_iommu_capable(struct device *dev, enum iommu_cap cap)
+{
+	const struct iommu_ops *ops;
+
+	if (!dev->iommu || !dev->iommu->iommu_dev)
+		return false;
+
+	ops = dev_iommu_ops(dev);
+	if (!ops->capable)
+		return false;
+
+	return ops->capable(cap);
+}
+EXPORT_SYMBOL_GPL(device_iommu_capable);
+
 bool iommu_capable(struct bus_type *bus, enum iommu_cap cap)
 {
 	if (!bus->iommu_ops || !bus->iommu_ops->capable)
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 9208eca4b0d1..e26cf84e5d82 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -417,6 +417,7 @@ static inline const struct iommu_ops *dev_iommu_ops(struct device *dev)
 extern int bus_set_iommu(struct bus_type *bus, const struct iommu_ops *ops);
 extern int bus_iommu_probe(struct bus_type *bus);
 extern bool iommu_present(struct bus_type *bus);
+extern bool device_iommu_capable(struct device *dev, enum iommu_cap cap);
 extern bool iommu_capable(struct bus_type *bus, enum iommu_cap cap);
 extern struct iommu_domain *iommu_domain_alloc(struct bus_type *bus);
 extern struct iommu_group *iommu_group_get_by_id(int id);
@@ -689,6 +690,11 @@ static inline bool iommu_present(struct bus_type *bus)
 	return false;
 }
 
+static inline bool device_iommu_capable(struct device *dev, enum iommu_cap cap)
+{
+	return false;
+}
+
 static inline bool iommu_capable(struct bus_type *bus, enum iommu_cap cap)
 {
 	return false;
-- 
2.35.3.dirty

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
