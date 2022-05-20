Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3D21C433EF
	for <iommu@archiver.kernel.org>; Fri, 20 May 2022 11:03:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5CF9842591;
	Fri, 20 May 2022 11:03:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hL7sHxk6Gt-3; Fri, 20 May 2022 11:03:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 101244259D;
	Fri, 20 May 2022 11:03:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D3D59C0032;
	Fri, 20 May 2022 11:03:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5E626C002D
 for <iommu@lists.linux-foundation.org>; Fri, 20 May 2022 11:03:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3A05084689
 for <iommu@lists.linux-foundation.org>; Fri, 20 May 2022 11:03:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id l8jGedSRlUXB for <iommu@lists.linux-foundation.org>;
 Fri, 20 May 2022 11:03:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7BCFE8468B
 for <iommu@lists.linux-foundation.org>; Fri, 20 May 2022 11:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1653044588; x=1684580588;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=64uK/wIWiSqexpwgngQnIl6DO+Ru93LCQrKFKwJZoRk=;
 b=KfAhV/ZrgZDAepWxRu41zxNeMcsjIA80VnbBjm96VSh+17JBVnKcv38q
 7Vy2AKhfGIjc1SPPWiYac1Ay47tt+UosNnc7zJTeDYhjieKHSj6cHN/az
 4pU7QG7JU2QKuk6hdb29fsAumNHp6aMApg9lQkEqNWUZ0YDIxboTvMyM4
 Tw08WZkY9ctx+9h98Dqj14kQe5WGNLQ9H37BMSaVYb4paSCxLogoPgHPT
 0ueWSjMiR1ZfmfalU8HFiZoSKXEynQsCboTg1uSGMqYSxVC4ZdKwh1QBs
 8ywTS6cfrImYHCLbO6gttN5wzPDsmNbbCy86rNuLLERNnYSi9TzKib55K w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="272700689"
X-IronPort-AV: E=Sophos;i="5.91,239,1647327600"; d="scan'208";a="272700689"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2022 04:03:07 -0700
X-IronPort-AV: E=Sophos;i="5.91,239,1647327600"; d="scan'208";a="599166968"
Received: from wangyu5-mobl.ccr.corp.intel.com (HELO [10.249.172.121])
 ([10.249.172.121])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2022 04:03:04 -0700
Message-ID: <9e786a91-6239-1fa5-cad9-f319794b6055@linux.intel.com>
Date: Fri, 20 May 2022 19:03:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/5] iommu: Add blocking_domain_ops field in iommu_ops
Content-Language: en-US
To: Joerg Roedel <joro@8bytes.org>
References: <20220516015759.2952771-1-baolu.lu@linux.intel.com>
 <20220516015759.2952771-3-baolu.lu@linux.intel.com>
 <YodVJ7ervpIdWfg+@8bytes.org>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <YodVJ7ervpIdWfg+@8bytes.org>
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 iommu@lists.linux-foundation.org, Jacob jun Pan <jacob.jun.pan@intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Will Deacon <will@kernel.org>
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

On 2022/5/20 16:45, Joerg Roedel wrote:
> On Mon, May 16, 2022 at 09:57:56AM +0800, Lu Baolu wrote:
>>   	const struct iommu_domain_ops *default_domain_ops;
>> +	const struct iommu_domain_ops *blocking_domain_ops;
> 
> I don't understand why extra domain-ops are needed for this. I think it
> would be more straight-forward to implement allocation of
> IOMMU_DOMAIN_BLOCKED domains in each driver and let the details be
> handled in the set_dev() call-back. The IOMMU driver can make sure DMA
> is blocked for a device when it encounters a IOMMU_DOMAIN_BLOCKED
> domain.
> 
> For IOMMUs that have no explicit way to block DMA could just use an
> unmanaged domain with an empty page-table.

Yes, this is what will go.

Best regards,
baolu

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
