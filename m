Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 828BEC433EF
	for <iommu@archiver.kernel.org>; Fri, 22 Apr 2022 11:22:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2514860F71;
	Fri, 22 Apr 2022 11:22:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uBhWQYIqplVw; Fri, 22 Apr 2022 11:22:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 174D160DCB;
	Fri, 22 Apr 2022 11:22:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B27F0C0032;
	Fri, 22 Apr 2022 11:22:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 55BE9C002D
 for <iommu@lists.linux-foundation.org>; Fri, 22 Apr 2022 11:22:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2CD3041BD6
 for <iommu@lists.linux-foundation.org>; Fri, 22 Apr 2022 11:22:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WFJob0-f0p3L for <iommu@lists.linux-foundation.org>;
 Fri, 22 Apr 2022 11:22:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CD02241BAD
 for <iommu@lists.linux-foundation.org>; Fri, 22 Apr 2022 11:22:41 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 1862CB82C15;
 Fri, 22 Apr 2022 11:22:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A31B1C385AA;
 Fri, 22 Apr 2022 11:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1650626558;
 bh=tNf+5h5T3qHAOYjpS84V/nz/K0uUb9xr3AXDzXd1SVI=;
 h=Date:From:To:Cc:Subject:From;
 b=XTO1jMQX7j4vfTBeb9FIw1ko71H9TOx62On1ZoFva/AXm+eOBvgynQS7HoqhxBhMI
 t6snACFLEJ4J68S0O+R4TzdZyFKCowXAosmIxojZV8QOaS7BQrKH6C1kljEqJDJjzu
 VzUDR+IiSRNIzE/I210JtwcxH/yQtJIpKDiSABL1Ab1Nh0T+RLv6xP94kUPZHZ3sOS
 JGC0fjfVP3iDGZdug+hJv2Le69fo0yRqU6BAvyI0Q5YHCzueevqoabyLAnFycpxXr0
 4z64Z2/pKy674216U6ONMwWB+UJJa3PZKgQ537KLqqnRmRsTssfBdq2mfWDhXEGdw0
 KTyrRFRxS0vlQ==
Date: Fri, 22 Apr 2022 12:22:34 +0100
From: Will Deacon <will@kernel.org>
To: joro@8bytes.org
Subject: [GIT PULL] iommu/arm-smmu: Fixes for 5.18
Message-ID: <20220422112233.GB9901@willie-the-truck>
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

Unusually, we've got some SMMU driver fixes this time around. Summary in
the tag -- please can you pull these for 5.18?

Cheers,

Will

--->8

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-fixes

for you to fetch changes up to 4a25f2ea0e030b2fc852c4059a50181bfc5b2f57:

  iommu: arm-smmu: disable large page mappings for Nvidia arm-smmu (2022-04-22 11:21:30 +0100)

----------------------------------------------------------------
Arm SMMU fixes for 5.18

- Fix off-by-one in SMMUv3 SVA TLB invalidation

- Disable large mappings to workaround nvidia erratum

----------------------------------------------------------------
Ashish Mhetre (1):
      iommu: arm-smmu: disable large page mappings for Nvidia arm-smmu

Nicolin Chen (1):
      iommu/arm-smmu-v3: Fix size calculation in arm_smmu_mm_invalidate_range()

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c |  9 +++++++-
 drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c    | 30 +++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 1 deletion(-)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
