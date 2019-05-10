Return-Path: <SRS0=MPmd=TK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7DFFC04A6B
	for <iommu@archiver.kernel.org>; Fri, 10 May 2019 08:23:08 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FD6D20850
	for <iommu@archiver.kernel.org>; Fri, 10 May 2019 08:23:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FD6D20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 85A5CE39;
	Fri, 10 May 2019 08:23:08 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id CF131D99
	for <iommu@lists.linux-foundation.org>;
	Fri, 10 May 2019 08:23:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
	[148.163.156.1])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 88ABF1FB
	for <iommu@lists.linux-foundation.org>;
	Fri, 10 May 2019 08:23:07 +0000 (UTC)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x4A8N27x120226
	for <iommu@lists.linux-foundation.org>; Fri, 10 May 2019 04:23:07 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2sd4xma0w1-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <iommu@lists.linux-foundation.org>; Fri, 10 May 2019 04:23:05 -0400
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <iommu@lists.linux-foundation.org> from <pmorel@linux.ibm.com>;
	Fri, 10 May 2019 09:22:42 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
	by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Fri, 10 May 2019 09:22:39 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
	[9.149.105.62])
	by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x4A8MbXY49610988
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Fri, 10 May 2019 08:22:37 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 75D9EAE051;
	Fri, 10 May 2019 08:22:37 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E1608AE055;
	Fri, 10 May 2019 08:22:36 +0000 (GMT)
Received: from morel-ThinkPad-W530.boeblingen.de.ibm.com (unknown
	[9.145.187.238])
	by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Fri, 10 May 2019 08:22:36 +0000 (GMT)
From: Pierre Morel <pmorel@linux.ibm.com>
To: sebott@linux.vnet.ibm.com
Subject: [PATCH 2/4] vfio: vfio_iommu_type1: Define
	VFIO_IOMMU_INFO_CAPABILITIES
Date: Fri, 10 May 2019 10:22:33 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557476555-20256-1-git-send-email-pmorel@linux.ibm.com>
References: <1557476555-20256-1-git-send-email-pmorel@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19051008-4275-0000-0000-0000033351DE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051008-4276-0000-0000-00003842C748
Message-Id: <1557476555-20256-3-git-send-email-pmorel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-05-09_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=780 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1905100059
Cc: linux-s390@vger.kernel.org, pasic@linux.vnet.ibm.com,
	alex.williamson@redhat.com, kvm@vger.kernel.org,
	heiko.carstens@de.ibm.com, walling@linux.ibm.com,
	linux-kernel@vger.kernel.org, borntraeger@de.ibm.com,
	iommu@lists.linux-foundation.org, schwidefsky@de.ibm.com,
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

To use the VFIO_IOMMU_GET_INFO to retrieve IOMMU specific information,
we define a new flag VFIO_IOMMU_INFO_CAPABILITIES in the
vfio_iommu_type1_info structure and the associated capability
information block.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 include/uapi/linux/vfio.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 8f10748..8f68e0f 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -715,6 +715,16 @@ struct vfio_iommu_type1_info {
 	__u32	flags;
 #define VFIO_IOMMU_INFO_PGSIZES (1 << 0)	/* supported page sizes info */
 	__u64	iova_pgsizes;		/* Bitmap of supported page sizes */
+#define VFIO_IOMMU_INFO_CAPABILITIES (1 << 1)  /* support capabilities info */
+	__u64   cap_offset;     /* Offset within info struct of first cap */
+};
+
+#define VFIO_IOMMU_INFO_CAP_QFN		1
+#define VFIO_IOMMU_INFO_CAP_QGRP	2
+
+struct vfio_iommu_type1_info_block {
+	struct vfio_info_cap_header header;
+	__u32 data[];
 };
 
 #define VFIO_IOMMU_GET_INFO _IO(VFIO_TYPE, VFIO_BASE + 12)
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
