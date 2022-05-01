Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA6D9C433EF
	for <iommu@archiver.kernel.org>; Sun,  1 May 2022 13:13:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 65FB860B6C;
	Sun,  1 May 2022 13:13:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N290RUtQteo6; Sun,  1 May 2022 13:13:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7089360B02;
	Sun,  1 May 2022 13:13:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1FDACC0032;
	Sun,  1 May 2022 13:13:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5B888C002D
 for <iommu@lists.linux-foundation.org>; Sun,  1 May 2022 13:13:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 49AFF409FF
 for <iommu@lists.linux-foundation.org>; Sun,  1 May 2022 13:13:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Snz0EBHavWaJ for <iommu@lists.linux-foundation.org>;
 Sun,  1 May 2022 13:13:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0AD42409FB
 for <iommu@lists.linux-foundation.org>; Sun,  1 May 2022 13:13:08 +0000 (UTC)
Received: by mail-pj1-x1034.google.com with SMTP id
 j8-20020a17090a060800b001cd4fb60dccso10875816pjj.2
 for <iommu@lists.linux-foundation.org>; Sun, 01 May 2022 06:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id;
 bh=dJZi+/WPdcKxjEapwSjUsXGWCJvPbK+sm/8N0ec5JVY=;
 b=Jskd7h6x/6zw2xzs8eqnb0NFuea/abFEwnRJTo/pxFCDlXX7fzm8k0E1uG+6zWlQnR
 8IRq9pZyxa+ObcYF+gD/i8OryJpGhh3o7bf/ghJYSmxxEapNTEBuOh22JNAl4U9ROWb6
 PY2st7shkaVyIwnLgYDTVD2S28x++/9ClFWdquJbJiMzHpsUkIw1WpprK/pj0NwC7fTX
 5q+xnbpTkwIn6l0bOLFZ9ngY/mleoXvfvZshSEMo6VAGwnsW8IxIzYTY9AHa6ehX0CnN
 jic7d/pQKTkVLLgB5BanvFMdcjfAziOoWKPQ9q8QO2XBEoYlrdI6+m6IY5gA9nhiogkK
 JUEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=dJZi+/WPdcKxjEapwSjUsXGWCJvPbK+sm/8N0ec5JVY=;
 b=VUJIWiJHi4fqpTjYXQbl97nVEWskvZinK4LaMmSVx9nL5zbGFbwN2ZTMk2uqaekJVP
 2lg/eJJDaiFqnCyYh9p6smnIUtrppFM0eBOOdJE2NEitO0GUBLbaY0CMUfPjxoMUG+LC
 otUTGAkizk7gbHmTs5b5L1E9VLGS0jL45k706P6xC5xGxAUpFtJE18U5dKhhrzJ46TWm
 OKCLz95JaLdT0irt//Tc36Z9GL7SkqiBxybRCvtd6E7NV/91HInD2hrAQhzZHGKjXiMy
 et6M1ECKtjeJT4vi2z0dth6naZE16KhoSQclg2N8JLFo2RHNptBF9zXvSLar9LM+s1T3
 QXJg==
X-Gm-Message-State: AOAM531LsHrYX4i8ZwTByLxbzcspUnyFhJj4MFrJXGDwrfEEgTOEwD/p
 LMSL5/+H10AyhhZSQeGkJjs=
X-Google-Smtp-Source: ABdhPJyqTwaVt+oGV9vys0cmrU4vLLMTpOIRjlB/xJbxkk1sPItJb9mAls593fhVzKrnghUOS9+W1w==
X-Received: by 2002:a17:90b:4b81:b0:1dc:4dfe:9b01 with SMTP id
 lr1-20020a17090b4b8100b001dc4dfe9b01mr2896477pjb.110.1651410788431; 
 Sun, 01 May 2022 06:13:08 -0700 (PDT)
Received: from localhost.localdomain ([122.233.238.54])
 by smtp.gmail.com with ESMTPSA id
 7-20020a631347000000b003c14af505fcsm9561252pgt.20.2022.05.01.06.13.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 May 2022 06:13:07 -0700 (PDT)
From: Xiaomeng Tong <xiam0nd.tong@gmail.com>
To: agross@kernel.org, bjorn.andersson@linaro.org, joro@8bytes.org,
 will@kernel.org, sricharan@codeaurora.org
Subject: [PATCH v2] iommu: fix an incorrect NULL check on list iterator
Date: Sun,  1 May 2022 21:12:59 +0800
Message-Id: <20220501131259.11529-1-xiam0nd.tong@gmail.com>
X-Mailer: git-send-email 2.17.1
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
 Xiaomeng Tong <xiam0nd.tong@gmail.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
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

The bug is here:
	if (!iommu || iommu->dev->of_node != spec->np) {

The list iterator value 'iommu' will *always* be set and non-NULL by
list_for_each_entry(), so it is incorrect to assume that the iterator
value will be NULL if the list is empty or no element is found (in fact,
it will point to a invalid structure object containing HEAD).

To fix the bug, use a new value 'iter' as the list iterator, while use
the old value 'iommu' as a dedicated variable to point to the found one,
and remove the unneeded check for 'iommu->dev->of_node != spec->np'
outside the loop.

Cc: stable@vger.kernel.org
Fixes: f78ebca8ff3d6 ("iommu/msm: Add support for generic master bindings")
Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>
---
changes since v1:
 - add a new iter variable (suggested by Joerg Roedel)

v1: https://lore.kernel.org/all/20220327053558.2821-1-xiam0nd.tong@gmail.com/
---
 drivers/iommu/msm_iommu.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 3a38352b603f..41a3231a6d13 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -615,16 +615,17 @@ static void insert_iommu_master(struct device *dev,
 static int qcom_iommu_of_xlate(struct device *dev,
 			       struct of_phandle_args *spec)
 {
-	struct msm_iommu_dev *iommu;
+	struct msm_iommu_dev *iommu = NULL, *iter;
 	unsigned long flags;
-	int ret = 0;
 
 	spin_lock_irqsave(&msm_iommu_lock, flags);
-	list_for_each_entry(iommu, &qcom_iommu_devices, dev_node)
-		if (iommu->dev->of_node == spec->np)
+	list_for_each_entry(iter, &qcom_iommu_devices, dev_node)
+		if (iter->dev->of_node == spec->np) {
+			iommu = iter;
 			break;
+		}
 
-	if (!iommu || iommu->dev->of_node != spec->np) {
+	if (!iommu) {
 		ret = -ENODEV;
 		goto fail;
 	}
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
