Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0EA28EE
	for <iommu@lists.linux.dev>; Tue,  8 Nov 2022 13:00:27 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A8C9Or5009799;
	Tue, 8 Nov 2022 12:59:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2022-7-12; bh=FkA06drFvoohZOAdtjadciWDeXolGizxDkgRyYuiORY=;
 b=qPZh7p9DtLx44ReKOkmgNZH8JVJHDp9qwcIPpOOBAunnsT14EjuaIlzJr2euVtCgOgpS
 zq461cPoL9ieX+5eab6yjY+Xu1VlhLMQZht4ITlEXzmxZh3gLV1BXzp4KHsHCTh39aAv
 CVzcMgpUC/dro2fC4F/9079yZICWmde3AEiq29RPGuS2KxxwZaDwEBNgGcUtuiaI2gpU
 VTM4pFRYaMK4gZR7CkPo/KqnsUoewf6KedJA8zwnIGamgSwvbJUhkhNjqcvIV72mAZWO
 J7WhdqhImUl6AVfkyYy8F2aQ4XMc8xFYwYelL9oB1omHTz0xAMDX/JROjmefjMeFJ19m GQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kngreq23d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Nov 2022 12:59:28 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A8A5mNr030074;
	Tue, 8 Nov 2022 12:59:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kpctkc73x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Nov 2022 12:59:28 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2A8CxRG4027177;
	Tue, 8 Nov 2022 12:59:27 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3kpctkc73p-1;
	Tue, 08 Nov 2022 12:59:27 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: 
Cc: harshit.m.mogalapalli@oracle.com, konrad.wilk@oracle.com,
        harshit.m.mogalapalli@gmail.com, David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [RFC] iommu/vt-d: set default value of INTEL_IOMMU_FLOPPY_WA to n
Date: Tue,  8 Nov 2022 04:58:55 -0800
Message-Id: <20221108125855.2984751-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211080076
X-Proofpoint-ORIG-GUID: QcCHY4EIHo5OTCgg4UQclcgiztWbC31S
X-Proofpoint-GUID: QcCHY4EIHo5OTCgg4UQclcgiztWbC31S

It is likely that modern intel motherboard will not ship with a
floppy connection anymore, so let us disable it by default, as it
gets turned on when we do a make defconfig.

Suggested-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 drivers/iommu/intel/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
index b7dff5092fd2..c783ae85ca9b 100644
--- a/drivers/iommu/intel/Kconfig
+++ b/drivers/iommu/intel/Kconfig
@@ -76,7 +76,7 @@ config INTEL_IOMMU_BROKEN_GFX_WA
 	  option is removed in the 2.6.32 kernel.
 
 config INTEL_IOMMU_FLOPPY_WA
-	def_bool y
+	def_bool n
 	depends on X86
 	help
 	  Floppy disk drivers are known to bypass DMA API calls
-- 
2.38.1

