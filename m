Return-Path: <SRS0=gtiV=HF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 837D1C433E6
	for <iommu@archiver.kernel.org>; Wed,  3 Feb 2021 20:57:41 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17A6264F9B
	for <iommu@archiver.kernel.org>; Wed,  3 Feb 2021 20:57:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17A6264F9B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id D98EF86B03;
	Wed,  3 Feb 2021 20:57:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fQgQg5wGyYDp; Wed,  3 Feb 2021 20:57:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B2E3986B71;
	Wed,  3 Feb 2021 20:57:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9FA67C1834;
	Wed,  3 Feb 2021 20:57:35 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CBFD2C013A
 for <iommu@lists.linux-foundation.org>; Wed,  3 Feb 2021 20:57:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id C76E0871CF
 for <iommu@lists.linux-foundation.org>; Wed,  3 Feb 2021 20:57:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Rs7IeLUZWjT9 for <iommu@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 20:57:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by hemlock.osuosl.org (Postfix) with ESMTPS id E65D7871B2
 for <iommu@lists.linux-foundation.org>; Wed,  3 Feb 2021 20:57:31 +0000 (UTC)
IronPort-SDR: hqi9LVvY4lTLgCXb4chwQFE8RgHX3pG/0ilPFxb8tS5yc03nDOv4Syj2a/vy1R8Crd9gs1jS+4
 oJ0KUzOBQfLg==
X-IronPort-AV: E=McAfee;i="6000,8403,9884"; a="160875319"
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; d="scan'208";a="160875319"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Feb 2021 12:57:31 -0800
IronPort-SDR: G3Slvai/j9HhtC7F3TgFBs5ouMaKBSpqdfeBf6+JEg0o30xilyMw1L8grccIH4csUS1oJnnYCn
 60kXa5ZMaZFA==
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; d="scan'208";a="372510587"
Received: from megha-z97x-ud7-th.sc.intel.com ([143.183.85.154])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA;
 03 Feb 2021 12:57:31 -0800
From: Megha Dey <megha.dey@intel.com>
To: tglx@linutronix.de
Subject: [PATCH 10/12] iommu: Add capability IOMMU_CAP_VIOMMU_HINT
Date: Wed,  3 Feb 2021 12:56:43 -0800
Message-Id: <1612385805-3412-11-git-send-email-megha.dey@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612385805-3412-1-git-send-email-megha.dey@intel.com>
References: <1612385805-3412-1-git-send-email-megha.dey@intel.com>
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

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Megha Dey <megha.dey@intel.com>
---
 drivers/iommu/amd/iommu.c    |  2 ++
 drivers/iommu/intel/iommu.c  | 20 ++++++++++++++++++++
 drivers/iommu/virtio-iommu.c |  9 +++++++++
 include/linux/iommu.h        |  2 ++
 4 files changed, 33 insertions(+)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index f0adbc4..a851f37 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2646,6 +2646,8 @@ static bool amd_iommu_capable(enum iommu_cap cap)
 		return (irq_remapping_enabled == 1);
 	case IOMMU_CAP_NOEXEC:
 		return false;
+	case IOMMU_CAP_VIOMMU_HINT:
+		return amd_iommu_np_cache;
 	default:
 		break;
 	}
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 06b00b5..905d6aa 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -5094,12 +5094,32 @@ static inline bool nested_mode_support(void)
 	return ret;
 }
 
+static inline bool caching_mode_supported(void)
+{
+	struct dmar_drhd_unit *drhd;
+	struct intel_iommu *iommu;
+	bool ret = false;
+
+	rcu_read_lock();
+	for_each_active_iommu(iommu, drhd) {
+		if (cap_caching_mode(iommu->cap)) {
+			ret = true;
+			break;
+		}
+	}
+	rcu_read_unlock();
+
+	return ret;
+}
+
 static bool intel_iommu_capable(enum iommu_cap cap)
 {
 	if (cap == IOMMU_CAP_CACHE_COHERENCY)
 		return domain_update_iommu_snooping(NULL) == 1;
 	if (cap == IOMMU_CAP_INTR_REMAP)
 		return irq_remapping_enabled == 1;
+	if (cap == IOMMU_CAP_VIOMMU_HINT)
+		return caching_mode_supported();
 
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
index b3f0e20..5e62bcc 100644
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
