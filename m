Return-Path: <SRS0=aa3U=GS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8103AC433E0
	for <iommu@archiver.kernel.org>; Fri, 15 Jan 2021 11:26:28 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2621523358
	for <iommu@archiver.kernel.org>; Fri, 15 Jan 2021 11:26:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2621523358
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id E18C587310;
	Fri, 15 Jan 2021 11:26:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iFYAt3P1Q9DQ; Fri, 15 Jan 2021 11:26:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5589F8730C;
	Fri, 15 Jan 2021 11:26:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 34A7EC088B;
	Fri, 15 Jan 2021 11:26:27 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A417BC088B
 for <iommu@lists.linux-foundation.org>; Fri, 15 Jan 2021 11:26:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 9349786C59
 for <iommu@lists.linux-foundation.org>; Fri, 15 Jan 2021 11:26:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cxaYFqp3G2Sc for <iommu@lists.linux-foundation.org>;
 Fri, 15 Jan 2021 11:26:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 2031486AC8
 for <iommu@lists.linux-foundation.org>; Fri, 15 Jan 2021 11:26:25 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 74B52221F7;
 Fri, 15 Jan 2021 11:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1610709984;
 bh=Ud2aU3k2amrcKUSS+xZ+7kbwFYaKD8iDQJBdhP/vXCU=;
 h=Date:From:To:Cc:Subject:From;
 b=kjFFbT+cftc/qgBpV2O5kcSyfAGq9i70VipVaLTA4N5FvBFUAi3CnAJsdcuvwnsMK
 EG/W0QdAYqsWMNkN5EDMbz+k05nzFRKnLC8FsA2G1+wxquxKT42lKFgPbHL4swHi0I
 Yds6sKl5nmGCrUO5HWkfqg+OpHHDkedAs/I4E+UetBp/qIRtmMkyN25e34KNLmm50j
 efnjTDxK1OQXZVKa/JXGIWT7I6udj+57OoHVNzff/z9Q5FHCw1dgJTU0iZF2RphOsN
 Vx7Y/nSDM5LKEHm13LX3daUWT5zjF//9j8MJ74/HJ7LqLoNERJ5QlAHs2mjsSHcHit
 rdWFDtaL+H/mQ==
Date: Fri, 15 Jan 2021 11:26:20 +0000
From: Will Deacon <will@kernel.org>
To: torvalds@linux-foundation.org
Subject: [GIT PULL] IOMMU fixes for -rc4
Message-ID: <20210115112619.GA14253@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 iommu <iommu@lists.linux-foundation.org>, Robin Murphy <robin.murphy@arm.com>
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

Hi Linus,

Please pull these three IOMMU fixes for -rc4. The main one is a change
to the Intel IOMMU driver to fix the handling of unaligned addresses
when invalidating the TLB. The fix itself is a bit ugly (the caller does
a bunch of shifting which is then effectively undone later in the
callchain), but Lu has patches to clean all of this up in 5.12.

Thanks,

Will

--->8

The following changes since commit 7c29ada5e70083805bc3a68daa23441df421fbee:

  iommu/vt-d: Fix ineffective devTLB invalidation for subdevices (2021-01-07 14:38:15 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/iommu-fixes

for you to fetch changes up to 694a1c0adebee9152a9ba0320468f7921aca647d:

  iommu/vt-d: Fix duplicate included linux/dma-map-ops.h (2021-01-12 16:56:20 +0000)

----------------------------------------------------------------
iommu fixes for -rc4

- Fix address alignment handling for VT-D TLB invalidation

- Enable workarounds for buggy Qualcomm firmware on two more SoCs

- Drop duplicate #include

----------------------------------------------------------------
Konrad Dybcio (1):
      iommu: arm-smmu-qcom: Add sdm630/msm8998 compatibles for qcom quirks

Lu Baolu (1):
      iommu/vt-d: Fix unaligned addresses for intel_flush_svm_range_dev()

Tian Tao (1):
      iommu/vt-d: Fix duplicate included linux/dma-map-ops.h

 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c |  2 ++
 drivers/iommu/intel/iommu.c                |  1 -
 drivers/iommu/intel/svm.c                  | 22 ++++++++++++++++++++--
 3 files changed, 22 insertions(+), 3 deletions(-)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
