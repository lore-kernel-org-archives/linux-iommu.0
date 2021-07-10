Return-Path: <SRS0=ojAJ=MC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38451C07E9E
	for <iommu@archiver.kernel.org>; Sat, 10 Jul 2021 02:19:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4251613EC
	for <iommu@archiver.kernel.org>; Sat, 10 Jul 2021 02:19:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4251613EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A2C9B6062E;
	Sat, 10 Jul 2021 02:19:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WmDcQz9e5yVm; Sat, 10 Jul 2021 02:19:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 884896060F;
	Sat, 10 Jul 2021 02:19:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 640ABC0010;
	Sat, 10 Jul 2021 02:19:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 57AE7C000E
 for <iommu@lists.linux-foundation.org>; Sat, 10 Jul 2021 02:19:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 30A7D400EE
 for <iommu@lists.linux-foundation.org>; Sat, 10 Jul 2021 02:19:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NFpDrnHxWC9Y for <iommu@lists.linux-foundation.org>;
 Sat, 10 Jul 2021 02:19:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6E15D400CC
 for <iommu@lists.linux-foundation.org>; Sat, 10 Jul 2021 02:19:12 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 317C8613E8;
 Sat, 10 Jul 2021 02:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625883552;
 bh=6MAIkxHaPo+Yqp2Ff/ElNQYLdszBr4YG2QdZKdHUdtg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=obThWvzh/oCyvB+1lY74H4CnZ8rwFc/tYD0uaxZrh3qsl9QuJs3Szy1FaATgyyVDJ
 rv6BhrE2A49NioBTcxgfWjXMJKUB2KR//VkSyBEyfDWuQ6ACJXXXNWNU+i+qZfk5F3
 krYlGDKeXhitPuVe6gcknEJTr+gQjo6/7NX1CN6D+uGFy1JDsXKqBxi00zeEBu1pMV
 b/25w07D3VwS29Kkz4LbP8+k/CKvwApxk0NPhjXkcUT7I+FZJNwitzhYnbGVdAvF4g
 kh/0vaNcCIX2AtGD209jdlsBcD14VjgEOdNwLn4ILTUfA0eyEhTybkPzH7/tYrnf4Y
 Ze5tZOR9iRthQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.13 061/114] iommu/arm-smmu-qcom: Skip the TTBR1
 quirk for db820c.
Date: Fri,  9 Jul 2021 22:16:55 -0400
Message-Id: <20210710021748.3167666-61-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210710021748.3167666-1-sashal@kernel.org>
References: <20210710021748.3167666-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Cc: Sasha Levin <sashal@kernel.org>, Eric Anholt <eric@anholt.net>,
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

From: Eric Anholt <eric@anholt.net>

[ Upstream commit a242f4297cfe3f4589a7620dcd42cc503607fc6b ]

db820c wants to use the qcom smmu path to get HUPCF set (which keeps
the GPU from wedging and then sometimes wedging the kernel after a
page fault), but it doesn't have separate pagetables support yet in
drm/msm so we can't go all the way to the TTBR1 path.

Signed-off-by: Eric Anholt <eric@anholt.net>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Link: https://lore.kernel.org/r/20210326231303.3071950-1-eric@anholt.net
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 98b3a1c2a181..44a427833385 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -130,6 +130,16 @@ static int qcom_adreno_smmu_alloc_context_bank(struct arm_smmu_domain *smmu_doma
 	return __arm_smmu_alloc_bitmap(smmu->context_map, start, count);
 }
 
+static bool qcom_adreno_can_do_ttbr1(struct arm_smmu_device *smmu)
+{
+	const struct device_node *np = smmu->dev->of_node;
+
+	if (of_device_is_compatible(np, "qcom,msm8996-smmu-v2"))
+		return false;
+
+	return true;
+}
+
 static int qcom_adreno_smmu_init_context(struct arm_smmu_domain *smmu_domain,
 		struct io_pgtable_cfg *pgtbl_cfg, struct device *dev)
 {
@@ -144,7 +154,8 @@ static int qcom_adreno_smmu_init_context(struct arm_smmu_domain *smmu_domain,
 	 * be AARCH64 stage 1 but double check because the arm-smmu code assumes
 	 * that is the case when the TTBR1 quirk is enabled
 	 */
-	if ((smmu_domain->stage == ARM_SMMU_DOMAIN_S1) &&
+	if (qcom_adreno_can_do_ttbr1(smmu_domain->smmu) &&
+	    (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) &&
 	    (smmu_domain->cfg.fmt == ARM_SMMU_CTX_FMT_AARCH64))
 		pgtbl_cfg->quirks |= IO_PGTABLE_QUIRK_ARM_TTBR1;
 
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
