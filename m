Return-Path: <SRS0=6QSB=IH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A088C433E0
	for <iommu@archiver.kernel.org>; Tue,  9 Mar 2021 06:22:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFFEF6519D
	for <iommu@archiver.kernel.org>; Tue,  9 Mar 2021 06:22:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFFEF6519D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AEDF76F5BD;
	Tue,  9 Mar 2021 06:22:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UtCAbl-zUKCH; Tue,  9 Mar 2021 06:22:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 868FD6F5D7;
	Tue,  9 Mar 2021 06:22:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6428BC000A;
	Tue,  9 Mar 2021 06:22:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 46775C0001
 for <iommu@lists.linux-foundation.org>; Tue,  9 Mar 2021 06:22:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 286C940178
 for <iommu@lists.linux-foundation.org>; Tue,  9 Mar 2021 06:22:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tYPfgPkTGC4M for <iommu@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 06:22:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E9B514016D
 for <iommu@lists.linux-foundation.org>; Tue,  9 Mar 2021 06:22:35 +0000 (UTC)
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DvlSv01FRz17Hqs;
 Tue,  9 Mar 2021 14:20:47 +0800 (CST)
Received: from DESKTOP-7FEPK9S.china.huawei.com (10.174.184.135) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Tue, 9 Mar 2021 14:22:24 +0800
From: Shenming Lu <lushenming@huawei.com>
To: Alex Williamson <alex.williamson@redhat.com>, Cornelia Huck
 <cohuck@redhat.com>, Will Deacon <will@kernel.org>, Robin Murphy
 <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Jean-Philippe Brucker
 <jean-philippe@linaro.org>, Eric Auger <eric.auger@redhat.com>,
 <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux-foundation.org>,
 <linux-api@vger.kernel.org>
Subject: [RFC PATCH v2 6/6] vfio: Add nested IOPF support
Date: Tue, 9 Mar 2021 14:22:07 +0800
Message-ID: <20210309062207.505-7-lushenming@huawei.com>
X-Mailer: git-send-email 2.27.0.windows.1
In-Reply-To: <20210309062207.505-1-lushenming@huawei.com>
References: <20210309062207.505-1-lushenming@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.174.184.135]
X-CFilter-Loop: Reflected
Cc: Kevin Tian <kevin.tian@intel.com>, Christoph Hellwig <hch@infradead.org>,
 lushenming@huawei.com, wanghaibin.wang@huawei.com
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

To set up nested mode, drivers such as vfio_pci have to register
a handler to receive stage/level 1 faults from the IOMMU, but
since currently each device can only have one iommu dev fault
handler, and if stage 2 IOPF is already enabled (VFIO_IOMMU_ENABLE_IOPF),
we choose to update the registered handler (a combined one) via
flags (set IOPF_REPORT_NESTED_L1_CONCERNED), and further deliver
the received stage 1 faults in the handler to the guest through
a newly added vfio_device_ops callback.

Signed-off-by: Shenming Lu <lushenming@huawei.com>
---
 drivers/vfio/vfio.c             | 83 +++++++++++++++++++++++++++++++++
 drivers/vfio/vfio_iommu_type1.c | 37 +++++++++++++++
 include/linux/vfio.h            |  9 ++++
 3 files changed, 129 insertions(+)

diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
index 77b29bbd3027..c6a01d947d0d 100644
--- a/drivers/vfio/vfio.c
+++ b/drivers/vfio/vfio.c
@@ -2389,6 +2389,89 @@ int vfio_iommu_dev_fault_handler(struct iommu_fault *fault, void *data)
 }
 EXPORT_SYMBOL_GPL(vfio_iommu_dev_fault_handler);
 
+int vfio_iommu_dev_fault_handler_unregister_nested(struct device *dev)
+{
+	struct vfio_container *container;
+	struct vfio_group *group;
+	struct vfio_iommu_driver *driver;
+	int ret;
+
+	if (!dev)
+		return -EINVAL;
+
+	group = vfio_group_get_from_dev(dev);
+	if (!group)
+		return -ENODEV;
+
+	ret = vfio_group_add_container_user(group);
+	if (ret)
+		goto out;
+
+	container = group->container;
+	driver = container->iommu_driver;
+	if (likely(driver && driver->ops->unregister_hdlr_nested))
+		ret = driver->ops->unregister_hdlr_nested(container->iommu_data,
+							  dev);
+	else
+		ret = -ENOTTY;
+
+	vfio_group_try_dissolve_container(group);
+
+out:
+	vfio_group_put(group);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(vfio_iommu_dev_fault_handler_unregister_nested);
+
+/*
+ * Register/Update the VFIO page fault handler
+ * to receive nested stage/level 1 faults.
+ */
+int vfio_iommu_dev_fault_handler_register_nested(struct device *dev)
+{
+	struct vfio_container *container;
+	struct vfio_group *group;
+	struct vfio_iommu_driver *driver;
+	int ret;
+
+	if (!dev)
+		return -EINVAL;
+
+	group = vfio_group_get_from_dev(dev);
+	if (!group)
+		return -ENODEV;
+
+	ret = vfio_group_add_container_user(group);
+	if (ret)
+		goto out;
+
+	container = group->container;
+	driver = container->iommu_driver;
+	if (likely(driver && driver->ops->register_hdlr_nested))
+		ret = driver->ops->register_hdlr_nested(container->iommu_data,
+							dev);
+	else
+		ret = -ENOTTY;
+
+	vfio_group_try_dissolve_container(group);
+
+out:
+	vfio_group_put(group);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(vfio_iommu_dev_fault_handler_register_nested);
+
+int vfio_transfer_dev_fault(struct device *dev, struct iommu_fault *fault)
+{
+	struct vfio_device *device = dev_get_drvdata(dev);
+
+	if (unlikely(!device->ops->transfer))
+		return -EOPNOTSUPP;
+
+	return device->ops->transfer(device->device_data, fault);
+}
+EXPORT_SYMBOL_GPL(vfio_transfer_dev_fault);
+
 /**
  * Module/class support
  */
diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 8d14ced649a6..62ad4a47de4a 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -3581,6 +3581,13 @@ static int vfio_iommu_type1_dma_map_iopf(void *iommu_data,
 	enum iommu_page_response_code status = IOMMU_PAGE_RESP_INVALID;
 	struct iommu_page_response resp = {0};
 
+	/*
+	 * When configured in nested mode, further deliver
+	 * stage/level 1 faults to the guest.
+	 */
+	if (iommu->nesting && !(fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_L2))
+		return vfio_transfer_dev_fault(dev, fault);
+
 	mutex_lock(&iommu->lock);
 
 	dma = vfio_find_dma(iommu, iova, PAGE_SIZE);
@@ -3654,6 +3661,34 @@ static int vfio_iommu_type1_dma_map_iopf(void *iommu_data,
 	return 0;
 }
 
+static int vfio_iommu_type1_register_hdlr_nested(void *iommu_data,
+						 struct device *dev)
+{
+	struct vfio_iommu *iommu = iommu_data;
+
+	if (iommu->iopf_enabled)
+		return iommu_update_device_fault_handler(dev, ~0,
+					IOPF_REPORT_NESTED_L1_CONCERNED);
+	else
+		return iommu_register_device_fault_handler(dev,
+					vfio_iommu_dev_fault_handler,
+					IOPF_REPORT_NESTED |
+					IOPF_REPORT_NESTED_L1_CONCERNED,
+					dev);
+}
+
+static int vfio_iommu_type1_unregister_hdlr_nested(void *iommu_data,
+						   struct device *dev)
+{
+	struct vfio_iommu *iommu = iommu_data;
+
+	if (iommu->iopf_enabled)
+		return iommu_update_device_fault_handler(dev,
+					~IOPF_REPORT_NESTED_L1_CONCERNED, 0);
+	else
+		return iommu_unregister_device_fault_handler(dev);
+}
+
 static const struct vfio_iommu_driver_ops vfio_iommu_driver_ops_type1 = {
 	.name			= "vfio-iommu-type1",
 	.owner			= THIS_MODULE,
@@ -3670,6 +3705,8 @@ static const struct vfio_iommu_driver_ops vfio_iommu_driver_ops_type1 = {
 	.group_iommu_domain	= vfio_iommu_type1_group_iommu_domain,
 	.notify			= vfio_iommu_type1_notify,
 	.dma_map_iopf		= vfio_iommu_type1_dma_map_iopf,
+	.register_hdlr_nested	= vfio_iommu_type1_register_hdlr_nested,
+	.unregister_hdlr_nested	= vfio_iommu_type1_unregister_hdlr_nested,
 };
 
 static int __init vfio_iommu_type1_init(void)
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index 73af317a4343..60e935e4851b 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -29,6 +29,7 @@
  * @match: Optional device name match callback (return: 0 for no-match, >0 for
  *         match, -errno for abort (ex. match with insufficient or incorrect
  *         additional args)
+ * @transfer: Optional. Transfer the received faults to the guest for nested mode.
  */
 struct vfio_device_ops {
 	char	*name;
@@ -43,6 +44,7 @@ struct vfio_device_ops {
 	int	(*mmap)(void *device_data, struct vm_area_struct *vma);
 	void	(*request)(void *device_data, unsigned int count);
 	int	(*match)(void *device_data, char *buf);
+	int	(*transfer)(void *device_data, struct iommu_fault *fault);
 };
 
 extern struct iommu_group *vfio_iommu_group_get(struct device *dev);
@@ -102,6 +104,10 @@ struct vfio_iommu_driver_ops {
 	int		(*dma_map_iopf)(void *iommu_data,
 					struct iommu_fault *fault,
 					struct device *dev);
+	int		(*register_hdlr_nested)(void *iommu_data,
+						struct device *dev);
+	int		(*unregister_hdlr_nested)(void *iommu_data,
+						  struct device *dev);
 };
 
 extern int vfio_register_iommu_driver(const struct vfio_iommu_driver_ops *ops);
@@ -164,6 +170,9 @@ struct kvm;
 extern void vfio_group_set_kvm(struct vfio_group *group, struct kvm *kvm);
 
 extern int vfio_iommu_dev_fault_handler(struct iommu_fault *fault, void *data);
+extern int vfio_iommu_dev_fault_handler_unregister_nested(struct device *dev);
+extern int vfio_iommu_dev_fault_handler_register_nested(struct device *dev);
+extern int vfio_transfer_dev_fault(struct device *dev, struct iommu_fault *fault);
 
 /*
  * Sub-module helpers
-- 
2.19.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
