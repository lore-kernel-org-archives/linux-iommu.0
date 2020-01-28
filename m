Return-Path: <SRS0=+4f7=3R=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B15C35249
	for <iommu@archiver.kernel.org>; Tue, 28 Jan 2020 22:00:51 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5BF824687
	for <iommu@archiver.kernel.org>; Tue, 28 Jan 2020 22:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="aHhxCqQM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5BF824687
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4AFA788042;
	Tue, 28 Jan 2020 22:00:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6ya2-dzSLlhn; Tue, 28 Jan 2020 22:00:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id AAEBA88049;
	Tue, 28 Jan 2020 22:00:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 919E4C0171;
	Tue, 28 Jan 2020 22:00:50 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1029EC1D8A
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jan 2020 22:00:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id EF56420523
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jan 2020 22:00:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7KEz9FbenXB2 for <iommu@lists.linux-foundation.org>;
 Tue, 28 Jan 2020 22:00:47 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail26.static.mailgun.info (mail26.static.mailgun.info
 [104.130.122.26])
 by silver.osuosl.org (Postfix) with ESMTPS id 454281FEBF
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jan 2020 22:00:44 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1580248847; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=3XTHOrqJBEezFPn/s5nwaKJiKFWkMkhGMTc5GyAom3o=;
 b=aHhxCqQMMxrW5LaEpjenjUb0jTlqNozaptKMChjd36Pmlc2KcaMf7U5fIdGozhuYb0dF3NrD
 VbvpkLrvrWFBBrfGOneIb5Dl2VnaSXQfr2pm3op539OBrpGQrQYnhgW1Z8Um7DaCnEn4OuHJ
 QSRT4d8lcS4DEmegi8wl03dIoyU=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e30af04.7f52696df260-smtp-out-n03;
 Tue, 28 Jan 2020 22:00:36 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 9F4B4C447AB; Tue, 28 Jan 2020 22:00:34 +0000 (UTC)
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: jcrouse)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 9C64DC433CB;
 Tue, 28 Jan 2020 22:00:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9C64DC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=none smtp.mailfrom=jcrouse@codeaurora.org
From: Jordan Crouse <jcrouse@codeaurora.org>
To: iommu@lists.linux-foundation.org
Subject: [PATCH v5 1/5] iommu: Add DOMAIN_ATTR_SPLIT_TABLES
Date: Tue, 28 Jan 2020 15:00:15 -0700
Message-Id: <1580248819-12644-2-git-send-email-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580248819-12644-1-git-send-email-jcrouse@codeaurora.org>
References: <1580248819-12644-1-git-send-email-jcrouse@codeaurora.org>
Cc: robin.murphy@arm.com, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, will@kernel.org,
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

Add a new attribute to enable and query the state of split pagetables
for the domain.

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

 include/linux/iommu.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index d1b5f4d..b14398b 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -126,6 +126,8 @@ enum iommu_attr {
 	DOMAIN_ATTR_FSL_PAMUV1,
 	DOMAIN_ATTR_NESTING,	/* two stages of translation */
 	DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE,
+	/* Enable split pagetables (for example, TTBR1 on arm-smmu) */
+	DOMAIN_ATTR_SPLIT_TABLES,
 	DOMAIN_ATTR_MAX,
 };
 
-- 
2.7.4
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
