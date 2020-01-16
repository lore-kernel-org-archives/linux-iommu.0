Return-Path: <SRS0=QvS0=3F=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 505F0C33CAF
	for <iommu@archiver.kernel.org>; Thu, 16 Jan 2020 17:08:11 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 264E324653
	for <iommu@archiver.kernel.org>; Thu, 16 Jan 2020 17:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1amk1Up1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 264E324653
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id C70EC86AE5;
	Thu, 16 Jan 2020 17:08:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Lt0ocstE96b5; Thu, 16 Jan 2020 17:08:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id CB56486B3C;
	Thu, 16 Jan 2020 17:08:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B8996C1D82;
	Thu, 16 Jan 2020 17:08:06 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B4297C077D
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jan 2020 17:08:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id AFE7C1FD43
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jan 2020 17:08:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vYpOUPY9fkLD for <iommu@lists.linux-foundation.org>;
 Thu, 16 Jan 2020 17:08:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 38C011FEDF
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jan 2020 17:08:00 +0000 (UTC)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6508320730;
 Thu, 16 Jan 2020 17:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1579194480;
 bh=Cbm9NWmK9mpFfahIoT9+kEcREyTJA5wATb0Y07W3Zkk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=1amk1Up1ZlD5lGMay8KOGF7FaTOYx/oWRtCCUDs6qXxEy0JxLoE5WafijHyv3Xj36
 o5/Sc0XfRuhSYNJUh84geaGxugZl98PkwBS2UQE6j1eSLh+o07BcoQCnFMCuEdLD1V
 trFq2ihjnhg2PtiomnEXO7WdIFRN2BuQ7HDL28OQ=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 382/671] iommu: Use right function to get group
 for device
Date: Thu, 16 Jan 2020 12:00:20 -0500
Message-Id: <20200116170509.12787-119-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116170509.12787-1-sashal@kernel.org>
References: <20200116170509.12787-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Cc: Sasha Levin <sashal@kernel.org>, iommu@lists.linux-foundation.org,
 Joerg Roedel <jroedel@suse.de>
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

From: Lu Baolu <baolu.lu@linux.intel.com>

[ Upstream commit 57274ea25736496ee019a5c40479855b21888839 ]

The iommu_group_get_for_dev() will allocate a group for a
device if it isn't in any group. This isn't the use case
in iommu_request_dm_for_dev(). Let's use iommu_group_get()
instead.

Fixes: d290f1e70d85a ("iommu: Introduce iommu_request_dm_for_dev()")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/iommu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index d588b6844f5f..3d69c8205c52 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1899,9 +1899,9 @@ int iommu_request_dm_for_dev(struct device *dev)
 	int ret;
 
 	/* Device must already be in a group before calling this function */
-	group = iommu_group_get_for_dev(dev);
-	if (IS_ERR(group))
-		return PTR_ERR(group);
+	group = iommu_group_get(dev);
+	if (!group)
+		return -EINVAL;
 
 	mutex_lock(&group->mutex);
 
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
