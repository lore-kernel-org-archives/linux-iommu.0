Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58DB6C433EF
	for <iommu@archiver.kernel.org>; Fri,  4 Mar 2022 13:59:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A81F960F88;
	Fri,  4 Mar 2022 13:59:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xkXdgSjhG7Ts; Fri,  4 Mar 2022 13:59:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7F58C60D6C;
	Fri,  4 Mar 2022 13:59:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 56F6AC001D;
	Fri,  4 Mar 2022 13:59:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4699AC000B
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 13:59:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F0B2B4168D
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 13:59:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ibm.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Y_PJ9UOhmsVt for <iommu@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 13:59:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 26ABB41688
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 13:59:20 +0000 (UTC)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 224DvARZ018816; 
 Fri, 4 Mar 2022 13:59:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=rJI+W8znlgq3IeuuQK96IK1RIeb4TDW5ujOWEcCPmt4=;
 b=KlKlZReq8u9Vtw9xFXG08RH/hlQuBMylXXtI7dfHNF6Bs1ug9j6wR157qvaYkt6IFM59
 rZj68dGDD/hvpCv9iz6Cq3OAtTBg/1oDka4Kxy3huXy97vje5+CSc1q/xuZq+wEHJLEd
 RTTd+WKcqswbbtb3e1M4kY4NKaOzuWXG1OhJD3CqHQtMzb0XGWux5jb9LW5fG3v81mNN
 kgMjqG0CONSPPX/t9HxpaNSlaJ0zrkuHta+q19CT5DX9vI7aIZc0sb4avY1B/mPzpfN8
 S4pNnca8oa1cBNtgmaoggZcLbVSGksXhdalYU+79Msn3y+VHYMU4nAAPGnuZElw/GdrL yQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3ekb6gt0t5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 04 Mar 2022 13:59:09 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 224Bg97l007569;
 Fri, 4 Mar 2022 13:59:09 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.70])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3ekb6gt0rw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 04 Mar 2022 13:59:09 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
 by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 224DrZFZ024546;
 Fri, 4 Mar 2022 13:59:06 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by ppma01fra.de.ibm.com with ESMTP id 3ek4k81mda-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 04 Mar 2022 13:59:06 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 224Dx3UY7536992
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 4 Mar 2022 13:59:03 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9AEDFAE051;
 Fri,  4 Mar 2022 13:59:03 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1FC2AAE045;
 Fri,  4 Mar 2022 13:59:03 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri,  4 Mar 2022 13:59:03 +0000 (GMT)
From: Halil Pasic <pasic@linux.ibm.com>
To: Christoph Hellwig <hch@infradead.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 0/2] swiotlb: rework fix info leak with DMA_FROM_DEVICE
Date: Fri,  4 Mar 2022 14:58:57 +0100
Message-Id: <20220304135859.3521513-1-pasic@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: N92PW_cjbVXc--CGf5Nkuep7JfHDooWp
X-Proofpoint-GUID: 6LzP9T3dM405XagGvK82ddQ8-H0bOogf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-04_06,2022-03-04_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1011
 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0 priorityscore=1501
 mlxlogscore=894 adultscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203040071
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>, linux-doc@vger.kernel.org,
 stable@vger.kernel.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 iommu@lists.linux-foundation.org, Doug Gilbert <dgilbert@interlog.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
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

Unfortunately, we ended up with the wrong version of the patch "fix info
leak with DMA_FROM_DEVICE" getting merged. We got v4 merged, but the
version we want is v7 with some minor tweaks which were supposed to be
applied by Christoph (swiotlb maintainer). After pointing this out, I
was asked by Christoph to create an incremental fix. 

IMHO the cleanest way to do this is a reverting the incorrect version
of the patch and applying the correct one. I hope that qualifies as
an incremental fix.

The main differences between what we got and what we need are:
* swiotlb_sync_single_for_device is also required to do an extra bounce
* It was decided that we want to defer introducing DMA_ATTR_OVERWRITE,
  until we have exploiters 
* And anyway DMA_ATTR_OVERWRITE must take precedence over
  DMA_ATTR_SKIP_CPU_SYNC, so the v4 implementation of DMA_ATTR_OVERWRITE
  ain't even orrect.


Halil Pasic (2):
  Revert "swiotlb: fix info leak with DMA_FROM_DEVICE"
  swiotlb: fix info leak with DMA_FROM_DEVICE

 Documentation/core-api/dma-attributes.rst |  8 --------
 include/linux/dma-mapping.h               |  8 --------
 kernel/dma/swiotlb.c                      | 23 +++++++++++++++--------
 3 files changed, 15 insertions(+), 24 deletions(-)


base-commit: 38f80f42147ff658aff218edb0a88c37e58bf44f
-- 
2.32.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
