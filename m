Return-Path: <SRS0=EbOf=VF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0512EC606C7
	for <iommu@archiver.kernel.org>; Mon,  8 Jul 2019 19:06:45 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D00C721783
	for <iommu@archiver.kernel.org>; Mon,  8 Jul 2019 19:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UxNN0yHo";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Upbw5W/d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D00C721783
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 3A4BE2A87;
	Mon,  8 Jul 2019 19:06:39 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 35BF42713
	for <iommu@lists.linux-foundation.org>;
	Mon,  8 Jul 2019 19:00:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id E2644826
	for <iommu@lists.linux-foundation.org>;
	Mon,  8 Jul 2019 19:00:58 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 91F6F61132; Mon,  8 Jul 2019 19:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1562612458;
	bh=8vvsLWPcHr0znTAIRbRfTb5WuDfVnCumJ8bN1RXKkaU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UxNN0yHo5CGNXp+ydx2bLZKC7mWjNgmQZpII3uS3MUzx43T9fSWWLazEneidMzkVH
	ybKQmUS8pzWITStApDsRyi6nSkq81E+x2N5lh/yGBVPr3meYM1PWBTR0MsFVh5qxBC
	YT4EFbLbgSHQG2haAy42AbpMJoTbKuNEz00nGuHk=
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com
	[199.106.103.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: jcrouse@smtp.codeaurora.org)
	by smtp.codeaurora.org (Postfix) with ESMTPSA id 3F59660E40;
	Mon,  8 Jul 2019 19:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1562612456;
	bh=8vvsLWPcHr0znTAIRbRfTb5WuDfVnCumJ8bN1RXKkaU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Upbw5W/djHsjIjuGf3gIhOy7HFDE4loB2ekFEU8qBMXVqNg4kaM4fLsyTssaxk5D1
	jHSu0mL/YhTYrNDb71e9+JvNqt7t87D7uj2fjYpvwVSQ3zTjPtmx0/wb2H8ffeXsmY
	92papmWE9htJ+GplCCwMzha46zOrNt6UtgY+Rvf0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3F59660E40
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
	dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
	spf=none smtp.mailfrom=jcrouse@codeaurora.org
From: Jordan Crouse <jcrouse@codeaurora.org>
To: freedreno@lists.freedesktop.org
Subject: [RESEND PATCH v2 3/3] iommu/arm-smmu: Add support for
	DOMAIN_ATTR_SPLIT_TABLES
Date: Mon,  8 Jul 2019 13:00:47 -0600
Message-Id: <1562612447-19856-4-git-send-email-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1562612447-19856-1-git-send-email-jcrouse@codeaurora.org>
References: <1562612447-19856-1-git-send-email-jcrouse@codeaurora.org>
Cc: jean-philippe.brucker@arm.com, linux-arm-msm@vger.kernel.org,
	dianders@chromium.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, hoegsberg@google.com,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

When DOMAIN_ATTR_SPLIT_TABLES is specified for pass ARM_64_LPAE_SPLIT_S1
to io_pgtable_ops to allocate and initialize TTBR0 and TTBR1 pagetables.

v3: Moved all the pagetable specific work into io-pgtable-arm
in a previous patch.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

 drivers/iommu/arm-smmu.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 653b6b3..7a6b4bb 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -257,6 +257,7 @@ struct arm_smmu_domain {
 	bool				non_strict;
 	struct mutex			init_mutex; /* Protects smmu pointer */
 	spinlock_t			cb_lock; /* Serialises ATS1* ops and TLB syncs */
+	u32 attributes;
 	struct iommu_domain		domain;
 };
 
@@ -832,7 +833,11 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 		ias = smmu->va_size;
 		oas = smmu->ipa_size;
 		if (cfg->fmt == ARM_SMMU_CTX_FMT_AARCH64) {
-			fmt = ARM_64_LPAE_S1;
+			if (smmu_domain->attributes &
+				(1 << DOMAIN_ATTR_SPLIT_TABLES))
+				fmt = ARM_64_LPAE_SPLIT_S1;
+			else
+				fmt = ARM_64_LPAE_S1;
 		} else if (cfg->fmt == ARM_SMMU_CTX_FMT_AARCH32_L) {
 			fmt = ARM_32_LPAE_S1;
 			ias = min(ias, 32UL);
@@ -1582,6 +1587,10 @@ static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
 		case DOMAIN_ATTR_NESTING:
 			*(int *)data = (smmu_domain->stage == ARM_SMMU_DOMAIN_NESTED);
 			return 0;
+		case DOMAIN_ATTR_SPLIT_TABLES:
+			*(int *)data = !!(smmu_domain->attributes &
+				(1 << DOMAIN_ATTR_SPLIT_TABLES));
+			return 0;
 		default:
 			return -ENODEV;
 		}
@@ -1622,6 +1631,11 @@ static int arm_smmu_domain_set_attr(struct iommu_domain *domain,
 			else
 				smmu_domain->stage = ARM_SMMU_DOMAIN_S1;
 			break;
+		case DOMAIN_ATTR_SPLIT_TABLES:
+			if (*((int *)data))
+				smmu_domain->attributes |=
+					(1 << DOMAIN_ATTR_SPLIT_TABLES);
+			break;
 		default:
 			ret = -ENODEV;
 		}
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
