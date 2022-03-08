Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9C9CC433EF
	for <iommu@archiver.kernel.org>; Tue,  8 Mar 2022 10:18:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6E20940472;
	Tue,  8 Mar 2022 10:18:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dUDFzeswd5wO; Tue,  8 Mar 2022 10:18:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 00DD5400FD;
	Tue,  8 Mar 2022 10:18:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BE225C001D;
	Tue,  8 Mar 2022 10:18:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 55532C000B
 for <iommu@lists.linux-foundation.org>; Tue,  8 Mar 2022 10:18:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3B9084021F
 for <iommu@lists.linux-foundation.org>; Tue,  8 Mar 2022 10:18:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hU3BmaKqzBol for <iommu@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 10:18:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 676FE401E9
 for <iommu@lists.linux-foundation.org>; Tue,  8 Mar 2022 10:18:21 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 74A89CE1389;
 Tue,  8 Mar 2022 10:18:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78646C340F5;
 Tue,  8 Mar 2022 10:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1646734695;
 bh=RVm+u++xiJMcvCjfVFFJLnTbinzhAa77XmTYfnikpH4=;
 h=Date:From:To:Cc:Subject:From;
 b=Q1OMohd5ioeyo0mcG+oVM+bQiMHlDYJrc2anSe4WEDbA2XgTYjH8Zh08JPtjuoV0/
 YP2UHN+XvydgfiMwAkoflPIi0AORaagTtNOIxAUA4JbOvf8So2VkYY3ydC6bO+6h1u
 MehkGIcjyqfEHRF2uFqlZKqb7hSd59reJ8G15ixyjVy0WWWitpwgKNadRnDFeP7fSQ
 EqzRmvXum19u8l9GiILE4edDHfYoLemby3NaGl0FRaUpwXYffnmBu74O045c4dgVDa
 ryBfCi5FpgU4J9QsOIRj4RhTO3zU3FCtZL94YPN8kUqidf8ltuUFznevRv3NIzCFyz
 pszAxC/eKhZRQ==
Date: Tue, 8 Mar 2022 10:18:10 +0000
From: Will Deacon <will@kernel.org>
To: joro@8bytes.org
Subject: [GIT PULL] iommu/arm-smmu: Updates for 5.18
Message-ID: <20220308101810.GB31063@willie-the-truck>
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

Please pull this handful of Arm SMMU updates for 5.18. Summary in the tag.

Cheers,

Will

--->8

The following changes since commit 26291c54e111ff6ba87a164d85d4a4e134b7315c:

  Linux 5.17-rc2 (2022-01-30 15:37:07 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-updates

for you to fetch changes up to 97dfad194ca8de04c7292d4f4c8dc493c0d20f85:

  iommu/arm-smmu: Account for PMU interrupts (2022-03-07 21:09:39 +0000)

----------------------------------------------------------------
Arm SMMU updates for 5.18

- Fix SMMUv3 soft lockup during continuous stream of events

- Fix error path for Qualcomm SMMU probe()

- Rework SMMU IRQ setup to prepare the ground for PMU support

- Minor cleanups and refactoring

----------------------------------------------------------------
Andy Shevchenko (1):
      perf/smmuv3: Don't cast parameter in bit operations

Christophe JAILLET (2):
      iommu/arm-smmu-v3: Avoid open coded arithmetic in memory allocation
      iommu/arm-smmu-v3: Simplify memory allocation

Miaoqian Lin (1):
      iommu/arm-smmu: Add missing pm_runtime_disable() in qcom_iommu_device_probe

Robin Murphy (1):
      iommu/arm-smmu: Account for PMU interrupts

Zhou Guanghui (1):
      iommu/arm-smmu-v3: fix event handling soft lockup

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 27 +++------
 drivers/iommu/arm/arm-smmu/arm-smmu.c       | 93 ++++++++++++++---------------
 drivers/iommu/arm/arm-smmu/arm-smmu.h       |  5 +-
 drivers/iommu/arm/arm-smmu/qcom_iommu.c     | 10 +++-
 drivers/perf/arm_smmuv3_pmu.c               |  4 +-
 5 files changed, 64 insertions(+), 75 deletions(-)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
