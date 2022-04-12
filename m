Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A884C433EF
	for <iommu@archiver.kernel.org>; Tue, 12 Apr 2022 13:13:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EA3C040570;
	Tue, 12 Apr 2022 13:13:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9zzlS4fUvwVH; Tue, 12 Apr 2022 13:13:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C1BCA40189;
	Tue, 12 Apr 2022 13:13:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8F3F8C002F;
	Tue, 12 Apr 2022 13:13:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4867FC002C
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 13:13:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 368A240300
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 13:13:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jgMS7SiGTTkp for <iommu@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 13:13:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4A36240322
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 13:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1649769213; x=1681305213;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=XR4HOYE6zeHEFBL28l2IpgxCfioOEDYmeQaZWokwHR8=;
 b=jQqVWniUC+RRBQ1Tth9USwexi0mgYHERRNqXbs9WV9TZ0qa179FJtCae
 45G6xDtHPVuxnxjhrmEpUp2QVENvgW6hk8OtGLs4yT2XLCJ5/kzKk2fjV
 e0EjcrlNZ4A/yzGT1GkQGenaYGhaMnc0/ZHpKZm3b/QQBU0Dd2gNNRw84
 7+u5VvUq0/Rmt5UmBx0vKHrtCFixO8gzDPytk1XsBG7MUK1V5x7i3cbq5
 o5RWFBuYANppV9PzXqG3gmUxKRXPmoSeNtimH4NvOzXuyfZpUsMbDXNbm
 jj6jjEU6P0Y2jMDu6AAgHp9klUKR1ys2a2rCxiBAEGC6UnfEIpVXaYGN0 Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="348808577"
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; d="scan'208";a="348808577"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Apr 2022 06:13:32 -0700
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; d="scan'208";a="572759914"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.210.174])
 ([10.254.210.174])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Apr 2022 06:13:29 -0700
Message-ID: <a3b9d7f0-b7b9-ffdf-90c3-b216e1e19b35@linux.intel.com>
Date: Tue, 12 Apr 2022 21:13:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
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
 <8df77a0f-55ee-bbc3-8ada-ab109d9323eb@linux.intel.com>
 <BN9PR11MB5276FD53286C0181B4987C958CED9@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276FD53286C0181B4987C958CED9@BN9PR11MB5276.namprd11.prod.outlook.com>
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

On 2022/4/12 15:44, Tian, Kevin wrote:
>> From: Lu Baolu<baolu.lu@linux.intel.com>
>> Sent: Saturday, April 9, 2022 8:51 PM
>>
>> On 2022/4/8 16:16, Tian, Kevin wrote:
>>>> From: Jason Gunthorpe<jgg@nvidia.com>
>>>> Sent: Thursday, April 7, 2022 11:24 PM
>>>>
>>>> IOMMU_CACHE means "normal DMA to this iommu_domain's IOVA
>> should
>>>> be cache
>>>> coherent" and is used by the DMA API. The definition allows for special
>>>> non-coherent DMA to exist - ie processing of the no-snoop flag in PCIe
>>>> TLPs - so long as this behavior is opt-in by the device driver.
>>>>
>>>> The flag is mainly used by the DMA API to synchronize the IOMMU setting
>>>> with the expected cache behavior of the DMA master. eg based on
>>>> dev_is_dma_coherent() in some case.
>>>>
>>>> For Intel IOMMU IOMMU_CACHE was redefined to mean 'force all DMA
>> to
>>>> be
>>>> cache coherent' which has the practical effect of causing the IOMMU to
>>>> ignore the no-snoop bit in a PCIe TLP.
>>>>
>>>> x86 platforms are always IOMMU_CACHE, so Intel should ignore this flag.
>>>>
>>>> Instead use the new domain op enforce_cache_coherency() which causes
>>>> every
>>>> IOPTE created in the domain to have the no-snoop blocking behavior.
>>>>
>>>> Reconfigure VFIO to always use IOMMU_CACHE and call
>>>> enforce_cache_coherency() to operate the special Intel behavior.
>>>>
>>>> Remove the IOMMU_CACHE test from Intel IOMMU.
>>>>
>>>> Ultimately VFIO plumbs the result of enforce_cache_coherency() back into
>>>> the x86 platform code through kvm_arch_register_noncoherent_dma()
>>>> which
>>>> controls if the WBINVD instruction is available in the guest. No other
>>>> arch implements kvm_arch_register_noncoherent_dma().
>>>>
>>>> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>
>>> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
>>>
>>> btw as discussed in last version it is not necessarily to recalculate
>>> snoop control globally with this new approach. Will follow up to
>>> clean it up after this series is merged.
>> Agreed. But it also requires the enforce_cache_coherency() to be called
>> only after domain being attached to a device just as VFIO is doing.
> that actually makes sense, right? w/o device attached it's pointless to
> call that interface on a domain...

Agreed. Return -EOPNOTSUPP or -EINVAL to tell the caller that this
operation is invalid before any device attachment.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
