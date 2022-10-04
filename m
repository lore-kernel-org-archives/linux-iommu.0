Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9660B7B
	for <iommu@lists.linux.dev>; Tue,  4 Oct 2022 12:07:21 +0000 (UTC)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 294A8c7f008580;
	Tue, 4 Oct 2022 12:07:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=gjJeUk27NyKv1lbIFV/Hsf9JTFXiSQ9D5upP3GoVtkc=;
 b=nBVXCcjOMKQhX8K3nfcK/8XaqURyc4KEQ2kQg+aDBDn52dgn+e9HZWSZwAncAdHiC3yp
 GrYbiUDutumnSYD2ycCgsmsUdis9N6B2IO1SlkW/JvLiL60IDJTES8OzP9dEV7/QohA8
 ZEkqfyfP5HJdcDvpxC8/Y2GoccuZ/YZp80hDwaCb35Kw4ryYN5Gmzezai9+p+0qNv4Cc
 JE0/zoRbIv//LYclsKrUS7Mq7ab9yoGHdS1cbEHCbjq8kck5cesiWOFMUI9MyKy/2fmW
 0VynU6bO9Xzrgwd6QiCCXd6tjF+cSOwb6IG4CYXCWASvQqBVhYheVO0Q3TPTHOPIlOmf KQ== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k0gw16k90-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Oct 2022 12:07:14 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
	by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 294C62Bt026342;
	Tue, 4 Oct 2022 12:07:12 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
	by ppma04ams.nl.ibm.com with ESMTP id 3jxd6943qd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Oct 2022 12:07:11 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 294C799t59507174
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Oct 2022 12:07:09 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E64DCA4040;
	Tue,  4 Oct 2022 12:07:08 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 724BCA4053;
	Tue,  4 Oct 2022 12:07:08 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Tue,  4 Oct 2022 12:07:08 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev
Cc: linux-s390@vger.kernel.org, borntraeger@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, jgg@nvidia.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/5] iommu/s390: Fix incorrect aperture check
Date: Tue,  4 Oct 2022 14:07:05 +0200
Message-Id: <20221004120706.2957492-5-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221004120706.2957492-1-schnelle@linux.ibm.com>
References: <20221004120706.2957492-1-schnelle@linux.ibm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vnDWB1zKrndT8EZxLDv53iZgmKcVPahl
X-Proofpoint-GUID: vnDWB1zKrndT8EZxLDv53iZgmKcVPahl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-04_04,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 impostorscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210040078

The domain->geometry.aperture_end specifies the last valid address treat
it as such when checking if a DMA address is valid.

Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
v3 -> v4:
- Make aperture check resistant against overflow (Jason)

 drivers/iommu/s390-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index 762dc55aea1e..94c444b909bd 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -200,7 +200,7 @@ static int s390_iommu_update_trans(struct s390_domain *s390_domain,
 	int rc = 0;
 
 	if (dma_addr < s390_domain->domain.geometry.aperture_start ||
-	    dma_addr + size > s390_domain->domain.geometry.aperture_end)
+	    (dma_addr + size - 1) > s390_domain->domain.geometry.aperture_end)
 		return -EINVAL;
 
 	nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
-- 
2.34.1

