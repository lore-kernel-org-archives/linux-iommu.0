Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A6EC433F5
	for <iommu@archiver.kernel.org>; Sat,  9 Apr 2022 12:51:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4E17F41E09;
	Sat,  9 Apr 2022 12:51:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZChj3tPFGSgu; Sat,  9 Apr 2022 12:51:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E243F41E07;
	Sat,  9 Apr 2022 12:50:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BBD66C0033;
	Sat,  9 Apr 2022 12:50:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 96A97C002C
 for <iommu@lists.linux-foundation.org>; Sat,  9 Apr 2022 12:50:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 703FA60E5D
 for <iommu@lists.linux-foundation.org>; Sat,  9 Apr 2022 12:50:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yRPWirK8-gFI for <iommu@lists.linux-foundation.org>;
 Sat,  9 Apr 2022 12:50:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C7CB760E4A
 for <iommu@lists.linux-foundation.org>; Sat,  9 Apr 2022 12:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1649508657; x=1681044657;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=IzooKfKFcWaX9k+NhfOKyjJfqEy1HTI7gbsXol8gG7U=;
 b=WhYwbM7ki7OT+Yu2xT2mRscbkiYbaWiWJz9CJJ897L2ogH87RweRAG52
 4us+/wVZPbGvJxg/jUnwO94urdFX9igP30Uka5gB2KTXesQcoIfDTt9I2
 GtlvYKSW24MytgxKzJXfNJ7cJ6jfMvkmtsCVuMx/MRfER3jkiGvOU7ahu
 2E3fZzqR+TXjp/PSwmnBakUXNKBDKUOjD/KAsglwWSSXAomfTBrlUzFQQ
 /fUPE2kB0zP3WWS/758rlYEWDkzL7UC2kR8j2wXfDhdHeMp4kJ43vt5+G
 MUmWHJC+TSXl5qqm9HimZu6Zmo1n6QBIKqgNsMSCWiZaIuA3bs1fpGiKN w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10311"; a="261978085"
X-IronPort-AV: E=Sophos;i="5.90,247,1643702400"; d="scan'208";a="261978085"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2022 05:50:57 -0700
X-IronPort-AV: E=Sophos;i="5.90,247,1643702400"; d="scan'208";a="698639161"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.214.211])
 ([10.254.214.211])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2022 05:50:54 -0700
Message-ID: <8df77a0f-55ee-bbc3-8ada-ab109d9323eb@linux.intel.com>
Date: Sat, 9 Apr 2022 20:50:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 2/4] vfio: Move the Intel no-snoop control off of
 IOMMU_CACHE
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, David Woodhouse <dwmw2@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>
References: <0-v2-f090ae795824+6ad-intel_no_snoop_jgg@nvidia.com>
 <2-v2-f090ae795824+6ad-intel_no_snoop_jgg@nvidia.com>
 <BN9PR11MB5276796235136C1E6C50A5AF8CE99@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276796235136C1E6C50A5AF8CE99@BN9PR11MB5276.namprd11.prod.outlook.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

On 2022/4/8 16:16, Tian, Kevin wrote:
>> From: Jason Gunthorpe <jgg@nvidia.com>
>> Sent: Thursday, April 7, 2022 11:24 PM
>>
>> IOMMU_CACHE means "normal DMA to this iommu_domain's IOVA should
>> be cache
>> coherent" and is used by the DMA API. The definition allows for special
>> non-coherent DMA to exist - ie processing of the no-snoop flag in PCIe
>> TLPs - so long as this behavior is opt-in by the device driver.
>>
>> The flag is mainly used by the DMA API to synchronize the IOMMU setting
>> with the expected cache behavior of the DMA master. eg based on
>> dev_is_dma_coherent() in some case.
>>
>> For Intel IOMMU IOMMU_CACHE was redefined to mean 'force all DMA to
>> be
>> cache coherent' which has the practical effect of causing the IOMMU to
>> ignore the no-snoop bit in a PCIe TLP.
>>
>> x86 platforms are always IOMMU_CACHE, so Intel should ignore this flag.
>>
>> Instead use the new domain op enforce_cache_coherency() which causes
>> every
>> IOPTE created in the domain to have the no-snoop blocking behavior.
>>
>> Reconfigure VFIO to always use IOMMU_CACHE and call
>> enforce_cache_coherency() to operate the special Intel behavior.
>>
>> Remove the IOMMU_CACHE test from Intel IOMMU.
>>
>> Ultimately VFIO plumbs the result of enforce_cache_coherency() back into
>> the x86 platform code through kvm_arch_register_noncoherent_dma()
>> which
>> controls if the WBINVD instruction is available in the guest. No other
>> arch implements kvm_arch_register_noncoherent_dma().
>>
>> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> 
> btw as discussed in last version it is not necessarily to recalculate
> snoop control globally with this new approach. Will follow up to
> clean it up after this series is merged.

Agreed. But it also requires the enforce_cache_coherency() to be called
only after domain being attached to a device just as VFIO is doing.

Anyway, for this change in iommu/vt-d:

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
