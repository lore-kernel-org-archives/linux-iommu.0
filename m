Return-Path: <SRS0=5N08=DA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA19C4363D
	for <iommu@archiver.kernel.org>; Wed, 23 Sep 2020 15:00:00 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3131F206FB
	for <iommu@archiver.kernel.org>; Wed, 23 Sep 2020 14:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="Us9uZya3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3131F206FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id B42BF8671B;
	Wed, 23 Sep 2020 14:59:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xzzUTcCC8ccW; Wed, 23 Sep 2020 14:59:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id BCDF986700;
	Wed, 23 Sep 2020 14:59:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 88714C0859;
	Wed, 23 Sep 2020 14:59:58 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0A349C0051
 for <iommu@lists.linux-foundation.org>; Wed, 23 Sep 2020 14:53:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 04E2D84B80
 for <iommu@lists.linux-foundation.org>; Wed, 23 Sep 2020 14:53:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Rjiw707kPycL for <iommu@lists.linux-foundation.org>;
 Wed, 23 Sep 2020 14:53:57 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from m42-4.mailgun.net (m42-4.mailgun.net [69.72.42.4])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 5059384C9F
 for <iommu@lists.linux-foundation.org>; Wed, 23 Sep 2020 14:53:57 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1600872837; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=E8EY+ZCQ/E+6/fGqtQk7cFqKhQr66yDJmc66sl86p9U=;
 b=Us9uZya3lUHMlLBn6WfO6HQw+brUwbx8OQUlkMCeIVQQ/tfy/xHmxHytAiirWyetZIyGmWc3
 bqlsxK43YCeO90Cqg/ad38u+QOalvAKBsyJHgILo1/FhIgo0YEibsOcvVaEsv2cjklj5xaim
 jHMH9RpFK58fbiAlzGQAjM5Y3w0=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5f6b618451ea4325f30b0648 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 23 Sep 2020 14:53:56
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 60DA4C433FE; Wed, 23 Sep 2020 14:53:56 +0000 (UTC)
Received: from charante-linux.qualcomm.com (unknown [202.46.22.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: charante)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 50FEDC433CA;
 Wed, 23 Sep 2020 14:53:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 50FEDC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=fail smtp.mailfrom=charante@codeaurora.org
From: Charan Teja Reddy <charante@codeaurora.org>
To: joro@8bytes.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH] iommu: of: skip iommu_device_list traversal in
 of_iommu_xlate()
Date: Wed, 23 Sep 2020 20:23:46 +0530
Message-Id: <1600872826-2254-1-git-send-email-charante@codeaurora.org>
X-Mailer: git-send-email 2.7.4
X-Mailman-Approved-At: Wed, 23 Sep 2020 14:59:57 +0000
Cc: Charan Teja Reddy <charante@codeaurora.org>, linux-kernel@vger.kernel.org
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

In of_iommu_xlate(), check if iommu device is enabled before traversing
the iommu_device_list through iommu_ops_from_fwnode(). It is of no use
in traversing the iommu_device_list only to return NO_IOMMU because of
iommu device node is disabled.

Signed-off-by: Charan Teja Reddy <charante@codeaurora.org>
---
 drivers/iommu/of_iommu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index e505b91..225598c 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -94,9 +94,10 @@ static int of_iommu_xlate(struct device *dev,
 	struct fwnode_handle *fwnode = &iommu_spec->np->fwnode;
 	int ret;
 
+	if (!of_device_is_available(iommu_spec->np))
+		return NO_IOMMU;
 	ops = iommu_ops_from_fwnode(fwnode);
-	if ((ops && !ops->of_xlate) ||
-	    !of_device_is_available(iommu_spec->np))
+	if (ops && !ops->of_xlate)
 		return NO_IOMMU;
 
 	ret = iommu_fwspec_init(dev, &iommu_spec->np->fwnode, ops);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of the Code Aurora Forum, hosted by The Linux Foundation

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
