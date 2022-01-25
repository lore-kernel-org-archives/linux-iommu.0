Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7CBAC433F5
	for <iommu@archiver.kernel.org>; Tue, 25 Jan 2022 05:00:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7138F4099A;
	Tue, 25 Jan 2022 05:00:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BpW94ASDOpFW; Tue, 25 Jan 2022 05:00:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5B31440993;
	Tue, 25 Jan 2022 05:00:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2E7B9C0039;
	Tue, 25 Jan 2022 05:00:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0C541C002F
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 05:00:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EF4A360B38
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 05:00:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AhsRwrXuY9Xc for <iommu@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 05:00:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5323760B2F
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 05:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1643086828; x=1674622828;
 h=cc:subject:to:references:from:message-id:date:
 mime-version:in-reply-to:content-transfer-encoding;
 bh=jvQi+RQyehALY6K5e0Jia9BEKYL9WZi+E3wSrVsSdpc=;
 b=M7w3mTnlc8vYZMXdy6ZWmdYOJKxGPEw56Jt3A2pgsx+8LMEPkF5KYZq0
 sQFDOg9b2GbMuFwILpzaQnftTOUEhtTfSbjJbYkqua1SsjxImMi6gui7u
 JlZZlO7j6yKoMqoMXqzpBVrIpZz86wDT0JonTBWKxf4UxiOB4XAskPXAs
 6nyw2jq75G+vWBQDrH4JfW1asuwMEzEWPv2/LSKghmv5vWyyXYhyTd0u7
 Si3YipQEVnN9o3UbvSM1oIm6w8IL0Cxo1j4FEVdl/WcwDOnFYLDv1zczN
 iKpX8RYIh1U+zKhvCzfVQiJGLRKFmQubFDLuTofOaz5ZoBEOtNGDJJtLf Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="226889673"
X-IronPort-AV: E=Sophos;i="5.88,314,1635231600"; d="scan'208";a="226889673"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jan 2022 21:00:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,314,1635231600"; d="scan'208";a="534563268"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by orsmga008.jf.intel.com with ESMTP; 24 Jan 2022 21:00:14 -0800
Subject: Re: [PATCH 7/7] iommu: Add iommu_domain::domain_ops
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Ben Skeggs <bskeggs@redhat.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
References: <20220124071103.2097118-1-baolu.lu@linux.intel.com>
 <20220124071103.2097118-8-baolu.lu@linux.intel.com>
 <BN9PR11MB5276BE30652988271878E78C8C5E9@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <33060cd9-9115-013c-7253-52a36aa467e7@linux.intel.com>
Date: Tue, 25 Jan 2022 12:59:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <BN9PR11MB5276BE30652988271878E78C8C5E9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
Cc: David Airlie <airlied@linux.ie>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Thierry Reding <thierry.reding@gmail.com>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>, Daniel Vetter <daniel@ffwll.ch>
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

On 1/24/22 5:58 PM, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Monday, January 24, 2022 3:11 PM
>> +/**
>> + * struct domain_ops - per-domain ops
>> + * @attach_dev: attach an iommu domain to a device
>> + * @detach_dev: detach an iommu domain from a device
> 
> What is the criteria about whether an op should be iommu_ops or domain_ops
> when it requires both domain and device pointers like above two (and future
> PASID-based attach)?

Generally ops belong to iommu_ops if they are only device oriented, and
domain_ops if they are only domain oriented. But it's really hard to
judge when both device and domain are involved. Good question. :-)

Perhaps we should leave the attach/detach interfaces in iommu_ops since
they are related to device capabilities. For example, some devices
support attach_dev_pasid, while others not.

> 
> Other examples include:
> 	@apply_resv_region

This will be deprecated.

> 	@is_attach_deferred

Should be at least device centric (domain doesn't play any role here).
Further step is to save the is_attach_deferred at a flag in dev_iommu
and remove the ops (as Robin suggested).

> 
> Thanks
> Kevin
> 

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
