Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146DD15AEF
	for <iommu@lists.linux.dev>; Thu,  3 Aug 2023 10:14:17 +0000 (UTC)
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-585fb08172bso8502847b3.2
        for <iommu@lists.linux.dev>; Thu, 03 Aug 2023 03:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691057657; x=1691662457;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rOifn/Wuhm3Lbc3GJRKlq49fGVZtVjA5QOC6h6hHPVo=;
        b=Jk2nmERl0LUPbXV28X+tSYo8C1QRreF449bLJdfo1bgvPAu3ZE0GaI+0HHnypyhdOp
         Z4CUeAp28p3bldIY9P6A3qelTHXphyeOrpXSlBpjl1IQJch7vtsNY8lADstN+iTkN2Y/
         zk32wJbkWYqMThVz7BG/8N74ahf0QvyY9NQ/d8Vm+wS3xiFLOu5vPhQeI8o6avTXp8Ij
         mxh0Y36cfWA3FwqHAjPx4UzJ64ezXJzdRjLeL2Hdhd9EHX99GUhpZBkoXDjcZ5DANg+s
         mWJf2qHQbeINpLvO5ahJXwVOPGwl7+kKrLysMT3clPhDcKcKDYlOaj3cB3NcY8IE8LIE
         Nu7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691057657; x=1691662457;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rOifn/Wuhm3Lbc3GJRKlq49fGVZtVjA5QOC6h6hHPVo=;
        b=fIA8FMarW1RADDbdhX9WRZNpeqJajS5E+Uc/ip1W5oJ/9jB8a4tlDLdxbnPPKd8xXE
         24vsy2XKim39czX1bff3SLwbnNOfKk1Qb4DAaHqjGwNClM0zUGykswcY6cJyUC6PK9XO
         xH5oxHb+MozzOCl7Ok1Fd8zRnJ0gG0/CvlGY11/5E2HT1dZououHdOmoXa7XnBkgS2Oo
         MLsUKVNIFC9wLY8jRUjclG9h3vKP3dtbJd/hKk4aG+fZ0snGaa1NZksswq0Yo1qAs2+U
         c/kUE7xin+EwEfqoKwAmlbvqdv4wdwnO5d6DWp6hHk+E8Ng/iBkzFJZ89/RAT8pHv6Uo
         sz4g==
X-Gm-Message-State: ABy/qLbsMKv0HZveDRclJfgYtN4RjrXi5/42tDZqTk239ngiGG0UnGdB
	EP13t0MGeMmIeydODibNtqbvbZilkF0iJwMkG/TxutX2PA/tAVxTSMQ6SmeQHGjyjazlL37JlgK
	qhOQEl3n+EcRmPofDda99KA959avSTZ5slNL8eZzY7jOdjRqopDDKreE9xFf6360=
X-Google-Smtp-Source: APBJJlEww5GzZLOemvoHR0jnjoJTpv9UvSTAuAgQXGJ5jhZ7oiz42irlxltf7zXwxFAEDzkY/BIZ2zeS4ZW5
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:39d1:8774:b733:6210])
 (user=mshavit job=sendgmr) by 2002:a25:ab0b:0:b0:d0e:e780:81b3 with SMTP id
 u11-20020a25ab0b000000b00d0ee78081b3mr118271ybi.2.1691057656667; Thu, 03 Aug
 2023 03:14:16 -0700 (PDT)
Date: Thu,  3 Aug 2023 18:12:23 +0800
In-Reply-To: <20230803101351.1561031-1-mshavit@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230803101351.1561031-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230803181225.v5.3.I374b2826d8b01f3a0110fd42a01208d2e8adb0a2@changeid>
Subject: [PATCH v5 3/6] iommu/arm-smmu-v3: Add helper for atc invalidation
From: Michael Shavit <mshavit@google.com>
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: baolu.lu@linux.intel.com, will@kernel.org, jgg@nvidia.com, 
	jean-philippe@linaro.org, robin.murphy@arm.com, nicolinc@nvidia.com, 
	Michael Shavit <mshavit@google.com>
Content-Type: text/plain; charset="UTF-8"

This will be used to invalidate ATC entries made on an SSID for a master
when detaching a domain with pasid.

Signed-off-by: Michael Shavit <mshavit@google.com>
---

(no changes since v2)

Changes in v2:
- Make use of arm_smmu_atc_inv_cmd_set_ssid

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 6e614ad12fb48..e0565c644ffdb 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1798,13 +1798,15 @@ arm_smmu_atc_inv_to_cmd(unsigned long iova, size_t size,
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
@@ -1814,6 +1816,11 @@ static int arm_smmu_atc_inv_master(struct arm_smmu_master *master)
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
2.41.0.585.gd2178a4bd4-goog

