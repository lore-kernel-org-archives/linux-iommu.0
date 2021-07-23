Return-Path: <SRS0=yZZ9=MP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1448AC4338F
	for <iommu@archiver.kernel.org>; Fri, 23 Jul 2021 23:18:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FB1060F25
	for <iommu@archiver.kernel.org>; Fri, 23 Jul 2021 23:18:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8FB1060F25
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5295783B72;
	Fri, 23 Jul 2021 23:18:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FEifQJHSnN6L; Fri, 23 Jul 2021 23:18:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2EBBD83B6C;
	Fri, 23 Jul 2021 23:18:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E98D9C0010;
	Fri, 23 Jul 2021 23:18:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0DA78C000E
 for <iommu@lists.linux-foundation.org>; Fri, 23 Jul 2021 23:18:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DB7A8414B7
 for <iommu@lists.linux-foundation.org>; Fri, 23 Jul 2021 23:18:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ibm.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id s5AfGnXU0QyM for <iommu@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 23:18:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 29839414B5
 for <iommu@lists.linux-foundation.org>; Fri, 23 Jul 2021 23:18:19 +0000 (UTC)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 16NN2lbm026571; Fri, 23 Jul 2021 19:18:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=8sfxVjObelAC18t2Mcrt5gz09PThZDf56hljvbnXAjM=;
 b=aCHUFS074T+vPxlYlzIy4ATjxL28SJOxK8T2g+rJtUycE7J2IC6wetG0c5PBE/ss+HIx
 Zq00KV/TpjlGOEilk4+bjaSaDip30qFZJF7Ikow7IuqtLepF8E0goz/9C8DD+ZW3t6xN
 rJZoCP9zFU1jXzBr48wWzLGyLOn0gz754TAkZQqQIvTSE9Od2oDqhO9WfRJHUHejy6jN
 3y4BrL+shpH6oFlclwiWREVXuszuCIDkhApEwoNvWlunCwXzoFXSCuGRJ//yeounNkDG
 Eq59p9+vUjaatbII+/0yOsI9O8cXNSxDMSS6Vjn2/SoaUPk3ew0nkkRzH3Yf3g4YC8EE ng== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3a06hns5pv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Jul 2021 19:18:11 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16NNHFHa008905;
 Fri, 23 Jul 2021 23:18:08 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by ppma06ams.nl.ibm.com with ESMTP id 39vng72vw6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Jul 2021 23:18:08 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 16NNI5Gi29491600
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 23 Jul 2021 23:18:05 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5C9C94C08B;
 Fri, 23 Jul 2021 23:18:05 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C42D14C07A;
 Fri, 23 Jul 2021 23:18:04 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 23 Jul 2021 23:18:04 +0000 (GMT)
From: Halil Pasic <pasic@linux.ibm.com>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH v2 1/1] s390/pv: fix the forcing of the swiotlb
Date: Sat, 24 Jul 2021 01:17:46 +0200
Message-Id: <20210723231746.3964989-1-pasic@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: m1jpGHpOV5hVjMebEskb7OtI42Sl7OlE
X-Proofpoint-ORIG-GUID: m1jpGHpOV5hVjMebEskb7OtI42Sl7OlE
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.790
 definitions=2021-07-23_13:2021-07-23,
 2021-07-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxscore=0
 clxscore=1011 malwarescore=0 impostorscore=0 adultscore=0 suspectscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107230137
Cc: Nathan Chancellor <nathan@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
 linux-s390 <linux-s390@vger.kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Heiko Carstens <hca@linux.ibm.com>, stable@vger.kernel.org,
 Halil Pasic <pasic@linux.ibm.com>, Claire Chang <tientzu@chromium.org>,
 Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Guenter Roeck <linux@roeck-us.net>
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

Since commit 903cd0f315fe ("swiotlb: Use is_swiotlb_force_bounce for
swiotlb data bouncing") if code sets swiotlb_force it needs to do so
before the swiotlb is initialised. Otherwise
io_tlb_default_mem->force_bounce will not get set to true, and devices
that use (the default) swiotlb will not bounce despite switolb_force
having the value of SWIOTLB_FORCE.

Let us restore swiotlb functionality for PV by fulfilling this new
requirement.

This change addresses what turned out to be a fragility in
commit 64e1f0c531d1 ("s390/mm: force swiotlb for protected
virtualization"), which ain't exactly broken in its original context,
but could give us some more headache if people backport the broken
change and forget this fix.

Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Fixes: 903cd0f315fe ("swiotlb: Use is_swiotlb_force_bounce for swiotlb data bouncing")
Fixes: 64e1f0c531d1 ("s390/mm: force swiotlb for protected virtualization")
Cc: stable@vger.kernel.org #5.3+

---

I'm aware that this fix does not really satisfy the formal requirements
for the stable process. But to avoid problems with backports we would
like this fix applied to 5.3+ stable kernels.
---
 arch/s390/mm/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index d85bd7f5d8dc..1c8f8ccebfb7 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -186,9 +186,9 @@ static void pv_init(void)
 		return;
 
 	/* make sure bounce buffers are shared */
+	swiotlb_force = SWIOTLB_FORCE;
 	swiotlb_init(1);
 	swiotlb_update_mem_attributes();
-	swiotlb_force = SWIOTLB_FORCE;
 }
 
 void __init mem_init(void)

base-commit: 90d856e71443a2fcacca8e7539bac44d9cb3f7ab
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
