Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADB55C433F5
	for <iommu@archiver.kernel.org>; Tue, 22 Mar 2022 00:45:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6029384316;
	Tue, 22 Mar 2022 00:45:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4WCaSxr2TjU5; Tue, 22 Mar 2022 00:45:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5C36884311;
	Tue, 22 Mar 2022 00:45:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2C4A6C0012;
	Tue, 22 Mar 2022 00:45:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0223DC000B
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 00:45:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E5618416D8
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 00:45:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AVOdmdcaTPjQ for <iommu@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 00:45:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 418CB416D7
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 00:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647909912; x=1679445912;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=TSpDJqCgCqJQmfCcYan0G8S5Qg4VBq1hKKqgc00HwE4=;
 b=d9V3FWUd0ZUEI5+SqRw4goNEm7gfowv9c01hLj5JujU7WJGSINF7qCQw
 Zz3KYT6hKt+9DTgaJ5VrylZH03ua608UtQPeC3hLbWu9tAW+YTCfIfP9l
 Gwonyc2SZXjU0wpAJicc23lflhzF3cLOnRwzN6cEah8OVv2Ww8xY1atmr
 CTVKBu+eSoHf4nahQmagNNeQFAM376Z8/WGBlfyTHjNPNkrIEhPbILtkF
 D00mEDssRH+L3fud7Sh5KEMx9ThuxdUX8PTi/zLXY+bjIiFaugBTbSm2J
 o5VfyE6uLvxM3t+Ut27AnFavaX2Gmba3t/6iJd1K8WF+OqI0GxXbywjiX Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="257633760"
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; d="scan'208";a="257633760"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Mar 2022 17:45:11 -0700
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; d="scan'208";a="560118888"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.208.85])
 ([10.254.208.85])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Mar 2022 17:45:07 -0700
Message-ID: <a0be971d-2cbc-8d62-4a05-9f8542fefe94@linux.intel.com>
Date: Tue, 22 Mar 2022 08:45:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH RFC 01/11] iommu: Add pasid_bits field in struct dev_iommu
Content-Language: en-US
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
 <20220320064030.2936936-2-baolu.lu@linux.intel.com> <Yjhf4dlthDkHBICr@myrica>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <Yjhf4dlthDkHBICr@myrica>
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

On 2022/3/21 19:22, Jean-Philippe Brucker wrote:
> Hi Baolu,
> 
> On Sun, Mar 20, 2022 at 02:40:20PM +0800, Lu Baolu wrote:
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> index 627a3ed5ee8f..8e262210b5ad 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> @@ -2812,6 +2812,7 @@ static int arm_smmu_dev_enable_feature(struct device *dev,
>>   		master->iopf_enabled = true;
>>   		return 0;
>>   	case IOMMU_DEV_FEAT_SVA:
>> +		dev->iommu->pasid_bits = master->ssid_bits;
> This would be better in arm_smmu_probe_device()

Sure.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
