Return-Path: <SRS0=QSCI=P7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB8DC433F5
	for <iommu@archiver.kernel.org>; Fri, 12 Nov 2021 13:12:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55F8460EFE
	for <iommu@archiver.kernel.org>; Fri, 12 Nov 2021 13:12:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 55F8460EFE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1532E6064E;
	Fri, 12 Nov 2021 13:12:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3gK6w9pVoqWd; Fri, 12 Nov 2021 13:12:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F1385605F5;
	Fri, 12 Nov 2021 13:12:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AE0DDC001E;
	Fri, 12 Nov 2021 13:12:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3A2C5C0012
 for <iommu@lists.linux-foundation.org>; Fri, 12 Nov 2021 13:12:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 208E181B98
 for <iommu@lists.linux-foundation.org>; Fri, 12 Nov 2021 13:12:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BpGL7dvI4gbB for <iommu@lists.linux-foundation.org>;
 Fri, 12 Nov 2021 13:12:36 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4D14480ECF
 for <iommu@lists.linux-foundation.org>; Fri, 12 Nov 2021 13:12:36 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id b12so15478943wrh.4
 for <iommu@lists.linux-foundation.org>; Fri, 12 Nov 2021 05:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lOXgQ6ktc8t7YW2KaSJg/CD93KvU0bXVPXTF0jzPmMs=;
 b=NvxzqCUeCZ5iPoTGUrMVjh7VAATIcw3u8jGFAEbIaHD7LjT5zbJrXUiQUP9shDauJb
 DBHOI0Jsj9c7ZJllTMYN+mqeAMD/GCUGe/EbaTM2GTBoDxz6NOAj63zf21X8hAaHdPIv
 PhJBchPhEJYsKCBLp+s95bc5AlVAHK+5c89TtTBqpCe9KqqcYvaY39J0pR8l4GCYfkaB
 eKutFnUBhem+njgeg+vbpm201kGb0mU02i6fJjs55c0F8pXG8/HVALIEO1EvY88ijhBG
 6Wwh3c89nIK8Efl9DA1/vBgGfExILB6bYDay5Nx4CaiZdvI5ojzLSwGXJSZyErdofSJG
 LNZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lOXgQ6ktc8t7YW2KaSJg/CD93KvU0bXVPXTF0jzPmMs=;
 b=RjhD6kD67Scf5WpSWhi/1PEJetlK9dVe+CRwHKeJnC2mDQEQUoqOFt/M1m2vzmwHTO
 SmpHY8Rblfr3rTCFdynu8hQjzAFgroU01L3kY5wrxAztJEzd+ZIyms2S84V/QfpnqFkm
 bFAg6me3unVTRu9hDexosrUi/kRJTSL/OQevz7rwhzVL/nY4rVmqlUXmGvpTd/uzhYUK
 i3qnQttvCUfVBKecLI+3LkRwLtQ+tVd1EQ2AvjtrZlvJKGoWhQSc43jV50l8kn+fX1Z2
 nrjzovDf8Q9hyObW0lb5L6KGVrzdlFrYapHt7QDxUkkZLZAkpjP39X05hzgZmWakBwPT
 deVQ==
X-Gm-Message-State: AOAM5321VAfT/ZCWhsbnN5bcgGoMSdxdHfTeaSGbP1+LuZmsvHR7fcUs
 UuqLImNZd3/lVQo6cDqQRAc=
X-Google-Smtp-Source: ABdhPJxEbMw5IZlLgUPFVnT64GbiW/9O2P51nkpn3Nvbl3xrpdCPT7WjQQYNaJzV8+d1p4kefJ24UA==
X-Received: by 2002:adf:f7c2:: with SMTP id a2mr7832761wrq.71.1636722754530;
 Fri, 12 Nov 2021 05:12:34 -0800 (PST)
Received: from localhost ([193.209.96.43])
 by smtp.gmail.com with ESMTPSA id c17sm6040514wmk.23.2021.11.12.05.12.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Nov 2021 05:12:33 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 0/4] iommu/arm-smmu: Support Tegra234 SMMU
Date: Fri, 12 Nov 2021 14:12:27 +0100
Message-Id: <20211112131231.3683098-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>,
 iommu@lists.linux-foundation.org, Thierry Reding <thierry.reding@gmail.com>,
 linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

From: Thierry Reding <treding@nvidia.com>

Hi,

this series of patches adds and enables support for the ARM SMMU
instances found on the new Tegra234 SoC. This is mostly similar to what
can be found on Tegra194 except that there are a few more instances to
meet increased bandwidth needs.

In addition to adding support for the new Tegra234 compatible string,
this also adds a missing description for the nvidia,memory-controller
property to the ARM SMMU device tree binding.

I plan on picking up patch 4 into the Tegra tree because it has a
dependency (for the stream ID definitions) on a separate patch series
for the memory controller that I sent out earlier.

Thanks,
Thierry

Thierry Reding (4):
  dt-bindings: arm-smmu: Document nvidia,memory-controller property
  dt-bindings: arm-smmu: Add compatible for Tegra234 SOC
  iommu/arm-smmu: Support Tegra234 SMMU
  arm64: tegra: Add Tegra234 IOMMUs

 .../devicetree/bindings/iommu/arm,smmu.yaml   |  13 +-
 arch/arm64/boot/dts/nvidia/tegra234.dtsi      | 426 ++++++++++++++++++
 drivers/iommu/arm/arm-smmu/arm-smmu-impl.c    |   3 +-
 3 files changed, 440 insertions(+), 2 deletions(-)

-- 
2.33.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
