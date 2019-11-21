Return-Path: <SRS0=a2WC=ZN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A02B2C432C0
	for <iommu@archiver.kernel.org>; Thu, 21 Nov 2019 11:50:05 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7429A2089D
	for <iommu@archiver.kernel.org>; Thu, 21 Nov 2019 11:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="el74vyNO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7429A2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5389386F8D;
	Thu, 21 Nov 2019 11:50:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iPc_iaBQK6us; Thu, 21 Nov 2019 11:50:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E5BD686F80;
	Thu, 21 Nov 2019 11:50:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E193DC1DD8;
	Thu, 21 Nov 2019 11:50:04 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D48F7C18DA
 for <iommu@lists.linuxfoundation.org>; Thu, 21 Nov 2019 11:50:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id C4086887B0
 for <iommu@lists.linuxfoundation.org>; Thu, 21 Nov 2019 11:50:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Tf+QYFnawg9w for <iommu@lists.linuxfoundation.org>;
 Thu, 21 Nov 2019 11:50:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 67D8888798
 for <iommu@lists.linuxfoundation.org>; Thu, 21 Nov 2019 11:50:02 +0000 (UTC)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
 [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0B014208A3;
 Thu, 21 Nov 2019 11:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1574337002;
 bh=DHeiJVQlW7y4ddlQ/LaGON1SaFa79wUh5PTwgg5/o8M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=el74vyNOgy/VHH87tsM/060IuAl5FpETWUlRLRujX4ywRbhO1vLc+Mdz+r0QIcr/u
 5hT/M5MSU9uiaFCFGbDm4tvGnrSTh4+gjwbEZtf2S7El9w9lUWx5LayVudOhgcirfY
 lpZJxgLMJfQaVSS/15lL5+O+mC6S1XACegl3T/rw=
From: Will Deacon <will@kernel.org>
To: iommu@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 14/14] iommu/arm-smmu: Update my email address in
 MODULE_AUTHOR()
Date: Thu, 21 Nov 2019 11:49:18 +0000
Message-Id: <20191121114918.2293-15-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191121114918.2293-1-will@kernel.org>
References: <20191121114918.2293-1-will@kernel.org>
MIME-Version: 1.0
Cc: "Isaac J. Manjarres" <isaacm@codeaurora.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Saravana Kannan <saravanak@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Robin Murphy <robin.murphy@arm.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Will Deacon <will@kernel.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

I no longer work for Arm, so update the stale reference to my old email
address.

Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/iommu/arm-smmu-v3.c | 2 +-
 drivers/iommu/arm-smmu.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index f79b14f75107..7669beafc493 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -3732,5 +3732,5 @@ static struct platform_driver arm_smmu_driver = {
 module_platform_driver(arm_smmu_driver);
 
 MODULE_DESCRIPTION("IOMMU API for ARM architected SMMUv3 implementations");
-MODULE_AUTHOR("Will Deacon <will.deacon@arm.com>");
+MODULE_AUTHOR("Will Deacon <will@kernel.org>");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 100ab5b9c255..d55acc48aee3 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -2291,5 +2291,5 @@ static struct platform_driver arm_smmu_driver = {
 module_platform_driver(arm_smmu_driver);
 
 MODULE_DESCRIPTION("IOMMU API for ARM architected SMMU implementations");
-MODULE_AUTHOR("Will Deacon <will.deacon@arm.com>");
+MODULE_AUTHOR("Will Deacon <will@kernel.org>");
 MODULE_LICENSE("GPL v2");
-- 
2.24.0.432.g9d3f5f5b63-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
