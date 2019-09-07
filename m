Return-Path: <SRS0=yK3q=XC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E0AC43331
	for <iommu@archiver.kernel.org>; Sat,  7 Sep 2019 05:54:29 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6443721670
	for <iommu@archiver.kernel.org>; Sat,  7 Sep 2019 05:54:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6443721670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 9E866E70;
	Sat,  7 Sep 2019 05:54:20 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 372292961
	for <iommu@lists.linux-foundation.org>;
	Sat,  7 Sep 2019 00:14:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
	[148.163.156.1])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id D7B95756
	for <iommu@lists.linux-foundation.org>;
	Sat,  7 Sep 2019 00:14:07 +0000 (UTC)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x8707KAq042339; Fri, 6 Sep 2019 20:13:59 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2uuwcnqq2e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NOT); Fri, 06 Sep 2019 20:13:59 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x8708NVT044333;
	Fri, 6 Sep 2019 20:13:58 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com
	[169.55.91.170])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2uuwcnqq1x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NOT); Fri, 06 Sep 2019 20:13:58 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
	by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id
	x8709NrN029092; Sat, 7 Sep 2019 00:13:57 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
	[9.57.198.23]) by ppma02wdc.us.ibm.com with ESMTP id 2uqgh7pr3s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NOT); Sat, 07 Sep 2019 00:13:57 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
	[9.57.199.107])
	by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	x870DtQm54722900
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Sat, 7 Sep 2019 00:13:55 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C696124054;
	Sat,  7 Sep 2019 00:13:55 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8AAF2124053;
	Sat,  7 Sep 2019 00:13:54 +0000 (GMT)
Received: from oc4221205838.ibm.com (unknown [9.85.134.207])
	by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
	Sat,  7 Sep 2019 00:13:54 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: sebott@linux.ibm.com
Subject: [PATCH v4 3/4] vfio: zpci: defining the VFIO headers
Date: Fri,  6 Sep 2019 20:13:50 -0400
Message-Id: <1567815231-17940-4-git-send-email-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1567815231-17940-1-git-send-email-mjrosato@linux.ibm.com>
References: <1567815231-17940-1-git-send-email-mjrosato@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-09-06_11:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=852 adultscore=0 classifier=spam adjust=0 reason=mlx
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

We define a new device region in vfio.h to be able to
get the ZPCI CLP information by reading this region from
userland.

We create a new file, vfio_zdev.h to define the structure
of the new region we defined in vfio.h

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 include/uapi/linux/vfio.h      |  1 +
 include/uapi/linux/vfio_zdev.h | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)
 create mode 100644 include/uapi/linux/vfio_zdev.h

diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 8f10748..8328c87 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -371,6 +371,7 @@ struct vfio_region_gfx_edid {
  * to do TLB invalidation on a GPU.
  */
 #define VFIO_REGION_SUBTYPE_IBM_NVLINK2_ATSD	(1)
+#define VFIO_REGION_SUBTYPE_ZDEV_CLP		(2)
 
 /*
  * The MSIX mappable capability informs that MSIX data of a BAR can be mmapped
diff --git a/include/uapi/linux/vfio_zdev.h b/include/uapi/linux/vfio_zdev.h
new file mode 100644
index 0000000..55e0d6d
--- /dev/null
+++ b/include/uapi/linux/vfio_zdev.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Region definition for ZPCI devices
+ *
+ * Copyright IBM Corp. 2019
+ *
+ * Author(s): Pierre Morel <pmorel@linux.ibm.com>
+ */
+
+#ifndef _VFIO_ZDEV_H_
+#define _VFIO_ZDEV_H_
+
+#include <linux/types.h>
+
+/**
+ * struct vfio_region_zpci_info - ZPCI information.
+ *
+ */
+struct vfio_region_zpci_info {
+	__u64 dasm;
+	__u64 start_dma;
+	__u64 end_dma;
+	__u64 msi_addr;
+	__u64 flags;
+	__u16 pchid;
+	__u16 mui;
+	__u16 noi;
+	__u16 maxstbl;
+	__u8 version;
+	__u8 gid;
+#define VFIO_PCI_ZDEV_FLAGS_REFRESH 1
+	__u8 util_str[];
+} __packed;
+
+#endif
-- 
1.8.3.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
