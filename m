Return-Path: <SRS0=4dp6=E3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F33DC388F9
	for <iommu@archiver.kernel.org>; Sat, 21 Nov 2020 14:04:09 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48F2F2224A
	for <iommu@archiver.kernel.org>; Sat, 21 Nov 2020 14:04:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48F2F2224A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id E6FD086DDB;
	Sat, 21 Nov 2020 14:04:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9WnRFN4LYchg; Sat, 21 Nov 2020 14:04:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 598DE86CC8;
	Sat, 21 Nov 2020 14:04:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2ADF7C163C;
	Sat, 21 Nov 2020 14:04:06 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 33B21C0891
 for <iommu@lists.linux-foundation.org>; Sat, 21 Nov 2020 14:04:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 235208743B
 for <iommu@lists.linux-foundation.org>; Sat, 21 Nov 2020 14:04:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eRf3US6ku1fz for <iommu@lists.linux-foundation.org>;
 Sat, 21 Nov 2020 14:04:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 4D23E87428
 for <iommu@lists.linux-foundation.org>; Sat, 21 Nov 2020 14:04:04 +0000 (UTC)
IronPort-SDR: kcMl8lFdrVPZA0yhrFYYnPXgyToiOTo19z9QptfW5fOwGV8YI4Lv5zA1cB7m4vJN87fJGUAgwn
 xttVNcfXamjA==
X-IronPort-AV: E=McAfee;i="6000,8403,9811"; a="168083756"
X-IronPort-AV: E=Sophos;i="5.78,359,1599548400"; d="scan'208";a="168083756"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2020 06:04:04 -0800
IronPort-SDR: Htr7dIdTkCCmrt54Sfjf8HyJUM/SB6y5awS91fjn9aUkHny5ZYAJcxPOlBMTHFVJp8BLGWCV9G
 v/uvB5eBBMGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,359,1599548400"; d="scan'208";a="431852780"
Received: from allen-box.sh.intel.com ([10.239.159.28])
 by fmsmga001.fm.intel.com with ESMTP; 21 Nov 2020 06:04:01 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v9 3/4] iommu: Take lock before reading iommu group default
 domain type
Date: Sat, 21 Nov 2020 21:56:19 +0800
Message-Id: <20201121135620.3496419-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201121135620.3496419-1-baolu.lu@linux.intel.com>
References: <20201121135620.3496419-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: Ashok Raj <ashok.raj@intel.com>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org,
 Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>
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

From: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>

"/sys/kernel/iommu_groups/<grp_id>/type" file could be read to find out the
default domain type of an iommu group. The default domain of an iommu group
doesn't change after booting and hence could be read directly. But,
after addding support to dynamically change iommu group default domain, the
above assumption no longer stays valid.

iommu group default domain type could be changed at any time by writing to
"/sys/kernel/iommu_groups/<grp_id>/type". So, take group mutex before
reading iommu group default domain type so that the user wouldn't see stale
values or iommu_group_show_type() doesn't try to derefernce stale pointers.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Sohil Mehta <sohil.mehta@intel.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 716bd602b0ed..aad465c38067 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -501,6 +501,7 @@ static ssize_t iommu_group_show_type(struct iommu_group *group,
 {
 	char *type = "unknown\n";
 
+	mutex_lock(&group->mutex);
 	if (group->default_domain) {
 		switch (group->default_domain->type) {
 		case IOMMU_DOMAIN_BLOCKED:
@@ -517,6 +518,7 @@ static ssize_t iommu_group_show_type(struct iommu_group *group,
 			break;
 		}
 	}
+	mutex_unlock(&group->mutex);
 	strcpy(buf, type);
 
 	return strlen(type);
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
