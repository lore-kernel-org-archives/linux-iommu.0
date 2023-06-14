Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEF0101EC
	for <iommu@lists.linux.dev>; Wed, 14 Jun 2023 15:45:11 +0000 (UTC)
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-bc7267224adso1730538276.0
        for <iommu@lists.linux.dev>; Wed, 14 Jun 2023 08:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686757510; x=1689349510;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GFfBSOUvUPqFSx6n4vEtFQq3Hc8Ha+kDvCzi3+3mgos=;
        b=vp6Nlsbz0oC9g4ftIwLdhomK6sQnklY1ZxeEkHnIXfEXrOB32EsbD/Sxec0iRhhQHg
         FG7D8M3PpWeaM8iqTIew0USWOhnUT0FjBe9eXnTTSV/LhmO3ZmKELA9cij4LrrquyyEX
         xN4kZsa+CrEDpQ+9SCj337Iz/uwRx2q05yM0XfIncqMYOokbXzbVERwKppl5BO38z5eP
         hHmqL5KhrByMtgmNr4kVUihXIw6qeRCfAOy3kJEM2Xe0aOvPnzQXKdDIUXJE6sDAuRHp
         s5nPeYy80N984gbWZ3p5ANSaT8JevwNNBkebJ7ua9ynBAmNYrnU+pSstx30pek9GSY+/
         b8wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686757510; x=1689349510;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GFfBSOUvUPqFSx6n4vEtFQq3Hc8Ha+kDvCzi3+3mgos=;
        b=aeqMev2wE75LwWcaKLmpdimIXgBYP1Go7XFa4hU4nKVhz+YPXDjswx6S+eaALf6UoL
         Plf+wpUaDXm60R5ULmgLxPKyE1mzwHt+MGsgEieXGaA60X9MOBjo3xV7x8oyfX+kBn92
         QX3MZbfydxgL1rdBjeLybIjWUL4cUd7HWYhUEC17x9Zjb6fSgQ36ix2eurKfFIPf0ef1
         94PCe/nSWaPp3E9aWkKkO1bEuozlnRmRwq4/XSRKsLz1Z1I2L2Zx9bwqq7Ai64RRxXFD
         vKbcurCq9PvuLKsMOchKVQS06x+qMNxqgLLqCoJjkYqX0nAISF6br2/M3Nk3dFqE4fjk
         Pt3Q==
X-Gm-Message-State: AC+VfDw1HpNR7Lm4xgOK+EEEdEap+uyhsdc58mO1wkvHOR/n9UHGSgfG
	9kI4JMMZ3jTeJtuX7JJ+h8ppyaWxN3gX
X-Google-Smtp-Source: ACHHUZ54OC1oThkrdI5m1JIqCvJD/OCLMDFClBfZ1oOPcGRnJCDeBJWfnhAFwtQXg3YtdduEf0o8Lo03wyNZ
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:c6e6:49bf:5c44:5965])
 (user=mshavit job=sendgmr) by 2002:a05:6902:1185:b0:ba8:381b:f764 with SMTP
 id m5-20020a056902118500b00ba8381bf764mr888385ybu.3.1686757510234; Wed, 14
 Jun 2023 08:45:10 -0700 (PDT)
Date: Wed, 14 Jun 2023 23:42:05 +0800
In-Reply-To: <20230614154304.2860121-1-mshavit@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230614154304.2860121-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230614154304.2860121-14-mshavit@google.com>
Subject: [PATCH v3 13/13] iommu/arm-smmu-v3-sva: Add check when enabling sva
From: Michael Shavit <mshavit@google.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>
Cc: Michael Shavit <mshavit@google.com>, jean-philippe@linaro.org, nicolinc@nvidia.com, 
	jgg@nvidia.com, baolu.lu@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

SVA domains can only be attached when the master's STEs have a stage 1
domain.

Signed-off-by: Michael Shavit <mshavit@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index b615a85e6a54e..e2a91f20f0906 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -499,9 +499,15 @@ int arm_smmu_master_enable_sva(struct arm_smmu_master *master)
 	int ret;
 
 	mutex_lock(&sva_lock);
+
+	if (!master->s1_cfg) {
+		ret = -EBUSY;
+		goto unlock;
+	}
 	ret = arm_smmu_master_sva_enable_iopf(master);
 	if (!ret)
 		master->sva_enabled = true;
+unlock:
 	mutex_unlock(&sva_lock);
 
 	return ret;
-- 
2.41.0.162.gfafddb0af9-goog

