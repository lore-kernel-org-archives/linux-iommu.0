Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEC85C433EF
	for <iommu@archiver.kernel.org>; Tue, 22 Mar 2022 05:49:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 88A4841687;
	Tue, 22 Mar 2022 05:49:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KHtdH6ywvaxy; Tue, 22 Mar 2022 05:49:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4C31941676;
	Tue, 22 Mar 2022 05:49:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 18A6BC0012;
	Tue, 22 Mar 2022 05:49:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 03804C000B
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 05:48:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D137B40332
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 05:48:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9s9FaWPEaliX for <iommu@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 05:48:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A1B6E400B8
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 05:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647928136; x=1679464136;
 h=message-id:date:mime-version:cc:to:references:from:
 subject:in-reply-to:content-transfer-encoding;
 bh=1SnuodTzmo2WR9Zf0tKGMtHe4Kb2aNMr0wspGadKIwY=;
 b=bHa0TFWukQqYDq1rZl2yBHbBO8XOZ09CdZ3f8nAsoRUPGtkkrxMhqndX
 yuPp4oFVnoyng6UqdQ8RFhZ/7RKt99wAFB/387Nh30dglWn17MFzkpS/u
 oMqqQsgyCPi89RIvuBCoUIUZx5KT58QKCoZPG+McxiDf6rRZ2/EV7RLpj
 ptzba96yMsphDgCg/Fj5VuTWQyW5+rhpAMcLqUL36tQRebwOoewru5pXP
 Sb5SOcG/6aiYNjcxyd0Kt5TlBNtgmGmOMbw60wPIa+gvkIcGBFx91r97G
 056OBiDPmZ6ZCkCKZoslVf9QnuPWx/mMkvozQ2U/kukyXz6rwqdNHP/wA Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="344159049"
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; d="scan'208";a="344159049"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Mar 2022 22:48:55 -0700
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; d="scan'208";a="560217417"
Received: from ellenyin-mobl.ccr.corp.intel.com (HELO [10.254.213.205])
 ([10.254.213.205])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Mar 2022 22:48:52 -0700
Message-ID: <45860360-4648-3f0b-6758-fe398aca4204@linux.intel.com>
Date: Tue, 22 Mar 2022 13:48:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
 <20220320064030.2936936-11-baolu.lu@linux.intel.com>
 <20220321125021.GQ11336@nvidia.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH RFC 10/11] iommu: Make IOPF handling framework generic
In-Reply-To: <20220321125021.GQ11336@nvidia.com>
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

On 2022/3/21 20:50, Jason Gunthorpe wrote:
> On Sun, Mar 20, 2022 at 02:40:29PM +0800, Lu Baolu wrote:
> 
>> +static enum iommu_page_response_code
>> +iommu_sva_handle_iopf(struct iommu_fault *fault, void *data)
>> +{
>> +	vm_fault_t ret;
>> +	struct mm_struct *mm;
>> +	struct vm_area_struct *vma;
>> +	unsigned int access_flags = 0;
>> +	struct iommu_domain *domain = data;
> 
> Why is the iommu_domain not passed in as a fully typed object? I would
> think data should some opaque value used by non-sva cases.

The "data" is set together with the fault handler when the caller
installs a fault handler for an iommu domain. We will add a generic
interface to install fault handler for an iommu domain later when a real
non-sva case comes.

> 
> What is the lifetime model here anyhow?

I simply thought that the device driver should guarantee that there are
no pending faults after sva_unbind(). This is insufficient. I need to
rework this.

> 
>> +	unsigned int fault_flags = FAULT_FLAG_REMOTE;
>> +	struct iommu_fault_page_request *prm = &fault->prm;
>> +	enum iommu_page_response_code status = IOMMU_PAGE_RESP_INVALID;
>> +
>> +	if (!(prm->flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID))
>> +		return status;
>> +
>> +	mm = domain->sva_cookie;
>> +	if (IS_ERR_OR_NULL(mm))
> 
> Do not use this function
> 
> Do not store err pointers in structs.

Sure.

> 
>> +out_put_mm:
>> +	mmap_read_unlock(mm);
>> +	mmput(mm);
> 
> mm structs are weird, they have two refcounts.
> 
> The 'sva_cookie' should hold a mmgrab/mmdrop() refcount to keep the
> pointer alive but to touch the mmap lock you have to upgrade it to a
> refcount that prevents destruction using mmget_not_zero() just for
> this short period.

Yes. Will look into it.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
