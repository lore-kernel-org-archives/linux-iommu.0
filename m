Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5523C433EF
	for <iommu@archiver.kernel.org>; Wed,  6 Apr 2022 13:37:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4C963832DB;
	Wed,  6 Apr 2022 13:37:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VBKC5JNDpck1; Wed,  6 Apr 2022 13:37:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1FA7F818A7;
	Wed,  6 Apr 2022 13:37:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0579CC001D;
	Wed,  6 Apr 2022 13:37:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D1DE7C0012
 for <iommu@lists.linux-foundation.org>; Wed,  6 Apr 2022 13:37:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AF57060A93
 for <iommu@lists.linux-foundation.org>; Wed,  6 Apr 2022 13:37:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n9e9jeNb8vxY for <iommu@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 13:37:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id B751160672
 for <iommu@lists.linux-foundation.org>; Wed,  6 Apr 2022 13:37:48 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D871F12FC;
 Wed,  6 Apr 2022 06:37:47 -0700 (PDT)
Received: from [10.57.41.19] (unknown [10.57.41.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE9363F73B;
 Wed,  6 Apr 2022 06:37:45 -0700 (PDT)
Message-ID: <b7639218-2d10-fd71-0f4b-3af3f8fa224b@arm.com>
Date: Wed, 6 Apr 2022 14:37:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH RFC v2 03/11] iommu/sva: Add iommu_domain type for SVA
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20220329053800.3049561-1-baolu.lu@linux.intel.com>
 <20220329053800.3049561-4-baolu.lu@linux.intel.com>
 <20220330190201.GB2120790@nvidia.com>
 <BN9PR11MB5276A39F481E2E31B0FCFEAE8CE39@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220402233210.GM2120790@nvidia.com>
 <BN9PR11MB527660D99D154F922B0A628B8CE79@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220406012334.GZ2120790@nvidia.com>
 <BN9PR11MB52764E3DE16E19D1F1515D008CE79@BN9PR11MB5276.namprd11.prod.outlook.com>
 <d0f6caea-0cd9-d839-c9fb-0fe49c2bad16@arm.com>
 <20220406130614.GC2120790@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220406130614.GC2120790@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>, Will Deacon <will@kernel.org>
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

On 2022-04-06 14:06, Jason Gunthorpe wrote:
> On Wed, Apr 06, 2022 at 01:32:07PM +0100, Robin Murphy wrote:
>> a particular IOMMU instance, and potentially allocate separate domains for
>> separate devices to represent the same address space, much like
>> vfio_iommu_type1_attach_group() does.
> 
> I think this VFIO code also needs some more work, it currently assumes
> that if the domain ops are the same then the domains are compatible,
> and that is not true for ARM SMMU drivers.

Well, strictly it uses the ops as a "negative" heuristic that the 
domains are not definitely incompatible, and only then consolidates 
domains if cross-attaching actually succeeds. So I don't think it's 
really so bad.

> I've been thinking of adding a domain callback 'can device attach' and
> replacing the ops compare with that instead.

Previous comment notwithstanding, much as I do tend to prefer "just try 
the operation and see what happens" APIs, that might be more reliable in 
the long run than trying to encode specific "sorry, you'll need to 
allocate a separate domain for this device" vs. "this should have worked 
but something went wrong" semantics in the return value from attach.

>> It's not really worth IOMMU drivers trying to support a domain spanning
>> potentially-heterogeneous instances internally, since they can't reasonably
>> know what matters in any particular situation.
> 
> In the long run I think it will be worth optimizing. If the SMMU
> instances can share IOPTE memory then we get two wins - memory
> reduction and reduced work to read dirty bits.
> 
> The dirty read in particular is very performance sensitive so if real
> work loads have many SMMUs per VM it will become a pain point.

In the ideal case though, the SVA domains are only there to logically 
bridge between an existing process pagetable and IOMMU instances at the 
API level, right? Surely if we're shadowing physical pagetables for SVA 
we've basically already lost the performance game?

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
