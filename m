Return-Path: <SRS0=ZJ+1=4B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10509C2BA83
	for <iommu@archiver.kernel.org>; Thu, 13 Feb 2020 10:14:54 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAD9220873
	for <iommu@archiver.kernel.org>; Thu, 13 Feb 2020 10:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LxfZfpNC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAD9220873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id F1B9F203ED;
	Thu, 13 Feb 2020 10:14:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eIfHDt9Kje2c; Thu, 13 Feb 2020 10:14:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id A63DB21135;
	Thu, 13 Feb 2020 10:14:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 90E3FC07FE;
	Thu, 13 Feb 2020 10:14:51 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CB12AC0177
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 10:14:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id C80F386CC5
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 10:14:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZudpEHWMeTNt for <iommu@lists.linux-foundation.org>;
 Thu, 13 Feb 2020 10:14:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 1E69D86CC7
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 10:14:49 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id z3so5939809wru.3
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 02:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=x5dk7qiKtWru6EN2nFzBqe4Wug6V5GV2jfq/LzU0wiw=;
 b=LxfZfpNC9g2Kao3Ca86IBRs1BVelmn8AvrmBdYYcvu/Ke2cjSOzIyL4tYo+CSK06ir
 w3b22BZqfdo7gA4OGIO7IPlmKXPutox8+BQRijvmJOLUFg76kRhQNt87DPJR4X9qAiMM
 +A7sCzIh/nwBLfWMREpCrSBlAqcRv1kBTi7+wkAkOLYjSyYzxvIfzyWCPOhfF2PIoZMr
 68xchnfm0tHysAcpb+CfWLgd+nrsjJ/carvqlZNvfgjhupYg/vPbGHa8oLMduRWowQxN
 SEyTmYq+kC8yFTfIDpTSzTGunUntmDOwNm/FB/pRONEy4RDWQgjDrBAGU67PZ2o+JbRW
 6vGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=x5dk7qiKtWru6EN2nFzBqe4Wug6V5GV2jfq/LzU0wiw=;
 b=Nbj/CcV7Nfyy/XYW3cg7XCzvswN0zL73mF5OjwpuOSzhzKHF/O5OmfODnaacBDO/Ht
 gIKawzzAve8bqNLrxHMe3q0vgPFM0GxXrVtTDutkAAVMW7ofF7COLvWMGYWd4eAxgS8W
 L8o+k8tYQ5KuY/66Ko9w140CrM34ApN4+7+y7LO9jFK1/0DQoEiHD/zeyowRpluYDov+
 hArKrMblPHj2tzlAJ4yCZ6KGBFpNGXG5hNCsym2MFlJxU15DQN64BUg24ayLdPc28kp2
 rA5hvpOT8LCXMmKfvUuepYvoPNAwdSn+jIustBiZD3Lve+qmRv9mNd9d8vXJ6/s9ldLA
 /fCQ==
X-Gm-Message-State: APjAAAUttLS+isZ4386HaEGwKneISSqQhvWrQ5nX7maR5DR2yKJ1sg8z
 XKBKiTGLi+SvjW+i2WtSJjAcnw==
X-Google-Smtp-Source: APXvYqw6o99I0CZZyiTcqdl7ceH4XsBTkQw3w/87dL8LUwOg4DxhwdracytpcV7NsxduI66j7hSHCQ==
X-Received: by 2002:adf:f787:: with SMTP id q7mr20817905wrp.297.1581588887619; 
 Thu, 13 Feb 2020 02:14:47 -0800 (PST)
Received: from localhost.localdomain ([2001:171b:2276:930:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id y131sm2428059wmc.13.2020.02.13.02.14.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 02:14:47 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux-foundation.org, will@kernel.org, bhelgaas@google.com
Subject: [PATCH 4/4] iommu/arm-smmu-v3: Write level-1 descriptors atomically
Date: Thu, 13 Feb 2020 11:14:35 +0100
Message-Id: <20200213101435.229932-5-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213101435.229932-1-jean-philippe@linaro.org>
References: <20200213101435.229932-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: zhangfei.gao@linaro.org, robin.murphy@arm.com
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

Use WRITE_ONCE() to make sure that the SMMU doesn't read incomplete
stream table descriptors. Refer to the comment about 64-bit accesses,
and add the comment to the equivalent context descriptor code.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm-smmu-v3.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 11123fbf22a5..034ad9671b83 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1539,6 +1539,7 @@ static void arm_smmu_write_cd_l1_desc(__le64 *dst,
 	u64 val = (l1_desc->l2ptr_dma & CTXDESC_L1_DESC_L2PTR_MASK) |
 		  CTXDESC_L1_DESC_V;
 
+	/* See comment in arm_smmu_write_ctx_desc() */
 	WRITE_ONCE(*dst, cpu_to_le64(val));
 }
 
@@ -1734,7 +1735,8 @@ arm_smmu_write_strtab_l1_desc(__le64 *dst, struct arm_smmu_strtab_l1_desc *desc)
 	val |= FIELD_PREP(STRTAB_L1_DESC_SPAN, desc->span);
 	val |= desc->l2ptr_dma & STRTAB_L1_DESC_L2PTR_MASK;
 
-	*dst = cpu_to_le64(val);
+	/* See comment in arm_smmu_write_ctx_desc() */
+	WRITE_ONCE(*dst, cpu_to_le64(val));
 }
 
 static void arm_smmu_sync_ste_for_sid(struct arm_smmu_device *smmu, u32 sid)
-- 
2.25.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
