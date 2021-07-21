Return-Path: <SRS0=85So=MN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D390FC636CA
	for <iommu@archiver.kernel.org>; Wed, 21 Jul 2021 18:21:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0E0161264
	for <iommu@archiver.kernel.org>; Wed, 21 Jul 2021 18:21:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0E0161264
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7E8CA608CF;
	Wed, 21 Jul 2021 18:21:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ACyc-oUkOpZ7; Wed, 21 Jul 2021 18:21:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5C7A6608CA;
	Wed, 21 Jul 2021 18:21:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 31AA3C0010;
	Wed, 21 Jul 2021 18:21:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D6399C000E
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 18:21:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BF36C40575
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 18:21:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jAB6F2f2H7t8 for <iommu@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 18:21:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id DEC7040362
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 18:21:18 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A3F411FB;
 Wed, 21 Jul 2021 11:21:18 -0700 (PDT)
Received: from 010265703453.arm.com (unknown [10.57.36.146])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EC58A3F694;
 Wed, 21 Jul 2021 11:21:16 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Subject: [PATCH 19/23] iommu: Expose DMA domain strictness via sysfs
Date: Wed, 21 Jul 2021 19:20:30 +0100
Message-Id: <fb1dc51d19772284f357bf5603d8f150ff857b41.1626888445.git.robin.murphy@arm.com>
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

The sysfs interface for default domain types exists primarily so users
can choose the performance/security tradeoff relevant to their own
workload. As such, the choice between the policies for DMA domains fits
perfectly as an additional point on that scale - downgrading a
particular device from a strict default to non-strict may be enough to
let it reach the desired level of performance, while still retaining
more peace of mind than with a wide-open identity domain. Now that we've
abstracted non-strict mode as a distinct type of DMA domain, allow it to
be chosen through the user interface as well.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 Documentation/ABI/testing/sysfs-kernel-iommu_groups | 2 ++
 drivers/iommu/iommu.c                               | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-iommu_groups b/Documentation/ABI/testing/sysfs-kernel-iommu_groups
index eae2f1c1e11e..43ba764ba5b7 100644
--- a/Documentation/ABI/testing/sysfs-kernel-iommu_groups
+++ b/Documentation/ABI/testing/sysfs-kernel-iommu_groups
@@ -42,6 +42,8 @@ Description:	/sys/kernel/iommu_groups/<grp_id>/type shows the type of default
 		========  ======================================================
 		DMA       All the DMA transactions from the device in this group
 		          are translated by the iommu.
+		DMA-FQ    As above, but using batched invalidation to lazily
+		          remove translations after use.
 		identity  All the DMA transactions from the device in this group
 		          are not translated by the iommu.
 		auto      Change to the type the device was booted with.
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index d7eaacae0944..d3b562a33ac4 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3195,6 +3195,8 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
 		req_type = IOMMU_DOMAIN_IDENTITY;
 	else if (sysfs_streq(buf, "DMA"))
 		req_type = IOMMU_DOMAIN_DMA;
+	else if (sysfs_streq(buf, "DMA-FQ"))
+		req_type = IOMMU_DOMAIN_DMA_FQ;
 	else if (sysfs_streq(buf, "auto"))
 		req_type = 0;
 	else
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
