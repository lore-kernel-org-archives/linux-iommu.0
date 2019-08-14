Return-Path: <SRS0=gZYu=WK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A7AC32753
	for <iommu@archiver.kernel.org>; Wed, 14 Aug 2019 14:09:14 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B655A206C1
	for <iommu@archiver.kernel.org>; Wed, 14 Aug 2019 14:09:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B655A206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 55112E82;
	Wed, 14 Aug 2019 14:09:14 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 7FC19E7A
	for <iommu@lists.linux-foundation.org>;
	Wed, 14 Aug 2019 14:09:13 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 120A587E
	for <iommu@lists.linux-foundation.org>;
	Wed, 14 Aug 2019 14:09:13 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id 013DD2F9; Wed, 14 Aug 2019 16:09:10 +0200 (CEST)
Date: Wed, 14 Aug 2019 16:09:09 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [git pull] IOMMU Fixes for Linux v5.3-rc4
Message-ID: <20190814140902.GA28527@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

Hi Linus,

The following changes since commit e21a712a9685488f5ce80495b37b9fdbe96c230d:

  Linux 5.3-rc3 (2019-08-04 18:40:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.3-rc4

for you to fetch changes up to 3a18844dcf89e636b2d0cbf577e3963b0bcb6d23:

  iommu/vt-d: Fix possible use-after-free of private domain (2019-08-09 17:35:25 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v5.3-rc4

Including:

	- A couple more fixes for the Intel VT-d driver for bugs
	  introduced during the recent conversion of this driver to use
	  IOMMU core default domains.

	- Fix for common dma-iommu code to make sure MSI mappings happen
	  in the correct domain for a device.

	- Fix a corner case in the handling of sg-lists in dma-iommu
	  code that might cause dma_length to be truncated.

	- Mark a switch as fall-through in arm-smmu code.

----------------------------------------------------------------
Anders Roxell (1):
      iommu/arm-smmu: Mark expected switch fall-through

Lu Baolu (4):
      iommu/vt-d: Detach domain when move device out of group
      iommu/vt-d: Correctly check format of page table in debugfs
      iommu/vt-d: Detach domain before using a private one
      iommu/vt-d: Fix possible use-after-free of private domain

Robin Murphy (2):
      iommu/dma: Handle MSI mappings separately
      iommu/dma: Handle SG length overflow better

 drivers/iommu/arm-smmu-v3.c         |  4 ++--
 drivers/iommu/dma-iommu.c           | 19 +++++++++++--------
 drivers/iommu/intel-iommu-debugfs.c |  2 +-
 drivers/iommu/intel-iommu.c         | 11 +++++++++--
 4 files changed, 23 insertions(+), 13 deletions(-)

Please pull.

Thanks,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
