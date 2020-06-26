Return-Path: <SRS0=GrUw=AH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5EBDC433DF
	for <iommu@archiver.kernel.org>; Fri, 26 Jun 2020 14:47:13 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F78320768
	for <iommu@archiver.kernel.org>; Fri, 26 Jun 2020 14:47:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F78320768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 1425C2012F;
	Fri, 26 Jun 2020 14:47:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 87uaI+Tg2yCP; Fri, 26 Jun 2020 14:47:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 24034232A7;
	Fri, 26 Jun 2020 14:47:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 16542C0863;
	Fri, 26 Jun 2020 14:47:09 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 03B14C016F
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 14:47:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id DF39487698
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 14:47:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3-bUwPwPekkw for <iommu@lists.linux-foundation.org>;
 Fri, 26 Jun 2020 14:47:05 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 8085587C6F
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 14:47:05 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 5E1352A7; Fri, 26 Jun 2020 16:47:02 +0200 (CEST)
Date: Fri, 26 Jun 2020 16:47:01 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [git pull] IOMMU Fixes for Linux v5.8-rc2
Message-ID: <20200626144655.GA20234@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

The following changes since commit 48778464bb7d346b47157d21ffde2af6b2d39110:

  Linux 5.8-rc2 (2020-06-21 15:45:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.8-rc2

for you to fetch changes up to 48f0bcfb7aad2c6eb4c1e66476b58475aa14393e:

  iommu/vt-d: Fix misuse of iommu_domain_identity_map() (2020-06-23 10:08:32 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v5.8-rc2:

A couple of Intel VT-d fixes:

	- Make Intel SVM code 64bit only. The code uses pgd_t* and the
	  IOMMU only supports long-mode page-table formats, so its
	  broken on 32bit anyway.

	- Make sure GFX quirks in for Intel VT-d are not applied to
	  untrusted devices. Those devices might gain full memory access
	  otherwise.

	- Identity mapping setup fix.

	- Fix ACS enabling when Intel IOMMU is off and untrusted devices
	  are detected.

	- Two smaller fixes for coherency and IO page-table setup

----------------------------------------------------------------
Lu Baolu (5):
      iommu/vt-d: Make Intel SVM code 64-bit only
      iommu/vt-d: Set U/S bit in first level page table by default
      iommu/vt-d: Enable PCI ACS for platform opt in hint
      iommu/vt-d: Update scalable mode paging structure coherency
      iommu/vt-d: Fix misuse of iommu_domain_identity_map()

Rajat Jain (1):
      iommu/vt-d: Don't apply gfx quirks to untrusted devices

 drivers/iommu/Kconfig       |  2 +-
 drivers/iommu/intel/dmar.c  |  3 ++-
 drivers/iommu/intel/iommu.c | 59 +++++++++++++++++++++++++++++++++++++++------
 include/linux/intel-iommu.h |  1 +
 4 files changed, 56 insertions(+), 9 deletions(-)

Please pull.

Thanks,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
