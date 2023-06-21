Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C47F8482
	for <iommu@lists.linux.dev>; Wed, 21 Jun 2023 06:44:22 +0000 (UTC)
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-bd5059e5347so13214756276.0
        for <iommu@lists.linux.dev>; Tue, 20 Jun 2023 23:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687329861; x=1689921861;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=C8az5zJDH0ESFjwiqnExbJyBaF+tF0BTQf7Bxk21/Xo=;
        b=MmssWY+3YFktxIF/WA4KOY5DVa4UBDzQVE2mTxNFaVyKAMTQcPmzrUyKnRow1u5/1i
         0meUrWB+7qdjGxGk/BZXzmzb1pQ53nSbLZW7KEXzmJ1wTWPeYpDaHRWw5MR6gg5fRS/t
         ku0AYHWl3On0+y1JE0YaBf7Aeap5dO2iKcztXzsyi5LQbiU3nBTbOOBGFhj+kVO1nPS/
         L1ltlHWhVDA8Qr/1MoVmRNWP3cN11BDGjlQjTXU+uttVYyoXzTzGdapoPcBYaZqSXJL0
         P6GwQQiyXHV7CzI5aqwk/8XCza5dBcBmpLoo5ytAswHLv7lm0GTilChwtaq7QlU0zcFb
         bo5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687329861; x=1689921861;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C8az5zJDH0ESFjwiqnExbJyBaF+tF0BTQf7Bxk21/Xo=;
        b=fxXHxytqLS0SxCHcp/0qN8R8Uk2gVGLh/RVTVW0e6x++R0lA4wzd1yiex3CRUlBdAY
         NeungiDCM9gdzFoL//kQiHCVj2g5XCBPWLujEQh8YhIcQEPIF2gPZhaAUUXHiHiOAxC6
         etZNbdy89wo4Ya4J8g5qdpY9AyVLe8ec6NxuEmRTr9N1XBKMt91TBfgG+KLFUn1m/iwV
         Y3+SRrszW6DJ23UDdGVdR0T7dgzs5AUvF8Tg50VNb2Dcp0kNy0gDSxIQpROgEIuFmx6f
         RyOfSqliok4MY3IOamNk+NLciFrylQvwZPSwtycYI5N/BNOD8OkNo/HhtyZz2nOrmzKW
         aciA==
X-Gm-Message-State: AC+VfDxVEgzS55ED5QtAC3l7tU1w70o7TFtupETjzt06y0AgbRS5eFtn
	ws77uRbcCGzcEjWgPhIYO9zRqcksIMFp
X-Google-Smtp-Source: ACHHUZ7mhXQYdCxoNYKF5SfDVv2FuZ4r9FDAvWLFLi6rVg6yhDNcK8dk0uoxOmNJIbocwU2FBeocvwwAg5dq
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:384f:f7da:c61d:5a3e])
 (user=mshavit job=sendgmr) by 2002:a05:6902:92:b0:bc4:a660:528f with SMTP id
 h18-20020a056902009200b00bc4a660528fmr3348263ybs.5.1687329861096; Tue, 20 Jun
 2023 23:44:21 -0700 (PDT)
Date: Wed, 21 Jun 2023 14:37:20 +0800
In-Reply-To: <20230621063825.268890-1-mshavit@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230621063825.268890-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230621063825.268890-9-mshavit@google.com>
Subject: [PATCH v4 08/13] iommu/arm-smmu-v3: Add helper for atc invalidation
From: Michael Shavit <mshavit@google.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>
Cc: Michael Shavit <mshavit@google.com>, jean-philippe@linaro.org, nicolinc@nvidia.com, 
	jgg@nvidia.com, baolu.lu@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This will be used to invalidate ATC entries made on an SSID for a master
when detaching a domain with pasid.

Signed-off-by: Michael Shavit <mshavit@google.com>
---
v1->v2: Make use of arm_smmu_atc_inv_cmd_set_ssid
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 65e2dfd28b7d8..0a5e875abda86 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1784,13 +1784,15 @@ arm_smmu_atc_inv_to_cmd(unsigned long iova, size_t size,
 	cmd->atc.size	= log2_span;
 }
 
-static int arm_smmu_atc_inv_master(struct arm_smmu_master *master)
+static int arm_smmu_atc_inv_master_ssid(struct arm_smmu_master *master,
+					int ssid)
 {
 	int i;
 	struct arm_smmu_cmdq_ent cmd;
 	struct arm_smmu_cmdq_batch cmds;
 
 	arm_smmu_atc_inv_to_cmd(0, 0, &cmd);
+	arm_smmu_atc_inv_cmd_set_ssid(ssid, &cmd);
 	cmds.num = 0;
 	for (i = 0; i < master->num_streams; i++) {
 		cmd.atc.sid = master->streams[i].id;
@@ -1800,6 +1802,11 @@ static int arm_smmu_atc_inv_master(struct arm_smmu_master *master)
 	return arm_smmu_cmdq_batch_submit(master->smmu, &cmds);
 }
 
+static int arm_smmu_atc_inv_master(struct arm_smmu_master *master)
+{
+	return arm_smmu_atc_inv_master_ssid(master, 0);
+}
+
 /*
  * If ssid is non-zero, issue atc invalidations with the given ssid instead of
  * the one the domain is attached to. This is used by SVA since it's pasid
-- 
2.41.0.162.gfafddb0af9-goog

