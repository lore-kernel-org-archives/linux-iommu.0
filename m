Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25651C433F5
	for <iommu@archiver.kernel.org>; Wed,  1 Jun 2022 09:37:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BB5C9415FB;
	Wed,  1 Jun 2022 09:37:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id thZal4rso8p1; Wed,  1 Jun 2022 09:37:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5BE4E415FC;
	Wed,  1 Jun 2022 09:37:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2A94EC0039;
	Wed,  1 Jun 2022 09:37:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ADAA0C002D
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jun 2022 09:37:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8B851415FB
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jun 2022 09:37:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o9HNLLYyF210 for <iommu@lists.linux-foundation.org>;
 Wed,  1 Jun 2022 09:37:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B8166415C5
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jun 2022 09:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1654076251; x=1685612251;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=D7NtTD/QI9HCTZzgqGKCgSrSSUq0k5fYUd5oM5bo5JY=;
 b=G3zvwCRiDRNivkdtM/m01wXHda3/2bap0PGQPIgurgD/m0orMk3wn3ON
 msppomuEDWSL5T4jTotk2g9U3A7GLZF6GvkqxcgbvbF49b7+nY3iz7HWn
 NMEQnKmQz2L95oA9UhcIJb2mEp+6K+9L/2DSd9lL9U2/0H5VjRGs4NMLq
 A90q0phGiZHaViF11kN1Zsu9DJAGfrhu1jTBRfp/wm0EQLBckTHK14bSH
 jwAb55wxaoAuLzeAx5KMs7nZmpQ/ArJJZCX92mThpegtX1kUS8HaIYMZs
 IundusFBY9A/Fy86SXHOaJg0DFOtMv7Y3EMX7x3DwiNrm6EZuHTrIRznZ A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="361904365"
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; d="scan'208";a="361904365"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2022 02:37:31 -0700
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; d="scan'208";a="706981292"
Received: from hej1-mobl.ccr.corp.intel.com (HELO [10.255.28.123])
 ([10.255.28.123])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2022 02:37:27 -0700
Message-ID: <868984fa-c8bc-635c-1788-99bc8e6fd587@linux.intel.com>
Date: Wed, 1 Jun 2022 17:37:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 1/6] iommu: Add a per domain PASID for DMA API
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <20220518182120.1136715-1-jacob.jun.pan@linux.intel.com>
 <20220518182120.1136715-2-jacob.jun.pan@linux.intel.com>
 <20220524135034.GU1343366@nvidia.com> <20220524081727.19c2dd6d@jacob-builder>
 <20220530122247.GY1343366@nvidia.com>
 <BN9PR11MB52768105FC4FB959298F8A188CDC9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <628aa885-dd12-8bcd-bfc6-446345bf69ed@linux.intel.com>
 <20220531102955.6618b540@jacob-builder>
 <BN9PR11MB5276A2B5E849C2153939934C8CDF9@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276A2B5E849C2153939934C8CDF9@BN9PR11MB5276.namprd11.prod.outlook.com>
Cc: "vkoul@kernel.org" <vkoul@kernel.org>, "Jiang, Dave" <dave.jiang@intel.com>,
 "Raj, Ashok" <ashok.raj@intel.com>, "will@kernel.org" <will@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Jason Gunthorpe <jgg@nvidia.com>,
 "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 David Woodhouse <dwmw2@infradead.org>
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

On 2022/6/1 09:43, Tian, Kevin wrote:
>> From: Jacob Pan<jacob.jun.pan@linux.intel.com>
>> Sent: Wednesday, June 1, 2022 1:30 AM
>>>> In both cases the pasid is stored in the attach data instead of the
>>>> domain.
>>>>
>> So during IOTLB flush for the domain, do we loop through the attach data?
> Yes and it's required.

What does the attach data mean here? Do you mean group->pasid_array?

Why not tracking the {device, pasid} info in the iommu driver when
setting domain to {device, pasid}? We have tracked device in a list when
setting a domain to device.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
