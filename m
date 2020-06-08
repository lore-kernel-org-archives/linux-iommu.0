Return-Path: <SRS0=28v9=7V=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLACK,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFA8C433E0
	for <iommu@archiver.kernel.org>; Mon,  8 Jun 2020 23:14:45 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65EB820C09
	for <iommu@archiver.kernel.org>; Mon,  8 Jun 2020 23:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wzB7TxfK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65EB820C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4722E87799;
	Mon,  8 Jun 2020 23:14:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RGMbllSPGW7L; Mon,  8 Jun 2020 23:14:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id D18E981AE4;
	Mon,  8 Jun 2020 23:14:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B8E7BC0863;
	Mon,  8 Jun 2020 23:14:44 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2A6C7C016F
 for <iommu@lists.linux-foundation.org>; Mon,  8 Jun 2020 23:14:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 256F6221F0
 for <iommu@lists.linux-foundation.org>; Mon,  8 Jun 2020 23:14:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UuTbD9SIsqvy for <iommu@lists.linux-foundation.org>;
 Mon,  8 Jun 2020 23:14:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 71FCC21509
 for <iommu@lists.linux-foundation.org>; Mon,  8 Jun 2020 23:14:43 +0000 (UTC)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9FFED21556;
 Mon,  8 Jun 2020 23:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1591658083;
 bh=WPj0jjv6Ts+fStz7KcOL0WNWp4wINcRRJV6yd0QuEiA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=wzB7TxfKI9MloeHyVgxEH04y/ygCU7MEYTa5EYDiik3afwLlHKvV2cAW16hPduKOd
 uMD76W7oLHlhFDzjFm9AEsfR9CNXnNtqIfd2tzP4Y5ceBEIkgdfI+szIBhP4T5OYWw
 +MEwEagakI2rg6Ca22DEPX/q2VY/Pc5ophOYKPWY=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 127/606] iommu/amd: Do not loop forever when
 trying to increase address space
Date: Mon,  8 Jun 2020 19:04:12 -0400
Message-Id: <20200608231211.3363633-127-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231211.3363633-1-sashal@kernel.org>
References: <20200608231211.3363633-1-sashal@kernel.org>
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

From: Joerg Roedel <jroedel@suse.de>

[ Upstream commit 5b8a9a047b6cad361405c7900c1e1cdd378c4589 ]

When increase_address_space() fails to allocate memory, alloc_pte()
will call it again until it succeeds. Do not loop forever while trying
to increase the address space and just return an error instead.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Tested-by: Qian Cai <cai@lca.pw>
Link: https://lore.kernel.org/r/20200504125413.16798-3-joro@8bytes.org
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/amd_iommu.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 1d8634250afc..18c995a16d80 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1500,8 +1500,19 @@ static u64 *alloc_pte(struct protection_domain *domain,
 	amd_iommu_domain_get_pgtable(domain, &pgtable);
 
 	while (address > PM_LEVEL_SIZE(pgtable.mode)) {
-		*updated = increase_address_space(domain, address, gfp) || *updated;
+		bool upd = increase_address_space(domain, address, gfp);
+
+		/* Read new values to check if update was successful */
 		amd_iommu_domain_get_pgtable(domain, &pgtable);
+
+		/*
+		 * Return an error if there is no memory to update the
+		 * page-table.
+		 */
+		if (!upd && (address > PM_LEVEL_SIZE(pgtable.mode)))
+			return NULL;
+
+		*updated = *updated || upd;
 	}
 
 
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
