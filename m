Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1962C433EF
	for <iommu@archiver.kernel.org>; Mon, 14 Feb 2022 02:01:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 951CD40463;
	Mon, 14 Feb 2022 02:01:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Prfad94ql9eB; Mon, 14 Feb 2022 02:01:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 27AF7400D3;
	Mon, 14 Feb 2022 02:01:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DAE2FC0011;
	Mon, 14 Feb 2022 02:01:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE0B8C000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 02:01:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A122A4012A
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 02:01:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cu6cd3MOsNRy for <iommu@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 02:01:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9C58C400D3
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 02:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644804092; x=1676340092;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=uM4eaPEur3eeStm8M6r17HYW2FgzI1a510pLlxYCStU=;
 b=M5vo+x9aEEC4DaICcR9BAwZ/Yn0M7LGVFbn1eYzw5wwXHckLWbU+P635
 vupeylM3wUXhxWnkoN7jrse6FtWaXyXd9uf2ltMAFjn6Foj2dIG8R5jDh
 W9wzE2DT3uCcPq3JLdHE477KvXkC2iPYTehyOhGiIEtqcd2NVOYdvVQhZ
 pCsZgCIfHVyJh3XGljquGPgaaGYXNNyAThC9Wl1XnG5/TOJQE9YurZLUK
 kkdKbyEUkTAFAYyl1tZ0u3h3xR368FTcET4/MgoiBwtVrml1tcO+1dNR6
 rS/jggki0/d62x8QGvd0pUUkqjL6l3WR/eWxbC0szcPY5baQFVN15wPw7 w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="250198695"
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; d="scan'208";a="250198695"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2022 18:01:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; d="scan'208";a="680139430"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 13 Feb 2022 18:01:27 -0800
Message-ID: <e56ac8fd-151e-fb51-f2ee-7b4cc8b69c5c@linux.intel.com>
Date: Mon, 14 Feb 2022 10:00:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 00/10] iommu cleanup and refactoring
Content-Language: en-US
To: Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Ben Skeggs <bskeggs@redhat.com>,
 Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
References: <20220208012559.1121729-1-baolu.lu@linux.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20220208012559.1121729-1-baolu.lu@linux.intel.com>
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Jonathan Hunter <jonathanh@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Daniel Vetter <daniel@ffwll.ch>
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

On 2/8/22 9:25 AM, Lu Baolu wrote:
> Hi,
> 
> The guest pasid and aux-domain related code are dead code in current
> iommu subtree. As we have reached a consensus that all these features
> should be based on the new iommufd framework (which is under active
> development), the first part of this series removes and cleanups all
> the dead code.
> 
> The second part of this series refactors the iommu_domain by moving all
> domain specific ops from iommu_ops to a new iommu_domain_ops. This makes
> iommu_domain self-contained and represent the abstraction of an I/O
> translation table in the IOMMU subsystem. With different type of
> iommu_domain providing different set of ops, it's easier to support more
> types of I/O translation tables.
> 
> Please help to review and comment.
> 
> Best regards,
> baolu
> 
> Change log:
> v1: https://lore.kernel.org/linux-iommu/20220124071103.2097118-1-baolu.lu@linux.intel.com/
> 
> v2:
>   - Remove apply_resv_region callback.
>   - Remove domain argument from is_attach_deferred callback.
>   - Convert all feasible instances of dev->bus->iommu_ops to dev_iommu_ops().
>   - Add the default_domain_ops (default iommu_domain_ops) in iommu_ops to
>     avoid big churn in dozens of iommu drivers.
>   - We discussed removing pgsize_bitmap in struct iommu_ops and
>     initialize the domain field in domain_alloc(). Considering that
>     domain_alloc() is being refactored, let's wait until the new domain_alloc()
>     comes.
>   - Various code/description refinement.
>   - This version of series is available on github:
>     https://github.com/LuBaolu/intel-iommu/commits/iommu-domain-ops-v2
> 
> Lu Baolu (10):
>    iommu/vt-d: Remove guest pasid related callbacks
>    iommu: Remove guest pasid related interfaces and definitions
>    iommu/vt-d: Remove aux-domain related callbacks
>    iommu: Remove aux-domain related interfaces and iommu_ops
>    iommu: Remove apply_resv_region
>    drm/nouveau/device: Get right pgsize_bitmap of iommu_domain
>    iommu: Use right way to retrieve iommu_ops
>    iommu: Remove unused argument in is_attach_deferred
>    iommu: Use dev_iommu_ops() helper
>    iommu: Split struct iommu_ops
> 
>   include/linux/intel-iommu.h                   |  27 -
>   include/linux/intel-svm.h                     |  12 -
>   include/linux/iommu.h                         | 184 +++---
>   drivers/iommu/amd/amd_iommu.h                 |   3 +-
>   drivers/iommu/intel/pasid.h                   |   4 -
>   include/uapi/linux/iommu.h                    | 181 ------
>   .../drm/nouveau/nvkm/engine/device/tegra.c    |   2 +-
>   drivers/iommu/amd/iommu.c                     |  23 +-
>   drivers/iommu/amd/iommu_v2.c                  |   2 +-
>   drivers/iommu/apple-dart.c                    |  20 +-
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  18 +-
>   drivers/iommu/arm/arm-smmu/arm-smmu.c         |  20 +-
>   drivers/iommu/arm/arm-smmu/qcom_iommu.c       |  18 +-
>   drivers/iommu/exynos-iommu.c                  |  14 +-
>   drivers/iommu/fsl_pamu_domain.c               |  10 +-
>   drivers/iommu/intel/debugfs.c                 |   3 +-
>   drivers/iommu/intel/iommu.c                   | 540 +-----------------
>   drivers/iommu/intel/pasid.c                   | 161 ------
>   drivers/iommu/intel/svm.c                     | 209 -------
>   drivers/iommu/iommu.c                         | 326 ++---------
>   drivers/iommu/ipmmu-vmsa.c                    |  18 +-
>   drivers/iommu/msm_iommu.c                     |  30 +-
>   drivers/iommu/mtk_iommu.c                     |  20 +-
>   drivers/iommu/mtk_iommu_v1.c                  |  14 +-
>   drivers/iommu/omap-iommu.c                    |  14 +-
>   drivers/iommu/rockchip-iommu.c                |  14 +-
>   drivers/iommu/s390-iommu.c                    |  14 +-
>   drivers/iommu/sprd-iommu.c                    |  18 +-
>   drivers/iommu/sun50i-iommu.c                  |  18 +-
>   drivers/iommu/tegra-gart.c                    |  18 +-
>   drivers/iommu/tegra-smmu.c                    |  14 +-
>   drivers/iommu/virtio-iommu.c                  |  14 +-
>   32 files changed, 303 insertions(+), 1680 deletions(-)
> 

Thank you very much for the comments. A new version of this series has
been posted here.

https://lore.kernel.org/linux-iommu/20220214015538.2828933-1-baolu.lu@linux.intel.com/

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
