Return-Path: <SRS0=EPGj=UL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C80C31E46
	for <iommu@archiver.kernel.org>; Wed, 12 Jun 2019 07:17:35 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83F6320684
	for <iommu@archiver.kernel.org>; Wed, 12 Jun 2019 07:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZAs7q5+B";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KDzaqLHB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83F6320684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 3829F15F8;
	Wed, 12 Jun 2019 07:17:35 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id DBEE015E9
	for <iommu@lists.linux-foundation.org>;
	Wed, 12 Jun 2019 07:16:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 6E3CE87E
	for <iommu@lists.linux-foundation.org>;
	Wed, 12 Jun 2019 07:16:10 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 31D4F60741; Wed, 12 Jun 2019 07:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1560323770;
	bh=G4FwNfCMzmbQWhHtSmKn6+0lmeggfG6bd2sWRg5DNvI=;
	h=From:To:Cc:Subject:Date:From;
	b=ZAs7q5+BZKQBzehPs8zjt+RJP3QzWuLTdjldsEGADRZeZM8EmubFAsFGoG436Cjwt
	uk2wRKDjmoB2V+y+cLG0sCeX7DCuelUie1TotjhxPhrKWMFJdkOOP+88tYqX2s3YLZ
	ItLnanIChIr5wrCZ+mznLZ6kOnGJKu5N1KD8++Pk=
Received: from blr-ubuntu-41.ap.qualcomm.com
	(blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com
	[103.229.18.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: vivek.gautam@smtp.codeaurora.org)
	by smtp.codeaurora.org (Postfix) with ESMTPSA id 1E560602F4;
	Wed, 12 Jun 2019 07:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1560323769;
	bh=G4FwNfCMzmbQWhHtSmKn6+0lmeggfG6bd2sWRg5DNvI=;
	h=From:To:Cc:Subject:Date:From;
	b=KDzaqLHB/BqX8eUq14ztTe0VJox0crdOGG6NEngsossj0T4OrO8Yo1It5zG/5sH4D
	sF08JKP1JBDfrMbmRRMMQ5SElwZ8PHtH1qFSuXhQSzUG5dcsiS5HW/3gMXSzzg2Oe6
	mvTvoN7Cp59yfDeljqrUMP7jTv4Nglw3Lrrs8ezQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1E560602F4
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
	dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
	spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
From: Vivek Gautam <vivek.gautam@codeaurora.org>
To: agross@kernel.org, robh+dt@kernel.org, will.deacon@arm.com,
	robin.murphy@arm.com, joro@8bytes.org, bjorn.andersson@linaro.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH v3 0/4] Qcom smmu-500 wait-for-safe handling for sdm845
Date: Wed, 12 Jun 2019 12:45:50 +0530
Message-Id: <20190612071554.13573-1-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9a70
Cc: david.brown@linaro.org, linux-kernel@vger.kernel.org
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Subject changed, older subject was -
Qcom smmu-500 TLB invalidation errata for sdm845.
Previous version of the patches are at [1]:

Qcom's implementation of smmu-500 on sdm845 adds a hardware logic called
wait-for-safe. This logic helps in meeting the invalidation requirements
from 'real-time clients', such as display and camera. This wait-for-safe
logic ensures that the invalidations happen after getting an ack from these
devices.
In this patch-series we are disabling this wait-for-safe logic from the
arm-smmu driver's probe as with this enabled the hardware tries to
throttle invalidations from 'non-real-time clients', such as USB and UFS.

For detailed information please refer to patch [3/4] in this series.
I have included the device tree patch too in this series for someone who
would like to test out this. Here's a branch [2] that gets display on MTP
SDM845 device.

This patch series is inspired from downstream work to handle under-performance
issues on real-time clients on sdm845. In downstream we add separate page table
ops to handle TLB maintenance and toggle wait-for-safe in tlb_sync call so that
achieve required performance for display and camera [3, 4].

Changes since v2:
 * Dropped the patch to add atomic io_read/write scm API.
 * Removed support for any separate page table ops to handle wait-for-safe.
   Currently just disabling this wait-for-safe logic from arm_smmu_device_probe()
   to achieve performance on USB/UFS on sdm845.
 * Added a device tree patch to add smmu option for fw-implemented support
   for SCM call to take care of SAFE toggling.

Changes since v1:
 * Addressed Will and Robin's comments:
    - Dropped the patch[4] that forked out __arm_smmu_tlb_inv_range_nosync(),
      and __arm_smmu_tlb_sync().
    - Cleaned up the errata patch further to use downstream polling mechanism
      for tlb sync.
 * No change in SCM call patches - patches 1 to 3.

[1] https://lore.kernel.org/patchwork/cover/983913/
[2] https://github.com/vivekgautam1/linux/tree/v5.2-rc4/sdm845-display-working
[3] https://source.codeaurora.org/quic/la/kernel/msm-4.9/commit/drivers/iommu/arm-smmu.c?h=CogSystems-msm-49/msm-4.9&id=da765c6c75266b38191b38ef086274943f353ea7
[4] https://source.codeaurora.org/quic/la/kernel/msm-4.9/commit/drivers/iommu/arm-smmu.c?h=CogSystems-msm-49/msm-4.9&id=8696005aaaf745de68f57793c1a534a34345c30a

Vivek Gautam (4):
  firmware: qcom_scm-64: Add atomic version of qcom_scm_call
  firmware/qcom_scm: Add scm call to handle smmu errata
  iommu/arm-smmu: Add support to handle Qcom's wait-for-safe logic
  arm64: dts/sdm845: Enable FW implemented safe sequence handler on MTP

 arch/arm64/boot/dts/qcom/sdm845.dtsi |   1 +
 drivers/firmware/qcom_scm-32.c       |   5 ++
 drivers/firmware/qcom_scm-64.c       | 149 ++++++++++++++++++++++++-----------
 drivers/firmware/qcom_scm.c          |   6 ++
 drivers/firmware/qcom_scm.h          |   5 ++
 drivers/iommu/arm-smmu.c             |  16 ++++
 include/linux/qcom_scm.h             |   2 +
 7 files changed, 140 insertions(+), 44 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
