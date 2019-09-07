Return-Path: <SRS0=yK3q=XC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9747C43331
	for <iommu@archiver.kernel.org>; Sat,  7 Sep 2019 05:54:38 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE11721670
	for <iommu@archiver.kernel.org>; Sat,  7 Sep 2019 05:54:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE11721670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id F1D2CEB8;
	Sat,  7 Sep 2019 05:54:20 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id AFA522961
	for <iommu@lists.linux-foundation.org>;
	Sat,  7 Sep 2019 00:14:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
	[148.163.156.1])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 378B8756
	for <iommu@lists.linux-foundation.org>;
	Sat,  7 Sep 2019 00:14:11 +0000 (UTC)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x8707Ngh113588; Fri, 6 Sep 2019 20:13:58 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2uuwu0evgm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NOT); Fri, 06 Sep 2019 20:13:58 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x8707aUl115701;
	Fri, 6 Sep 2019 20:13:57 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
	[169.62.189.10])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2uuwu0evg9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NOT); Fri, 06 Sep 2019 20:13:57 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
	by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id
	x8709N3j004282; Sat, 7 Sep 2019 00:13:56 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
	[9.57.198.28]) by ppma02dal.us.ibm.com with ESMTP id 2uqgh8285u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NOT); Sat, 07 Sep 2019 00:13:56 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
	[9.57.199.107])
	by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	x870DroP47513980
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Sat, 7 Sep 2019 00:13:54 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC556124054;
	Sat,  7 Sep 2019 00:13:53 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 55829124052;
	Sat,  7 Sep 2019 00:13:53 +0000 (GMT)
Received: from oc4221205838.ibm.com (unknown [9.85.134.207])
	by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
	Sat,  7 Sep 2019 00:13:53 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: sebott@linux.ibm.com
Subject: [PATCH v4 1/4] s390: pci: Exporting access to CLP PCI function and
	PCI group
Date: Fri,  6 Sep 2019 20:13:48 -0400
Message-Id: <1567815231-17940-2-git-send-email-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1567815231-17940-1-git-send-email-mjrosato@linux.ibm.com>
References: <1567815231-17940-1-git-send-email-mjrosato@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-09-06_11:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1906280000 definitions=main-1909070000
X-Mailman-Approved-At: Sat, 07 Sep 2019 05:54:18 +0000
Cc: linux-s390@vger.kernel.org, walling@linux.ibm.com,
	alex.williamson@redhat.com, gor@linux.ibm.com,
	kvm@vger.kernel.org, pmorel@linux.ibm.com, cohuck@redhat.com,
	heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org,
	pasic@linux.ibm.com, borntraeger@de.ibm.com,
	iommu@lists.linux-foundation.org, robin.murphy@arm.com,
	gerald.schaefer@de.ibm.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

From: Pierre Morel <pmorel@linux.ibm.com>

For the generic implementation of VFIO PCI we need to retrieve
the hardware configuration for the PCI functions and the
PCI function groups.

We modify the internal function using CLP Query PCI function and
CLP query PCI function group so that they can be called from
outside the S390 architecture PCI code and prefix the two
functions with "zdev" to make clear that they can be called
knowing only the associated zdevice.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Reviewed-by: Sebastian Ott <sebott@linux.ibm.com>
---
 arch/s390/include/asm/pci.h |  3 ++
 arch/s390/pci/pci_clp.c     | 71 +++++++++++++++++++++++----------------------
 2 files changed, 40 insertions(+), 34 deletions(-)

diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
index a2399ef..dd03212 100644
--- a/arch/s390/include/asm/pci.h
+++ b/arch/s390/include/asm/pci.h
@@ -266,4 +266,7 @@ static inline int __pcibus_to_node(const struct pci_bus *bus)
 
 #endif /* CONFIG_NUMA */
 
+int zdev_query_pci_fngrp(struct zpci_dev *zdev,
+			 struct clp_req_rsp_query_pci_grp *rrb);
+int zdev_query_pci_fn(struct zpci_dev *zdev, struct clp_req_rsp_query_pci *rrb);
 #endif
diff --git a/arch/s390/pci/pci_clp.c b/arch/s390/pci/pci_clp.c
index 9bdff4d..df06fdf 100644
--- a/arch/s390/pci/pci_clp.c
+++ b/arch/s390/pci/pci_clp.c
@@ -113,32 +113,18 @@ static void clp_store_query_pci_fngrp(struct zpci_dev *zdev,
 	}
 }
 
-static int clp_query_pci_fngrp(struct zpci_dev *zdev, u8 pfgid)
+int zdev_query_pci_fngrp(struct zpci_dev *zdev,
+			 struct clp_req_rsp_query_pci_grp *rrb)
 {
-	struct clp_req_rsp_query_pci_grp *rrb;
-	int rc;
-
-	rrb = clp_alloc_block(GFP_KERNEL);
-	if (!rrb)
-		return -ENOMEM;
-
 	memset(rrb, 0, sizeof(*rrb));
 	rrb->request.hdr.len = sizeof(rrb->request);
 	rrb->request.hdr.cmd = CLP_QUERY_PCI_FNGRP;
 	rrb->response.hdr.len = sizeof(rrb->response);
-	rrb->request.pfgid = pfgid;
+	rrb->request.pfgid = zdev->pfgid;
 
-	rc = clp_req(rrb, CLP_LPS_PCI);
-	if (!rc && rrb->response.hdr.rsp == CLP_RC_OK)
-		clp_store_query_pci_fngrp(zdev, &rrb->response);
-	else {
-		zpci_err("Q PCI FGRP:\n");
-		zpci_err_clp(rrb->response.hdr.rsp, rc);
-		rc = -EIO;
-	}
-	clp_free_block(rrb);
-	return rc;
+	return clp_req(rrb, CLP_LPS_PCI);
 }
+EXPORT_SYMBOL(zdev_query_pci_fngrp);
 
 static int clp_store_query_pci_fn(struct zpci_dev *zdev,
 				  struct clp_rsp_query_pci *response)
@@ -174,32 +160,49 @@ static int clp_store_query_pci_fn(struct zpci_dev *zdev,
 	return 0;
 }
 
-static int clp_query_pci_fn(struct zpci_dev *zdev, u32 fh)
+int zdev_query_pci_fn(struct zpci_dev *zdev, struct clp_req_rsp_query_pci *rrb)
+{
+
+	memset(rrb, 0, sizeof(*rrb));
+	rrb->request.hdr.len = sizeof(rrb->request);
+	rrb->request.hdr.cmd = CLP_QUERY_PCI_FN;
+	rrb->response.hdr.len = sizeof(rrb->response);
+	rrb->request.fh = zdev->fh;
+
+	return clp_req(rrb, CLP_LPS_PCI);
+}
+
+static int clp_query_pci(struct zpci_dev *zdev)
 {
 	struct clp_req_rsp_query_pci *rrb;
+	struct clp_req_rsp_query_pci_grp *grrb;
 	int rc;
 
 	rrb = clp_alloc_block(GFP_KERNEL);
 	if (!rrb)
 		return -ENOMEM;
 
-	memset(rrb, 0, sizeof(*rrb));
-	rrb->request.hdr.len = sizeof(rrb->request);
-	rrb->request.hdr.cmd = CLP_QUERY_PCI_FN;
-	rrb->response.hdr.len = sizeof(rrb->response);
-	rrb->request.fh = fh;
-
-	rc = clp_req(rrb, CLP_LPS_PCI);
-	if (!rc && rrb->response.hdr.rsp == CLP_RC_OK) {
-		rc = clp_store_query_pci_fn(zdev, &rrb->response);
-		if (rc)
-			goto out;
-		rc = clp_query_pci_fngrp(zdev, rrb->response.pfgid);
-	} else {
+	rc = zdev_query_pci_fn(zdev, rrb);
+	if (rc || rrb->response.hdr.rsp != CLP_RC_OK) {
 		zpci_err("Q PCI FN:\n");
 		zpci_err_clp(rrb->response.hdr.rsp, rc);
 		rc = -EIO;
+		goto out;
 	}
+	rc = clp_store_query_pci_fn(zdev, &rrb->response);
+	if (rc)
+		goto out;
+
+	grrb = (struct clp_req_rsp_query_pci_grp *)rrb;
+	rc = zdev_query_pci_fngrp(zdev, grrb);
+	if (rc || grrb->response.hdr.rsp != CLP_RC_OK) {
+		zpci_err("Q PCI FGRP:\n");
+		zpci_err_clp(grrb->response.hdr.rsp, rc);
+		rc = -EIO;
+		goto out;
+	}
+	clp_store_query_pci_fngrp(zdev, &grrb->response);
+
 out:
 	clp_free_block(rrb);
 	return rc;
@@ -219,7 +222,7 @@ int clp_add_pci_device(u32 fid, u32 fh, int configured)
 	zdev->fid = fid;
 
 	/* Query function properties and update zdev */
-	rc = clp_query_pci_fn(zdev, fh);
+	rc = clp_query_pci(zdev);
 	if (rc)
 		goto error;
 
-- 
1.8.3.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
