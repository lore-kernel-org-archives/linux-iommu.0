Return-Path: <SRS0=XtWO=JB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534D3C433B4
	for <iommu@archiver.kernel.org>; Sun,  4 Apr 2021 15:33:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7A4C611C0
	for <iommu@archiver.kernel.org>; Sun,  4 Apr 2021 15:33:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7A4C611C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8FDBA607E1;
	Sun,  4 Apr 2021 15:33:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xvrvhgnEzpTC; Sun,  4 Apr 2021 15:33:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8065660765;
	Sun,  4 Apr 2021 15:33:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5B53CC000C;
	Sun,  4 Apr 2021 15:33:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 75344C000A
 for <iommu@lists.linux-foundation.org>; Sun,  4 Apr 2021 15:33:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5B2A941BFA
 for <iommu@lists.linux-foundation.org>; Sun,  4 Apr 2021 15:33:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YQyWSWcKjTUI for <iommu@lists.linux-foundation.org>;
 Sun,  4 Apr 2021 15:33:33 +0000 (UTC)
X-Greylist: delayed 00:07:09 by SQLgrey-1.8.0
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AA48041BF9
 for <iommu@lists.linux-foundation.org>; Sun,  4 Apr 2021 15:33:32 +0000 (UTC)
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AY2d9Ga8XTmD/lIU2x9Ruk+AYI+orLtY04lQ7?=
 =?us-ascii?q?vn1ZYxpTb8CeioSSjO0WvCWE6go5dXk8lbm7U5Wobmjb8fdOi7U5GZeHcE3YtH?=
 =?us-ascii?q?CzLIdkhLGSoAHIPyHl7OZS2eNBXsFFaeHYNlRxgcbk7ATQKb9J/PC87Kuqie3C?=
 =?us-ascii?q?pk0CcShWbchbgztRNhyWCQlfSgVAGPMCdKa014534wCtfnkada2Aa0UtVeKrnb?=
 =?us-ascii?q?L2qK4=3D?=
X-IronPort-AV: E=Sophos;i="5.81,304,1610406000"; d="scan'208";a="377727877"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 04 Apr 2021 17:26:19 +0200
Date: Sun, 4 Apr 2021 17:26:19 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Sven Peter <sven@svenpeter.dev>
Subject: [PATCH] iommu: dart: fix call_kern.cocci warnings
Message-ID: <alpine.DEB.2.22.394.2104041724340.2958@hadrien>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Cc: kbuild-all@lists.01.org, Marc Zyngier <maz@kernel.org>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
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

From: kernel test robot <lkp@intel.com>

Function apple_dart_attach_stream called on line 519 inside
lock on line 509 but uses GFP_KERNEL

Generated by: scripts/coccinelle/locks/call_kern.cocci

Fixes: ce67d3b3ef37 ("iommu: dart: Add DART iommu driver")
CC: Sven Peter <sven@svenpeter.dev>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
Signed-off-by: Julia Lawall <julia.lawall@inria.fr>
---

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git hack/m1-pcie
head:   1fd2c9634dd24fba323baba52200de18e4d3f4ee
commit: ce67d3b3ef3734925631ec65deb1cf8078d826cf [14/15] iommu: dart: Add DART iommu driver
:::::: branch date: 8 hours ago
:::::: commit date: 8 hours ago

Please take the patch only if it's a positive warning. Thanks!

 apple-dart-iommu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/iommu/apple-dart-iommu.c
+++ b/drivers/iommu/apple-dart-iommu.c
@@ -435,7 +435,7 @@ static int apple_dart_attach_stream(stru
 		goto error;
 	}

-	stream = kzalloc(sizeof(*stream), GFP_KERNEL);
+	stream = kzalloc(sizeof(*stream), GFP_ATOMIC);
 	if (!stream) {
 		ret = -ENOMEM;
 		goto error;
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
