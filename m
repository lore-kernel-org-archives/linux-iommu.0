Return-Path: <SRS0=eGnl=LK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 772DCC48BE8
	for <iommu@archiver.kernel.org>; Wed, 16 Jun 2021 10:58:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2278561042
	for <iommu@archiver.kernel.org>; Wed, 16 Jun 2021 10:58:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2278561042
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DFD9B403DB;
	Wed, 16 Jun 2021 10:58:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FuZj0JlLXGNy; Wed, 16 Jun 2021 10:58:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DBAD440177;
	Wed, 16 Jun 2021 10:58:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BA4E4C000E;
	Wed, 16 Jun 2021 10:58:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1B547C000B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 10:58:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 17274838FB
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 10:58:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kluBb4Q238kN for <iommu@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 10:58:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 848BF834C7
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 10:58:18 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id C42D661042;
 Wed, 16 Jun 2021 10:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623841098;
 bh=ZmODpF83uSvqjPBI5p8Cu8qZyLNvoTchOyLLBiGoWk0=;
 h=Date:From:To:Cc:Subject:From;
 b=nXoYddWxQ9Qw9vxeaHPG9Oppn9Ltc3/MiGcKG0AhbE7uGQsDxtWogIpxpTPbiFfrL
 bnK7IR7Fvdr45fMha6oVVn//JwCB6+Kc+Y7I6aGWvWYksYcIGiyzAWyIbLiRkMnY60
 wzCvIbPMlr1wthDXp6+9lKeZKScJKFfaLPv50RCTAdFNkR8xLB/ynM0vXvRDBpNWZ/
 H09xe4kcxyrbZBrQrvuVXTpysIpimjggbhNEvtuVoXITqq+yenBBOrhY+1RAlI3QFC
 9fFGe+vrRmayr+a7jz0+IwYvXCKV+jqVe39k1eiCyMLL+8bbz9VAunitPnWe87nNL6
 9d7UHjUuMkl3Q==
Date: Wed, 16 Jun 2021 11:58:13 +0100
From: Will Deacon <will@kernel.org>
To: joro@8bytes.org
Subject: [GIT PULL] iommu/arm-smmu: Updates for 5.14
Message-ID: <20210616105813.GA22735@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: robin.murphy@arm.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, treding@nvidia.com, kernel-team@android.com,
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

Please pull these Arm SMMU updates for 5.14.

Of particular note is the support for stalling faults with platform devices
using SMMUv3 -- this concludes the bulk of the SVA work from Jean-Philippe.

Other than that, one thing to note is that the patch from Thierry adding
the '->prove_finalize' implementation hook is also shared with the
memory-controller tree, since they build on top of it to get the SMMU
working with an nvidia SOC. Unfortunately, that patch also caused a NULL
dereference on other parts, so there's a subsequent patch on top here
addressing that.

Due to the above, the sooner this lands in -next, the better.

Cheers,

Will

--->8

The following changes since commit c4681547bcce777daf576925a966ffa824edd09d:

  Linux 5.13-rc3 (2021-05-23 11:42:48 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-updates

for you to fetch changes up to ddd25670d39b2181c7bec33301f2d24cdcf25dde:

  Merge branch 'for-thierry/arm-smmu' into for-joerg/arm-smmu/updates (2021-06-16 11:30:55 +0100)

----------------------------------------------------------------
Arm SMMU updates for 5.14

- SMMUv3:

  * Support stalling faults for platform devices

  * Decrease defaults sizes for the event and PRI queues

- SMMUv2:

  * Support for a new '->probe_finalize' hook, needed by Nvidia

  * Even more Qualcomm compatible strings

  * Avoid Adreno TTBR1 quirk for DB820C platform

- Misc:

  * Trivial cleanups/refactoring

----------------------------------------------------------------
Amey Narkhede (1):
      iommu/arm: Cleanup resources in case of probe error path

Bixuan Cui (1):
      iommu/arm-smmu-v3: Change *array into *const array

Eric Anholt (2):
      iommu/arm-smmu-qcom: Skip the TTBR1 quirk for db820c.
      arm64: dts: msm8996: Mark the GPU's SMMU as an adreno one.

Jean-Philippe Brucker (4):
      dt-bindings: Document stall property for IOMMU masters
      ACPI/IORT: Enable stall support for platform devices
      iommu/arm-smmu-v3: Add stall support for platform devices
      iommu/arm-smmu-v3: Ratelimit event dump

Martin Botka (1):
      iommu/arm-smmu-qcom: Add sm6125 compatible

Sai Prakash Ranjan (2):
      iommu/arm-smmu-qcom: Add SC7280 SMMU compatible
      iommu/arm-smmu-qcom: Move the adreno smmu specific impl

Shawn Guo (2):
      iommu/arm-smmu-qcom: hook up qcom_smmu_impl for ACPI boot
      iommu/arm-smmu-qcom: Protect acpi_match_platform_list() call with CONFIG_ACPI

Thierry Reding (1):
      iommu/arm-smmu: Implement ->probe_finalize()

Will Deacon (2):
      iommu/arm-smmu: Check smmu->impl pointer before dereferencing
      Merge branch 'for-thierry/arm-smmu' into for-joerg/arm-smmu/updates

Xiyu Yang (2):
      iommu/arm-smmu: Fix arm_smmu_device refcount leak when arm_smmu_rpm_get fails
      iommu/arm-smmu: Fix arm_smmu_device refcount leak in address translation

Zhen Lei (2):
      iommu/arm-smmu-v3: Decrease the queue size of evtq and priq
      iommu/arm-smmu-v3: Remove unnecessary oom message

 Documentation/devicetree/bindings/iommu/iommu.txt |  18 ++
 arch/arm64/boot/dts/qcom/msm8996.dtsi             |   2 +-
 drivers/acpi/arm64/iort.c                         |   4 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  59 +++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c       | 222 ++++++++++++++++++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h       |  48 ++++-
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c        |  43 ++++-
 drivers/iommu/arm/arm-smmu/arm-smmu.c             |  38 +++-
 drivers/iommu/arm/arm-smmu/arm-smmu.h             |   1 +
 drivers/iommu/arm/arm-smmu/qcom_iommu.c           |  13 +-
 10 files changed, 409 insertions(+), 39 deletions(-)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
