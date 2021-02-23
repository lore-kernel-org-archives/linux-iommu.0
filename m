Return-Path: <SRS0=j2S/=HZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0779C433E6
	for <iommu@archiver.kernel.org>; Tue, 23 Feb 2021 21:08:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4447464E85
	for <iommu@archiver.kernel.org>; Tue, 23 Feb 2021 21:08:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4447464E85
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 06C798249B;
	Tue, 23 Feb 2021 21:08:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C5_C29qtbwjb; Tue, 23 Feb 2021 21:08:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9690C8248C;
	Tue, 23 Feb 2021 21:08:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8271EC000A;
	Tue, 23 Feb 2021 21:08:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B84B2C0001
 for <iommu@lists.linux-foundation.org>; Tue, 23 Feb 2021 21:08:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A69196061C
 for <iommu@lists.linux-foundation.org>; Tue, 23 Feb 2021 21:08:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G49iJ0SPGDV4 for <iommu@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 21:08:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A549C60656
 for <iommu@lists.linux-foundation.org>; Tue, 23 Feb 2021 21:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614114495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DDvyG5TVr/zkrVHXr19OIy1qfeCOwHBTVauPIQEiDDQ=;
 b=AprQsszDyiYdps/4mN1+SXpqq2aVZXik+IttIhfzzXdkxF0M18IGrGF+y/KMW7egFgQ3e/
 n2kpDFB0OOErpHh63Sps/622hOvtLzD6QZWerPOEAlPxrByx5wbrZudb9wX0v+/hggKIB1
 KZKTiU8rn/u8E3jYgtNSpIiFzzr7Kpw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-EEga1GFGMC61V9-JqZTDWA-1; Tue, 23 Feb 2021 16:07:38 -0500
X-MC-Unique: EEga1GFGMC61V9-JqZTDWA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EAD1CCC624;
 Tue, 23 Feb 2021 21:07:34 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-114-34.ams2.redhat.com [10.36.114.34])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 84EBD5D9D0;
 Tue, 23 Feb 2021 21:07:26 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, will@kernel.org,
 maz@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
 alex.williamson@redhat.com, tn@semihalf.com, zhukeqian1@huawei.com
Subject: [PATCH v12 08/13] vfio/pci: Add framework for custom interrupt indices
Date: Tue, 23 Feb 2021 22:06:20 +0100
Message-Id: <20210223210625.604517-9-eric.auger@redhat.com>
In-Reply-To: <20210223210625.604517-1-eric.auger@redhat.com>
References: <20210223210625.604517-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: jean-philippe@linaro.org, wangxingang5@huawei.com, lushenming@huawei.com,
 jiangkunkun@huawei.com, vivek.gautam@arm.com, vsethi@nvidia.com,
 zhangfei.gao@linaro.org
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

Implement IRQ capability chain infrastructure. All interrupt
indexes beyond VFIO_PCI_NUM_IRQS are handled as extended
interrupts. They are registered with a specific type/subtype
and supported flags.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v11 -> v12:
- check !vdev->num_ext_irqs in vfio_pci_set_ext_irq_trigger()
  [Shameer, Qubingbing]
---
 drivers/vfio/pci/vfio_pci.c         | 99 +++++++++++++++++++++++------
 drivers/vfio/pci/vfio_pci_intrs.c   | 62 ++++++++++++++++++
 drivers/vfio/pci/vfio_pci_private.h | 14 ++++
 3 files changed, 157 insertions(+), 18 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index a528b72b57d2..e6b94bad77da 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -610,6 +610,14 @@ static void vfio_pci_disable(struct vfio_pci_device *vdev)
 	ret = iommu_unregister_device_fault_handler(&vdev->pdev->dev);
 	WARN_ON(ret == -EBUSY);
 
+	for (i = 0; i < vdev->num_ext_irqs; i++)
+		vfio_pci_set_irqs_ioctl(vdev, VFIO_IRQ_SET_DATA_NONE |
+					VFIO_IRQ_SET_ACTION_TRIGGER,
+					VFIO_PCI_NUM_IRQS + i, 0, 0, NULL);
+	vdev->num_ext_irqs = 0;
+	kfree(vdev->ext_irqs);
+	vdev->ext_irqs = NULL;
+
 	/* Device closed, don't need mutex here */
 	list_for_each_entry_safe(ioeventfd, ioeventfd_tmp,
 				 &vdev->ioeventfds_list, next) {
@@ -825,6 +833,9 @@ static int vfio_pci_get_irq_count(struct vfio_pci_device *vdev, int irq_type)
 			return 1;
 	} else if (irq_type == VFIO_PCI_REQ_IRQ_INDEX) {
 		return 1;
+	} else if (irq_type >= VFIO_PCI_NUM_IRQS &&
+		   irq_type < VFIO_PCI_NUM_IRQS + vdev->num_ext_irqs) {
+		return 1;
 	}
 
 	return 0;
@@ -1010,7 +1021,7 @@ static long vfio_pci_ioctl(void *device_data,
 			info.flags |= VFIO_DEVICE_FLAGS_RESET;
 
 		info.num_regions = VFIO_PCI_NUM_REGIONS + vdev->num_regions;
-		info.num_irqs = VFIO_PCI_NUM_IRQS;
+		info.num_irqs = VFIO_PCI_NUM_IRQS + vdev->num_ext_irqs;
 
 		if (IS_ENABLED(CONFIG_VFIO_PCI_ZDEV)) {
 			int ret = vfio_pci_info_zdev_add_caps(vdev, &caps);
@@ -1189,36 +1200,87 @@ static long vfio_pci_ioctl(void *device_data,
 
 	} else if (cmd == VFIO_DEVICE_GET_IRQ_INFO) {
 		struct vfio_irq_info info;
+		struct vfio_info_cap caps = { .buf = NULL, .size = 0 };
+		unsigned long capsz;
 
 		minsz = offsetofend(struct vfio_irq_info, count);
 
+		/* For backward compatibility, cannot require this */
+		capsz = offsetofend(struct vfio_irq_info, cap_offset);
+
 		if (copy_from_user(&info, (void __user *)arg, minsz))
 			return -EFAULT;
 
-		if (info.argsz < minsz || info.index >= VFIO_PCI_NUM_IRQS)
+		if (info.argsz < minsz ||
+			info.index >= VFIO_PCI_NUM_IRQS + vdev->num_ext_irqs)
 			return -EINVAL;
 
-		switch (info.index) {
-		case VFIO_PCI_INTX_IRQ_INDEX ... VFIO_PCI_MSIX_IRQ_INDEX:
-		case VFIO_PCI_REQ_IRQ_INDEX:
-			break;
-		case VFIO_PCI_ERR_IRQ_INDEX:
-			if (pci_is_pcie(vdev->pdev))
-				break;
-			fallthrough;
-		default:
-			return -EINVAL;
-		}
+		if (info.argsz >= capsz)
+			minsz = capsz;
 
 		info.flags = VFIO_IRQ_INFO_EVENTFD;
 
-		info.count = vfio_pci_get_irq_count(vdev, info.index);
-
-		if (info.index == VFIO_PCI_INTX_IRQ_INDEX)
+		switch (info.index) {
+		case VFIO_PCI_INTX_IRQ_INDEX:
 			info.flags |= (VFIO_IRQ_INFO_MASKABLE |
 				       VFIO_IRQ_INFO_AUTOMASKED);
-		else
+			break;
+		case VFIO_PCI_MSI_IRQ_INDEX ... VFIO_PCI_MSIX_IRQ_INDEX:
+		case VFIO_PCI_REQ_IRQ_INDEX:
 			info.flags |= VFIO_IRQ_INFO_NORESIZE;
+			break;
+		case VFIO_PCI_ERR_IRQ_INDEX:
+			info.flags |= VFIO_IRQ_INFO_NORESIZE;
+			if (!pci_is_pcie(vdev->pdev))
+				return -EINVAL;
+			break;
+		default:
+		{
+			struct vfio_irq_info_cap_type cap_type = {
+				.header.id = VFIO_IRQ_INFO_CAP_TYPE,
+				.header.version = 1 };
+			int ret, i;
+
+			if (info.index >= VFIO_PCI_NUM_IRQS +
+						vdev->num_ext_irqs)
+				return -EINVAL;
+			info.index = array_index_nospec(info.index,
+							VFIO_PCI_NUM_IRQS +
+							vdev->num_ext_irqs);
+			i = info.index - VFIO_PCI_NUM_IRQS;
+
+			info.flags = vdev->ext_irqs[i].flags;
+			cap_type.type = vdev->ext_irqs[i].type;
+			cap_type.subtype = vdev->ext_irqs[i].subtype;
+
+			ret = vfio_info_add_capability(&caps,
+					&cap_type.header,
+					sizeof(cap_type));
+			if (ret)
+				return ret;
+		}
+		}
+
+		info.count = vfio_pci_get_irq_count(vdev, info.index);
+
+		if (caps.size) {
+			info.flags |= VFIO_IRQ_INFO_FLAG_CAPS;
+			if (info.argsz < sizeof(info) + caps.size) {
+				info.argsz = sizeof(info) + caps.size;
+				info.cap_offset = 0;
+			} else {
+				vfio_info_cap_shift(&caps, sizeof(info));
+				if (copy_to_user((void __user *)arg +
+						  sizeof(info), caps.buf,
+						  caps.size)) {
+					kfree(caps.buf);
+					return -EFAULT;
+				}
+				info.cap_offset = sizeof(info);
+			}
+
+			kfree(caps.buf);
+		}
 
 		return copy_to_user((void __user *)arg, &info, minsz) ?
 			-EFAULT : 0;
@@ -1237,7 +1299,8 @@ static long vfio_pci_ioctl(void *device_data,
 		max = vfio_pci_get_irq_count(vdev, hdr.index);
 
 		ret = vfio_set_irqs_validate_and_prepare(&hdr, max,
-						 VFIO_PCI_NUM_IRQS, &data_size);
+				VFIO_PCI_NUM_IRQS + vdev->num_ext_irqs,
+				&data_size);
 		if (ret)
 			return ret;
 
diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
index 869dce5f134d..d67995fe872f 100644
--- a/drivers/vfio/pci/vfio_pci_intrs.c
+++ b/drivers/vfio/pci/vfio_pci_intrs.c
@@ -19,6 +19,7 @@
 #include <linux/vfio.h>
 #include <linux/wait.h>
 #include <linux/slab.h>
+#include <linux/nospec.h>
 
 #include "vfio_pci_private.h"
 
@@ -635,6 +636,24 @@ static int vfio_pci_set_req_trigger(struct vfio_pci_device *vdev,
 					       count, flags, data);
 }
 
+static int vfio_pci_set_ext_irq_trigger(struct vfio_pci_device *vdev,
+					unsigned int index, unsigned int start,
+					unsigned int count, uint32_t flags,
+					void *data)
+{
+	int i;
+
+	if (start != 0 || count > 1 || !vdev->num_ext_irqs)
+		return -EINVAL;
+
+	index = array_index_nospec(index,
+				   VFIO_PCI_NUM_IRQS + vdev->num_ext_irqs);
+	i = index - VFIO_PCI_NUM_IRQS;
+
+	return vfio_pci_set_ctx_trigger_single(&vdev->ext_irqs[i].trigger,
+					       count, flags, data);
+}
+
 int vfio_pci_set_irqs_ioctl(struct vfio_pci_device *vdev, uint32_t flags,
 			    unsigned index, unsigned start, unsigned count,
 			    void *data)
@@ -684,6 +703,13 @@ int vfio_pci_set_irqs_ioctl(struct vfio_pci_device *vdev, uint32_t flags,
 			break;
 		}
 		break;
+	default:
+		switch (flags & VFIO_IRQ_SET_ACTION_TYPE_MASK) {
+		case VFIO_IRQ_SET_ACTION_TRIGGER:
+			func = vfio_pci_set_ext_irq_trigger;
+			break;
+		}
+		break;
 	}
 
 	if (!func)
@@ -691,3 +717,39 @@ int vfio_pci_set_irqs_ioctl(struct vfio_pci_device *vdev, uint32_t flags,
 
 	return func(vdev, index, start, count, flags, data);
 }
+
+int vfio_pci_get_ext_irq_index(struct vfio_pci_device *vdev,
+			       unsigned int type, unsigned int subtype)
+{
+	int i;
+
+	for (i = 0; i <  vdev->num_ext_irqs; i++) {
+		if (vdev->ext_irqs[i].type == type &&
+		    vdev->ext_irqs[i].subtype == subtype) {
+			return i;
+		}
+	}
+	return -EINVAL;
+}
+
+int vfio_pci_register_irq(struct vfio_pci_device *vdev,
+			  unsigned int type, unsigned int subtype,
+			  u32 flags)
+{
+	struct vfio_ext_irq *ext_irqs;
+
+	ext_irqs = krealloc(vdev->ext_irqs,
+			    (vdev->num_ext_irqs + 1) * sizeof(*ext_irqs),
+			    GFP_KERNEL);
+	if (!ext_irqs)
+		return -ENOMEM;
+
+	vdev->ext_irqs = ext_irqs;
+
+	vdev->ext_irqs[vdev->num_ext_irqs].type = type;
+	vdev->ext_irqs[vdev->num_ext_irqs].subtype = subtype;
+	vdev->ext_irqs[vdev->num_ext_irqs].flags = flags;
+	vdev->ext_irqs[vdev->num_ext_irqs].trigger = NULL;
+	vdev->num_ext_irqs++;
+	return 0;
+}
diff --git a/drivers/vfio/pci/vfio_pci_private.h b/drivers/vfio/pci/vfio_pci_private.h
index 1d9b0f648133..e180b5435c8f 100644
--- a/drivers/vfio/pci/vfio_pci_private.h
+++ b/drivers/vfio/pci/vfio_pci_private.h
@@ -77,6 +77,13 @@ struct vfio_pci_region {
 	u32				flags;
 };
 
+struct vfio_ext_irq {
+	u32				type;
+	u32				subtype;
+	u32				flags;
+	struct eventfd_ctx		*trigger;
+};
+
 struct vfio_pci_dummy_resource {
 	struct resource		resource;
 	int			index;
@@ -111,6 +118,8 @@ struct vfio_pci_device {
 	struct vfio_pci_irq_ctx	*ctx;
 	int			num_ctx;
 	int			irq_type;
+	struct vfio_ext_irq	*ext_irqs;
+	int			num_ext_irqs;
 	int			num_regions;
 	struct vfio_pci_region	*region;
 	u8			msi_qmax;
@@ -154,6 +163,11 @@ struct vfio_pci_device {
 
 extern void vfio_pci_intx_mask(struct vfio_pci_device *vdev);
 extern void vfio_pci_intx_unmask(struct vfio_pci_device *vdev);
+extern int vfio_pci_register_irq(struct vfio_pci_device *vdev,
+				 unsigned int type, unsigned int subtype,
+				 u32 flags);
+extern int vfio_pci_get_ext_irq_index(struct vfio_pci_device *vdev,
+				      unsigned int type, unsigned int subtype);
 
 extern int vfio_pci_set_irqs_ioctl(struct vfio_pci_device *vdev,
 				   uint32_t flags, unsigned index,
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
