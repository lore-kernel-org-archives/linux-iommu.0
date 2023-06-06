Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864BC15ACE
	for <iommu@lists.linux.dev>; Tue,  6 Jun 2023 12:10:51 +0000 (UTC)
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1b24203569aso398605ad.2
        for <iommu@lists.linux.dev>; Tue, 06 Jun 2023 05:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686053451; x=1688645451;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=C0PSyQeXC7Iz/P3YpxIMlG3+vOjTAssvVZqtnA/BFhw=;
        b=2YvtQkhtruPyaU6tyIiOFVtpwOKVajkps/SV+rmgxl5WcQGFxK06oATnOVAhefKsb/
         /+tX6arfJ/Za9QYTa80Ei6E11onSKYS7FIz7iInWoRFPOWEY5aPsmfcRL0zuObD3kAq0
         teU/b922dsyZ//kQGYgXVvkHMSBnz3ieADNsR8xmAE0B3/N50Bl+vA1z7orEKcxD09Na
         bdbw4y7eF6C+HCfUimAIszfp3GX30HXWkqD/lwSejlJbb9AM/4g8brT1EpgR9qNhnEbM
         IypWkQ/P7yNKwLZhGySBmvzzhXMm7ZZFnsb2tJniozWmxdNQhN6ba8XMv52XGQjbrdS9
         De3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686053451; x=1688645451;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C0PSyQeXC7Iz/P3YpxIMlG3+vOjTAssvVZqtnA/BFhw=;
        b=AFryeCQY1eNxYcmkYNbDTb4lVtSQ2Hd8Gn8lYSG+yuQUdt0Xl01ROrwew2LPDxuWOG
         g+GUMmz2OQv8yLnVyq7S9wEu3cDHDXQUC1vydSFxpJpYcT3Dqx6kp4657mgxcJ0asJoZ
         D0UBBwulouzFt6ISFoBrZqYm5I0rIU7gkdBREW4nVoLqTUG6glhO/ZSMmHKfq6XxmEjn
         cYeIVQoua8XeA1PAXBLjCLV0hIbUgDPAVsMYkV+9iWz+/JhgS2TdAM9VC6w7wUh/QA/n
         PRC4JQX0u/cFag8NavueMeAwV1Wzgxv+flYUicX7nQ/Q30m440CX8N1Vg/LQXvbQrFBZ
         RPgw==
X-Gm-Message-State: AC+VfDw1wYZTtERbTGCPXdikPkZezzbt6u4hngFae5XQaIDOzLhKO17t
	QGKEa5E+RRZ3aTYjSII8E38fg6m9pcZr
X-Google-Smtp-Source: ACHHUZ4x7W0FDltSlEvI3muVSMQ0fdaK5g12vYIpYYXAKI4ob4o42ABzQjjOpYbLtirWzKE/HT0Jn0tZ7kY+
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:a615:63d5:b54e:6919])
 (user=mshavit job=sendgmr) by 2002:a17:902:d483:b0:1ae:485e:d192 with SMTP id
 c3-20020a170902d48300b001ae485ed192mr629661plg.8.1686053451002; Tue, 06 Jun
 2023 05:10:51 -0700 (PDT)
Date: Tue,  6 Jun 2023 20:07:49 +0800
In-Reply-To: <20230606120854.4170244-1-mshavit@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230606120854.4170244-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230606120854.4170244-14-mshavit@google.com>
Subject: [PATCH v2 13/18] iommu/arm-smmu-v3-sva: Add check when enabling sva
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
2.41.0.rc0.172.g3f132b7071-goog

