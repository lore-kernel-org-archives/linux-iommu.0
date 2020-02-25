Return-Path: <SRS0=zhz4=4N=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D82BC35DF7
	for <iommu@archiver.kernel.org>; Tue, 25 Feb 2020 06:18:39 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9FEE21744
	for <iommu@archiver.kernel.org>; Tue, 25 Feb 2020 06:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LD38JGPy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9FEE21744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id A478885D26;
	Tue, 25 Feb 2020 06:18:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3UzNfbbcRcNm; Tue, 25 Feb 2020 06:18:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id A15D28589A;
	Tue, 25 Feb 2020 06:18:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8788BC18DA;
	Tue, 25 Feb 2020 06:18:37 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1CE43C0177
 for <iommu@lists.linux-foundation.org>; Tue, 25 Feb 2020 06:18:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id F166920381
 for <iommu@lists.linux-foundation.org>; Tue, 25 Feb 2020 06:18:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a529Ti+Ocjoe for <iommu@lists.linux-foundation.org>;
 Tue, 25 Feb 2020 06:18:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com
 [209.85.215.195])
 by silver.osuosl.org (Postfix) with ESMTPS id 14F0A2036D
 for <iommu@lists.linux-foundation.org>; Tue, 25 Feb 2020 06:18:35 +0000 (UTC)
Received: by mail-pg1-f195.google.com with SMTP id a14so5968235pgb.11
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 22:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=e+7bx8lUSmVrpWTazNQW1i3Mowvkih4cewfdKjPmTy4=;
 b=LD38JGPy04uN1yjFhWdfFm1TtlN5JgFs3svtOJ1YyG0FCVGaxcb5+GNmYLZ51tZSyo
 oAFCOPJ1OYAZHQJwG7Za4U0bB6QEtc5CYqQMpI640/Le3MUj84E7pAFPupiEhd4GHTUa
 PJRNaM+SkDUbk8YDrrJo7PECOudld1MQA6fnnKufEfkQ76Kn+sSN/ZT9n56DiWAVMh4g
 NR1ZvHsHxp0isifDUS+lnFU3+yJMOxtP7iM+Kri8CXZwOe01S448gTpYYtW561G2pDlo
 SJDOKuPlUN42+hZpH2ux8o20rUcLHP7fOvXOO/T3c/yMRxwETFsrsX/31tRRWw1Tl6OR
 /sfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=e+7bx8lUSmVrpWTazNQW1i3Mowvkih4cewfdKjPmTy4=;
 b=oc6lSgHMBDNGQUYQFPCqer42PsyXLtg/tnxc7FqRJlcbPbmMBK4iiy5f7cyyPXBU3a
 +jHamuSmS0io3u+TNcljlbQqhuUffKRfrPACfDCT4h5OmyVeMRh3DjBO84kd27HlkczD
 9pv+0EqneqociTFavEP0kwn6fKqPP9tSD91mP9bNvX4deliQokQCzO2mBQHvKZK9m2fK
 XwP8guXvv7PfbOw42VbPyP7TDXIXfLioHG7Z+OeB6vvaCBk14OYFK1SfvXMsiG/CExhq
 x5H2v6kHQWjcBMkaxoQ86EUgEwEX9Oah6JhsKbLl+UfIISAXhWwUE6Z0ql9rqwnYXtVA
 2Uaw==
X-Gm-Message-State: APjAAAXzfyGXcXjhHabWhMbjpfWEVIXXBZmr16uyTnLOUa2CxbbdKVFw
 /YNtXkbck7YEV87KvTxKRktCZw==
X-Google-Smtp-Source: APXvYqxEzw4tKr8TWATiCEQ2SB4wrPgMGenyQG6KArzN8Y17gzlGpHwMZyTpBuJ3nI6rVsIaKjJepA==
X-Received: by 2002:a65:4b83:: with SMTP id t3mr55484000pgq.195.1582611514690; 
 Mon, 24 Feb 2020 22:18:34 -0800 (PST)
Received: from localhost.localdomain ([240e:362:421:7f00:524:e1bd:8061:a346])
 by smtp.gmail.com with ESMTPSA id
 q17sm15038327pfg.123.2020.02.24.22.18.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 24 Feb 2020 22:18:34 -0800 (PST)
From: Zhangfei Gao <zhangfei.gao@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>, Herbert Xu <herbert@gondor.apana.org.au>,
 jonathan.cameron@huawei.com, dave.jiang@intel.com, grant.likely@arm.com,
 jean-philippe <jean-philippe@linaro.org>,
 Jerome Glisse <jglisse@redhat.com>, ilias.apalodimas@linaro.org,
 francois.ozog@linaro.org, kenneth-lee-2012@foxmail.com,
 Wangzhou <wangzhou1@hisilicon.com>,
 "haojian . zhuang" <haojian.zhuang@linaro.org>, guodong.xu@linaro.org
Subject: [PATCH] MAINTAINERS: add maintainers for uacce
Date: Tue, 25 Feb 2020 14:17:55 +0800
Message-Id: <1582611475-32691-1-git-send-email-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.7.4
Cc: Zhangfei Gao <zhangfei.gao@linaro.org>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-accelerators@lists.ozlabs.org,
 linux-crypto@vger.kernel.org
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

Add Zhangfei Gao and Zhou Wang as maintainers for uacce

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 38fe2f3..22e647f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17039,6 +17039,16 @@ W:	http://linuxtv.org
 S:	Maintained
 F:	drivers/media/pci/tw686x/
 
+UACCE ACCELERATOR FRAMEWORK
+M:	Zhangfei Gao <zhangfei.gao@linaro.org>
+M:	Zhou Wang <wangzhou1@hisilicon.com>
+S:	Maintained
+F:	Documentation/ABI/testing/sysfs-driver-uacce
+F:	Documentation/misc-devices/uacce.rst
+F:	drivers/misc/uacce/
+F:	include/linux/uacce.h
+F:	include/uapi/misc/uacce/
+
 UBI FILE SYSTEM (UBIFS)
 M:	Richard Weinberger <richard@nod.at>
 L:	linux-mtd@lists.infradead.org
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
