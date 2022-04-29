Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 497CAC433F5
	for <iommu@archiver.kernel.org>; Fri, 29 Apr 2022 06:17:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DE16983F3C;
	Fri, 29 Apr 2022 06:17:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HX-8FiLWGFvs; Fri, 29 Apr 2022 06:17:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C172F83F4F;
	Fri, 29 Apr 2022 06:17:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 53D2DC007B;
	Fri, 29 Apr 2022 06:17:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 038B8C002D
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 06:17:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CEFE283F4F
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 06:17:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E4M4IeYRma6M for <iommu@lists.linux-foundation.org>;
 Fri, 29 Apr 2022 06:17:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 761A083F3C
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 06:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651213050; x=1682749050;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=Ti68k/z1JomTVPNNM6IUrCDfU5XGG1j6rnK5v6KWG4c=;
 b=PsQnDwGL8QFooOwFV7rca8s9unjOjiPr2vrgoZvk5J8aUE7x3S9+1Eaf
 mFRztCljRgWShZOx2Q2GSjs9RGdtIiB6a3TWjdksmN/rQ/7D5tPi+iouZ
 HLvzM/AKxValdaprNEE6qFFwmlPlRRBZLh4mj9k0+sCraibWote8pymR2
 bw0Bd+CX3h8jmod32kRlkVFx1N3REX8g90f/q3A7j+xkmVeMtCCiyJjLn
 c9xXsabpEmxI7Rr63kHyasdnMaI+uHJrL5kxZeNSk4v40jazvkZpz0hCv
 7OSiPYXjIN1RwN3jqnnAdLf3A3Bz3ufvZVJKYK290oWL0L9bwRJGcinxL w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="329487854"
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; d="scan'208";a="329487854"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2022 23:17:28 -0700
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; d="scan'208";a="581917186"
Received: from lye4-mobl.ccr.corp.intel.com (HELO [10.249.170.95])
 ([10.249.170.95])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2022 23:17:25 -0700
Message-ID: <dfe247b5-10d9-75d7-b742-28be910b5fb2@linux.intel.com>
Date: Fri, 29 Apr 2022 14:17:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 10/12] iommu: Prepare IOMMU domain for IOPF
Content-Language: en-US
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20220421052121.3464100-1-baolu.lu@linux.intel.com>
 <20220421052121.3464100-11-baolu.lu@linux.intel.com>
 <YmqpGFzMZn7ZMzsQ@myrica>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <YmqpGFzMZn7ZMzsQ@myrica>
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

Hi Jean,

On 2022/4/28 22:47, Jean-Philippe Brucker wrote:
> Hi Baolu,
> 
> On Thu, Apr 21, 2022 at 01:21:19PM +0800, Lu Baolu wrote:
>> +/*
>> + * Get the attached domain for asynchronous usage, for example the I/O
>> + * page fault handling framework. The caller get a reference counter
>> + * of the domain automatically on a successful return and should put
>> + * it with iommu_domain_put() after usage.
>> + */
>> +struct iommu_domain *
>> +iommu_get_domain_for_dev_pasid_async(struct device *dev, ioasid_t pasid)
>> +{
>> +	struct iommu_domain *domain;
>> +	struct iommu_group *group;
>> +
>> +	if (!pasid_valid(pasid))
>> +		return NULL;
>> +
>> +	group = iommu_group_get(dev);
>> +	if (!group)
>> +		return NULL;
>> +
>> +	mutex_lock(&group->mutex);
> 
> There is a possible deadlock between unbind() and the fault handler:
> 
>   unbind()                            iopf_handle_group()
>    mutex_lock(&group->mutex)
>    iommu_detach_device_pasid()
>     iopf_queue_flush_dev()             iommu_get_domain_for_dev_pasid_async()
>      ... waits for IOPF work            mutex_lock(&group->mutex)
> 

Yes, really.

> I was wrong in my previous review: we do have a guarantee that the SVA
> domain does not go away during IOPF handling, because unbind() waits for
> pending faults with iopf_queue_flush_dev() before freeing the domain (or
> for Arm stall, knows that there are no pending faults). So we can just get
> rid of domain->async_users and the group->mutex in IOPF, I think?

Agreed with you. The Intel code does the same thing in its unbind().

Thus, the sva domain's life cycle has already synchronized with IOPF
handling, there's no need for domain->async.

I will drop it in the next version. Thanks you!

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
