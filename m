Return-Path: <SRS0=CQae=6W=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D26C38A2A
	for <iommu@archiver.kernel.org>; Fri,  8 May 2020 22:02:58 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0DE2214D8
	for <iommu@archiver.kernel.org>; Fri,  8 May 2020 22:02:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0DE2214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 834A38700B;
	Fri,  8 May 2020 22:02:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id faXHSPX_kO25; Fri,  8 May 2020 22:02:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5C0AD86EEA;
	Fri,  8 May 2020 22:02:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 41A5CC0889;
	Fri,  8 May 2020 22:02:56 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B559EC07FF
 for <iommu@lists.linux-foundation.org>; Fri,  8 May 2020 22:02:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id AB170893EE
 for <iommu@lists.linux-foundation.org>; Fri,  8 May 2020 22:02:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b6DmqzugP40v for <iommu@lists.linux-foundation.org>;
 Fri,  8 May 2020 22:02:55 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 7A87189396
 for <iommu@lists.linux-foundation.org>; Fri,  8 May 2020 22:02:54 +0000 (UTC)
Received: from localhost.localdomain ([149.172.19.189]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Ma1oK-1jaQAZ0hW8-00W11D; Sat, 09 May 2020 00:02:27 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH] iommu/renesas: fix unused-function warning
Date: Sat,  9 May 2020 00:02:16 +0200
Message-Id: <20200508220224.688985-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
X-Provags-ID: V03:K1:nguKpoyDbwtn9OPppaa1Wkm4f1dh24v77iIkSuLPsDpqTEETLOi
 8fGI9X9HbB6Af8+GtEuUXekkCnA0zjffrQYJhHl/OPgS7W0gkuT+/ZASHGVNNBmD3SfMcH1
 AAGLAMgVzsl7553S0p0+gRRp9X/+7V2PRZdlyEWbVSJ2rM1gHU0VKGWC/NrJKqt0rHiFIR0
 9FR0/q2tCmYqKwfxA3KEQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WGPHeoCJUXo=:PqfGjNxO7ONTBOkQt/zAOC
 QlMKZK0qcyOf3cdLRylgomWSUGUDNkcqfUM36WbBmvEoCzkvl4tr+BDAKe3jP7p18JxptopLs
 UFBYh+LgN7pY9RduTraN7x5nTpgkQf9C7A1MgDARF1JLR5f5N3SgY0v+EQqfHws6zHKvJMelL
 DwMo4oSCL+3M16cmQbmdraaCkOrVkJQ5gF34CO2ZzhRL7MHYHR1Iy1XIanAzGqyMbMKKuoDVR
 PlEKq1suHKxI/ATEie3dGznx1dEKJXxaPyvxEMf0Db5oldNDTMEX/WA6BYJ8dgUaw+b9j+aA7
 rEzTVjUnU6TDC9nmS+fWwabEaSuHLjMKWXeb5+emVhbQUyXXqv9d9L+r03km42Z7gsjfmPk6L
 kfESyxiLlnzSg8v9otXEYCsilsULpMPkbDGzmd5qkOdKt791iMo4VfYkuh7wqVsnjWEC+f3u+
 ow2BEzyCLe7JJvjuYy5ZbcP536WJ5f+sdjqgC7N9V0tk7nLCUcz9nbRuvx+Pt/AIJYOVwARoE
 Q249S44z3FYo0mCcrc2KtbBUqyNfidv0Vs0+maeykj9XySk/50QkEMeBbnyxkMgZr6efRHcLM
 mw/jeVZ9Lb3SJTfUszsp3y5+gzynRf1eQ2K2G5/d0qpVqiBudB/es/RMEY70VkyogwNIiohyJ
 P+icQj54FV47lv1EYva3zM/poh54vDXE31mCyN9HZRCujg9TnNtQrNGJoNV6OBQpX9LL4tARj
 sMMZ+qrS+jXKNKjD+eKroIiBhuCr74S0ycznjIn0tx/hAHkIKysvkzgqBZQorv2Gqgslt+Pis
 s2dgqRHg8mK402ZMbvmx3vt0xB3AStgNO3joc6teXckSiZ8M0o=
Cc: Hai Nguyen Pham <hai.pham.ud@renesas.com>, Joerg Roedel <jroedel@suse.de>,
 Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert+renesas@glider.be>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Simon Horman <horms+renesas@verge.net.au>,
 Will Deacon <will@kernel.org>
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

gcc warns because the only reference to ipmmu_find_group
is inside of an #ifdef:

drivers/iommu/ipmmu-vmsa.c:878:28: error: 'ipmmu_find_group' defined but not used [-Werror=unused-function]

Change the #ifdef to an equivalent IS_ENABLED().

Fixes: 6580c8a78424 ("iommu/renesas: Convert to probe/release_device() call-backs")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/iommu/ipmmu-vmsa.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index fb7e702dee23..4c2972f3153b 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -903,11 +903,8 @@ static const struct iommu_ops ipmmu_ops = {
 	.probe_device = ipmmu_probe_device,
 	.release_device = ipmmu_release_device,
 	.probe_finalize = ipmmu_probe_finalize,
-#if defined(CONFIG_ARM) && !defined(CONFIG_IOMMU_DMA)
-	.device_group = generic_device_group,
-#else
-	.device_group = ipmmu_find_group,
-#endif
+	.device_group = IS_ENABLED(CONFIG_ARM) && !IS_ENABLED(CONFIG_IOMMU_DMA)
+			? generic_device_group : ipmmu_find_group,
 	.pgsize_bitmap = SZ_1G | SZ_2M | SZ_4K,
 	.of_xlate = ipmmu_of_xlate,
 };
-- 
2.26.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
