Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24987C433F5
	for <iommu@archiver.kernel.org>; Tue, 15 Feb 2022 02:10:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BD55240523;
	Tue, 15 Feb 2022 02:10:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jg81L9YRh_Yb; Tue, 15 Feb 2022 02:10:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7735B40412;
	Tue, 15 Feb 2022 02:10:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4457AC0011;
	Tue, 15 Feb 2022 02:10:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 05EDEC000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Feb 2022 02:10:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D076F8141E
 for <iommu@lists.linux-foundation.org>; Tue, 15 Feb 2022 02:10:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sc0kV-iFBYjZ for <iommu@lists.linux-foundation.org>;
 Tue, 15 Feb 2022 02:10:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 296E2813F5
 for <iommu@lists.linux-foundation.org>; Tue, 15 Feb 2022 02:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644891009; x=1676427009;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=KarI2KGIBoMIjz9i6cuv3KYdqwF8kbc+NTQdpXJE3+M=;
 b=FsNlWmjhyOZDi489WZsUe3KBGfldmrfMgr77atLkI7gpSRsxl8D0a7FK
 1UCkHJPwl98H/LYi6GO7zFUMWdYT4df42sws1JxyCEzJM+MJXk4IJSdXI
 5+Kvxw+OINR2yyU74HAsZjuvv8wh64LtbxArJjzQNyn6n2amx7dvPU2EU
 jNE0/2qEftIV6GVq73yBav1p92fAvujwZ2Uyw49634VBdkuCQ7o7iw0rO
 IqO0K7uWASzshFfT7DAYJeWEDTypFC6hdbPv9D7vlClmjn06jqJxOQ+87
 6gA09mnmwfZF5tsJNPikQe8DUeEeBvvCeFU5Zpx2dN4z4TrmaH614scKL w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="230866984"
X-IronPort-AV: E=Sophos;i="5.88,369,1635231600"; d="scan'208";a="230866984"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Feb 2022 18:10:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,369,1635231600"; d="scan'208";a="680795973"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 14 Feb 2022 18:10:04 -0800
Message-ID: <a663613f-c417-715b-7071-1a992adb8c68@linux.intel.com>
Date: Tue, 15 Feb 2022 10:08:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 06/10] drm/nouveau/device: Get right pgsize_bitmap of
 iommu_domain
Content-Language: en-US
To: Joerg Roedel <joro@8bytes.org>
References: <20220214015538.2828933-1-baolu.lu@linux.intel.com>
 <20220214015538.2828933-7-baolu.lu@linux.intel.com>
 <YgpQjJPZnnOJUepv@8bytes.org>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <YgpQjJPZnnOJUepv@8bytes.org>
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 David Airlie <airlied@linux.ie>, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux-foundation.org, Jacob jun Pan <jacob.jun.pan@intel.com>,
 Christoph Hellwig <hch@infradead.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Thierry Reding <thierry.reding@gmail.com>, Ben Skeggs <bskeggs@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Daniel Vetter <daniel@ffwll.ch>,
 Jonathan Hunter <jonathanh@nvidia.com>, Will Deacon <will@kernel.org>,
 Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
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

On 2/14/22 8:52 PM, Joerg Roedel wrote:
> On Mon, Feb 14, 2022 at 09:55:34AM +0800, Lu Baolu wrote:
>> The supported page sizes of an iommu_domain are saved in the pgsize_bitmap
>> field. Retrieve the value from the right place.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
>> Link: https://lore.kernel.org/r/20211218074546.1772553-1-baolu.lu@linux.intel.com
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> Acked-by: Joerg Roedel <jroedel@suse.de>
> 
> I guess this is picked up by the DRM maintainers?
> 

I would like this patch to go through the iommu tree. This series could
not be compiled without this change.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
