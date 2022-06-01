Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 595BEC433F5
	for <iommu@archiver.kernel.org>; Wed,  1 Jun 2022 10:48:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E9AEA40A63;
	Wed,  1 Jun 2022 10:48:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZoSvdkCmPJan; Wed,  1 Jun 2022 10:48:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C62E840127;
	Wed,  1 Jun 2022 10:48:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A855EC0032;
	Wed,  1 Jun 2022 10:48:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C0C96C002D
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jun 2022 10:48:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AE99282ACA
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jun 2022 10:48:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BZrXgJ2AxK7I for <iommu@lists.linux-foundation.org>;
 Wed,  1 Jun 2022 10:48:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 22D2C81443
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jun 2022 10:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1654080509; x=1685616509;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=FljOfQd0ovis2myCMXGwjQ7sjwvP24kidUblqHsfnRA=;
 b=iI5F11nidUOKCcnuKJ41h/+z2jp0jbZKE4egwyAgHuFf4dwqeTWv3Bjz
 6kI2zKANJYYFTanquxbPblXL/hwFk5G3wIXr0vwhFo6Gq7DCLnE0qweKt
 DSIglapHdvN5odEhC5sREBRZtiRj5/pHSi9B9D52ERv+iX0L1p7IfKB9J
 EK3TL5lPj+/hJogs1+078WybXtc0mvydnHGN6u0lPz2m7ND+O0z2jR4Jb
 TH3t/mv6XhwyZzrzvGwwVrKm1NbYpBfhbXJl5kFtp+/n2rV5XKsldz4Ms
 WC4T8i1VI0Wmzz+dgY/LtbLZGM6bBoL7FjLEtBrX8mazgN1e2/fN2TZhb A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="361922342"
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; d="scan'208";a="361922342"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2022 03:48:28 -0700
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; d="scan'208";a="707004298"
Received: from hej1-mobl.ccr.corp.intel.com (HELO [10.255.28.123])
 ([10.255.28.123])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2022 03:48:25 -0700
Message-ID: <c70501f3-9cee-fc7d-4ebc-6f88e1ad147f@linux.intel.com>
Date: Wed, 1 Jun 2022 18:48:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 07/12] iommu/vt-d: Acquiring lock in pasid manipulation
 helpers
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 "Raj, Ashok" <ashok.raj@intel.com>, Christoph Hellwig <hch@infradead.org>,
 Jason Gunthorpe <jgg@nvidia.com>
References: <20220527063019.3112905-1-baolu.lu@linux.intel.com>
 <20220527063019.3112905-8-baolu.lu@linux.intel.com>
 <BN9PR11MB527639286A5F8BB4C8B4D3028CDF9@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB527639286A5F8BB4C8B4D3028CDF9@BN9PR11MB5276.namprd11.prod.outlook.com>
Cc: Will Deacon <will@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>, Robin Murphy <robin.murphy@arm.com>
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

On 2022/6/1 17:18, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Friday, May 27, 2022 2:30 PM
>>
>> The iommu->lock is used to protect the per-IOMMU pasid directory table
>> and pasid table. Move the spinlock acquisition/release into the helpers
>> to make the code self-contained.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>, with one nit
> 
>>
>> -	/* Caller must ensure PASID entry is not in use. */
>> -	if (pasid_pte_is_present(pte))
>> -		return -EBUSY;
>> +	spin_lock(&iommu->lock);
>> +	pte = get_non_present_pasid_entry(dev, pasid);
>> +	if (!pte) {
>> +		spin_unlock(&iommu->lock);
>> +		return -ENODEV;
>> +	}
> 
> I don't think above is a good abstraction and it changes the error
> code for an present entry from -EBUSY to -ENODEV.

Sure. I will roll it back to -EBUSY. I added this helper because the
same code appears at least three times in this file.

Best regards,
baolu


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
