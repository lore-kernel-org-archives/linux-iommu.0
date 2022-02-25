Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81CFFC433FE
	for <iommu@archiver.kernel.org>; Fri, 25 Feb 2022 01:58:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 27E47605A5;
	Fri, 25 Feb 2022 01:58:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 72PgJOWDQiLF; Fri, 25 Feb 2022 01:58:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 17B216068A;
	Fri, 25 Feb 2022 01:58:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E31D3C0021;
	Fri, 25 Feb 2022 01:58:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 936E7C0011
 for <iommu@lists.linux-foundation.org>; Fri, 25 Feb 2022 01:58:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 81F446068A
 for <iommu@lists.linux-foundation.org>; Fri, 25 Feb 2022 01:58:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iFFOoC--zcDX for <iommu@lists.linux-foundation.org>;
 Fri, 25 Feb 2022 01:58:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E37FF605A5
 for <iommu@lists.linux-foundation.org>; Fri, 25 Feb 2022 01:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1645754333; x=1677290333;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=AiMLReOXdbxwCJYEkuxwFgwJdr/KRPlox84ap13k0a8=;
 b=aQbkLOajP2N7fOgLET6uTd9JC4oqVuZKNdkEI33MtXLDgTJfvScH5WY/
 QieC1V6wrTLMVyHoEiEMc89NggDF4z02okvpb6pDs5T4JFfH0bZio6Z0L
 jEtp2sw4nVj5nGz53msQ+ccDwBynjnlb0jUTuGZW9d2xXlnQUamy1h6N1
 dMsmlR4d+ugKDZ3GyaIIU+vkGH6pYdzYIIDnUuzBRFMBKG3CC8Ru1L1QE
 YYo8q6T9StpKloHW2wJ2gEEyXd+ULrlJo4grWzcBk+mFBjHKLGAsAMuAJ
 jTH00opBNzXwTiLLsBYpYxkfYqdToYjlIq7+vROQAxW9sIHXpgTH1N5zM w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="252592175"
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; d="scan'208";a="252592175"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2022 17:58:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; d="scan'208";a="533386135"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by orsmga007.jf.intel.com with ESMTP; 24 Feb 2022 17:58:50 -0800
Message-ID: <1e320de0-3dd7-936f-a9d4-8686687b0675@linux.intel.com>
Date: Fri, 25 Feb 2022 09:57:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 08/11] iommu/vt-d: Fix indentation of goto labels
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20220214025704.3184654-1-baolu.lu@linux.intel.com>
 <20220214025704.3184654-9-baolu.lu@linux.intel.com>
 <20220224130822.GK6413@nvidia.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20220224130822.GK6413@nvidia.com>
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

On 2/24/22 9:08 PM, Jason Gunthorpe wrote:
> On Mon, Feb 14, 2022 at 10:57:01AM +0800, Lu Baolu wrote:
>> Remove blanks before goto labels.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>>   drivers/iommu/intel/iommu.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> It would be better to rework this function to not have the goto
> spaghetti in the first place.. Looks like putting the
> 'for_each_active_dev_scope' into another function would do the trick.

Good idea. Let me revisit this later.

> 
> Anyhow, this is more consistent with kernel style:
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
