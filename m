Return-Path: <SRS0=PnSl=7W=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CCFC433DF
	for <iommu@archiver.kernel.org>; Tue,  9 Jun 2020 18:05:28 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE8FA20734
	for <iommu@archiver.kernel.org>; Tue,  9 Jun 2020 18:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="Y4J6p1/U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE8FA20734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 80002869EB;
	Tue,  9 Jun 2020 18:05:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iBSt-HGX64ja; Tue,  9 Jun 2020 18:05:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0E9588699B;
	Tue,  9 Jun 2020 18:05:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E7F10C0863;
	Tue,  9 Jun 2020 18:05:24 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F0E3FC016F
 for <iommu@lists.linux-foundation.org>; Tue,  9 Jun 2020 18:05:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E604986943
 for <iommu@lists.linux-foundation.org>; Tue,  9 Jun 2020 18:05:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bqkr2ZtE971a for <iommu@lists.linux-foundation.org>;
 Tue,  9 Jun 2020 18:05:23 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail27.static.mailgun.info (mail27.static.mailgun.info
 [104.130.122.27])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 0A2A485E5C
 for <iommu@lists.linux-foundation.org>; Tue,  9 Jun 2020 18:05:22 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1591725923; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=x01+HksEUfPnnuAjrfKal7kG0NEwAm/phbFVlSCT2kQ=;
 b=Y4J6p1/Uvo8ZlLbiSBfuClpdHptPPicyweJk8bzE2pZRM2dGLdtTNFbvGwT3P2Se0zsUaPu/
 hGqQcg2hIcNulyICmPXkDyr0g2UsviuVCDiFs70POrPGGys3oWZf8HJojGABZgqyui7Y8dy7
 X9mp8KqmbSR/LTGEmpkbeeIW9lQ=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-east-1.postgun.com with SMTP id
 5edfcf610206ad41d1da1d7e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 09 Jun 2020 18:05:21
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id E22F8C433A0; Tue,  9 Jun 2020 18:05:20 +0000 (UTC)
Received: from jordan-laptop.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: jcrouse)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 1AD1EC43387;
 Tue,  9 Jun 2020 18:05:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1AD1EC43387
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=none smtp.mailfrom=jcrouse@codeaurora.org
From: Jordan Crouse <jcrouse@codeaurora.org>
To: linux-arm-msm@vger.kernel.org
Subject: [PATCH] iommu/arm-smmu: Don't bypass pinned stream mappings
Date: Tue,  9 Jun 2020 12:05:16 -0600
Message-Id: <20200609180516.14362-1-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.17.1
Cc: Patrick Daly <pdaly@codeaurora.org>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
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

Commit 0e764a01015d ("iommu/arm-smmu: Allow client devices to select
direct mapping") sets the initial domain type to SMMU_DOMAIN_IDENTITY
for devices that select direct mapping. This ends up setting the domain
as ARM_SMMU_DOMAIN_BYPASS which causes the stream ID mappings
for the device to be programmed to S2CR_TYPE_BYPASS.

This causes a problem for stream mappings that are inherited from
the bootloader since rewriting the stream to BYPASS will disrupt the
display controller access to DDR.

This is an extension to ("iommu/arm-smmu: Allow inheriting stream mapping
from bootloader") [1] that identifies streams that are already configured
 and marked them as pinned. This patch extends that to not re-write pinned
stream mappings for ARM_SMMU_DOMAIN_BYPASS domains.

[1] https://lore.kernel.org/r/20191226221709.3844244-4-bjorn.andersson@linaro.org

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

 drivers/iommu/arm-smmu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index c7add09f11c1..9c1e5ba948a7 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1143,6 +1143,10 @@ static int arm_smmu_domain_add_master(struct arm_smmu_domain *smmu_domain,
 		if (type == s2cr[idx].type && cbndx == s2cr[idx].cbndx)
 			continue;
 
+		/* Don't bypasss pinned streams; leave them as they are */
+		if (type == S2CR_TYPE_BYPASS && s2cr[idx].pinned)
+			continue;
+
 		s2cr[idx].type = type;
 		s2cr[idx].privcfg = S2CR_PRIVCFG_DEFAULT;
 		s2cr[idx].cbndx = cbndx;
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
