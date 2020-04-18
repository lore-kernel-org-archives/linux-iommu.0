Return-Path: <SRS0=tixU=6C=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A4AC3A5A0
	for <iommu@archiver.kernel.org>; Sat, 18 Apr 2020 13:46:00 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CFAA21BE5
	for <iommu@archiver.kernel.org>; Sat, 18 Apr 2020 13:46:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CFAA21BE5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 674BC880C2;
	Sat, 18 Apr 2020 13:45:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EcbebFDtzXug; Sat, 18 Apr 2020 13:45:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 720EE8807B;
	Sat, 18 Apr 2020 13:45:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5771DC089F;
	Sat, 18 Apr 2020 13:45:58 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 13D89C0172
 for <iommu@lists.linux-foundation.org>; Sat, 18 Apr 2020 13:45:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id E7EC92002D
 for <iommu@lists.linux-foundation.org>; Sat, 18 Apr 2020 13:45:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RvMSg9BwFckw for <iommu@lists.linux-foundation.org>;
 Sat, 18 Apr 2020 13:45:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from cmccmta1.chinamobile.com (cmccmta1.chinamobile.com
 [221.176.66.79])
 by silver.osuosl.org (Postfix) with ESMTP id 908192000A
 for <iommu@lists.linux-foundation.org>; Sat, 18 Apr 2020 13:45:49 +0000 (UTC)
Received: from spf.mail.chinamobile.com (unknown[172.16.121.13]) by
 rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee45e9b046fbee-aeef1;
 Sat, 18 Apr 2020 21:45:20 +0800 (CST)
X-RM-TRANSID: 2ee45e9b046fbee-aeef1
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.1.172.61])
 by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee75e9b046d98d-93ff7;
 Sat, 18 Apr 2020 21:45:19 +0800 (CST)
X-RM-TRANSID: 2ee75e9b046d98d-93ff7
From: Tang Bin <tangbin@cmss.chinamobile.com>
To: joro@8bytes.org, agross@kernel.org, bjorn.andersson@linaro.org,
 robdclark@gmail.com
Subject: [PATCH v2]iommu/qcom:fix local_base status check
Date: Sat, 18 Apr 2020 21:47:03 +0800
Message-Id: <20200418134703.1760-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Tang Bin <tangbin@cmss.chinamobile.com>
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

The function qcom_iommu_device_probe() does not perform sufficient
error checking after executing devm_ioremap_resource(), which can
result in crashes if a critical error path is encountered.

Fixes: 0ae349a0f33f ("iommu/qcom: Add qcom_iommu")

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
v2:
 - fix commit message and add fixed tag
---
 drivers/iommu/qcom_iommu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/qcom_iommu.c
index 4328da0b0..b160cf140 100644
--- a/drivers/iommu/qcom_iommu.c
+++ b/drivers/iommu/qcom_iommu.c
@@ -813,8 +813,11 @@ static int qcom_iommu_device_probe(struct platform_device *pdev)
 	qcom_iommu->dev = dev;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (res)
+	if (res) {
 		qcom_iommu->local_base = devm_ioremap_resource(dev, res);
+		if (IS_ERR(qcom_iommu->local_base))
+			return PTR_ERR(qcom_iommu->local_base);
+	}
 
 	qcom_iommu->iface_clk = devm_clk_get(dev, "iface");
 	if (IS_ERR(qcom_iommu->iface_clk)) {
-- 
2.20.1.windows.1



_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
