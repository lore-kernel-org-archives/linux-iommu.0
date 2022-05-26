Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C164EC433F5
	for <iommu@archiver.kernel.org>; Thu, 26 May 2022 01:03:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5168840A93;
	Thu, 26 May 2022 01:03:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JTkaajbYcBBK; Thu, 26 May 2022 01:03:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 31CBD400A4;
	Thu, 26 May 2022 01:03:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 13646C0039;
	Thu, 26 May 2022 01:03:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9B443C002D
 for <iommu@lists.linux-foundation.org>; Thu, 26 May 2022 01:03:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 73DB140A93
 for <iommu@lists.linux-foundation.org>; Thu, 26 May 2022 01:03:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7WJLcTYoA23s for <iommu@lists.linux-foundation.org>;
 Thu, 26 May 2022 01:03:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C08C2400A4
 for <iommu@lists.linux-foundation.org>; Thu, 26 May 2022 01:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1653527010; x=1685063010;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=bexwVsjTlj4+OT7BIDQSL12xl4zS/h0VfNF+KXjKZKY=;
 b=E9ZwcvyNtE7U9fyJ5DbCMGqujgJUucrRq5ZWW6vW9XQUmCEoMZx2tJFk
 wDKpFN47BANRu3p6O+ukSOnybIOL7zaGxv8zhQnIAxz8SbEBrHX5hNDMo
 P7LZ2jBD26DDTkofX0UErWvy0HAcs4x2NeuWNTRyfaoTVIvstrU2WCh7m
 QfDFWWq6KH4G4JmlfiqFJKdp18t6Y2KEOUANa2xwlZiOlaBD4OUl+ksgJ
 Mj0uvpllIa9FFGeWGzJYCq6WezNN7BY4XfNV191UR+jgIPvnvK9uVBBs5
 MVLNs+JsUoa2nswY0owivF0CJ5+b+ysHQ8Ezhx6EBRNTSemWDLyXwtBFC Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10358"; a="254480592"
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; d="scan'208";a="254480592"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2022 18:03:27 -0700
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; d="scan'208";a="602624206"
Received: from fengyuan-mobl.ccr.corp.intel.com (HELO [10.249.175.132])
 ([10.249.175.132])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2022 18:03:23 -0700
Message-ID: <6588c871-a46d-9746-53da-c119d79370b5@linux.intel.com>
Date: Thu, 26 May 2022 09:03:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v7 03/10] iommu/sva: Add iommu_sva_domain support
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20220519072047.2996983-1-baolu.lu@linux.intel.com>
 <20220519072047.2996983-4-baolu.lu@linux.intel.com>
 <20220524134440.GT1343366@nvidia.com>
 <3ce2f162-7b0c-391d-7978-d1703fbe9b79@linux.intel.com>
 <20220525152538.GD1343366@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220525152538.GD1343366@nvidia.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Kevin Tian <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Vinod Koul <vkoul@kernel.org>, Jacob jun Pan <jacob.jun.pan@intel.com>,
 Will Deacon <will@kernel.org>
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

On 2022/5/25 23:25, Jason Gunthorpe wrote:
> On Wed, May 25, 2022 at 01:19:08PM +0800, Baolu Lu wrote:
>> Hi Jason,
>>
>> On 2022/5/24 21:44, Jason Gunthorpe wrote:
>>>> diff --git a/drivers/iommu/iommu-sva-lib.c b/drivers/iommu/iommu-sva-lib.c
>>>> index 106506143896..210c376f6043 100644
>>>> +++ b/drivers/iommu/iommu-sva-lib.c
>>>> @@ -69,3 +69,51 @@ struct mm_struct *iommu_sva_find(ioasid_t pasid)
>>>>    	return ioasid_find(&iommu_sva_pasid, pasid, __mmget_not_zero);
>>>>    }
>>>>    EXPORT_SYMBOL_GPL(iommu_sva_find);
>>>> +
>>>> +/*
>>>> + * IOMMU SVA driver-oriented interfaces
>>>> + */
>>>> +struct iommu_domain *
>>>> +iommu_sva_alloc_domain(struct bus_type *bus, struct mm_struct *mm)
>>> This should return the proper type
>>>
>>
>> Can you please elaborate a bit on "return the proper type"? Did you mean
>> return iommu_sva_domain instead? That's a wrapper of iommu_domain and
>> only for iommu internal usage.
> 
> If you are exposing special SVA APIs then it is not internal usage
> only anymore, so expose the type.

Ah, got you. Thanks for the explanation.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
