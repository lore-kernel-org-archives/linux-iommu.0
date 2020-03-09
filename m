Return-Path: <SRS0=J+1i=42=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC08FC18E5A
	for <iommu@archiver.kernel.org>; Mon,  9 Mar 2020 18:47:58 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A64FB215A4
	for <iommu@archiver.kernel.org>; Mon,  9 Mar 2020 18:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="TsyklB8B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A64FB215A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5C1C3872B9;
	Mon,  9 Mar 2020 18:47:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CkbiLdBiDpYe; Mon,  9 Mar 2020 18:47:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 99FBD87281;
	Mon,  9 Mar 2020 18:47:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 85B2AC1D89;
	Mon,  9 Mar 2020 18:47:57 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2F418C0177
 for <iommu@lists.linux-foundation.org>; Mon,  9 Mar 2020 18:23:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 186A587B4D
 for <iommu@lists.linux-foundation.org>; Mon,  9 Mar 2020 18:23:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nNbt-rSsUr3R for <iommu@lists.linux-foundation.org>;
 Mon,  9 Mar 2020 18:23:41 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail26.static.mailgun.info (mail26.static.mailgun.info
 [104.130.122.26])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 329D387B36
 for <iommu@lists.linux-foundation.org>; Mon,  9 Mar 2020 18:23:39 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1583778221; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=5pJKzeW4cHTF7+UFcjOH7U5y2zK8JxKCVKx6r3Uqg0I=;
 b=TsyklB8BllIlTKjZbsjOee56tm/AYgv3oQK6bCrrHR6YkHH87zTAW4hX2JGmvMySe4jT/0rL
 hWoXZvs/1yx0qnyGmJwPenVuwCST78K5Cd5NTEDGQwOGGf/aYnqxvpb5b96OSWy+Lam3546B
 OYCRJ5/xBRH/vJ0il8eJWN1DCik=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e66899e.7f98a374e768-smtp-out-n03;
 Mon, 09 Mar 2020 18:23:26 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 012F0C44788; Mon,  9 Mar 2020 18:23:26 +0000 (UTC)
Received: from blr-ubuntu-87.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: sibis)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 85160C43636;
 Mon,  9 Mar 2020 18:23:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 85160C43636
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=none smtp.mailfrom=sibis@codeaurora.org
From: Sibi Sankar <sibis@codeaurora.org>
To: bjorn.andersson@linaro.org,
	robh+dt@kernel.org,
	joro@8bytes.org
Subject: [PATCH 1/3] iommu: Export "iommu_request_dm_for_dev"
Date: Mon,  9 Mar 2020 23:52:53 +0530
Message-Id: <20200309182255.20142-2-sibis@codeaurora.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200309182255.20142-1-sibis@codeaurora.org>
References: <20200309182255.20142-1-sibis@codeaurora.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 09 Mar 2020 18:47:56 +0000
Cc: ohad@wizery.com, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, agross@kernel.org,
 Sibi Sankar <sibis@codeaurora.org>
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

Export "iommu_request_dm_for_dev" to allow for modular builds of
drivers requesting for direct mapping.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 drivers/iommu/iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 3e3528436e0b2..06a36230fe22d 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2353,6 +2353,7 @@ int iommu_request_dm_for_dev(struct device *dev)
 {
 	return request_default_domain_for_dev(dev, IOMMU_DOMAIN_IDENTITY);
 }
+EXPORT_SYMBOL_GPL(iommu_request_dm_for_dev);
 
 /* Request that a device can't be direct mapped by the IOMMU */
 int iommu_request_dma_domain_for_dev(struct device *dev)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
