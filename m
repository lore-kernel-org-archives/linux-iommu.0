Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B38CC433EF
	for <iommu@archiver.kernel.org>; Fri, 25 Feb 2022 01:57:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B586883E9A;
	Fri, 25 Feb 2022 01:57:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FyWkSCaw1nSC; Fri, 25 Feb 2022 01:57:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B729883E6C;
	Fri, 25 Feb 2022 01:57:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9E2CEC0021;
	Fri, 25 Feb 2022 01:57:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1B6E2C0011
 for <iommu@lists.linux-foundation.org>; Fri, 25 Feb 2022 01:57:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0A54883E6F
 for <iommu@lists.linux-foundation.org>; Fri, 25 Feb 2022 01:57:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tbuqojdXAxNi for <iommu@lists.linux-foundation.org>;
 Fri, 25 Feb 2022 01:57:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7110E83E6C
 for <iommu@lists.linux-foundation.org>; Fri, 25 Feb 2022 01:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1645754259; x=1677290259;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=v0JSbQfSFuoGQvNp0jnSnBhsEa8/XAvqCDK142/+K+U=;
 b=CIHWkpHq1j2lgY0NvUKJK4gKHLqftIafFGvctxdfY12byvmLf1+yhc2R
 eWR9yn4oHOrJubGSuoutjCrUUv94rbVQuUshY870iNaZxJujmpWY6w2LW
 2GrWm0OIB/14f5dxQp6x449Mq/ygGeAJLRh8iSghSjZlPuvLc+EotmhgQ
 OXa2r5O1LP9WAcKhi9/4XowlcXrxsZwQUMXrPZoEucrm3ahrzlbsIHFJQ
 ZuyMG6hgTH6aDFSMMSxsshyT+plmxwDwD7+kz4hHRgr+pGYuM7InVltpd
 hp4X6O4y15v10aPVp3EwQYwGgH4vBtrG5iD3nggbzSgAHEmBj20mej4kX w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="313115589"
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; d="scan'208";a="313115589"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2022 17:57:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; d="scan'208";a="533385941"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by orsmga007.jf.intel.com with ESMTP; 24 Feb 2022 17:57:35 -0800
Message-ID: <0c261ae1-d1d4-d63d-19cf-e2417a6a38f9@linux.intel.com>
Date: Fri, 25 Feb 2022 09:56:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 06/11] iommu/vt-d: Remove unnecessary includes
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20220214025704.3184654-1-baolu.lu@linux.intel.com>
 <20220214025704.3184654-7-baolu.lu@linux.intel.com>
 <20220224130504.GI6413@nvidia.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20220224130504.GI6413@nvidia.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

On 2/24/22 9:05 PM, Jason Gunthorpe wrote:
> On Mon, Feb 14, 2022 at 10:56:59AM +0800, Lu Baolu wrote:
>> Remove unnecessary include files and sort the remaining alphabetically.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel/iommu.c | 34 +++++++---------------------------
>>   1 file changed, 7 insertions(+), 27 deletions(-)
> 
> Are we sorting includes alphabetically now?

I sorted them in this patch.

> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> Jason

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
