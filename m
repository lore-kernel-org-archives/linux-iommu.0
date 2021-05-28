Return-Path: <SRS0=hOEw=KX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B056C4708C
	for <iommu@archiver.kernel.org>; Fri, 28 May 2021 13:00:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03D21613E6
	for <iommu@archiver.kernel.org>; Fri, 28 May 2021 13:00:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03D21613E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B58D040E52;
	Fri, 28 May 2021 13:00:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AjN7IJeOhYns; Fri, 28 May 2021 13:00:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id D031640418;
	Fri, 28 May 2021 13:00:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B4755C000E;
	Fri, 28 May 2021 13:00:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 49D9CC0001
 for <iommu@lists.linux-foundation.org>; Fri, 28 May 2021 13:00:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2B52840105
 for <iommu@lists.linux-foundation.org>; Fri, 28 May 2021 13:00:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ey54ZH7R-PL6 for <iommu@lists.linux-foundation.org>;
 Fri, 28 May 2021 13:00:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1AB4F40216
 for <iommu@lists.linux-foundation.org>; Fri, 28 May 2021 13:00:49 +0000 (UTC)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Fs4VM2RNLzYmqd;
 Fri, 28 May 2021 20:58:03 +0800 (CST)
Received: from dggema769-chm.china.huawei.com (10.1.198.211) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 28 May 2021 21:00:43 +0800
Received: from localhost (10.174.179.215) by dggema769-chm.china.huawei.com
 (10.1.198.211) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 28
 May 2021 21:00:43 +0800
From: YueHaibing <yuehaibing@huawei.com>
To: <joro@8bytes.org>, <will@kernel.org>
Subject: [PATCH -next] iommu/amd: use DEVICE_ATTR_RO macro
Date: Fri, 28 May 2021 20:59:51 +0800
Message-ID: <20210528125951.9268-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggema769-chm.china.huawei.com (10.1.198.211)
X-CFilter-Loop: Reflected
Cc: iommu@lists.linux-foundation.org, YueHaibing <yuehaibing@huawei.com>,
 linux-kernel@vger.kernel.org
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

Use DEVICE_ATTR_RO() helper instead of plain DEVICE_ATTR(),
which makes the code a bit shorter and easier to read.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/iommu/amd/init.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index d006724f4dc2..4ffb694bd297 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1731,23 +1731,21 @@ static void init_iommu_perf_ctr(struct amd_iommu *iommu)
 	return;
 }
 
-static ssize_t amd_iommu_show_cap(struct device *dev,
-				  struct device_attribute *attr,
-				  char *buf)
+static ssize_t cap_show(struct device *dev,
+			struct device_attribute *attr, char *buf)
 {
 	struct amd_iommu *iommu = dev_to_amd_iommu(dev);
 	return sprintf(buf, "%x\n", iommu->cap);
 }
-static DEVICE_ATTR(cap, S_IRUGO, amd_iommu_show_cap, NULL);
+static DEVICE_ATTR_RO(cap);
 
-static ssize_t amd_iommu_show_features(struct device *dev,
-				       struct device_attribute *attr,
-				       char *buf)
+static ssize_t features_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
 {
 	struct amd_iommu *iommu = dev_to_amd_iommu(dev);
 	return sprintf(buf, "%llx\n", iommu->features);
 }
-static DEVICE_ATTR(features, S_IRUGO, amd_iommu_show_features, NULL);
+static DEVICE_ATTR_RO(features);
 
 static struct attribute *amd_iommu_attrs[] = {
 	&dev_attr_cap.attr,
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
