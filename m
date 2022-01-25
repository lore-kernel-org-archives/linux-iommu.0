Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E49CCC433F5
	for <iommu@archiver.kernel.org>; Tue, 25 Jan 2022 03:05:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 77F2B4034A;
	Tue, 25 Jan 2022 03:05:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qR_SttqE6m1u; Tue, 25 Jan 2022 03:05:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1BFBE400FB;
	Tue, 25 Jan 2022 03:05:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F2555C0039;
	Tue, 25 Jan 2022 03:05:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2C2F1C002F
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 03:05:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 03E0D40156
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 03:05:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Y6sChcayQ-ox for <iommu@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 03:05:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4AD85400FB
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 03:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1643079911; x=1674615911;
 h=cc:subject:to:references:from:message-id:date:
 mime-version:in-reply-to:content-transfer-encoding;
 bh=xFZOp1fGsqzXn/fUyBiOUmJ92pSPaeM/so/3oAX5ed4=;
 b=LpIzcK4XRcLLLxTWkOnxGSVxPgg7XUU43WCjrTc92gZDTZjAEkQq9PV5
 oX1itDAD8ECLR6oW4ICZfO4WEIPeBB1I163Qx8KXkC9ih2/vP2/8kLFNx
 2Ge66lYjs6+Gjf8/PAYppID75rPX5QMgs0t/S++zdimzd0E9xNb4Rx+d+
 TB+lDmTMH2BvEsLLZnkJaWWeSl09LBDcXvyeqxyp3/f0ANSQLhUyTCLyA
 dYTF8RH/0rcHnUWrjVna8vUVDWUWDBawRBh4naj7hjQ9CDPbtchVQ+9Wo
 dBocuQl4fTy/p/qH7ENuceLbtjrY0k4UYrnUTSKcBXO0TXeDLklow75dO g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="226183364"
X-IronPort-AV: E=Sophos;i="5.88,313,1635231600"; d="scan'208";a="226183364"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jan 2022 19:05:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,313,1635231600"; d="scan'208";a="534532285"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by orsmga008.jf.intel.com with ESMTP; 24 Jan 2022 19:05:05 -0800
Subject: Re: [PATCH 6/7] iommu: Use right way to retrieve iommu_ops
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Ben Skeggs <bskeggs@redhat.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
References: <20220124071103.2097118-1-baolu.lu@linux.intel.com>
 <20220124071103.2097118-7-baolu.lu@linux.intel.com>
 <BN9PR11MB52761ADE7D2696DDF0388A6F8C5E9@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <229d72cf-3d1b-8df2-7438-309893f6aa9a@linux.intel.com>
Date: Tue, 25 Jan 2022 11:04:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <BN9PR11MB52761ADE7D2696DDF0388A6F8C5E9@BN9PR11MB5276.namprd11.prod.outlook.com>
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

On 1/24/22 5:48 PM, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Monday, January 24, 2022 3:11 PM
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index aa5486243892..111b3e9c79bb 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -385,6 +385,14 @@ static inline void iommu_iotlb_gather_init(struct
>> iommu_iotlb_gather *gather)
>>   	};
>>   }
>>
>> +static inline const struct iommu_ops *dev_iommu_ops_get(struct device
>> *dev)
> 
> dev_get_iommu_ops or just dev_iommu_ops?

dev_iommu_ops() looks better.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
