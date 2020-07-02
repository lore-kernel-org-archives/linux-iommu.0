Return-Path: <SRS0=8rqH=AN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB0DC433DF
	for <iommu@archiver.kernel.org>; Thu,  2 Jul 2020 20:44:44 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1E7C20780
	for <iommu@archiver.kernel.org>; Thu,  2 Jul 2020 20:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="awIazyPj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1E7C20780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=semihalf.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 88F0686B83;
	Thu,  2 Jul 2020 20:44:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fvZDSzAqLWzm; Thu,  2 Jul 2020 20:44:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6DDA285FD0;
	Thu,  2 Jul 2020 20:44:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 56CEDC0890;
	Thu,  2 Jul 2020 20:44:42 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3E2EAC0733
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jul 2020 20:44:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 2047F20496
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jul 2020 20:44:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Fut-2c-Jwr6a for <iommu@lists.linux-foundation.org>;
 Thu,  2 Jul 2020 20:44:40 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com
 [209.85.167.65])
 by silver.osuosl.org (Postfix) with ESMTPS id C7F6F20380
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jul 2020 20:44:39 +0000 (UTC)
Received: by mail-lf1-f65.google.com with SMTP id y18so17009473lfh.11
 for <iommu@lists.linux-foundation.org>; Thu, 02 Jul 2020 13:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=semihalf-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=eJKWwwb5sZNIMmtDeQlyT8Jj6wSl1CFV9/fEuSXAZwU=;
 b=awIazyPjnY7Ozy4WBmf6iohjAWMeVLUmfItYZqGlKzRi8S3I0MoV5VXXXlo1rju0he
 jH/oGOQOZv88hF8lDWgEo1s+4BfuzWa0QW51ddyQhfF5yiTZefpWoWrFOHbqARF2pRXL
 g/lRtzvGd7SRzaQMda6Nh8Rel7M7ZksicGl8MPm9NICfmZAYzCd+N3rn7NUmSg3Wu99B
 tjismAzWn1MJMSeY+kzWTBb+IMhWnpx7M0jT7x4z/64ov+8UKR/FANC8VIPhGBKdvQdL
 xAQT61yrooLnwYiKogRqY3HmOcbJlMFI37eJKIzd19v+3BkvmVrNraFkxIbCy6Pzda7L
 1RAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=eJKWwwb5sZNIMmtDeQlyT8Jj6wSl1CFV9/fEuSXAZwU=;
 b=ezbRJAKT8fW+4D52YN/6IdGszVFDiRJU0v6RpYNqO1fUKd8aHjNcihgQ062uK0p0Yr
 NUHm82cXIpaxsPtVYKe9ipIk6CYkOoT/lPA9du66Iy1vm65zUBwTpfsf/2WllOTBjuqg
 ZKSfDYu8X0Tt6C7kxvnPjObWvH3Uvb0tXUuIVrNGykOH4rnMBCZ2ZDurg2y3kVsdP+M7
 16G24L0ckpV8yL21WAtISuteBynPNahFfj5GkrdkowFXqMbRbSdhuPWI1CLWIWIvA7Bi
 z1seDk7BA3sB/GBjhLY238fansSqglGDehQpEfirNPMhOwWy6WFf/uRh6bbbdRP986aP
 LfhQ==
X-Gm-Message-State: AOAM5326fNbk2AZEv5z7jyU6Yz5kIuSKuJmO1F+UCx0zi3FzLsHl/f8J
 c/gQntsWkjJzkImUQYGceTAdtGPW044=
X-Google-Smtp-Source: ABdhPJwhWFHlehhdaC1EHXHyukD2VZsiZOAASUSH4+v3yoslhRemMCOLsyiK2U3r+dNAOF51WBRqZw==
X-Received: by 2002:a2e:b554:: with SMTP id a20mr16177178ljn.108.1593721019380; 
 Thu, 02 Jul 2020 13:16:59 -0700 (PDT)
Received: from localhost.localdomain ([83.68.95.66])
 by smtp.gmail.com with ESMTPSA id y2sm3320372lji.8.2020.07.02.13.16.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2020 13:16:58 -0700 (PDT)
From: Tomasz Nowicki <tn@semihalf.com>
To: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
 gregory.clement@bootlin.com, robh+dt@kernel.org, hannah@marvell.com
Subject: [PATCH v3 1/4] iommu/arm-smmu: Add SMMU ID2 register fixup hook
Date: Thu,  2 Jul 2020 22:16:30 +0200
Message-Id: <20200702201633.22693-2-tn@semihalf.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200702201633.22693-1-tn@semihalf.com>
References: <20200702201633.22693-1-tn@semihalf.com>
Cc: devicetree@vger.kernel.org, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, nadavh@marvell.com,
 iommu@lists.linux-foundation.org, mw@semihalf.com,
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

We already have 'cfg_probe' hook which meant to override and apply
workarounds while probing ID registers. However, 'cfg_probe' is called
at the very end and therefore for some cases fixing up things becomes complex
or requires exporting of SMMU driver structures. Hence, seems it is better and
cleaner to do ID fixup right away. In preparation for adding Marvell
errata add an extra ID2 fixup hook.

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
---
 drivers/iommu/arm-smmu.c | 3 +++
 drivers/iommu/arm-smmu.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 243bc4cb2705..17c92e319754 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1857,6 +1857,9 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 
 	/* ID2 */
 	id = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_ID2);
+	if (smmu->impl && smmu->impl->cfg_id2_fixup)
+		id = smmu->impl->cfg_id2_fixup(id);
+
 	size = arm_smmu_id_size_to_bits(FIELD_GET(ARM_SMMU_ID2_IAS, id));
 	smmu->ipa_size = size;
 
diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
index d172c024be61..f4c8bd7d0b34 100644
--- a/drivers/iommu/arm-smmu.h
+++ b/drivers/iommu/arm-smmu.h
@@ -382,6 +382,7 @@ struct arm_smmu_impl {
 	void (*write_reg64)(struct arm_smmu_device *smmu, int page, int offset,
 			    u64 val);
 	int (*cfg_probe)(struct arm_smmu_device *smmu);
+	u32 (*cfg_id2_fixup)(u32 id);
 	int (*reset)(struct arm_smmu_device *smmu);
 	int (*init_context)(struct arm_smmu_domain *smmu_domain);
 	void (*tlb_sync)(struct arm_smmu_device *smmu, int page, int sync,
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
