Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8D5EC433EF
	for <iommu@archiver.kernel.org>; Sat,  9 Apr 2022 12:44:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 56AE4410AB;
	Sat,  9 Apr 2022 12:44:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n5r_xKG0rU1Y; Sat,  9 Apr 2022 12:44:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0B401408F9;
	Sat,  9 Apr 2022 12:44:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DE32CC0033;
	Sat,  9 Apr 2022 12:44:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0E5E4C002C
 for <iommu@lists.linux-foundation.org>; Sat,  9 Apr 2022 12:44:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EA00F4010E
 for <iommu@lists.linux-foundation.org>; Sat,  9 Apr 2022 12:44:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2n7v73KlyDL1 for <iommu@lists.linux-foundation.org>;
 Sat,  9 Apr 2022 12:44:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6058A4002B
 for <iommu@lists.linux-foundation.org>; Sat,  9 Apr 2022 12:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1649508274; x=1681044274;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=vN9BGDE0AtbpKR0FrUbydLNQHt8DeQ0BMm7aU1jDmgg=;
 b=WyuXiuugaVHCSFIIfvlLk1463AKmYIk2xFypq86xjZiOleXGMnmW7Nc5
 eT4gcQsd+00DLOQ6otfGkouZKQrctBgeupskP/mALISscIZQOQyTuquGM
 kUWUSeyWoBjNcrCjKIqg3i7HT7k6ItRhgS+CU+wuUs/DOE417UKy2PR5n
 Jc4FODWBzwbbusrjmbAGWxsZcds3+wb9Yzxw6NRHTFWC4bUlhDuStwiI2
 3OZM1JyVV+yU40lwLZ6dQ+ZqVUSHceYX1y9ZG04GtHlQhdQPsrQyJXlld
 f+DMYLhovQudhKx2U/Z2h05+qTydpyXjmkM8QfSW12kiAwGgZ6CYkKzhp w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10311"; a="261977578"
X-IronPort-AV: E=Sophos;i="5.90,247,1643702400"; d="scan'208";a="261977578"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2022 05:44:33 -0700
X-IronPort-AV: E=Sophos;i="5.90,247,1643702400"; d="scan'208";a="698637454"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.214.211])
 ([10.254.214.211])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2022 05:44:31 -0700
Message-ID: <5511a33b-573d-d605-4fbc-67f8e578aec5@linux.intel.com>
Date: Sat, 9 Apr 2022 20:44:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/4] iommu: Introduce the domain op
 enforce_cache_coherency()
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, David Woodhouse <dwmw2@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>
References: <0-v2-f090ae795824+6ad-intel_no_snoop_jgg@nvidia.com>
 <1-v2-f090ae795824+6ad-intel_no_snoop_jgg@nvidia.com>
 <BN9PR11MB5276FBFE9D5BC5039BA571A58CE99@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276FBFE9D5BC5039BA571A58CE99@BN9PR11MB5276.namprd11.prod.outlook.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

On 2022/4/8 16:05, Tian, Kevin wrote:
>> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
>> index 2f9891cb3d0014..1f930c0c225d94 100644
>> --- a/include/linux/intel-iommu.h
>> +++ b/include/linux/intel-iommu.h
>> @@ -540,6 +540,7 @@ struct dmar_domain {
>>   	u8 has_iotlb_device: 1;
>>   	u8 iommu_coherency: 1;		/* indicate coherency of
>> iommu access */
>>   	u8 iommu_snooping: 1;		/* indicate snooping control
>> feature */
>> +	u8 enforce_no_snoop : 1;        /* Create IOPTEs with snoop control */
> it reads like no_snoop is the result of the enforcement... Probably
> force_snooping better matches the intention here.

+1

Other changes in iommu/vt-d looks good to me.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
