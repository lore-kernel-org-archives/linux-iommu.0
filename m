Return-Path: <SRS0=c0M2=2J=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75186C43603
	for <iommu@archiver.kernel.org>; Thu, 19 Dec 2019 12:04:32 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A4AF24672
	for <iommu@archiver.kernel.org>; Thu, 19 Dec 2019 12:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XL+3ciAA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A4AF24672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 180C587F08;
	Thu, 19 Dec 2019 12:04:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uyN7Yg8eI448; Thu, 19 Dec 2019 12:04:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 12F3787EFB;
	Thu, 19 Dec 2019 12:04:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0E39FC18DC;
	Thu, 19 Dec 2019 12:04:31 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 60DE8C077D
 for <iommu@lists.linuxfoundation.org>; Thu, 19 Dec 2019 12:04:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 5AD7F86F41
 for <iommu@lists.linuxfoundation.org>; Thu, 19 Dec 2019 12:04:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wZ2WJu1NpiYI for <iommu@lists.linuxfoundation.org>;
 Thu, 19 Dec 2019 12:04:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id D880D81E4F
 for <iommu@lists.linuxfoundation.org>; Thu, 19 Dec 2019 12:04:29 +0000 (UTC)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
 [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 576E7222C2;
 Thu, 19 Dec 2019 12:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1576757069;
 bh=3tpbtnl8OY57w2rdlJWwXlJgag79sYKXgNFcccIKSe4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=XL+3ciAAMACO2HKpFvxi0nRHLegR8Vt+TjRCNvBEv+grJOqV00RgTzinj0z6gAcrt
 qoQWFRj8DKrlJaVwOnl1Vjs3uyVPVL0Fu5GTgg+i+ScfWenIhTL98VixOPjWirl53d
 tsRxwCPrdQTnfACHG1eQHfjQ/7hRKyL3M4qfVqxY=
From: Will Deacon <will@kernel.org>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linuxfoundation.org
Subject: [PATCH v4 10/16] iommu/arm-smmu: Prevent forced unbinding of Arm SMMU
 drivers
Date: Thu, 19 Dec 2019 12:03:46 +0000
Message-Id: <20191219120352.382-11-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191219120352.382-1-will@kernel.org>
References: <20191219120352.382-1-will@kernel.org>
MIME-Version: 1.0
Cc: "Isaac J. Manjarres" <isaacm@codeaurora.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
 Robin Murphy <robin.murphy@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Will Deacon <will@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>
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

Forcefully unbinding the Arm SMMU drivers is a pretty dangerous operation,
since it will likely lead to catastrophic failure for any DMA devices
mastering through the SMMU being unbound. When the driver then attempts
to "handle" the fatal faults, it's very easy to trip over dead data
structures, leading to use-after-free.

On John's machine, he reports that the machine was "unusable" due to
loss of the storage controller following a forced unbind of the SMMUv3
driver:

  | # cd ./bus/platform/drivers/arm-smmu-v3
  | # echo arm-smmu-v3.0.auto > unbind
  | hisi_sas_v2_hw HISI0162:01: CQE_AXI_W_ERR (0x800) found!
  | platform arm-smmu-v3.0.auto: CMD_SYNC timeout at 0x00000146
  | [hwprod 0x00000146, hwcons 0x00000000]

Prevent this forced unbinding of the drivers by setting "suppress_bind_attrs"
to true.

Link: https://lore.kernel.org/lkml/06dfd385-1af0-3106-4cc5-6a5b8e864759@huawei.com
Reported-by: John Garry <john.garry@huawei.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/iommu/arm-smmu-v3.c | 5 +++--
 drivers/iommu/arm-smmu.c    | 7 ++++---
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 68163b1d680d..9d4c9de6172d 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -3700,8 +3700,9 @@ MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
 
 static struct platform_driver arm_smmu_driver = {
 	.driver	= {
-		.name		= "arm-smmu-v3",
-		.of_match_table	= of_match_ptr(arm_smmu_of_match),
+		.name			= "arm-smmu-v3",
+		.of_match_table		= of_match_ptr(arm_smmu_of_match),
+		.suppress_bind_attrs	= true,
 	},
 	.probe	= arm_smmu_device_probe,
 	.remove	= arm_smmu_device_remove,
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 7c768f771001..5cbee88a3b83 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -2268,9 +2268,10 @@ static const struct dev_pm_ops arm_smmu_pm_ops = {
 
 static struct platform_driver arm_smmu_driver = {
 	.driver	= {
-		.name		= "arm-smmu",
-		.of_match_table	= of_match_ptr(arm_smmu_of_match),
-		.pm		= &arm_smmu_pm_ops,
+		.name			= "arm-smmu",
+		.of_match_table		= of_match_ptr(arm_smmu_of_match),
+		.pm			= &arm_smmu_pm_ops,
+		.suppress_bind_attrs    = true,
 	},
 	.probe	= arm_smmu_device_probe,
 	.remove	= arm_smmu_device_remove,
-- 
2.24.1.735.g03f4e72817-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
