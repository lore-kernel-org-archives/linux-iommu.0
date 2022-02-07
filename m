Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 424B7C433F5
	for <iommu@archiver.kernel.org>; Mon,  7 Feb 2022 23:04:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5558381258;
	Mon,  7 Feb 2022 23:04:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Wn3zTYJRy4xH; Mon,  7 Feb 2022 23:03:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 073E381777;
	Mon,  7 Feb 2022 23:03:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E3876C0077;
	Mon,  7 Feb 2022 23:03:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 12B9AC0073
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 23:03:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 994A180B91
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 23:03:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Xh_rpZl6LKvX for <iommu@lists.linux-foundation.org>;
 Mon,  7 Feb 2022 23:03:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D521080BA2
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 23:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644275029; x=1675811029;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Zzuc+4BUhDw8AYLm9O80nUHIQ9qam3U/ceY5Tn4nhdA=;
 b=ZiTHVo+2xKFCRTroxBf39vbmfUIpoauUzFH7+iCHOXSS21mVFCyUsLKo
 zvNTVhdD9Ko1a0HjpzyRQ8dOJqIE9vtdmWExWRl1i2S5syB2tUoRXGXPh
 VBJ7SXnUMFrfvW8IqaKow0vSscF4WCn1KprA1mO2wVvo1tZIPZArvd6On
 a+hb3UU9/lMMtoLSnYwJ+Qq03K5pJas6aoONzbPdPEnUxqoI1nXj6CAVA
 Uv7kQmNJwH7nhxs+4ZAh2/eq9eYfaxVy47Sqsz8r7H1WKU24w6WCrfCVO
 J6/fpUPPaXKVifDjTpnGln3ltgR3JXTBL0AWe7iVyprKEo3z1DkZivx6t g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="248774751"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; d="scan'208";a="248774751"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2022 15:03:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; d="scan'208";a="540324005"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
 by orsmga008.jf.intel.com with ESMTP; 07 Feb 2022 15:03:01 -0800
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Thomas Gleixner" <tglx@linutronix.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Andy Lutomirski" <luto@kernel.org>, "Tony Luck" <tony.luck@intel.com>,
 "Lu Baolu" <baolu.lu@linux.intel.com>, "Joerg Roedel" <joro@8bytes.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>,
 "Jacob Pan" <jacob.jun.pan@linux.intel.com>,
 "Ashok Raj" <ashok.raj@intel.com>,
 "Ravi V Shankar" <ravi.v.shankar@intel.com>
Subject: [PATCH v4 01/11] iommu/sva: Rename CONFIG_IOMMU_SVA_LIB to
 CONFIG_IOMMU_SVA
Date: Mon,  7 Feb 2022 15:02:44 -0800
Message-Id: <20220207230254.3342514-2-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220207230254.3342514-1-fenghua.yu@intel.com>
References: <20220207230254.3342514-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Cc: Fenghua Yu <fenghua.yu@intel.com>, iommu@lists.linux-foundation.org,
 x86 <x86@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
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

This CONFIG option originally only referred to the Shared
Virtual Address (SVA) library. But it is now also used for
non-library portions of code.

Drop the "_LIB" suffix so that there is just one configuration
options for all code relating to SVA.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
---
v4:
- Add "Reviewed-by: Thomas Gleixner <tglx@linutronix.de>" (Thomas).

v2:
- Add this patch for more meaningful name CONFIG_IOMMU_SVA

 drivers/iommu/Kconfig         | 6 +++---
 drivers/iommu/Makefile        | 2 +-
 drivers/iommu/intel/Kconfig   | 2 +-
 drivers/iommu/iommu-sva-lib.h | 6 +++---
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 3eb68fa1b8cc..c79a0df090c0 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -144,8 +144,8 @@ config IOMMU_DMA
 	select IRQ_MSI_IOMMU
 	select NEED_SG_DMA_LENGTH
 
-# Shared Virtual Addressing library
-config IOMMU_SVA_LIB
+# Shared Virtual Addressing
+config IOMMU_SVA
 	bool
 	select IOASID
 
@@ -379,7 +379,7 @@ config ARM_SMMU_V3
 config ARM_SMMU_V3_SVA
 	bool "Shared Virtual Addressing support for the ARM SMMUv3"
 	depends on ARM_SMMU_V3
-	select IOMMU_SVA_LIB
+	select IOMMU_SVA
 	select MMU_NOTIFIER
 	help
 	  Support for sharing process address spaces with devices using the
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index bc7f730edbb0..44475a9b3eea 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -27,6 +27,6 @@ obj-$(CONFIG_FSL_PAMU) += fsl_pamu.o fsl_pamu_domain.o
 obj-$(CONFIG_S390_IOMMU) += s390-iommu.o
 obj-$(CONFIG_HYPERV_IOMMU) += hyperv-iommu.o
 obj-$(CONFIG_VIRTIO_IOMMU) += virtio-iommu.o
-obj-$(CONFIG_IOMMU_SVA_LIB) += iommu-sva-lib.o io-pgfault.o
+obj-$(CONFIG_IOMMU_SVA) += iommu-sva-lib.o io-pgfault.o
 obj-$(CONFIG_SPRD_IOMMU) += sprd-iommu.o
 obj-$(CONFIG_APPLE_DART) += apple-dart.o
diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
index 247d0f2d5fdf..39a06d245f12 100644
--- a/drivers/iommu/intel/Kconfig
+++ b/drivers/iommu/intel/Kconfig
@@ -52,7 +52,7 @@ config INTEL_IOMMU_SVM
 	select PCI_PRI
 	select MMU_NOTIFIER
 	select IOASID
-	select IOMMU_SVA_LIB
+	select IOMMU_SVA
 	help
 	  Shared Virtual Memory (SVM) provides a facility for devices
 	  to access DMA resources through process address space by
diff --git a/drivers/iommu/iommu-sva-lib.h b/drivers/iommu/iommu-sva-lib.h
index 031155010ca8..95dc3ebc1928 100644
--- a/drivers/iommu/iommu-sva-lib.h
+++ b/drivers/iommu/iommu-sva-lib.h
@@ -17,7 +17,7 @@ struct device;
 struct iommu_fault;
 struct iopf_queue;
 
-#ifdef CONFIG_IOMMU_SVA_LIB
+#ifdef CONFIG_IOMMU_SVA
 int iommu_queue_iopf(struct iommu_fault *fault, void *cookie);
 
 int iopf_queue_add_device(struct iopf_queue *queue, struct device *dev);
@@ -28,7 +28,7 @@ struct iopf_queue *iopf_queue_alloc(const char *name);
 void iopf_queue_free(struct iopf_queue *queue);
 int iopf_queue_discard_partial(struct iopf_queue *queue);
 
-#else /* CONFIG_IOMMU_SVA_LIB */
+#else /* CONFIG_IOMMU_SVA */
 static inline int iommu_queue_iopf(struct iommu_fault *fault, void *cookie)
 {
 	return -ENODEV;
@@ -64,5 +64,5 @@ static inline int iopf_queue_discard_partial(struct iopf_queue *queue)
 {
 	return -ENODEV;
 }
-#endif /* CONFIG_IOMMU_SVA_LIB */
+#endif /* CONFIG_IOMMU_SVA */
 #endif /* _IOMMU_SVA_LIB_H */
-- 
2.35.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
