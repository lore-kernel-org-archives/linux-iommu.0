Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5390C433F5
	for <iommu@archiver.kernel.org>; Thu, 10 Feb 2022 00:49:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6C6FB8248F;
	Thu, 10 Feb 2022 00:49:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 71-uF70cSIQE; Thu, 10 Feb 2022 00:49:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 69D3481CE7;
	Thu, 10 Feb 2022 00:49:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2207DC001A;
	Thu, 10 Feb 2022 00:49:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6366FC000B
 for <iommu@lists.linux-foundation.org>; Thu, 10 Feb 2022 00:49:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 437D18248F
 for <iommu@lists.linux-foundation.org>; Thu, 10 Feb 2022 00:49:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3_bsBxdzfAhR for <iommu@lists.linux-foundation.org>;
 Thu, 10 Feb 2022 00:49:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8341E81CE7
 for <iommu@lists.linux-foundation.org>; Thu, 10 Feb 2022 00:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644454179; x=1675990179;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=ei+VnaHpgHPJ+c/nKei5uKtauvdLXQwFHwki6nRTPGM=;
 b=dksvRIC/gbcaJxWL/4eLzA8iEmueLMhczNxlXQtu2aHfrHE8eIpl1je9
 VRukkbQNi7ZRNtsE0gF0P7HiowJVFTwiNgNLPtelROzx0YZATWWe7MxOP
 zUx3ZLuvW4DMzZgh94sL8paH0AC4MhsYyGt0LuCz+LGP4OxvhW54sgNj+
 KVixQaFIeBGkeum+P+x5tYO0tKsaadrH31bF2xKv1nE3Og5P65SS7zd8N
 sLeAVzgcXawU/IjZMA0S2cF2+CRc4cJ75ZGj6BXo+neZ6C2wlrLqrupA5
 yBXAkP58wgjNeBi5w42nNR0GOde9WGHpTJfjImu8qp14MmgMfzRPwezDh w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="310117371"
X-IronPort-AV: E=Sophos;i="5.88,357,1635231600"; d="scan'208";a="310117371"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2022 16:49:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,357,1635231600"; d="scan'208";a="678967443"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 09 Feb 2022 16:49:34 -0800
Message-ID: <b8ccaf6f-e374-ecd8-ee86-5f415a33a4a9@linux.intel.com>
Date: Thu, 10 Feb 2022 08:48:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 06/10] drm/nouveau/device: Get right pgsize_bitmap of
 iommu_domain
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20220208012559.1121729-1-baolu.lu@linux.intel.com>
 <20220208012559.1121729-7-baolu.lu@linux.intel.com>
 <20220209133139.GX4160@nvidia.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20220209133139.GX4160@nvidia.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 David Airlie <airlied@linux.ie>, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux-foundation.org, Jacob jun Pan <jacob.jun.pan@intel.com>,
 Christoph Hellwig <hch@infradead.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Thierry Reding <thierry.reding@gmail.com>, Ben Skeggs <bskeggs@redhat.com>,
 Daniel Vetter <daniel@ffwll.ch>, Jonathan Hunter <jonathanh@nvidia.com>,
 Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-kernel@vger.kernel.org
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

On 2/9/22 9:31 PM, Jason Gunthorpe wrote:
> On Tue, Feb 08, 2022 at 09:25:55AM +0800, Lu Baolu wrote:
>> The supported page sizes of an iommu_domain are saved in the pgsize_bitmap
>> field. Retrieve the value from the right place.
>>
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>> Reviewed-by: Robin Murphy<robin.murphy@arm.com>
>> Link:https://lore.kernel.org/r/20211218074546.1772553-1-baolu.lu@linux.intel.com
>> Reviewed-by: Christoph Hellwig<hch@lst.de>
>> ---
>>   drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> IMHO it is weird that the ops have a pgsize_bitmap at all.

Agreed. Christoph doesn't like it either. The domain->pgsize_bitmap
should be initialized during domain_alloc(). We plan to make this happen
in or after domain_alloc() refactoring.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
