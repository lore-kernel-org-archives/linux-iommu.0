Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02696C433EF
	for <iommu@archiver.kernel.org>; Mon, 21 Mar 2022 10:23:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A485280D80;
	Mon, 21 Mar 2022 10:23:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lwDqRFhLQhVm; Mon, 21 Mar 2022 10:23:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 855EE8276B;
	Mon, 21 Mar 2022 10:23:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4B4CFC0012;
	Mon, 21 Mar 2022 10:23:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E4D99C000B
 for <iommu@lists.linux-foundation.org>; Mon, 21 Mar 2022 10:23:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D172C4034B
 for <iommu@lists.linux-foundation.org>; Mon, 21 Mar 2022 10:23:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LWqvf6Rcmlja for <iommu@lists.linux-foundation.org>;
 Mon, 21 Mar 2022 10:23:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 023C94014D
 for <iommu@lists.linux-foundation.org>; Mon, 21 Mar 2022 10:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647858193; x=1679394193;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=Y8pIweaAMyTCi93qGcfIHb2ZdfwxCLpe+KI0+IDSZLM=;
 b=W3wzWO5LJN/R4qQzBxTqe35c+RKJsvxGL8xjLxC87f3Ztsvt9kUrVwEW
 w11iMev/xKtnbLDEO1KOLHvM8M4Vu3XAiTk7qrXVfKrfF85tay/AD1BHw
 uHkSWcQav42ZT+nUVoFmelMPgvtQcIdgBdSbtDmOl8T8Qpdjqb+QBidex
 V+r4PQKQ9c+lKRaXe6iBCVCCX+gCDkXCTXFzVq3vcgyLs8v/ywDPyZjJp
 Hwa4AxNlAV7GsxTDXob23MsYduhz7b59Hqinp11IEiX3XZehPwPTHrohf
 UIjgBKNycU6XmlbGu3gdeTC82EBlvo1JY7r2nqSr49plr5uHQ3g+OL3qy A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10292"; a="257235822"
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; d="scan'208";a="257235822"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Mar 2022 03:23:12 -0700
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; d="scan'208";a="559805481"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.213.169])
 ([10.254.213.169])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Mar 2022 03:23:08 -0700
Message-ID: <4f9d5857-c16d-8201-00ea-28f0cb6bbaf8@linux.intel.com>
Date: Mon, 21 Mar 2022 18:23:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH RFC 02/11] iommu: Add iommu_domain type for SVA
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
References: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
 <20220320064030.2936936-3-baolu.lu@linux.intel.com>
 <BL1PR11MB5271E3ACDCB85F1CD92797B38C169@BL1PR11MB5271.namprd11.prod.outlook.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <BL1PR11MB5271E3ACDCB85F1CD92797B38C169@BL1PR11MB5271.namprd11.prod.outlook.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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

On 2022/3/21 15:06, Tian, Kevin wrote:
>> From: Lu Baolu<baolu.lu@linux.intel.com>
>> Sent: Sunday, March 20, 2022 2:40 PM
>>
>> Add a new iommu domain type IOMMU_DOMAIN_SVA to represent an I/O
>> page
>> table which is shared from CPU host VA. Add a sva_cookie field in the
>> iommu_domain structure to save the mm_struct which represent the CPU
>> memory page table.
>>
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>> ---
>>   include/linux/iommu.h | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index 36f43af0af53..3e179b853380 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -64,6 +64,9 @@ struct iommu_domain_geometry {
>>   #define __IOMMU_DOMAIN_PT	(1U << 2)  /* Domain is identity
>> mapped   */
>>   #define __IOMMU_DOMAIN_DMA_FQ	(1U << 3)  /* DMA-API uses
>> flush queue    */
>>
>> +#define __IOMMU_DOMAIN_SHARED	(1U << 4)  /* Page table shared from
>> CPU  */
>> +#define __IOMMU_DOMAIN_HOST_VA	(1U << 5)  /* Host CPU virtual
>> address */
> suppose the SHARED bit will be also used for KVM page table sharing and
> HOST_VA bit is to differentiate mm sharing from the latter?
> 

Yes, that's my intention.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
