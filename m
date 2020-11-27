Return-Path: <SRS0=F28s=FB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC79DC63777
	for <iommu@archiver.kernel.org>; Fri, 27 Nov 2020 11:45:39 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64DCE206D8
	for <iommu@archiver.kernel.org>; Fri, 27 Nov 2020 11:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VeSQBB20"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64DCE206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id DE7242E309;
	Fri, 27 Nov 2020 11:45:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vqCLjbb70fLk; Fri, 27 Nov 2020 11:45:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 3A9EE2E2F9;
	Fri, 27 Nov 2020 11:45:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0B0BDC163C;
	Fri, 27 Nov 2020 11:45:37 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C18E1C0052
 for <iommu@lists.linux-foundation.org>; Fri, 27 Nov 2020 11:45:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id A12F02E301
 for <iommu@lists.linux-foundation.org>; Fri, 27 Nov 2020 11:45:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id l725ja1rmuZu for <iommu@lists.linux-foundation.org>;
 Fri, 27 Nov 2020 11:45:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id E37082E2F9
 for <iommu@lists.linux-foundation.org>; Fri, 27 Nov 2020 11:45:34 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D1427206D8;
 Fri, 27 Nov 2020 11:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1606477534;
 bh=pCuERobJCCzVNGQt0FGsvx61B+OhUF8qKzhnI5TXBWQ=;
 h=Date:From:To:Cc:Subject:From;
 b=VeSQBB20rTF2W/n/gWl929dklnJle/FUbDJ1O2K0KHwpQtRGlRTJVzfC9gvfmGKc4
 D67wwdCGhZV0ekFOWD4qRcZyGX+f/8PaUOq7m+UK1Gw+iPOI3fiWAKYFAJhDsDCO6F
 TVpQbmagZ2Agd3GCtBiTfTcpdAIJtIIcAdDcEUi0=
Date: Fri, 27 Nov 2020 11:45:29 +0000
From: Will Deacon <will@kernel.org>
To: torvalds@linux-foundation.org
Subject: [GIT PULL] IOMMU fixes for -rc6
Message-ID: <20201127114529.GB20418@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>, tglx@linutronix.de,
 Robin Murphy <robin.murphy@arm.com>
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

Hi again, Linus,

Here's another round of IOMMU fixes for -rc6 consisting mainly of a
bunch of independent driver fixes. Thomas agreed for me to take the
x86 'tboot' fix here, as it fixes a regression introduced by a vt-d
change.

Please pull,

Will

--->8

The following changes since commit 91c2c28d8de34815ea9bb4d16e9db7308ad33d3e:

  MAINTAINERS: Temporarily add myself to the IOMMU entry (2020-11-19 11:12:17 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/iommu-fixes

for you to fetch changes up to d76b42e92780c3587c1a998a3a943b501c137553:

  iommu/vt-d: Don't read VCCAP register unless it exists (2020-11-26 14:50:24 +0000)

----------------------------------------------------------------
iommu fixes for -rc6

- Fix intel iommu driver when running on devices without VCCAP_REG

- Fix swiotlb and "iommu=pt" interaction under TXT (tboot)

- Fix missing return value check during device probe()

- Fix probe ordering for Qualcomm SMMU implementation

- Ensure page-sized mappings are used for AMD IOMMU buffers with SNP RMP

----------------------------------------------------------------
David Woodhouse (1):
      iommu/vt-d: Don't read VCCAP register unless it exists

John Stultz (1):
      arm-smmu-qcom: Ensure the qcom_scm driver has finished probing

Lu Baolu (1):
      x86/tboot: Don't disable swiotlb when iommu is forced on

Shameer Kolothum (1):
      iommu: Check return of __iommu_attach_device()

Suravee Suthikulpanit (1):
      iommu/amd: Enforce 4k mapping for certain IOMMU data structures

 arch/x86/kernel/tboot.c                    |  5 +----
 drivers/iommu/amd/init.c                   | 27 ++++++++++++++++++++++-----
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c |  4 ++++
 drivers/iommu/intel/dmar.c                 |  3 ++-
 drivers/iommu/intel/iommu.c                |  4 ++--
 drivers/iommu/iommu.c                      | 10 ++++++----
 6 files changed, 37 insertions(+), 16 deletions(-)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
