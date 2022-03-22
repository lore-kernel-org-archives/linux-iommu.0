Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A2ECC433F5
	for <iommu@archiver.kernel.org>; Tue, 22 Mar 2022 00:54:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E7BA360FF1;
	Tue, 22 Mar 2022 00:54:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aRl2kQT3Wtb6; Tue, 22 Mar 2022 00:54:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B113460FE8;
	Tue, 22 Mar 2022 00:54:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 913E9C0012;
	Tue, 22 Mar 2022 00:54:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B909BC000B
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 00:54:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 94412610C5
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 00:54:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id alyRgieDmImf for <iommu@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 00:54:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0319C60FF1
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 00:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647910450; x=1679446450;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=25WEx/VI04GLdRJN6w8aNF3alk3XvOfUYr/ih2ArDWI=;
 b=cSjrXDauiW+ceMIN81nNooCbLIq9yPp93W5FWnvF77p/nlIM8DbX/Qhx
 gcmFu7yMFmVJhUKeWCAD4ROyacuzko/u3dpl5BuizriiHBQqCr95wirJx
 LScBuC4MyVLp5aTepu3HdHrQpCZBmXsAFxYB1NQ2c9cx3TE/lmhaqfmrM
 olzh7FZuXIMmiqfO/xVNhe9aWC+I5yFGOcMv22s1t4kYTn1k98cr9rl4u
 OnyFsALoW2MBApeR7PDf6/Q3spJhdYru/yxK20s6gBs/b66XDo7VqKnYW
 9tTq1IFJGL0jHmnXCazBN+pWTOzTDJNy8qvEXpyUIxNegXpDOEu6JlAB/ w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="257404741"
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; d="scan'208";a="257404741"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Mar 2022 17:54:09 -0700
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; d="scan'208";a="560121532"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.208.85])
 ([10.254.208.85])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Mar 2022 17:54:05 -0700
Message-ID: <355235cb-1fe9-cdd5-45a5-3105aead417d@linux.intel.com>
Date: Tue, 22 Mar 2022 08:54:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH RFC 02/11] iommu: Add iommu_domain type for SVA
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
 <20220320064030.2936936-3-baolu.lu@linux.intel.com>
 <20220321114745.GI11336@nvidia.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20220321114745.GI11336@nvidia.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 iommu@lists.linux-foundation.org, Jacob jun Pan <jacob.jun.pan@intel.com>,
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

On 2022/3/21 19:47, Jason Gunthorpe wrote:
> On Sun, Mar 20, 2022 at 02:40:21PM +0800, Lu Baolu wrote:
>> Add a new iommu domain type IOMMU_DOMAIN_SVA to represent an I/O page
>> table which is shared from CPU host VA. Add a sva_cookie field in the
>> iommu_domain structure to save the mm_struct which represent the CPU
>> memory page table.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>>   include/linux/iommu.h | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index 36f43af0af53..3e179b853380 100644
>> +++ b/include/linux/iommu.h
>> @@ -64,6 +64,9 @@ struct iommu_domain_geometry {
>>   #define __IOMMU_DOMAIN_PT	(1U << 2)  /* Domain is identity mapped   */
>>   #define __IOMMU_DOMAIN_DMA_FQ	(1U << 3)  /* DMA-API uses flush queue    */
>>   
>> +#define __IOMMU_DOMAIN_SHARED	(1U << 4)  /* Page table shared from CPU  */
>> +#define __IOMMU_DOMAIN_HOST_VA	(1U << 5)  /* Host CPU virtual address */
>> +
>>   /*
>>    * This are the possible domain-types
>>    *
>> @@ -86,6 +89,8 @@ struct iommu_domain_geometry {
>>   #define IOMMU_DOMAIN_DMA_FQ	(__IOMMU_DOMAIN_PAGING |	\
>>   				 __IOMMU_DOMAIN_DMA_API |	\
>>   				 __IOMMU_DOMAIN_DMA_FQ)
>> +#define IOMMU_DOMAIN_SVA	(__IOMMU_DOMAIN_SHARED |	\
>> +				 __IOMMU_DOMAIN_HOST_VA)
> 
> Is there any use for this in the core code? I feel like flags should
> only be created if the core code needs to test them in some way.

flags are some attributes of the domain and the combination of multiple
flags forms a domain type.

> 
>> @@ -95,6 +100,7 @@ struct iommu_domain {
>>   	void *handler_token;
>>   	struct iommu_domain_geometry geometry;
>>   	struct iommu_dma_cookie *iova_cookie;
>> +	struct mm_struct *sva_cookie;
> 
> Don't call a mm_struct a cookie please

Sure.

> 
> And why do we need this in core code?

Need to connect an SVA domain with mm.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
