Return-Path: <SRS0=tLNU=5F=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88552C4332D
	for <iommu@archiver.kernel.org>; Fri, 20 Mar 2020 15:35:29 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FCFC2070A
	for <iommu@archiver.kernel.org>; Fri, 20 Mar 2020 15:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZnbSRZUX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FCFC2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5F8C788869;
	Fri, 20 Mar 2020 15:35:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3udUISk64x3h; Fri, 20 Mar 2020 15:35:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id BE3918876B;
	Fri, 20 Mar 2020 15:35:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9E8DFC089E;
	Fri, 20 Mar 2020 15:35:25 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F3FC9C07FF
 for <iommu@lists.linux-foundation.org>; Fri, 20 Mar 2020 15:35:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E377D87402
 for <iommu@lists.linux-foundation.org>; Fri, 20 Mar 2020 15:35:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BqToiIzl9pII for <iommu@lists.linux-foundation.org>;
 Fri, 20 Mar 2020 15:35:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 8324C873EC
 for <iommu@lists.linux-foundation.org>; Fri, 20 Mar 2020 15:35:24 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 112912070A;
 Fri, 20 Mar 2020 15:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1584718524;
 bh=PCMtCPWpgRJ4SJUtOrkrxxNkDVKdaN+ir2Ppk0Q6Dig=;
 h=Date:From:To:Cc:Subject:From;
 b=ZnbSRZUXjKZ/oVvf1zRUFVbw8Ehqux0gkX2zaKJ6khisHbkvmeQKxrZSGQOlzDSSI
 YcTff5BxuARj7/zu5Ezmam39siZsUv9vyI1A6SWob82GkM101PbnTp2/xzyW7N1e+7
 mSG/91kWrfvQPMlbptIWr8sBmadoiDDVb4f+SWkg=
Date: Fri, 20 Mar 2020 15:35:20 +0000
From: Will Deacon <will@kernel.org>
To: joro@8bytes.org
Subject: [GIT PULL] iommu/arm-smmu: Updates for 5.7
Message-ID: <20200320153519.GB6815@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: jean-philippe@linaro.org, robin.murphy@arm.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 kernel-team@android.com, linux-arm-kernel@lists.infradead.org
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

Please pull these Arm SMMU updates for 5.7. The summary is in the tag (which
you may need to re-fetch if you've got my tree added as a remote).

Cheers,

Will

--->8

The following changes since commit f8788d86ab28f61f7b46eb6be375f8a726783636:

  Linux 5.6-rc3 (2020-02-23 16:17:42 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-updates

for you to fetch changes up to 6a481a95d4c198a2dd0a61f8877b92a375757db8:

  iommu/arm-smmu-v3: Add SMMUv3.2 range invalidation support (2020-03-18 21:37:10 +0000)

----------------------------------------------------------------
Arm SMMU updates for 5.7

- Support for the TLB range invalidation command in SMMUv3.2

- Introduction of command batching helpers...

- ... which are then used to batch up CD and ATC invalidation

- Support for PCI PASID, along with necessary PCI symbol exports

- MAINTAINERS update to include DT binding docs

----------------------------------------------------------------
Jean-Philippe Brucker (5):
      PCI/ATS: Export symbols of PASID functions
      iommu/arm-smmu-v3: Add support for PCI PASID
      iommu/arm-smmu-v3: Write level-1 descriptors atomically
      iommu/arm-smmu-v3: Add command queue batching helpers
      iommu/arm-smmu-v3: Batch context descriptor invalidation

Rob Herring (2):
      iommu/arm-smmu-v3: Batch ATC invalidation commands
      iommu/arm-smmu-v3: Add SMMUv3.2 range invalidation support

Robin Murphy (1):
      MAINTAINERS: Cover Arm SMMU DT bindings

 MAINTAINERS                 |   1 +
 drivers/iommu/arm-smmu-v3.c | 204 ++++++++++++++++++++++++++++++++++++++------
 drivers/pci/ats.c           |   4 +
 3 files changed, 181 insertions(+), 28 deletions(-)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
