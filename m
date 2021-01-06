Return-Path: <SRS0=DPil=GJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 035B8C433DB
	for <iommu@archiver.kernel.org>; Wed,  6 Jan 2021 01:10:10 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C56922CAF
	for <iommu@archiver.kernel.org>; Wed,  6 Jan 2021 01:10:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C56922CAF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id D3C042045D;
	Wed,  6 Jan 2021 01:10:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q9SXcW4zJLbH; Wed,  6 Jan 2021 01:10:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 7D87A20353;
	Wed,  6 Jan 2021 01:10:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 66F90C0891;
	Wed,  6 Jan 2021 01:10:06 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3B950C013A
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jan 2021 01:10:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 1EEA1871E2
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jan 2021 01:10:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ObHfEltCNSrP for <iommu@lists.linux-foundation.org>;
 Wed,  6 Jan 2021 01:10:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 2FC9E871DF
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jan 2021 01:10:02 +0000 (UTC)
IronPort-SDR: P+KysHP2y0dv/W0Nwy6nI11ajPyDyBXbvVr03r6jIw6o/bOciBRpMr9HDYPMtF4JCDn+jcvl+p
 U/oj1ZJ5nXig==
X-IronPort-AV: E=McAfee;i="6000,8403,9855"; a="238759357"
X-IronPort-AV: E=Sophos;i="5.78,478,1599548400"; d="scan'208";a="238759357"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jan 2021 17:09:54 -0800
IronPort-SDR: D/qMZFJukaMzB+stYT74FeGsqKJB+iPFp9uDBBnxdJbYW5Oxhg2NVsAvegkfGHUzp3lC149Uk0
 iv49fvYJPVDA==
X-IronPort-AV: E=Sophos;i="5.78,478,1599548400"; d="scan'208";a="379089659"
Received: from jan-mobl.ccr.corp.intel.com (HELO [10.255.29.66])
 ([10.255.29.66])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jan 2021 17:09:52 -0800
To: Will Deacon <will@kernel.org>
References: <20201231005323.2178523-1-baolu.lu@linux.intel.com>
 <20201231005323.2178523-2-baolu.lu@linux.intel.com>
 <20210105190357.GA12182@willie-the-truck>
From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 2/5] iommu/vt-d: Fix unaligned addresses for
 intel_flush_svm_range_dev()
Message-ID: <f8c7f124-48ab-f74f-a5cb-51b0ca4785ac@linux.intel.com>
Date: Wed, 6 Jan 2021 09:09:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210105190357.GA12182@willie-the-truck>
Content-Language: en-US
Cc: Ashok Raj <ashok.raj@intel.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Guo Kaijie <Kaijie.Guo@intel.com>
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

Hi Will,

Happy New Year!

On 2021/1/6 3:03, Will Deacon wrote:
> On Thu, Dec 31, 2020 at 08:53:20AM +0800, Lu Baolu wrote:
>> The VT-d hardware will ignore those Addr bits which have been masked by
>> the AM field in the PASID-based-IOTLB invalidation descriptor. As the
>> result, if the starting address in the descriptor is not aligned with
>> the address mask, some IOTLB caches might not invalidate. Hence people
>> will see below errors.
>>
>> [ 1093.704661] dmar_fault: 29 callbacks suppressed
>> [ 1093.704664] DMAR: DRHD: handling fault status reg 3
>> [ 1093.712738] DMAR: [DMA Read] Request device [7a:02.0] PASID 2
>>                 fault addr 7f81c968d000 [fault reason 113]
>>                 SM: Present bit in first-level paging entry is clear
>>
>> Fix this by using aligned address for PASID-based-IOTLB invalidation.
>>
>> Fixes: 1c4f88b7f1f92 ("iommu/vt-d: Shared virtual address in scalable mode")
>> Reported-and-tested-by: Guo Kaijie <Kaijie.Guo@intel.com>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel/svm.c | 22 ++++++++++++++++++++--
>>   1 file changed, 20 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
>> index 69566695d032..b16a4791acfb 100644
>> --- a/drivers/iommu/intel/svm.c
>> +++ b/drivers/iommu/intel/svm.c
>> @@ -118,8 +118,10 @@ void intel_svm_check(struct intel_iommu *iommu)
>>   	iommu->flags |= VTD_FLAG_SVM_CAPABLE;
>>   }
>>   
>> -static void intel_flush_svm_range_dev (struct intel_svm *svm, struct intel_svm_dev *sdev,
>> -				unsigned long address, unsigned long pages, int ih)
>> +static void __flush_svm_range_dev(struct intel_svm *svm,
>> +				  struct intel_svm_dev *sdev,
>> +				  unsigned long address,
>> +				  unsigned long pages, int ih)
>>   {
>>   	struct qi_desc desc;
>>   
>> @@ -170,6 +172,22 @@ static void intel_flush_svm_range_dev (struct intel_svm *svm, struct intel_svm_d
>>   	}
>>   }
>>   
>> +static void intel_flush_svm_range_dev(struct intel_svm *svm,
>> +				      struct intel_svm_dev *sdev,
>> +				      unsigned long address,
>> +				      unsigned long pages, int ih)
>> +{
>> +	unsigned long shift = ilog2(__roundup_pow_of_two(pages));
>> +	unsigned long align = (1ULL << (VTD_PAGE_SHIFT + shift));
>> +	unsigned long start = ALIGN_DOWN(address, align);
>> +	unsigned long end = ALIGN(address + (pages << VTD_PAGE_SHIFT), align);
>> +
>> +	while (start < end) {
>> +		__flush_svm_range_dev(svm, sdev, start, align >> VTD_PAGE_SHIFT, ih);
>> +		start += align;
>> +	}
>> +}
> 
> Given that this only seems to be called from intel_invalidate_range(), which
> has to compute 'pages' only to have it pulled apart again here, perhaps it
> would be cleaner for intel_flush_svm_range() to take something like an
> 'order' argument instead?
> 
> What do you think?

We need to clean up here. It's duplicate with the qi_flush_piotlb()
helper. I have a patch under testing for this. I will post it for review
later.

> 
> Will
> 

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
