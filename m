Return-Path: <SRS0=Q5U9=VI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB3CC742A1
	for <iommu@archiver.kernel.org>; Thu, 11 Jul 2019 19:48:12 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3325920863
	for <iommu@archiver.kernel.org>; Thu, 11 Jul 2019 19:48:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3325920863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C0CA954D9;
	Thu, 11 Jul 2019 19:47:54 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 77F5C50E0
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Jul 2019 19:15:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mslow2.mail.gandi.net (mslow2.mail.gandi.net [217.70.178.242])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id D7A0089F
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Jul 2019 19:15:42 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (unknown [217.70.183.194])
	by mslow2.mail.gandi.net (Postfix) with ESMTP id D85FA3A2705
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Jul 2019 15:03:13 +0000 (UTC)
X-Originating-IP: 92.137.69.152
Received: from localhost (alyon-656-1-672-152.w92-137.abo.wanadoo.fr
	[92.137.69.152]) (Authenticated sender: gregory.clement@bootlin.com)
	by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id B75B84000B;
	Thu, 11 Jul 2019 15:03:06 +0000 (UTC)
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [PATCH v2 0/4]  Add system mmu support for Armada-806
Date: Thu, 11 Jul 2019 17:02:38 +0200
Message-Id: <20190711150242.25290-1-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 11 Jul 2019 19:37:36 +0000
Cc: devicetree@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>, Antoine Tenart <antoine.tenart@bootlin.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Will Deacon <will.deacon@arm.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Nadav Haklai <nadavh@marvell.com>, Rob Herring <robh+dt@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>,
	linux-arm-kernel@lists.infradead.org,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
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

Hello,

last year a first version of this series was submitted to add support
for IOMMU for AP806, including workaround for accessing ARM SMMU 64bit
registers[1].

For the record, AP-806 can't access SMMU registers with 64bit width,
this patches split the readq/writeq for 32bit access, due to erratanum
#582743.

Based on the feedback from Robin Murphy, I also add code ensuring that
we won't try to use AArch64 format with 32 bits acces.

It was also discussed to not use compatible but propertu to support
this workaround. I agree to make this change if needed, but for now I
would like to have a feedback on the current code to know if it is
acceptable if there is still potential issue.

The series was tested on a vanilla v5.1 kernel, and without the
series, an USB stick was not detected under QEMU whereas with this
series it worked as expected.

Greogry

[1]: https://lkml.org/lkml/2018/10/15/373

Gregory CLEMENT (1):
  arm64: dts: marvell: armada-ap806: add smmu support

Hanna Hawa (3):
  iommu/arm-smmu: Introduce wrapper for writeq/readq
  iommu/arm-smmu: Workaround for Marvell Armada-AP806 SoC erratum
    #582743
  dt-bindings: iommu/arm,smmu: add compatible string for Marvell

 Documentation/arm64/silicon-errata.txt        |  2 +
 .../devicetree/bindings/iommu/arm,smmu.txt    |  1 +
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi | 17 +++++
 drivers/iommu/arm-smmu.c                      | 74 ++++++++++++++++---
 4 files changed, 83 insertions(+), 11 deletions(-)

-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
