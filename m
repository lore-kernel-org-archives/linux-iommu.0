Return-Path: <SRS0=a8KZ=BG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 042A2C433E4
	for <iommu@archiver.kernel.org>; Mon, 27 Jul 2020 12:05:19 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF46B20663
	for <iommu@archiver.kernel.org>; Mon, 27 Jul 2020 12:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fgIlfaG2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF46B20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 70D34876EB;
	Mon, 27 Jul 2020 12:05:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vyscTN7EHL-m; Mon, 27 Jul 2020 12:05:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id A4C82867EC;
	Mon, 27 Jul 2020 12:05:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9631AC0050;
	Mon, 27 Jul 2020 12:05:17 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 81444C004D
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jul 2020 12:05:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 6F12885E6B
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jul 2020 12:05:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 17CnuqwgecSL for <iommu@lists.linux-foundation.org>;
 Mon, 27 Jul 2020 12:05:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 0EC9385DC4
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jul 2020 12:05:16 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B457C20663;
 Mon, 27 Jul 2020 12:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1595851515;
 bh=r1kUcZmdouTSseteZGhdHYEGdV/gZ5NwF+sWDuAMOnM=;
 h=Date:From:To:Cc:Subject:From;
 b=fgIlfaG2lMAUS1E0ldkFwcqu4K50rN68s8Msg5/hB+gWmiciFrohRD/NLtRt3NCc3
 tCuDaxsfmzeQjRZZT+g590lyN64EnXni4Xq/qlXx+gqX/AwXxBI7/GM4AOBv/veD5P
 O8dZGa64VIxZ2Ud/V0iVkF7i58hLlBx/oHDMxP58=
Date: Mon, 27 Jul 2020 13:05:11 +0100
From: Will Deacon <will@kernel.org>
To: joro@8bytes.org
Subject: [GIT PULL] iommu/arm-smmu: Move driver files into their own subdir
Message-ID: <20200727120510.GA20662@willie-the-truck>
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

As requested in [1], here is a second Arm SMMU pull request for 5.9, moving
the driver files into their own subdirectory to avoid cluttering
drivers/iommu/.

Cheers,

Will

[1] https://lore.kernel.org/r/20200722133323.GG27672@8bytes.org

--->8

The following changes since commit aa7ec73297df57a86308fee78d2bf86e22ea0bae:

  iommu/arm-smmu: Add global/context fault implementation hooks (2020-07-20 09:30:51 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-updates

for you to fetch changes up to e86d1aa8b60f7ea18d36f50296d7d20eb2852e7e:

  iommu/arm-smmu: Move Arm SMMU drivers into their own subdirectory (2020-07-27 12:53:10 +0100)

----------------------------------------------------------------
More Arm SMMU updates for 5.9

- Move Arm SMMU driver files into their own subdirectory

----------------------------------------------------------------
Will Deacon (1):
      iommu/arm-smmu: Move Arm SMMU drivers into their own subdirectory

 MAINTAINERS                                        | 4 ++--
 drivers/iommu/Makefile                             | 5 +----
 drivers/iommu/arm/Makefile                         | 2 ++
 drivers/iommu/arm/arm-smmu-v3/Makefile             | 2 ++
 drivers/iommu/{ => arm/arm-smmu-v3}/arm-smmu-v3.c  | 0
 drivers/iommu/arm/arm-smmu/Makefile                | 4 ++++
 drivers/iommu/{ => arm/arm-smmu}/arm-smmu-impl.c   | 0
 drivers/iommu/{ => arm/arm-smmu}/arm-smmu-nvidia.c | 0
 drivers/iommu/{ => arm/arm-smmu}/arm-smmu-qcom.c   | 0
 drivers/iommu/{ => arm/arm-smmu}/arm-smmu.c        | 0
 drivers/iommu/{ => arm/arm-smmu}/arm-smmu.h        | 0
 drivers/iommu/{ => arm/arm-smmu}/qcom_iommu.c      | 0
 12 files changed, 11 insertions(+), 6 deletions(-)
 create mode 100644 drivers/iommu/arm/Makefile
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/Makefile
 rename drivers/iommu/{ => arm/arm-smmu-v3}/arm-smmu-v3.c (100%)
 create mode 100644 drivers/iommu/arm/arm-smmu/Makefile
 rename drivers/iommu/{ => arm/arm-smmu}/arm-smmu-impl.c (100%)
 rename drivers/iommu/{ => arm/arm-smmu}/arm-smmu-nvidia.c (100%)
 rename drivers/iommu/{ => arm/arm-smmu}/arm-smmu-qcom.c (100%)
 rename drivers/iommu/{ => arm/arm-smmu}/arm-smmu.c (100%)
 rename drivers/iommu/{ => arm/arm-smmu}/arm-smmu.h (100%)
 rename drivers/iommu/{ => arm/arm-smmu}/qcom_iommu.c (100%)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
