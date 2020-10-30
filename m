Return-Path: <SRS0=LARK=EF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7620C6369E
	for <iommu@archiver.kernel.org>; Fri, 30 Oct 2020 05:05:16 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5874E221FF
	for <iommu@archiver.kernel.org>; Fri, 30 Oct 2020 05:05:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5874E221FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 4319A22E6E;
	Fri, 30 Oct 2020 05:05:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9bM1jXvDqhtx; Fri, 30 Oct 2020 05:05:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 561F92037B;
	Fri, 30 Oct 2020 05:05:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 36AEAC0859;
	Fri, 30 Oct 2020 05:05:13 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 56C8DC0051
 for <iommu@lists.linux-foundation.org>; Fri, 30 Oct 2020 05:05:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 322D6228D1
 for <iommu@lists.linux-foundation.org>; Fri, 30 Oct 2020 05:05:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vDI1cDPFWhrx for <iommu@lists.linux-foundation.org>;
 Fri, 30 Oct 2020 05:05:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by silver.osuosl.org (Postfix) with ESMTPS id 7D7F1228B4
 for <iommu@lists.linux-foundation.org>; Fri, 30 Oct 2020 05:05:10 +0000 (UTC)
IronPort-SDR: eUqnYEfEylMaRSkr63BNzO1FDamx9opCy6kLEcf4b2qF13py22pbtT9dMKDJCs857gpEG5U8DU
 A3xDZ37G9DrQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9789"; a="253268375"
X-IronPort-AV: E=Sophos;i="5.77,432,1596524400"; d="scan'208";a="253268375"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2020 22:05:08 -0700
IronPort-SDR: DBvYloqtZm7ZhjV0oDjwAGVxl8PMUs3l2Umcf5zMlwrfkQTu6eWd9tYUYj/E9GzsYU7VVH7G8V
 uo/wGP6DpSDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,432,1596524400"; d="scan'208";a="425261534"
Received: from allen-box.sh.intel.com ([10.239.159.139])
 by fmsmga001.fm.intel.com with ESMTP; 29 Oct 2020 22:05:04 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH v6 1/5] vfio/mdev: Register mdev bus earlier during boot
Date: Fri, 30 Oct 2020 12:58:05 +0800
Message-Id: <20201030045809.957927-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201030045809.957927-1-baolu.lu@linux.intel.com>
References: <20201030045809.957927-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Kevin Tian <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, kvm@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>
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

Move mdev bus registration earlier than IOMMU probe processing so that
the IOMMU drivers could be able to set iommu_ops for the mdev bus. This
only applies when vfio-mdev module is setected to be built-in.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/vfio/mdev/mdev_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/vfio/mdev/mdev_core.c b/drivers/vfio/mdev/mdev_core.c
index b558d4cfd082..6b9ab71f89e7 100644
--- a/drivers/vfio/mdev/mdev_core.c
+++ b/drivers/vfio/mdev/mdev_core.c
@@ -417,8 +417,12 @@ static void __exit mdev_exit(void)
 	mdev_bus_unregister();
 }
 
+#if IS_BUILTIN(CONFIG_VFIO_MDEV)
+postcore_initcall(mdev_init)
+#else
 module_init(mdev_init)
 module_exit(mdev_exit)
+#endif /* IS_BUILTIN(CONFIG_VFIO_MDEV) */
 
 MODULE_VERSION(DRIVER_VERSION);
 MODULE_LICENSE("GPL v2");
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
