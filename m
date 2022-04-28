Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E9F7C433EF
	for <iommu@archiver.kernel.org>; Thu, 28 Apr 2022 09:00:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4619981276;
	Thu, 28 Apr 2022 09:00:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id urnLiQ6pg-PZ; Thu, 28 Apr 2022 09:00:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2F6A281292;
	Thu, 28 Apr 2022 09:00:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E8BEBC0039;
	Thu, 28 Apr 2022 09:00:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2303EC002D
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 09:00:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 01F1C4056E
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 09:00:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=foxmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pFIAIxBCrTtg for <iommu@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 09:00:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out203-205-221-245.mail.qq.com (out203-205-221-245.mail.qq.com
 [203.205.221.245])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A6E7A40198
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 09:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1651136421;
 bh=1YZv1zOYWKRjF1huRVXlo6mKgvTSjTUBeoIV4b4PtvQ=;
 h=From:To:Cc:Subject:Date;
 b=oskz8BIO6PH+HX0xWyK1sMvrs1rTClsHt2KJT60/NWwv7Sj2tp5YuNeFDP6aqEtIl
 xpZfe42289HkUsHyPDuIwHqR1ApoYHSUgzFPI9Rw77OCuYQEGhPR2rrbil+CctSdho
 v/cdq9f0j7A/OpVa1bd01U/lsDuzE0jZC1XZUe2s=
Received: from localhost.localdomain ([59.172.176.242])
 by newxmesmtplogicsvrszb6.qq.com (NewEsmtp) with SMTP
 id D3137827; Thu, 28 Apr 2022 16:52:49 +0800
X-QQ-mid: xmsmtpt1651135969t5qiwrf7v
Message-ID: <tencent_EDB94B1C7E14B4E1974A66FF4D2029CC6D08@qq.com>
X-QQ-XMAILINFO: MQ+wLuVvI2LQULY0Prs9k+SYrCIJ25n+J1FFbPzFDaLOs58lBVFosbs9muNjZO
 UkC5FRYale8I0tJQhZMnD/nNF1Vz++RhAUQPQYY1kxbAC/i3UeS57nhtQHjiGPTEXUIC9sgQ/vj0
 6pFCBZeTgpBCCwyN7nfohxjPOPs2KV5S66KuGJph61XB3D47DQudC+wkfULr7i7INNE1IbcAKsF7
 z5mQdiC1fpWt4ABJnM+UP82qL80FsyftAmZ4GzSIodBKxV0foXSoPbQM8pbdEXNXOj4y/nEUyNAk
 gMXE8OR5f1XLUHxCwUC9fBFx9L94N1ar7g8mycekJj5CMpYwWzHTuWcEFfHw17iXC6+hDfWz/dzn
 dVx/DsqNegIxEh8UznNw1NhxOVfm/tSYfGwpLNvFg24xszvB3N1Q7xVOtw/lsjitmm2Zn14N14x9
 T0ovUmfrXcIKQwKIwjyRpU5lGFJeMu0frDtVaojrqzm1skPkmY14BSyoHwxqwbxT6GpBZZMu9rrc
 1kSs5rUXHTxQvP2yS1cJFFrXpcMDc4Qay6bI3xKaKeVctigZKhyAwM60O5vK5rZiQYDE4yjf0KTo
 dzfYRbMZe1T9N14lsta04Vxpl9f0TrT/Uok5hjGXJ4xhL/AYMJnUkiFyfWREVPx61+pAgwXCznmu
 ySklUpDQultSP6YmOh+BOek5XzN8wG4JDpZCBf0iiP3QkEjOuJ/V8YumjfNpkkPczzZIBDDK+lZz
 TBlxIecqwwT+V0thIWg8ec/eWoFmS4qJAIoBfcOvDKIdLbrYkghw3Mgw+qWt3m2hp7tRcfnq73x4
 A1MjnJcoE2I92Gvp644tKRuTuSPpWZmLqSU3EsV9mbuuV86BnQoTjTi3s6Hh07u0XuqjUXV59qen
 oL8kyD/o20G2Wfyn3GwLAjoH3TG7ROERDv+4RVGjWclqoPXrqlia0oNmgr5+yysKzNm0REgkYUxP
 y0L3KWasBRa46yrBaytg==
From: xkernel.wang@foxmail.com
To: agross@kernel.org, bjorn.andersson@linaro.org, joro@8bytes.org,
 will@kernel.org
Subject: [PATCH v2] iommu/msm: add a check for the return of kzalloc()
Date: Thu, 28 Apr 2022 16:52:39 +0800
X-OQ-MSGID: <20220428085239.1287-1-xkernel.wang@foxmail.com>
MIME-Version: 1.0
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Xiaoke Wang <xkernel.wang@foxmail.com>
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

From: Xiaoke Wang <xkernel.wang@foxmail.com>

kzalloc() is a memory allocation function which can return NULL when
some internal memory errors happen. So it is better to check it to
prevent potential wrong memory access.

Besides, to propagate the error to the caller, the type of
insert_iommu_master() is changed to `int`. Several instructions related
to it are also updated.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
ChangeLog:
v1->v2 propagate the error to the caller.
 drivers/iommu/msm_iommu.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 3a38352..e3d109b 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -588,7 +588,7 @@ static void print_ctx_regs(void __iomem *base, int ctx)
 	       GET_SCTLR(base, ctx), GET_ACTLR(base, ctx));
 }
 
-static void insert_iommu_master(struct device *dev,
+static int insert_iommu_master(struct device *dev,
 				struct msm_iommu_dev **iommu,
 				struct of_phandle_args *spec)
 {
@@ -597,6 +597,10 @@ static void insert_iommu_master(struct device *dev,
 
 	if (list_empty(&(*iommu)->ctx_list)) {
 		master = kzalloc(sizeof(*master), GFP_ATOMIC);
+		if (!master) {
+			dev_err(dev, "Failed to allocate iommu_master\n");
+			return -ENOMEM;
+		}
 		master->of_node = dev->of_node;
 		list_add(&master->list, &(*iommu)->ctx_list);
 		dev_iommu_priv_set(dev, master);
@@ -606,10 +610,11 @@ static void insert_iommu_master(struct device *dev,
 		if (master->mids[sid] == spec->args[0]) {
 			dev_warn(dev, "Stream ID 0x%hx repeated; ignoring\n",
 				 sid);
-			return;
+			return 0;
 		}
 
 	master->mids[master->num_mids++] = spec->args[0];
+	return 0;
 }
 
 static int qcom_iommu_of_xlate(struct device *dev,
@@ -629,7 +634,7 @@ static int qcom_iommu_of_xlate(struct device *dev,
 		goto fail;
 	}
 
-	insert_iommu_master(dev, &iommu, spec);
+	ret = insert_iommu_master(dev, &iommu, spec);
 fail:
 	spin_unlock_irqrestore(&msm_iommu_lock, flags);
 
-- 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
