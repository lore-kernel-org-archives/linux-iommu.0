Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A0E3CCA47B
	for <iommu@archiver.kernel.org>; Sat,  2 Jul 2022 21:37:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0F866415EC;
	Sat,  2 Jul 2022 21:37:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0F866415EC
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=N6w5oPvP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iX9mj_kxtFRK; Sat,  2 Jul 2022 21:37:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7D6B2415E2;
	Sat,  2 Jul 2022 21:37:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7D6B2415E2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 62029C0032;
	Sat,  2 Jul 2022 21:37:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B9502C002D
 for <iommu@lists.linux-foundation.org>; Sat,  2 Jul 2022 21:37:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8577A81469
 for <iommu@lists.linux-foundation.org>; Sat,  2 Jul 2022 21:37:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8577A81469
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=N6w5oPvP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vZ2dR9E5VRLL for <iommu@lists.linux-foundation.org>;
 Sat,  2 Jul 2022 21:37:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5E98581462
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5E98581462
 for <iommu@lists.linux-foundation.org>; Sat,  2 Jul 2022 21:37:27 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id c13so6951643eds.10
 for <iommu@lists.linux-foundation.org>; Sat, 02 Jul 2022 14:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=WV81TTrUzfnxlK8f1IHJz4xXjnSjuTWSu4GCpZi6HEY=;
 b=N6w5oPvPqSon53fXnJZtzHnqdoTIeYCV6XuIzoHbJZvZSPSWEzPKieCj19s19eJcwL
 RcIaTUHdUUNr9nkU6I8AoMl8MYOb93MYMUeA0voFGALhae/V7epsJgesAM52ZRW0dX2Y
 4yxMLoOi6DW/mQkOXwh0GbnbaVTBgbdxWiAiCbpqEsBEKg6pEaxcBiNh8KoKto2CQ+5k
 VSW2p4QdgRIqPwEEj8mBNKB9BzfGyNCD8VAk1JR6fgYaS+Xp/nbzdZvzdg3/YaSn/Kpz
 IQD+4eisIUTicjTxgNLfA7Ka4wWJVD1nwiy7AQb07DRuKpbj8Tux5G3x0Zq9odNjaYHP
 u+Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=WV81TTrUzfnxlK8f1IHJz4xXjnSjuTWSu4GCpZi6HEY=;
 b=JRnzAX5LjFIb7Lm9JfEpxjnVfAonHu5rrMVh/Svy+02PSfcrTQL5/MQv8fG1+pkHSe
 OeETb7z0+olBVbDQ6jlaZJTXCcZgqOgD4JqkQZsKjsFmqV1z1Zu51PJUKXo8TyLQ4/xX
 pPWVcdLR2HqNpIjPEb6zgKgk8VY9JQxXhLGF2P4MgKM2oHVbR/IZXtAZcC1D2iWTx7yt
 y34/drGDdD6GaYJOqif76/tzKzEnK7pqXiq3ZQgPb+0cvrk7mo+50LlFWfgML329vs9O
 MgW8zz3lZBNZzkzQDroCHPvIOdoUrXLMixfXVZDkUsArHVmDqmPOPbg9cmafn3lsV8jW
 5kXw==
X-Gm-Message-State: AJIora8aFy1TMliYv+pfRRe6RP1rIwE/9OHYAzCAFcJWzgJPHyA4I58W
 hsOcSarUV0X5fzEUnejMw1xMWw==
X-Google-Smtp-Source: AGRyM1tKUcbvm7Pv5J7R8O4WaT3he1b97HxgOQBsVTrAmlhI7zbpEK0Cj+SrJSn0blV18Pjxg6AVHA==
X-Received: by 2002:aa7:cd91:0:b0:438:33a1:d5aa with SMTP id
 x17-20020aa7cd91000000b0043833a1d5aamr22690535edv.157.1656797845428; 
 Sat, 02 Jul 2022 14:37:25 -0700 (PDT)
Received: from localhost ([31.134.121.151]) by smtp.gmail.com with ESMTPSA id
 m7-20020a056402050700b004356c0d7436sm17483107edv.42.2022.07.02.14.37.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Jul 2022 14:37:25 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 0/4] iommu/exynos: Add basic support for SysMMU v7
Date: Sun,  3 Jul 2022 00:37:20 +0300
Message-Id: <20220702213724.3949-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Cc: Janghyuck Kim <janghyuck.kim@samsung.com>,
 linux-samsung-soc@vger.kernel.org, Will Deacon <will@kernel.org>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Cho KyongHo <pullip.cho@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, Sumit Semwal <sumit.semwal@linaro.org>,
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

Existing exynos-iommu driver only supports SysMMU versions up to v5. But
it's pretty much ready for basic usage with SysMMU v7, only small
changes have to be done. As SysMMU version is tested dynamically (by
reading the corresponding register), there is no need to introduce new
compatible string.

One major change is that SysMMU v7 can have different register layouts:
  - with Virtual Machine support
  - without Virtual Machine support

That can be checked by reading the capability registers. In case the
SysMMU IP-core is VM-capable, the VM registers have to be used, and some
additional initialization is needed. That is the case on E850-96 board,
which non-secure SysMMU (v7.4) implements VM-capable register set.

The patch series was tested on E850-96 board. Because at the moment
there are no SysMMU users for that board, the testing was done using so
called "Emulated Translation" registers available on SysMMU v7. That
allows one to initiate the translation from CPU, by writing to those
registers, and then reading the corresponding TLB registers to find out
the translation result. The testing driver can be found in [1] tree.

[1] https://github.com/joe-skb7/linux/tree/e850-96-mainline-iommu

Sam Protsenko (4):
  iommu/exynos: Set correct dma mask for SysMMU v5+
  iommu/exynos: Check if SysMMU v7 has VM registers
  iommu/exynos: Use lookup based approach to access v7 registers
  iommu/exynos: Add minimal support for SysMMU v7 with VM registers

 drivers/iommu/exynos-iommu.c | 112 ++++++++++++++++++++++++++++++++---
 1 file changed, 104 insertions(+), 8 deletions(-)

-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
