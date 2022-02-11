Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 470C8C433EF
	for <iommu@archiver.kernel.org>; Fri, 11 Feb 2022 03:07:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D48EC83123;
	Fri, 11 Feb 2022 03:06:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6RSeezAjexDR; Fri, 11 Feb 2022 03:06:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D83F183103;
	Fri, 11 Feb 2022 03:06:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C25FDC0011;
	Fri, 11 Feb 2022 03:06:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 11E63C0039
 for <iommu@lists.linux-foundation.org>; Fri, 11 Feb 2022 03:06:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E4D8E83134
 for <iommu@lists.linux-foundation.org>; Fri, 11 Feb 2022 03:06:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0MkXRaOnH8Kw for <iommu@lists.linux-foundation.org>;
 Fri, 11 Feb 2022 03:06:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4EEAC83103
 for <iommu@lists.linux-foundation.org>; Fri, 11 Feb 2022 03:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644548816; x=1676084816;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=kCYuj8MB7ATRsjZRreWhkD0/omIZjIPw2cvKPR4Oy2o=;
 b=A5q40ln5HxGHkRXUpcSpAZTOeY665L91Ax0PS4yh7NWPvG5QA908P+tb
 mhO1ZStN6UXVMyPxQ2vIawgjJgFwhwMwEq7eVH6z2CkfudWuZaaZllXut
 TNpHSgeGDaOPksgHHVFCWmw4ed4pzSH9HRHmDNMf12sDXnRSj+z5t98gF
 6mziE44EAhSfgYRQtk6uFiaqA45eJ78xQ/7mRIcrLKs9B/8S9Rv2BPu5Z
 w0Fe1VpvnUS7TPezbtid1PbdZSHgkDL7x4OVsllSSnhTV8mv8+QIKmT+G
 gpPmVRWJxCYjAjCKZQmOMdZot+zDmRt2yAo4XgaY1FmHRa7UxS0cnEmAl A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="274202601"
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; d="scan'208";a="274202601"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2022 19:06:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; d="scan'208";a="483062833"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by orsmga003.jf.intel.com with ESMTP; 10 Feb 2022 19:06:53 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: David Airlie <airlied@linux.ie>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Chris Wilson <chris@chris-wilson.co.uk>,
 Nathan Myers <ncm@cantrip.org>
Subject: [PATCH 1/2] agp/intel: Use per device iommu check
Date: Fri, 11 Feb 2022 11:05:30 +0800
Message-Id: <20220211030531.2398789-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220211030531.2398789-1-baolu.lu@linux.intel.com>
References: <20220211030531.2398789-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
 Lucas De Marchi <lucas.demarchi@intel.com>, linux-kernel@vger.kernel.org,
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

The IOMMU subsystem has already provided an interface to query whether
the IOMMU hardware is enabled for a specific device. This changes the
check from Intel specific intel_iommu_gfx_mapped (globally exported by
the Intel IOMMU driver) to probing the presence of IOMMU on a specific
device using the generic device_iommu_mapped().

This follows commit cca084692394a ("drm/i915: Use per device iommu check")
which converted drm/i915 driver to use device_iommu_mapped().

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/char/agp/intel-gtt.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/char/agp/intel-gtt.c b/drivers/char/agp/intel-gtt.c
index c53cc9868cd8..9631cbc7002e 100644
--- a/drivers/char/agp/intel-gtt.c
+++ b/drivers/char/agp/intel-gtt.c
@@ -20,7 +20,7 @@
 #include <linux/kernel.h>
 #include <linux/pagemap.h>
 #include <linux/agp_backend.h>
-#include <linux/intel-iommu.h>
+#include <linux/iommu.h>
 #include <linux/delay.h>
 #include <asm/smp.h>
 #include "agp.h"
@@ -573,18 +573,15 @@ static void intel_gtt_cleanup(void)
  */
 static inline int needs_ilk_vtd_wa(void)
 {
-#ifdef CONFIG_INTEL_IOMMU
 	const unsigned short gpu_devid = intel_private.pcidev->device;
 
-	/* Query intel_iommu to see if we need the workaround. Presumably that
-	 * was loaded first.
+	/*
+	 * Query iommu subsystem to see if we need the workaround. Presumably
+	 * that was loaded first.
 	 */
-	if ((gpu_devid == PCI_DEVICE_ID_INTEL_IRONLAKE_D_IG ||
-	     gpu_devid == PCI_DEVICE_ID_INTEL_IRONLAKE_M_IG) &&
-	     intel_iommu_gfx_mapped)
-		return 1;
-#endif
-	return 0;
+	return ((gpu_devid == PCI_DEVICE_ID_INTEL_IRONLAKE_D_IG ||
+		 gpu_devid == PCI_DEVICE_ID_INTEL_IRONLAKE_M_IG) &&
+		device_iommu_mapped(&intel_private.pcidev->dev));
 }
 
 static bool intel_gtt_can_wc(void)
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
