Return-Path: <SRS0=L2Qy=CE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31CBFC433E1
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 11:33:51 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7EAF2083B
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 11:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SO5iEERq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7EAF2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id AC80D86B2D;
	Wed, 26 Aug 2020 11:33:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mkt9lh20z6ox; Wed, 26 Aug 2020 11:33:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1A55884E38;
	Wed, 26 Aug 2020 11:33:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ECD14C07FF;
	Wed, 26 Aug 2020 11:33:45 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 80A63C0051
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 11:33:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 55AE3204B3
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 11:33:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Nl6h5h5W0jUY for <iommu@lists.linux-foundation.org>;
 Wed, 26 Aug 2020 11:33:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 by silver.osuosl.org (Postfix) with ESMTPS id A493E2045C
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 11:33:42 +0000 (UTC)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07QBU3OI079427;
 Wed, 26 Aug 2020 11:33:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=4d0UEY0MXbhyacpjI1yRuNRF+3MeSwYn+K5Lelz7zok=;
 b=SO5iEERq4BF1tLDEDNrPv4XwotVauqLillq4/v5Mc/+xjDq0Qy1jaGClXXyjs3l40zOc
 gw/Tqyw1+jv+wZxtVypp51J9RU7r6eUKu1I+yXE+K5b1oK7n1FQlvcW6mkK/dC7kFY32
 VLzwdWxDUHN6PC3ZP0i9ep87Et8R0II5dq8DQRSAGgpd/sVZj61jhrP0UN1fJBxj7dLO
 P0X8DDJmqa6tt25759bT2RQuvJphDCgXjcXhHMhl8/5OALJXVRq39UMNpGp5FeBwr/N3
 qGyu3eumDuRE/+u/f3QCsE6L6ceAbCPnHc0MNl00Xil9/8GwfJSwahcPsuLqmzYECf1m wA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 333dbrytst-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 26 Aug 2020 11:33:39 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07QBUE92001015;
 Wed, 26 Aug 2020 11:33:38 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3020.oracle.com with ESMTP id 333rua2a2w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2020 11:33:38 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07QBXbQi012927;
 Wed, 26 Aug 2020 11:33:37 GMT
Received: from mwanda (/41.57.98.10) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 26 Aug 2020 04:33:36 -0700
Date: Wed, 26 Aug 2020 14:33:30 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Christoph Hellwig <hch@lst.de>,
 Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH] dma-pool: Fix an uninitialized variable bug in
 atomic_pool_expand()
Message-ID: <20200826113330.GD393664@mwanda>
MIME-Version: 1.0
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9724
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0
 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008260093
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9724
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 clxscore=1011
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008260093
Cc: kernel-janitors@vger.kernel.org, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org
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

The "page" pointer can be used with out being initialized.

Fixes: d7e673ec2c8e ("dma-pool: Only allocate from CMA when in same memory zone")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 kernel/dma/pool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index 06582b488e31..1281c0f0442b 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -84,7 +84,7 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
 			      gfp_t gfp)
 {
 	unsigned int order;
-	struct page *page;
+	struct page *page = NULL;
 	void *addr;
 	int ret = -ENOMEM;
 
-- 
2.28.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
