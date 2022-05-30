Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D431C433EF
	for <iommu@archiver.kernel.org>; Mon, 30 May 2022 13:44:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 432798411C;
	Mon, 30 May 2022 13:44:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6nYfe_p2yB_g; Mon, 30 May 2022 13:44:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 093F084105;
	Mon, 30 May 2022 13:44:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D6F5DC0039;
	Mon, 30 May 2022 13:44:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CBF03C002D
 for <iommu@lists.linux-foundation.org>; Mon, 30 May 2022 13:44:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ACD0784105
 for <iommu@lists.linux-foundation.org>; Mon, 30 May 2022 13:44:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NikdrLpkcUd3 for <iommu@lists.linux-foundation.org>;
 Mon, 30 May 2022 13:44:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B410C8411A
 for <iommu@lists.linux-foundation.org>; Mon, 30 May 2022 13:44:12 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id E9321B80DB3;
 Mon, 30 May 2022 13:44:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E098C3411A;
 Mon, 30 May 2022 13:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1653918249;
 bh=fsc6IIIk1awweZ+LPL499ZV/HHQ210t5VuqTymzmdZw=;
 h=From:To:Cc:Subject:Date:From;
 b=CoAnx3Z6+FkEB0I2L3tZgc1H0suyzS5p7ZZZOFwvifmWZl8ZbdZX5dZwfkg+dgFKN
 85bKyyTEVTMCzZN41iMLUJ+MLrLuHF/rWeWZVnFfmbh8OoJSw44Twb1F2AJm5oOiXA
 MOVGH/6jgclhy3nJS/KahzMyNLosiHCmFpgX9rcm3GbyJvHv5vx3eOhfIXHd+7DjU4
 89QBhRVSMoGZGeao+lml9+zUfElgwU1i/fOePT3tIkSI+xATlJkl9vo+0FX3Eh07fi
 T0BAAlsZV7mXmonEUK2XpFej4EZz4RInfwaPjLbtpqQsFmodKRloayULAInE6MvGaM
 EpAdyL6PbW0nw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 01/76] iommu/vt-d: Add RPLS to quirk list to skip
 TE disabling
Date: Mon, 30 May 2022 09:42:51 -0400
Message-Id: <20220530134406.1934928-1-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Cc: Sasha Levin <sashal@kernel.org>,
 Raviteja Goud Talla <ravitejax.goud.talla@intel.com>, will@kernel.org,
 iommu@lists.linux-foundation.org, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tejas Upadhyay <tejaskumarx.surendrakumar.upadhyay@intel.com>,
 dwmw2@infradead.org
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

From: Tejas Upadhyay <tejaskumarx.surendrakumar.upadhyay@intel.com>

[ Upstream commit 0a967f5bfd9134b89681cae58deb222e20840e76 ]

The VT-d spec requires (10.4.4 Global Command Register, TE
field) that:

Hardware implementations supporting DMA draining must drain
any in-flight DMA read/write requests queued within the
Root-Complex before completing the translation enable
command and reflecting the status of the command through
the TES field in the Global Status register.

Unfortunately, some integrated graphic devices fail to do
so after some kind of power state transition. As the
result, the system might stuck in iommu_disable_translati
on(), waiting for the completion of TE transition.

This adds RPLS to a quirk list for those devices and skips
TE disabling if the qurik hits.

Link: https://gitlab.freedesktop.org/drm/intel/-/issues/4898
Tested-by: Raviteja Goud Talla <ravitejax.goud.talla@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Tejas Upadhyay <tejaskumarx.surendrakumar.upadhyay@intel.com>
Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20220302043256.191529-1-tejaskumarx.surendrakumar.upadhyay@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/intel/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 21749859ad45..477dde39823c 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -6296,7 +6296,7 @@ static void quirk_igfx_skip_te_disable(struct pci_dev *dev)
 	ver = (dev->device >> 8) & 0xff;
 	if (ver != 0x45 && ver != 0x46 && ver != 0x4c &&
 	    ver != 0x4e && ver != 0x8a && ver != 0x98 &&
-	    ver != 0x9a)
+	    ver != 0x9a && ver != 0xa7)
 		return;
 
 	if (risky_device(dev))
-- 
2.35.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
