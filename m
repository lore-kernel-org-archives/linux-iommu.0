Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2A99C433EF
	for <iommu@archiver.kernel.org>; Mon, 14 Feb 2022 14:14:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 64A1860EE5;
	Mon, 14 Feb 2022 14:14:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R1ImYBMheNjW; Mon, 14 Feb 2022 14:14:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3FA8C60AFE;
	Mon, 14 Feb 2022 14:14:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 069D5C0011;
	Mon, 14 Feb 2022 14:14:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CFC07C000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 14:14:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AF08F813C6
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 14:14:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4cClIqJ-3V5W for <iommu@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 14:14:41 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E6E43813C2
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 14:14:40 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id E6060374; Mon, 14 Feb 2022 15:14:37 +0100 (CET)
Date: Mon, 14 Feb 2022 15:14:36 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v3 00/10] iommu cleanup and refactoring
Message-ID: <YgpjzNtQlOdq+1AB@8bytes.org>
References: <20220214015538.2828933-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220214015538.2828933-1-baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 David Airlie <airlied@linux.ie>, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux-foundation.org, Jonathan Hunter <jonathanh@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Thierry Reding <thierry.reding@gmail.com>, Ben Skeggs <bskeggs@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Daniel Vetter <daniel@ffwll.ch>,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>
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

On Mon, Feb 14, 2022 at 09:55:28AM +0800, Lu Baolu wrote:
> v3:
>  - Remove ops check when dev_iommu_ops() is used.
>  - This version of series is available on github:
>    https://github.com/LuBaolu/intel-iommu/commits/iommu-domain-ops-v3
> 
> Lu Baolu (10):
>   iommu/vt-d: Remove guest pasid related callbacks
>   iommu: Remove guest pasid related interfaces and definitions
>   iommu/vt-d: Remove aux-domain related callbacks
>   iommu: Remove aux-domain related interfaces and iommu_ops
>   iommu: Remove apply_resv_region
>   drm/nouveau/device: Get right pgsize_bitmap of iommu_domain
>   iommu: Use right way to retrieve iommu_ops
>   iommu: Remove unused argument in is_attach_deferred
>   iommu: Use dev_iommu_ops() helper
>   iommu: Split struct iommu_ops

Really cool, thanks for doing this, Baolu! I am currently running some
tests on this series to make sure there are no build breakages. And I
agree with Jason that:

	iommu: Use right way to retrieve iommu_ops and
	iommu: Use dev_iommu_ops() helper

can be combined into one patch. Splitting iommu_ops was something I have
been thinking about for some time, so thanks again for doing this.

Regards,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
