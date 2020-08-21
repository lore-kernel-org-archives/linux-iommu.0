Return-Path: <SRS0=6E3Y=B7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75815C433E1
	for <iommu@archiver.kernel.org>; Fri, 21 Aug 2020 16:18:25 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A8AE22D04
	for <iommu@archiver.kernel.org>; Fri, 21 Aug 2020 16:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dcnYdR+5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A8AE22D04
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 162A82048D;
	Fri, 21 Aug 2020 16:18:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Wdxt-lcpyBZs; Fri, 21 Aug 2020 16:18:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 43ED720398;
	Fri, 21 Aug 2020 16:18:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 24358C07FF;
	Fri, 21 Aug 2020 16:18:24 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A7BC9C0051
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 16:18:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id A1132886BB
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 16:18:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RWj-k8OxqD1U for <iommu@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 16:18:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id B8EDC884F0
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 16:18:21 +0000 (UTC)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CEFDA22B4E;
 Fri, 21 Aug 2020 16:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598026701;
 bh=7E3ARa3gGjKsJ3XyQWjqb1t8KY5M1C2PdcSqkYpDFG0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dcnYdR+5w3YSy/D3PcGWrrPmk1med6fCZJGirB860MVh3X5CZhL7RtnLPjbVzaZ3D
 MLrNlRryI2paqWnGNqGbA9+G7W4ReMcVbZX4rNSZrjCMLNXnFC23t0p/br88dzpkMt
 QJMvaOLa0c6jpq4GC8/zbqxszPjY2755AlH3usqY=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 11/38] iommu/iova: Don't BUG on invalid PFNs
Date: Fri, 21 Aug 2020 12:17:40 -0400
Message-Id: <20200821161807.348600-11-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821161807.348600-1-sashal@kernel.org>
References: <20200821161807.348600-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Cc: Sasha Levin <sashal@kernel.org>, iommu@lists.linux-foundation.org,
 Joerg Roedel <jroedel@suse.de>, Robin Murphy <robin.murphy@arm.com>,
 Prakash Gupta <guptap@codeaurora.org>
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

From: Robin Murphy <robin.murphy@arm.com>

[ Upstream commit d3e3d2be688b4b5864538de61e750721a311e4fc ]

Unlike the other instances which represent a complete loss of
consistency within the rcache mechanism itself, or a fundamental
and obvious misconfiguration by an IOMMU driver, the BUG_ON() in
iova_magazine_free_pfns() can be provoked at more or less any time
in a "spooky action-at-a-distance" manner by any old device driver
passing nonsense to dma_unmap_*() which then propagates through to
queue_iova().

Not only is this well outside the IOVA layer's control, it's also
nowhere near fatal enough to justify panicking anyway - all that
really achieves is to make debugging the offending driver more
difficult. Let's simply WARN and otherwise ignore bogus PFNs.

Reported-by: Prakash Gupta <guptap@codeaurora.org>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Prakash Gupta <guptap@codeaurora.org>
Link: https://lore.kernel.org/r/acbd2d092b42738a03a21b417ce64e27f8c91c86.1591103298.git.robin.murphy@arm.com
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/iova.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 34c058c24b9d2..ce5cd05253db9 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -814,7 +814,9 @@ iova_magazine_free_pfns(struct iova_magazine *mag, struct iova_domain *iovad)
 	for (i = 0 ; i < mag->size; ++i) {
 		struct iova *iova = private_find_iova(iovad, mag->pfns[i]);
 
-		BUG_ON(!iova);
+		if (WARN_ON(!iova))
+			continue;
+
 		private_free_iova(iovad, iova);
 	}
 
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
