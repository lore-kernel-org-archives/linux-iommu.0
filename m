Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D338C433F5
	for <iommu@archiver.kernel.org>; Thu, 19 May 2022 18:29:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A8E94844D8;
	Thu, 19 May 2022 18:29:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bgUgW1KSgnKe; Thu, 19 May 2022 18:29:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8B10A844D6;
	Thu, 19 May 2022 18:29:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5E5ADC0039;
	Thu, 19 May 2022 18:29:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DDA17C002D
 for <iommu@lists.linux-foundation.org>; Thu, 19 May 2022 18:29:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C677E410BB
 for <iommu@lists.linux-foundation.org>; Thu, 19 May 2022 18:29:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ibm.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NEaCUBkdGX_Z for <iommu@lists.linux-foundation.org>;
 Thu, 19 May 2022 18:29:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7BBB3410A7
 for <iommu@lists.linux-foundation.org>; Thu, 19 May 2022 18:29:44 +0000 (UTC)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24JHnMi6011493;
 Thu, 19 May 2022 18:29:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=xrNctW9hVKbrU4W6AMqU2wLjNusMYTB/FYWs1L1y5aQ=;
 b=jcmKmAuWXdoMkK8OykiBQWPVLx8rf31qjOnBo+YuWvZaKZFn6h6zCiW49Ftu+O9sqd0K
 88Z5/Fz+yzzC5rjdgHa86D6KZ5I5ZS6umEM4ojtpRIipIjom6bPSHskQ8vWWA6Y4aOiW
 6TUx7GL5h/G9c0sVX2Vptc40cZLECagSeAXDHFxHUVef5+eL7HxQ1CVqrEh5iEpqi8oS
 QCnOA5Qg1wpMIPEJd1nIBJMykJCFtfeTBbRDYRguEj3rP+L4hpqw/UEF/hvrBGXKyk/t
 XfHVRu7IUXYYnsaBgcMTzhDzXOp0yCroW8Y+A+J0p6YN4NRLxvDg1YMi8wSjLTME1h0+ WA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g5tmkrtff-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 May 2022 18:29:38 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24JHq8FO020578;
 Thu, 19 May 2022 18:29:37 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com
 [169.55.91.170])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g5tmkrtf8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 May 2022 18:29:37 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
 by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24JISpgC008710;
 Thu, 19 May 2022 18:29:37 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com
 (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
 by ppma02wdc.us.ibm.com with ESMTP id 3g242a5k8p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 May 2022 18:29:37 +0000
Received: from b03ledav002.gho.boulder.ibm.com
 (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
 by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 24JITaFW23134634
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 May 2022 18:29:36 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E8FF4136059;
 Thu, 19 May 2022 18:29:35 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A007B136051;
 Thu, 19 May 2022 18:29:34 +0000 (GMT)
Received: from li-c92d2ccc-254b-11b2-a85c-a700b5bfb098.ibm.com.com (unknown
 [9.211.37.97])
 by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu, 19 May 2022 18:29:34 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: jgg@nvidia.com, joro@8bytes.org
Subject: [PATCH] iommu/s390: tolerate repeat attach_dev calls
Date: Thu, 19 May 2022 14:29:29 -0400
Message-Id: <20220519182929.581898-1-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: t1RilyYolHsJLOPLBzO2pxdNqh7SgUYc
X-Proofpoint-ORIG-GUID: gjzwgNJ_9iqSM-ohudG6p3A8_pmMDcsd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-19_05,2022-05-19_03,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0
 impostorscore=0 malwarescore=0 mlxscore=0 bulkscore=0 clxscore=1011
 mlxlogscore=999 suspectscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205190103
Cc: linux-s390@vger.kernel.org, farman@linux.ibm.com, kvm@vger.kernel.org,
 schnelle@linux.ibm.com, cohuck@redhat.com, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, alex.williamson@redhat.com,
 gerald.schaefer@linux.ibm.com, borntraeger@linux.ibm.com, will@kernel.org
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

Since commit 0286300e6045 ("iommu: iommu_group_claim_dma_owner() must
always assign a domain") s390-iommu will get called to allocate multiple
unmanaged iommu domains for a vfio-pci device -- however the current
s390-iommu logic tolerates only one.  Recognize that multiple domains can
be allocated and handle switching between DMA or different iommu domain
tables during attach_dev.

Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 drivers/iommu/s390-iommu.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index 3833e86c6e7b..c898bcbbce11 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -99,7 +99,7 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
 	if (!domain_device)
 		return -ENOMEM;
 
-	if (zdev->dma_table) {
+	if (zdev->dma_table && !zdev->s390_domain) {
 		cc = zpci_dma_exit_device(zdev);
 		if (cc) {
 			rc = -EIO;
@@ -107,6 +107,9 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
 		}
 	}
 
+	if (zdev->s390_domain)
+		zpci_unregister_ioat(zdev, 0);
+
 	zdev->dma_table = s390_domain->dma_table;
 	cc = zpci_register_ioat(zdev, 0, zdev->start_dma, zdev->end_dma,
 				virt_to_phys(zdev->dma_table));
@@ -136,7 +139,13 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
 	return 0;
 
 out_restore:
-	zpci_dma_init_device(zdev);
+	if (!zdev->s390_domain) {
+		zpci_dma_init_device(zdev);
+	} else {
+		zdev->dma_table = zdev->s390_domain->dma_table;
+		zpci_register_ioat(zdev, 0, zdev->start_dma, zdev->end_dma,
+				   virt_to_phys(zdev->dma_table));
+	}
 out_free:
 	kfree(domain_device);
 
@@ -167,7 +176,7 @@ static void s390_iommu_detach_device(struct iommu_domain *domain,
 	}
 	spin_unlock_irqrestore(&s390_domain->list_lock, flags);
 
-	if (found) {
+	if (found && (zdev->s390_domain == s390_domain)) {
 		zdev->s390_domain = NULL;
 		zpci_unregister_ioat(zdev, 0);
 		zpci_dma_init_device(zdev);
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
