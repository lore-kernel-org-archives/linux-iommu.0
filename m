Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B07CC433F5
	for <iommu@archiver.kernel.org>; Thu, 28 Apr 2022 14:16:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 17AC58145A;
	Thu, 28 Apr 2022 14:16:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id elgH4XXlKolQ; Thu, 28 Apr 2022 14:16:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D5F0681442;
	Thu, 28 Apr 2022 14:16:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A5BD8C0032;
	Thu, 28 Apr 2022 14:16:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0B5BDC002D
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 14:16:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DDFF340298
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 14:16:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u2gyWL3hhpTR for <iommu@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 14:16:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id BDFF140155
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 14:16:42 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7985D1474;
 Thu, 28 Apr 2022 07:16:41 -0700 (PDT)
Received: from [10.57.80.98] (unknown [10.57.80.98])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 413FA3F5A1;
 Thu, 28 Apr 2022 07:16:39 -0700 (PDT)
Message-ID: <77195ec7-89e0-c208-f021-70a958347657@arm.com>
Date: Thu, 28 Apr 2022 15:16:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 00/14] iommu: Retire bus_set_iommu()
Content-Language: en-GB
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org, will@kernel.org
References: <cover.1650890638.git.robin.murphy@arm.com>
In-Reply-To: <cover.1650890638.git.robin.murphy@arm.com>
Cc: jean-philippe@linaro.org, zhang.lyra@gmail.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 thierry.reding@gmail.com, gerald.schaefer@linux.ibm.com,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2022-04-28 14:18, Robin Murphy wrote:
> v1: https://lore.kernel.org/linux-iommu/cover.1649935679.git.robin.murphy@arm.com/
> 
> Hi all,
> 
> Just some minor updates for v2, adding a workaround to avoid changing
> VT-d behaviour for now, cleaning up the extra include I missed in
> virtio-iommu, and collecting all the acks so far.

Oh, and I added the proper error handling for bus_iommu_probe() since it 
turned out to be trivial, and applied Krishna's R-b to the wrong patch 
because of course what was patch #2 is now actually patch #3 :(

Apologies, juggling one too many things at the moment...

Robin.

> As before, this is
> based on the AMD IOMMU patch now applied, plus v2 of my
> device_iommu_capable() series here:
> 
> https://lore.kernel.org/linux-iommu/cover.1650878781.git.robin.murphy@arm.com/
> 
> Cheers,
> Robin.
> 
> 
> 
> Robin Murphy (14):
>    iommu/vt-d: Temporarily reject probing non-PCI devices
>    iommu: Always register bus notifiers
>    iommu: Move bus setup to IOMMU device registration
>    iommu/amd: Clean up bus_set_iommu()
>    iommu/arm-smmu: Clean up bus_set_iommu()
>    iommu/arm-smmu-v3: Clean up bus_set_iommu()
>    iommu/dart: Clean up bus_set_iommu()
>    iommu/exynos: Clean up bus_set_iommu()
>    iommu/ipmmu-vmsa: Clean up bus_set_iommu()
>    iommu/mtk: Clean up bus_set_iommu()
>    iommu/omap: Clean up bus_set_iommu()
>    iommu/tegra-smmu: Clean up bus_set_iommu()
>    iommu/virtio: Clean up bus_set_iommu()
>    iommu: Clean up bus_set_iommu()
> 
>   drivers/iommu/amd/amd_iommu.h               |   1 -
>   drivers/iommu/amd/init.c                    |   9 +-
>   drivers/iommu/amd/iommu.c                   |  21 ----
>   drivers/iommu/apple-dart.c                  |  30 +-----
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  53 +---------
>   drivers/iommu/arm/arm-smmu/arm-smmu.c       |  84 +--------------
>   drivers/iommu/arm/arm-smmu/qcom_iommu.c     |   4 -
>   drivers/iommu/exynos-iommu.c                |   9 --
>   drivers/iommu/fsl_pamu_domain.c             |   4 -
>   drivers/iommu/intel/iommu.c                 |   5 +-
>   drivers/iommu/iommu.c                       | 110 +++++++++-----------
>   drivers/iommu/ipmmu-vmsa.c                  |  35 +------
>   drivers/iommu/msm_iommu.c                   |   2 -
>   drivers/iommu/mtk_iommu.c                   |  13 +--
>   drivers/iommu/mtk_iommu_v1.c                |  13 +--
>   drivers/iommu/omap-iommu.c                  |   6 --
>   drivers/iommu/rockchip-iommu.c              |   2 -
>   drivers/iommu/s390-iommu.c                  |   6 --
>   drivers/iommu/sprd-iommu.c                  |   5 -
>   drivers/iommu/sun50i-iommu.c                |   2 -
>   drivers/iommu/tegra-smmu.c                  |  29 ++----
>   drivers/iommu/virtio-iommu.c                |  25 -----
>   include/linux/iommu.h                       |   1 -
>   23 files changed, 67 insertions(+), 402 deletions(-)
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
