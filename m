Return-Path: <SRS0=dgoC=IK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10AF8C433E0
	for <iommu@archiver.kernel.org>; Fri, 12 Mar 2021 15:56:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 857D864FE0
	for <iommu@archiver.kernel.org>; Fri, 12 Mar 2021 15:56:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 857D864FE0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 49E9F6FA1E;
	Fri, 12 Mar 2021 15:56:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TpTIIXeXKCHS; Fri, 12 Mar 2021 15:56:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 316376FAEB;
	Fri, 12 Mar 2021 15:56:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 06E24C000B;
	Fri, 12 Mar 2021 15:56:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DDEF0C0001
 for <iommu@lists.linux-foundation.org>; Fri, 12 Mar 2021 15:56:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D012C4324E
 for <iommu@lists.linux-foundation.org>; Fri, 12 Mar 2021 15:56:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CjbtOnt2ksYx for <iommu@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 15:56:04 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1C3FC4017B
 for <iommu@lists.linux-foundation.org>; Fri, 12 Mar 2021 15:56:03 +0000 (UTC)
Received: by mail-lj1-x230.google.com with SMTP id r20so7359404ljk.4
 for <iommu@lists.linux-foundation.org>; Fri, 12 Mar 2021 07:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=uz8axRJtNwOGJiSaHqygjzHfEXoywnTTEXk/8QEVZWc=;
 b=aEk/ptF91oAruIKJCh5kBzObHw8A21+pu5m9So7irpHVhCtzTskmjARilRC8bYCWzo
 H23ZiWdsa7iQ0D9gXpJ9Zk5iO+ALMlhy5tzcBVABoNID4NDYZH6kVZ3KzScldu36d3fS
 B49dZb5EMjoRWQvi0JnjaTeKBF8X2CyfkAbkJoqI+xnnsySjWWWt1xi308IiIU1ipgSa
 ufExRffYHsZxXbJPLY9RrW6tQBOjPKlpwXEDdEbOpP4BpAcp0O/ZlH4/ohREQjrPIvxO
 JUyatwzzldqu71TeBDPC9rgkpPmYhidxTqTi3uigZGGuTQiffhO83NslnKWLd4qRe8j2
 RW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=uz8axRJtNwOGJiSaHqygjzHfEXoywnTTEXk/8QEVZWc=;
 b=egKy/XmTONB9Y1v6uZ2hE0UNIGCdSE4WoXyDcdDE4RpGblXeUxQI+7+Nt8BrTmddA2
 Vb0vvoMxdumDV2JdZPRY3wcGXuGJrQmTcQPI3pxUulYcD0HDjkXYWTIviJ/43sd6AdJZ
 jb2fIiSpbTqAaIoec8zyxaeMko1z/n0UeIeAA6Hiln8edT/jj1T8gwq+2iOexi9aNw+q
 KzZfMByLOBKOwZoODHztLHDF2syGA6wwOUvkv2YHVPZI5x4PSINFr6sNBitnUDbjX+mP
 5/0EENxk1fjHzi6Z9nDFkOegqYdQVpiP247wuD/7Hwpym4ZqftXjkSv4et+mM+SfOtK1
 JPig==
X-Gm-Message-State: AOAM530pvU+DZXkjgNTB91p4azpfh4RVKngDQ2UZ0Wd+HHc1Nf7JM4Pl
 leKOzekgoQvnBaqFPTlmX+w=
X-Google-Smtp-Source: ABdhPJyNqC+zjAUitl09iFh8JuBYf69cws7MGpkC+ezD8XZhsmCo09/B4p/pXb7GbW7EHSEN2ok4Ng==
X-Received: by 2002:a05:651c:384:: with SMTP id
 e4mr2690606ljp.500.1615564561904; 
 Fri, 12 Mar 2021 07:56:01 -0800 (PST)
Received: from localhost.localdomain (109-252-193-52.dynamic.spd-mgts.ru.
 [109.252.193.52])
 by smtp.gmail.com with ESMTPSA id u11sm1759224lfg.275.2021.03.12.07.56.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Mar 2021 07:56:01 -0800 (PST)
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>, Joerg Roedel <joro@8bytes.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, Krishna Reddy <vdumpa@nvidia.com>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Will Deacon <will@kernel.org>
Subject: [PATCH v1] iommu/tegra-smmu: Make tegra_smmu_probe_device() to handle
 all IOMMU phandles
Date: Fri, 12 Mar 2021 18:54:39 +0300
Message-Id: <20210312155439.18477-1-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Cc: linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
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

The tegra_smmu_probe_device() handles only the first IOMMU device-tree
phandle, skipping the rest. Devices like 3D module on Tegra30 have
multiple IOMMU phandles, one for each h/w block, and thus, only one
IOMMU phandle is added to fwspec for the 3D module, breaking GPU.
Previously this problem was masked by tegra_smmu_attach_dev() which
didn't use the fwspec, but parsed the DT by itself. The previous commit
to tegra-smmu driver partially reverted changes that caused problems for
T124 and now we have tegra_smmu_attach_dev() that uses the fwspec and
the old-buggy variant of tegra_smmu_probe_device() which skips secondary
IOMMUs.

Make tegra_smmu_probe_device() not to skip the secondary IOMMUs. This
fixes a partially attached IOMMU of the 3D module on Tegra30 and now GPU
works properly once again.

Fixes: 765a9d1d02b2 ("iommu/tegra-smmu: Fix mc errors on tegra124-nyan")
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/iommu/tegra-smmu.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 97eb62f667d2..602aab98c079 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -849,12 +849,11 @@ static struct iommu_device *tegra_smmu_probe_device(struct device *dev)
 		smmu = tegra_smmu_find(args.np);
 		if (smmu) {
 			err = tegra_smmu_configure(smmu, dev, &args);
-			of_node_put(args.np);
 
-			if (err < 0)
+			if (err < 0) {
+				of_node_put(args.np);
 				return ERR_PTR(err);
-
-			break;
+			}
 		}
 
 		of_node_put(args.np);
-- 
2.29.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
