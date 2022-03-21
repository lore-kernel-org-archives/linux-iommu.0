Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8F1DC433F5
	for <iommu@archiver.kernel.org>; Mon, 21 Mar 2022 11:01:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 54325410C4;
	Mon, 21 Mar 2022 11:01:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0EX1-UYb70Uf; Mon, 21 Mar 2022 11:01:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2AF80410DC;
	Mon, 21 Mar 2022 11:01:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D7479C0012;
	Mon, 21 Mar 2022 11:01:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3EA16C000B
 for <iommu@lists.linux-foundation.org>; Mon, 21 Mar 2022 11:01:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2C633608A5
 for <iommu@lists.linux-foundation.org>; Mon, 21 Mar 2022 11:01:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OLmrnUAJGGvQ for <iommu@lists.linux-foundation.org>;
 Mon, 21 Mar 2022 11:01:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A0923605AC
 for <iommu@lists.linux-foundation.org>; Mon, 21 Mar 2022 11:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647860511; x=1679396511;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=STU6cY35f0Ar5xQ71SnPMC7cF7hVD3maLrZFmxx4A+8=;
 b=jrnOz7aHPQ2ZslXg1e4FeCNXO7vfvyIjzEILP5BJLqak4EN/gyVeLdVD
 PuzkRiW1l8KFlA8gkaJ50grYnC7AfPRmkOlHwqQNZmcJ61NmmDCuHmZQo
 uxWLncD4oQeOn2eKTu8a0tF5KEnj9swWjz4BIRn4UreaIyyJsrxOBmaSg
 nqbbjF2vQbSX9BtU+pXeqmae2hDt/XdFU9XsyQ2SWT6PfEAmG2m169x1n
 6ixKZf7xtaqBWET14A61V/PosEfFXqD6u+NRUkM7AqkriBd2ItmnH0SWo
 sGuHJZpUoUpvN2wv8Nxnr6Akr9dzTbw4qRiwW98ocemMJO5rlyJwDucA5 g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10292"; a="343952471"
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; d="scan'208";a="343952471"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Mar 2022 04:01:50 -0700
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; d="scan'208";a="559819619"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.213.169])
 ([10.254.213.169])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Mar 2022 04:01:47 -0700
Message-ID: <ec863d22-b79c-2e50-5897-7f1ab5381e44@linux.intel.com>
Date: Mon, 21 Mar 2022 19:01:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH RFC 06/11] iommu/sva: Use attach/detach_pasid_dev in SVA
 interfaces
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
References: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
 <20220320064030.2936936-7-baolu.lu@linux.intel.com>
 <BL1PR11MB52714F57E430FCBE97DDAB478C169@BL1PR11MB5271.namprd11.prod.outlook.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <BL1PR11MB52714F57E430FCBE97DDAB478C169@BL1PR11MB5271.namprd11.prod.outlook.com>
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

On 2022/3/21 16:04, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Sunday, March 20, 2022 2:40 PM
>> +struct iommu_sva *
>> +iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void
>> *drvdata)
>> +{
>> +	int ret = -EINVAL;
>> +	struct iommu_sva *handle;
>> +	struct iommu_domain *domain;
>> +
>> +	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
>> +	if (!handle)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	ret = iommu_sva_alloc_pasid(mm, 1, (1U << dev->iommu->pasid_bits)
>> - 1);
>> +	if (ret)
>> +		goto out;
>> +
>> +	domain = iommu_sva_domain_alloc(dev);
>> +	if (!domain) {
>> +		ret = -ENOMEM;
>> +		goto out;
>> +	}
>> +	domain->sva_cookie = mm;
> 
> one domain can be attached by multiple devices, so this should not be
> a blind alloc.

Indeed. Perhaps we could associate the SVA domain with the mm->pasid and
add a user counter inside the domain.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
