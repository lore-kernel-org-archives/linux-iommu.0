Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28776C433EF
	for <iommu@archiver.kernel.org>; Tue, 15 Feb 2022 05:47:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B976882AAA;
	Tue, 15 Feb 2022 05:47:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8S2sCyDppKCC; Tue, 15 Feb 2022 05:47:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C86AC82862;
	Tue, 15 Feb 2022 05:47:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A8F61C0011;
	Tue, 15 Feb 2022 05:47:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D1AEBC000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Feb 2022 05:47:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AE6D160E52
 for <iommu@lists.linux-foundation.org>; Tue, 15 Feb 2022 05:47:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f5h8GcNEWB1t for <iommu@lists.linux-foundation.org>;
 Tue, 15 Feb 2022 05:47:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1AFCE60DFE
 for <iommu@lists.linux-foundation.org>; Tue, 15 Feb 2022 05:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644904060; x=1676440060;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=FB4ZrG+H6kHcJlMBI4utm8Pv+AllaomNjuD3vYEkBkw=;
 b=Ju3TRaMl3fSf5WDriwoq+oQWgOdmwPBLBEM/X22I0ZDHNkgiWiYCVwRg
 Q8uupj4vgQ+xEA8FUKWZVcShyotGpXfM4sX2FLt9j1JNK+BQcP3BvOq/4
 eXU3POzSK2/SGf6wrrS80Kdm2x0BCzqu9kpqciOAT0zRXLQqoOLrZTqQd
 +vm0U1SYgKMnzKVj9zXZNl5/SbMgGbH4QaO4pNrXMhW2JY80vjeHfkDoz
 h5L12OYqx5rIT66y0534yOpjuAHr+VQKtLwCct00JodP29/jkTmhrrzIh
 oIm19H9LgDtDaYN0FZk6nnCTe3E78RqlwiF0qGHAhgP0RM8bS+iP88yVz g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="313529374"
X-IronPort-AV: E=Sophos;i="5.88,369,1635231600"; d="scan'208";a="313529374"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Feb 2022 21:47:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,369,1635231600"; d="scan'208";a="680850350"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 14 Feb 2022 21:47:36 -0800
Message-ID: <b8420944-03ec-e426-e1fa-789b17604686@linux.intel.com>
Date: Tue, 15 Feb 2022 13:46:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 10/11] iommu/vt-d: Use xarray for global
 device_domain_info
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20220214025704.3184654-1-baolu.lu@linux.intel.com>
 <20220214025704.3184654-11-baolu.lu@linux.intel.com>
 <20220214140038.GB4160@nvidia.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20220214140038.GB4160@nvidia.com>
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

Hi Jason,

On 2/14/22 10:00 PM, Jason Gunthorpe wrote:
>> +
>> +/* Convert device source ID into the index of device_domain_array. */
>> +static inline unsigned long devi_idx(unsigned long seg, u8 bus, u8 devfn)
>> +{
>> +	return (seg << 16) | PCI_DEVID(bus, devfn);
>> +}
>>   
>>   /*
>> - * Iterate over elements in device_domain_list and call the specified
>> + * Iterate over elements in device_domain_array and call the specified
>>    * callback @fn against each element.
>>    */
>>   int for_each_device_domain(int (*fn)(struct device_domain_info *info,
>>   				     void *data), void *data)
>>   {
>> -	int ret = 0;
>> -	unsigned long flags;
>>   	struct device_domain_info *info;
>> +	unsigned long index;
>> +	int ret = 0;
>>   
>> -	spin_lock_irqsave(&device_domain_lock, flags);
>> -	list_for_each_entry(info, &device_domain_list, global) {
>> +	rcu_read_lock();
>> +	xa_for_each(&device_domain_array, index, info) {
>>   		ret = fn(info, data);
>> -		if (ret) {
>> -			spin_unlock_irqrestore(&device_domain_lock, flags);
>> -			return ret;
>> -		}
>> +		if (ret)
>> +			break;
> And you probably shouldn't try to use RCU. It is really unclear how
> this function can be useful while racing against
> intel_iommu_release_device(), eg today the only user of this function
> does:
> 
> static int search_pasid_table(struct device_domain_info *info, void *opaque)
> {
> 	struct pasid_table_opaque *data = opaque;
> 
> 	if (info->iommu->segment == data->segment &&
> 	    info->bus == data->bus &&
> 	    info->devfn == data->devfn &&
> 
> And even if you kfree_rcu(info) then 'info->iommu->' is still racy
> unlocked.
> 
> RCU is complicated to use, it is not just a drop in replacement for a
> spinlock.

Thanks for your comments. I am going to stop this patch (and the next
11/11) and spend more time figuring them out.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
