Return-Path: <SRS0=4RPJ=Z7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BDAFC00454
	for <iommu@archiver.kernel.org>; Mon,  9 Dec 2019 15:08:03 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4DDC207FD
	for <iommu@archiver.kernel.org>; Mon,  9 Dec 2019 15:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RCFZsnYA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4DDC207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id AD76787F73;
	Mon,  9 Dec 2019 15:08:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d1E8m8sMk80G; Mon,  9 Dec 2019 15:08:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 538ED87F5D;
	Mon,  9 Dec 2019 15:08:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 40B57C1796;
	Mon,  9 Dec 2019 15:08:02 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 88D62C0881
 for <iommu@lists.linux-foundation.org>; Mon,  9 Dec 2019 15:08:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 7819C87F5D
 for <iommu@lists.linux-foundation.org>; Mon,  9 Dec 2019 15:08:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9eRblLZLrDJV for <iommu@lists.linux-foundation.org>;
 Mon,  9 Dec 2019 15:08:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
 [209.85.128.68])
 by hemlock.osuosl.org (Postfix) with ESMTPS id AB13887F73
 for <iommu@lists.linux-foundation.org>; Mon,  9 Dec 2019 15:08:00 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id n9so15353030wmd.3
 for <iommu@lists.linux-foundation.org>; Mon, 09 Dec 2019 07:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SCh0DvmuPvNnvwyZrUn1Yxeo2DKZuHbBZB63XGCCkS0=;
 b=RCFZsnYA0ah3RgaH4YcQ8lshQjU7h/V8oku0vGmhP4oE9Wtew3Cf9yl2hieQG5wrK6
 Ix2xPTip9Dd4NRjiWUdsWMp61s5znz2sevxNPEMTWQxZyd3pq8l77DoTAHRRhmp85Uy+
 iZCodqQIhd+4nvvloniqdKNiV+iuR0PKJabToorhlsWVZi9BzSg1EqvtudbeqB0RAwja
 T+sdZ2DJRdFhDap4NVifzs3S4ANB8VN1e32SPvQ5xJj7Wza5fCalFMyYIlsvBm6aleBN
 L0hAyV5gu3bi8DdTiU+RSIPy+Yb1Z7X3/j54c4/9x3aMMtnsjxLc3qt5MBZq+IenwAia
 7VKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SCh0DvmuPvNnvwyZrUn1Yxeo2DKZuHbBZB63XGCCkS0=;
 b=dpMl6bBi0CHwmWyUoc4pAKfXuQTiF6SW4UzE60mZeYSRramEIR+ssYSXH/SI3m0TaL
 Bdr0RdU0U5awumwyChXveFlie5o7GNfow2u/al7BeXr4hwMXvwrPWTv7MGeapuiJQXvy
 ed6B61NyjV6jTT1cWkWeIH2v3wgoRZjquoCKaggCBpccSyLiNLYnr7tGAX0iboLqqCr8
 gKvRD2qkcoVDHF0nDQflLrZYb6cNud1M3TywsDBHGY3Fx16DoQQTl6/FC3TKLKCQRT9S
 wHHZk8bChcziQvLarSJey5aIOX6oTWKoByhggM0OQF3dCjnQbbrc3skBQMEw3pF62bqd
 nnOw==
X-Gm-Message-State: APjAAAWOf3gXuzf2NX1rckBN9T1HJ5sx3W+65J3AxUDUYWQre0xeXxLN
 ZaDi2Z6JiizvC1X6HFGvcmY=
X-Google-Smtp-Source: APXvYqxl2jgGeV/nQbJT4WcN79CWmM1WA8NXKH9i0hXyR/42inKaAVju+sJOobjHc7cEOfabhQZ6KA==
X-Received: by 2002:a1c:c90e:: with SMTP id f14mr25155761wmb.47.1575904079019; 
 Mon, 09 Dec 2019 07:07:59 -0800 (PST)
Received: from localhost (pD9E518ED.dip0.t-ipconnect.de. [217.229.24.237])
 by smtp.gmail.com with ESMTPSA id 4sm41628wmg.22.2019.12.09.07.07.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2019 07:07:58 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [RFC 1/2] iommu: arm-smmu: Extract arm_smmu_of_parse()
Date: Mon,  9 Dec 2019 16:07:47 +0100
Message-Id: <20191209150748.2471814-2-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191209150748.2471814-1-thierry.reding@gmail.com>
References: <20191209150748.2471814-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Cc: linux-tegra@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>,
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

From: Thierry Reding <treding@nvidia.com>

This function will be subsequently used to extract stream ID information
early, before a struct device is available.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/iommu/arm-smmu.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index d1aef07bb784..5c5cf942077e 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1545,18 +1545,28 @@ static int arm_smmu_domain_set_attr(struct iommu_domain *domain,
 	return ret;
 }
 
-static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
+static u32 arm_smmu_of_parse(struct device_node *np, const u32 *args,
+			     unsigned int count)
 {
-	u32 mask, fwid = 0;
+	u32 fwid = 0, mask;
 
-	if (args->args_count > 0)
-		fwid |= FIELD_PREP(SMR_ID, args->args[0]);
+	if (count > 0)
+		fwid |= FIELD_PREP(SMR_ID, args[0]);
 
-	if (args->args_count > 1)
-		fwid |= FIELD_PREP(SMR_MASK, args->args[1]);
-	else if (!of_property_read_u32(args->np, "stream-match-mask", &mask))
+	if (count > 1)
+		fwid |= FIELD_PREP(SMR_MASK, args[1]);
+	else if (!of_property_read_u32(np, "stream-match-mask", &mask))
 		fwid |= FIELD_PREP(SMR_MASK, mask);
 
+	return fwid;
+}
+
+static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
+{
+	u32 fwid;
+
+	fwid = arm_smmu_of_parse(args->np, args->args, args->args_count);
+
 	return iommu_fwspec_add_ids(dev, &fwid, 1);
 }
 
-- 
2.23.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
