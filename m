Return-Path: <SRS0=aa3U=GS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21BE2C433E6
	for <iommu@archiver.kernel.org>; Fri, 15 Jan 2021 09:03:49 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCD5C23435
	for <iommu@archiver.kernel.org>; Fri, 15 Jan 2021 09:03:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCD5C23435
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 30EAF203A4;
	Fri, 15 Jan 2021 09:03:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X9uULlacj3v6; Fri, 15 Jan 2021 09:03:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 9139320397;
	Fri, 15 Jan 2021 09:03:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8BC92C08A1;
	Fri, 15 Jan 2021 09:03:47 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 42CAEC088B
 for <iommu@lists.linux-foundation.org>; Fri, 15 Jan 2021 09:03:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 3F0628741D
 for <iommu@lists.linux-foundation.org>; Fri, 15 Jan 2021 09:03:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id avWIQJ8xTjue for <iommu@lists.linux-foundation.org>;
 Fri, 15 Jan 2021 09:03:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id D62C687313
 for <iommu@lists.linux-foundation.org>; Fri, 15 Jan 2021 09:03:45 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 339302339D;
 Fri, 15 Jan 2021 09:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1610701425;
 bh=7la6AOF22duM8nJdUP2TkacYvkWl00x0WTDSlkJJ08Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ilM8UPVTtCs0av85SpQYZFCxrPLSFrVCyYJJsEyhSzUncpZAXQkyzYW6Ku8KfCB+b
 zfS0Ky5uGtAsxu6ufVQZILJwqRHc94+QfSejF0URKcVZbVbvWMuwkYXPE1F+IAY0R5
 YfZucUpv2mEJyszNkt9TwNZrIOL3zOcMaP1jz2aJpNX4rP+yXW9Spy+pjhtBa6UqGv
 WUrLRZ7rB6WIKe9eMiET+QTH1V/zlRL1FrpwAuCKfznd4pb7IEEGgnvXtBlelI0Poq
 wxPZY63YZjsRD3tIPYGsUNGC3b0+DQrApSN09tEa8v9aZThBNcVQ7JXLdb6X7VH7oL
 z/les4wrPZugQ==
From: Vinod Koul <vkoul@kernel.org>
To: Will Deacon <will@kernel.org>
Subject: [PATCH 2/2] iommu: arm-smmu-impl: Add SM8350 qcom iommu implementation
Date: Fri, 15 Jan 2021 14:33:22 +0530
Message-Id: <20210115090322.2287538-2-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210115090322.2287538-1-vkoul@kernel.org>
References: <20210115090322.2287538-1-vkoul@kernel.org>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
 Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

Add SM8350 qcom iommu implementation to the table of
qcom_smmu_impl_of_match table which brings in iommu support for SM8350
SoC

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 5dff7ffbef11..8044a9bfca66 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -327,6 +327,7 @@ static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
 	{ .compatible = "qcom,sdm845-smmu-500" },
 	{ .compatible = "qcom,sm8150-smmu-500" },
 	{ .compatible = "qcom,sm8250-smmu-500" },
+	{ .compatible = "qcom,sm8350-smmu-500" },
 	{ }
 };
 
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
