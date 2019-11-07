Return-Path: <SRS0=3PM5=Y7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F0FC5DF60
	for <iommu@archiver.kernel.org>; Thu,  7 Nov 2019 14:30:27 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ADC221D6C
	for <iommu@archiver.kernel.org>; Thu,  7 Nov 2019 14:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ygxopWXv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ADC221D6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 731FA154D;
	Thu,  7 Nov 2019 14:30:27 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id BB3391545
	for <iommu@lists.linux-foundation.org>;
	Thu,  7 Nov 2019 14:30:25 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 5915E710
	for <iommu@lists.linux-foundation.org>;
	Thu,  7 Nov 2019 14:30:25 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
	bits)) (No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 4C0FC2187F;
	Thu,  7 Nov 2019 14:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573137025;
	bh=nunLUUukjE7H+fygHiM0yHAgwOJt5cB9lKYVFnHbO2A=;
	h=Date:From:To:Cc:Subject:From;
	b=ygxopWXvNWBupUFfq+x0vV43LlTIWXYmOf1NY0ueGzxoPfIsBX5uSzD8OBMbcAVv3
	55D+6XneAw5b2ySi62WSvlZ1/lROxqh3btERAwqCJ8UssH2gavgbfoM4POfpcO52Cm
	oa1pCEDIYApB47JJ+9Xbqlt0YgfQBlGmPp0TqSOA=
Date: Thu, 7 Nov 2019 14:30:20 +0000
From: Will Deacon <will@kernel.org>
To: joro@8bytes.org
Subject: [GIT PULL] iommu/arm-smmu: Updates for 5.5
Message-ID: <20191107143020.GA12988@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org, robin.murphy@arm.com,
	linux-kernel@vger.kernel.org
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

Please pull these Arm SMMU updates for 5.5. The main changes are support
for the Qualcomm SMMUv2 implementation in the SDM845 SoC using the recently
introduced "implementation hook" code, a bunch of preparatory work to
expose TTBR1 via the io-pgtable code so that two (distinct) page tables
can be attached to a domain at the same time and performance improvements
relating to runtime power management on SMMUv2 during unmap() and general
dispatch of the new TLB invalidation callbacks.

The Qualcomm patches necessitated some changes to their firmware interface
code, but that has been Acked by Andy and Bjorn.

There were some conflicts with the fixes I sent you previously, so this
branch has those same commits merged in because I didn't want to rebase.

Cheers,

Will

--->8

The following changes since commit 1be08f458d1602275b02f5357ef069957058f3fd:

  iommu/io-pgtable-arm: Support all Mali configurations (2019-10-01 12:16:47 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-joerg/arm-smmu/updates

for you to fetch changes up to dd5ddd3c7a8c7ac382a82d15757f0ca3ab2b2dbc:

  iommu/io-pgtable-arm: Rename IOMMU_QCOM_SYS_CACHE and improve doc (2019-11-07 12:19:05 +0000)

----------------------------------------------------------------
Christophe JAILLET (2):
      iommu/io-pgtable: Move some initialization data to .init.rodata
      iommu/arm-smmu: Axe a useless test in 'arm_smmu_master_alloc_smes()'

Rob Clark (1):
      iommu/arm-smmu: Avoid pathological RPM behaviour for unmaps

Robin Murphy (12):
      iommu/arm-smmu: Remove .tlb_inv_range indirection
      iommu/arm-smmu: Remove "leaf" indirection
      iommu/arm-smmu: Move .tlb_sync method to implementation
      iommu/arm-smmu: Remove arm_smmu_flush_ops
      iommu/arm-smmu: Report USF more clearly
      iommu/io-pgtable: Make selftest gubbins consistently __init
      iommu/io-pgtable-arm: Rationalise size check
      iommu/io-pgtable-arm: Simplify bounds checks
      iommu/io-pgtable-arm: Simplify start level lookup
      iommu/io-pgtable-arm: Simplify PGD size handling
      iommu/io-pgtable-arm: Simplify level indexing
      iommu/io-pgtable-arm: Rationalise MAIR handling

Vivek Gautam (3):
      firmware: qcom_scm-64: Add atomic version of qcom_scm_call
      firmware/qcom_scm: Add scm call to handle smmu errata
      iommu: arm-smmu-impl: Add sdm845 implementation hook

Will Deacon (3):
      firmware: qcom: scm: Ensure 'a0' status code is treated as signed
      Merge branch 'for-joerg/arm-smmu/fixes' into for-joerg/arm-smmu/updates
      iommu/io-pgtable-arm: Rename IOMMU_QCOM_SYS_CACHE and improve doc

 drivers/firmware/qcom_scm-32.c     |   5 +
 drivers/firmware/qcom_scm-64.c     | 153 ++++++++++++++++++--------
 drivers/firmware/qcom_scm.c        |   6 +
 drivers/firmware/qcom_scm.h        |   5 +
 drivers/iommu/Makefile             |   2 +-
 drivers/iommu/arm-smmu-impl.c      |   5 +-
 drivers/iommu/arm-smmu-qcom.c      |  51 +++++++++
 drivers/iommu/arm-smmu-v3.c        |   2 +-
 drivers/iommu/arm-smmu.c           | 217 +++++++++++++++++++++----------------
 drivers/iommu/arm-smmu.h           |  16 +--
 drivers/iommu/io-pgtable-arm-v7s.c |  15 +--
 drivers/iommu/io-pgtable-arm.c     | 130 +++++++++++-----------
 drivers/iommu/ipmmu-vmsa.c         |   2 +-
 drivers/iommu/qcom_iommu.c         |   4 +-
 include/linux/io-pgtable.h         |   2 +-
 include/linux/iommu.h              |   8 +-
 include/linux/qcom_scm.h           |   2 +
 17 files changed, 397 insertions(+), 228 deletions(-)
 create mode 100644 drivers/iommu/arm-smmu-qcom.c
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
