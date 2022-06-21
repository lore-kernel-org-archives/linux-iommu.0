Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30A9DC433EF
	for <iommu@archiver.kernel.org>; Tue, 21 Jun 2022 04:28:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9774F40AF6;
	Tue, 21 Jun 2022 04:28:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9774F40AF6
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Bo9w9jwu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DwYm7GpxYxBE; Tue, 21 Jun 2022 04:28:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 57BD840445;
	Tue, 21 Jun 2022 04:28:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 57BD840445
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 24C35C0032;
	Tue, 21 Jun 2022 04:28:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 502C0C002D
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jun 2022 04:28:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2519441983
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jun 2022 04:28:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2519441983
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Bo9w9jwu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jSf8wn8TAmYx for <iommu@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 04:28:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1EC2641970
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1EC2641970
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jun 2022 04:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1655785707; x=1687321707;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=DkFRRkmJt7PsIWwIUdSoJXbh9kQg9crtwrrbrg/6TSU=;
 b=Bo9w9jwujt69Hs9dyhb7+oWRH9PVzKZSbF2YXQrAAGfbLUmeTv2MuVUR
 WT9L5UjP41tJs99gFf4qW/TMGLKvrj6dZ8pH8AHgV2ZNVYLMvFAJ+EOqe
 KZ4iWq0LckKlGqbAlYLrDfeNDeU71PATydCNMw/X7rGEpMdySVpXlAjce
 kvef2TiiDnnZbYIZ3BxI8wnpUlCS81ux2AI+bhvkuzmDOjzRZdGnos4L7
 3jCFWFS+gmi1TSZGweRKdZSu5JoeFVAI7uCI8YEY9GB02jvqvNJoNnI2s
 8oW8XZd9QmaXLClvQHgDIs25UBeIH1Jq+vIpLUUtW7UbdShVk8Z1rDAgG A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="341708607"
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; d="scan'208";a="341708607"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2022 21:28:24 -0700
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; d="scan'208";a="833395659"
Received: from zequnyu-mobl1.ccr.corp.intel.com (HELO [10.255.31.162])
 ([10.255.31.162])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2022 21:28:22 -0700
Message-ID: <80457871-a760-69ba-70be-5e95344182ea@linux.intel.com>
Date: Tue, 21 Jun 2022 12:28:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix RID2PASID setup failure
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 "Raj, Ashok" <ashok.raj@intel.com>
References: <20220620081729.4610-1-baolu.lu@linux.intel.com>
 <BN9PR11MB52764F60972DF52EEF945D408CB39@BN9PR11MB5276.namprd11.prod.outlook.com>
 <5d13cab5-1f0a-51c7-78a3-fb5d3d793ab1@linux.intel.com>
 <BN9PR11MB527671B3B4C1F786E40D67408CB39@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB527671B3B4C1F786E40D67408CB39@BN9PR11MB5276.namprd11.prod.outlook.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>, "Qiang,
 Chenyi" <chenyi.qiang@intel.com>,
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

On 2022/6/21 11:46, Tian, Kevin wrote:
>> From: Baolu Lu <baolu.lu@linux.intel.com>
>> Sent: Tuesday, June 21, 2022 11:39 AM
>>
>> On 2022/6/21 10:54, Tian, Kevin wrote:
>>>> From: Lu Baolu <baolu.lu@linux.intel.com>
>>>> Sent: Monday, June 20, 2022 4:17 PM
>>>> @@ -2564,7 +2564,7 @@ static int domain_add_dev_info(struct
>>>> dmar_domain *domain, struct device *dev)
>>>>    			ret = intel_pasid_setup_second_level(iommu,
>>>> domain,
>>>>    					dev, PASID_RID2PASID);
>>>>    		spin_unlock_irqrestore(&iommu->lock, flags);
>>>> -		if (ret) {
>>>> +		if (ret && ret != -EBUSY) {
>>>>    			dev_err(dev, "Setup RID2PASID failed\n");
>>>>    			dmar_remove_one_dev_info(dev);
>>>>    			return ret;
>>>> --
>>>> 2.25.1
>>>
>>> It's cleaner to avoid this error at the first place, i.e. only do the
>>> setup when the first device is attached to the pasid table.
>>
>> The logic that identifies the first device might introduce additional
>> unnecessary complexity. Devices that share a pasid table are rare. I
>> even prefer to give up sharing tables so that the code can be
>> simpler.:-)
>>
> 
> It's not that complex if you simply move device_attach_pasid_table()
> out of intel_pasid_alloc_table(). Then do the setup if
> list_empty(&pasid_table->dev) and then attach device to the
> pasid table in domain_add_dev_info().

The pasid table is part of the device, hence a better place to
allocate/free the pasid table is in the device probe/release paths.
Things will become more complicated if we change relationship between
device and it's pasid table when attaching/detaching a domain. That's
the reason why I thought it was additional complexity.

--
Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
