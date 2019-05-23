Return-Path: <SRS0=aUVl=TX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14638C282DD
	for <iommu@archiver.kernel.org>; Thu, 23 May 2019 12:25:57 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E267421019
	for <iommu@archiver.kernel.org>; Thu, 23 May 2019 12:25:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E267421019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 72E04C2C;
	Thu, 23 May 2019 12:25:38 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id BBD469EE
	for <iommu@lists.linux-foundation.org>;
	Thu, 23 May 2019 12:25:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
	[148.163.158.5])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 27E3F875
	for <iommu@lists.linux-foundation.org>;
	Thu, 23 May 2019 12:25:35 +0000 (UTC)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x4NC7ZoK018747
	for <iommu@lists.linux-foundation.org>; Thu, 23 May 2019 08:25:35 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2snu8f0udj-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <iommu@lists.linux-foundation.org>; Thu, 23 May 2019 08:25:34 -0400
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <iommu@lists.linux-foundation.org> from <pmorel@linux.ibm.com>;
	Thu, 23 May 2019 13:25:33 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
	by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Thu, 23 May 2019 13:25:29 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
	[9.149.105.232])
	by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x4NCPSVW44892364
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Thu, 23 May 2019 12:25:28 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 066DA52052;
	Thu, 23 May 2019 12:25:28 +0000 (GMT)
Received: from morel-ThinkPad-W530.boeblingen.de.ibm.com (unknown
	[9.152.222.40])
	by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 7A1DF52057;
	Thu, 23 May 2019 12:25:27 +0000 (GMT)
From: Pierre Morel <pmorel@linux.ibm.com>
To: sebott@linux.vnet.ibm.com
Subject: [PATCH v3 1/3] s390: pci: Exporting access to CLP PCI function and
	PCI group
Date: Thu, 23 May 2019 14:25:24 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558614326-24711-1-git-send-email-pmorel@linux.ibm.com>
References: <1558614326-24711-1-git-send-email-pmorel@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19052312-0012-0000-0000-0000031EAB75
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052312-0013-0000-0000-000021576488
Message-Id: <1558614326-24711-2-git-send-email-pmorel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-05-23_10:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1905230087
Cc: linux-s390@vger.kernel.org, pasic@linux.vnet.ibm.com,
	alex.williamson@redhat.com, kvm@vger.kernel.org,
	heiko.carstens@de.ibm.com, walling@linux.ibm.com,
	linux-kernel@vger.kernel.org, borntraeger@de.ibm.com,
	iommu@lists.linux-foundation.org, schwidefsky@de.ibm.com,
	robin.murphy@arm.com, gerald.schaefer@de.ibm.com
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
 arch/s390/pci/pci_clp.c     | 70 +++++++++++++++++++++++----------------------
 2 files changed, 39 insertions(+), 34 deletions(-)

diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
index 305befd..e66b246 100644
--- a/arch/s390/include/asm/pci.h
+++ b/arch/s390/include/asm/pci.h
@@ -261,4 +261,7 @@ cpumask_of_pcibus(const struct pci_bus *bus)
 
 #endif /* CONFIG_NUMA */
 
+int zdev_query_pci_fngrp(struct zpci_dev *zdev,
+			 struct clp_req_rsp_query_pci_grp *rrb);
+int zdev_query_pci_fn(struct zpci_dev *zdev, struct clp_req_rsp_query_pci *rrb);
 #endif
diff --git a/arch/s390/pci/pci_clp.c b/arch/s390/pci/pci_clp.c
index 3a36b07..c57f675 100644
--- a/arch/s390/pci/pci_clp.c
+++ b/arch/s390/pci/pci_clp.c
@@ -113,31 +113,16 @@ static void clp_store_query_pci_fngrp(struct zpci_dev *zdev,
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
 
 static int clp_store_query_pci_fn(struct zpci_dev *zdev,
@@ -174,32 +159,49 @@ static int clp_store_query_pci_fn(struct zpci_dev *zdev,
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
@@ -219,7 +221,7 @@ int clp_add_pci_device(u32 fid, u32 fh, int configured)
 	zdev->fid = fid;
 
 	/* Query function properties and update zdev */
-	rc = clp_query_pci_fn(zdev, fh);
+	rc = clp_query_pci(zdev);
 	if (rc)
 		goto error;
 
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
