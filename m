Return-Path: <SRS0=1/OX=IR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98DD4C433E0
	for <iommu@archiver.kernel.org>; Fri, 19 Mar 2021 01:11:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ED2E64DE8
	for <iommu@archiver.kernel.org>; Fri, 19 Mar 2021 01:11:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ED2E64DE8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 94A2660615;
	Fri, 19 Mar 2021 01:11:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EL5f_6QcQSxG; Fri, 19 Mar 2021 01:11:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 71735605C7;
	Fri, 19 Mar 2021 01:11:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 56FF2C000B;
	Fri, 19 Mar 2021 01:11:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B878DC0001
 for <iommu@lists.linux-foundation.org>; Fri, 19 Mar 2021 01:11:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 93156400F2
 for <iommu@lists.linux-foundation.org>; Fri, 19 Mar 2021 01:11:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 89bWIzrqur3g for <iommu@lists.linux-foundation.org>;
 Fri, 19 Mar 2021 01:11:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D144B400D3
 for <iommu@lists.linux-foundation.org>; Fri, 19 Mar 2021 01:11:53 +0000 (UTC)
IronPort-SDR: p+UktEAqS6YbfDJ0vw8+UzmjvYtB9MzvRpgSq9aeCe3LcfWlElQNEnhpoHIlPn+AgkTTNsgqkQ
 XuhmxsAJ+lVA==
X-IronPort-AV: E=McAfee;i="6000,8403,9927"; a="189178097"
X-IronPort-AV: E=Sophos;i="5.81,259,1610438400"; d="scan'208";a="189178097"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2021 18:11:52 -0700
IronPort-SDR: x+MgqkNqPy2F2VFdTbXqhIBZxCpqoZXDNrbT1D/v6ToPMW9/OnawiGv09j1i/+jG7cgEe1zupQ
 FJSNjHJzK2Hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,259,1610438400"; d="scan'208";a="434078622"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128])
 ([10.239.159.128])
 by fmsmga004.fm.intel.com with ESMTP; 18 Mar 2021 18:11:48 -0700
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix lockdep splat in
 intel_pasid_get_entry()
To: Joerg Roedel <joro@8bytes.org>
References: <20210317005834.173503-1-baolu.lu@linux.intel.com>
 <YFMpmLNd73IVcgWq@8bytes.org>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <89f87115-32dc-205e-61e0-71de0d626303@linux.intel.com>
Date: Fri, 19 Mar 2021 09:02:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YFMpmLNd73IVcgWq@8bytes.org>
Content-Language: en-US
Cc: Dave Jiang <dave.jiang@intel.com>, iommu@lists.linux-foundation.org,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
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

Hi Joerg,

On 3/18/21 6:21 PM, Joerg Roedel wrote:
> On Wed, Mar 17, 2021 at 08:58:34AM +0800, Lu Baolu wrote:
>> The pasid_lock is used to synchronize different threads from modifying a
>> same pasid directory entry at the same time. It causes below lockdep splat.
>>
>> [   83.296538] ========================================================
>> [   83.296538] WARNING: possible irq lock inversion dependency detected
>> [   83.296539] 5.12.0-rc3+ #25 Tainted: G        W
>> [   83.296539] --------------------------------------------------------
>> [   83.296540] bash/780 just changed the state of lock:
>> [   83.296540] ffffffff82b29c98 (device_domain_lock){..-.}-{2:2}, at:
>>             iommu_flush_dev_iotlb.part.0+0x32/0x110
>> [   83.296547] but this lock took another, SOFTIRQ-unsafe lock in the past:
>> [   83.296547]  (pasid_lock){+.+.}-{2:2}
>> [   83.296548]
>>
>>             and interrupts could create inverse lock ordering between them.
>>
>> [   83.296549] other info that might help us debug this:
>> [   83.296549] Chain exists of:
>>                   device_domain_lock --> &iommu->lock --> pasid_lock
>> [   83.296551]  Possible interrupt unsafe locking scenario:
>>
>> [   83.296551]        CPU0                    CPU1
>> [   83.296552]        ----                    ----
>> [   83.296552]   lock(pasid_lock);
>> [   83.296553]                                local_irq_disable();
>> [   83.296553]                                lock(device_domain_lock);
>> [   83.296554]                                lock(&iommu->lock);
>> [   83.296554]   <Interrupt>
>> [   83.296554]     lock(device_domain_lock);
>> [   83.296555]
>>                  *** DEADLOCK ***
>>
>> Fix it by replacing the pasid_lock with an atomic exchange operation.
>>
>> Reported-and-tested-by: Dave Jiang <dave.jiang@intel.com>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel/pasid.c | 14 ++++++--------
>>   1 file changed, 6 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
>> index 9fb3d3e80408..1ddcb8295f72 100644
>> --- a/drivers/iommu/intel/pasid.c
>> +++ b/drivers/iommu/intel/pasid.c
>> @@ -24,7 +24,6 @@
>>   /*
>>    * Intel IOMMU system wide PASID name space:
>>    */
>> -static DEFINE_SPINLOCK(pasid_lock);
>>   u32 intel_pasid_max_id = PASID_MAX;
>>   
>>   int vcmd_alloc_pasid(struct intel_iommu *iommu, u32 *pasid)
>> @@ -259,19 +258,18 @@ struct pasid_entry *intel_pasid_get_entry(struct device *dev, u32 pasid)
>>   	dir_index = pasid >> PASID_PDE_SHIFT;
>>   	index = pasid & PASID_PTE_MASK;
>>   
>> -	spin_lock(&pasid_lock);
>>   	entries = get_pasid_table_from_pde(&dir[dir_index]);
>>   	if (!entries) {
>>   		entries = alloc_pgtable_page(info->iommu->node);
>> -		if (!entries) {
>> -			spin_unlock(&pasid_lock);
>> +		if (!entries)
>>   			return NULL;
>> -		}
>>   
>> -		WRITE_ONCE(dir[dir_index].val,
>> -			   (u64)virt_to_phys(entries) | PASID_PTE_PRESENT);
>> +		if (cmpxchg64(&dir[dir_index].val, 0ULL,
>> +			      (u64)virt_to_phys(entries) | PASID_PTE_PRESENT)) {
>> +			free_pgtable_page(entries);
>> +			entries = get_pasid_table_from_pde(&dir[dir_index]);
> 
> This is racy, someone could have already cleared the pasid-entry again.

This code modifies the pasid directory entry. The pasid directory
entries are allocated on demand and will never be freed.

> What you need to do here is to retry the whole path by adding a goto
> to before  the first get_pasid_table_from_pde() call.

Yes. Retrying by adding a goto makes the code clearer.

> 
> Btw, what makes sure that the pasid_entry does not go away when it is
> returned here?

As explained above, it handles the pasid directory table entry which
won't go away.

> 
> Regards,
> 
> 	Joerg
> 

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
