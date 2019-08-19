Return-Path: <SRS0=RhgY=WP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1867EC3A5A1
	for <iommu@archiver.kernel.org>; Mon, 19 Aug 2019 13:23:20 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9C362085A
	for <iommu@archiver.kernel.org>; Mon, 19 Aug 2019 13:23:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9C362085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 7AD03E43;
	Mon, 19 Aug 2019 13:23:05 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 2D0D7E31
	for <iommu@lists.linux-foundation.org>;
	Mon, 19 Aug 2019 13:23:03 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 4B5A08A2
	for <iommu@lists.linux-foundation.org>;
	Mon, 19 Aug 2019 13:23:01 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id D15E3309; Mon, 19 Aug 2019 15:22:58 +0200 (CEST)
From: Joerg Roedel <joro@8bytes.org>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 00/11 v3] Cleanup IOMMU passthrough setting (and disable IOMMU
	Passthrough when SME is active)
Date: Mon, 19 Aug 2019 15:22:45 +0200
Message-Id: <20190819132256.14436-1-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
Cc: fenghua.yu@intel.com, tony.luck@intel.com, linux-ia64@vger.kernel.org,
	corbet@lwn.net, Joerg Roedel <jroedel@suse.de>, x86@kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, mingo@redhat.com, bp@alien8.de,
	Thomas.Lendacky@amd.com, hpa@zytor.com, tglx@linutronix.de
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

From: Joerg Roedel <jroedel@suse.de>

Hi,

This patch-set started out small to overwrite the default passthrough
setting (through CONFIG_IOMMU_DEFAULT_PASSTHROUGH=y) when SME is active.

But on the way to that Tom reminded me that the current ways to
configure passthrough/no-passthrough modes for IOMMU on x86 is a mess.
So I added a few more patches to clean that up a bit, getting rid of the
iommu_pass_through variable on the way.This information is now kept only
in iommu code, with helpers to change that setting from architecture
code.

And of course this patch-set still disables IOMMU Passthrough mode when
SME is active even when CONFIG_IOMMU_DEFAULT_PASSTHROUGH=y is set.

The reason for that change is that SME with passthrough mode turned out
to be fragile with devices requiring SWIOTLB, mainly because SWIOTLB has
a maximum allocation size of 256kb and a limit overall size of the
bounce buffer.

Therefore having IOMMU in translation mode by default is better when SME
is active on a system.

Please review.

Thanks,

	Joerg

Changes since v2:

	- Added 'bool cmd_line' parameter to iommu_set_default_*()
	  functions, so that we correctly recognize iommu=pt/nopt
	  command line parameters

Changes since v1:

	- Cleaned up the kernel command line parameters to
	  configure passthrough/translated mode, getting rid
	  of the global iommu_pass_through variable

Joerg Roedel (11):
  iommu: Remember when default domain type was set on kernel command line
  iommu: Add helpers to set/get default domain type
  iommu: Use Functions to set default domain type in iommu_set_def_domain_type()
  iommu/amd: Request passthrough mode from IOMMU core
  iommu/vt-d: Request passthrough mode from IOMMU core
  x86/dma: Get rid of iommu_pass_through
  ia64: Get rid of iommu_pass_through
  iommu: Print default domain type on boot
  iommu: Set default domain type at runtime
  iommu: Disable passthrough mode when SME is active
  Documentation: Update Documentation for iommu.passthrough

 Documentation/admin-guide/kernel-parameters.txt |  2 +-
 arch/ia64/include/asm/iommu.h                   |  2 -
 arch/ia64/kernel/pci-dma.c                      |  2 -
 arch/x86/include/asm/iommu.h                    |  1 -
 arch/x86/kernel/pci-dma.c                       | 20 +-----
 drivers/iommu/amd_iommu.c                       |  6 +-
 drivers/iommu/intel-iommu.c                     |  2 +-
 drivers/iommu/iommu.c                           | 93 +++++++++++++++++++++++--
 include/linux/iommu.h                           | 16 +++++
 9 files changed, 110 insertions(+), 34 deletions(-)

-- 
2.16.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
