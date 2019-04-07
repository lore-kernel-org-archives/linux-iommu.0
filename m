Return-Path: <SRS0=ZMNw=SJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD8D0C282DD
	for <iommu@archiver.kernel.org>; Sun,  7 Apr 2019 12:48:26 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1824218FE
	for <iommu@archiver.kernel.org>; Sun,  7 Apr 2019 12:48:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1824218FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A8931B8E;
	Sun,  7 Apr 2019 12:48:17 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 37F81B50
	for <iommu@lists.linux-foundation.org>;
	Sun,  7 Apr 2019 12:48:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id A58487A6
	for <iommu@lists.linux-foundation.org>;
	Sun,  7 Apr 2019 12:48:15 +0000 (UTC)
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
	by Forcepoint Email with ESMTP id E518EAC886700A348614;
	Sun,  7 Apr 2019 20:48:10 +0800 (CST)
Received: from HGHY1l002753561.china.huawei.com (10.177.23.164) by
	DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server
	id 14.3.408.0; Sun, 7 Apr 2019 20:48:01 +0800
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
Subject: [PATCH v4 2/6] iommu: keep dma mode build options consistent with
	cmdline options
Date: Sun, 7 Apr 2019 20:41:43 +0800
Message-ID: <20190407124147.13576-3-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.19.2.windows.1
In-Reply-To: <20190407124147.13576-1-thunder.leizhen@huawei.com>
References: <20190407124147.13576-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.177.23.164]
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

First, add build option IOMMU_DMA_MODE_LAZY, so that we have the
opportunity to set lazy mode as default at build time. Then put the
three config options in an choice, make people can only choose one of the
three at a time, the same to the boot options iommu.dma_mode.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/Kconfig | 30 +++++++++++++++++++++++++++---
 drivers/iommu/iommu.c |  4 +++-
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index b67fcabd668f7b6..19118cfdea1c335 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -74,16 +74,40 @@ config IOMMU_DEBUGFS
 	  debug/iommu directory, and then populate a subdirectory with
 	  entries as required.
 
-config IOMMU_DEFAULT_PASSTHROUGH
-	bool "IOMMU passthrough by default"
+choice
+	prompt "IOMMU dma mode"
 	depends on IOMMU_API
+	default IOMMU_DMA_MODE_STRICT
+	help
+	  IOMMU dma mode, such as: passthrough, lazy, strict.
+
+config IOMMU_DMA_MODE_PASSTHROUGH
+	bool "Configure DMA to bypass the IOMMU"
         help
 	  Enable passthrough by default, removing the need to pass in
 	  iommu.dma_mode=passthrough or iommu=pt through command line. If this
 	  is enabled, you can still disable with iommu.dma_mode={lazy|strict}
 	  or iommu=nopt depending on the architecture.
 
-	  If unsure, say N here.
+config IOMMU_DMA_MODE_LAZY
+	bool "IOMMU DMA use lazy mode to flush IOTLB and free IOVA"
+	help
+	  Support lazy mode, where for every IOMMU DMA unmap operation, the
+	  flush operation of IOTLB and the free operation of IOVA are deferred.
+	  They are only guaranteed to be done before the related IOVA will be
+	  reused. Removing the need to pass in kernel parameters through
+	  command line. For example, iommu.dma_mode=lazy on ARM64. If this is
+	  enabled, you can still disable with kernel parameters, such as
+	  iommu.dma_mode=strict depending on the architecture.
+
+config IOMMU_DMA_MODE_STRICT
+	bool "IOMMU DMA use strict mode to flush IOTLB and free IOVA"
+	help
+	  For every IOMMU DMA unmap operation, the flush operation of IOTLB and
+	  the free operation of IOVA are guaranteed to be done in the unmap
+	  function.
+
+endchoice
 
 config OF_IOMMU
        def_bool y
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index e4d581e6cb8d210..b75e23a2ea08da8 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -39,8 +39,10 @@
 static struct kset *iommu_group_kset;
 static DEFINE_IDA(iommu_group_ida);
 
-#ifdef CONFIG_IOMMU_DEFAULT_PASSTHROUGH
+#if defined(CONFIG_IOMMU_DMA_MODE_PASSTHROUGH)
 #define IOMMU_DEFAULT_DMA_MODE		IOMMU_DMA_MODE_PASSTHROUGH
+#elif defined(CONFIG_IOMMU_DMA_MODE_LAZY)
+#define IOMMU_DEFAULT_DMA_MODE		IOMMU_DMA_MODE_LAZY
 #else
 #define IOMMU_DEFAULT_DMA_MODE		IOMMU_DMA_MODE_STRICT
 #endif
-- 
1.8.3


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
