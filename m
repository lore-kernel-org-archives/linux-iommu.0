Return-Path: <SRS0=Yw80=4G=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A56BC34049
	for <iommu@archiver.kernel.org>; Tue, 18 Feb 2020 17:13:30 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB3D92467B
	for <iommu@archiver.kernel.org>; Tue, 18 Feb 2020 17:13:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB3D92467B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B904885A60;
	Tue, 18 Feb 2020 17:13:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4fUFet_1rjXB; Tue, 18 Feb 2020 17:13:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DCBBA8598A;
	Tue, 18 Feb 2020 17:13:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C3F4FC08A0;
	Tue, 18 Feb 2020 17:13:27 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 88D18C013E
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 17:13:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 73AB186092
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 17:13:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IluldgjLLZjd for <iommu@lists.linux-foundation.org>;
 Tue, 18 Feb 2020 17:13:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com
 [209.85.210.66])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 8139E85064
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 17:13:24 +0000 (UTC)
Received: by mail-ot1-f66.google.com with SMTP id p8so20189540oth.10
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 09:13:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=KxKWes5Maiiz92tj+onliCPmpibZ/Bkve3W+pNRz4Mc=;
 b=ICg/nwehf7vehWAVT70W2zGlQN4/PQxPAFKS1ma4+uVVuBalXpcAPwntHfkSIpg8vW
 zXAFahCWLwWoevEvfCgtvi+FzYhQjoh3b8j0bfbJbhvxJJgD0k8tmECT2WxYOeWFdTwE
 B1mHl765FKk92AOEX6mX8uHhC2z6ZCeca+F6VtPFZ0/sc6MSH5o0DplEPN0g2gTahDBh
 QMgpbXiPiGYDxl/U0z2vcwJJDhExPt0B1FSoZgGayUDMAxPU2Ubri+G5I/kDFCAs/kZs
 oxsS67eayVYof+woRM3eHr9JfW1dbl63UFlE0cuyxwmx/8o3qQCEeQTCma7STetoDanJ
 S7Cg==
X-Gm-Message-State: APjAAAWjh/VzRAJCyjQHmgjBP/heUjI0Z+t7v7AcQmnimVRJX9olTnYw
 hg8sv5RRygM3LyZGfE0Zfw==
X-Google-Smtp-Source: APXvYqw78RKkguXMrAM7M8gSXlZrfkdWkZ4c6zf2HSWTeBKpVzryzLJxnnrYZ2glk4KBR3Pi24m44w==
X-Received: by 2002:a9d:10d:: with SMTP id 13mr4047747otu.238.1582046003552;
 Tue, 18 Feb 2020 09:13:23 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id y25sm1545755oto.27.2020.02.18.09.13.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2020 09:13:22 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 soc@kernel.org, Andre Przywara <andre.przywara@arm.com>,
 Robert Richter <rrichter@marvell.com>, Jon Loeliger <jdl@jdl.com>,
 Alexander Graf <graf@amazon.com>, Matthias Brugger <mbrugger@suse.com>,
 Mark Langsdorf <mlangsdo@redhat.com>
Subject: [RFC PATCH 00/11] Removing Calxeda platform support
Date: Tue, 18 Feb 2020 11:13:10 -0600
Message-Id: <20200218171321.30990-1-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: kvm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>,
 linux-ide@vger.kernel.org, Will Deacon <will@kernel.org>,
 linux-clk@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
 devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, linux-edac@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, Tony Luck <tony.luck@intel.com>,
 Stephen Boyd <sboyd@kernel.org>, netdev@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 iommu@lists.linux-foundation.org, James Morse <james.morse@arm.com>,
 Robin Murphy <robin.murphy@arm.com>, "David S. Miller" <davem@davemloft.net>
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

Calxeda has been defunct for 6 years now. Use of Calxeda servers carried
on for some time afterwards primarily as distro builders for 32-bit ARM.
AFAIK, those systems have been retired in favor of 32-bit VMs on 64-bit
hosts.

The other use of Calxeda Midway I'm aware of was testing 32-bit ARM KVM
support as there are few or no other systems with enough RAM and LPAE. Now
32-bit KVM host support is getting removed[1].

While it's not much maintenance to support, I don't care to convert the
Calxeda DT bindings to schema nor fix any resulting errors in the dts files
(which already don't exactly match what's shipping in firmware).

Rob

[1] https://lore.kernel.org/linux-arm-kernel/20200210141324.21090-1-maz@kernel.org/

Rob Herring (11):
  vfio: Remove Calxeda XGMAC reset driver
  ata: Remove Calxeda AHCI driver
  cpuidle: Remove Calxeda driver
  cpufreq: Remove Calxeda driver
  EDAC: Remove Calxeda drivers
  iommu: arm-smmu: Remove Calxeda secure mode quirk
  net: Remove Calxeda XGMAC driver
  clk: Remove Calxeda driver
  ARM: Remove Calxeda platform support
  ARM: dts: Remove Calxeda platforms
  dt-bindings: Remove Calxeda platforms bindings

 .../devicetree/bindings/arm/calxeda.yaml      |   22 -
 .../devicetree/bindings/arm/calxeda/l2ecc.txt |   15 -
 .../devicetree/bindings/ata/sata_highbank.txt |   44 -
 .../devicetree/bindings/clock/calxeda.txt     |   17 -
 .../memory-controllers/calxeda-ddr-ctrlr.txt  |   16 -
 .../devicetree/bindings/net/calxeda-xgmac.txt |   18 -
 .../bindings/phy/calxeda-combophy.txt         |   17 -
 MAINTAINERS                                   |   14 -
 arch/arm/Kconfig                              |    2 -
 arch/arm/Kconfig.debug                        |   12 +-
 arch/arm/Makefile                             |    1 -
 arch/arm/boot/dts/Makefile                    |    3 -
 arch/arm/boot/dts/ecx-2000.dts                |  103 -
 arch/arm/boot/dts/ecx-common.dtsi             |  230 --
 arch/arm/boot/dts/highbank.dts                |  161 --
 arch/arm/configs/multi_v7_defconfig           |    5 -
 arch/arm/mach-highbank/Kconfig                |   19 -
 arch/arm/mach-highbank/Makefile               |    4 -
 arch/arm/mach-highbank/core.h                 |   18 -
 arch/arm/mach-highbank/highbank.c             |  175 --
 arch/arm/mach-highbank/pm.c                   |   49 -
 arch/arm/mach-highbank/smc.S                  |   25 -
 arch/arm/mach-highbank/sysregs.h              |   75 -
 arch/arm/mach-highbank/system.c               |   22 -
 drivers/ata/Kconfig                           |    9 -
 drivers/ata/Makefile                          |    1 -
 drivers/ata/sata_highbank.c                   |  635 ------
 drivers/clk/Makefile                          |    1 -
 drivers/clk/clk-highbank.c                    |  329 ---
 drivers/cpufreq/Kconfig.arm                   |   10 -
 drivers/cpufreq/Makefile                      |    3 +-
 drivers/cpufreq/cpufreq-dt-platdev.c          |    3 -
 drivers/cpufreq/highbank-cpufreq.c            |  106 -
 drivers/cpuidle/Kconfig.arm                   |    7 -
 drivers/cpuidle/Makefile                      |    1 -
 drivers/cpuidle/cpuidle-calxeda.c             |   72 -
 drivers/edac/Kconfig                          |   14 -
 drivers/edac/Makefile                         |    3 -
 drivers/edac/highbank_l2_edac.c               |  142 --
 drivers/edac/highbank_mc_edac.c               |  272 ---
 drivers/iommu/arm-smmu-impl.c                 |   43 -
 drivers/net/ethernet/Kconfig                  |    1 -
 drivers/net/ethernet/Makefile                 |    1 -
 drivers/net/ethernet/calxeda/Kconfig          |    9 -
 drivers/net/ethernet/calxeda/Makefile         |    2 -
 drivers/net/ethernet/calxeda/xgmac.c          | 1927 -----------------
 drivers/vfio/platform/reset/Kconfig           |    8 -
 drivers/vfio/platform/reset/Makefile          |    2 -
 .../reset/vfio_platform_calxedaxgmac.c        |   74 -
 49 files changed, 2 insertions(+), 4740 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/calxeda.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/calxeda/l2ecc.txt
 delete mode 100644 Documentation/devicetree/bindings/ata/sata_highbank.txt
 delete mode 100644 Documentation/devicetree/bindings/clock/calxeda.txt
 delete mode 100644 Documentation/devicetree/bindings/memory-controllers/calxeda-ddr-ctrlr.txt
 delete mode 100644 Documentation/devicetree/bindings/net/calxeda-xgmac.txt
 delete mode 100644 Documentation/devicetree/bindings/phy/calxeda-combophy.txt
 delete mode 100644 arch/arm/boot/dts/ecx-2000.dts
 delete mode 100644 arch/arm/boot/dts/ecx-common.dtsi
 delete mode 100644 arch/arm/boot/dts/highbank.dts
 delete mode 100644 arch/arm/mach-highbank/Kconfig
 delete mode 100644 arch/arm/mach-highbank/Makefile
 delete mode 100644 arch/arm/mach-highbank/core.h
 delete mode 100644 arch/arm/mach-highbank/highbank.c
 delete mode 100644 arch/arm/mach-highbank/pm.c
 delete mode 100644 arch/arm/mach-highbank/smc.S
 delete mode 100644 arch/arm/mach-highbank/sysregs.h
 delete mode 100644 arch/arm/mach-highbank/system.c
 delete mode 100644 drivers/ata/sata_highbank.c
 delete mode 100644 drivers/clk/clk-highbank.c
 delete mode 100644 drivers/cpufreq/highbank-cpufreq.c
 delete mode 100644 drivers/cpuidle/cpuidle-calxeda.c
 delete mode 100644 drivers/edac/highbank_l2_edac.c
 delete mode 100644 drivers/edac/highbank_mc_edac.c
 delete mode 100644 drivers/net/ethernet/calxeda/Kconfig
 delete mode 100644 drivers/net/ethernet/calxeda/Makefile
 delete mode 100644 drivers/net/ethernet/calxeda/xgmac.c
 delete mode 100644 drivers/vfio/platform/reset/vfio_platform_calxedaxgmac.c


base-commit: 11a48a5a18c63fd7621bb050228cebf13566e4d8
--
2.20.1
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
