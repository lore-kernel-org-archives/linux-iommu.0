Return-Path: <SRS0=L2Qy=CE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CB2C433E5
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 10:50:48 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 645D620866
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 10:50:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 645D620866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4B515869EC;
	Wed, 26 Aug 2020 10:50:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ABVBZl4bF6Mk; Wed, 26 Aug 2020 10:50:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 45E9786A36;
	Wed, 26 Aug 2020 10:50:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 30E7AC0890;
	Wed, 26 Aug 2020 10:50:45 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E6B56C0051
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 10:50:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id D463086978
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 10:50:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QtGEckU4Bc3f for <iommu@lists.linux-foundation.org>;
 Wed, 26 Aug 2020 10:50:43 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from ZXSHCAS2.zhaoxin.com (unknown [203.148.12.82])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 2EB5C869F6
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 10:50:43 +0000 (UTC)
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHCAS2.zhaoxin.com
 (10.28.252.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 26 Aug
 2020 18:50:38 +0800
Received: from localhost.localdomain (61.148.243.98) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 26 Aug
 2020 18:50:36 +0800
From: FelixCuioc <FelixCui-oc@zhaoxin.com>
To: Joerg Roedel <joro@8bytes.org>, <iommu@lists.linux-foundation.org>,
 <linux-kernel@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, "Lu
 Baolu" <baolu.lu@linux.intel.com>, Dan Carpenter <dan.carpenter@oracle.com>,
 <kbuild@lists.01.org>
Subject: [PATCH v2 3/3] iommu/vt-d:Add mutex_unlock() before returning
Date: Wed, 26 Aug 2020 06:50:25 -0400
Message-ID: <20200826105025.3912-4-FelixCui-oc@zhaoxin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200826105025.3912-1-FelixCui-oc@zhaoxin.com>
References: <20200826105025.3912-1-FelixCui-oc@zhaoxin.com>
MIME-Version: 1.0
X-Originating-IP: [61.148.243.98]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
Cc: TonyWWang-oc@zhaoxin.com, kbuild-all@lists.01.org, CobeChen-oc@zhaoxin.com
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

In the probe_acpi_namespace_devices function,when the physical
node of the acpi device is NULL,the unlock function is missing.
Add mutex_unlock(&adev->physical_node_lock).

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: FelixCuioc <FelixCui-oc@zhaoxin.com>
---
 drivers/iommu/intel/iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index b31f02f41c96..25e9853cba1b 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4851,6 +4851,7 @@ static int __init probe_acpi_namespace_devices(void)
 			if (pn_dev == NULL) {
 				dev->bus->iommu_ops = &intel_iommu_ops;
 				ret = iommu_probe_device(dev);
+				mutex_unlock(&adev->physical_node_lock);
 				if (ret) {
 					pr_err("acpi_device probe fail! ret:%d\n", ret);
 					return ret;
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
