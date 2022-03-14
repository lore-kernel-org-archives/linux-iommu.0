Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75EF5C4332F
	for <iommu@archiver.kernel.org>; Mon, 14 Mar 2022 19:49:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2E3A4408BF;
	Mon, 14 Mar 2022 19:49:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NAolI1d_gKDk; Mon, 14 Mar 2022 19:49:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DFF3D40894;
	Mon, 14 Mar 2022 19:49:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B8AE9C001D;
	Mon, 14 Mar 2022 19:49:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 902F0C000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Mar 2022 19:49:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7F80381980
 for <iommu@lists.linux-foundation.org>; Mon, 14 Mar 2022 19:49:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ibm.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0RshJCZXJIsu for <iommu@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 19:49:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D7DD481493
 for <iommu@lists.linux-foundation.org>; Mon, 14 Mar 2022 19:49:32 +0000 (UTC)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22EJlWp6001504; 
 Mon, 14 Mar 2022 19:49:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Ry3NbK8OjW+Q+ShaRu/ojqyHHa3JtAipA1RifCDi87I=;
 b=MxrxK74FzfgJcM9tbwO1rSMSLlPBK+0ly4cL37Se8M2u8PqwxKVffa238+chL7LdAfr0
 31gMx5+27rgbtT2P+pGez9nXQ7fTup1ZSiEyVh/nDkBPHo5LZGQcXjDh4NhyQQ84WDm1
 qVHT448J0QnS1gGemC8HvgsKKq83/LY0YtUIe7oPzzxaCAt4lPBIGyJBhOI5UDP45rqi
 pH175PyykoAiqf6yVKCFGGjHT4y/Q3OgQHTEXHQpU5Jxoa//6dSupXgtseEwR6tXNL5O
 UV9vl6LHGHBiSQ/Sr+AQyt1dqoczj7RdEJX0BpIAn8luaJ/tDV9o65TXWsrye//u8aeh 9Q== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3et6ae14qg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Mar 2022 19:49:28 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22EJlfTD002002;
 Mon, 14 Mar 2022 19:49:28 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3et6ae14q5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Mar 2022 19:49:27 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22EJlA6G009546;
 Mon, 14 Mar 2022 19:49:26 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28]) by ppma01dal.us.ibm.com with ESMTP id 3erk59cc9v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Mar 2022 19:49:26 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 22EJnOfH18874866
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Mar 2022 19:49:24 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AF09011206D;
 Mon, 14 Mar 2022 19:49:24 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 32E8F112067;
 Mon, 14 Mar 2022 19:49:17 +0000 (GMT)
Received: from li-c92d2ccc-254b-11b2-a85c-a700b5bfb098.ibm.com.com (unknown
 [9.211.32.184]) by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Mon, 14 Mar 2022 19:49:16 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: linux-s390@vger.kernel.org
Subject: [PATCH v4 26/32] KVM: s390: pci: handle refresh of PCI translations
Date: Mon, 14 Mar 2022 15:44:45 -0400
Message-Id: <20220314194451.58266-27-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220314194451.58266-1-mjrosato@linux.ibm.com>
References: <20220314194451.58266-1-mjrosato@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9Ec6i66jadZq2zyy5JtpUS9nu1v6bBUL
X-Proofpoint-GUID: 7fweTxisU0AQQWE-kQ_rSZ42Dc-755GY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-14_13,2022-03-14_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 bulkscore=0 adultscore=0 mlxscore=0 malwarescore=0 mlxlogscore=748
 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
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

Add a routine that will perform a shadow operation between a guest
and host IOAT.  A subsequent patch will invoke this in response to
an 04 RPCIT instruction intercept.

Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 arch/s390/include/asm/kvm_pci.h |  1 +
 arch/s390/kvm/pci.c             | 31 ++++++++++++++++++++++++++++++-
 arch/s390/kvm/pci.h             |  3 +++
 3 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/kvm_pci.h b/arch/s390/include/asm/kvm_pci.h
index e27dbede723c..9578b5dafb45 100644
--- a/arch/s390/include/asm/kvm_pci.h
+++ b/arch/s390/include/asm/kvm_pci.h
@@ -25,6 +25,7 @@ struct kvm_zdev {
 	struct zpci_fib fib;
 	struct notifier_block nb;
 	struct list_head entry;
+	u64 rpcit_count;
 };
 
 int kvm_s390_pci_dev_open(struct zpci_dev *zdev);
diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
index 1a8b82220b29..40d2fadbfbd5 100644
--- a/arch/s390/kvm/pci.c
+++ b/arch/s390/kvm/pci.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/kvm_host.h>
+#include <linux/iommu.h>
 #include <linux/pci.h>
 #include <linux/vfio.h>
 #include <asm/kvm_pci.h>
@@ -173,6 +174,30 @@ int kvm_s390_pci_aen_init(u8 nisc)
 	return rc;
 }
 
+int kvm_s390_pci_refresh_trans(struct kvm_vcpu *vcpu, unsigned long req,
+			       unsigned long start, unsigned long size)
+{
+	struct kvm_zdev *kzdev;
+	u32 fh = req >> 32;
+	int rc;
+
+	/* Make sure this is a valid device associated with this guest */
+	kzdev = get_kzdev_by_fh(vcpu->kvm, fh);
+	if (!kzdev)
+		return -EINVAL;
+
+	/*
+	 * The KVM-managed IOMMU map operation will synchronize the associated
+	 * guest IOAT tables with the host DMA tables.  A physical address is
+	 * not specified as it will be derived from pinned guest PTEs
+	 */
+	rc = iommu_map(kzdev->dom, start, 0, size, IOMMU_WRITE | IOMMU_READ);
+
+	kzdev->rpcit_count++;
+
+	return rc;
+}
+
 /* Modify PCI: Register floating adapter interruption forwarding */
 static int kvm_zpci_set_airq(struct zpci_dev *zdev)
 {
@@ -716,6 +741,8 @@ void kvm_s390_pci_clear_list(struct kvm *kvm)
 
 int kvm_s390_pci_init(void)
 {
+	int rc;
+
 	aift = kzalloc(sizeof(struct zpci_aift), GFP_KERNEL);
 	if (!aift)
 		return -ENOMEM;
@@ -723,5 +750,7 @@ int kvm_s390_pci_init(void)
 	spin_lock_init(&aift->gait_lock);
 	mutex_init(&aift->aift_lock);
 
-	return 0;
+	rc = zpci_get_mdd(&aift->mdd);
+
+	return rc;
 }
diff --git a/arch/s390/kvm/pci.h b/arch/s390/kvm/pci.h
index 867f04cae3a1..2cb1b27396c1 100644
--- a/arch/s390/kvm/pci.h
+++ b/arch/s390/kvm/pci.h
@@ -33,6 +33,7 @@ struct zpci_aift {
 	struct kvm_zdev **kzdev;
 	spinlock_t gait_lock; /* Protects the gait, used during AEN forward */
 	struct mutex aift_lock; /* Protects the other structures in aift */
+	u32 mdd;
 };
 
 extern struct zpci_aift *aift;
@@ -48,6 +49,8 @@ static inline struct kvm *kvm_s390_pci_si_to_kvm(struct zpci_aift *aift,
 
 int kvm_s390_pci_aen_init(u8 nisc);
 void kvm_s390_pci_aen_exit(void);
+int kvm_s390_pci_refresh_trans(struct kvm_vcpu *vcpu, unsigned long req,
+			       unsigned long start, unsigned long end);
 
 int kvm_s390_pci_zpci_start(struct kvm *kvm, struct zpci_dev *zdev);
 int kvm_s390_pci_zpci_stop(struct kvm *kvm, struct zpci_dev *zdev);
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
