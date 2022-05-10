Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51C84C433F5
	for <iommu@archiver.kernel.org>; Tue, 10 May 2022 16:01:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E25DC60B1F;
	Tue, 10 May 2022 16:01:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NJxEQ5d5EIuP; Tue, 10 May 2022 16:01:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D22D6605D6;
	Tue, 10 May 2022 16:01:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AC3DFC0039;
	Tue, 10 May 2022 16:01:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7A8ABC002D
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 16:01:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5B82D60B1F
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 16:01:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SfjaJb9jnd4q for <iommu@lists.linux-foundation.org>;
 Tue, 10 May 2022 16:01:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 93CC5605D6
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 16:01:14 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id F0834B81DB5;
 Tue, 10 May 2022 16:01:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EC2AC385A6;
 Tue, 10 May 2022 16:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652198471;
 bh=8R7QdAS1HkPD/ObWmH1HXiPVeYzqdGBRiK33o/ZU5GQ=;
 h=Date:From:To:Cc:Subject:From;
 b=W7y4X9dw1SUbI/nc2u7Y9qeXUtoC/3Nid+dZQ2mRtGYVCq9EGtR9LrpPq/8Kigs+f
 W2qIOf9HwGBKJhpsHxyh57wHT4jWXpHOza9yy78a9p5d+gKATS/5s4NuhJkpmT6HeF
 mdJnStqeNYGrGrhw+GxbHG4ExkvTxZ6bxX+HwNO7r+emR1iCVhO8PYoPtU47RZTSZu
 ELPbwdJ8rW3bzCc9/Ieni0nKZ9hZtDr2raFTrrKYDJBmx6GJQT984s1Jz9kSv5LETH
 MuMw9Wv8CQokRnzPmY4WE5jo316Y1Kg8kGkUr+RYIZ0LM50bjRPHNaGq+f3AirZT5x
 v51+dhoEhe+8A==
Date: Tue, 10 May 2022 17:01:06 +0100
From: Will Deacon <will@kernel.org>
To: joro@8bytes.org
Subject: [GIT PULL] iommu/arm-smmu: Updates for 5.19
Message-ID: <20220510160106.GA28351@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: kernel-team@android.com, iommu@lists.linux-foundation.org,
 robin.murphy@arm.com, linux-kernel@vger.kernel.org,
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

Hi Joerg,

Please pull these Arm SMMU updates for 5.19. The bulk of it is just adding
new device-tree compatible strings for the existing drivers, but there
are some non-critical fixes in here as well. Please see the tag for more
details.

I used the previous fixes pull as a base for this so that you shouldn't
run into any conflicts with upstream.

Cheers,

Will

--->8

The following changes since commit 4a25f2ea0e030b2fc852c4059a50181bfc5b2f57:

  iommu: arm-smmu: disable large page mappings for Nvidia arm-smmu (2022-04-22 11:21:30 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-updates

for you to fetch changes up to 628bf55b620497a105f4963ee8fb84769f7e6bb4:

  iommu/arm-smmu: Force identity domains for legacy binding (2022-05-10 12:01:31 +0100)

----------------------------------------------------------------
Arm SMMU updates for 5.19

- Add new Qualcomm device-tree compatible strings

- Add new Nvidia device-tree compatible string for Tegra234

- Fix UAF in SMMUv3 shared virtual addressing code

- Force identity-mapped domains for users of ye olde SMMU legacy binding

- Minor cleanups

----------------------------------------------------------------
Bjorn Andersson (2):
      dt-bindings: arm-smmu: Add compatible for Qualcomm SC8280XP
      iommu/arm-smmu-qcom: Add SC8280XP support

Jean-Philippe Brucker (1):
      iommu/arm-smmu-v3-sva: Fix mm use-after-free

Robin Murphy (1):
      iommu/arm-smmu: Force identity domains for legacy binding

Rohit Agarwal (1):
      dt-bindings: arm-smmu: Add binding for SDX65 SMMU

Thierry Reding (3):
      dt-bindings: arm-smmu: Document nvidia,memory-controller property
      dt-bindings: arm-smmu: Add compatible for Tegra234 SOC
      iommu/arm-smmu: Support Tegra234 SMMU

Yang Yingliang (2):
      iommu/arm-smmu: fix possible null-ptr-deref in arm_smmu_device_probe()
      iommu/arm-smmu-v3: check return value after calling platform_get_resource()

 .../devicetree/bindings/iommu/arm,smmu.yaml        | 25 ++++++++++++++++++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c    | 13 +++++++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        |  2 ++
 drivers/iommu/arm/arm-smmu/arm-smmu-impl.c         |  3 ++-
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c         |  1 +
 drivers/iommu/arm/arm-smmu/arm-smmu.c              |  8 ++++---
 6 files changed, 44 insertions(+), 8 deletions(-)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
