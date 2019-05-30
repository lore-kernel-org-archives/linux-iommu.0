Return-Path: <SRS0=ZfVm=T6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 471C8C072B1
	for <iommu@archiver.kernel.org>; Thu, 30 May 2019 03:57:55 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26F052428D
	for <iommu@archiver.kernel.org>; Thu, 30 May 2019 03:57:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26F052428D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 683B8309F;
	Thu, 30 May 2019 03:57:37 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 6C3C43070
	for <iommu@lists.linux-foundation.org>;
	Thu, 30 May 2019 03:49:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id D9D1E6C5
	for <iommu@lists.linux-foundation.org>;
	Thu, 30 May 2019 03:49:24 +0000 (UTC)
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
	by Forcepoint Email with ESMTP id DB4C41F0F32B9FF7AF5D;
	Thu, 30 May 2019 11:49:22 +0800 (CST)
Received: from HGHY4L002753561.china.huawei.com (10.133.215.186) by
	DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server
	id 14.3.439.0; Thu, 30 May 2019 11:49:12 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, John Garry
	<john.garry@huawei.com>, Robin Murphy <robin.murphy@arm.com>, Will Deacon
	<will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>, Jonathan Corbet
	<corbet@lwn.net>, linux-doc <linux-doc@vger.kernel.org>, Sebastian Ott
	<sebott@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>,
	"Martin Schwidefsky" <schwidefsky@de.ibm.com>, Heiko Carstens
	<heiko.carstens@de.ibm.com>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, "Michael
	Ellerman" <mpe@ellerman.id.au>, Tony Luck <tony.luck@intel.com>, Fenghua Yu
	<fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin"
	<hpa@zytor.com>, David Woodhouse <dwmw2@infradead.org>, iommu
	<iommu@lists.linux-foundation.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, x86 <x86@kernel.org>,
	linux-ia64 <linux-ia64@vger.kernel.org>
Subject: [PATCH v8 1/7] iommu: enhance IOMMU default DMA mode build options
Date: Thu, 30 May 2019 11:48:25 +0800
Message-ID: <20190530034831.4184-2-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20190530034831.4184-1-thunder.leizhen@huawei.com>
References: <20190530034831.4184-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.133.215.186]
X-CFilter-Loop: Reflected
Cc: Hanjun Guo <guohanjun@huawei.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

First, add build option IOMMU_DEFAULT_{LAZY|STRICT}, so that we have the
opportunity to set {lazy|strict} mode as default at build time. Then put
the three config options in an choice, make people can only choose one of
the three at a time.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/Kconfig | 42 +++++++++++++++++++++++++++++++++++-------
 drivers/iommu/iommu.c |  3 ++-
 2 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 83664db5221df02..d6a1a45f80ffbf5 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -75,17 +75,45 @@ config IOMMU_DEBUGFS
 	  debug/iommu directory, and then populate a subdirectory with
 	  entries as required.
 
-config IOMMU_DEFAULT_PASSTHROUGH
-	bool "IOMMU passthrough by default"
+choice
+	prompt "IOMMU default DMA mode"
 	depends on IOMMU_API
-        help
-	  Enable passthrough by default, removing the need to pass in
-	  iommu.passthrough=on or iommu=pt through command line. If this
-	  is enabled, you can still disable with iommu.passthrough=off
-	  or iommu=nopt depending on the architecture.
+	default IOMMU_DEFAULT_STRICT
+	help
+	  This option allows IOMMU DMA mode to be chose at build time, to
+	  override the default DMA mode of each ARCHs, removing the need to
+	  pass in kernel parameters through command line. You can still use
+	  ARCHs specific boot options to override this option again.
+
+config IOMMU_DEFAULT_PASSTHROUGH
+	bool "passthrough"
+	help
+	  In this mode, the DMA access through IOMMU without any addresses
+	  translation. That means, the wrong or illegal DMA access can not
+	  be caught, no error information will be reported.
 
 	  If unsure, say N here.
 
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
+	  This mode is safer than the two above, but it maybe slower in some
+	  high performace scenarios.
+
+endchoice
+
 config OF_IOMMU
        def_bool y
        depends on OF && IOMMU_API
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 67ee6623f9b2a4d..56bce221285b15f 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -43,7 +43,8 @@
 #else
 static unsigned int iommu_def_domain_type = IOMMU_DOMAIN_DMA;
 #endif
-static bool iommu_dma_strict __read_mostly = true;
+static bool iommu_dma_strict __read_mostly =
+			IS_ENABLED(CONFIG_IOMMU_DEFAULT_STRICT);
 
 struct iommu_group {
 	struct kobject kobj;
-- 
1.8.3


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
