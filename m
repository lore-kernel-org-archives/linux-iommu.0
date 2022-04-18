Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82B72C433EF
	for <iommu@archiver.kernel.org>; Mon, 18 Apr 2022 11:44:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2DA4941012;
	Mon, 18 Apr 2022 11:44:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7xJtgjdrmVpB; Mon, 18 Apr 2022 11:44:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 13BCF40579;
	Mon, 18 Apr 2022 11:44:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E39BDC002F;
	Mon, 18 Apr 2022 11:44:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C29EDC002C
 for <iommu@lists.linux-foundation.org>; Mon, 18 Apr 2022 11:44:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A074040579
 for <iommu@lists.linux-foundation.org>; Mon, 18 Apr 2022 11:44:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ekk7YIk_itnI for <iommu@lists.linux-foundation.org>;
 Mon, 18 Apr 2022 11:44:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DEE0740297
 for <iommu@lists.linux-foundation.org>; Mon, 18 Apr 2022 11:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1650282288; x=1681818288;
 h=message-id:date:mime-version:cc:to:references:from:
 subject:in-reply-to:content-transfer-encoding;
 bh=ed9XtiWvuduH3tePyFDVZz4+lZ73C5IN2pEFYdP+YKI=;
 b=aw2Mjak+93FclCcIlf9i+OqhUpfmbIf6LjOV46n7HlmdtYKeBgR7Fr9r
 60LN4nRizwPhYgbSBZgwSq+bx2m/aVs6VmxVAMsTWxP5h9GGNxNbpz5ks
 3nitAuArXAwhmituSAobqgS1Q/2rtdlcMEwe2Yfql+5AU9w965a4QP0/M
 BJtb5N1HExkEUgpFt40pOFrtME4VQen4oO/A4/Qx1R/1Mt5AyuPwt7zTe
 Gwmec3B0+fU8CIlrVNjfVNdliPD7LDHkI1X4pyVgQYBxBibvx8t1hHqO9
 o+0Vf2c1obq9oipg7KwiwS+c+uzVtDgWxC0l/1TwFttXA2TI3eF8I625v Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10320"; a="323944345"
X-IronPort-AV: E=Sophos;i="5.90,269,1643702400"; d="scan'208";a="323944345"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Apr 2022 04:44:48 -0700
X-IronPort-AV: E=Sophos;i="5.90,269,1643702400"; d="scan'208";a="575541874"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.208.231])
 ([10.254.208.231])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Apr 2022 04:44:46 -0700
Message-ID: <46f51f30-28e9-4b91-acd5-1df43c1428d6@linux.intel.com>
Date: Mon, 18 Apr 2022 19:44:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>,
 "Pan, Jacob jun" <jacob.jun.pan@intel.com>, "Raj, Ashok"
 <ashok.raj@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>
References: <20220416123049.879969-1-baolu.lu@linux.intel.com>
 <20220416123049.879969-4-baolu.lu@linux.intel.com>
 <BN9PR11MB5276BC4D5F9B133C84630CBA8CF39@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 3/3] iommu/vt-d: Size Page Request Queue to avoid overflow
 condition
In-Reply-To: <BN9PR11MB5276BC4D5F9B133C84630CBA8CF39@BN9PR11MB5276.namprd11.prod.outlook.com>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
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

On 2022/4/18 15:00, Tian, Kevin wrote:
>> From: Lu Baolu<baolu.lu@linux.intel.com>
>> Sent: Saturday, April 16, 2022 8:31 PM
>>
>> PRQ overflow may cause I/O throughput congestion, resulting in unnecessary
>> degradation of IO performance. Appropriately increasing the length of PRQ
>> can greatly reduce the occurrence of PRQ overflow. The count of maximum
>> page requests that can be generated in parallel by a PCIe device is
>> statically defined in the Outstanding Page Request Capacity field of the
>> PCIe ATS configure space.
>>
>> The new lenght of PRQ is calculated by summing up the value of Outstanding
>> Page Request Capacity register across all devices where Page Requests are
>> supported on the real PR-capable platfrom (Intel Sapphire Rapids). The
>> result is round to the nearest higher power of 2.
> The actual requirement is usage and platform specific. What about
> doubling the default size and also provide an option for admin to
> tune?

I also have this in my list to provide an opt-in interface for user. But
I don't want to include it in this series as this is only for small
tuning. The opt-in interface looks more like a new feature. :-)

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
