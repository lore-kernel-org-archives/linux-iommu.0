Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A002C433EF
	for <iommu@archiver.kernel.org>; Fri, 29 Apr 2022 06:35:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C9B1983F1E;
	Fri, 29 Apr 2022 06:35:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T2emeF2V-KOP; Fri, 29 Apr 2022 06:35:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B942E83F22;
	Fri, 29 Apr 2022 06:35:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 66C1CC0039;
	Fri, 29 Apr 2022 06:35:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0B111C002D
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 06:35:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EA572408D4
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 06:35:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nCNygldiUIBY for <iommu@lists.linux-foundation.org>;
 Fri, 29 Apr 2022 06:35:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A922C40734
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 06:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651214148; x=1682750148;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=73uaYpqAPQn+8U/LuREycvqXt3Sws/vKsehS795EZBw=;
 b=FoAgl1It2cGoyoVmYtAGJAN1ycW81YwWDhb9FlRozcwbl+v8vDRJz6l8
 OE1ChB4qGyHkY7EKL/9ppEnjil1DCNM21HwzTx2el94EmMOvT8DwymiEQ
 v3W6qKsXQJb2t/wv1eOYiDuqc7B+K04Or0vZCkLnW2JtVLdlGP6cYy4pR
 yE0/eXZJ6ZcQLj5fSix8/zdljbOKnzxa6MRa69iqDLzUS0WjzwAKNHZlk
 4dsst+8hpB5B3VetlUu9I9ASpGlsloLPkJ9o+/kL+ry1CpQHr2iPL3kYG
 IiwTzLg/qRmFU8VMaYgOZkK0ambzPT3pKg1WW+O0dvk5ylI81KpWzH6C5 w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="253933033"
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; d="scan'208";a="253933033"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2022 23:35:42 -0700
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; d="scan'208";a="581924572"
Received: from lye4-mobl.ccr.corp.intel.com (HELO [10.249.170.95])
 ([10.249.170.95])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2022 23:35:39 -0700
Message-ID: <d8682159-508b-501b-3642-54c8155a356d@linux.intel.com>
Date: Fri, 29 Apr 2022 14:35:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 11/12] iommu: Per-domain I/O page fault handling
Content-Language: en-US
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20220421052121.3464100-1-baolu.lu@linux.intel.com>
 <20220421052121.3464100-12-baolu.lu@linux.intel.com>
 <YmqrTGcHotvhhaT2@myrica>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <YmqrTGcHotvhhaT2@myrica>
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 iommu@lists.linux-foundation.org, Jacob jun Pan <jacob.jun.pan@intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Will Deacon <will@kernel.org>
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

On 2022/4/28 22:57, Jean-Philippe Brucker wrote:
> On Thu, Apr 21, 2022 at 01:21:20PM +0800, Lu Baolu wrote:
>>   static void iopf_handle_group(struct work_struct *work)
>>   {
>>   	struct iopf_group *group;
>> @@ -134,12 +78,23 @@ static void iopf_handle_group(struct work_struct *work)
>>   	group = container_of(work, struct iopf_group, work);
>>   
>>   	list_for_each_entry_safe(iopf, next, &group->faults, list) {
>> +		struct iommu_domain *domain;
>> +
>> +		domain = iommu_get_domain_for_dev_pasid_async(group->dev,
>> +				iopf->fault.prm.pasid);
> Reading the PCIe spec again (v6.0 10.4.1.1 PASID Usage), all faults within
> the group have the same PASID so we could move the domain fetch out of the
> loop. It does deviate from the old behavior, though, so we could change
> it later.

Perhaps we can add a pasid member in the struct iopf_group and do a
sanity check when a new iopf is added to the group? Here, we just fetch
the domain with group->pasid.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
