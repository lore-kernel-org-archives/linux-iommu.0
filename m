Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F6C14AA6
	for <iommu@lists.linux.dev>; Thu, 17 Aug 2023 18:21:41 +0000 (UTC)
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-589a45c1b0fso1449417b3.1
        for <iommu@lists.linux.dev>; Thu, 17 Aug 2023 11:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692296501; x=1692901301;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BIQTGF+g2uioZsuYxh2OZLeccAuWFaEAAqhYyJhrMno=;
        b=dwgSvvfqT9h8cnS2ANlfzc/bgIB0QsDd8CDnK3UIm0ECJPG5JtjbaBFo+m/YimJjK1
         FlcF7DYGVOnxlmxsuZmwGYkLyzXE/+YXllLknn+tZ0URfSeZ5ZQm2ooYJMUDaCgm9HD3
         EMRZmApldwJieHbJYGroUPtE8c2Vj1YgXUDFNmuw6MbqODyN/lDCN2SE2s0i09cVaycM
         IwOY8mSDO8eTap09s5EpC3UjfSkki/wTO7MZecQEtHfYnAOIxSA33Hg4SfFIAFGar366
         ucYHtFxnE0S6mZ5Oye/3L5iPNtWCHGNxHVp6H5k1FOv9CqWStIWrJaHE35yH0GApsM9x
         ZyDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692296501; x=1692901301;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BIQTGF+g2uioZsuYxh2OZLeccAuWFaEAAqhYyJhrMno=;
        b=DUzZIs+u3wpKEzEPHFBUsH5hctjtVoRqV7r8qlfWZsJHSVbrIqwcMsPuqKqLZfbylb
         BtKu4Qyp3JdgnkEXtSnELoUqYx/NTTr7Y1uLWLvuql4VKNBf4oLVvIJygmne7DLkuYvI
         kW5GtR2ilwDJIAOqxUbXLrRVL2kohECdQPV3tIMjiRMLiXBWAtjkJeOZuLsNjIE2sxVp
         fQCBXdvhl2PvX/vltIs1zViaAVXaWE1KYlpdWtBLOBJ5Xq/CFkqXyCVYX8Ug+fkX9kKx
         xoLKgRP9kWeBnVRVlCwfgShdcOrVB79I8kPCzF8ZASoPqBTRCkqvRdqWbv1+zKZVLq9o
         IBfA==
X-Gm-Message-State: AOJu0YzHaA/pax0ijStlIm9RhjAJql9yRKi6/lxxFLNurABml3uPx7f7
	hgF3Wgt7ndrQqKnlUHVejPMqrzo+bS8MZf0N0xRd3jZMoqVK9jERNTtwfb2yI3ZUy5uFtaeSQT4
	utx7BATe4AaEmUsZlFUgTKOQA8N6hNc4HtSRI5xFR4bIXaIHoW0Iq/OSOL281leU=
X-Google-Smtp-Source: AGHT+IGki4STCy0HIY6Al3kylQ4EKIZ5nbsBXL4XMwGt8Fl0igDhFp/d8IMaNrxqUESLF7rmYoeQWgvp+7e3
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:4a77:fd20:7069:bdf9])
 (user=mshavit job=sendgmr) by 2002:a25:ab8c:0:b0:d45:daf4:1fc5 with SMTP id
 v12-20020a25ab8c000000b00d45daf41fc5mr4372ybi.3.1692296500636; Thu, 17 Aug
 2023 11:21:40 -0700 (PDT)
Date: Fri, 18 Aug 2023 02:16:29 +0800
In-Reply-To: <20230817182055.1770180-1-mshavit@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230817182055.1770180-1-mshavit@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230818021629.RFC.v1.7.I65dd382de382428dcb33333342b35405903ac768@changeid>
Subject: [RFC PATCH v1 7/8] iommu/arm-smmu-v3: check for domain initialization
 using pgtbl_ops
From: Michael Shavit <mshavit@google.com>
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: will@kernel.org, jgg@nvidia.com, nicolinc@nvidia.com, tina.zhang@intel.com, 
	jean-philippe@linaro.org, robin.murphy@arm.com, 
	Michael Shavit <mshavit@google.com>
Content-Type: text/plain; charset="UTF-8"

In order to remove smmu_domain->smmu in the next commit

Signed-off-by: Michael Shavit <mshavit@google.com>
---

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 7f88b2b19cbe5..c9f89f4f47721 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2918,7 +2918,7 @@ static int arm_smmu_enable_nesting(struct iommu_domain *domain)
 	int ret = 0;
 
 	mutex_lock(&smmu_domain->init_mutex);
-	if (smmu_domain->smmu)
+	if (smmu_domain->pgtbl_ops)
 		ret = -EPERM;
 	else
 		smmu_domain->stage = ARM_SMMU_DOMAIN_NESTED;
-- 
2.42.0.rc1.204.g551eb34607-goog

