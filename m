Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E70BEC433F5
	for <iommu@archiver.kernel.org>; Tue, 17 May 2022 02:38:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7EE3240573;
	Tue, 17 May 2022 02:38:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id peexjU5bKWIq; Tue, 17 May 2022 02:38:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2C53F40408;
	Tue, 17 May 2022 02:38:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 04A53C0032;
	Tue, 17 May 2022 02:38:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 35ADAC002D
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 02:38:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2F7198191E
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 02:38:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mRkEzBxzZM0x for <iommu@lists.linux-foundation.org>;
 Tue, 17 May 2022 02:38:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6298C818EC
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 02:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652755083; x=1684291083;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=TvoRtaY2Mjgh/1gRlxU2MnLeVhFHFwlZKH+8DjiQySo=;
 b=P0UY6FVDRAZT/5NirVG32kAoPICNyxHVxUF0ndLw0zcprC5pXtaHLlTr
 W3qJYHNrAbDGkPW3rU9TTl8kcQgwzq3/A/WvH2xs9Kg5K+r8oGRLTLUyY
 2qSHujOOBKyYk2I5tI2gooMWmUk3r0tgPRBQPDDhHHFnQoz36SfC7ioO5
 5FAlqIK/buMvMaSIP/tNQmiwB3DSbm3hFKWJZ+CkSPmwxYIckHWfCRgRd
 mqu/GR0gmB6xVIPuVNLeJZyjYe0/7brsQ71D2544Kl05FMqr67Bf5Go35
 pxf44y3HKrGD5gwFEQ9M1PkQD+msv0DNXdLMYbCiPzwKK00EPMSXaN+DE A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="334074584"
X-IronPort-AV: E=Sophos;i="5.91,231,1647327600"; d="scan'208";a="334074584"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 May 2022 19:38:01 -0700
X-IronPort-AV: E=Sophos;i="5.91,231,1647327600"; d="scan'208";a="596859162"
Received: from ctang1-mobl.ccr.corp.intel.com (HELO [10.249.192.251])
 ([10.249.192.251])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 May 2022 19:37:57 -0700
Message-ID: <c8492b29-bc27-ae12-d5c4-9fbbc797e310@linux.intel.com>
Date: Tue, 17 May 2022 10:37:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/5] iommu: Add blocking_domain_ops field in iommu_ops
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, Robin Murphy <robin.murphy@arm.com>
References: <20220516015759.2952771-1-baolu.lu@linux.intel.com>
 <20220516015759.2952771-3-baolu.lu@linux.intel.com>
 <8a0fc6cf-f46e-f17e-2b76-099ada1683c3@arm.com>
 <20220516135741.GV1343366@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220516135741.GV1343366@nvidia.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Will Deacon <will@kernel.org>
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

On 2022/5/16 21:57, Jason Gunthorpe wrote:
> On Mon, May 16, 2022 at 12:22:08PM +0100, Robin Murphy wrote:
>> On 2022-05-16 02:57, Lu Baolu wrote:
>>> Each IOMMU driver must provide a blocking domain ops. If the hardware
>>> supports detaching domain from device, setting blocking domain equals
>>> detaching the existing domain from the deivce. Otherwise, an UNMANAGED
>>> domain without any mapping will be used instead.
>> Unfortunately that's backwards - most of the implementations of .detach_dev
>> are disabling translation entirely, meaning the device ends up effectively
>> in passthrough rather than blocked.
> Ideally we'd convert the detach_dev of every driver into either
> a blocking or identity domain. The trick is knowing which is which..

I am still a bit puzzled about how the blocking_domain should be used 
when it is extended to support ->set_dev_pasid.

If it's a blocking domain, the IOMMU driver knows that setting the
blocking domain to device pasid means detaching the existing one.

But if it's an identity domain, how could the IOMMU driver choose
between:

  - setting the input domain to the pasid on device; or,
  - detaching the existing domain.

I've ever thought about below solutions:

- Checking the domain types and dispatching them to different
   operations.
- Using different blocking domains for different types of domains.

But both look rough.

> 
> Guessing going down the list:
>   apple dart - blocking, detach_dev calls apple_dart_hw_disable_dma() same as
>                IOMMU_DOMAIN_BLOCKED
> 	      [I wonder if this drive ris wrong in other ways though because
>                 I dont see a remove_streams in attach_dev]
>   exynos - this seems to disable the 'sysmmu' so I'm guessing this is
>            identity
>   iommu-vmsa - Comment says 'disable mmu translaction' so I'm guessing
>                this is idenity
>   mkt_v1 - Code looks similar to mkt, which is probably identity.
>   rkt - No idea
>   sprd - No idea
>   sun50i - This driver confusingly treats identity the same as
>            unmanaged, seems wrong, no idea.
>   amd - Not sure, clear_dte_entry() seems to set translation on but points
>         the PTE to 0 ? Based on the spec table 8 I would have expected
>         TV to be clear which would be blocking. Maybe a bug??
>   arm smmu qcomm - not sure
>   intel - blocking
> 
> These doesn't support default domains, so detach_dev should return
> back to DMA API ownership, which is either identity or something weird:
>   fsl_pamu - identity due to the PPC use of dma direct
>   msm
>   mkt
>   omap
>   s390 - platform DMA ops
>   terga-gart - Usually something called a GART would be 0 length once
>                disabled, guessing blocking?
>   tegra-smmu
> 
> So, the approach here should be to go driver by driver and convert
> detach_dev to either identity, blocking or just delete it entirely,
> excluding the above 7 that don't support default domains. And get acks
> from the driver owners.
> 

Agreed. There seems to be a long way to go. I am wondering if we could
decouple this refactoring from my new SVA API work? We can easily switch
.detach_dev_pasid to using blocking domain later.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
