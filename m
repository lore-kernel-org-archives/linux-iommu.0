Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1023EC433EF
	for <iommu@archiver.kernel.org>; Mon, 14 Mar 2022 19:49:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C6F74405CD;
	Mon, 14 Mar 2022 19:49:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VcEB8giBVEBY; Mon, 14 Mar 2022 19:49:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A336F405B0;
	Mon, 14 Mar 2022 19:49:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 79C08C001D;
	Mon, 14 Mar 2022 19:49:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E568DC000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Mar 2022 19:49:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E02344064B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Mar 2022 19:49:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Q3GTV8nfWWfU for <iommu@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 19:49:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1DC33405B0
 for <iommu@lists.linux-foundation.org>; Mon, 14 Mar 2022 19:49:24 +0000 (UTC)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22EJlYtZ025603; 
 Mon, 14 Mar 2022 19:49:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=jCJb3uoE4AvG/NwZYgfyajpNJCvah+v+Z6bhqln4G4c=;
 b=LIPz+MLLTikUhz4jKyNX34r6G3+PlSLQQYPHtG1+dJIitiQv3IvJJkX/cbWYQyKyJPxw
 seb6zXw8nEqCaKj+t+96fI5SY5XpxCjyzcgZBrHw/wyNkZS5E35OOk/XjEsbYYwCtf1Q
 1VWe9YlQfRw6uGK+rxyNZAuE/IK8t3l0X3r+x7VqbVFUwTMV/uz9ZW2xregdreQ/nsrj
 kh22YNUWj3dFlEyi0r8NhlE39AFLM5rcQDj0jOMJ/NJoa/ooG0iqs54o4hd2Y7FMNMRw
 +wD92e5g2ZMMmXTJccyF6/+eBrPxcWGlhT6Drs806PkJqNaiWqp7O9ML+uDarr36/vHc WA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3et6ag0yf2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Mar 2022 19:49:19 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22EJlklJ026151;
 Mon, 14 Mar 2022 19:49:19 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3et6ag0yej-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Mar 2022 19:49:19 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22EJl8OK028282;
 Mon, 14 Mar 2022 19:49:18 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27]) by ppma04dal.us.ibm.com with ESMTP id 3erk59cc8k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Mar 2022 19:49:18 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 22EJnG5i24445254
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Mar 2022 19:49:16 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 84CA2112062;
 Mon, 14 Mar 2022 19:49:16 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 53A69112067;
 Mon, 14 Mar 2022 19:49:09 +0000 (GMT)
Received: from li-c92d2ccc-254b-11b2-a85c-a700b5bfb098.ibm.com.com (unknown
 [9.211.32.184]) by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Mon, 14 Mar 2022 19:49:09 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: linux-s390@vger.kernel.org
Subject: [PATCH v4 25/32] KVM: s390: pci: provide routines for
 enabling/disabling IOAT assist
Date: Mon, 14 Mar 2022 15:44:44 -0400
Message-Id: <20220314194451.58266-26-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220314194451.58266-1-mjrosato@linux.ibm.com>
References: <20220314194451.58266-1-mjrosato@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SPJUUOUAeJSXFD4EIEAL_MrgG_3QDlfG
X-Proofpoint-GUID: fHXz44E_9nQE3ex7ajBCv_hdg3OJLOGY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-14_13,2022-03-14_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 adultscore=0 phishscore=0 impostorscore=0 mlxscore=0 mlxlogscore=789
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203140116
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

These routines will be wired into a kvm ioctl in orer to respond to
requests to enable / disable a device for PCI I/O Address Translation
assistance via a KVM-managed IOMMU.

Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 arch/s390/include/asm/kvm_pci.h |  2 ++
 arch/s390/kvm/pci.c             | 25 +++++++++++++++++++++++++
 arch/s390/kvm/pci.h             |  2 ++
 3 files changed, 29 insertions(+)

diff --git a/arch/s390/include/asm/kvm_pci.h b/arch/s390/include/asm/kvm_pci.h
index ed596880fb06..e27dbede723c 100644
--- a/arch/s390/include/asm/kvm_pci.h
+++ b/arch/s390/include/asm/kvm_pci.h
@@ -30,6 +30,8 @@ struct kvm_zdev {
 int kvm_s390_pci_dev_open(struct zpci_dev *zdev);
 void kvm_s390_pci_dev_release(struct zpci_dev *zdev);
 
+u8 kvm_s390_pci_get_dtsm(struct zpci_dev *zdev);
+
 int zpci_iommu_attach_kvm(struct zpci_dev *zdev, struct kvm *kvm);
 int zpci_iommu_kvm_assign_iota(struct zpci_dev *zdev, u64 iota);
 int zpci_iommu_kvm_remove_iota(struct zpci_dev *zdev);
diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
index 2287c1c6a3e5..1a8b82220b29 100644
--- a/arch/s390/kvm/pci.c
+++ b/arch/s390/kvm/pci.c
@@ -367,6 +367,28 @@ static int kvm_s390_pci_aif_disable(struct zpci_dev *zdev, bool force)
 	return rc;
 }
 
+static int kvm_s390_pci_ioat_enable(struct zpci_dev *zdev, u64 iota)
+{
+	if (IS_ENABLED(CONFIG_S390_KVM_IOMMU))
+		return zpci_iommu_kvm_assign_iota(zdev, iota);
+	else
+		return -EINVAL;
+}
+
+static int kvm_s390_pci_ioat_disable(struct zpci_dev *zdev)
+{
+	if (IS_ENABLED(CONFIG_S390_KVM_IOMMU))
+		return zpci_iommu_kvm_remove_iota(zdev);
+	else
+		return -EINVAL;
+}
+
+u8 kvm_s390_pci_get_dtsm(struct zpci_dev *zdev)
+{
+	return (zdev->dtsm & KVM_S390_PCI_DTSM_MASK);
+}
+EXPORT_SYMBOL_GPL(kvm_s390_pci_get_dtsm);
+
 static int kvm_s390_pci_interp_enable(struct zpci_dev *zdev)
 {
 	u32 gisa;
@@ -432,6 +454,9 @@ static int kvm_s390_pci_interp_disable(struct zpci_dev *zdev, bool force)
 	if (zdev->kzdev->fib.fmt0.aibv != 0)
 		kvm_s390_pci_aif_disable(zdev, force);
 
+	/* If we are using the IOAT assist, disable it now */
+	kvm_s390_pci_ioat_disable(zdev);
+
 	/* Remove the host CLP guest designation */
 	zdev->gisa = 0;
 
diff --git a/arch/s390/kvm/pci.h b/arch/s390/kvm/pci.h
index a95d9fdc91be..867f04cae3a1 100644
--- a/arch/s390/kvm/pci.h
+++ b/arch/s390/kvm/pci.h
@@ -16,6 +16,8 @@
 #include <asm/airq.h>
 #include <asm/kvm_pci.h>
 
+#define KVM_S390_PCI_DTSM_MASK 0x40
+
 struct zpci_gaite {
 	u32 gisa;
 	u8 gisc;
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
