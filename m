Return-Path: <SRS0=69++=LC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 980BBC4743E
	for <iommu@archiver.kernel.org>; Tue,  8 Jun 2021 13:23:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 279C16128D
	for <iommu@archiver.kernel.org>; Tue,  8 Jun 2021 13:23:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 279C16128D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E26EE4045F;
	Tue,  8 Jun 2021 13:23:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J-rBl2zpcVFD; Tue,  8 Jun 2021 13:23:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 760F840448;
	Tue,  8 Jun 2021 13:23:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 031EDC0024;
	Tue,  8 Jun 2021 13:23:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6DE42C0001
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 13:22:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5D31B400EB
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 13:22:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id awsUQKv4w1-b for <iommu@lists.linux-foundation.org>;
 Tue,  8 Jun 2021 13:22:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5FC3F400E7
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 13:22:58 +0000 (UTC)
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.206])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FzrKG0ljGz6H6xs;
 Tue,  8 Jun 2021 21:13:38 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 15:22:56 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 14:22:52 +0100
From: John Garry <john.garry@huawei.com>
To: <joro@8bytes.org>, <will@kernel.org>, <dwmw2@infradead.org>,
 <baolu.lu@linux.intel.com>, <robin.murphy@arm.com>
Subject: [PATCH v11 1/3] iommu: Enhance IOMMU default DMA mode build options
Date: Tue, 8 Jun 2021 21:18:26 +0800
Message-ID: <1623158308-180604-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1623158308-180604-1-git-send-email-john.garry@huawei.com>
References: <1623158308-180604-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: rdunlap@infradead.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com,
 iommu@lists.linux-foundation.org
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

From: Zhen Lei <thunder.leizhen@huawei.com>

First, add build options IOMMU_DEFAULT_{LAZY|STRICT}, so that we have the
opportunity to set {lazy|strict} mode as default at build time. Then put
the two config options in a choice, as they are mutually exclusive.

[jpg: Make choice between strict and lazy only (and not passthrough)]
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/iommu/Kconfig | 35 +++++++++++++++++++++++++++++++++++
 drivers/iommu/iommu.c |  3 ++-
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 1f111b399bca..369a3af9e5bf 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -90,6 +90,41 @@ config IOMMU_DEFAULT_PASSTHROUGH
 
 	  If unsure, say N here.
 
+choice
+	prompt "IOMMU default DMA mode"
+	depends on IOMMU_API
+	depends on X86 || IA64 || X86_64 || ARM || ARM64
+
+	default IOMMU_DEFAULT_STRICT
+	help
+	  This option allows an IOMMU DMA mode to be chosen at build time, to
+	  override the default DMA mode of each ARCH, removing the need to
+	  pass in kernel parameters through command line. It is still possible
+	  to provide ARCH-specific or common boot options to override this
+	  option.
+
+	  If unsure, keep the default.
+
+config IOMMU_DEFAULT_LAZY
+	bool "lazy"
+	help
+	  Support lazy mode, where for every IOMMU DMA unmap operation, the
+	  flush operation of IOTLB and the free operation of IOVA are deferred.
+	  They are only guaranteed to be done before the related IOVA will be
+	  reused.
+
+config IOMMU_DEFAULT_STRICT
+	bool "strict"
+	help
+	  For every IOMMU DMA unmap operation, the flush operation of IOTLB and
+	  the free operation of IOVA are guaranteed to be done in the unmap
+	  function.
+
+	  This mode is safer than lazy mode, but it may be slower in some high
+	  performance scenarios.
+
+endchoice
+
 config OF_IOMMU
 	def_bool y
 	depends on OF && IOMMU_API
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 966426a96520..177b0dafc535 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -29,7 +29,8 @@ static struct kset *iommu_group_kset;
 static DEFINE_IDA(iommu_group_ida);
 
 static unsigned int iommu_def_domain_type __read_mostly;
-static bool iommu_dma_strict __read_mostly = true;
+static bool iommu_dma_strict __read_mostly =
+			IS_ENABLED(CONFIG_IOMMU_DEFAULT_STRICT);
 static u32 iommu_cmd_line __read_mostly;
 
 struct iommu_group {
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
