Return-Path: <SRS0=K8mx=DR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 237D4C433DF
	for <iommu@archiver.kernel.org>; Sat, 10 Oct 2020 08:18:19 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55F73207C4
	for <iommu@archiver.kernel.org>; Sat, 10 Oct 2020 08:18:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55F73207C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id C593987838;
	Sat, 10 Oct 2020 08:18:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CnEEb3qVC1vP; Sat, 10 Oct 2020 08:18:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3984287805;
	Sat, 10 Oct 2020 08:18:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 25706C07FF;
	Sat, 10 Oct 2020 08:18:17 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2E353C07FF
 for <iommu@lists.linux-foundation.org>; Sat, 10 Oct 2020 08:18:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 15815875BB
 for <iommu@lists.linux-foundation.org>; Sat, 10 Oct 2020 08:18:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uM5eTm6Ph-mQ for <iommu@lists.linux-foundation.org>;
 Sat, 10 Oct 2020 08:18:15 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from ZXSHCAS1.zhaoxin.com (ZXSHCAS1.zhaoxin.com [203.148.12.81])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 533D08771A
 for <iommu@lists.linux-foundation.org>; Sat, 10 Oct 2020 08:18:12 +0000 (UTC)
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHCAS1.zhaoxin.com
 (10.28.252.161) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sat, 10 Oct
 2020 16:02:58 +0800
Received: from localhost.localdomain (114.242.250.7) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sat, 10 Oct
 2020 16:02:56 +0800
From: FelixCuioc <FelixCui-oc@zhaoxin.com>
To: Joerg Roedel <joro@8bytes.org>, <iommu@lists.linux-foundation.org>,
 <linux-kernel@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, "Lu
 Baolu" <baolu.lu@linux.intel.com>, Dan Carpenter <dan.carpenter@oracle.com>,
 <kbuild@lists.01.org>
Subject: [PATCH v3 2/2] iommu/vt-d:Add support for probing ACPI device in RMRR
Date: Sat, 10 Oct 2020 04:02:41 -0400
Message-ID: <20201010080241.14642-3-FelixCui-oc@zhaoxin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201010080241.14642-1-FelixCui-oc@zhaoxin.com>
References: <20201010080241.14642-1-FelixCui-oc@zhaoxin.com>
MIME-Version: 1.0
X-Originating-IP: [114.242.250.7]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
Cc: TonyWWang-oc@zhaoxin.com, CobeChen-oc@zhaoxin.com
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

After acpi device in RMRR is detected,it is necessary
to establish a mapping for these devices.
In acpi_device_create_direct_mappings(),create a mapping
for the acpi device in RMRR.
Add a helper to achieve the acpi namespace device can
access the RMRR region.

Signed-off-by: FelixCuioc <FelixCui-oc@zhaoxin.com>
---
 drivers/iommu/intel/iommu.c | 29 +++++++++++++++++++++++++++++
 drivers/iommu/iommu.c       |  6 ++++++
 include/linux/iommu.h       |  2 ++
 3 files changed, 37 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 594b2f29c043..a0fe867aa1f5 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4844,6 +4844,21 @@ static int __init platform_optin_force_iommu(void)
 	return 1;
 }
 
+static int acpi_device_create_direct_mappings(struct device *pn_dev, struct device *acpi_device)
+{
+	struct iommu_group *group;
+
+	acpi_device->bus->iommu_ops = &intel_iommu_ops;
+	group = iommu_group_get(pn_dev);
+	if (!group) {
+		pr_warn("ACPI name space devices create direct mappings wrong!\n");
+		return -EINVAL;
+	}
+	__acpi_device_create_direct_mappings(group, acpi_device);
+
+	return 0;
+}
+
 static int __init probe_acpi_namespace_devices(void)
 {
 	struct dmar_drhd_unit *drhd;
@@ -4858,6 +4873,7 @@ static int __init probe_acpi_namespace_devices(void)
 			struct acpi_device_physical_node *pn;
 			struct iommu_group *group;
 			struct acpi_device *adev;
+			struct device *pn_dev = NULL;
 
 			if (dev->bus != &acpi_bus_type)
 				continue;
@@ -4868,6 +4884,7 @@ static int __init probe_acpi_namespace_devices(void)
 					    &adev->physical_node_list, node) {
 				group = iommu_group_get(pn->dev);
 				if (group) {
+					pn_dev = pn->dev;
 					iommu_group_put(group);
 					continue;
 				}
@@ -4876,7 +4893,19 @@ static int __init probe_acpi_namespace_devices(void)
 				ret = iommu_probe_device(pn->dev);
 				if (ret)
 					break;
+				pn_dev = pn->dev;
+			}
+			if (!pn_dev) {
+				dev->bus->iommu_ops = &intel_iommu_ops;
+				ret = iommu_probe_device(dev);
+				if (ret) {
+					pr_err("acpi_device probe fail! ret:%d\n", ret);
+					goto unlock;
+				}
+				goto unlock;
 			}
+			ret = acpi_device_create_direct_mappings(pn_dev, dev);
+unlock:
 			mutex_unlock(&adev->physical_node_lock);
 
 			if (ret)
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 6d847027d35e..ffd470297ea6 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -779,6 +779,12 @@ static bool iommu_is_attach_deferred(struct iommu_domain *domain,
 	return false;
 }
 
+void  __acpi_device_create_direct_mappings(struct iommu_group *group, struct device *acpi_device)
+{
+	iommu_create_device_direct_mappings(group, acpi_device);
+}
+EXPORT_SYMBOL_GPL(__acpi_device_create_direct_mappings);
+
 /**
  * iommu_group_add_device - add a device to an iommu group
  * @group: the group into which to add the device (reference should be held)
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 82876f682367..bfc46e538c29 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -516,6 +516,8 @@ extern void iommu_domain_window_disable(struct iommu_domain *domain, u32 wnd_nr)
 
 extern int report_iommu_fault(struct iommu_domain *domain, struct device *dev,
 			      unsigned long iova, int flags);
+extern void __acpi_device_create_direct_mappings(struct iommu_group *group,
+						 struct device *acpi_device);
 
 static inline void iommu_flush_iotlb_all(struct iommu_domain *domain)
 {
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
