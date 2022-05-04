Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4949AC433F5
	for <iommu@archiver.kernel.org>; Wed,  4 May 2022 08:49:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E4EDB8340C;
	Wed,  4 May 2022 08:49:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z_9HbQVAP_nI; Wed,  4 May 2022 08:49:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CD1AA83478;
	Wed,  4 May 2022 08:49:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A3BE4C0039;
	Wed,  4 May 2022 08:49:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5EFA4C0032
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 08:49:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4CCA84049F
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 08:49:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bxAoFm2J15LN for <iommu@lists.linux-foundation.org>;
 Wed,  4 May 2022 08:49:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BBBBA40004
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 08:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651654163; x=1683190163;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=V5tYr+zZNvwfwnQpbzyvburfLeDVmqCwlAN1Bm8YOJs=;
 b=WzLw67hrLE8TD8SwcUjy2ROYR2lCKgLSGoWk7K7GT/LcqgnWnZBm9VLZ
 vpOBqi9eFwWHdIEQLCqkGqQiJQtFqf9j1pSqcxMvdlORdqvH8Rb+dNElA
 jaUR96AZa8OAiK1YS3m4Jk/KTmQyedweNre0F1A3YxTvLtF+3wLVxjzNF
 E7ew0xcHtgVxtKDS/rprF2STfYmcjMliJZGLLZbDv551uYowtPPRetxM8
 ikzm9yZeUxe+j6c4hbpVZrWvTd2kxtt3KEVZmWXWBI4jy8VW61b4auXK+
 9I7l0RCmKq5fX0wybtEIMLrAMTNhwhVNI8FrQMRjH0FZULAHdGGgGs+Vw A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="247614133"
X-IronPort-AV: E=Sophos;i="5.91,197,1647327600"; d="scan'208";a="247614133"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 May 2022 01:49:23 -0700
X-IronPort-AV: E=Sophos;i="5.91,197,1647327600"; d="scan'208";a="734304485"
Received: from yanc1-mobl.ccr.corp.intel.com (HELO [10.255.30.223])
 ([10.255.30.223])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 May 2022 01:49:20 -0700
Message-ID: <aef3b3ed-a7a4-5e6a-c16d-0ee57d01e124@linux.intel.com>
Date: Wed, 4 May 2022 16:49:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 5/5] iommu/vt-d: Remove hard coding PGSNP bit in PASID
 entries
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20220501112434.874236-1-baolu.lu@linux.intel.com>
 <20220501112434.874236-6-baolu.lu@linux.intel.com>
 <20220502131959.GL8364@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220502131959.GL8364@nvidia.com>
Cc: Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2022/5/2 21:19, Jason Gunthorpe wrote:
> On Sun, May 01, 2022 at 07:24:34PM +0800, Lu Baolu wrote:
>> As enforce_cache_coherency has been introduced into the iommu_domain_ops,
>> the kernel component which owns the iommu domain is able to opt-in its
>> requirement for force snooping support. The iommu driver has no need to
>> hard code the page snoop control bit in the PASID table entries anymore.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel/pasid.h | 1 -
>>   drivers/iommu/intel/iommu.c | 3 ---
>>   drivers/iommu/intel/pasid.c | 6 ------
>>   3 files changed, 10 deletions(-)
> 
> It seems fine, but as in the other email where do we do
> pasid_set_pgsnp() for a new device attach on an already no-snopp domain?

Yes. I will take care of this in the next version.

> Jason

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
