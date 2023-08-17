Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A87B14AA6
	for <iommu@lists.linux.dev>; Thu, 17 Aug 2023 18:21:37 +0000 (UTC)
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-589d8e16dfdso1260507b3.3
        for <iommu@lists.linux.dev>; Thu, 17 Aug 2023 11:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692296496; x=1692901296;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KUbNCncRdoFX1+f2g3pRLFzwoP3ZTCWn6yNRKIIgaR8=;
        b=szQhiT9g55SNiHgWkEz0kzx/pdJeQMPRZT87WkTbJfU5llAAIBmjRjgiQpTzpF5YN9
         jnHWSW4RBGrl6wHgCm0b7DGDja4uzbX3KiaPHrY+tRwAS5ROOmoBpwFcWEuGquvUQoW3
         pe7iA4pHhX5sYBiHgb5CEJaRdVTc5M7PLGuWkpCjPNbYCwOvg0u3nXy5uC5Ylbnl5joJ
         FwUTm8R7v07kv/Kwe1FErP0xhPfqlzOjNSztxiwntrbqdWE6FD0+E7joEgqK2swPc/xu
         kWoNfbm78S8JqLwataTwW78ctZTGc6ehN2UYe/Tguy+OLMeSudr8wa4I8hVdXC/5tmSE
         yZFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692296496; x=1692901296;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KUbNCncRdoFX1+f2g3pRLFzwoP3ZTCWn6yNRKIIgaR8=;
        b=iObAOp+eY5GChxmbuXu2dLq2f+zT4MwXTHyr4lpvI+1YfhmJKoBKUkBVcIru6ws2F3
         m9j1zjJUD5uQwBplHDqNuCK+mNCoOHLdsNm6KycLWQZCK1rLuG0yBH+PnLginwBPtDYP
         FPLtmU6E8FAhAvYRYqUHfh6mM2acknxfUAx3U+DZOju+ioaqLA9/9EZMjosO2O4GwPCA
         UuXE21FxhouJDsm1Q8K3Zh3Ctudnf7ilgt7M8Zzp3EyoT6pAmmFTHR3/Vtnl1fpg5cVS
         n/TEwatwtmLLgOyHlPKtLQ/NxCqPI5Bv8kqVBt/e38OTAqB1XaHlB4IxOH3HmIdNPeTL
         ibLw==
X-Gm-Message-State: AOJu0Yyi7BuhngAhvdSVugaSlN1dKGrbK4l8+qLgixyBmNS08L+JcUtz
	ISqYLQ7LpnjCl2JxefIQ8TwulwfkelXUW4vRZ7BfwOJ9Re3Gm3trmTcE7pPTQg9xMF3Jbz2xM7U
	CCnHt0/38L0FAjeB+3PztrlIZdcHAwLQfeL2UJGkaSeSwxr/ICtORB7m1MiyB4dU=
X-Google-Smtp-Source: AGHT+IEu0J32esLhZqyNCqxShUB/3M3HqZKWXXA5yaIU1uOsU/89OPq9VhM26WkG7OBEwWdWhp4PpsKGG9U1
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:4a77:fd20:7069:bdf9])
 (user=mshavit job=sendgmr) by 2002:a81:ae53:0:b0:58c:b5a4:8e14 with SMTP id
 g19-20020a81ae53000000b0058cb5a48e14mr2800ywk.2.1692296496312; Thu, 17 Aug
 2023 11:21:36 -0700 (PDT)
Date: Fri, 18 Aug 2023 02:16:28 +0800
In-Reply-To: <20230817182055.1770180-1-mshavit@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230817182055.1770180-1-mshavit@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230818021629.RFC.v1.6.I65dd382de382428dcb3cf61342b35405903ac768@changeid>
Subject: [RFC PATCH v1 6/8] iommu/arm-smmu-v3: Free VMID when uninstalling
 domain from SMMU
From: Michael Shavit <mshavit@google.com>
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: will@kernel.org, jgg@nvidia.com, nicolinc@nvidia.com, tina.zhang@intel.com, 
	jean-philippe@linaro.org, robin.murphy@arm.com, 
	Michael Shavit <mshavit@google.com>
Content-Type: text/plain; charset="UTF-8"

This will allow installing a domain onto multiple smmu devices.

Signed-off-by: Michael Shavit <mshavit@google.com>
---

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 208fec5fba462..7f88b2b19cbe5 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2112,7 +2112,6 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 static void arm_smmu_domain_free(struct iommu_domain *domain)
 {
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
-	struct arm_smmu_device *smmu = smmu_domain->smmu;
 
 	free_io_pgtable_ops(smmu_domain->pgtbl_ops);
 
@@ -2122,10 +2121,6 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 		mutex_lock(&arm_smmu_asid_lock);
 		arm_smmu_free_asid(&smmu_domain->cd);
 		mutex_unlock(&arm_smmu_asid_lock);
-	} else {
-		struct arm_smmu_s2_cfg *cfg = &smmu_domain->s2_cfg;
-		if (cfg->vmid)
-			ida_free(&smmu->vmid_map, cfg->vmid);
 	}
 
 	kfree(smmu_domain);
@@ -2484,6 +2479,14 @@ static void arm_smmu_installed_smmus_remove_device(
 			continue;
 		list_del(&master->list);
 		if (list_empty(&installed_smmu->devices)) {
+			if (smmu_domain->stage == ARM_SMMU_DOMAIN_S2) {
+				struct arm_smmu_s2_cfg *cfg =
+					&smmu_domain->s2_cfg;
+
+				if (cfg->vmid)
+					ida_free(&smmu->vmid_map,
+						 cfg->vmid);
+			}
 			list_del(&installed_smmu->list);
 			kfree(installed_smmu);
 		}
-- 
2.42.0.rc1.204.g551eb34607-goog

