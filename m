Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62272CCA473
	for <iommu@archiver.kernel.org>; Tue, 21 Jun 2022 15:11:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EB0E5829FE;
	Tue, 21 Jun 2022 15:11:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EB0E5829FE
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.a=rsa-sha256 header.s=20161220 header.b=B4KKsAdu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 17LzDj1UU_p0; Tue, 21 Jun 2022 15:11:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A1CB583F69;
	Tue, 21 Jun 2022 15:11:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A1CB583F69
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 14B27C0093;
	Tue, 21 Jun 2022 15:10:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 568AAC002D
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jun 2022 15:10:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2EA51415C5
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jun 2022 15:10:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2EA51415C5
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi
 header.a=rsa-sha256 header.s=20161220 header.b=B4KKsAdu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KFO-64aZgiWt for <iommu@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 15:10:55 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 67E00414CE
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 67E00414CE
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jun 2022 15:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
 s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=kX6TxBhPYP7/zzOagr1iopz1md+3ufdCaT6isU511rc=; b=B4KKsAdu7ncsWr+sdy3pVK/C2G
 F9YntmRgqGqxvX76WIfvo5Bto6O+odkTbiTPPDM+32fAURI4qFZVyFaXANbZOtWY6P1pAD4xoj14j
 xQcyruASEd11BtNOygFKk+XD2RvarhUmlEPkcW1xvo0WaBZPEs3uXQqwgWCwJNI/JXjIWQa9ge1eH
 dJngun6cI8gCZ1JV/+NuCUqIXwVm6N66Bik5gqtjaQbsubaJCpkHhhrDKkOtQYE9RQ1kqN/962VQg
 0QMqUW8pOmXl2Z03Ipm31EhdPeswilXhzfbGpDBe3JXtX+Uq7C2qRqrUPpZoiMAzpwbCe2g1jgEqf
 GFiXRPbg==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70]
 helo=toshino.localdomain) by mail.kapsi.fi with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <cyndis@kapsi.fi>)
 id 1o3fWU-00Ea3F-Gr; Tue, 21 Jun 2022 18:10:34 +0300
From: Mikko Perttunen <cyndis@kapsi.fi>
To: thierry.reding@gmail.com, jonathanh@nvidia.com, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, robh+dt@kernel.org,
 krzysztof.kozlowski@canonical.com
Subject: [PATCH v6 08/10] drm/tegra: nvdec: Fix TRANSCFG register offset
Date: Tue, 21 Jun 2022 18:10:20 +0300
Message-Id: <20220621151022.1416300-9-cyndis@kapsi.fi>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220621151022.1416300-1-cyndis@kapsi.fi>
References: <20220621151022.1416300-1-cyndis@kapsi.fi>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 91.158.25.70
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Mikko Perttunen <mperttunen@nvidia.com>,
 iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
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

From: Mikko Perttunen <mperttunen@nvidia.com>

NVDEC's TRANSCFG register is at a different offset than VIC.
This becomes a problem now when context isolation is enabled and
the reset value of the register is no longer sufficient.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
v6:
* New patch
---
 drivers/gpu/drm/tegra/nvdec.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tegra/nvdec.c b/drivers/gpu/drm/tegra/nvdec.c
index 79e1e88203cf..386f9b2e78c4 100644
--- a/drivers/gpu/drm/tegra/nvdec.c
+++ b/drivers/gpu/drm/tegra/nvdec.c
@@ -21,6 +21,8 @@
 #include "falcon.h"
 #include "vic.h"
 
+#define NVDEC_TFBIF_TRANSCFG			0x2c44
+
 struct nvdec_config {
 	const char *firmware;
 	unsigned int version;
@@ -63,7 +65,7 @@ static int nvdec_boot(struct nvdec *nvdec)
 		u32 value;
 
 		value = TRANSCFG_ATT(1, TRANSCFG_SID_FALCON) | TRANSCFG_ATT(0, TRANSCFG_SID_HW);
-		nvdec_writel(nvdec, value, VIC_TFBIF_TRANSCFG);
+		nvdec_writel(nvdec, value, NVDEC_TFBIF_TRANSCFG);
 
 		if (spec->num_ids > 0) {
 			value = spec->ids[0] & 0xffff;
-- 
2.36.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
