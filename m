Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F774C4167B
	for <iommu@archiver.kernel.org>; Wed, 30 Mar 2022 11:59:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 215B1847F1;
	Wed, 30 Mar 2022 11:59:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aQ7QAXbPxeDK; Wed, 30 Mar 2022 11:59:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BCC5B8475D;
	Wed, 30 Mar 2022 11:59:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 95423C001D;
	Wed, 30 Mar 2022 11:59:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DE1B4C0012
 for <iommu@lists.linux-foundation.org>; Wed, 30 Mar 2022 11:59:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DB2AB84543
 for <iommu@lists.linux-foundation.org>; Wed, 30 Mar 2022 11:59:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Bgf4m4a_lC7o for <iommu@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 11:59:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1B0638453A
 for <iommu@lists.linux-foundation.org>; Wed, 30 Mar 2022 11:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1648641545; x=1680177545;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=tANUoNzHzK67sN+dxAnpjoWCep2qpLxGxl27vY7/z0A=;
 b=WatlqHBtMZHbNxMLDWzREXtDWnHsFbljQJNHdbRqDS+YJH/pOq5DxtSF
 Zj9mmePTCdl0C2YQFwJCugPxnS3KkQ5fe6U43YR75dRBdPdPShdAlmp0z
 aiWSb5LPKYNgMzC6IUN1HFUeafMCDrVeKYiKr5dz0LnYpcmKT1Aj/NhIh
 93mcrdo3+koIGaHlJnhRFnaE76Zk9BMWOJetQIM9vGfxhfRhwg6y4qz49
 f3CNWiarx4+gkSkEZdzMXz2Pbrtvw/6XJVonkj9KaqdAiTYhCClZMqq48
 J1xBnOiMO4ENNh1OfxBCcXfaSbZ+YCeHeNz5JZnX93ANc1fD/FWI0iiO3 Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="259239361"
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; d="scan'208";a="259239361"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2022 04:59:04 -0700
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; d="scan'208";a="565505459"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.215.120])
 ([10.254.215.120])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2022 04:58:59 -0700
Message-ID: <d2cdd06b-bd66-a422-125c-b1b389c195de@linux.intel.com>
Date: Wed, 30 Mar 2022 19:58:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH RFC v2 01/11] iommu: Add pasid_bits field in struct
 dev_iommu
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
References: <20220329053800.3049561-1-baolu.lu@linux.intel.com>
 <20220329053800.3049561-2-baolu.lu@linux.intel.com>
 <BN9PR11MB52763DAEC605FD1B21EE4EAF8C1F9@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52763DAEC605FD1B21EE4EAF8C1F9@BN9PR11MB5276.namprd11.prod.outlook.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>
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

On 2022/3/30 15:05, Tian, Kevin wrote:
>> From: Lu Baolu<baolu.lu@linux.intel.com>
>> Sent: Tuesday, March 29, 2022 1:38 PM
>>
>> Use this field to save the pasid/ssid bits that a device is able to
>> support with its IOMMU hardware. It is a generic attribute of a device
>> and lifting it into the per-device dev_iommu struct makes it possible
>> to allocate a PASID for device without calls into the IOMMU drivers.
>> Any iommu driver which suports PASID related features should set this
>> field before features are enabled on the devices.
> Miss a clarification for non-PCI SVA as discussed here:
> 
> https://lore.kernel.org/all/85d61ad6-0cf0-ac65-3312-32d0cdeb1b27@linux.intel.com/

Yes. Thanks for the reminding.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
