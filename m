Return-Path: <SRS0=v/Dl=XS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF00C32755
	for <iommu@archiver.kernel.org>; Mon, 23 Sep 2019 12:35:14 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AF7921655
	for <iommu@archiver.kernel.org>; Mon, 23 Sep 2019 12:35:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AF7921655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 99977CCC;
	Mon, 23 Sep 2019 12:35:12 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 51E6DCC6
	for <iommu@lists.linux-foundation.org>;
	Mon, 23 Sep 2019 12:35:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
	[148.163.156.1])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id F1028102
	for <iommu@lists.linux-foundation.org>;
	Mon, 23 Sep 2019 12:35:10 +0000 (UTC)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x8NCUxlD139894
	for <iommu@lists.linux-foundation.org>; Mon, 23 Sep 2019 08:35:10 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2v6x4g02vs-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <iommu@lists.linux-foundation.org>; Mon, 23 Sep 2019 08:35:09 -0400
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <iommu@lists.linux-foundation.org> from <pasic@linux.ibm.com>;
	Mon, 23 Sep 2019 13:35:07 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
	by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Mon, 23 Sep 2019 13:35:05 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
	[9.149.105.61])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x8NCZ3RJ60686590
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Mon, 23 Sep 2019 12:35:03 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 83BC211C064;
	Mon, 23 Sep 2019 12:35:03 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2613811C05C;
	Mon, 23 Sep 2019 12:35:03 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Mon, 23 Sep 2019 12:35:03 +0000 (GMT)
From: Halil Pasic <pasic@linux.ibm.com>
To: Christoph Hellwig <hch@lst.de>,
	Gerald Schaefer <gerald.schaefer@de.ibm.com>
Subject: [RFC PATCH 3/3] dma-mapping: warn on harmful GFP_* flags
Date: Mon, 23 Sep 2019 14:34:18 +0200
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190923123418.22695-1-pasic@linux.ibm.com>
References: <20190923123418.22695-1-pasic@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19092312-4275-0000-0000-0000036A0B34
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19092312-4276-0000-0000-0000387C7F68
Message-Id: <20190923123418.22695-4-pasic@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-09-23_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1908290000 definitions=main-1909230124
Cc: linux-s390@vger.kernel.org, Janosch Frank <frankja@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	linux-kernel@vger.kernel.org, Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	iommu@lists.linux-foundation.org
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

The commit message of commit 57bf5a8963f8 ("dma-mapping: clear harmful
GFP_* flags in common code") says that probably warn when we encounter
harmful GFP_* flags which we clean -- because the client code is best
case silly if not buggy. I concur with that.

Let's warn once when we encounter silly GFP_* flags. The guys caring
about the respective client code will hopefully fix these soon.

Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
---

I'm not too happy with my warning message. Suggestions welcome!
---
 include/linux/dma-mapping.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 5024bc863fa7..299f36ac8668 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -823,6 +823,9 @@ extern gfp_t dma_override_gfp_flags(struct device *dev, gfp_t flags);
 static inline gfp_t dma_override_gfp_flags(struct device *dev, gfp_t flags)
 {
 	/* let the implementation decide on the zone to allocate from: */
+	dev_WARN_ONCE(dev,
+		      flags & (__GFP_DMA32 | __GFP_DMA | __GFP_HIGHMEM),
+		      "fixme: don't dma_alloc with any of: __GFP_DMA32, __GFP_DMA, __GFP_HIGHMEM\n");
 	return flags & ~(__GFP_DMA | __GFP_DMA32 | __GFP_HIGHMEM);
 }
 #endif
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
