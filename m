Return-Path: <SRS0=/C+/=P4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76990C433FE
	for <iommu@archiver.kernel.org>; Tue,  9 Nov 2021 22:18:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 237A5619E1
	for <iommu@archiver.kernel.org>; Tue,  9 Nov 2021 22:18:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 237A5619E1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E3BE04045D;
	Tue,  9 Nov 2021 22:18:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xiqofajsQMJI; Tue,  9 Nov 2021 22:18:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DD3AD400FE;
	Tue,  9 Nov 2021 22:18:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BE6B8C0012;
	Tue,  9 Nov 2021 22:18:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 34E4AC000E
 for <iommu@lists.linux-foundation.org>; Tue,  9 Nov 2021 22:18:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1716A40450
 for <iommu@lists.linux-foundation.org>; Tue,  9 Nov 2021 22:18:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uYgtvaTdgAEf for <iommu@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 22:18:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 67295400FE
 for <iommu@lists.linux-foundation.org>; Tue,  9 Nov 2021 22:18:28 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 396D261360;
 Tue,  9 Nov 2021 22:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1636496308;
 bh=gjUG6+LBHjMZ1Kr7edkSf0qs+90PlyljuxOKpiXbHnQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=VQTNuEweTrU3WWfTzlhCmQQn9OkZUKqPbovlQWS+2myUFtv/16fYKbUjDfi5+wQzh
 5+TE4YCxwD5UbY55GQ5h2WIzA2QywmveMWH6XQSP+w034CfLRI9EcYcTOCirA1kUje
 1CSl991dcwG7gqeKMqmO3pKRjkfv0nnGj4Ud6HJpxoWOiQmY7u2cj88VC/v/MhW1N4
 fqwgzVP0juUpfEmUG8aGX3wjEkSC8iYT3Bv4cBw/UrGsgpUVmy+Hka0vZ1sQggT4HQ
 2AuY341p7DNFgOKDDGBAxOg2cVsTFC5GwlAaS4998ZQ4hl8BhTzCwOymMIjoPmBHbw
 9C8oPK3W8XUEw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 59/82] iommu/vt-d: Do not falsely log intel_iommu
 is unsupported kernel option
Date: Tue,  9 Nov 2021 17:16:17 -0500
Message-Id: <20211109221641.1233217-59-sashal@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211109221641.1233217-1-sashal@kernel.org>
References: <20211109221641.1233217-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Cc: Sasha Levin <sashal@kernel.org>, Joerg Roedel <jroedel@suse.de>,
 Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
 Eero Tamminen <eero.t.tamminen@intel.com>, iommu@lists.linux-foundation.org
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

From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

[ Upstream commit 5240aed2cd2594fb392239f11b9681e5e1591619 ]

Handling of intel_iommu kernel command line option should return "true" to
indicate option is valid and so avoid logging it as unknown by the core
parsing code.

Also log unknown sub-options at the notice level to let user know of
potential typos or similar.

Reported-by: Eero Tamminen <eero.t.tamminen@intel.com>
Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Link: https://lore.kernel.org/r/20210831112947.310080-1-tvrtko.ursulin@linux.intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Link: https://lore.kernel.org/r/20211014053839.727419-2-baolu.lu@linux.intel.com
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/intel/iommu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index d75f59ae28e6e..9a356075d3450 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -412,6 +412,7 @@ static int __init intel_iommu_setup(char *str)
 {
 	if (!str)
 		return -EINVAL;
+
 	while (*str) {
 		if (!strncmp(str, "on", 2)) {
 			dmar_disabled = 0;
@@ -441,13 +442,16 @@ static int __init intel_iommu_setup(char *str)
 		} else if (!strncmp(str, "tboot_noforce", 13)) {
 			pr_info("Intel-IOMMU: not forcing on after tboot. This could expose security risk for tboot\n");
 			intel_iommu_tboot_noforce = 1;
+		} else {
+			pr_notice("Unknown option - '%s'\n", str);
 		}
 
 		str += strcspn(str, ",");
 		while (*str == ',')
 			str++;
 	}
-	return 0;
+
+	return 1;
 }
 __setup("intel_iommu=", intel_iommu_setup);
 
-- 
2.33.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
