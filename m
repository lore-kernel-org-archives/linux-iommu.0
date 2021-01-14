Return-Path: <SRS0=IUlV=GR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED245C433E0
	for <iommu@archiver.kernel.org>; Thu, 14 Jan 2021 01:38:34 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AEE823435
	for <iommu@archiver.kernel.org>; Thu, 14 Jan 2021 01:38:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AEE823435
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0D7CC86B76;
	Thu, 14 Jan 2021 01:38:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0jaHfE-WWw7T; Thu, 14 Jan 2021 01:38:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id AE55886B74;
	Thu, 14 Jan 2021 01:38:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9AF2CC0893;
	Thu, 14 Jan 2021 01:38:32 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 03AE3C013A
 for <iommu@lists.linux-foundation.org>; Thu, 14 Jan 2021 01:38:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id DF40787321
 for <iommu@lists.linux-foundation.org>; Thu, 14 Jan 2021 01:38:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CA8iOdEZiQh5 for <iommu@lists.linux-foundation.org>;
 Thu, 14 Jan 2021 01:38:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 39F488731B
 for <iommu@lists.linux-foundation.org>; Thu, 14 Jan 2021 01:38:30 +0000 (UTC)
IronPort-SDR: nCe53kHcn4CMVSUrEHHUC1OXoHakVu6FK9tFNfo4mENqEViIkEnmLMVqXmhZDH9mrfK+mM30KQ
 MVBcC6UKSq5g==
X-IronPort-AV: E=McAfee;i="6000,8403,9863"; a="165382230"
X-IronPort-AV: E=Sophos;i="5.79,345,1602572400"; d="scan'208";a="165382230"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jan 2021 17:38:24 -0800
IronPort-SDR: pn1dl9IBHiG0ZLke/ddfHTH+J+J3s550xpbrnvKnzRL+7+3/XUH1L9nveDzCPWCvl1SxaA/1R9
 Wyo+suoELB9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,345,1602572400"; d="scan'208";a="569582521"
Received: from allen-box.sh.intel.com ([10.239.159.28])
 by fmsmga006.fm.intel.com with ESMTP; 13 Jan 2021 17:38:18 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: tglx@linutronix.de, ashok.raj@intel.com, kevin.tian@intel.com,
 dave.jiang@intel.com, megha.dey@intel.com, dwmw2@infradead.org
Subject: [RFC PATCH v3 1/2] iommu: Add capability IOMMU_CAP_VIOMMU
Date: Thu, 14 Jan 2021 09:30:02 +0800
Message-Id: <20210114013003.297050-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210114013003.297050-1-baolu.lu@linux.intel.com>
References: <20210114013003.297050-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: kvm@vger.kernel.org, rafael@kernel.org, linux-pci@vger.kernel.org,
 sanjay.k.kumar@intel.com, linux-kernel@vger.kernel.org, bhelgaas@google.com,
 kwankhede@nvidia.com, will@kernel.org, leon@kernel.org, netanelg@mellanox.com,
 maz@kernel.org, vkoul@kernel.org, jgg@mellanox.com, yan.y.zhao@linux.intel.com,
 shahafs@mellanox.com, parav@mellanox.com, alex.williamson@redhat.com,
 samuel.ortiz@intel.com, dan.j.williams@intel.com, tony.luck@intel.com,
 mona.hossain@intel.com, iommu@lists.linux-foundation.org,
 jacob.jun.pan@intel.com, dmaengine@vger.kernel.org, pbonzini@redhat.com
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

Some vendor IOMMU drivers are able to declare that it is running in a VM
context. This is very valuable for the features that only want to be
supported on bare metal. Add a capability bit so that it could be used.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c  | 20 ++++++++++++++++++++
 drivers/iommu/virtio-iommu.c |  9 +++++++++
 include/linux/iommu.h        |  1 +
 3 files changed, 30 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index cb205a04fe4c..8eb022d0e8aa 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -5738,12 +5738,32 @@ static inline bool nested_mode_support(void)
 	return ret;
 }
 
+static inline bool caching_mode_enabled(void)
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
+	if (cap == IOMMU_CAP_VIOMMU)
+		return caching_mode_enabled();
 
 	return false;
 }
diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 2bfdd5734844..719793e103db 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -931,7 +931,16 @@ static int viommu_of_xlate(struct device *dev, struct of_phandle_args *args)
 	return iommu_fwspec_add_ids(dev, args->args, 1);
 }
 
+static bool viommu_capable(enum iommu_cap cap)
+{
+	if (cap == IOMMU_CAP_VIOMMU)
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
index b95a6f8db6ff..1d24be667a03 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -94,6 +94,7 @@ enum iommu_cap {
 					   transactions */
 	IOMMU_CAP_INTR_REMAP,		/* IOMMU supports interrupt isolation */
 	IOMMU_CAP_NOEXEC,		/* IOMMU_NOEXEC flag */
+	IOMMU_CAP_VIOMMU,		/* IOMMU can declar running in a VM */
 };
 
 /*
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
