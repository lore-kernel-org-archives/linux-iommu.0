Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6B25C433EF
	for <iommu@archiver.kernel.org>; Fri, 10 Dec 2021 20:57:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6BDF342770;
	Fri, 10 Dec 2021 20:57:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w8hBZn5za0Tw; Fri, 10 Dec 2021 20:57:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5C24E4275A;
	Fri, 10 Dec 2021 20:57:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2DC53C001E;
	Fri, 10 Dec 2021 20:57:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0E33CC0012
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 20:57:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EA62A42768
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 20:57:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dRah55fI9_h9 for <iommu@lists.linux-foundation.org>;
 Fri, 10 Dec 2021 20:57:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 30A0F4275A
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 20:57:08 +0000 (UTC)
Received: by mail-ot1-x329.google.com with SMTP id
 35-20020a9d08a6000000b00579cd5e605eso10924226otf.0
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 12:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wobD4Jbzi5ufjdCOWA/nVYk8n1ISd9Z61aPS0wQf5zE=;
 b=JdY2WDN2p461FkGvsxWWgssB5bJvFhZYhUHH63DdzZaOS/BF8ZQTp0ZRohildNIGfX
 alWei8hF/dOiYXd1Z9hS5CEigliRsXzQO8xzs+kxd+ajDHK3eNMRM87q4Ju4rj6fd/gv
 lYsbndjN7dSsbgrIBFXGjMTA4PdACS//XRVN3ZbYkoy1n3FT5jlT/d0jDR4IQCv9A+Uy
 KByWYGgTkvVMxsGsOL2XYtQWqLYAPwOihXIJCui3XCZ95CJhgQCB1P4mw+mNY823BKGt
 0I8P5dypvRWs2TbprRkp1owmaruN+NMkRC5sjMK6j3MfLzBbi2qubfSIZVBUZhE9ccKN
 zL7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=wobD4Jbzi5ufjdCOWA/nVYk8n1ISd9Z61aPS0wQf5zE=;
 b=ai3yKFRIZn6rTy9KmyBZPlT0N6CppWi3yF0vHCVqBJaCgrL8R6EKBaFZHsFzV05d+h
 Z1rl5lmviQoDJNkBPSZNUSYX96YWCGjdRXMvHk4zxkfHi4aklHgLOxDMERY2Ol8Z3WBL
 c9ujvuhLymKCzAc26SSy3HS0Voqw/JtQCGYkLST60Z4YXCLTlsNnMVJyt1yQK03+xCeA
 5ixb5qN6ebuzO5b8ngyEnDZeMsIVzanYcYtGUJlizWbDEGzkXiYPj9WRB488uGaRZt6o
 G3dmwH/SBBJp0/iwk9EhTg34X2XX4bzi0WowTi+2YIDrgCSXGXKsk6IC1Yu1onphhy0b
 LuyQ==
X-Gm-Message-State: AOAM533qFPD+LnUZocguoYdQP7Cif2p4VGAECHz7PvoUX+yrJMHVMsfV
 L/IHLi3+JXtfA2lnHUr4K4Q=
X-Google-Smtp-Source: ABdhPJwjZrKA3qk3BYYk+5CCrYVxJPalsMFrhHqeEmEj9Q654spZxrRQ5lvqR74363+dwnEBfK8Nyg==
X-Received: by 2002:a05:6830:314b:: with SMTP id
 c11mr12958654ots.224.1639169827221; 
 Fri, 10 Dec 2021 12:57:07 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 t13sm926128oiw.30.2021.12.10.12.57.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Dec 2021 12:57:06 -0800 (PST)
From: Guenter Roeck <linux@roeck-us.net>
To: Yong Wu <yong.wu@mediatek.com>
Subject: [PATCH] iommu/mediatek: Validate number of phandles associated with
 "mediatek, larbs"
Date: Fri, 10 Dec 2021 12:57:04 -0800
Message-Id: <20211210205704.1664928-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Cc: kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 Guenter Roeck <linux@roeck-us.net>, Matthias Brugger <matthias.bgg@gmail.com>,
 Dan Carpenter <dan.carpenter@oracle.com>, Will Deacon <will@kernel.org>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Since commit baf94e6ebff9 ("iommu/mediatek: Add device link for smi-common
and m4u"), the driver assumes that at least one phandle associated with
"mediatek,larbs" exists. If that is not the case, for example if reason
"mediatek,larbs" is provided as boolean property, the code will use an
uninitialized pointer and may crash. To fix the problem, ensure that the
number of phandles associated with "mediatek,larbs" is at least 1 and
bail out immediately if that is not the case.

Cc: Yong Wu <yong.wu@mediatek.com>
Cc: Tomasz Figa <tfiga@chromium.org>
Fixes: baf94e6ebff9 ("iommu/mediatek: Add device link for smi-common and m4u")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/iommu/mtk_iommu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 25b834104790..0bbe32d0a2a6 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -828,6 +828,8 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 					     "mediatek,larbs", NULL);
 	if (larb_nr < 0)
 		return larb_nr;
+	if (larb_nr == 0)
+		return -EINVAL;
 
 	for (i = 0; i < larb_nr; i++) {
 		u32 id;
-- 
2.33.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
