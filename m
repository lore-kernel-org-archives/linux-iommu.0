Return-Path: <SRS0=UfLp=4C=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0FDC3B1A1
	for <iommu@archiver.kernel.org>; Fri, 14 Feb 2020 16:20:08 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3259F24733
	for <iommu@archiver.kernel.org>; Fri, 14 Feb 2020 16:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="18LPU1mT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3259F24733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0F67087646;
	Fri, 14 Feb 2020 16:20:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8kPg1iNlRoxQ; Fri, 14 Feb 2020 16:20:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id D41F387618;
	Fri, 14 Feb 2020 16:20:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9F7F6C08A4;
	Fri, 14 Feb 2020 16:20:06 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B2C8AC0177
 for <iommu@lists.linux-foundation.org>; Fri, 14 Feb 2020 16:20:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9CA2E85F2D
 for <iommu@lists.linux-foundation.org>; Fri, 14 Feb 2020 16:20:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FKn3k6af6Y5d for <iommu@lists.linux-foundation.org>;
 Fri, 14 Feb 2020 16:20:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 8D83285EF0
 for <iommu@lists.linux-foundation.org>; Fri, 14 Feb 2020 16:20:04 +0000 (UTC)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 89E5F2472C;
 Fri, 14 Feb 2020 16:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1581697204;
 bh=WejT3Jlm73icaZYufA+h2E/dA+9hbApxdmiA8FvbewE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=18LPU1mTGvyoZmVX6Y9BlIaffz0Sg0hn1y/GAq8Q2ih/QDMi0N10lljAYoOQI3UxP
 LMC0nWFFTWweZoCRR+lBdXJg7hyYWZpJIBUOrJzcDFDJ5fGKCEgcAK/VStyLSO7CQn
 nZysXUNce0oFiDwwDNf1gPaWv84UZgTjg41tk+f8=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 131/186] iommu/arm-smmu-v3: Use WRITE_ONCE() when
 changing validity of an STE
Date: Fri, 14 Feb 2020 11:16:20 -0500
Message-Id: <20200214161715.18113-131-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214161715.18113-1-sashal@kernel.org>
References: <20200214161715.18113-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Cc: Sasha Levin <sashal@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
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

From: Will Deacon <will@kernel.org>

[ Upstream commit d71e01716b3606a6648df7e5646ae12c75babde4 ]

If, for some bizarre reason, the compiler decided to split up the write
of STE DWORD 0, we could end up making a partial structure valid.

Although this probably won't happen, follow the example of the
context-descriptor code and use WRITE_ONCE() to ensure atomicity of the
write.

Reported-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/arm-smmu-v3.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 09eb258a9a7de..29feafa8007fb 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1145,7 +1145,8 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_device *smmu, u32 sid,
 	}
 
 	arm_smmu_sync_ste_for_sid(smmu, sid);
-	dst[0] = cpu_to_le64(val);
+	/* See comment in arm_smmu_write_ctx_desc() */
+	WRITE_ONCE(dst[0], cpu_to_le64(val));
 	arm_smmu_sync_ste_for_sid(smmu, sid);
 
 	/* It's likely that we'll want to use the new STE soon */
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
