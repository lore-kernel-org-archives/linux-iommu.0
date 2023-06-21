Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C838482
	for <iommu@lists.linux.dev>; Wed, 21 Jun 2023 06:45:02 +0000 (UTC)
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-25e7fe2fb9bso2569527a91.3
        for <iommu@lists.linux.dev>; Tue, 20 Jun 2023 23:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687329902; x=1689921902;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GFfBSOUvUPqFSx6n4vEtFQq3Hc8Ha+kDvCzi3+3mgos=;
        b=t4HhyrUZx343POQssx8xWB3bNqEwvVz5axTthBdUwUeHP98YwM0/jOGBkI8RNJ6CfV
         q813TeRnvgUNnvQ5yy+drxSkGdqSae/ZdfJL2CLBJbfVgemKrHUzyxNImNn9WE4R5pN1
         QgALlayI2ddPtiW6CPlWgIpz9CmCsE/e1EJarXWy6qGQnc+hIy5agSCGPnJEUO2/Lcx0
         w31wnEnCEJrXmNRkg29aSfwTjpHDwxP6w/ngMobxEgWSJDGOmFnCq3Hf+OQierGh/m/V
         vjKc3DIyPkMR9sdzlVpuqyKBLwgRtHl253JAEGraYWPxylZDrHFJArJHYf6fcfRkfMfq
         s4QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687329902; x=1689921902;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GFfBSOUvUPqFSx6n4vEtFQq3Hc8Ha+kDvCzi3+3mgos=;
        b=A9M3eI9gkCdStTOmuI1I+jLdo3WmyRxt7ecIAhic9rUl3bNqCggcZ403DPTwFKvP8F
         p33mCd5VgKpQUUkLPlKt8Vsm3/Iy5rvQt9+PW7INTzVT4Rg3CZ4wVp/+dlzEoh7UQG/3
         QAI3PacqNyNkLlo4M58Xox2BQegmh0+SJWIOJrpdygnl4IeWLa293h8dguOLf9ZIZD1x
         c7Lyc3Olhcxh/KSpeIw5Y/KFvabB+9qbyLgMiGd+5xNSZEaeTrNNpiEby7g+p3a+GlJj
         G0ImdCv6cmIoCPEP3IvJm9sNQ/g3I4FEC8V7hoXAGFGHzAvh8KOs2gYyh4mp4e5RtXPK
         vB1A==
X-Gm-Message-State: AC+VfDzFHRgspGFzhPMSx3Rn0fME2M7Zz5WMSvfam6zWpYgnGhJ/8tQD
	/cosW/M+Hk52iYuyJpDNjYgjBbxqE/Cy
X-Google-Smtp-Source: ACHHUZ4sre6FKQd6JetGrp6VVOp9i7yh8bqwdCg0x/qqo75bj1C1/wd2ryfmXfIMYXHnMZ1hGUQI3eC1XGFb
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:384f:f7da:c61d:5a3e])
 (user=mshavit job=sendgmr) by 2002:a17:90a:fa06:b0:25b:d689:72a4 with SMTP id
 cm6-20020a17090afa0600b0025bd68972a4mr1992026pjb.4.1687329901714; Tue, 20 Jun
 2023 23:45:01 -0700 (PDT)
Date: Wed, 21 Jun 2023 14:37:25 +0800
In-Reply-To: <20230621063825.268890-1-mshavit@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230621063825.268890-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230621063825.268890-14-mshavit@google.com>
Subject: [PATCH v4 13/13] iommu/arm-smmu-v3-sva: Add check when enabling sva
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

