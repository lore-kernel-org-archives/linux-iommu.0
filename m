Return-Path: <SRS0=CXUA=H4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4AD9C4332B
	for <iommu@archiver.kernel.org>; Fri, 26 Feb 2021 20:11:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A0BC64F40
	for <iommu@archiver.kernel.org>; Fri, 26 Feb 2021 20:11:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A0BC64F40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D9CEF6F9C0;
	Fri, 26 Feb 2021 20:11:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id a6G5-y9kpq9d; Fri, 26 Feb 2021 20:11:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id A11AE6F9BE;
	Fri, 26 Feb 2021 20:11:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DA52DC0017;
	Fri, 26 Feb 2021 20:11:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B8622C0013
 for <iommu@lists.linux-foundation.org>; Fri, 26 Feb 2021 20:11:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9BAC54F0A7
 for <iommu@lists.linux-foundation.org>; Fri, 26 Feb 2021 20:11:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PWZehSgfOuDy for <iommu@lists.linux-foundation.org>;
 Fri, 26 Feb 2021 20:11:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7135D4A053
 for <iommu@lists.linux-foundation.org>; Fri, 26 Feb 2021 20:11:15 +0000 (UTC)
IronPort-SDR: Rd86kw2Ix7+zD/cX3ItxfK/zAgywGNKnr6xkObiymg1AWeBN+oTU9ZSZjtLggPKNFzIU4+BOJr
 nOBsa1IwsGTg==
X-IronPort-AV: E=McAfee;i="6000,8403,9907"; a="186039452"
X-IronPort-AV: E=Sophos;i="5.81,209,1610438400"; d="scan'208";a="186039452"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2021 12:11:14 -0800
IronPort-SDR: Yo/KNtvXneOxHD6NG7HH8FE9wVW+KzGpM+KyH432qTshqa1T8Sq2664sNn9RpZibK33r8a5KZX
 ELNvHeW965Rw==
X-IronPort-AV: E=Sophos;i="5.81,209,1610438400"; d="scan'208";a="405109452"
Received: from megha-z97x-ud7-th.sc.intel.com ([143.183.85.154])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA;
 26 Feb 2021 12:11:14 -0800
From: Megha Dey <megha.dey@intel.com>
To: tglx@linutronix.de
Subject: [Patch V2 10/13] iommu: Add capability IOMMU_CAP_VIOMMU_HINT
Date: Fri, 26 Feb 2021 12:11:14 -0800
Message-Id: <1614370277-23235-11-git-send-email-megha.dey@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1614370277-23235-1-git-send-email-megha.dey@intel.com>
References: <1614370277-23235-1-git-send-email-megha.dey@intel.com>
Cc: alex.williamson@redhat.com, kevin.tian@intel.com, tony.luck@intel.com,
 dave.jiang@intel.com, ashok.raj@intel.com, kvm@vger.kernel.org,
 ravi.v.shankar@intel.com, maz@kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 jgg@mellanox.com, megha.dey@intel.com, linux-pci@vger.kernel.org,
 bhelgaas@google.com, dan.j.williams@intel.com, dwmw@amazon.co.uk
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Lu Baolu <baolu.lu@linux.intel.com>

Some IOMMU specification defines some kind of hint mechanism, through
which BIOS can imply that OS runs in a virtualized environment. For
example, the caching mode defined in VT-d spec and NpCache capability
defined in the AMD IOMMU specification. This hint could also be used
outside of the IOMMU subsystem, where it could be used with other known
means (CPUID, smbios) to sense whether Linux is running in a virtualized
environment. Add a capability bit so that it could be used there.

Cc: Joerg Roedel <joro@8bytes.org>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Megha Dey <megha.dey@intel.com>
---
 drivers/iommu/amd/iommu.c    | 2 ++
 drivers/iommu/intel/iommu.c  | 5 +++++
 drivers/iommu/virtio-iommu.c | 9 +++++++++
 include/linux/iommu.h        | 2 ++
 4 files changed, 18 insertions(+)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index a69a8b5..a912318 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2140,6 +2140,8 @@ static bool amd_iommu_capable(enum iommu_cap cap)
 		return (irq_remapping_enabled == 1);
 	case IOMMU_CAP_NOEXEC:
 		return false;
+	case IOMMU_CAP_VIOMMU_HINT:
+		return amd_iommu_np_cache;
 	default:
 		break;
 	}
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index ee09323..55fa198 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -294,6 +294,7 @@ static inline void context_clear_entry(struct context_entry *context)
  */
 static struct dmar_domain *si_domain;
 static int hw_pass_through = 1;
+static int intel_caching_mode;
 
 #define for_each_domain_iommu(idx, domain)			\
 	for (idx = 0; idx < g_num_of_iommus; idx++)		\
@@ -3253,6 +3254,8 @@ static int __init init_dmars(void)
 
 		if (!ecap_pass_through(iommu->ecap))
 			hw_pass_through = 0;
+		if (cap_caching_mode(iommu->cap))
+			intel_caching_mode = 1;
 		intel_svm_check(iommu);
 	}
 
@@ -5113,6 +5116,8 @@ static bool intel_iommu_capable(enum iommu_cap cap)
 		return domain_update_iommu_snooping(NULL) == 1;
 	if (cap == IOMMU_CAP_INTR_REMAP)
 		return irq_remapping_enabled == 1;
+	if (cap == IOMMU_CAP_VIOMMU_HINT)
+		return intel_caching_mode;
 
 	return false;
 }
diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 2bfdd57..e4941ca 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -931,7 +931,16 @@ static int viommu_of_xlate(struct device *dev, struct of_phandle_args *args)
 	return iommu_fwspec_add_ids(dev, args->args, 1);
 }
 
+static bool viommu_capable(enum iommu_cap cap)
+{
+	if (cap == IOMMU_CAP_VIOMMU_HINT)
+		return true;
+
+	return false;
+}
+
 static struct iommu_ops viommu_ops = {
+	.capable		= viommu_capable,
 	.domain_alloc		= viommu_domain_alloc,
 	.domain_free		= viommu_domain_free,
 	.attach_dev		= viommu_attach_dev,
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 5e7fe51..9d0ade4 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -94,6 +94,8 @@ enum iommu_cap {
 					   transactions */
 	IOMMU_CAP_INTR_REMAP,		/* IOMMU supports interrupt isolation */
 	IOMMU_CAP_NOEXEC,		/* IOMMU_NOEXEC flag */
+	IOMMU_CAP_VIOMMU_HINT,		/* IOMMU can detect a hit for running in
+					   VM */
 };
 
 /*
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
