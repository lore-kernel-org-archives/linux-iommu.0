Return-Path: <SRS0=7Zqx=JL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D68C433B4
	for <iommu@archiver.kernel.org>; Wed, 14 Apr 2021 20:14:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E16F61177
	for <iommu@archiver.kernel.org>; Wed, 14 Apr 2021 20:14:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E16F61177
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 182866075D;
	Wed, 14 Apr 2021 20:14:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kutd23fQrkri; Wed, 14 Apr 2021 20:13:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5267A605B2;
	Wed, 14 Apr 2021 20:13:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 22F9AC000B;
	Wed, 14 Apr 2021 20:13:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CFB83C000A
 for <iommu@lists.linux-foundation.org>; Wed, 14 Apr 2021 20:13:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CA737402BF
 for <iommu@lists.linux-foundation.org>; Wed, 14 Apr 2021 20:13:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GxFRDjRdhbcz for <iommu@lists.linux-foundation.org>;
 Wed, 14 Apr 2021 20:13:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D45A6402AD
 for <iommu@lists.linux-foundation.org>; Wed, 14 Apr 2021 20:13:54 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id D4FBF61177;
 Wed, 14 Apr 2021 20:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1618431232;
 bh=pjYXcJSJfnY3qBJHkeakI7NfbOgpLhAxUI1E81NIjo8=;
 h=Date:From:To:Cc:Subject:From;
 b=hLv3Ib10bDmBqFSKlEZPpNJezJ0auMwkgvRwCY69qwsJZZrMfYubt9nR3sPB2RdiC
 OD0xYvbOZrb1yyXmE2TV+bRyhSHixzd0RY/Kv86yi6XM+eWC/RnuaYLtB/nHnacIIb
 cMnp8SLoMASnI1D4A5Ry6Dd8WNLwvoqP2RGC2TUD+9n6wjzFJfxbzGlGIcp550/tAZ
 NNejaTj/mykj4n9EZB+bei0FCt4r3QrIMzpV5FXZJ9hVVWlO9h4h8391W0dkQ0yhP1
 afDjvWy6bw4pCeUpnJh6KgJTt19fuKcBy7AO/OpXIOQu8B3NyC5ewUYDNrvkrlvbKi
 ru7dWmfnXZtNA==
Date: Wed, 14 Apr 2021 15:14:03 -0500
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>,
 Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>
Subject: [PATCH v2][next] iommu/vt-d: Fix out-bounds-warning in
 intel_svm_page_response()
Message-ID: <20210414201403.GA392764@embeddedor>
MIME-Version: 1.0
Content-Disposition: inline
Cc: iommu@lists.linux-foundation.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>
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

Replace a couple of calls to memcpy() with simple assignments in order
to fix the following out-of-bounds warning:

drivers/iommu/intel/svm.c:1198:4: warning: 'memcpy' offset [25, 32] from the object at 'desc' is out of the bounds of referenced subobject 'qw2' with type 'long long unsigned int' at offset 16 [-Warray-bounds]

The problem is that the original code is trying to copy data into a
couple of struct members adjacent to each other in a single call to
memcpy(). This causes a legitimate compiler warning because memcpy()
overruns the length of &desc.qw2 and &resp.qw2, respectively.

This helps with the ongoing efforts to globally enable -Warray-bounds
and get us closer to being able to tighten the FORTIFY_SOURCE routines
on memcpy().

Link: https://github.com/KSPP/linux/issues/109
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v2:
 - Fix another instance of this same issue in prq_event_thread().

 drivers/iommu/intel/svm.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 5165cea90421..332365ec3195 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -1020,9 +1020,10 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 			resp.qw2 = 0;
 			resp.qw3 = 0;
 
-			if (req->priv_data_present)
-				memcpy(&resp.qw2, req->priv_data,
-				       sizeof(req->priv_data));
+			if (req->priv_data_present) {
+				resp.qw2 = req->priv_data[0];
+				resp.qw3 = req->priv_data[1];
+			}
 			qi_submit_sync(iommu, &resp, 1, 0);
 		}
 prq_advance:
@@ -1194,9 +1195,10 @@ int intel_svm_page_response(struct device *dev,
 		desc.qw1 = QI_PGRP_IDX(prm->grpid) | QI_PGRP_LPIG(last_page);
 		desc.qw2 = 0;
 		desc.qw3 = 0;
-		if (private_present)
-			memcpy(&desc.qw2, prm->private_data,
-			       sizeof(prm->private_data));
+		if (private_present) {
+			desc.qw2 = prm->private_data[0];
+			desc.qw3 = prm->private_data[1];
+		}
 
 		qi_submit_sync(iommu, &desc, 1, 0);
 	}
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
