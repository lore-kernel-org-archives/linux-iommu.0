Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70C7ECCA488
	for <iommu@archiver.kernel.org>; Tue, 21 Jun 2022 15:11:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2CAEA40AF1;
	Tue, 21 Jun 2022 15:11:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2CAEA40AF1
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.a=rsa-sha256 header.s=20161220 header.b=vShT5f5p
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gwjv4CmNam3U; Tue, 21 Jun 2022 15:10:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6DC0A40562;
	Tue, 21 Jun 2022 15:10:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6DC0A40562
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5AEECC0086;
	Tue, 21 Jun 2022 15:10:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F1E28C002D
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jun 2022 15:10:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BD11C60AF0
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jun 2022 15:10:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BD11C60AF0
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi
 header.a=rsa-sha256 header.s=20161220 header.b=vShT5f5p
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 73lAcEebsTK9 for <iommu@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 15:10:54 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7F0DC6077D
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7F0DC6077D
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jun 2022 15:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
 s=20161220; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=w6BHQOo4OjAquUzPRJDN9FxN7UMmI2Re8yXkiTY0n9Y=; b=vShT5f5p/4U8Kva9zXvglxMYUx
 67Tf8dcUoxD1cP49t3NK3BoXWpsG1Fekg6tLmHRKAg2Mlwi5ad/w4jtCvWhGmJyMnHZ4TxHCYfYhO
 6Q4rpqg7wW5PxWFbPJ7GmlxRbqJ3D9VRmlRUnBnUePJgNEIvIrzgv8khKtXjiO6GiYxKdFIZvrzRf
 WWvcdpWLtKL4he4W4cgN6cbI4XCEW7XtR/LgXNuejtsLX4h5oWPorPpejkabcartfPF9fSzc19/Qn
 yr7U1+hPi8V63X5FjvecXURL0IZh23Tbol3+bS0NI0K/JHiia1qWwDcKQYC/B7hSTg8ECvGJ2CHDq
 B5DJN29Q==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70]
 helo=toshino.localdomain) by mail.kapsi.fi with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <cyndis@kapsi.fi>)
 id 1o3fWT-00Ea3F-F8; Tue, 21 Jun 2022 18:10:33 +0300
From: Mikko Perttunen <cyndis@kapsi.fi>
To: thierry.reding@gmail.com, jonathanh@nvidia.com, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, robh+dt@kernel.org,
 krzysztof.kozlowski@canonical.com
Subject: [PATCH v6 00/10] Host1x context isolation support
Date: Tue, 21 Jun 2022 18:10:12 +0300
Message-Id: <20220621151022.1416300-1-cyndis@kapsi.fi>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 91.158.25.70
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Mikko Perttunen <mperttunen@nvidia.com>,
 iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
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

From: Mikko Perttunen <mperttunen@nvidia.com>

-------------
Merging notes
-------------

The changes to DT bindings should be applied on top of Thierry's patch
'dt-bindings: display: tegra: Convert to json-schema'.

The change to the arm-smmu driver should be omitted if Robin Murphy's
IOMMU bus cleanup series is merged.

***
New in v6:

Rebased on 5.19-rc3 (-next is too broken)
Added patch to fix TRANSCFG offset on NVDEC.
***

***
New in v5:

Rebased
Renamed host1x_context to host1x_memory_context
Small change in DRM side client driver ops to reduce churn with some
  upcoming changes
Add NVDEC support

***

***
New in v4:

Addressed review comments. See individual patches.
***

***
New in v3:

Added device tree bindings for new property.
***

***
New in v2:

Added support for Tegra194
Use standard iommu-map property instead of custom mechanism
***

This series adds support for Host1x 'context isolation'. Since
when programming engines through Host1x, userspace can program in
any addresses it wants, we need some way to isolate the engines'
memory spaces. Traditionally this has either been done imperfectly
with a single shared IOMMU domain, or by copying and verifying the
programming command stream at submit time (Host1x firewall).

Since Tegra186 there is a privileged (only usable by kernel)
Host1x opcode that allows setting the stream ID sent by the engine
to the SMMU. So, by allocating a number of context banks and stream
IDs for this purpose, and using this opcode at the beginning of
each job, we can implement isolation. Due to the limited number of
context banks only each process gets its own context, and not
each channel.

This feature also allows sharing engines among multiple VMs when
used with Host1x's hardware virtualization support - up to 8 VMs
can be configured with a subset of allowed stream IDs, enforced
at hardware level.

To implement this, this series adds a new host1x context bus, which
will contain the 'struct device's corresponding to each context
bank / stream ID, changes to device tree and SMMU code to allow
registering the devices and using the bus, as well as the Host1x
stream ID programming code and support in TegraDRM.

Thanks,
Mikko

Mikko Perttunen (9):
  iommu/arm-smmu: Attach to host1x context device bus
  dt-bindings: host1x: Add iommu-map property
  gpu: host1x: Add context device management code
  gpu: host1x: Program context stream ID on submission
  arm64: tegra: Add Host1x context stream IDs on Tegra186+
  drm/tegra: falcon: Set DMACTX field on DMA transactions
  drm/tegra: nvdec: Fix TRANSCFG register offset
  drm/tegra: Support context isolation
  drm/tegra: Implement stream ID related callbacks on engines

Thierry Reding (1):
  dt-bindings: display: tegra: Convert to json-schema

 .../display/tegra/nvidia,tegra114-mipi.txt    |  41 --
 .../display/tegra/nvidia,tegra114-mipi.yaml   |  74 ++
 .../display/tegra/nvidia,tegra124-dpaux.yaml  | 149 ++++
 .../display/tegra/nvidia,tegra124-sor.yaml    | 206 ++++++
 .../display/tegra/nvidia,tegra124-vic.yaml    |  71 ++
 .../display/tegra/nvidia,tegra186-dc.yaml     |  85 +++
 .../tegra/nvidia,tegra186-display.yaml        | 310 ++++++++
 .../tegra/nvidia,tegra186-dsi-padctl.yaml     |  45 ++
 .../display/tegra/nvidia,tegra20-dc.yaml      | 181 +++++
 .../display/tegra/nvidia,tegra20-dsi.yaml     | 159 +++++
 .../display/tegra/nvidia,tegra20-epp.yaml     |  70 ++
 .../display/tegra/nvidia,tegra20-gr2d.yaml    |  73 ++
 .../display/tegra/nvidia,tegra20-gr3d.yaml    | 214 ++++++
 .../display/tegra/nvidia,tegra20-hdmi.yaml    | 126 ++++
 .../display/tegra/nvidia,tegra20-host1x.txt   | 675 ------------------
 .../display/tegra/nvidia,tegra20-host1x.yaml  | 352 +++++++++
 .../display/tegra/nvidia,tegra20-isp.yaml     |  67 ++
 .../display/tegra/nvidia,tegra20-mpe.yaml     |  73 ++
 .../display/tegra/nvidia,tegra20-tvo.yaml     |  58 ++
 .../display/tegra/nvidia,tegra20-vi.yaml      | 163 +++++
 .../display/tegra/nvidia,tegra210-csi.yaml    |  52 ++
 .../pinctrl/nvidia,tegra124-dpaux-padctl.txt  |  59 --
 arch/arm64/boot/dts/nvidia/tegra186.dtsi      |  11 +
 arch/arm64/boot/dts/nvidia/tegra194.dtsi      |  11 +
 drivers/gpu/drm/tegra/drm.h                   |  11 +
 drivers/gpu/drm/tegra/falcon.c                |   8 +
 drivers/gpu/drm/tegra/falcon.h                |   1 +
 drivers/gpu/drm/tegra/nvdec.c                 |  13 +-
 drivers/gpu/drm/tegra/submit.c                |  48 +-
 drivers/gpu/drm/tegra/uapi.c                  |  43 +-
 drivers/gpu/drm/tegra/vic.c                   |  67 +-
 drivers/gpu/host1x/Makefile                   |   1 +
 drivers/gpu/host1x/context.c                  | 160 +++++
 drivers/gpu/host1x/context.h                  |  27 +
 drivers/gpu/host1x/dev.c                      |  12 +-
 drivers/gpu/host1x/dev.h                      |   2 +
 drivers/gpu/host1x/hw/channel_hw.c            |  52 +-
 drivers/gpu/host1x/hw/host1x06_hardware.h     |  10 +
 drivers/gpu/host1x/hw/host1x07_hardware.h     |  10 +
 drivers/iommu/arm/arm-smmu/arm-smmu.c         |  13 +
 include/linux/host1x.h                        |  26 +
 41 files changed, 3037 insertions(+), 792 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra114-mipi.txt
 create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra114-mipi.yaml
 create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra124-dpaux.yaml
 create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra124-sor.yaml
 create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra124-vic.yaml
 create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra186-dc.yaml
 create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra186-display.yaml
 create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra186-dsi-padctl.yaml
 create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dc.yaml
 create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dsi.yaml
 create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-epp.yaml
 create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-gr2d.yaml
 create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-gr3d.yaml
 create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-hdmi.yaml
 delete mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt
 create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.yaml
 create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-isp.yaml
 create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-mpe.yaml
 create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-tvo.yaml
 create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vi.yaml
 create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra210-csi.yaml
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/nvidia,tegra124-dpaux-padctl.txt
 create mode 100644 drivers/gpu/host1x/context.c
 create mode 100644 drivers/gpu/host1x/context.h

-- 
2.36.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
