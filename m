Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7842FC43219
	for <iommu@archiver.kernel.org>; Tue, 12 Apr 2022 11:56:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 209776100D;
	Tue, 12 Apr 2022 11:56:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BQHxrZhLtl1G; Tue, 12 Apr 2022 11:56:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1156D60E61;
	Tue, 12 Apr 2022 11:56:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DD6C6C002F;
	Tue, 12 Apr 2022 11:56:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BB2B1C002C
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 11:56:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9A1938308A
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 11:56:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BmNlbuqsWO4v for <iommu@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 11:56:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 74D9883089
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 11:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1649764582; x=1681300582;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=L0qUnMQOFRRb2Pk8gqURd8V55DtzojRRl0dzjoOnUPY=;
 b=A6mL7VXFmmLC4J9SdW0jPo68F0khU0bWfNwSqS6fPzDaqpSzLfcBBPtO
 pWFbKhW7c5CRdvcZJqa1eiLhwSGJ3bwdNHDR03jgpOgW3y27lbnpN7tUW
 /rmMbmMKmBugqqrRdJ5gpIrUbI7qqSm3/3CYPIEUfTsUsAWzjBkxOq/jU
 fMI9TMmI09R6U6W3xBkGrXpw1m40Ud3Hwhdz2ELCVT05tEb6jucqRwSIR
 iv2K+SudwhxjIAiQaCThqWtHwaZipoWnKG4Z6WSQfV4/mzeUNqwVWFmYW
 Fo2uNV3qqEPcPOBpXEClQlZOgxuYIWMCIiuuD+ZCiJK/eiRBTe2duIljW A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="259953459"
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; d="scan'208";a="259953459"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Apr 2022 04:56:20 -0700
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; d="scan'208";a="572730132"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.210.174])
 ([10.254.210.174])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Apr 2022 04:56:16 -0700
Message-ID: <317c1d39-13df-2559-dff7-2a5c82630739@linux.intel.com>
Date: Tue, 12 Apr 2022 19:56:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH RFC v3 02/12] iommu: Add a flag to indicate immutable
 singleton group
Content-Language: en-US
To: Yi Liu <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, "Raj, Ashok" <ashok.raj@intel.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
References: <20220410102443.294128-1-baolu.lu@linux.intel.com>
 <20220410102443.294128-3-baolu.lu@linux.intel.com>
 <BN9PR11MB527679E5CE0516B2786F57518CED9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <7c70a136-6871-b48c-8e46-852bb1b62958@linux.intel.com>
 <e8d8d08c-8327-b0ad-6bdd-ef10cd34e212@intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <e8d8d08c-8327-b0ad-6bdd-ef10cd34e212@intel.com>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

Hi Yi,

On 2022/4/12 14:34, Yi Liu wrote:
>>>
>>>>
>>>> This adds a flag in the iommu_group struct to indicate an immutable
>>>> singleton group, and uses standard PCI bus topology, isolation 
>>>> features,
>>>> and DMA alias quirks to set the flag. If the device came from DT, 
>>>> assume
>>>> it is static and then the singleton attribute can know from the device
>>>> count in the group.
>>>
>>> where does the assumption come from?
>>
>> Hotplug is the only factor that can dynamically affect the
>> characteristics of IOMMU group singleton as far as I can see. If a
>> device node was created from the DT, it could be treated as static,
>> hence we can judge the singleton in iommu probe phase during boot.
> 
> not sure if hotplug is the only factor. Is it possible that admin modifies
> the ACS configuration on the bridge?

Not likely. This will completely change the existing iommu_group
settings.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
