Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB6363D7
	for <iommu@lists.linux.dev>; Wed, 30 Nov 2022 16:29:18 +0000 (UTC)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AUGIB4I009352;
	Wed, 30 Nov 2022 16:29:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=VV3smw0uO8uzSuO+VY0XddbFhxCvz0keXmOmUEo/naY=;
 b=GeqUah9JYf8K4KJkCcD63UeTdVDLD3GzuDKaFqdGWNK5kk5xUwcFOFe9U3uP1ZzbLwLw
 Q0vX7caRoaCA/QPUrHBgD8LQ8fZaGuxm7aXp7O1+qiMwSWvsjD8z+6z4y0aUsX0Mz+6B
 GTdkWxrEcoKmv+PIcgTSVMDN/yv4scA6cU+W8yQDsdgUyS3Kla3ItrLIHsoy6OdoEYfi
 B1TCVio9/WcmZgk7dKTBazKK0/JzRpLCuT8+fy70bbP9VbBLmXB2bf9krGokawh9P7dE
 kd6GcGmD/dvujlUCl/DwiCi6AAK4+FR3LhaJZekgEEauytzg76dWDQskPF89eGbBz4XQ wg== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
	by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3m6ajpg82w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Nov 2022 16:29:09 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
	by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AUGLqs8022051;
	Wed, 30 Nov 2022 16:29:07 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
	by ppma02fra.de.ibm.com with ESMTP id 3m3ae94dre-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Nov 2022 16:29:07 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
	by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AUGT5mt22086260
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Nov 2022 16:29:05 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F05EA405F;
	Wed, 30 Nov 2022 16:29:05 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DF393A4054;
	Wed, 30 Nov 2022 16:29:04 +0000 (GMT)
Received: from dilbert5.boeblingen.de.ibm.com (unknown [9.152.212.238])
	by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Wed, 30 Nov 2022 16:29:04 +0000 (GMT)
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev, linux390-list@tuxmaker.boeblingen.de.ibm.com,
        Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH] iommu/s390: Remove duplicate statement
Date: Wed, 30 Nov 2022 17:29:04 +0100
Message-Id: <20221130162904.472226-1-gbayer@linux.ibm.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: D0KJxY9iyEYwDaKp0SozOaBanAca1RyD
X-Proofpoint-ORIG-GUID: D0KJxY9iyEYwDaKp0SozOaBanAca1RyD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-30_04,2022-11-30_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 adultscore=0 mlxscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211300112

Clean up an erroneously duplicated statement. This is
a late finding while reviewing the latest s390 IOMMU work.

Fixes: cbf7827bc5dc ("iommu/s390: Fix potential s390_domain aperture shrinking")
Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
---

This duplicate line is currently in the -next and the IOMMU trees but not yet in
mainline.

 drivers/iommu/s390-iommu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index ed33c6cce083..3fd0e9fdacb8 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -132,7 +132,6 @@ static int s390_iommu_attach_device(struct iommu_domain *domain,
 	 */
 	if (cc && status != ZPCI_PCI_ST_FUNC_NOT_AVAIL)
 		return -EIO;
-	zdev->dma_table = s390_domain->dma_table;

 	zdev->dma_table = s390_domain->dma_table;
 	zdev->s390_domain = s390_domain;
-- 
2.38.1

