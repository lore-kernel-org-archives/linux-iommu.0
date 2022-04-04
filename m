Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93A76C433EF
	for <iommu@archiver.kernel.org>; Mon,  4 Apr 2022 06:09:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 20F8C408E0;
	Mon,  4 Apr 2022 06:09:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SxvE3Hj1EG0E; Mon,  4 Apr 2022 06:09:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id EABB8404C7;
	Mon,  4 Apr 2022 06:09:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C14D8C001D;
	Mon,  4 Apr 2022 06:09:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F1B10C0012
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 06:09:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E0B5882965
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 06:09:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0V3ZN8cTuCFI for <iommu@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 06:09:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CF1DA8294A
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 06:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1649052587; x=1680588587;
 h=message-id:date:mime-version:cc:to:references:from:
 subject:in-reply-to:content-transfer-encoding;
 bh=QUwLd3VDyRAL/XsTJb4wHwKxOdZmbH7Juo3nCntr/mU=;
 b=YJPTZhDBV/CzIczZJycWZclucaPN/x42hkboodLf5O+CTPjmIYUMqq36
 v4v438SoCok9lWHnIrdkd8GTeZ+bN01oOynjlk/7uTUuimgsOIDxLc7s7
 MX9GtOVUnT3NQfTqSefe+9EKGjxvGzE3cJeCiuWmC0G+C+0FaOaGxk53b
 l5JM7hcOyOpno2Z5TyI64O+penBJbmCgKJ4RfvLCPuiU+sy1PT2vj2rRx
 b2JSNTgGIF1DGxueU/SinQGeX5NC9lNK3O8j1p9lsNhn+3Daydz6WCi20
 r37AWrE3jV79FsaE/bPBE17zmdFxJ6bs4hEok/jd/B6RAgs4xVX04m5dp g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10306"; a="285393684"
X-IronPort-AV: E=Sophos;i="5.90,233,1643702400"; d="scan'208";a="285393684"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2022 23:09:45 -0700
X-IronPort-AV: E=Sophos;i="5.90,233,1643702400"; d="scan'208";a="548536823"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.214.140])
 ([10.254.214.140])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2022 23:09:41 -0700
Message-ID: <9cac5d3b-3343-9e39-fe7b-3914d6b41a69@linux.intel.com>
Date: Mon, 4 Apr 2022 14:09:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>
References: <20220329053800.3049561-1-baolu.lu@linux.intel.com>
 <20220329053800.3049561-4-baolu.lu@linux.intel.com>
 <20220330190201.GB2120790@nvidia.com>
 <BN9PR11MB5276A39F481E2E31B0FCFEAE8CE39@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220402233210.GM2120790@nvidia.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH RFC v2 03/11] iommu/sva: Add iommu_domain type for SVA
In-Reply-To: <20220402233210.GM2120790@nvidia.com>
Cc: "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>, Robin Murphy <robin.murphy@arm.com>
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

Hi Jason and Kevin,

On 2022/4/3 7:32, Jason Gunthorpe wrote:
> On Sat, Apr 02, 2022 at 08:43:16AM +0000, Tian, Kevin wrote:
> 
>>> This assumes any domain is interchangeable with any device, which is
>>> not the iommu model. We need a domain op to check if a device is
>>> compatiable with the domain for vfio an iommufd, this should do the
>>> same.
>>
>> This suggests that mm_struct needs to include the format information
>> of the CPU page table so the format can be checked by the domain op?
> 
> No, Linux does not support multiple formats for CPU page tables,
> AFAICT, and creating the SVA domain in the first place should check
> this.
> 
>>> It means each mm can have a list of domains associated with it and a
>>> new domain is auto-created if the device doesn't work with any of the
>>> existing domains.
>>
>> mm has only one page table and one format. If a device is incompatible
>> with an existing domain wrapping that page table, how come creating
>> another domain could make it compatible?
> 
> Because domains wrap more than just the IOPTE format, they have
> additional data related to the IOMMU HW block itself. Imagine a SOC
> with two IOMMU HW blocks that can both process the CPU IOPTE format,
> but have different configuration.
> 
> So if device A users IOMMU A it needs an iommu_domain from driver A and
> same for another device B, even if both iommu_domains are thin
> wrappers around the same mm_struct.

How about below data structure design?

- [New]struct iommu_sva_ioas
  Represent the I/O address space shared with an application CPU address
  space. This structure has a 1:1 relationship with an mm_struct. It
  graps a "mm->mm_count" refcount during creation and drop it on release.

struct iommu_sva_ioas {
         struct mm_struct *mm;
         ioasid_t pasid;

         /* Counter of domains attached to this ioas. */
         refcount_t users;

         /* All bindings are linked here. */
         struct list_head bonds;
};

- [Enhance existing] struct iommu_domain (IOMMU_DOMAIN_SVA type)
  Represent a hardware pagetable that the IOMMU hardware could use for
  SVA translation. Multiple iommu domains could be bound with an SVA ioas
  and each graps a refcount from ioas in order to make sure ioas could
  only be freed after all domains have been unbound.

@@ -95,6 +101,7 @@ struct iommu_domain {
         void *handler_token;
         struct iommu_domain_geometry geometry;
         struct iommu_dma_cookie *iova_cookie;
+       struct iommu_sva_ioas *sva_ioas;
  };


- [Enhance existing] struct iommu_sva
   Represent a bond relationship between an SVA ioas and an iommu domain.
   If a bond already exists, it's reused and a reference is taken.

/**
  * struct iommu_sva - handle to a device-mm bond
  */
struct iommu_sva {
         struct device           *dev;
         struct iommu_sva_ioas   *sva_ioas;
         struct iommu_domain     *domain;
         /* Link to sva ioas's bonds list */
         struct list_head        node;
         refcount_t              users;
};

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
