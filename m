Return-Path: <SRS0=TrXs=EJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A239C388F7
	for <iommu@archiver.kernel.org>; Tue,  3 Nov 2020 10:18:46 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E14D1206F8
	for <iommu@archiver.kernel.org>; Tue,  3 Nov 2020 10:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="0U2QI6sk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E14D1206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8D7C8870F7;
	Tue,  3 Nov 2020 10:18:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qN0ED2+0hLQp; Tue,  3 Nov 2020 10:18:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 10044870E6;
	Tue,  3 Nov 2020 10:18:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0514DC0889;
	Tue,  3 Nov 2020 10:18:45 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 148D3C0051
 for <iommu@lists.linux-foundation.org>; Tue,  3 Nov 2020 10:18:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id E60C920356
 for <iommu@lists.linux-foundation.org>; Tue,  3 Nov 2020 10:18:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yN-LRgYWSE+c for <iommu@lists.linux-foundation.org>;
 Tue,  3 Nov 2020 10:18:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 by silver.osuosl.org (Postfix) with ESMTPS id 116511FE65
 for <iommu@lists.linux-foundation.org>; Tue,  3 Nov 2020 10:18:42 +0000 (UTC)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A3AFORP061916;
 Tue, 3 Nov 2020 10:18:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=zOidJXdDr5yFSszqrc639ikquFWilMC8k+q0faz6Gkg=;
 b=0U2QI6skG/hCQ28b3a7kx5bbRJfM1uSTMVWbKPXajn54OEK77ftBvjtBD0QWEPemy608
 zcvAxETvrYH9sK+/gmMwQz+9AU40X3BOkzDf7v9JorToxbgdbE0nsTOg/9QIqy/Colv1
 G5/r203Btyi3JEhcLU5klElu5+FZTYDAXJT6KtOTvQpqMSBT+pJFgFV3uqnCB2cS6Oe2
 MEkpgtTfc5j4ycUaawJo1cwxaG3cHRBuEmkhTjTNXmMTM4FeOXvNJSHM1CPs2QJJl8LY
 HcqHE6G+SgvomHqv1HlW3JDd+1i/NsfDNluqJ4yriKzS3CvsSv1DcePoab5Go/E+OMzK ZA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 34hhvc8fmb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 03 Nov 2020 10:18:34 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A3AEfUm054369;
 Tue, 3 Nov 2020 10:16:33 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3020.oracle.com with ESMTP id 34hw0dapxt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Nov 2020 10:16:33 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0A3AGVWn028740;
 Tue, 3 Nov 2020 10:16:31 GMT
Received: from mwanda (/41.57.98.10) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 03 Nov 2020 02:16:30 -0800
Date: Tue, 3 Nov 2020 13:16:23 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Joerg Roedel <joro@8bytes.org>, Jacob Pan <jacob.pan.linux@gmail.com>
Subject: [PATCH] iommu: fix a check in iommu_check_bind_data()
Message-ID: <20201103101623.GA1127762@mwanda>
MIME-Version: 1.0
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9793
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999
 phishscore=0 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011030068
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9793
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=999
 bulkscore=0 phishscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011030068
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 iommu@lists.linux-foundation.org, kernel-janitors@vger.kernel.org
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

The "data->flags" variable is a u64 so if one of the high 32 bits is
set the original code will allow it, but it should be rejected.  The
fix is to declare "mask" as a u64 instead of a u32.

Fixes: d90573812eea ("iommu/uapi: Handle data and argsz filled by users")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/iommu/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 8c470f451a32..b53446bb8c6b 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2071,7 +2071,7 @@ EXPORT_SYMBOL_GPL(iommu_uapi_cache_invalidate);
 
 static int iommu_check_bind_data(struct iommu_gpasid_bind_data *data)
 {
-	u32 mask;
+	u64 mask;
 	int i;
 
 	if (data->version != IOMMU_GPASID_BIND_VERSION_1)
-- 
2.28.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
