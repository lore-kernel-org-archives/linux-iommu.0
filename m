Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC183C433EF
	for <iommu@archiver.kernel.org>; Wed,  4 May 2022 08:48:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7292B60E33;
	Wed,  4 May 2022 08:48:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JB6wNXbMyfpI; Wed,  4 May 2022 08:48:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5372E60C2A;
	Wed,  4 May 2022 08:48:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 36134C0039;
	Wed,  4 May 2022 08:48:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D0F78C0032
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 08:48:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B06F24049F
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 08:48:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g9iNoy_Yze3A for <iommu@lists.linux-foundation.org>;
 Wed,  4 May 2022 08:48:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1E55940004
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 08:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651654082; x=1683190082;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=kRAxXFRDE1RfRdjz1uNhLBx4H2p9vLqfF7AlX0j83pA=;
 b=kYymemlJ9ZB/TKXGQtdpD1iTTJawcgzANktqcCe30f8wVDISZjqOgCRD
 0rxua6Bg/bJH5O6HZfkWBsFv9p7LktVf8bxywFUXrG5vhLJgq0yQCOLVL
 8n/XbgXfulQBJCZwUhGaz6CWcutwVq8MSjYH4jbgH9V+8zOMNvXocu4/Q
 9q0owzXKqTpB3N+vj7Pj5htDpU4I72TCL9jkz6LwY0sby+N9XQxtThaK7
 rd4Gy1F1TOcukh65Vio221tEeD+x0/W7fU7lDMqxOb36sJXTAuMG30yoN
 BLRvFgJ9vLDIYfZ7w5Yl1HDSaQ4GN/gT1vMfVBYRISMU4TMU6/saN1KwO g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="267859401"
X-IronPort-AV: E=Sophos;i="5.91,197,1647327600"; d="scan'208";a="267859401"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 May 2022 01:47:59 -0700
X-IronPort-AV: E=Sophos;i="5.91,197,1647327600"; d="scan'208";a="734304227"
Received: from yanc1-mobl.ccr.corp.intel.com (HELO [10.255.30.223])
 ([10.255.30.223])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 May 2022 01:47:56 -0700
Message-ID: <d42cba21-049d-0f0a-f030-60e1609fc4c3@linux.intel.com>
Date: Wed, 4 May 2022 16:47:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 4/5] iommu/vt-d: Remove domain_update_iommu_snooping()
Content-Language: en-US
To: Jacob Pan <jacob.jun.pan@intel.com>
References: <20220501112434.874236-1-baolu.lu@linux.intel.com>
 <20220501112434.874236-5-baolu.lu@linux.intel.com>
 <20220502143603.4143dd66@jacob-builder>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220502143603.4143dd66@jacob-builder>
Cc: Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>
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

On 2022/5/3 05:36, Jacob Pan wrote:
> Hi BaoLu,
> 
> On Sun, 1 May 2022 19:24:33 +0800, Lu Baolu <baolu.lu@linux.intel.com>
> wrote:
> 
>> The IOMMU force snooping capability is not required to be consistent
>> among all the IOMMUs anymore. Remove force snooping capability check
>> in the IOMMU hot-add path and domain_update_iommu_snooping() becomes
>> a dead code now.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel/iommu.c | 34 +---------------------------------
>>   1 file changed, 1 insertion(+), 33 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index 3c1c228f9031..d5808495eb64 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -533,33 +533,6 @@ static void domain_update_iommu_coherency(struct
>> dmar_domain *domain) rcu_read_unlock();
>>   }
>>   
>> -static bool domain_update_iommu_snooping(struct intel_iommu *skip)
>> -{
>> -	struct dmar_drhd_unit *drhd;
>> -	struct intel_iommu *iommu;
>> -	bool ret = true;
>> -
>> -	rcu_read_lock();
>> -	for_each_active_iommu(iommu, drhd) {
>> -		if (iommu != skip) {
>> -			/*
>> -			 * If the hardware is operating in the scalable
>> mode,
>> -			 * the snooping control is always supported
>> since we
>> -			 * always set PASID-table-entry.PGSNP bit if the
>> domain
>> -			 * is managed outside (UNMANAGED).
>> -			 */
>> -			if (!sm_supported(iommu) &&
>> -			    !ecap_sc_support(iommu->ecap)) {
>> -				ret = false;
>> -				break;
>> -			}
>> -		}
>> -	}
>> -	rcu_read_unlock();
>> -
>> -	return ret;
>> -}
>> -
>>   static int domain_update_iommu_superpage(struct dmar_domain *domain,
>>   					 struct intel_iommu *skip)
>>   {
>> @@ -3593,12 +3566,7 @@ static int intel_iommu_add(struct dmar_drhd_unit
>> *dmaru) iommu->name);
>>   		return -ENXIO;
>>   	}
>> -	if (!ecap_sc_support(iommu->ecap) &&
>> -	    domain_update_iommu_snooping(iommu)) {
>> -		pr_warn("%s: Doesn't support snooping.\n",
>> -			iommu->name);
>> -		return -ENXIO;
>> -	}
>> +
> Maybe I missed earlier patches, so this bit can also be deleted?
> 
> struct dmar_domain {
> 	u8 iommu_snooping: 1;		/* indicate snooping control
> feature */

It has been cleaned up by below commit:

71cfafda9c9b vfio: Move the Intel no-snoop control off of IOMMU_CACHE

> 
>>   	sp = domain_update_iommu_superpage(NULL, iommu) - 1;
>>   	if (sp >= 0 && !(cap_super_page_val(iommu->cap) & (1 << sp))) {
>>   		pr_warn("%s: Doesn't support large page.\n",
> 
> 
> Thanks,
> 
> Jacob

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
