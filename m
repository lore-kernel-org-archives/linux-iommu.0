Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 885B2CCA480
	for <iommu@archiver.kernel.org>; Sat, 25 Jun 2022 12:56:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 40D4883F61;
	Sat, 25 Jun 2022 12:56:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 40D4883F61
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=etJULT9I
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1Q-pSe0Jue9H; Sat, 25 Jun 2022 12:56:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0DF1883F67;
	Sat, 25 Jun 2022 12:56:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0DF1883F67
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DDE92C0032;
	Sat, 25 Jun 2022 12:56:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74613C002D
 for <iommu@lists.linux-foundation.org>; Sat, 25 Jun 2022 12:56:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4038E60F29
 for <iommu@lists.linux-foundation.org>; Sat, 25 Jun 2022 12:56:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4038E60F29
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=etJULT9I
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MJSsacMocdjn for <iommu@lists.linux-foundation.org>;
 Sat, 25 Jun 2022 12:56:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AD6C460C20
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AD6C460C20
 for <iommu@lists.linux-foundation.org>; Sat, 25 Jun 2022 12:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1656161802; x=1687697802;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=K1A1BNwT+8Hbe6On1W0+Qd4OG/bxND97giqef+O4iOE=;
 b=etJULT9Imf7c78iqJDbBaoGforgTtyqYIoSrb0AlFsRjVIlUPJqC+QLO
 Rc/sdZ/YCOijdHXlfzxcnimFe+oxwPP6XqF++JmEO7khR5b7DlCJ45THV
 ugv01U5NWIC5nZ84Omet4TFAouzgh45SyfLydEEv0HVHfYp4jV0D/39V3
 dJtzShdJCrhjmKdnSAi1NiZwbZMx0tYuQ6zbUuUY4lFwOgZIvSUMhNAo3
 WSHF9a6RWE+xbZ4veJOxKYeAHioMpTX/Ujpv+WuH8rmUJXbVkLgKmEzR2
 yanz7csg3kL3GQfNph3QbTTInwfss0jf+0c1uNgP5B65mJbXOz0lGVxHs w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10388"; a="278727984"
X-IronPort-AV: E=Sophos;i="5.92,222,1650956400"; d="scan'208";a="278727984"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2022 05:56:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,222,1650956400"; d="scan'208";a="586890393"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by orsmga007.jf.intel.com with ESMTP; 25 Jun 2022 05:56:39 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Steve Wahl <steve.wahl@hpe.com>,
 Kevin Tian <kevin.tian@intel.com>
Subject: [PATCH v1 4/6] iommu/vt-d: Add VTD_FLAG_IOMMU_PROBED flag
Date: Sat, 25 Jun 2022 20:52:02 +0800
Message-Id: <20220625125204.2199437-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220625125204.2199437-1-baolu.lu@linux.intel.com>
References: <20220625125204.2199437-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: Dimitri Sivanich <sivanich@hpe.com>, Russ Anderson <russ.anderson@hpe.com>,
 Mike Travis <mike.travis@hpe.com>, Jerry Snitselaar <jsnitsel@redhat.com>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, David Woodhouse <dwmw2@infradead.org>
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

In the IOMMU hot-add path, there's a need to check whether an IOMMU
has been probed. Instead of checking the IOMMU pointer in the global
list, it's better to allocate a flag bit in iommu->flags for this
purpose.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.h | 1 +
 drivers/iommu/intel/iommu.c | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 56c3d1a9e155..105a1e7c60d9 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -479,6 +479,7 @@ enum {
 #define VTD_FLAG_TRANS_PRE_ENABLED	(1 << 0)
 #define VTD_FLAG_IRQ_REMAP_PRE_ENABLED	(1 << 1)
 #define VTD_FLAG_SVM_CAPABLE		(1 << 2)
+#define VTD_FLAG_IOMMU_PROBED		(1 << 3)
 
 extern int intel_iommu_sm;
 
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 78b26fef685e..f6d7055cffd7 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1695,6 +1695,7 @@ static void free_dmar_iommu(struct intel_iommu *iommu)
 	}
 
 	g_iommus[iommu->seq_id] = NULL;
+	iommu->flags &= ~VTD_FLAG_IOMMU_PROBED;
 
 	/* free context mapping */
 	free_context_table(iommu);
@@ -2951,6 +2952,7 @@ static int __init init_dmars(void)
 		}
 
 		g_iommus[iommu->seq_id] = iommu;
+		iommu->flags |= VTD_FLAG_IOMMU_PROBED;
 
 		intel_iommu_init_qi(iommu);
 
@@ -3460,7 +3462,7 @@ static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
 	int sp, ret;
 	struct intel_iommu *iommu = dmaru->iommu;
 
-	if (g_iommus[iommu->seq_id])
+	if (iommu->flags & VTD_FLAG_IOMMU_PROBED)
 		return 0;
 
 	ret = intel_cap_audit(CAP_AUDIT_HOTPLUG_DMAR, iommu);
@@ -3487,6 +3489,7 @@ static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
 		iommu_disable_translation(iommu);
 
 	g_iommus[iommu->seq_id] = iommu;
+	iommu->flags |= VTD_FLAG_IOMMU_PROBED;
 	ret = iommu_init_domains(iommu);
 	if (ret == 0)
 		ret = iommu_alloc_root_entry(iommu);
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
