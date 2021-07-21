Return-Path: <SRS0=85So=MN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6071DC636CA
	for <iommu@archiver.kernel.org>; Wed, 21 Jul 2021 18:21:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E676611C1
	for <iommu@archiver.kernel.org>; Wed, 21 Jul 2021 18:21:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E676611C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 101E540518;
	Wed, 21 Jul 2021 18:21:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qQzAgN2zlreb; Wed, 21 Jul 2021 18:21:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0141240522;
	Wed, 21 Jul 2021 18:21:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 90F19C0023;
	Wed, 21 Jul 2021 18:21:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 77299C000E
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 18:21:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 54D96608C1
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 18:21:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KCHuGabYJO15 for <iommu@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 18:21:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id AEC58608B6
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 18:21:13 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4452111FB;
 Wed, 21 Jul 2021 11:21:13 -0700 (PDT)
Received: from 010265703453.arm.com (unknown [10.57.36.146])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C87973F694;
 Wed, 21 Jul 2021 11:21:11 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Subject: [PATCH 16/23] iommu/arm-smmu: Prepare for multiple DMA domain types
Date: Wed, 21 Jul 2021 19:20:27 +0100
Message-Id: <04220b3420c2c513490450f37de109182364f235.1626888445.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1626888444.git.robin.murphy@arm.com>
References: <cover.1626888444.git.robin.murphy@arm.com>
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, dianders@chromium.org,
 iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
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

In preparation for the strict vs. non-strict decision for DMA domains to
be expressed in the domain type, make sure we expose our flush queue
awareness by accepting the new domain type, and test the specific
feature flag where we want to identify DMA domains in general.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 1 +
 drivers/iommu/arm/arm-smmu/arm-smmu.c       | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 039f371d2f8b..fa41026d272e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1972,6 +1972,7 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 
 	if (type != IOMMU_DOMAIN_UNMANAGED &&
 	    type != IOMMU_DOMAIN_DMA &&
+	    type != IOMMU_DOMAIN_DMA_FQ &&
 	    type != IOMMU_DOMAIN_IDENTITY)
 		return NULL;
 
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 354be8f4c0ef..dbc14c265b15 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -870,10 +870,11 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 
 	if (type != IOMMU_DOMAIN_UNMANAGED &&
 	    type != IOMMU_DOMAIN_DMA &&
+	    type != IOMMU_DOMAIN_DMA_FQ &&
 	    type != IOMMU_DOMAIN_IDENTITY)
 		return NULL;
 
-	if (type == IOMMU_DOMAIN_DMA && using_legacy_binding)
+	if ((type & __IOMMU_DOMAIN_DMA_API) && using_legacy_binding)
 		return NULL;
 	/*
 	 * Allocate the domain and initialise some of its data structures.
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
