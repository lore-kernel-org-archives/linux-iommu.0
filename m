Return-Path: <SRS0=te8u=GL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88255C433DB
	for <iommu@archiver.kernel.org>; Fri,  8 Jan 2021 14:40:00 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C0EE2388B
	for <iommu@archiver.kernel.org>; Fri,  8 Jan 2021 14:39:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C0EE2388B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9D4F784A0B;
	Fri,  8 Jan 2021 14:39:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Isrzsodvyjmb; Fri,  8 Jan 2021 14:39:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1D48E84032;
	Fri,  8 Jan 2021 14:39:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F3A8AC0891;
	Fri,  8 Jan 2021 14:39:58 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E64DEC013A
 for <iommu@lists.linux-foundation.org>; Fri,  8 Jan 2021 14:39:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id D910886DC0
 for <iommu@lists.linux-foundation.org>; Fri,  8 Jan 2021 14:39:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LLbJ5-g6TKzt for <iommu@lists.linux-foundation.org>;
 Fri,  8 Jan 2021 14:39:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 78FD686DBF
 for <iommu@lists.linux-foundation.org>; Fri,  8 Jan 2021 14:39:56 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id E22C023A03;
 Fri,  8 Jan 2021 14:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1610116796;
 bh=wu8Z1NndSiclLvgiYArv1I/gUeY9KPNK/Rtzl6oOWao=;
 h=Date:From:To:Cc:Subject:From;
 b=cyKH4bn+4uQ4o5U3IUubRGSPqAbgrbuR2x+uYDfuh70R9qvB5zMPij+kLFUzvTKsr
 DQ9FrP3ZWY9c1TtGaoPQoQbhHDbdIB/+ei7TUVTAiwjqJ3CTWxP4YIXUDGdpnEdLSd
 G1FteR399sqlPngl6qKSNQMzhCxHgGsAw4knlCk/eVlWJKY/kX0dGQYRnuCgrWJK8P
 OheDsDGmMkZ9zDft80iCn2GtzRQjfsCcU/7Qy2MqWhKRCaAfnF5kxADlxJ6sELOmFD
 ze8QOYGwxDr9Cwm6oAKIH1jZQmwXwbbfym38DO+bkl/ShdEw8495dKrj/59oh3c/zE
 IRqWVw3qJno/g==
Date: Fri, 8 Jan 2021 14:39:51 +0000
From: Will Deacon <will@kernel.org>
To: torvalds@linux-foundation.org
Subject: [GIT PULL] IOMMU fixes for -rc3
Message-ID: <20210108143951.GA4867@willie-the-truck>
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

Please pull these IOMMU fixes for -rc3. It's mainly all Intel VT-D stuff,
but there are some fixes for AMD and ARM as well. We've also got the
revert I promised during the merge window, which removes a temporary
hack to accomodate i915 while we transitioned the Intel IOMMU driver
over to the common DMA-IOMMU API.

Finally, there are still a couple of other VT-D fixes floating around, so I
expect to send you another batch of fixes next week.

Cheers,

Will

--->8

The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:

  Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/iommu-fixes

for you to fetch changes up to 7c29ada5e70083805bc3a68daa23441df421fbee:

  iommu/vt-d: Fix ineffective devTLB invalidation for subdevices (2021-01-07 14:38:15 +0000)

----------------------------------------------------------------
iommu fixes for -rc3

- Fix VT-D TLB invalidation for subdevices

- Fix VT-D use-after-free on subdevice detach

- Fix VT-D locking so that IRQs are disabled during SVA bind/unbind

- Fix VT-D address alignment when flushing IOTLB

- Fix memory leak in VT-D IRQ remapping failure path

- Revert temporary i915 sglist hack now that it is no longer required

- Fix sporadic boot failure with Arm SMMU on Qualcomm SM8150

- Fix NULL dereference in AMD IRQ remapping code with remapping disabled

- Fix accidental enabling of irqs on AMD resume-from-suspend path

- Fix some typos in comments

----------------------------------------------------------------
Bjorn Andersson (1):
      iommu/arm-smmu-qcom: Initialize SCTLR of the bypass context

David Woodhouse (2):
      iommu/amd: Set iommu->int_enabled consistently when interrupts are set up
      iommu/amd: Stop irq_remapping_select() matching when remapping is disabled

Dinghao Liu (1):
      iommu/intel: Fix memleak in intel_irq_remapping_alloc

Liu Yi L (3):
      iommu/vt-d: Move intel_iommu info from struct intel_svm to struct intel_svm_dev
      iommu/vt-d: Fix general protection fault in aux_detach_device()
      iommu/vt-d: Fix ineffective devTLB invalidation for subdevices

Lu Baolu (3):
      iommu/vt-d: Fix misuse of ALIGN in qi_flush_piotlb()
      Revert "iommu: Add quirk for Intel graphic devices in map_sg"
      iommu/vt-d: Fix lockdep splat in sva bind()/unbind()

Stefano Garzarella (1):
      iommu/iova: fix 'domain' typos

 drivers/iommu/amd/init.c                   |   3 +-
 drivers/iommu/amd/iommu.c                  |   3 +
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c |   2 +
 drivers/iommu/dma-iommu.c                  |  27 ------
 drivers/iommu/intel/dmar.c                 |   4 +-
 drivers/iommu/intel/iommu.c                | 148 +++++++++++++++++++++--------
 drivers/iommu/intel/irq_remapping.c        |   2 +
 drivers/iommu/intel/svm.c                  |  23 +++--
 drivers/iommu/iova.c                       |   8 +-
 include/linux/intel-iommu.h                |  18 ++--
 10 files changed, 147 insertions(+), 91 deletions(-)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
