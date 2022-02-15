Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A2FAC433EF
	for <iommu@archiver.kernel.org>; Tue, 15 Feb 2022 01:40:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A510340523;
	Tue, 15 Feb 2022 01:40:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FGu1UPzBRZEZ; Tue, 15 Feb 2022 01:40:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 441CB4036E;
	Tue, 15 Feb 2022 01:40:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1691AC001A;
	Tue, 15 Feb 2022 01:40:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 003D3C000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Feb 2022 01:40:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E2B6240448
 for <iommu@lists.linux-foundation.org>; Tue, 15 Feb 2022 01:40:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eDtKeTI7EJZp for <iommu@lists.linux-foundation.org>;
 Tue, 15 Feb 2022 01:40:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5D369403EC
 for <iommu@lists.linux-foundation.org>; Tue, 15 Feb 2022 01:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644889245; x=1676425245;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=KYWNub4KIGvtKYUBq0gCFrcp5xgJGm+OQNdJMARo9G8=;
 b=iyqNOMyoP9xhluP5AZaSndGH0y6jWjJAsTu6xXg70Qp1Svm8zID5QOjI
 bZBwtq6GeB4tx7EWZdi8umKW4RH3h7u3BeFbKvEV94YnJnYnWW901wzZw
 gKUXbopT0ZfRbYo2lO6Wetrci0eEDuGT01Go2DDbgP1HmCyMOZCVK1DbX
 rLiE1HVSraa48nj+NT23+hxas+aPB5JGn1FeGE0OAAl+BsRhh80hlo26u
 hryAr2kjg61Ug67HFSiDO3Mjv3LXeSj0P8hXtzOSJvstAKchMnfNkTw5x
 V+KSihb1qU3L61/Z71N50gbteN089ezQgmSQ8eD+/5Y+TcYX1rT8NG40F Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="233772480"
X-IronPort-AV: E=Sophos;i="5.88,369,1635231600"; d="scan'208";a="233772480"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Feb 2022 17:40:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,369,1635231600"; d="scan'208";a="680788159"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 14 Feb 2022 17:40:39 -0800
Message-ID: <43855d9f-f60a-0bb0-088d-cf0b12defb79@linux.intel.com>
Date: Tue, 15 Feb 2022 09:39:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 09/10] iommu: Use dev_iommu_ops() helper
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20220214015538.2828933-1-baolu.lu@linux.intel.com>
 <20220214015538.2828933-10-baolu.lu@linux.intel.com>
 <20220214132608.GA4160@nvidia.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20220214132608.GA4160@nvidia.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 David Airlie <airlied@linux.ie>, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux-foundation.org, Jacob jun Pan <jacob.jun.pan@intel.com>,
 Christoph Hellwig <hch@infradead.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Thierry Reding <thierry.reding@gmail.com>, Ben Skeggs <bskeggs@redhat.com>,
 Daniel Vetter <daniel@ffwll.ch>, Jonathan Hunter <jonathanh@nvidia.com>,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
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

On 2/14/22 9:26 PM, Jason Gunthorpe wrote:
> On Mon, Feb 14, 2022 at 09:55:37AM +0800, Lu Baolu wrote:
>> This converts all the feasible instances of dev->bus->iommu_ops to
>> dev_iommu_ops() in order to make the operation of obtaining iommu_ops
>> from a device consistent. The dev_iommu_ops() warns on NULL ops, so
>> we don't need to keep the confusing ops check.
>>
>> Suggested-by: Robin Murphy<robin.murphy@arm.com>
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/iommu.c | 30 ++++++++++++++----------------
>>   1 file changed, 14 insertions(+), 16 deletions(-)
> I thought you were going to squish this into the prior patch?

I will merge this two patches in the next version. I made them separated
in this series just for ease of review.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
