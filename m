Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82059C433EF
	for <iommu@archiver.kernel.org>; Wed, 16 Feb 2022 15:28:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 156884037E;
	Wed, 16 Feb 2022 15:28:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uL2foro5HcW3; Wed, 16 Feb 2022 15:28:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B84AF404A0;
	Wed, 16 Feb 2022 15:28:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 76A30C001A;
	Wed, 16 Feb 2022 15:28:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 138E8C000B;
 Wed, 16 Feb 2022 03:09:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DA93660B1C;
 Wed, 16 Feb 2022 03:09:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nKPAAop7zgYp; Wed, 16 Feb 2022 03:09:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 00DB960ADB;
 Wed, 16 Feb 2022 03:09:22 +0000 (UTC)
Received: by mail-qk1-x731.google.com with SMTP id d84so634634qke.8;
 Tue, 15 Feb 2022 19:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=3GJiORRsTVx+yI2/L1IdZTmJe+M7rTwA6x3mOQDXVmQ=;
 b=SIjbG25UuDR5aWFLNo606A8KF9DC/7h0SWpcFFgf6fkS1OwT65cGA70qwzWHLZncEd
 CKNlFo1bveItVQzjUhNwDqbcVe4rOA5FLW/BtpegisoNtmbFMZvB05jF0F5W7KFJLmqd
 Mxu9sLFetgolC5CmZoneMvEknSK1AjCBGPA5ZmEEP68z0lndpEKeTxyVxfvIAp8vWzQO
 K7xtYZj6gxoR1yt0LviOsLyd5Y87zJu/R3aT/VD7Z4G+AjeV1rF79HFB3i+BYQlVNFP3
 OHXjRdWyuXp9MfU2z/RNMesNcgqyq5bQflChawFX2z6rCQrOCNOVXi3fSrba6EKM1RcN
 9y2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=3GJiORRsTVx+yI2/L1IdZTmJe+M7rTwA6x3mOQDXVmQ=;
 b=grWJf4Ompf74OHFSMe7yMBQjl0jwElTl3s7KZl/aiXc0Zny/+K0npNUhqGTs0nL/UC
 cBsung/DdZujldyTL7sA+4yZkRDcSF9eZnvjn84EwqgY2etRC6SB6fgIoZ8W/sIq4Rmt
 WYg+IjQq/wpo969h7PSltD6NwQxfqBMVrmMS1Lik4JXd7/2cEAef4bNOKQDGaggrQCK4
 UQBak2qi6x37Tx+rq4MrEWq4hespLcSx8aOSSocAD6fM7L/IiPe+dY4Wn5ka36PnNANp
 JHlnvyQG8MzoWoBK2Z13IhNvRaL1DEfaPUovnWqFoPYs1zAEzpmUyhY5zIioc8F90bdq
 AKrg==
X-Gm-Message-State: AOAM5336/PXPn67N4pJsBcbWVDjbB9NwNMD/0NKfiMia6OA7fOremhfw
 ob8Ag9DDwtUOGtazMjLokAE=
X-Google-Smtp-Source: ABdhPJzmmNSnD5rQfwI01b677/YcsxCSxr089THSIYQVmFvMExzZkLYzsGK6DY8AnSAM7vXZeoqnBQ==
X-Received: by 2002:a05:620a:2699:b0:47d:753c:b8ff with SMTP id
 c25-20020a05620a269900b0047d753cb8ffmr383744qkp.763.1644980961930; 
 Tue, 15 Feb 2022 19:09:21 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
 by smtp.gmail.com with ESMTPSA id k20sm20635330qtx.64.2022.02.15.19.09.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Feb 2022 19:09:21 -0800 (PST)
From: cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To: jean-philippe@linaro.org
Subject: [PATCH] drivers/iommu: use struct_size over open coded arithmetic
Date: Wed, 16 Feb 2022 03:09:16 +0000
Message-Id: <20220216030916.1839742-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 16 Feb 2022 15:28:35 +0000
Cc: linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 will@kernel.org, Zeal Robot <zealci@zte.com.cn>
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

From: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>

Replace zero-length array with flexible-array member and make use
of the struct_size() helper in kzalloc(). For example:

struct viommu_request {
	...
	unsigned int			len;
	char				buf[];
};

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>
---
 drivers/iommu/virtio-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index f2aa34f57454..0996d9c7c358 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -231,7 +231,7 @@ static int __viommu_add_req(struct viommu_dev *viommu, void *buf, size_t len,
 	if (write_offset <= 0)
 		return -EINVAL;
 
-	req = kzalloc(sizeof(*req) + len, GFP_ATOMIC);
+	req = kzalloc(struct_size(req, buf, len), GFP_ATOMIC);
 	if (!req)
 		return -ENOMEM;
 
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
