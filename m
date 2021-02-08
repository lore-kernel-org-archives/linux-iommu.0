Return-Path: <SRS0=aVDl=HK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDAFEC433E0
	for <iommu@archiver.kernel.org>; Mon,  8 Feb 2021 06:10:41 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81E2364E28
	for <iommu@archiver.kernel.org>; Mon,  8 Feb 2021 06:10:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81E2364E28
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 412FA867E3;
	Mon,  8 Feb 2021 06:10:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pS9Pc+-x98mp; Mon,  8 Feb 2021 06:10:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6E118867E2;
	Mon,  8 Feb 2021 06:10:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5FEDCC0174;
	Mon,  8 Feb 2021 06:10:40 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2F1ADC013A
 for <iommu@lists.linux-foundation.org>; Mon,  8 Feb 2021 06:10:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 16BAB86FDC
 for <iommu@lists.linux-foundation.org>; Mon,  8 Feb 2021 06:10:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Eh7xON1haIp8 for <iommu@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 06:10:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 33F4786FD1
 for <iommu@lists.linux-foundation.org>; Mon,  8 Feb 2021 06:10:38 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id l12so15756836wry.2
 for <iommu@lists.linux-foundation.org>; Sun, 07 Feb 2021 22:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=IzgnsVIfQ7MUr3Ild4g6lH/jjkDlQ+c5fZz2xq4Qd0M=;
 b=IFdCDqIq3K4sR7qI23+MXf/nE+MnBNzqSkyVuO4r4wN26UzDYoL07WtEvfssn0BIfo
 Mk0lfYh/dKCl/TQo/5T9QAg0rxjsFnThCnuZpRG4BRV3L6wILC9S3y+JgjP8EbL1rOv7
 pHk+NMNjFXwQK3hZzrBvcrIyM0I3vXL9eAy6rM+QacznPveyuyT80126LftBl54p4lMM
 Xh7+4g6zXfld33SAq50bSzurmCwoFo32eEGeUVboYb7FitTrO4AggnL8DEneRmGtdWTn
 HD4dmKhx9vAZcOmoS83LegWJk1KKQIO8YtWx9x28T1A+vcsazdKE3WBXOFII+cIuFard
 NIaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=IzgnsVIfQ7MUr3Ild4g6lH/jjkDlQ+c5fZz2xq4Qd0M=;
 b=BA02CClV43dTD1/Lwy+YNZXf41kB5EBJth8+WlgFORCMciyZ1jDBvtve9hwCsIzcUz
 iC1Wu6F0zQtba6XJVxoWMwvNakttIaNnRpQ5a0tdYgFLjR8ovwLwWySNdbn4yKThzvv6
 QNtjaYqQUmC+Ifp2A1Jy6+etPaRbLY7nEWDzDteJ/tsAdG+mw3PCs7EkAfYvoNR/dGG+
 3f/mTzmtqFQJ2SuEMcgodOJMSifYc8u18nEuW7hnvRondOYesfKr+N0H8oVPeCvsRmCb
 QxxWvoweVFVFNY+xqL//t+ryp+jVBcT5N/HvXaqZJiqKIpQOT6LvXEpY0+3dyGb5fksA
 KIFg==
X-Gm-Message-State: AOAM532ym31m3xAHJ5o+HcBstbf92xllpU00SWSA/tDKXMP4JXEX5zCX
 mjMweNT2N9/epnDYAVXICUQ=
X-Google-Smtp-Source: ABdhPJwAklcz2IhxWhplULsILsyJcC1/7jVHUHOswyE9u52R6xwuOO+plQjS+Yqkm/ETdvCcMKtJXA==
X-Received: by 2002:a5d:414c:: with SMTP id c12mr18487516wrq.251.1612764636586; 
 Sun, 07 Feb 2021 22:10:36 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2d8e:7300:842e:a74a:35f3:bd06])
 by smtp.gmail.com with ESMTPSA id m2sm18466356wml.34.2021.02.07.22.10.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Feb 2021 22:10:35 -0800 (PST)
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
To: Yong Wu <yong.wu@mediatek.com>, linux-mediatek@lists.infradead.org,
 iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>
Subject: [PATCH] MAINTAINERS: repair file pattern in MEDIATEK IOMMU DRIVER
Date: Mon,  8 Feb 2021 07:10:25 +0100
Message-Id: <20210208061025.29198-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org,
 Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>, Joe Perches <joe@perches.com>,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>,
 Pia Eichinger <pia.eichinger@st.oth-regensburg.de>
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

Commit 6af4873852c4 ("MAINTAINERS: Add entry for MediaTek IOMMU") mentions
the pattern 'drivers/iommu/mtk-iommu*', but the files are actually named
with an underscore, not with a hyphen.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains:

  warning: no file matches  F:    drivers/iommu/mtk-iommu*

Repair this minor typo in the file pattern.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on next-20210205

Yong, please ack.
Will, please pick this minor fixup for your iommu-next tree.

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 674f42375acf..6b507e8d7828 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11200,7 +11200,7 @@ L:	iommu@lists.linux-foundation.org
 L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
 F:	Documentation/devicetree/bindings/iommu/mediatek*
-F:	drivers/iommu/mtk-iommu*
+F:	drivers/iommu/mtk_iommu*
 F:	include/dt-bindings/memory/mt*-port.h
 
 MEDIATEK JPEG DRIVER
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
