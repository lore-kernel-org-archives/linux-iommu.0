Return-Path: <SRS0=d8dU=JF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993D6C433ED
	for <iommu@archiver.kernel.org>; Thu,  8 Apr 2021 13:30:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C1BA61153
	for <iommu@archiver.kernel.org>; Thu,  8 Apr 2021 13:30:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C1BA61153
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1A80884823;
	Thu,  8 Apr 2021 13:30:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id a4tHKLnSeMNT; Thu,  8 Apr 2021 13:30:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 119F883C18;
	Thu,  8 Apr 2021 13:30:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DE40DC000B;
	Thu,  8 Apr 2021 13:30:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D8BCDC000A
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 13:30:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D4D91405C7
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 13:30:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aXA59uZqmDaW for <iommu@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 13:30:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 50773400FE
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 13:30:04 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id C40C56113C;
 Thu,  8 Apr 2021 13:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617888603;
 bh=NfLfquOCyf9Vx2nOKutNnCFVm83emxs246Y2WC5ndgY=;
 h=Date:From:To:Cc:Subject:From;
 b=hMudnabJt8rAyFOkHZeu6v5zhqbqpGRTEIsE25L+r2gOPljpxM6yCm6UKFd0rjJoZ
 BNRikw0D2pQpNDcw6dNj/tUdbAUYYGIUS5qCm5thXlJcCLvkjO4NoGiHPIex4xhSGF
 ec4GGjPGySTXjj9+ymY2jfYBwjmj+aMvqLuiHdQBNL2CBB65+loIi2/409cvhTtTdF
 TjEF3BbuI2sGeYlDYa6kMbOQeHQhokYtXgEaJ5JRUCNVwn+hzjyaPxfhifIs4wM9Mc
 SjLJk93GNabznECcVecP8xtqXmNCQn3nye3w/Ao4Xkl4eJKkUotutOOLhBi/6S3s9q
 kzTVtpbfD/Rpg==
Date: Thu, 8 Apr 2021 14:29:59 +0100
From: Will Deacon <will@kernel.org>
To: joro@8bytes.org
Subject: [GIT PULL] iommu/arm-smmu: Updates for 5.13
Message-ID: <20210408132959.GB17873@willie-the-truck>
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

There's hardly anything on the SMMU front for 5.13, but please pull
these regardless. Summary in the tag.

Cheers,

Will

--->8

The following changes since commit 1e28eed17697bcf343c6743f0028cc3b5dd88bf0:

  Linux 5.12-rc3 (2021-03-14 14:41:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-updates

for you to fetch changes up to e0bb4b73540495111ff2723e41cf5add2f031021:

  iommu/arm-smmu-v3: Remove the unused fields for PREFETCH_CONFIG command (2021-04-07 11:30:40 +0100)

----------------------------------------------------------------
Arm SMMU updates for 5.13

- SMMUv3:

  * Drop vestigial PREFETCH_ADDR support

  * Elide TLB sync logic for empty gather

  * Fix "Service Failure Mode" handling

- SMMUv2:

  * New Qualcomm compatible string

----------------------------------------------------------------
Sai Prakash Ranjan (1):
      dt-bindings: arm-smmu: Add compatible for SC7280 SoC

Xiang Chen (1):
      iommu/arm-smmu-v3: Add a check to avoid invalid iotlb sync

Zenghui Yu (1):
      iommu/arm-smmu-v3: Remove the unused fields for PREFETCH_CONFIG command

Zhen Lei (1):
      iommu/arm-smmu-v3: add bit field SFM into GERROR_ERR_MASK

 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c           | 5 +++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h           | 4 +---
 3 files changed, 5 insertions(+), 5 deletions(-)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
