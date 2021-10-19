Return-Path: <SRS0=0fjx=PH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20CFDC433EF
	for <iommu@archiver.kernel.org>; Tue, 19 Oct 2021 12:54:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D054F6137B
	for <iommu@archiver.kernel.org>; Tue, 19 Oct 2021 12:54:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D054F6137B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A141040608;
	Tue, 19 Oct 2021 12:54:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SaKCRCrGlrTK; Tue, 19 Oct 2021 12:54:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9102A40606;
	Tue, 19 Oct 2021 12:54:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6592EC000F;
	Tue, 19 Oct 2021 12:54:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5E2A8C000D
 for <iommu@lists.linux-foundation.org>; Tue, 19 Oct 2021 12:54:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5070F40282
 for <iommu@lists.linux-foundation.org>; Tue, 19 Oct 2021 12:54:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7kh9rfjwiYEF for <iommu@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 12:54:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 89B3940265
 for <iommu@lists.linux-foundation.org>; Tue, 19 Oct 2021 12:54:39 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id F03F261360;
 Tue, 19 Oct 2021 12:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1634648079;
 bh=XolEmSFJHODP9aZmMvAA9I4STQCYJzJC8vm4MrX87+A=;
 h=Date:From:To:Cc:Subject:From;
 b=JTlB2vgYj9uw9wf9tW1PRncSDV+KgTyAY3pqEqAbqoKFnZ8ZByto/QSzeQOn6Ta6K
 VKvWraVrGCwJsvslP7sZ2vkWzKg76vnnqVoO9BOvv9GUDv2sS3MOoFKHWczrEKvsNm
 +0UsPbZjQhFflXVEezwadYPjAv3BPjZK+D7WQuswWNaz1f+fN0FG2JJcW3iFotSv4w
 z9GksigTUWunwJvGGZUqEnc8W+NIQQIBfvVaCsboXrqSmFshjHy3gO9UVyCA400FW6
 kmop9K/bEgwI61TQoiX2kMvgUUf/B6cyKFvhyiN749xG+HyT8wf3N+aMSJF8vlaEVq
 wvuA4ykRzYCOg==
Date: Tue, 19 Oct 2021 13:54:34 +0100
From: Will Deacon <will@kernel.org>
To: joro@8bytes.org
Subject: [GIT PULL] iommu/arm-smmu: Updates for 5.16
Message-ID: <20211019125434.GA14085@willie-the-truck>
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

Please pull this tiny batch of Arm SMMU updates for 5.16. It's dominated
by compatible string additions for Qualcomm SMMUv2 implementations, but
there's a bit of cleanup on the SMMUv3 command-submission side as well.

Cheers,

Will

--->8

The following changes since commit 5816b3e6577eaa676ceb00a848f0fd65fe2adc29:

  Linux 5.15-rc3 (2021-09-26 14:08:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-updates

for you to fetch changes up to e37f1fe4332491bf2f7b7849d5c3adba0d2a77b3:

  iommu/arm-smmu-qcom: Request direct mapping for modem device (2021-10-08 09:07:44 +0100)

----------------------------------------------------------------
Arm SMMU updates for 5.16

- Minor optimisations to SMMUv3 command creation and submission

- Numerous new compatible string for Qualcomm SMMUv2 implementations

----------------------------------------------------------------
Konrad Dybcio (2):
      dt-bindings: arm-smmu: Add compatible for SM6350 SoC
      iommu/arm-smmu-qcom: Add SM6350 SMMU compatible

Loic Poulain (2):
      dt-bindings: arm-smmu: Add compatible for QCM2290 SoC
      iommu: arm-smmu-qcom: Add compatible for QCM2290

Sibi Sankar (1):
      iommu/arm-smmu-qcom: Request direct mapping for modem device

Zhen Lei (2):
      iommu/arm-smmu-v3: Stop pre-zeroing batch commands in arm_smmu_atc_inv_master()
      iommu/arm-smmu-v3: Properly handle the return value of arm_smmu_cmdq_build_cmd()

 .../devicetree/bindings/iommu/arm,smmu.yaml         |  2 ++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c         | 21 ++++++++++++++-------
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c          |  3 +++
 3 files changed, 19 insertions(+), 7 deletions(-)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
