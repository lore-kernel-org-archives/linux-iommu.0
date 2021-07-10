Return-Path: <SRS0=ojAJ=MC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B44C07E9C
	for <iommu@archiver.kernel.org>; Sat, 10 Jul 2021 02:25:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90C6D6140A
	for <iommu@archiver.kernel.org>; Sat, 10 Jul 2021 02:25:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90C6D6140A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4FA75421F6;
	Sat, 10 Jul 2021 02:25:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zTCdQpFhFYYi; Sat, 10 Jul 2021 02:25:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DAA2C42253;
	Sat, 10 Jul 2021 02:25:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B3549C0010;
	Sat, 10 Jul 2021 02:25:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D08E0C000E
 for <iommu@lists.linux-foundation.org>; Sat, 10 Jul 2021 02:25:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CAB346068F
 for <iommu@lists.linux-foundation.org>; Sat, 10 Jul 2021 02:25:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zdlTDmO9tiih for <iommu@lists.linux-foundation.org>;
 Sat, 10 Jul 2021 02:25:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0CE84606A0
 for <iommu@lists.linux-foundation.org>; Sat, 10 Jul 2021 02:25:43 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id C25D461439;
 Sat, 10 Jul 2021 02:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625883943;
 bh=beYeCVqpXG//mMve1jdsA+aMH4RCqJHoakwYn0A5V8M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=AKHa5hgEb+jmnDP1915RxdykJBNeTLY643BMvCeDGOX0IkyaP/9r0CxiHM3xY/hee
 8VF2LOhbq23P5uubhDWmW6v2s/nqshYMlgUnoyHt1NYqc6pR679dnt+dDmw6EOj2Go
 gmkvXTt/ic1mNNvbtZ642OOlcQYOxuzN4RnF2PlZpmI+5pqXMzklPeMJBJeoR8Bp1/
 h+vTATN+gRzzPJ7Om4tsZ6ohsFEmdTwBzTYIcJUhXcX17/LlHveU4r8xmZ4SgMKZOY
 /DvOiZeH2hSHg4SY2VbfJgP79dZZA8Xa6U98eQtljESMoy3emsillMH/onE+eKav8s
 oxg1DbkxFX6oA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 57/93] iommu/arm-smmu: Fix arm_smmu_device
 refcount leak in address translation
Date: Fri,  9 Jul 2021 22:23:51 -0400
Message-Id: <20210710022428.3169839-57-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210710022428.3169839-1-sashal@kernel.org>
References: <20210710022428.3169839-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Cc: Rob Clark <robdclark@chromium.org>, Sasha Levin <sashal@kernel.org>,
 Xin Tan <tanxin.ctf@gmail.com>, Xiyu Yang <xiyuyang19@fudan.edu.cn>,
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

From: Xiyu Yang <xiyuyang19@fudan.edu.cn>

[ Upstream commit 7c8f176d6a3fa18aa0f8875da6f7c672ed2a8554 ]

The reference counting issue happens in several exception handling paths
of arm_smmu_iova_to_phys_hard(). When those error scenarios occur, the
function forgets to decrease the refcount of "smmu" increased by
arm_smmu_rpm_get(), causing a refcount leak.

Fix this issue by jumping to "out" label when those error scenarios
occur.

Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
Reviewed-by: Rob Clark <robdclark@chromium.org>
Link: https://lore.kernel.org/r/1623293391-17261-1-git-send-email-xiyuyang19@fudan.edu.cn
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 052f0a1bf037..df24bbe3ea4f 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -1284,6 +1284,7 @@ static phys_addr_t arm_smmu_iova_to_phys_hard(struct iommu_domain *domain,
 	u64 phys;
 	unsigned long va, flags;
 	int ret, idx = cfg->cbndx;
+	phys_addr_t addr = 0;
 
 	ret = arm_smmu_rpm_get(smmu);
 	if (ret < 0)
@@ -1303,6 +1304,7 @@ static phys_addr_t arm_smmu_iova_to_phys_hard(struct iommu_domain *domain,
 		dev_err(dev,
 			"iova to phys timed out on %pad. Falling back to software table walk.\n",
 			&iova);
+		arm_smmu_rpm_put(smmu);
 		return ops->iova_to_phys(ops, iova);
 	}
 
@@ -1311,12 +1313,14 @@ static phys_addr_t arm_smmu_iova_to_phys_hard(struct iommu_domain *domain,
 	if (phys & ARM_SMMU_CB_PAR_F) {
 		dev_err(dev, "translation fault!\n");
 		dev_err(dev, "PAR = 0x%llx\n", phys);
-		return 0;
+		goto out;
 	}
 
+	addr = (phys & GENMASK_ULL(39, 12)) | (iova & 0xfff);
+out:
 	arm_smmu_rpm_put(smmu);
 
-	return (phys & GENMASK_ULL(39, 12)) | (iova & 0xfff);
+	return addr;
 }
 
 static phys_addr_t arm_smmu_iova_to_phys(struct iommu_domain *domain,
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
