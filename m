Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AE9EC433EF
	for <iommu@archiver.kernel.org>; Mon, 14 Mar 2022 19:49:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 46F228194C;
	Mon, 14 Mar 2022 19:49:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IMzbTS2fSyUd; Mon, 14 Mar 2022 19:49:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id F0B0A8195C;
	Mon, 14 Mar 2022 19:49:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CBA33C001D;
	Mon, 14 Mar 2022 19:49:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A8EA5C000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Mar 2022 19:48:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8430C405B0
 for <iommu@lists.linux-foundation.org>; Mon, 14 Mar 2022 19:48:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ibm.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E30QVFEn65M7 for <iommu@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 19:48:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4883D4027A
 for <iommu@lists.linux-foundation.org>; Mon, 14 Mar 2022 19:48:58 +0000 (UTC)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22EJlUvf008369; 
 Mon, 14 Mar 2022 19:48:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=fd5fQI4HUmVzn6H5qypbsY6eukCX/bkqPN4nxqPV2TQ=;
 b=QyGHLukqW/OpJ1/Gfk1oodcJBsw6yBMlsOiMkIwT/dvvC9JR9IwUe9bEr/3jrWHitoHw
 VLOxnn8NFbfQv0p6WvlUNQ7C3hPlcw/c5tb67xdqf8O5m87rCCCuThMAXN0a07g1Lkuw
 XlMS9J/DkA0xRxIbmk+dt6Ms8yrsh3oV7fkcFWcNLP0S1Y5DJFEiCvesiO7sVT2VBblD
 Rx4SBWTjAt87g9j0kSKPowGnRo9DWwrh6od3feDVuumyxfk5VEtaY3FirZGIZXMo0L99
 N6GDoWlKBxYOR7MlayGOqx9n1N11C1xY9RR4Foq0OLcEEzGj/qLc4lv07ivpmF5x4XcE gQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3et6cs0q47-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Mar 2022 19:48:53 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22EJloeP009950;
 Mon, 14 Mar 2022 19:48:52 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.27])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3et6cs0q43-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Mar 2022 19:48:52 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
 by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22EJlDfl010241;
 Mon, 14 Mar 2022 19:48:51 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28]) by ppma05wdc.us.ibm.com with ESMTP id 3erk59rah6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Mar 2022 19:48:51 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 22EJmoPX18022730
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Mar 2022 19:48:50 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DEFCA112073;
 Mon, 14 Mar 2022 19:48:49 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D1DF0112062;
 Mon, 14 Mar 2022 19:48:39 +0000 (GMT)
Received: from li-c92d2ccc-254b-11b2-a85c-a700b5bfb098.ibm.com.com (unknown
 [9.211.32.184]) by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Mon, 14 Mar 2022 19:48:39 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: linux-s390@vger.kernel.org
Subject: [PATCH v4 22/32] KVM: s390: pci: routines for (dis)associating zPCI
 devices with a KVM
Date: Mon, 14 Mar 2022 15:44:41 -0400
Message-Id: <20220314194451.58266-23-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220314194451.58266-1-mjrosato@linux.ibm.com>
References: <20220314194451.58266-1-mjrosato@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BvStC7B5dCYRItOiKOYZBS0KWHJUM6cg
X-Proofpoint-ORIG-GUID: SV6XvuXVs85AmjhY90X5FXWuFotfl424
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-14_13,2022-03-14_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=969
 priorityscore=1501 mlxscore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 spamscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2202240000 definitions=main-2203140116
Cc: kvm@vger.kernel.org, david@redhat.com, thuth@redhat.com,
 linux-kernel@vger.kernel.org, vneethv@linux.ibm.com, agordeev@linux.ibm.com,
 imbrenda@linux.ibm.com, will@kernel.org, frankja@linux.ibm.com, corbet@lwn.net,
 linux-doc@vger.kernel.org, pasic@linux.ibm.com, jgg@nvidia.com,
 gerald.schaefer@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 gor@linux.ibm.com, schnelle@linux.ibm.com, hca@linux.ibm.com,
 alex.williamson@redhat.com, freude@linux.ibm.com, pmorel@linux.ibm.com,
 cohuck@redhat.com, oberpar@linux.ibm.com, iommu@lists.linux-foundation.org,
 svens@linux.ibm.com, pbonzini@redhat.com
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

These routines will be wired into a KVM ioctl, to be issued from
userspace to (dis)associate a specific zPCI device with the issuing
KVM.  This will create/delete a relationship between KVM, zPCI device
and the associated IOMMU domain for the device.

Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |   2 +
 arch/s390/include/asm/kvm_pci.h  |   2 +
 arch/s390/kvm/kvm-s390.c         |   5 +
 arch/s390/kvm/pci.c              | 225 +++++++++++++++++++++++++++++++
 arch/s390/kvm/pci.h              |   5 +
 5 files changed, 239 insertions(+)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index bf61ab05f98c..bd171abbb8ef 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -965,6 +965,8 @@ struct kvm_arch{
 	DECLARE_BITMAP(idle_mask, KVM_MAX_VCPUS);
 	struct kvm_s390_gisa_interrupt gisa_int;
 	struct kvm_s390_pv pv;
+	struct list_head kzdev_list;
+	spinlock_t kzdev_list_lock;
 };
 
 #define KVM_HVA_ERR_BAD		(-1UL)
diff --git a/arch/s390/include/asm/kvm_pci.h b/arch/s390/include/asm/kvm_pci.h
index ebc0da5d9ac1..47ce18b5bddd 100644
--- a/arch/s390/include/asm/kvm_pci.h
+++ b/arch/s390/include/asm/kvm_pci.h
@@ -21,6 +21,8 @@ struct kvm_zdev {
 	struct zpci_dev *zdev;
 	struct kvm *kvm;
 	struct iommu_domain *dom; /* Used to invoke IOMMU API for RPCIT */
+	struct notifier_block nb;
+	struct list_head entry;
 };
 
 int kvm_s390_pci_dev_open(struct zpci_dev *zdev);
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index d91b2547f0bf..84acaf59a7d3 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2775,6 +2775,9 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 
 	kvm_s390_crypto_init(kvm);
 
+	if (IS_ENABLED(CONFIG_VFIO_PCI))
+		kvm_s390_pci_init_list(kvm);
+
 	mutex_init(&kvm->arch.float_int.ais_lock);
 	spin_lock_init(&kvm->arch.float_int.lock);
 	for (i = 0; i < FIRQ_LIST_COUNT; i++)
@@ -2860,6 +2863,8 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 	if (!kvm_is_ucontrol(kvm))
 		gmap_remove(kvm->arch.gmap);
 	kvm_s390_destroy_adapters(kvm);
+	if (IS_ENABLED(CONFIG_VFIO_PCI))
+		kvm_s390_pci_clear_list(kvm);
 	kvm_s390_clear_float_irqs(kvm);
 	kvm_s390_vsie_destroy(kvm);
 	KVM_EVENT(3, "vm 0x%pK destroyed", kvm);
diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
index 1c42d25de697..28fe95f13c33 100644
--- a/arch/s390/kvm/pci.c
+++ b/arch/s390/kvm/pci.c
@@ -9,6 +9,7 @@
 
 #include <linux/kvm_host.h>
 #include <linux/pci.h>
+#include <linux/vfio.h>
 #include <asm/kvm_pci.h>
 #include <asm/pci.h>
 #include <asm/pci_insn.h>
@@ -23,6 +24,22 @@ static inline int __set_irq_noiib(u16 ctl, u8 isc)
 	return zpci_set_irq_ctrl(ctl, isc, &iib);
 }
 
+static struct kvm_zdev *get_kzdev_by_fh(struct kvm *kvm, u32 fh)
+{
+	struct kvm_zdev *kzdev, *retval = NULL;
+
+	spin_lock(&kvm->arch.kzdev_list_lock);
+	list_for_each_entry(kzdev, &kvm->arch.kzdev_list, entry) {
+		if (kzdev->zdev->fh == fh) {
+			retval = kzdev;
+			break;
+		}
+	}
+	spin_unlock(&kvm->arch.kzdev_list_lock);
+
+	return retval;
+}
+
 /* Caller must hold the aift lock before calling this function */
 void kvm_s390_pci_aen_exit(void)
 {
@@ -153,6 +170,20 @@ int kvm_s390_pci_aen_init(u8 nisc)
 	return rc;
 }
 
+static int kvm_s390_pci_group_notifier(struct notifier_block *nb,
+				       unsigned long action, void *data)
+{
+	struct kvm_zdev *kzdev = container_of(nb, struct kvm_zdev, nb);
+
+	if (action == VFIO_GROUP_NOTIFY_SET_KVM) {
+		if (!data || !kzdev->zdev)
+			return NOTIFY_DONE;
+		kzdev->kvm = data;
+	}
+
+	return NOTIFY_OK;
+}
+
 int kvm_s390_pci_dev_open(struct zpci_dev *zdev)
 {
 	struct kvm_zdev *kzdev;
@@ -179,6 +210,200 @@ void kvm_s390_pci_dev_release(struct zpci_dev *zdev)
 }
 EXPORT_SYMBOL_GPL(kvm_s390_pci_dev_release);
 
+static struct vfio_device *get_vdev(struct device *dev)
+{
+	struct vfio_device *(*fn)(struct device *dev);
+	struct vfio_device *vdev;
+
+	fn = symbol_get(vfio_device_get_from_dev);
+	if (!fn)
+		return NULL;
+
+	vdev = fn(dev);
+
+	symbol_put(vfio_device_get_from_dev);
+
+	return vdev;
+}
+
+static void put_vdev(struct vfio_device *vdev)
+{
+	void (*fn)(struct vfio_device *vdev);
+
+	fn = symbol_get(vfio_device_put);
+	if (!fn)
+		return;
+
+	fn(vdev);
+
+	symbol_put(vfio_device_put);
+}
+
+static int register_notifier(struct device *dev, struct notifier_block *nb)
+{
+	int (*fn)(struct device *dev, enum vfio_notify_type type,
+		  unsigned long *events, struct notifier_block *nb);
+	unsigned long events = VFIO_GROUP_NOTIFY_SET_KVM;
+	int rc;
+
+	fn = symbol_get(vfio_register_notifier);
+	if (!fn)
+		return -EINVAL;
+
+	rc = fn(dev, VFIO_GROUP_NOTIFY, &events, nb);
+
+	symbol_put(vfio_register_notifier);
+
+	return rc;
+}
+
+static int unregister_notifier(struct device *dev, struct notifier_block *nb)
+{
+	int (*fn)(struct device *dev, enum vfio_notify_type type,
+		  struct notifier_block *nb);
+	int rc;
+
+	fn = symbol_get(vfio_unregister_notifier);
+	if (!fn)
+		return -EINVAL;
+
+	rc = fn(dev, VFIO_GROUP_NOTIFY, nb);
+
+	symbol_put(vfio_unregister_notifier);
+
+	return rc;
+}
+
+int kvm_s390_pci_zpci_start(struct kvm *kvm, struct zpci_dev *zdev)
+{
+	struct vfio_device *vdev;
+	struct pci_dev *pdev;
+	int rc;
+
+	rc = kvm_s390_pci_dev_open(zdev);
+	if (rc)
+		return rc;
+
+	pdev = pci_get_slot(zdev->zbus->bus, zdev->devfn);
+	if (!pdev) {
+		rc = -ENODEV;
+		goto exit_err;
+	}
+
+	vdev = get_vdev(&pdev->dev);
+	if (!vdev) {
+		pci_dev_put(pdev);
+		rc = -ENODEV;
+		goto exit_err;
+	}
+
+	zdev->kzdev->nb.notifier_call = kvm_s390_pci_group_notifier;
+
+	/*
+	 * At this point, a KVM should already be associated with this device,
+	 * so registering the notifier now should immediately trigger the
+	 * event.  We also want to know if the KVM association is later removed
+	 * to ensure proper cleanup happens.
+	 */
+	rc = register_notifier(vdev->dev, &zdev->kzdev->nb);
+
+	put_vdev(vdev);
+	pci_dev_put(pdev);
+
+	/* Make sure the registered KVM matches the KVM issuing the ioctl */
+	if (rc || zdev->kzdev->kvm != kvm) {
+		rc = -ENODEV;
+		goto exit_err;
+	}
+
+	/* Must support KVM-managed IOMMU to proceed */
+	if (IS_ENABLED(CONFIG_S390_KVM_IOMMU))
+		rc = zpci_iommu_attach_kvm(zdev, kvm);
+	else
+		rc = -EINVAL;
+
+	if (rc)
+		goto exit_err;
+
+	spin_lock(&kvm->arch.kzdev_list_lock);
+	list_add_tail(&zdev->kzdev->entry, &kvm->arch.kzdev_list);
+	spin_unlock(&kvm->arch.kzdev_list_lock);
+	return 0;
+
+exit_err:
+	kvm_s390_pci_dev_release(zdev);
+	return rc;
+}
+
+int kvm_s390_pci_zpci_stop(struct kvm *kvm, struct zpci_dev *zdev)
+{
+	struct vfio_device *vdev;
+	struct pci_dev *pdev;
+	int rc = 0;
+
+	if (!zdev || !zdev->kzdev)
+		return -EINVAL;
+
+	pdev = pci_get_slot(zdev->zbus->bus, zdev->devfn);
+	if (!pdev) {
+		rc = -ENODEV;
+		goto exit_err;
+	}
+
+	vdev = get_vdev(&pdev->dev);
+	if (!vdev) {
+		pci_dev_put(pdev);
+		rc = -ENODEV;
+		goto exit_err;
+	}
+
+	spin_lock(&kvm->arch.kzdev_list_lock);
+	list_del(&zdev->kzdev->entry);
+	spin_unlock(&kvm->arch.kzdev_list_lock);
+
+	rc = unregister_notifier(vdev->dev, &zdev->kzdev->nb);
+
+	put_vdev(vdev);
+	pci_dev_put(pdev);
+
+exit_err:
+	kvm_s390_pci_dev_release(zdev);
+	return rc;
+}
+
+void kvm_s390_pci_init_list(struct kvm *kvm)
+{
+	spin_lock_init(&kvm->arch.kzdev_list_lock);
+	INIT_LIST_HEAD(&kvm->arch.kzdev_list);
+}
+
+void kvm_s390_pci_clear_list(struct kvm *kvm)
+{
+	struct kvm_zdev *tmp, *kzdev;
+	struct vfio_device *vdev;
+	struct pci_dev *pdev;
+	LIST_HEAD(remove);
+
+	spin_lock(&kvm->arch.kzdev_list_lock);
+	list_for_each_entry_safe(kzdev, tmp, &kvm->arch.kzdev_list, entry)
+		list_move_tail(&kzdev->entry, &remove);
+	spin_unlock(&kvm->arch.kzdev_list_lock);
+
+	list_for_each_entry_safe(kzdev, tmp, &remove, entry) {
+		pdev = pci_get_slot(kzdev->zdev->zbus->bus, kzdev->zdev->devfn);
+		if (pdev) {
+			vdev = get_vdev(&pdev->dev);
+			if (vdev) {
+				unregister_notifier(vdev->dev,
+						    &kzdev->nb);
+				put_vdev(vdev);
+			}
+			pci_dev_put(pdev);
+		}
+		kvm_s390_pci_dev_release(kzdev->zdev);
+	}
+}
+
 int kvm_s390_pci_init(void)
 {
 	aift = kzalloc(sizeof(struct zpci_aift), GFP_KERNEL);
diff --git a/arch/s390/kvm/pci.h b/arch/s390/kvm/pci.h
index 25cb1c787190..a95d9fdc91be 100644
--- a/arch/s390/kvm/pci.h
+++ b/arch/s390/kvm/pci.h
@@ -47,6 +47,11 @@ static inline struct kvm *kvm_s390_pci_si_to_kvm(struct zpci_aift *aift,
 int kvm_s390_pci_aen_init(u8 nisc);
 void kvm_s390_pci_aen_exit(void);
 
+int kvm_s390_pci_zpci_start(struct kvm *kvm, struct zpci_dev *zdev);
+int kvm_s390_pci_zpci_stop(struct kvm *kvm, struct zpci_dev *zdev);
+void kvm_s390_pci_init_list(struct kvm *kvm);
+void kvm_s390_pci_clear_list(struct kvm *kvm);
+
 int kvm_s390_pci_init(void);
 
 #endif /* __KVM_S390_PCI_H */
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
