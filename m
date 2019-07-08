Return-Path: <SRS0=EbOf=VF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B233C606C7
	for <iommu@archiver.kernel.org>; Mon,  8 Jul 2019 19:06:41 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 322C421783
	for <iommu@archiver.kernel.org>; Mon,  8 Jul 2019 19:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BZ4h87ls";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="j/6RQ0lc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 322C421783
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id F3EFE2A8E;
	Mon,  8 Jul 2019 19:06:38 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id DA37D2713
	for <iommu@lists.linux-foundation.org>;
	Mon,  8 Jul 2019 19:00:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id A6759148
	for <iommu@lists.linux-foundation.org>;
	Mon,  8 Jul 2019 19:00:54 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 84A6160F3A; Mon,  8 Jul 2019 19:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1562612454;
	bh=I0b5kpNA6visZ/gWW+mc9BO8uDwDyEu2oJKHrjDh8wg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BZ4h87lsLGeBEAx2O+AgC1rYn8+otI0cj8XmmIXtmCctr4x3OrcbSMfLhLEmJh822
	uKBlN96iyQbsVD+LxdawaI5q+WM447Yf7u6Hl7OV8aMrsFrdlQEHhXOwThf40Tx0kf
	zhZ4qB0UndPmaqgFVRsGZzHth8nyWAmpphCRPE30=
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com
	[199.106.103.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: jcrouse@smtp.codeaurora.org)
	by smtp.codeaurora.org (Postfix) with ESMTPSA id C46AA60DB3;
	Mon,  8 Jul 2019 19:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1562612453;
	bh=I0b5kpNA6visZ/gWW+mc9BO8uDwDyEu2oJKHrjDh8wg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j/6RQ0lcgs09AsxsnGCao8bbrT6qUd2DPh0MR0efFnAhUe6KgnozkZtRwbylGFr6A
	b9CEmNA4tJEH2UbDmLJMrf80JLikoi0asSPHlIxSOHUe6uuQVvy7+2yckYhGNF5DwH
	hkIXSF3uzZzUSu0Ik1jvhMMkpkGra0iYDuRkNqMQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C46AA60DB3
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
	dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
	spf=none smtp.mailfrom=jcrouse@codeaurora.org
From: Jordan Crouse <jcrouse@codeaurora.org>
To: freedreno@lists.freedesktop.org
Subject: [RESEND PATCH v2 1/3] iommu: Add DOMAIN_ATTR_SPLIT_TABLES
Date: Mon,  8 Jul 2019 13:00:45 -0600
Message-Id: <1562612447-19856-2-git-send-email-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1562612447-19856-1-git-send-email-jcrouse@codeaurora.org>
References: <1562612447-19856-1-git-send-email-jcrouse@codeaurora.org>
Cc: jean-philippe.brucker@arm.com, linux-arm-msm@vger.kernel.org,
	dianders@chromium.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, hoegsberg@google.com
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

Add a new domain attribute to enable split pagetable support for devices
devices that support it.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

 include/linux/iommu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index fdc355c..b06db6c 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -125,6 +125,7 @@ enum iommu_attr {
 	DOMAIN_ATTR_FSL_PAMUV1,
 	DOMAIN_ATTR_NESTING,	/* two stages of translation */
 	DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE,
+	DOMAIN_ATTR_SPLIT_TABLES,
 	DOMAIN_ATTR_MAX,
 };
 
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
