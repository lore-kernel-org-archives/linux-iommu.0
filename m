Return-Path: <SRS0=LjD4=JG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5471DC433ED
	for <iommu@archiver.kernel.org>; Fri,  9 Apr 2021 03:44:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 100736113C
	for <iommu@archiver.kernel.org>; Fri,  9 Apr 2021 03:44:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 100736113C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C45E260E55;
	Fri,  9 Apr 2021 03:44:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9kWPClsSQWGa; Fri,  9 Apr 2021 03:44:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 70CCC60E56;
	Fri,  9 Apr 2021 03:44:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0FFFCC0014;
	Fri,  9 Apr 2021 03:44:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D380BC000A
 for <iommu@lists.linux-foundation.org>; Fri,  9 Apr 2021 03:44:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B511860E55
 for <iommu@lists.linux-foundation.org>; Fri,  9 Apr 2021 03:44:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5PS_PNm09Y9u for <iommu@lists.linux-foundation.org>;
 Fri,  9 Apr 2021 03:44:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 78B6960E52
 for <iommu@lists.linux-foundation.org>; Fri,  9 Apr 2021 03:44:53 +0000 (UTC)
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FGkVZ5q3qzlWq4;
 Fri,  9 Apr 2021 11:43:02 +0800 (CST)
Received: from DESKTOP-7FEPK9S.china.huawei.com (10.174.184.135) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Fri, 9 Apr 2021 11:44:45 +0800
From: Shenming Lu <lushenming@huawei.com>
To: Alex Williamson <alex.williamson@redhat.com>, Cornelia Huck
 <cohuck@redhat.com>, Will Deacon <will@kernel.org>, Robin Murphy
 <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Jean-Philippe Brucker
 <jean-philippe@linaro.org>, Eric Auger <eric.auger@redhat.com>,
 <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux-foundation.org>,
 <linux-api@vger.kernel.org>
Subject: [RFC PATCH v3 8/8] vfio: Add nested IOPF support
Date: Fri, 9 Apr 2021 11:44:20 +0800
Message-ID: <20210409034420.1799-9-lushenming@huawei.com>
X-Mailer: git-send-email 2.27.0.windows.1
In-Reply-To: <20210409034420.1799-1-lushenming@huawei.com>
References: <20210409034420.1799-1-lushenming@huawei.com>
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

To set up nested mode, drivers such as vfio_pci need to register a
handler to receive stage/level 1 faults from the IOMMU, but since
currently each device can only have one iommu dev fault handler,
and if stage 2 IOPF is already enabled (VFIO_IOMMU_ENABLE_IOPF),
we choose to update the registered handler (a consolidated one) via
flags (set FAULT_REPORT_NESTED_L1), and further deliver the received
stage 1 faults in the handler to the guest through a newly added
vfio_device_ops callback.

Signed-off-by: Shenming Lu <lushenming@huawei.com>
---
 drivers/vfio/vfio.c             | 81 +++++++++++++++++++++++++++++++++
 drivers/vfio/vfio_iommu_type1.c | 49 +++++++++++++++++++-
 include/linux/vfio.h            | 12 +++++
 3 files changed, 141 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
index 44c8dfabf7de..4245f15914bf 100644
--- a/drivers/vfio/vfio.c
+++ b/drivers/vfio/vfio.c
@@ -2356,6 +2356,87 @@ struct iommu_domain *vfio_group_iommu_domain(struct vfio_group *group)
 }
 EXPORT_SYMBOL_GPL(vfio_group_iommu_domain);
 
+/*
+ * Register/Update the VFIO IOPF handler to receive
+ * nested stage/level 1 faults.
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
+	if (likely(driver && driver->ops->register_handler))
+		ret = driver->ops->register_handler(container->iommu_data, dev);
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
+	if (likely(driver && driver->ops->unregister_handler))
+		ret = driver->ops->unregister_handler(container->iommu_data, dev);
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
+int vfio_transfer_iommu_fault(struct device *dev, struct iommu_fault *fault)
+{
+	struct vfio_device *device = dev_get_drvdata(dev);
+
+	if (unlikely(!device->ops->transfer))
+		return -EOPNOTSUPP;
+
+	return device->ops->transfer(device->device_data, fault);
+}
+EXPORT_SYMBOL_GPL(vfio_transfer_iommu_fault);
+
 /**
  * Module/class support
  */
diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index ba2b5a1cf6e9..9d1adeddb303 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -3821,13 +3821,32 @@ static int vfio_iommu_type1_dma_map_iopf(struct iommu_fault *fault, void *data)
 	struct vfio_batch batch;
 	struct vfio_range *range;
 	dma_addr_t iova = ALIGN_DOWN(fault->prm.addr, PAGE_SIZE);
-	int access_flags = 0;
+	int access_flags = 0, nested;
 	size_t premap_len, map_len, mapped_len = 0;
 	unsigned long bit_offset, vaddr, pfn, i, npages;
 	int ret;
 	enum iommu_page_response_code status = IOMMU_PAGE_RESP_INVALID;
 	struct iommu_page_response resp = {0};
 
+	if (vfio_dev_domian_nested(dev, &nested))
+		return -ENODEV;
+
+	/*
+	 * When configured in nested mode, further deliver the
+	 * stage/level 1 faults to the guest.
+	 */
+	if (nested) {
+		bool l2;
+
+		if (fault->type == IOMMU_FAULT_PAGE_REQ)
+			l2 = fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_L2;
+		if (fault->type == IOMMU_FAULT_DMA_UNRECOV)
+			l2 = fault->event.flags & IOMMU_FAULT_UNRECOV_L2;
+
+		if (!l2)
+			return vfio_transfer_iommu_fault(dev, fault);
+	}
+
 	if (fault->type != IOMMU_FAULT_PAGE_REQ)
 		return -EOPNOTSUPP;
 
@@ -4201,6 +4220,32 @@ static void vfio_iommu_type1_notify(void *iommu_data,
 	wake_up_all(&iommu->vaddr_wait);
 }
 
+static int vfio_iommu_type1_register_handler(void *iommu_data,
+					     struct device *dev)
+{
+	struct vfio_iommu *iommu = iommu_data;
+
+	if (iommu->iopf_enabled)
+		return iommu_update_device_fault_handler(dev, ~0,
+						FAULT_REPORT_NESTED_L1);
+	else
+		return iommu_register_device_fault_handler(dev,
+						vfio_iommu_type1_dma_map_iopf,
+						FAULT_REPORT_NESTED_L1, dev);
+}
+
+static int vfio_iommu_type1_unregister_handler(void *iommu_data,
+					       struct device *dev)
+{
+	struct vfio_iommu *iommu = iommu_data;
+
+	if (iommu->iopf_enabled)
+		return iommu_update_device_fault_handler(dev,
+						~FAULT_REPORT_NESTED_L1, 0);
+	else
+		return iommu_unregister_device_fault_handler(dev);
+}
+
 static const struct vfio_iommu_driver_ops vfio_iommu_driver_ops_type1 = {
 	.name			= "vfio-iommu-type1",
 	.owner			= THIS_MODULE,
@@ -4216,6 +4261,8 @@ static const struct vfio_iommu_driver_ops vfio_iommu_driver_ops_type1 = {
 	.dma_rw			= vfio_iommu_type1_dma_rw,
 	.group_iommu_domain	= vfio_iommu_type1_group_iommu_domain,
 	.notify			= vfio_iommu_type1_notify,
+	.register_handler	= vfio_iommu_type1_register_handler,
+	.unregister_handler	= vfio_iommu_type1_unregister_handler,
 };
 
 static int __init vfio_iommu_type1_init(void)
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index a7b426d579df..4621d8f0395d 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -29,6 +29,8 @@
  * @match: Optional device name match callback (return: 0 for no-match, >0 for
  *         match, -errno for abort (ex. match with insufficient or incorrect
  *         additional args)
+ * @transfer: Optional. Transfer the received stage/level 1 faults to the guest
+ *            for nested mode.
  */
 struct vfio_device_ops {
 	char	*name;
@@ -43,6 +45,7 @@ struct vfio_device_ops {
 	int	(*mmap)(void *device_data, struct vm_area_struct *vma);
 	void	(*request)(void *device_data, unsigned int count);
 	int	(*match)(void *device_data, char *buf);
+	int	(*transfer)(void *device_data, struct iommu_fault *fault);
 };
 
 extern struct iommu_group *vfio_iommu_group_get(struct device *dev);
@@ -100,6 +103,10 @@ struct vfio_iommu_driver_ops {
 						   struct iommu_group *group);
 	void		(*notify)(void *iommu_data,
 				  enum vfio_iommu_notify_type event);
+	int		(*register_handler)(void *iommu_data,
+					    struct device *dev);
+	int		(*unregister_handler)(void *iommu_data,
+					      struct device *dev);
 };
 
 extern int vfio_register_iommu_driver(const struct vfio_iommu_driver_ops *ops);
@@ -161,6 +168,11 @@ extern int vfio_unregister_notifier(struct device *dev,
 struct kvm;
 extern void vfio_group_set_kvm(struct vfio_group *group, struct kvm *kvm);
 
+extern int vfio_iommu_dev_fault_handler_register_nested(struct device *dev);
+extern int vfio_iommu_dev_fault_handler_unregister_nested(struct device *dev);
+extern int vfio_transfer_iommu_fault(struct device *dev,
+				     struct iommu_fault *fault);
+
 /*
  * Sub-module helpers
  */
-- 
2.19.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
