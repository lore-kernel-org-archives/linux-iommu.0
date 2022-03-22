Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2565BC433EF
	for <iommu@archiver.kernel.org>; Tue, 22 Mar 2022 04:31:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C567B40A9F;
	Tue, 22 Mar 2022 04:31:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BFRFdeNmipvP; Tue, 22 Mar 2022 04:31:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6A1DD400B8;
	Tue, 22 Mar 2022 04:31:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3A455C001A;
	Tue, 22 Mar 2022 04:31:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A1A28C000B
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 04:31:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8A00184353
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 04:31:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iQI18S558fO3 for <iommu@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 04:31:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2A4E484289
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 04:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647923507; x=1679459507;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=dsKJ5aYjOe1ElqEXDty5bKxW35OhOUL49tF3kSu1rOs=;
 b=eeQ+DqYXyYIpuHrCpHgC6FeIgqXsNPqnDSR+xk7yuCSaIYTBD2MwIyMV
 lhU35rleNOBBAFbfYcb+e6FvkVr44VPCO/3GSpnDcZl/POBPr4NPAR8CT
 yIdnxScoCkIfA5zQPh+LM62aDyVQsod9jRTbGS93kJpENtHmDsjGD6IyQ
 DykRK+X0b4wQUDad0PX17wpT6l4ipNFY1qgWm1gF1fCJLJVhaAqGSjNBQ
 81gtKqtSJS6GKuvzAgMkcsCZYnCeZaRo+rXHzBiLcMRS2g/bqiFQeNF7S
 aaabPNVsTJVGhVWebMmW4gu93YzhPxixM2E5JORNWywA69A+g9qnZolg3 A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="237661584"
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; d="scan'208";a="237661584"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Mar 2022 21:31:46 -0700
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; d="scan'208";a="518719355"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.209.186])
 ([10.254.209.186])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Mar 2022 21:31:41 -0700
Message-ID: <bdf294e5-b4ed-04dd-1c71-24fada7c9f3d@linux.intel.com>
Date: Tue, 22 Mar 2022 12:31:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH RFC 06/11] iommu/sva: Use attach/detach_pasid_dev in SVA
 interfaces
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
 <20220320064030.2936936-7-baolu.lu@linux.intel.com>
 <20220321120503.GN11336@nvidia.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20220321120503.GN11336@nvidia.com>
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

On 2022/3/21 20:05, Jason Gunthorpe wrote:
> On Sun, Mar 20, 2022 at 02:40:25PM +0800, Lu Baolu wrote:
> 
>> +/**
>> + * iommu_sva_bind_device() - Bind a process address space to a device
>> + * @dev: the device
>> + * @mm: the mm to bind, caller must hold a reference to it
>> + * @drvdata: opaque data pointer to pass to bind callback
>> + *
>> + * Create a bond between device and address space, allowing the device to access
>> + * the mm using the returned PASID. If a bond already exists between @device and
>> + * @mm, it is returned and an additional reference is taken. Caller must call
>> + * iommu_sva_unbind_device() to release each reference.
>> + *
>> + * iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA) must be called first, to
>> + * initialize the required SVA features.
>> + *
>> + * On error, returns an ERR_PTR value.
>> + */
>> +struct iommu_sva *
>> +iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void *drvdata)
> The drvdata is never used

Yes. It is cleaned up in Jacob's series.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
