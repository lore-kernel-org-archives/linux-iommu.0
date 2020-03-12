Return-Path: <SRS0=xT8t=45=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A942C10DCE
	for <iommu@archiver.kernel.org>; Thu, 12 Mar 2020 11:38:59 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 514232071B
	for <iommu@archiver.kernel.org>; Thu, 12 Mar 2020 11:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DDAvu0Y0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 514232071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 227DB87727;
	Thu, 12 Mar 2020 11:38:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VbZn4X-7S3al; Thu, 12 Mar 2020 11:38:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7AD808776A;
	Thu, 12 Mar 2020 11:38:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 64C0DC18D3;
	Thu, 12 Mar 2020 11:38:58 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 942E2C0177
 for <iommu@lists.linux-foundation.org>; Thu, 12 Mar 2020 11:38:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 8FE498853D
 for <iommu@lists.linux-foundation.org>; Thu, 12 Mar 2020 11:38:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RVtsH8H9aQIi for <iommu@lists.linux-foundation.org>;
 Thu, 12 Mar 2020 11:38:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 by hemlock.osuosl.org (Postfix) with ESMTPS id DD53588534
 for <iommu@lists.linux-foundation.org>; Thu, 12 Mar 2020 11:38:55 +0000 (UTC)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02CBWddV162866;
 Thu, 12 Mar 2020 11:37:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=iGXT7eu1hSl8BMZGeJVU++wfkK6X8r1GtDze0h7kfsw=;
 b=DDAvu0Y01jqlT9TTqzlLwPQW2mRJgw+/cZcBMqBEltRl8YAPhOdatmfQVAZUChDu9EUr
 MIZdGYmw3uWJexp0GwCes45p4yHqZxD7mtCYlGf2Z3LFEXlZ076X+iyXqNAtrcmNwfqG
 Ar/WPapFj8+fybSu49OUo+qhFR0/yEdxK+9+XTcCssKy5wOr0OEvvcksHghg3oZ1pY+2
 dr2Ftr1/Jy/FCtlTbv6KVOzWIvloWEw4gh1sO5pAqW2hYgyFR+/5uJeHPTFeUgDHl1jm
 mFLjDFCP6kwy2qZnW3C2sOGPg+QwUJHNhyD58Ew4CDFcLCBvB+vdzNOZTBwKTl2eEK54 1g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 2ym31us2n7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Mar 2020 11:37:44 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02CBbDZq138691;
 Thu, 12 Mar 2020 11:37:43 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3020.oracle.com with ESMTP id 2yp8p72epn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Mar 2020 11:37:43 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02CBbeAg008328;
 Thu, 12 Mar 2020 11:37:40 GMT
Received: from mwanda (/41.57.98.10) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 12 Mar 2020 04:37:39 -0700
Date: Thu, 12 Mar 2020 14:37:30 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: David Woodhouse <dwmw2@infradead.org>,
 Megha Dey <megha.dey@linux.intel.com>
Subject: [PATCH] iommu/vt-d: Unlock on error paths
Message-ID: <20200312113730.GF20562@mwanda>
MIME-Version: 1.0
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9557
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 phishscore=0
 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003120064
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9557
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 lowpriorityscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003120063
Cc: kernel-janitors@vger.kernel.org, iommu@lists.linux-foundation.org
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

There were a couple places where we need to unlock before returning.

Fixes: 91391b919e19 ("iommu/vt-d: Populate debugfs if IOMMUs are detected")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/iommu/intel-iommu-debugfs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel-iommu-debugfs.c b/drivers/iommu/intel-iommu-debugfs.c
index 8d24c4d85cc2..6a495b103972 100644
--- a/drivers/iommu/intel-iommu-debugfs.c
+++ b/drivers/iommu/intel-iommu-debugfs.c
@@ -289,11 +289,12 @@ static int dmar_translation_struct_show(struct seq_file *m, void *unused)
 		sts = dmar_readl(iommu->reg + DMAR_GSTS_REG);
 		if (!(sts & DMA_GSTS_TES)) {
 			seq_puts(m, "DMA Remapping is not enabled\n");
-			return 0;
+			goto unlock;
 		}
 		root_tbl_walk(m, iommu);
 		seq_putc(m, '\n');
 	}
+unlock:
 	rcu_read_unlock();
 
 	return 0;
@@ -444,7 +445,7 @@ static int ir_translation_struct_show(struct seq_file *m, void *unused)
 		sts = dmar_readl(iommu->reg + DMAR_GSTS_REG);
 		if (!(sts & DMA_GSTS_IRES)) {
 			seq_puts(m, "Interrupt Remapping is not enabled\n");
-			return 0;
+			goto unlock;
 		}
 
 		if (iommu->ir_table) {
@@ -475,6 +476,7 @@ static int ir_translation_struct_show(struct seq_file *m, void *unused)
 		}
 		seq_putc(m, '\n');
 	}
+unlock:
 	rcu_read_unlock();
 
 	return 0;
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
