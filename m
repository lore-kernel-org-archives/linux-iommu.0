Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78540C433F5
	for <iommu@archiver.kernel.org>; Wed, 15 Dec 2021 11:21:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0FD3060DA0;
	Wed, 15 Dec 2021 11:21:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A7-JRpilo_Fw; Wed, 15 Dec 2021 11:21:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C5B486061B;
	Wed, 15 Dec 2021 11:21:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6D378C001E;
	Wed, 15 Dec 2021 11:21:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DB215C0012
 for <iommu@lists.linux-foundation.org>; Wed, 15 Dec 2021 11:21:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CB3E040937
 for <iommu@lists.linux-foundation.org>; Wed, 15 Dec 2021 11:21:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cn4lxnVhZ2rt for <iommu@lists.linux-foundation.org>;
 Wed, 15 Dec 2021 11:21:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E19B740260
 for <iommu@lists.linux-foundation.org>; Wed, 15 Dec 2021 11:21:31 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 1782CB81EC1;
 Wed, 15 Dec 2021 11:21:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 920ABC34605;
 Wed, 15 Dec 2021 11:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1639567288;
 bh=/tc4XfmOU17H2sh1wj8kjCXk5JW0PN7jFtv/OiIdmYk=;
 h=Date:From:To:Cc:Subject:From;
 b=i9T9e1RBAQwI8cQ1eOLXeUnqMmtWbeSi2itcXnCqEijtudck/BqqfY2CKLEiSxs58
 rgkNHxUAMATp6qk8tuUDyvx77/14rVXNtOZOQ+9oQ6npviNAEajtVQT6UYHMc3wVfx
 aEVjjaohE3/KpCTdcftbSK69W1yrlaEcCVd3Rk1JRyRr/eA21lW9Q8lurt4T8TNu7R
 JbFdAgWm4mtNngd7MRQe87A8oLAbZkxYW2N6hvnz6JikLe4zORgtlyLKrGWuyvPHS5
 hURzlzGKsaP18ypzlguLYnTa9qQFl0shHmpkpCuiVTp5AvhymnGrGYPCJfZDghE7hy
 BK7YW7mFfk5Sw==
Date: Wed, 15 Dec 2021 11:21:24 +0000
From: Will Deacon <will@kernel.org>
To: joro@8bytes.org
Subject: [GIT PULL] iommu/arm-smmu: Updates for 5.17
Message-ID: <20211215112124.GC16765@willie-the-truck>
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

Please pull these Arm SMMU updates for 5.17.

Once again, there's not a lot here. In fact, it's mostly a combination
of non-critical fixes and DT compatible string additions. Summary in
the tag.

Cheers,

Will

--->8

The following changes since commit 0fcfb00b28c0b7884635dacf38e46d60bf3d4eb1:

  Linux 5.16-rc4 (2021-12-05 14:08:22 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-updates

for you to fetch changes up to 477436699e7801276fa7306e20318156cb535249:

  Revert "iommu/arm-smmu-v3: Decrease the queue size of evtq and priq" (2021-12-15 10:14:06 +0000)

----------------------------------------------------------------
Arm SMMU updates for 5.17

- Revert evtq and priq back to their former sizes

- Return early on short-descriptor page-table allocation failure

- Fix page fault reporting for Adreno GPU on SMMUv2

- Make SMMUv3 MMU notifier ops 'const'

- Numerous new compatible strings for Qualcomm SMMUv2 implementations

----------------------------------------------------------------
David Heidelberg (1):
      dt-bindings: arm-smmu: Add compatible for the SDX55 SoC

Rikard Falkeborn (1):
      iommu/arm-smmu-v3: Constify arm_smmu_mmu_notifier_ops

Rob Clark (1):
      iommu/arm-smmu-qcom: Fix TTBR0 read

Vinod Koul (2):
      dt-bindings: arm-smmu: Add compatible for SM8450 SoC
      iommu: arm-smmu-impl: Add SM8450 qcom iommu implementation

Yunfei Wang (1):
      iommu/io-pgtable-arm-v7s: Add error handle for page table allocation failure

Zhou Wang (1):
      Revert "iommu/arm-smmu-v3: Decrease the queue size of evtq and priq"

 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 2 ++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c       | 2 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h           | 5 ++---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c            | 3 ++-
 drivers/iommu/io-pgtable-arm-v7s.c                    | 6 +++++-
 5 files changed, 12 insertions(+), 6 deletions(-)

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
