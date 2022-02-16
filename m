Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6420DC433F5
	for <iommu@archiver.kernel.org>; Wed, 16 Feb 2022 07:04:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 034C460ACC;
	Wed, 16 Feb 2022 07:04:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2VRAY6Rp2VDy; Wed, 16 Feb 2022 07:04:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E1C7260B4D;
	Wed, 16 Feb 2022 07:04:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B4E3FC0011;
	Wed, 16 Feb 2022 07:04:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BC636C000B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Feb 2022 07:04:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9BF3E60B4D
 for <iommu@lists.linux-foundation.org>; Wed, 16 Feb 2022 07:04:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j9X34WKw4WOM for <iommu@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 07:04:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D199B60ACC
 for <iommu@lists.linux-foundation.org>; Wed, 16 Feb 2022 07:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644995085; x=1676531085;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=Rtxj1UDHxt0cG+aH0MjVGov4YzjQBNtjm2W/22eZowE=;
 b=giUnJ/9N08U4RaiUDCBd2gUfxqQ9MpICmhr4KQzTc9ZxrSqOCN1yPEEY
 Tcs9+3yhuxjMv8OV1xVa7bHSJssT+SoLay/84KUZl6zfel+2yN21U8JRA
 x5Wtd+pPiIp303qD/igSGr5WT1YETCdqJDDUCLbuM633QSjWzyx4gJwv/
 /FkeKVJ9UdKDGkVthLm4mFbx5KlaaPKN2RcReKKm1a7RG/SVO//MEWSjV
 VSwzx66P+a9HPzrxsUK+Yl60knffddQPVlSelBaHUZtE0s1yqvwCN6Tmi
 24PiHmNoicDd3hx76eOUTZPiKDrl041g/EOlnH4iK2BZW7YzFMlhU/i0g A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="275118931"
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; d="scan'208";a="275118931"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Feb 2022 23:04:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; d="scan'208";a="681387754"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 15 Feb 2022 23:04:43 -0800
Message-ID: <ae863355-3f44-5eae-4f35-90a62cb2d89f@linux.intel.com>
Date: Wed, 16 Feb 2022 15:03:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/1] iommu/vt-d: Move intel_iommu_ops to header file
Content-Language: en-US
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20220207141240.8253-1-andriy.shevchenko@linux.intel.com>
 <YgpY1IIBkFIxxjbm@8bytes.org>
 <30e45a7e-088d-7479-a284-68effadf3cbe@linux.intel.com>
 <Ygt3jibBVRyCn909@smile.fi.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <Ygt3jibBVRyCn909@smile.fi.intel.com>
Cc: Joerg Roedel <jroedel@suse.de>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
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

On 2/15/22 5:51 PM, Andy Shevchenko wrote:
> On Tue, Feb 15, 2022 at 09:31:37AM +0800, Lu Baolu wrote:
>> On 2/14/22 9:27 PM, Joerg Roedel wrote:
>>> On Mon, Feb 07, 2022 at 04:12:40PM +0200, Andy Shevchenko wrote:
> 
> ...
> 
>>>> +extern const struct iommu_ops intel_iommu_ops;
> 
>>> The intel_iommu_ops symbol is only used in drivers/iommu/intel, so I
>>> would prefer a header in that directory. But I leave that up to Baolu to
>>> decide.
>>
>> Agreed. I also have a plan to split them out into a internal header.
> 
> The above change is hanging for more than a year, can we apply it and then
> you can do a split?
> 

Yeah. This is my plan. The include/linux/intel-iommu.h also keeps other
internal only helpers. It worth a separated cleanup patch.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
