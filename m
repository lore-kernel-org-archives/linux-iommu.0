Return-Path: <SRS0=ms/0=4M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE95C11D2F
	for <iommu@archiver.kernel.org>; Mon, 24 Feb 2020 16:59:12 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4289F20836
	for <iommu@archiver.kernel.org>; Mon, 24 Feb 2020 16:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fxdWSvL7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4289F20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0FEBA84A6C;
	Mon, 24 Feb 2020 16:59:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZmJouHwwSAE3; Mon, 24 Feb 2020 16:59:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7ABE085E25;
	Mon, 24 Feb 2020 16:59:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 67BF2C1D89;
	Mon, 24 Feb 2020 16:59:11 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0215AC0177
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 16:59:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id F334F84B62
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 16:59:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DaiHS7j4zTJK for <iommu@lists.linux-foundation.org>;
 Mon, 24 Feb 2020 16:59:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
 [209.85.128.68])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 5327D84A6C
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 16:59:08 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id p9so50253wmc.2
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 08:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HsNqDpM5GYOb0rP3SKvjSjiXAgrPp7/dDnFzXTvMfm0=;
 b=fxdWSvL7/PlqMuOjCbpoyDK0oOMZfWMx8Bn0sQViiqiE3H2JO3U4xq75c/gD0NU1IB
 5LX+dV8sT5h1EGNCfmF3/Oc4OwWIiPSscSgJ9EdoXDkOLYlFea7GgkHZEKGQ4n3RX2xc
 tE0Z9fTNGrynG92HHnK+qNkjvWnd1/LmhQMR8Wkp+U8ifjROHa1WaQQXNc85lp2jIC+P
 lz56h7v5lvnlEFIVnmE4jx/Q/BDcbY3YEs++7gzkztWZ4dCkTt2gdyf4zasHzdwGusEP
 V4s2WLd6VesfOZIZPnXJjsJsg1FHR6SX/xW3H+Vqf2K7q/htUfeBaETDNaFwfGHo9nb3
 TUyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HsNqDpM5GYOb0rP3SKvjSjiXAgrPp7/dDnFzXTvMfm0=;
 b=peSukDlAiLcc9NWZIlLT7ONRskP3TORSuHlAN2QLQHBcz6mxfd7e6l985itoYYP+R3
 /4dympBFyoMph4HdyArLE67ipjFQN0gxZzaGXVls51fE2hpXCkjP05KEMQ+VkK+NkN/q
 xBd9JdNaEgoCuWVoTtoOHSJ46XnXdKb99FWJdTZDjHpb2NVEkmFRNucjV4AZBxAcvqKZ
 nGKnkRoH7xPRVAzDOgBjjMcaUbK92JAR/IAXeKSEduSmsP1Wqaf6mQ2a/UB6bXiuIDQ/
 v7W0HrZbfhRtOVx7nSsRLClEO/shnjChdHJMWwrhunAdqIAnHtNtrnG6SG1JoZv5OBEp
 CDzw==
X-Gm-Message-State: APjAAAXoXVrZvqbK5jG6piyf5FZzIApGA+zh9FSRObMM+aa7iPuKpj/f
 aWBHGIdgycUTOlGo1Zly0jdyNQ==
X-Google-Smtp-Source: APXvYqxzLvSxV15TQeDzuS7Vx3zfQgb1/0PPrdplrfLn1QNB4Up5cq5+1azMjxbcKStUM/cjgwhbxA==
X-Received: by 2002:a7b:c416:: with SMTP id k22mr35940wmi.10.1582563546869;
 Mon, 24 Feb 2020 08:59:06 -0800 (PST)
Received: from localhost.localdomain
 ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id b10sm19473978wrt.90.2020.02.24.08.59.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2020 08:59:06 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux-foundation.org, will@kernel.org, bhelgaas@google.com
Subject: [PATCH v2 5/6] iommu/arm-smmu-v3: Batch context descriptor
 invalidation
Date: Mon, 24 Feb 2020 17:58:45 +0100
Message-Id: <20200224165846.345993-6-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200224165846.345993-1-jean-philippe@linaro.org>
References: <20200224165846.345993-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: zhangfei.gao@linaro.org, robin.murphy@arm.com, robh@kernel.org
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

Rather than publishing one command at a time when invalidating a context
descriptor, batch the commands for all SIDs in the domain.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm-smmu-v3.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index beeec366bc41..12b2a0fa747e 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1512,6 +1512,7 @@ static void arm_smmu_sync_cd(struct arm_smmu_domain *smmu_domain,
 	size_t i;
 	unsigned long flags;
 	struct arm_smmu_master *master;
+	struct arm_smmu_cmdq_batch cmds = {};
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct arm_smmu_cmdq_ent cmd = {
 		.opcode	= CMDQ_OP_CFGI_CD,
@@ -1525,12 +1526,12 @@ static void arm_smmu_sync_cd(struct arm_smmu_domain *smmu_domain,
 	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
 		for (i = 0; i < master->num_sids; i++) {
 			cmd.cfgi.sid = master->sids[i];
-			arm_smmu_cmdq_issue_cmd(smmu, &cmd);
+			arm_smmu_cmdq_batch_add(smmu, &cmds, &cmd);
 		}
 	}
 	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 
-	arm_smmu_cmdq_issue_sync(smmu);
+	arm_smmu_cmdq_batch_submit(smmu, &cmds);
 }
 
 static int arm_smmu_alloc_cd_leaf_table(struct arm_smmu_device *smmu,
-- 
2.25.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
