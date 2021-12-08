Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A7D3C433F5
	for <iommu@archiver.kernel.org>; Wed,  8 Dec 2021 04:56:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CA5D440965;
	Wed,  8 Dec 2021 04:56:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ujeNMS_sr9pd; Wed,  8 Dec 2021 04:56:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 78695400C7;
	Wed,  8 Dec 2021 04:56:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5B448C002F;
	Wed,  8 Dec 2021 04:56:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E403CC0012
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 04:56:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D95E760EFE
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 04:56:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iE-VLu4xZ3Ur for <iommu@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 04:56:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EF53460EFC
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 04:56:28 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 712EBB81F70;
 Wed,  8 Dec 2021 04:56:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E346C341C3;
 Wed,  8 Dec 2021 04:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1638939386;
 bh=C9Fxg4lH/TpRohy6FBCFxRHJq6QxdHRXmdORxmA2LQg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=sqcCBB0TqyOBe1PKMXTJnGrJfgXFaWGreXTj4jacVfPnKGUQdsx2+nFCt6aL8AWCe
 gtaOqSRy8mIQSsB9Z1Uv6Jn0CtQ0xxwjqe9Ti1AqmdRSAJ2wmhcEdA5Oqc8wbp80tz
 zwRSIObMdfzqEZARgmGqbIaLCXu+YC30LG2braUKc+iaNTCQAdAGQ0n0COlSAwPH7W
 LNtk2YVvMJTRCDCVfBPMAHA1KG5uRv0WP3xJ06LgzZSpPQdm8cdmIxvLsj1ooSWMqU
 JY2qXKWq26CuKIsAcA3w9CH9PFTdFkD+uScKtG7iAGiebvHqBxMUoVX7QHjcBVE/Pe
 gXTHxbjRH/83g==
Date: Wed, 8 Dec 2021 10:26:22 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH 4/4] dmaengine: idxd: Use DMA API for in-kernel DMA with
 PASID
Message-ID: <YbA69kdTgqB9tJc8@matsya>
References: <1638884834-83028-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1638884834-83028-5-git-send-email-jacob.jun.pan@linux.intel.com>
 <dbb90f20-d9fb-1f24-b59d-15a2a42437e2@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <dbb90f20-d9fb-1f24-b59d-15a2a42437e2@intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Kumar,
 Sanjay K" <sanjay.k.kumar@intel.com>, LKML <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org,
 Tony Luck <tony.luck@intel.com>, Jacob Pan <jacob.jun.pan@intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Barry Song <21cnbao@gmail.com>,
 "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>, "Zanussi,
 Tom" <tom.zanussi@intel.com>
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

On 07-12-21, 16:27, Dave Jiang wrote:
> 
> On 12/7/2021 6:47 AM, Jacob Pan wrote:
> > In-kernel DMA should be managed by DMA mapping API. The existing kernel
> > PASID support is based on the SVA machinery in SVA lib that is intended
> > for user process SVA. The binding between a kernel PASID and kernel
> > mapping has many flaws. See discussions in the link below.
> > 
> > This patch utilizes iommu_enable_pasid_dma() to enable DSA to perform DMA
> > requests with PASID under the same mapping managed by DMA mapping API.
> > In addition, SVA-related bits for kernel DMA are removed. As a result,
> > DSA users shall use DMA mapping API to obtain DMA handles instead of
> > using kernel virtual addresses.
> > 
> > Link: https://lore.kernel.org/linux-iommu/20210511194726.GP1002214@nvidia.com/
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> 
> Acked-by: Dave Jiang <dave.jiang@intel.com>
> 
> Also cc Vinod and dmaengine@vger

Pls resend collecting acks. I dont have this in my queue

-- 
~Vinod
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
