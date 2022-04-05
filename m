Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C5BEC433EF
	for <iommu@archiver.kernel.org>; Tue,  5 Apr 2022 01:38:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 03A414013D;
	Tue,  5 Apr 2022 01:38:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1rj4zQdhDa5U; Tue,  5 Apr 2022 01:38:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 06BBA4018E;
	Tue,  5 Apr 2022 01:38:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CC707C002C;
	Tue,  5 Apr 2022 01:38:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 95881C0012
 for <iommu@lists.linux-foundation.org>; Tue,  5 Apr 2022 01:38:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7BF6960F1C
 for <iommu@lists.linux-foundation.org>; Tue,  5 Apr 2022 01:38:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cIqEbWmgF-pa for <iommu@lists.linux-foundation.org>;
 Tue,  5 Apr 2022 01:38:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CDC5060C14
 for <iommu@lists.linux-foundation.org>; Tue,  5 Apr 2022 01:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1649122691; x=1680658691;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=YzdBJ3M54EZS3crIo7do3ZbrEz3YRHCmFK7qH0ZuUxM=;
 b=XVuNFtBeEvyapHFL+tyh0FWqvD7wIFR98PLRu+HxbLo6cMKsn2pGuwV6
 B37b1V4jQxCArtmbhJRmnX2Lc1hRbQ9BWMifP8CoAx82BerWQyGVZxwKC
 RqbaGPj0k7pQVw+DPRFMED5Dxw6trzweLXI4srKD2cDvWcwWD9VUEWluI
 /PNMQv6KrIXNafI3udNY4NA/9vkwXsguU8+xejl6oCqsTvbDYJ0Bpe8Gi
 joBwrMApeeLnlToG28uZT/8AYWRuxW0sc1iz3WGsQ1jwupygEk4umdCTJ
 EGTguRDhytmdShWvJCtwSG0ftszNdQeKo2/71iBaYjkfH8efxiMk39gJA A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="240581109"
X-IronPort-AV: E=Sophos;i="5.90,235,1643702400"; d="scan'208";a="240581109"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Apr 2022 18:38:10 -0700
X-IronPort-AV: E=Sophos;i="5.90,235,1643702400"; d="scan'208";a="569645614"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.211.208])
 ([10.254.211.208])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Apr 2022 18:38:08 -0700
Message-ID: <806562e6-04b0-9ad9-e3cc-45e0bc12335e@linux.intel.com>
Date: Tue, 5 Apr 2022 09:38:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] iommu/vt-d: remove unneeded validity check on dev
Content-Language: en-US
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>
References: <20220313150337.593650-1-usama.anjum@collabora.com>
 <ace47a96-4e43-697a-4cfe-04544f014940@collabora.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <ace47a96-4e43-697a-4cfe-04544f014940@collabora.com>
Cc: iommu@lists.linux-foundation.org, kernel@collabora.com,
 linux-kernel@vger.kernel.org
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

On 2022/4/4 15:52, Muhammad Usama Anjum wrote:
> Any thoughts?

It looks good to me. I will queue it for v5.19.

Best regards,
baolu

> 
> On 3/13/22 8:03 PM, Muhammad Usama Anjum wrote:
>> dev_iommu_priv_get() is being used at the top of this function which
>> dereferences dev. Dev cannot be NULL after this. Remove the validity
>> check on dev and simplify the code.
>>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>>   drivers/iommu/intel/iommu.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index df5c62ecf942b..f79edbbd651a4 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -2502,7 +2502,7 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
>>   		}
>>   	}
>>   
>> -	if (dev && domain_context_mapping(domain, dev)) {
>> +	if (domain_context_mapping(domain, dev)) {
>>   		dev_err(dev, "Domain context map failed\n");
>>   		dmar_remove_one_dev_info(dev);
>>   		return NULL;
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
