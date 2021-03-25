Return-Path: <SRS0=Fh/M=IX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D71C3C433DB
	for <iommu@archiver.kernel.org>; Thu, 25 Mar 2021 17:12:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8999561A1E
	for <iommu@archiver.kernel.org>; Thu, 25 Mar 2021 17:12:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8999561A1E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2C2766076D;
	Thu, 25 Mar 2021 17:12:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lyCOL8EmYBVq; Thu, 25 Mar 2021 17:12:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 157476075D;
	Thu, 25 Mar 2021 17:12:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E242FC000D;
	Thu, 25 Mar 2021 17:12:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C8AB1C000A
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 17:12:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BD084401DD
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 17:12:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k-GqvFLgDwWe for <iommu@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 17:12:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 365E4401DA
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 17:12:31 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id BC1C861A16;
 Thu, 25 Mar 2021 17:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616692350;
 bh=aqaTJDnsiWJX1tcMgPNk2oK/dylyp4jFTDSiVv4TkL8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=e8s9UlmvUgL8hsE8u0OJZZIEfxRCZpwfagHYQPLEy+4E05INhNQxkc1j33kXKp3uk
 lDpWZ1TrzmwVcY+dfTqNjGmIeCyZfrzJGz1YZJcrge7sFegetsVF5tOpT8aG3zuhxU
 tyVcYA2PF9EdUkkHX5q2lwcnZNOzG6XXUJXwqCe15f12Q3HdxF94CEjj9PX0SHSB0C
 JZFe+yI/rogzFYBc9vmVKw2xibZGvpwF528+cuz9+/tCBM8cAvuaasRH7fVz3pg8FE
 v6FrCi+2yOkTT/pG1GoZ6glBMJy9grkgV7jOTbwLtTNh+lF0jx8vIWjs2yBr6ZU3ll
 5tDMPRoFL+fdg==
Date: Thu, 25 Mar 2021 17:12:26 +0000
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 2/2] iommu: Streamline registration interface
Message-ID: <20210325171226.GB15337@willie-the-truck>
References: <f4de29d8330981301c1935e667b507254a2691ae.1616157612.git.robin.murphy@arm.com>
 <95f69c593aa9dd57a5333e490dc06b8bae27fedf.1616157612.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <95f69c593aa9dd57a5333e490dc06b8bae27fedf.1616157612.git.robin.murphy@arm.com>
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

On Fri, Mar 19, 2021 at 12:52:02PM +0000, Robin Murphy wrote:
> Rather than have separate opaque setter functions that are easy to
> overlook and lead to repetitive boilerplate in drivers, let's pass the
> relevant initialisation parameters directly to iommu_device_register().
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/amd/init.c                    |  3 +--
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  5 +---
>  drivers/iommu/arm/arm-smmu/arm-smmu.c       |  5 +---
>  drivers/iommu/arm/arm-smmu/qcom_iommu.c     |  5 +---
>  drivers/iommu/exynos-iommu.c                |  5 +---
>  drivers/iommu/fsl_pamu_domain.c             |  4 +--
>  drivers/iommu/intel/dmar.c                  |  4 +--
>  drivers/iommu/intel/iommu.c                 |  3 +--
>  drivers/iommu/iommu.c                       |  7 ++++-
>  drivers/iommu/ipmmu-vmsa.c                  |  6 +----
>  drivers/iommu/msm_iommu.c                   |  5 +---
>  drivers/iommu/mtk_iommu.c                   |  5 +---
>  drivers/iommu/mtk_iommu_v1.c                |  4 +--
>  drivers/iommu/omap-iommu.c                  |  5 +---
>  drivers/iommu/rockchip-iommu.c              |  5 +---
>  drivers/iommu/s390-iommu.c                  |  4 +--
>  drivers/iommu/sprd-iommu.c                  |  5 +---
>  drivers/iommu/sun50i-iommu.c                |  5 +---
>  drivers/iommu/tegra-gart.c                  |  5 +---
>  drivers/iommu/tegra-smmu.c                  |  5 +---
>  drivers/iommu/virtio-iommu.c                |  5 +---
>  include/linux/iommu.h                       | 29 ++++-----------------
>  22 files changed, 31 insertions(+), 98 deletions(-)

I was worried this might blow up with !CONFIG_IOMMU_API, but actually
it all looks fine and is much cleaner imo so:

Acked-by: Will Deacon <will@kernel.org>

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
