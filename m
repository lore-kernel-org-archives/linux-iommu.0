Return-Path: <SRS0=g0Sk=4O=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBEBFC4BA0B
	for <iommu@archiver.kernel.org>; Wed, 26 Feb 2020 01:29:03 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B17FF20658
	for <iommu@archiver.kernel.org>; Wed, 26 Feb 2020 01:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eSRfJrrb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B17FF20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 7ECE1203EB;
	Wed, 26 Feb 2020 01:29:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c8I5S-vZGjQA; Wed, 26 Feb 2020 01:29:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 5535120418;
	Wed, 26 Feb 2020 01:29:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3BAF4C18DA;
	Wed, 26 Feb 2020 01:29:02 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4586CC0177
 for <iommu@lists.linux-foundation.org>; Wed, 26 Feb 2020 01:29:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 2F008870A9
 for <iommu@lists.linux-foundation.org>; Wed, 26 Feb 2020 01:29:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wRm7tdFopK9S for <iommu@lists.linux-foundation.org>;
 Wed, 26 Feb 2020 01:28:59 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com
 [209.85.210.196])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 18F4086EB1
 for <iommu@lists.linux-foundation.org>; Wed, 26 Feb 2020 01:28:59 +0000 (UTC)
Received: by mail-pf1-f196.google.com with SMTP id 2so527028pfg.12
 for <iommu@lists.linux-foundation.org>; Tue, 25 Feb 2020 17:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=vHnoiE2Lvw7hwJiHoxNVUEj7j+4ABzT2vnGBT++TeTk=;
 b=eSRfJrrbKwAkCJ/OfjPbB07snFeA90jhWtm3D1d/Ao4a8YWY5b/butwclrugMtQyto
 YUBnjKdnkb/m4/PV0VlWgwZVMENu91ZfRJQD4h9ez7V68ZunetMSLyhRCo8QCnFeTBAu
 3AeMMOOGQdycc11Tsvka8XDTeif5lp7H5oneJs1a+o+hFsafhWOXzMrMLf+N01NSzxDA
 manhXFzq0Gs/cLY8UO7k5q5LuPRSKBV1JTSuu+5L0hWMYk/2CeEkIvjGuRwFdUEHNx6Z
 TKD0Wd/29fJQexSTPplm65QkreJV7c+Tr7NZQEVC4ctA4Rov2zX6Y7hKVXbufTeQkbQg
 VE7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=vHnoiE2Lvw7hwJiHoxNVUEj7j+4ABzT2vnGBT++TeTk=;
 b=I5t8Qjfi9HakKMypL7tNEHHh9b0Rk0hOVSU1wfHD8zpjtzkEm9X+9yQsDTNwAzCDFp
 vXGcjA3Eh6cIHzwtJYA6xxz7O+o75EW9ZAqlK6DUq9oI1R+ki/7Mx1W1tmRPiTD2m8Oc
 GmnRzgnVArT44b3sI4kzQMN5H5XCQPV5yf8fqBvq1Wc0Y/xUFhHYErC3AlhcBneitHCq
 dfBr+Q5TqvQSg368+azF6knHu6SdFHc5vZbZGSHqbPapLbtDFcbntjer8DBZRoDsroFS
 p2SUkRgMg82stiRljEc2782TKWn0IgC27UXT4PnHUjrhtafNkNYI8wN23P7kDp26a0Hr
 zZoA==
X-Gm-Message-State: APjAAAXInfR7uA440Mu3UB84kk6phMeInma+zR6wgp3zU5kWFyZab7LL
 CY1eypDsKUuTHtBos5+JSBBDgw==
X-Google-Smtp-Source: APXvYqwUNwVRv+swWTZ2eRfOm2MCq483DsIDj+WOD8rH3A5r3EhuhbWBu8Nj/QxikFbvKlieVP4Edw==
X-Received: by 2002:a63:214e:: with SMTP id s14mr1264455pgm.428.1582680538680; 
 Tue, 25 Feb 2020 17:28:58 -0800 (PST)
Received: from localhost.localdomain ([240e:362:4c3:8800:a057:bb7f:18d7:2e])
 by smtp.gmail.com with ESMTPSA id q11sm326994pff.111.2020.02.25.17.28.44
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 25 Feb 2020 17:28:58 -0800 (PST)
From: Zhangfei Gao <zhangfei.gao@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>, Herbert Xu <herbert@gondor.apana.org.au>,
 jonathan.cameron@huawei.com, dave.jiang@intel.com, grant.likely@arm.com,
 jean-philippe <jean-philippe@linaro.org>,
 Jerome Glisse <jglisse@redhat.com>, ilias.apalodimas@linaro.org,
 francois.ozog@linaro.org, kenneth-lee-2012@foxmail.com,
 Wangzhou <wangzhou1@hisilicon.com>,
 "haojian . zhuang" <haojian.zhuang@linaro.org>, guodong.xu@linaro.org
Subject: [PATCH v2] MAINTAINERS: add maintainers for uacce
Date: Wed, 26 Feb 2020 09:28:28 +0800
Message-Id: <1582680508-596-1-git-send-email-zhangfei.gao@linaro.org>
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
Add list, suggested by Dave

MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 38fe2f3..b5bdef8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17039,6 +17039,18 @@ W:	http://linuxtv.org
 S:	Maintained
 F:	drivers/media/pci/tw686x/
 
+UACCE ACCELERATOR FRAMEWORK
+M:	Zhangfei Gao <zhangfei.gao@linaro.org>
+M:	Zhou Wang <wangzhou1@hisilicon.com>
+L:	linux-accelerators@lists.ozlabs.org
+L:	linux-kernel@vger.kernel.org
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
