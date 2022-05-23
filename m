Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BF45C433EF
	for <iommu@archiver.kernel.org>; Mon, 23 May 2022 11:11:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D402441947;
	Mon, 23 May 2022 11:11:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4RMMqkht3DV3; Mon, 23 May 2022 11:11:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7BCFC414C0;
	Mon, 23 May 2022 11:11:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 590F1C0032;
	Mon, 23 May 2022 11:11:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DDF87C002D
 for <iommu@lists.linux-foundation.org>; Mon, 23 May 2022 11:11:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CCCA881C0A
 for <iommu@lists.linux-foundation.org>; Mon, 23 May 2022 11:11:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id leKfbr3G2d7t for <iommu@lists.linux-foundation.org>;
 Mon, 23 May 2022 11:11:50 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4D1018143B
 for <iommu@lists.linux-foundation.org>; Mon, 23 May 2022 11:11:50 +0000 (UTC)
Received: by mail-pj1-x1031.google.com with SMTP id
 ob14-20020a17090b390e00b001dff2a43f8cso5941869pjb.1
 for <iommu@lists.linux-foundation.org>; Mon, 23 May 2022 04:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=l5BnpyT21XxmPEltzzCAln/RtmxzwllCEL8G3E1N/fc=;
 b=KABL5hpsiMRjUN5/8tnsKM1eG36tCM6CN5WjGMrOIzb9gaR5xpba37erhgDZmN0lXJ
 9U24mJHt31S60KaPAHRFSbE8N95K7qQBjWakaI7KpUAFXl0NQFYap8HgSkH7IjavJoOB
 IQ9EdIj5aiR/ywpgF15fQ5WTmEcbq06e+l9MO8l/zuvjqB76iIo2JJBLXVbvNi2yjfBL
 9a9MSRgPbAKuRdPKPXdKNu0biJ4HHjR09irLAtuTLLP0oA5ciEuLk5sj20mp98t5J+D7
 yBTj47Gxs+2Y1t2zgQtXI4LPtKC9EsdTHSBDi6Clq1rD/fx4bgW5TW4kduKCjhPNisbb
 ecig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=l5BnpyT21XxmPEltzzCAln/RtmxzwllCEL8G3E1N/fc=;
 b=vm9R+3BOV27Y5B58gzQT+Rd2v5XwoNlCUYzyZpFtagZVe69yc/wdFRL5IAsQVBYX68
 OczKOnrzioI25WZ8jPuwT7PXbg0N4JQbPUsIfIjXc/Y0nR0C/YEqBOcFCDtByGc7DLEL
 dNdSqqEu0y6oC1Ht2e3NL1T1UC51+ATssqlVF5lTAvOS5vLGOYfWorvdpGgjPTCPLAoz
 q90myGB+ZqelWiDzqZ9iKBy4VI79VsofKKKDwW6PhUeGlXefWO0IcMLBw6X2b3ICOj8C
 Xy9Rjmr2BxMUEkEHh0lsEKVZkVaQxK0koSjgr3QhuFUQttY1t1pPSZRC8KExkNkJHg7C
 tk2g==
X-Gm-Message-State: AOAM533ZcVNeVBrgGk8YDefL/NtEE5J19TaYQtUCHQ+2IT0KyTj3Eelz
 RtdWgP+JVTHRZ8NVQik82cE=
X-Google-Smtp-Source: ABdhPJwzc2locnUHLd9zvUFe31j5Q893w4ciZJAyxd61TfgGUxaEunrUjdF6HHe+c518HQPoozEJvg==
X-Received: by 2002:a17:902:7483:b0:161:ff6a:402b with SMTP id
 h3-20020a170902748300b00161ff6a402bmr12788392pll.89.1653304309520; 
 Mon, 23 May 2022 04:11:49 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
 by smtp.gmail.com with ESMTPSA id
 md2-20020a17090b23c200b001df2f8f0a45sm7048321pjb.1.2022.05.23.04.11.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 May 2022 04:11:49 -0700 (PDT)
From: cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To: joro@8bytes.org
Subject: [PATCH] iommu/ipmmu-vmsa: Avoid leak OF node on error
Date: Mon, 23 May 2022 11:11:45 +0000
Message-Id: <20220523111145.2976-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, Zeal Robot <zealci@zte.com.cn>,
 will@kernel.org, linux-kernel@vger.kernel.org,
 Minghao Chi <chi.minghao@zte.com.cn>
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

From: Minghao Chi <chi.minghao@zte.com.cn>

The OF node should be put before returning error in ipmmu_init(),
otherwise node's refcount will be leaked.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/iommu/ipmmu-vmsa.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 8fdb84b3642b..f6440b106f46 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -1179,11 +1179,10 @@ static int __init ipmmu_init(void)
 		return 0;
 
 	np = of_find_matching_node(NULL, ipmmu_of_ids);
+	of_node_put(np);
 	if (!np)
 		return 0;
 
-	of_node_put(np);
-
 	ret = platform_driver_register(&ipmmu_driver);
 	if (ret < 0)
 		return ret;
-- 
2.25.1


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
