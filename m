Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F027C433F5
	for <iommu@archiver.kernel.org>; Sun, 27 Mar 2022 08:15:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E41616068A;
	Sun, 27 Mar 2022 08:15:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uOHvk3n7Bqiv; Sun, 27 Mar 2022 08:15:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CA7B66060A;
	Sun, 27 Mar 2022 08:15:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8E111C001D;
	Sun, 27 Mar 2022 08:15:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8C749C0012
 for <iommu@lists.linux-foundation.org>; Sun, 27 Mar 2022 05:36:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 73B8940025
 for <iommu@lists.linux-foundation.org>; Sun, 27 Mar 2022 05:36:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5kE7QSOa43fj for <iommu@lists.linux-foundation.org>;
 Sun, 27 Mar 2022 05:36:05 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4736F404C3
 for <iommu@lists.linux-foundation.org>; Sun, 27 Mar 2022 05:36:05 +0000 (UTC)
Received: by mail-pj1-x102e.google.com with SMTP id
 o68-20020a17090a0a4a00b001c686a48263so9651820pjo.1
 for <iommu@lists.linux-foundation.org>; Sat, 26 Mar 2022 22:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id;
 bh=BXdefmByfbS7iadyHNuWA+1dWRCSn9oFrWGYl5Fm5mk=;
 b=WD/emqxoTCqSinxwNm9zYC0BhVut37NKvVjalaC3AKb8//RwbBJ0HSEAfuKaQ4TRfn
 6kwLAZMOADsCvtCO24agk+3gzGKGTzkJYK5VEESmUvDd0AwLk8MOqqqbGIxQADK8aLnO
 cnQOeYl0dNZheOli0EHPxR4XCURTaCEwk+DA6AttIClrfhjRFRZ7eNgaXmT3Q5TRifxb
 oWKTyZ27SYlho/bS0fQMj4jMBTHcATU1sYK+99WO7WA4uv1bNod4RcYqMHfWk7DyqCSQ
 Qc0paAN62/Th0TsFECWtb5Pb6fzEURwe3BBOKcRwTf5utyKHkZHcplpnGv6lEJDDO1pv
 w6fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=BXdefmByfbS7iadyHNuWA+1dWRCSn9oFrWGYl5Fm5mk=;
 b=5d9t42b0O/xx8u2NMUSLVSlBwiYLPSqvmxwIuH/2Z+UPLdTvgoXS+ZC7g6I26T48xl
 tQBCxP14EpN5Z06aVD+xd5tZ/G/8vt1edu59Q+hOwQbZ317NItNj9f0uW6AdA++7ULuv
 G2F7rqmd2oqah4SGNMFYNCGGm6wIvOQk4S7QIuzcWk8RWNfBbCUEhlmASby6homuiDIX
 67o8n1TIC2DmB36RwvycgUd1hseIuT5X3SyfXjYujy56HMOetlziI1nkLqICSr2l/BxF
 B+1GSJslBnt0kWhZ1h58GxrKJu6v84tqBtuv0adSqj6ASjvVJxk3EU/mjobIwPmu7Nkx
 gyOA==
X-Gm-Message-State: AOAM531P7K7tT4Wp/0018fjUpyK+seu3nBqHW0uqYOx5aOFq6MDCZYkL
 TeJQ428eVb9vRlUTpwwQ6po=
X-Google-Smtp-Source: ABdhPJzLDpKQkrWzztdlJpJD0lzsWQyEl0Qpi9c3Hry9x9AKCEmmWC14C7eZiUH7Vhej5pAm1C+3YQ==
X-Received: by 2002:a17:90a:4217:b0:1c7:c203:b4f3 with SMTP id
 o23-20020a17090a421700b001c7c203b4f3mr18995680pjg.177.1648359364587; 
 Sat, 26 Mar 2022 22:36:04 -0700 (PDT)
Received: from localhost.localdomain ([115.220.243.108])
 by smtp.googlemail.com with ESMTPSA id
 u10-20020a63b54a000000b00380ea901cd2sm9296275pgo.6.2022.03.26.22.36.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Mar 2022 22:36:04 -0700 (PDT)
From: Xiaomeng Tong <xiam0nd.tong@gmail.com>
To: agross@kernel.org
Subject: [PATCH] iommu: fix an incorrect NULL check on list iterator
Date: Sun, 27 Mar 2022 13:35:58 +0800
Message-Id: <20220327053558.2821-1-xiam0nd.tong@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Mailman-Approved-At: Sun, 27 Mar 2022 08:15:21 +0000
Cc: will@kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 iommu@lists.linux-foundation.org, Xiaomeng Tong <xiam0nd.tong@gmail.com>,
 linux-arm-msm@vger.kernel.org
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

To fix the bug, run insert_iommu_master(dev, &iommu, spec); unlock and
return 0 when found, otherwise unlock and return -ENODEV.

Cc: stable@vger.kernel.org
Fixes: f78ebca8ff3d6 ("iommu/msm: Add support for generic master bindings")
Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>
---
 drivers/iommu/msm_iommu.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 3a38352b603f..1dbb8b0695ec 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -617,23 +617,17 @@ static int qcom_iommu_of_xlate(struct device *dev,
 {
 	struct msm_iommu_dev *iommu;
 	unsigned long flags;
-	int ret = 0;
 
 	spin_lock_irqsave(&msm_iommu_lock, flags);
 	list_for_each_entry(iommu, &qcom_iommu_devices, dev_node)
-		if (iommu->dev->of_node == spec->np)
-			break;
-
-	if (!iommu || iommu->dev->of_node != spec->np) {
-		ret = -ENODEV;
-		goto fail;
-	}
-
-	insert_iommu_master(dev, &iommu, spec);
-fail:
+		if (iommu->dev->of_node == spec->np) {
+			insert_iommu_master(dev, &iommu, spec);
+			spin_unlock_irqrestore(&msm_iommu_lock, flags);
+			return 0;
+		}
 	spin_unlock_irqrestore(&msm_iommu_lock, flags);
 
-	return ret;
+	return -ENODEV;
 }
 
 irqreturn_t msm_iommu_fault_handler(int irq, void *dev_id)
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
