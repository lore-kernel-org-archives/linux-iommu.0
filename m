Return-Path: <SRS0=BRyA=YI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADECECE588
	for <iommu@archiver.kernel.org>; Tue, 15 Oct 2019 16:30:01 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3B4D2086A
	for <iommu@archiver.kernel.org>; Tue, 15 Oct 2019 16:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4QJXQ4+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3B4D2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id D59C7E9A;
	Tue, 15 Oct 2019 16:29:55 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id F3A77E96
	for <iommu@lists.linux-foundation.org>;
	Tue, 15 Oct 2019 16:29:54 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
	[209.85.128.67])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 715C26CE
	for <iommu@lists.linux-foundation.org>;
	Tue, 15 Oct 2019 16:29:54 +0000 (UTC)
Received: by mail-wm1-f67.google.com with SMTP id p7so21586241wmp.4
	for <iommu@lists.linux-foundation.org>;
	Tue, 15 Oct 2019 09:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=8EjDBNijVRoZjfqMLlXDaOnDwnymZTKSpRUqb0jAneU=;
	b=e4QJXQ4+hWtGPr3XXRL/OH8/hcXhMLaLfbqe37lsaMUbNRHvJMGGZp4XqiMur9ZIIc
	JuCMN1+nF/9t76VBmQ+bJFDSWppF2nOw7LSqfJHA9DEsVgtNBbmcgJpX21co1+0bzS7U
	ZDTmR1lzUv9uuaFF4QThMXFdM66UiBcnmiF11V9n7305SH7gf0aI5yrqgt3T8h/6Hs5m
	rb6AzpQ9daKybqWNfHD7m65mrL/RLjzbaZRoKmHGvth2WUrVbieH1uBum2ttR+uAANMh
	/M1hRnoNbhQiSVPrP+GTWO/Cl9Pg6LvKp9UDmIYDWpuJbB9qQf84cAByW1s9aYp4JZQm
	zfSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=8EjDBNijVRoZjfqMLlXDaOnDwnymZTKSpRUqb0jAneU=;
	b=Rut+oRL60txhvGDwdoiBHHrbaCQWBLnksQQZPcT7tzBb8OPyTSIipnXuIUXssZpAnO
	GlYXdDV9may5yv9tPQCguzWE62q+R5t8AR6m2ax4HMDyKQAgWbU2ruZ3+vT2URyqorgv
	ZKUx2t4kRR+B35E6uZTByrQ/TW3IbSSFJsjcoc0UPBUJqwlHA2agYBbPo7MtewzR74El
	xEV8wO0JpS+9EWx6JJmRolh1rksH/1wDBM/4oRNFijwdAvuzCFlH8SgMPAxE0VIbmEHT
	QpGdAqH7+42ymbxc0zg3czcy9ag26fwbgVbRSRv/KLJ9HOAJhb+DvBdNl8mbFDlRezvs
	IAyg==
X-Gm-Message-State: APjAAAXe3bBgESloTUxJ265sVN18XfdwhUBKBy52mo2JYXeMJoar4sDZ
	9zRyav8Gi1kh1pEsHcrB0g4=
X-Google-Smtp-Source: APXvYqziuZ6APvE5dI6UfqFlO5qrIoevHEqZUCi0rk13IQn0bCyF6RN2yeZd4Q+L34CkWrYJ3uVxGQ==
X-Received: by 2002:a7b:cd83:: with SMTP id y3mr21928223wmj.150.1571156992846; 
	Tue, 15 Oct 2019 09:29:52 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
	by smtp.gmail.com with ESMTPSA id
	t123sm37314754wma.40.2019.10.15.09.29.51
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Tue, 15 Oct 2019 09:29:51 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: [RFC 2/3] memory: tegra186: Register as memory controller
Date: Tue, 15 Oct 2019 18:29:44 +0200
Message-Id: <20191015162945.1203736-3-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191015162945.1203736-1-thierry.reding@gmail.com>
References: <20191015162945.1203736-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Cc: Will Deacon <will@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>,
	iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

From: Thierry Reding <treding@nvidia.com>

Registering as memory controller allows other drivers to obtain a
reference to it. This is mostly useful as a way of ordering probe
between devices depending on one another.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/memory/tegra/tegra186.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/memory/tegra/tegra186.c b/drivers/memory/tegra/tegra186.c
index 441213a35930..e94e960a79f4 100644
--- a/drivers/memory/tegra/tegra186.c
+++ b/drivers/memory/tegra/tegra186.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/io.h>
+#include <linux/memory-controller.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
@@ -11,6 +12,7 @@
 #include <dt-bindings/memory/tegra186-mc.h>
 
 struct tegra_mc {
+	struct memory_controller base;
 	struct device *dev;
 	void __iomem *regs;
 };
@@ -548,7 +550,7 @@ static int tegra186_mc_probe(struct platform_device *pdev)
 	if (IS_ERR(mc->regs))
 		return PTR_ERR(mc->regs);
 
-	mc->dev = &pdev->dev;
+	mc->base.dev = &pdev->dev;
 
 	for (i = 0; i < ARRAY_SIZE(tegra186_mc_clients); i++) {
 		const struct tegra_mc_client *client = &tegra186_mc_clients[i];
@@ -571,6 +573,10 @@ static int tegra186_mc_probe(struct platform_device *pdev)
 			client->name, override, security);
 	}
 
+	err = memory_controller_register(&mc->base);
+	if (err < 0)
+		return err;
+
 	platform_set_drvdata(pdev, mc);
 
 	return err;
-- 
2.23.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
