Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A888C433F5
	for <iommu@archiver.kernel.org>; Thu,  5 May 2022 12:12:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1B04440383;
	Thu,  5 May 2022 12:12:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kEwEen9pubSD; Thu,  5 May 2022 12:12:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DE3804014A;
	Thu,  5 May 2022 12:12:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 89CF9C0039;
	Thu,  5 May 2022 12:12:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1C34AC002D
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 12:12:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0823483F6F
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 12:12:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2g3928rkBBa8 for <iommu@lists.linux-foundation.org>;
 Thu,  5 May 2022 12:12:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3E06383F65
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 12:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651752755; x=1683288755;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=2DhPSKq1r7S3sDZ7dC36QkPcIiYnpBlQkC9n0su6nWA=;
 b=DDKFj/maGjcDajwnRbbhOacG0WEIZf6xCkTjtvTBBsSDd7hirHliIdw+
 kwDmt7CoaZDxHBzvD84nmKSmCKdtSlu+GjUiQ3T0hfV6mmd9VzCLEWu1u
 TmlkkkouRq6AQIJlo5xIcZdxq1jb5Nuee9YIUA1Al4BsjxlU8YTGnukSs
 CHy1yfDd8SzVYf0y6vc6uzwIooNzV0lRGx+C/01yYUXIos7ai8vd3V24O
 sgo5chUD+w+Iz9wwdwJ5QRiJvP1gtbnmq5IhbUOqwNoXVFNF7sOp0OQLr
 jwuYukPqsVtDW6ooRm4EiM4dt6mXdBhosxnABsRIdXK3U4lDNYJGuSdrl w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="328628608"
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; d="scan'208";a="328628608"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2022 05:12:28 -0700
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; d="scan'208";a="563215563"
Received: from minhaowa-mobl.ccr.corp.intel.com (HELO [10.255.30.75])
 ([10.255.30.75])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2022 05:12:26 -0700
Message-ID: <22359719-15c8-5215-fdf3-7eec60f2c106@linux.intel.com>
Date: Thu, 5 May 2022 20:12:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 2/4] iommu/vt-d: Check domain force_snooping against
 attached devices
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Jason Gunthorpe <jgg@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20220505010710.1477739-1-baolu.lu@linux.intel.com>
 <20220505010710.1477739-3-baolu.lu@linux.intel.com>
 <BN9PR11MB5276F768185B4CB64C2D027E8CC29@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276F768185B4CB64C2D027E8CC29@BN9PR11MB5276.namprd11.prod.outlook.com>
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

On 2022/5/5 16:43, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Thursday, May 5, 2022 9:07 AM
>>
>> As domain->force_snooping only impacts the devices attached with the
>> domain, there's no need to check against all IOMMU units. At the same
>> time, for a brand new domain (hasn't been attached to any device), the
>> force_snooping field could be set, but the attach_dev callback will
>> return failure if it wants to attach to a device which IOMMU has no
>> snoop control capability.
> 
> The description about brand new domain is not very clear. I think the
> point here is that force_snooping could be set on a domain no matter
> whether it has been attached or not and once set it is an immutable
> flag. If no device attached the operation always succeeds then this
> empty domain can be only attached to a device of which the IOMMU
> supports snoop control.

Exactly. Will update this description.

> 
>>   static bool intel_iommu_enforce_cache_coherency(struct iommu_domain
>> *domain)
>>   {
>>   	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
>>
>> -	if (!domain_update_iommu_snooping(NULL))
>> +	if (dmar_domain->force_snooping)
>> +		return true;
>> +
>> +	if (!domain_support_force_snooping(dmar_domain))
>>   		return false;
>> +
> 
> Who guarantees that domain->devices won't change between
> above condition check and following set operation?

Good catch. Should lift the lock up here.

> 
>> +	domain_set_force_snooping(dmar_domain);
>>   	dmar_domain->force_snooping = true;
>> +
>>   	return true;
>>   }
>>
> 
> Thanks
> Kevin

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
