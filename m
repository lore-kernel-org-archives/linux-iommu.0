Return-Path: <SRS0=PBOI=OA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F557C4332F
	for <iommu@archiver.kernel.org>; Fri, 10 Sep 2021 00:16:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 474D861209
	for <iommu@archiver.kernel.org>; Fri, 10 Sep 2021 00:16:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 474D861209
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2208384A68;
	Fri, 10 Sep 2021 00:16:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7NnRZz6mqD2T; Fri, 10 Sep 2021 00:16:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 14B2184A66;
	Fri, 10 Sep 2021 00:16:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E58F4C0011;
	Fri, 10 Sep 2021 00:16:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9BCECC000D
 for <iommu@lists.linux-foundation.org>; Fri, 10 Sep 2021 00:16:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7DDCE4064C
 for <iommu@lists.linux-foundation.org>; Fri, 10 Sep 2021 00:16:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F75PObdk7udR for <iommu@lists.linux-foundation.org>;
 Fri, 10 Sep 2021 00:16:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CB54740635
 for <iommu@lists.linux-foundation.org>; Fri, 10 Sep 2021 00:16:55 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id C0FBF61208;
 Fri, 10 Sep 2021 00:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631233015;
 bh=RNf9vEr2uufGpxXa4wgnVK85ccOPTtxswSIhBYi6TL0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=MGEfuDDFD1woLTNlTMd9HuJZCEv2cEHDtmoHWSNeNgTvNcO+CneKyr9iYoTrXYDKu
 uTMIKbTVPieY/UW8tC68CyHVtVvFFPGyvflR36NRcyNJ5p0hPNGWUR05Ih10yAIj0D
 hcha768wtoJ9egEhnJO+YnlXwT1fyWZ/5g+1yHxi2fWTA+bAXWdX0KPXclZDAMQxZW
 3dRjqzBajWZ9huOimjpUZ9UK1eJFIJhYA9/BjOBufGhj1Hoooz852Hcwx+0bvB2iIY
 5y6Z2+9pcWK6mqthF5r2MqeZO7kRKTDQrpkP3Okrq8msW/tZZuQ8Iy9FOmDCMtftlh
 13+lt7v78uquA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.14 41/99] iommu: Fix race condition during default
 domain allocation
Date: Thu,  9 Sep 2021 20:15:00 -0400
Message-Id: <20210910001558.173296-41-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210910001558.173296-1-sashal@kernel.org>
References: <20210910001558.173296-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Cc: Sasha Levin <sashal@kernel.org>, Will Deacon <will@kernel.org>,
 iommu@lists.linux-foundation.org, Ashish Mhetre <amhetre@nvidia.com>
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

From: Ashish Mhetre <amhetre@nvidia.com>

[ Upstream commit 211ff31b3d33b56aa12937e898c9280d07daf0d9 ]

When two devices with same SID are getting probed concurrently through
iommu_probe_device(), the iommu_domain sometimes is getting allocated more
than once as call to iommu_alloc_default_domain() is not protected for
concurrency. Furthermore, it leads to each device holding a different
iommu_domain pointer, separate IOVA space and only one of the devices'
domain is used for translations from IOMMU. This causes accesses from other
device to fault or see incorrect translations.
Fix this by protecting iommu_alloc_default_domain() call with group->mutex
and let all devices with same SID share same iommu_domain.

Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
Link: https://lore.kernel.org/r/1628570641-9127-2-git-send-email-amhetre@nvidia.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/iommu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 63f0af10c403..3050cc4b02bc 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -273,7 +273,9 @@ int iommu_probe_device(struct device *dev)
 	 * support default domains, so the return value is not yet
 	 * checked.
 	 */
+	mutex_lock(&group->mutex);
 	iommu_alloc_default_domain(group, dev);
+	mutex_unlock(&group->mutex);
 
 	if (group->default_domain) {
 		ret = __iommu_attach_device(group->default_domain, dev);
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
