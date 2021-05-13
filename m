Return-Path: <SRS0=YXze=KI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF47C43460
	for <iommu@archiver.kernel.org>; Thu, 13 May 2021 03:07:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 549BB613F6
	for <iommu@archiver.kernel.org>; Thu, 13 May 2021 03:07:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 549BB613F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0F0CB84492;
	Thu, 13 May 2021 03:07:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 58uNTRYGW1fn; Thu, 13 May 2021 03:07:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id B74F683C8A;
	Thu, 13 May 2021 03:07:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9AFDBC000D;
	Thu, 13 May 2021 03:07:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F0ED9C0001
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 03:07:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C90EC40F8A
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 03:07:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id szRdmqNwyL6r for <iommu@lists.linux-foundation.org>;
 Thu, 13 May 2021 03:07:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E381B40F86
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 03:07:01 +0000 (UTC)
IronPort-SDR: uMgWWD7DqUWTGKh9hKI6KJ5E5EPre7W6rytTMDj644zYOweTTIh806CZBGsB9Q68IzDGbfY3z2
 2sKuxLLqQsgQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="220842985"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; d="scan'208";a="220842985"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2021 20:07:01 -0700
IronPort-SDR: WPygU0PGHIqUyfEL+qDio++f7cx4aQ9yZa/w7AdBcZG71qnp2iGkaTENlHO3EgaNNpWeP0JxXj
 xIX/IZ7bcdMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; d="scan'208";a="623085792"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128])
 ([10.239.159.128])
 by fmsmga006.fm.intel.com with ESMTP; 12 May 2021 20:06:58 -0700
Subject: Re: [RESEND PATACH 1/1] iommu/vt-d: Use user privilege for RID2PASID
 translation
To: "Raj, Ashok" <ashok.raj@intel.com>
References: <20210512064426.3440915-1-baolu.lu@linux.intel.com>
 <20210512170349.GB102348@otc-nc-03>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <3e1f61dd-2f1e-0b11-934a-b0dab2e52d65@linux.intel.com>
Date: Thu, 13 May 2021 11:06:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210512170349.GB102348@otc-nc-03>
Content-Language: en-US
Cc: kevin.tian@intel.com, sanjay.k.kumar@intel.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 jacob.jun.pan@intel.com, Will Deacon <will@kernel.org>
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

Hi Ashok,

On 5/13/21 1:03 AM, Raj, Ashok wrote:
> On Wed, May 12, 2021 at 02:44:26PM +0800, Lu Baolu wrote:
>> When first-level page tables are used for IOVA translation, we use user
>> privilege by setting U/S bit in the page table entry. This is to make it
>> consistent with the second level translation, where the U/S enforcement
>> is not available. Clear the SRE (Supervisor Request Enable) field in the
>> pasid table entry of RID2PASID so that requests requesting the supervisor
>> privilege are blocked and treated as DMA remapping faults.
>>
>> Suggested-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Fixes: b802d070a52a1 ("iommu/vt-d: Use iova over first level")
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel/iommu.c | 7 +++++--
>>   drivers/iommu/intel/pasid.c | 3 ++-
>>   2 files changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index 708f430af1c4..f1742da42478 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -2525,9 +2525,9 @@ static int domain_setup_first_level(struct intel_iommu *iommu,
>>   				    struct device *dev,
>>   				    u32 pasid)
>>   {
>> -	int flags = PASID_FLAG_SUPERVISOR_MODE;
>>   	struct dma_pte *pgd = domain->pgd;
>>   	int agaw, level;
>> +	int flags = 0;
>>   
>>   	/*
>>   	 * Skip top levels of page tables for iommu which has
>> @@ -2543,7 +2543,10 @@ static int domain_setup_first_level(struct intel_iommu *iommu,
>>   	if (level != 4 && level != 5)
>>   		return -EINVAL;
>>   
>> -	flags |= (level == 5) ? PASID_FLAG_FL5LP : 0;
>> +	if (pasid != PASID_RID2PASID)
>> +		flags |= PASID_FLAG_SUPERVISOR_MODE;
>> +	if (level == 5)
>> +		flags |= PASID_FLAG_FL5LP;
> 
> Given that we are still not bought into the supervisor PASID, should we make this an
> explicit request before turning on SUPERVISOR mode always? Since
> pasid_set_sre() has no return, we have no way to fail it.
> 

The supervisor PASID is now supported in VT-d implementation. This patch
is only for RID2PASID. We need a separated patch to remove the superisor
pasid code once we reach a consensus.

Does this work for you?

Best regards,
baolu

> 
>>   
>>   	if (domain->domain.type == IOMMU_DOMAIN_UNMANAGED)
>>   		flags |= PASID_FLAG_PAGE_SNOOP;
>> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
>> index 72646bafc52f..72dc84821dad 100644
>> --- a/drivers/iommu/intel/pasid.c
>> +++ b/drivers/iommu/intel/pasid.c
>> @@ -699,7 +699,8 @@ int intel_pasid_setup_second_level(struct intel_iommu *iommu,
>>   	 * Since it is a second level only translation setup, we should
>>   	 * set SRE bit as well (addresses are expected to be GPAs).
>>   	 */
>> -	pasid_set_sre(pte);
>> +	if (pasid != PASID_RID2PASID)
>> +		pasid_set_sre(pte);
>>   	pasid_set_present(pte);
>>   	pasid_flush_caches(iommu, pte, pasid, did);
>>   
>> -- 
>> 2.25.1
>>
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
