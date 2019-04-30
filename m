Return-Path: <SRS0=Kg+4=TA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7874DC43219
	for <iommu@archiver.kernel.org>; Tue, 30 Apr 2019 00:31:15 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41E9321707
	for <iommu@archiver.kernel.org>; Tue, 30 Apr 2019 00:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=arista.com header.i=@arista.com header.b="MOPfSeYv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41E9321707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 01441DA4;
	Tue, 30 Apr 2019 00:31:15 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 0BA25D7A
	for <iommu@lists.linux-foundation.org>;
	Tue, 30 Apr 2019 00:30:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com
	[209.85.208.66])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 4B412775
	for <iommu@lists.linux-foundation.org>;
	Tue, 30 Apr 2019 00:30:37 +0000 (UTC)
Received: by mail-ed1-f66.google.com with SMTP id w37so10758271edw.4
	for <iommu@lists.linux-foundation.org>;
	Mon, 29 Apr 2019 17:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=arista.com; s=googlenew;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=tmHyoZA3s8+eH8irHXDQwuHohJUycE2ziw5RpU+dlOU=;
	b=MOPfSeYvgFTPgmXOyqu5vdYm5hkSdQbjS+ZqEcO2RU+mAi+5MAMZoFxX3IpBDPLPQS
	+6cxB/pSPBzbPChynLlIkPp4j946qOnm4Ye/TMQhOEbAMuMfpeVVBcoKcz4+RJW8yx6/
	Ved8pdw06sn2gpyLII0BLDY6t7Sg8N2naFdo6CAqbtTC39FR3o1Tc1kBC5kIorVz+Ak4
	ako09dGNcEJDViNxWaT8wPfz1pEdUxqyVHmDsDi6DvZ163SxxHJc0/irfHhaluAhRXut
	fRdoOWoA4QNK2yK1oJ5SHB/z+IS3njGTe+Ft9ivlpb8yi+AAVdDoaUQ0ZqtYNO7vRck8
	qUcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=tmHyoZA3s8+eH8irHXDQwuHohJUycE2ziw5RpU+dlOU=;
	b=QF1MrbGwkbOmDcq4qMlohz6GI0C16/R8DobnettcyVKVy4rSoOLvTyyhxRmrvBgYvz
	pQkb4q0W7z9mDADpIwGo0EyqiKXjvspWEbUM4Ro2+pY8kITnY+se+jhCLXcwqZ+QQ49w
	KkY9qk/OX9HZ3lCrSaKDVMfMyRSAVrlsdt5LT98SVyBgtainbrwdAbQsyhZ/q9D4gy+D
	0IIdQgIKWpC97ypB49REkHLkSyfjNhqahdu9wypdj0XBxCeq27LIA7djmFEmrwg/iEkn
	r9daXLZFgEBvRtVne1gpnIM2u8G9J9pdJrMDclyg+b6ZTg+rrGyc7yl+KoocWylgHQ5X
	infQ==
X-Gm-Message-State: APjAAAWuiVsDas6uiT98ztY9bEt+e80CZs0uhpHsaCtV8tno6tMJaK8s
	sHzf9Uy1sOkKMURY6vkDl3QyAegLghMiHA==
X-Google-Smtp-Source: APXvYqxnysyX/Gy2Mv+d0SzufhcdmkrISFZgci8tZfFs0rMtqN5Lk2YDEgY4FPz5PnrMa8o5ipagUg==
X-Received: by 2002:aa7:c88a:: with SMTP id p10mr41403077eds.145.1556584235673;
	Mon, 29 Apr 2019 17:30:35 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:a0:bc00:7d76:7b66:68:3b5f])
	by smtp.gmail.com with ESMTPSA id a9sm9424163edt.93.2019.04.29.17.30.34
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 17:30:35 -0700 (PDT)
To: iommu@lists.linux-foundation.org
Subject: [PATCH v2 0/4] iommu/amd: Convert the AMD iommu driver to the
	dma-iommu api
Date: Tue, 30 Apr 2019 01:29:47 +0100
Message-Id: <20190430002952.18909-1-tmurphy@arista.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Cc: Heiko Stuebner <heiko@sntech.de>, Will Deacon <will.deacon@arm.com>,
	David Brown <david.brown@linaro.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	linux-s390@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>, linux-rockchip@lists.infradead.org,
	Kukjin Kim <kgene@kernel.org>,
	Gerald Schaefer <gerald.schaefer@de.ibm.com>,
	Andy Gross <andy.gross@linaro.org>, linux-tegra@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	linux-arm-kernel@lists.infradead.org, Tom Murphy <tmurphy@arista.com>,
	Robin Murphy <robin.murphy@arm.com>,
	linux-kernel@vger.kernel.org, murphyt7@tcd.ie,
	David Woodhouse <dwmw2@infradead.org>
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
From: Tom Murphy via iommu <iommu@lists.linux-foundation.org>
Reply-To: Tom Murphy <tmurphy@arista.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190430002947.tkmZ0UjQCvGcSC1jGH1onJAcGzjw8Xs02q0UuN19tkc@z>

Convert the AMD iommu driver to the dma-iommu api. Remove the iova
handling and reserve region code from the AMD iommu driver.

Change-log:
v2:
-Rebase on top of this series:
 http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-iommu-ops.3
-Add a gfp_t parameter to the iommu_ops::map function.
-Made use of the reserve region code inside the dma-iommu api

Tom Murphy (4):
  iommu: Add gfp parameter to iommu_ops::map
  iommu/dma-iommu: Handle deferred devices
  iommu/dma-iommu: Use the dev->coherent_dma_mask
  iommu/amd: Convert the AMD iommu driver to the dma-iommu api

 drivers/iommu/Kconfig          |   1 +
 drivers/iommu/amd_iommu.c      | 694 ++++-----------------------------
 drivers/iommu/arm-smmu-v3.c    |   2 +-
 drivers/iommu/arm-smmu.c       |   2 +-
 drivers/iommu/dma-iommu.c      |  52 ++-
 drivers/iommu/exynos-iommu.c   |   2 +-
 drivers/iommu/intel-iommu.c    |   2 +-
 drivers/iommu/iommu.c          |  43 +-
 drivers/iommu/ipmmu-vmsa.c     |   2 +-
 drivers/iommu/msm_iommu.c      |   2 +-
 drivers/iommu/mtk_iommu.c      |   2 +-
 drivers/iommu/mtk_iommu_v1.c   |   2 +-
 drivers/iommu/omap-iommu.c     |   2 +-
 drivers/iommu/qcom_iommu.c     |   2 +-
 drivers/iommu/rockchip-iommu.c |   2 +-
 drivers/iommu/s390-iommu.c     |   2 +-
 drivers/iommu/tegra-gart.c     |   2 +-
 drivers/iommu/tegra-smmu.c     |   2 +-
 include/linux/iommu.h          |  21 +-
 19 files changed, 187 insertions(+), 652 deletions(-)

-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
