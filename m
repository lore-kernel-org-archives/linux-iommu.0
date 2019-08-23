Return-Path: <SRS0=APMu=WT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74DCC3A5A4
	for <iommu@archiver.kernel.org>; Fri, 23 Aug 2019 14:55:06 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B24A122CE3
	for <iommu@archiver.kernel.org>; Fri, 23 Aug 2019 14:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ShNGWUgi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B24A122CE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 9E26FFB7;
	Fri, 23 Aug 2019 14:54:49 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 2FEC8F90
	for <iommu@lists.linux-foundation.org>;
	Fri, 23 Aug 2019 14:54:48 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 620AD7FB
	for <iommu@lists.linux-foundation.org>;
	Fri, 23 Aug 2019 14:54:46 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
	bits)) (No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 1190E22CE3;
	Fri, 23 Aug 2019 14:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566572086;
	bh=lJbwcNuXBLBOGKeSUzkdVWU1aT1DeSZnQwEw8jSvh0g=;
	h=Date:From:To:Cc:Subject:From;
	b=ShNGWUgimD1YRDPnp8mWCYcV6Y573AmwOnbaQNXNxJd9SaJwcO1xv4+47K7dvM7pH
	rwo4Z+nYh2rWgnjCz+Dt8LRskc3zzIVY936SHZfdfEdxr5f99vh6lMIN0yBWGWuo7s
	yT3CqaQ7Mr4NgJFyR1cbt90YH3ybeLIcDHaNhc8o=
Date: Fri, 23 Aug 2019 15:54:41 +0100
From: Will Deacon <will@kernel.org>
To: joro@8bytes.org
Subject: [GIT PULL] iommu/arm-smmu: Big batch of updates for 5.4
Message-ID: <20190823145440.2b7ejsnglz2bju5k@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Cc: jean-philippe@linaro.org, iommu@lists.linux-foundation.org,
	robin.murphy@arm.com
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

Hi Joerg,

Please pull these ARM SMMU updates for 5.4. The branch is based on the
for-joerg/batched-unmap branch that you pulled into iommu/core already
because I didn't want to rebase everything onto -rc3. The pull request
was generated against iommu/core.

There's a lot of code here, but the headlines are:

  * Complete refactoring of arm-smmu.c to allow for implementation-specific
    quirks, errata and general weirdness outside of the core architecture
    support code.

  * Rework of the SMMUv3 ATS support, after it was found to be broken.
    Since it's a pretty niche thing for us right now, the support is
    effectively reverted for -stable kernels.

  * New algorithm for submitting commands to the SMMUv3 command queue
    which removes the need for a spinlock and reduces CPU usage under
    heavy I/O loads.

There's some ongoing work to extend io-pgtable to be able to deal with
high virtual address ranges but that's not quite there yet and I hope
to queue it for 5.5 instead.

Any problems, just shout (although it's a public holiday on Monday in
the UK, so you'll have to shout very loudly indeed).

Cheers,

Will

--->8

The following changes since commit 3951c41af4a65ba418e6b1b973d398552bedb84f:

  iommu/io-pgtable: Pass struct iommu_iotlb_gather to ->tlb_add_page() (2019-07-29 17:22:59 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-joerg/arm-smmu/updates

for you to fetch changes up to 1554240ff864da9eb99e2233d3faf191c567c47a:

  Merge branches 'for-joerg/arm-smmu/smmu-v2' and 'for-joerg/arm-smmu/smmu-v3' into for-joerg/arm-smmu/updates (2019-08-23 15:05:45 +0100)

----------------------------------------------------------------
Robin Murphy (18):
      iommu/arm-smmu: Mask TLBI address correctly
      iommu/qcom: Mask TLBI addresses correctly
      iommu/arm-smmu: Convert GR0 registers to bitfields
      iommu/arm-smmu: Convert GR1 registers to bitfields
      iommu/arm-smmu: Convert context bank registers to bitfields
      iommu/arm-smmu: Rework cb_base handling
      iommu/arm-smmu: Split arm_smmu_tlb_inv_range_nosync()
      iommu/arm-smmu: Get rid of weird "atomic" write
      iommu/arm-smmu: Abstract GR1 accesses
      iommu/arm-smmu: Abstract context bank accesses
      iommu/arm-smmu: Abstract GR0 accesses
      iommu/arm-smmu: Rename arm-smmu-regs.h
      iommu/arm-smmu: Add implementation infrastructure
      iommu/arm-smmu: Move Secure access quirk to implementation
      iommu/arm-smmu: Add configuration implementation hook
      iommu/arm-smmu: Add reset implementation hook
      iommu/arm-smmu: Add context init implementation hook
      iommu/arm-smmu: Ensure 64-bit I/O accessors are available on 32-bit CPU

Will Deacon (16):
      iommu/arm-smmu-v3: Separate s/w and h/w views of prod and cons indexes
      iommu/arm-smmu-v3: Drop unused 'q' argument from Q_OVF macro
      iommu/arm-smmu-v3: Move low-level queue fields out of arm_smmu_queue
      iommu/arm-smmu-v3: Operate directly on low-level queue where possible
      iommu/arm-smmu-v3: Reduce contention during command-queue insertion
      iommu/arm-smmu-v3: Defer TLB invalidation until ->iotlb_sync()
      iommu/arm-smmu: Make private implementation details static
      iommu/arm-smmu-v3: Document ordering guarantees of command insertion
      iommu/arm-smmu-v3: Disable detection of ATS and PRI
      iommu/arm-smmu-v3: Remove boolean bitfield for 'ats_enabled' flag
      iommu/arm-smmu-v3: Don't issue CMD_SYNC for zero-length invalidations
      iommu/arm-smmu-v3: Rework enabling/disabling of ATS for PCI masters
      iommu/arm-smmu-v3: Fix ATC invalidation ordering wrt main TLBs
      iommu/arm-smmu-v3: Avoid locking on invalidation path when not using ATS
      Revert "iommu/arm-smmu-v3: Disable detection of ATS and PRI"
      Merge branches 'for-joerg/arm-smmu/smmu-v2' and 'for-joerg/arm-smmu/smmu-v3' into for-joerg/arm-smmu/updates

 MAINTAINERS                   |   3 +-
 drivers/iommu/Makefile        |   2 +-
 drivers/iommu/arm-smmu-impl.c | 174 ++++++++
 drivers/iommu/arm-smmu-regs.h | 210 ----------
 drivers/iommu/arm-smmu-v3.c   | 945 +++++++++++++++++++++++++++++++-----------
 drivers/iommu/arm-smmu.c      | 579 ++++++++------------------
 drivers/iommu/arm-smmu.h      | 402 ++++++++++++++++++
 drivers/iommu/qcom_iommu.c    |  17 +-
 8 files changed, 1482 insertions(+), 850 deletions(-)
 create mode 100644 drivers/iommu/arm-smmu-impl.c
 delete mode 100644 drivers/iommu/arm-smmu-regs.h
 create mode 100644 drivers/iommu/arm-smmu.h
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
