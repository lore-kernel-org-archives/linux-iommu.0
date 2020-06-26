Return-Path: <SRS0=GrUw=AH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD557C433DF
	for <iommu@archiver.kernel.org>; Fri, 26 Jun 2020 20:01:55 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1613206DD
	for <iommu@archiver.kernel.org>; Fri, 26 Jun 2020 20:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="ufOVCtxG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1613206DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8DE368887F;
	Fri, 26 Jun 2020 20:01:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5b8BIybUsdCm; Fri, 26 Jun 2020 20:01:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 03D9788751;
	Fri, 26 Jun 2020 20:01:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E322DC088C;
	Fri, 26 Jun 2020 20:01:54 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F36AC016F
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 20:01:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 2FFEC24AF8
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 20:01:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CBie5nseS1nr for <iommu@lists.linux-foundation.org>;
 Fri, 26 Jun 2020 20:01:51 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail29.static.mailgun.info (mail29.static.mailgun.info
 [104.130.122.29])
 by silver.osuosl.org (Postfix) with ESMTPS id 634B4204CF
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 20:01:44 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1593201711; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=I4mi9KRzY9q8x+8ibjGrJyjF0IRQt7yz1HbGjbPTjwA=;
 b=ufOVCtxGeVha3FvJ4Dgs9LUwKiDbEiuZ17eAFgIOwrrXqepLLOuHjCtxPwu4tVJfU4WzWKVg
 WqBElQFINh8C0lj3e1NlvaH1iH7wjU4aSgl3BMVHbXJQP4kr4Zrism7e+jGF4TGRaMTGgxa0
 H/Nb72s3TeJSdbKwgoIgt94yJhI=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5ef653f7ad153efa349aae9b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 26 Jun 2020 20:00:55
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 76A62C433CB; Fri, 26 Jun 2020 20:00:55 +0000 (UTC)
Received: from jordan-laptop.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: jcrouse)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id D8FB7C433CA;
 Fri, 26 Jun 2020 20:00:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D8FB7C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=none smtp.mailfrom=jcrouse@codeaurora.org
From: Jordan Crouse <jcrouse@codeaurora.org>
To: linux-arm-msm@vger.kernel.org
Subject: [PATCH v9 4/7] iommu/arm-smmu: Add a pointer to the attached device
 to smmu_domain
Date: Fri, 26 Jun 2020 14:00:38 -0600
Message-Id: <20200626200042.13713-5-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200626200042.13713-1-jcrouse@codeaurora.org>
References: <20200626200042.13713-1-jcrouse@codeaurora.org>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 John Stultz <john.stultz@linaro.org>, freedreno@lists.freedesktop.org,
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

Add a link to the pointer to the struct device that is attached to a
domain. This makes it easy to get the pointer if it is needed in the
implementation specific code.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

 drivers/iommu/arm-smmu.c | 6 ++++--
 drivers/iommu/arm-smmu.h | 1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 048de2681670..060139452c54 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -668,7 +668,8 @@ static void arm_smmu_write_context_bank(struct arm_smmu_device *smmu, int idx)
 }
 
 static int arm_smmu_init_domain_context(struct iommu_domain *domain,
-					struct arm_smmu_device *smmu)
+					struct arm_smmu_device *smmu,
+					struct device *dev)
 {
 	int irq, start, ret = 0;
 	unsigned long ias, oas;
@@ -801,6 +802,7 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 		cfg->asid = cfg->cbndx;
 
 	smmu_domain->smmu = smmu;
+	smmu_domain->dev = dev;
 
 	pgtbl_cfg = (struct io_pgtable_cfg) {
 		.pgsize_bitmap	= smmu->pgsize_bitmap,
@@ -1190,7 +1192,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		return ret;
 
 	/* Ensure that the domain is finalised */
-	ret = arm_smmu_init_domain_context(domain, smmu);
+	ret = arm_smmu_init_domain_context(domain, smmu, dev);
 	if (ret < 0)
 		goto rpm_put;
 
diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
index 5f2de20e883b..d33cfe26b2f5 100644
--- a/drivers/iommu/arm-smmu.h
+++ b/drivers/iommu/arm-smmu.h
@@ -345,6 +345,7 @@ struct arm_smmu_domain {
 	struct mutex			init_mutex; /* Protects smmu pointer */
 	spinlock_t			cb_lock; /* Serialises ATS1* ops and TLB syncs */
 	struct iommu_domain		domain;
+	struct device			*dev;	/* Device attached to this domain */
 };
 
 static inline u32 arm_smmu_lpae_tcr(struct io_pgtable_cfg *cfg)
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
