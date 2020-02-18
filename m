Return-Path: <SRS0=Yw80=4G=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104F0C34051
	for <iommu@archiver.kernel.org>; Tue, 18 Feb 2020 17:13:39 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDF6A2465D
	for <iommu@archiver.kernel.org>; Tue, 18 Feb 2020 17:13:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDF6A2465D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id A0E858721E;
	Tue, 18 Feb 2020 17:13:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e32ULR1rya2d; Tue, 18 Feb 2020 17:13:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 025A386C3A;
	Tue, 18 Feb 2020 17:13:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F1133C08A0;
	Tue, 18 Feb 2020 17:13:37 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F1A6FC013E
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 17:13:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id DFE5E85B4A
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 17:13:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EiMeesErXuxh for <iommu@lists.linux-foundation.org>;
 Tue, 18 Feb 2020 17:13:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com
 [209.85.167.194])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 526ED85BC4
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 17:13:34 +0000 (UTC)
Received: by mail-oi1-f194.google.com with SMTP id c16so20858887oic.3
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 09:13:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kW31qHj/OGRN2L4TXUUKIQPN57zbu2axU6XP0HsWl20=;
 b=NNCzJPzMQZrtZldeke7febrT7eyAVeyXRcjODZNR9aA37fWtDjc6hwVDvemuVYe6aA
 lFR/rx/uEXYl515tiY35OxBgjwyUmdf1QC2iWntTbplWr8Xp+5AZOH8EAsOena3qazsX
 pDnRSoN4mLi+S2nCDJ5EJRJPOd5hNNdHZ4Fk+ac72iznUbL9teERI8h6ahVdFsOfU6v1
 JQnv0NTrm5cQkGaixkE0PgaYDJhJOQpEKszQmCmz3YlUOHbcmN86XLZg9bTxLpCdoCBD
 mx+91gN3tcMjZIOZ9ILu5ze5FEnbWaeorG4M11L4YY/fnfTWOoqfDIXsmRj0slAvXIaE
 UAGw==
X-Gm-Message-State: APjAAAXkOfJhdxXRnxcB3qYlVbdJzrLCWw4tz0GizO3nn5q31MFSZwHb
 qzUC9KAxVP27mhKIQFPk3Q==
X-Google-Smtp-Source: APXvYqzM1O5/oeWQHJ8gT8Z9L53EKPDEEuwksZtS3dmhCEXg8KSK+0rIqhxLhSP9RCgQyZtde069lg==
X-Received: by 2002:a05:6808:9ba:: with SMTP id
 e26mr1936616oig.81.1582046013542; 
 Tue, 18 Feb 2020 09:13:33 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id y25sm1545755oto.27.2020.02.18.09.13.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2020 09:13:33 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 soc@kernel.org, Andre Przywara <andre.przywara@arm.com>,
 Robert Richter <rrichter@marvell.com>, Jon Loeliger <jdl@jdl.com>,
 Alexander Graf <graf@amazon.com>, Matthias Brugger <mbrugger@suse.com>,
 Mark Langsdorf <mlangsdo@redhat.com>
Subject: [RFC PATCH 06/11] iommu: arm-smmu: Remove Calxeda secure mode quirk
Date: Tue, 18 Feb 2020 11:13:16 -0600
Message-Id: <20200218171321.30990-7-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200218171321.30990-1-robh@kernel.org>
References: <20200218171321.30990-1-robh@kernel.org>
MIME-Version: 1.0
Cc: kvm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>,
 linux-ide@vger.kernel.org, Will Deacon <will@kernel.org>,
 linux-clk@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
 devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, linux-edac@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, Tony Luck <tony.luck@intel.com>,
 Stephen Boyd <sboyd@kernel.org>, netdev@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 iommu@lists.linux-foundation.org, James Morse <james.morse@arm.com>,
 Robin Murphy <robin.murphy@arm.com>, "David S. Miller" <davem@davemloft.net>
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

Cc: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
Do not apply yet.

 drivers/iommu/arm-smmu-impl.c | 43 -----------------------------------
 1 file changed, 43 deletions(-)

diff --git a/drivers/iommu/arm-smmu-impl.c b/drivers/iommu/arm-smmu-impl.c
index 74d97a886e93..a3be8712d27f 100644
--- a/drivers/iommu/arm-smmu-impl.c
+++ b/drivers/iommu/arm-smmu-impl.c
@@ -9,45 +9,6 @@

 #include "arm-smmu.h"

-
-static int arm_smmu_gr0_ns(int offset)
-{
-	switch(offset) {
-	case ARM_SMMU_GR0_sCR0:
-	case ARM_SMMU_GR0_sACR:
-	case ARM_SMMU_GR0_sGFSR:
-	case ARM_SMMU_GR0_sGFSYNR0:
-	case ARM_SMMU_GR0_sGFSYNR1:
-	case ARM_SMMU_GR0_sGFSYNR2:
-		return offset + 0x400;
-	default:
-		return offset;
-	}
-}
-
-static u32 arm_smmu_read_ns(struct arm_smmu_device *smmu, int page,
-			    int offset)
-{
-	if (page == ARM_SMMU_GR0)
-		offset = arm_smmu_gr0_ns(offset);
-	return readl_relaxed(arm_smmu_page(smmu, page) + offset);
-}
-
-static void arm_smmu_write_ns(struct arm_smmu_device *smmu, int page,
-			      int offset, u32 val)
-{
-	if (page == ARM_SMMU_GR0)
-		offset = arm_smmu_gr0_ns(offset);
-	writel_relaxed(val, arm_smmu_page(smmu, page) + offset);
-}
-
-/* Since we don't care for sGFAR, we can do without 64-bit accessors */
-static const struct arm_smmu_impl calxeda_impl = {
-	.read_reg = arm_smmu_read_ns,
-	.write_reg = arm_smmu_write_ns,
-};
-
-
 struct cavium_smmu {
 	struct arm_smmu_device smmu;
 	u32 id_base;
@@ -166,10 +127,6 @@ struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device *smmu)
 		break;
 	}

-	if (of_property_read_bool(smmu->dev->of_node,
-				  "calxeda,smmu-secure-config-access"))
-		smmu->impl = &calxeda_impl;
-
 	if (of_device_is_compatible(smmu->dev->of_node, "qcom,sdm845-smmu-500"))
 		return qcom_smmu_impl_init(smmu);

--
2.20.1
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
