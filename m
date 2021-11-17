Return-Path: <SRS0=sOBO=QE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A1CC433F5
	for <iommu@archiver.kernel.org>; Wed, 17 Nov 2021 05:26:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 891E561A0D
	for <iommu@archiver.kernel.org>; Wed, 17 Nov 2021 05:26:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 891E561A0D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 45B0B80F65;
	Wed, 17 Nov 2021 05:26:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m0vh-nEawZ9y; Wed, 17 Nov 2021 05:26:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 18F1C80EEE;
	Wed, 17 Nov 2021 05:26:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DADDDC001E;
	Wed, 17 Nov 2021 05:26:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3FE39C0012
 for <iommu@lists.linux-foundation.org>; Wed, 17 Nov 2021 05:26:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 19FDA40139
 for <iommu@lists.linux-foundation.org>; Wed, 17 Nov 2021 05:26:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id H3p-9_n0ZxWC for <iommu@lists.linux-foundation.org>;
 Wed, 17 Nov 2021 05:26:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 05182400F6
 for <iommu@lists.linux-foundation.org>; Wed, 17 Nov 2021 05:26:52 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10170"; a="257647743"
X-IronPort-AV: E=Sophos;i="5.87,240,1631602800"; d="scan'208";a="257647743"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2021 21:26:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,240,1631602800"; d="scan'208";a="494772632"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by orsmga007.jf.intel.com with ESMTP; 16 Nov 2021 21:26:46 -0800
Subject: Re: [PATCH 01/11] iommu: Add device dma ownership set/release
 interfaces
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20211115020552.2378167-1-baolu.lu@linux.intel.com>
 <20211115020552.2378167-2-baolu.lu@linux.intel.com>
 <YZJdJH4AS+vm0j06@infradead.org>
 <cc7ce6f4-b1ec-49ef-e245-ab6c330154c2@linux.intel.com>
 <20211116134603.GA2105516@nvidia.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <d79acc01-eeaf-e6ac-0415-af498c355a00@linux.intel.com>
Date: Wed, 17 Nov 2021 13:22:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211116134603.GA2105516@nvidia.com>
Content-Language: en-US
Cc: Kevin Tian <kevin.tian@intel.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Ashok Raj <ashok.raj@intel.com>, kvm@vger.kernel.org, rafael@kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Cornelia Huck <cohuck@redhat.com>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jacob jun Pan <jacob.jun.pan@intel.com>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Diana Craciun <diana.craciun@oss.nxp.com>
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

On 11/16/21 9:46 PM, Jason Gunthorpe wrote:
> On Tue, Nov 16, 2021 at 09:57:30AM +0800, Lu Baolu wrote:
>> Hi Christoph,
>>
>> On 11/15/21 9:14 PM, Christoph Hellwig wrote:
>>> On Mon, Nov 15, 2021 at 10:05:42AM +0800, Lu Baolu wrote:
>>>> +enum iommu_dma_owner {
>>>> +	DMA_OWNER_NONE,
>>>> +	DMA_OWNER_KERNEL,
>>>> +	DMA_OWNER_USER,
>>>> +};
>>>> +
>>>
>>>> +	enum iommu_dma_owner dma_owner;
>>>> +	refcount_t owner_cnt;
>>>> +	struct file *owner_user_file;
>>>
>>> I'd just overload the ownership into owner_user_file,
>>>
>>>    NULL			-> no owner
>>>    (struct file *)1UL)	-> kernel
>>>    real pointer		-> user
>>>
>>> Which could simplify a lot of the code dealing with the owner.
>>>
>>
>> Yeah! Sounds reasonable. I will make this in the next version.
> 
> It would be good to figure out how to make iommu_attach_device()
> enforce no other driver binding as a kernel user without a file *, as
> Robin pointed to, before optimizing this.
> 
> This fixes an existing bug where iommu_attach_device() only checks the
> group size and is vunerable to a hot plug increasing the group size
> after it returns. That check should be replaced by this series's logic
> instead.

As my my understanding, the essence of this problem is that only the
user owner of the iommu_group could attach an UNMANAGED domain to it.
If I understand it right, how about introducing a new interface to
allocate a user managed domain and storing the user file pointer in it.

--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -94,6 +94,7 @@ struct iommu_domain {
         void *handler_token;
         struct iommu_domain_geometry geometry;
         struct iommu_dma_cookie *iova_cookie;
+       struct file *owner_user_file;
  };
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1902,6 +1902,18 @@ struct iommu_domain *iommu_domain_alloc(struct 
bus_type *bus)
  }
  EXPORT_SYMBOL_GPL(iommu_domain_alloc);

+struct iommu_domain *iommu_domain_alloc_user(struct bus_type *bus,
+                                            struct file *filep)
+{
+       struct iommu_domain *domain;
+
+       domain = __iommu_domain_alloc(bus, IOMMU_DOMAIN_UNMANAGED);
+       if (domain)
+               domain->owner_user_file = filep;
+
+       return domain;
+}

When attaching a domain to an user-owned iommu_group, both group and
domain should have matched user fd.

Does above help here?

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
