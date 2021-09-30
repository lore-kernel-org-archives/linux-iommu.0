Return-Path: <SRS0=YF8t=OU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB9EC433EF
	for <iommu@archiver.kernel.org>; Thu, 30 Sep 2021 13:44:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EF2261353
	for <iommu@archiver.kernel.org>; Thu, 30 Sep 2021 13:44:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5EF2261353
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1C0F840787;
	Thu, 30 Sep 2021 13:44:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bFZ-ia2q5sAY; Thu, 30 Sep 2021 13:44:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BF26940179;
	Thu, 30 Sep 2021 13:44:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A05B5C0011;
	Thu, 30 Sep 2021 13:44:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BD246C000D
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 13:44:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A0BD140760
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 13:44:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jWxX9EZLhn4w for <iommu@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 13:44:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E0B87400F0
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 13:44:13 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10122"; a="225265223"
X-IronPort-AV: E=Sophos;i="5.85,336,1624345200"; d="scan'208";a="225265223"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2021 06:44:11 -0700
X-IronPort-AV: E=Sophos;i="5.85,336,1624345200"; d="scan'208";a="564177724"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.214.141])
 ([10.254.214.141])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2021 06:44:00 -0700
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "Lu, Baolu" <baolu.lu@intel.com>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-11-yi.l.liu@intel.com>
 <20210922152407.1bfa6ff7.alex.williamson@redhat.com>
 <20210922234954.GB964074@nvidia.com>
 <BN9PR11MB543333AD3C81312115686AAA8CA39@BN9PR11MB5433.namprd11.prod.outlook.com>
 <YUxTvCt1mYDntO8z@myrica> <20210923112716.GE964074@nvidia.com>
 <BN9PR11MB5433BCFCF3B0CB657E9BFE898CA39@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210923122220.GL964074@nvidia.com>
 <BN9PR11MB5433F33CB7CFBCD41BE2F5C68CAA9@BN9PR11MB5433.namprd11.prod.outlook.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [RFC 10/20] iommu/iommufd: Add IOMMU_DEVICE_GET_INFO
Message-ID: <9a04c421-4a25-f1de-a896-321026b3f0ce@linux.intel.com>
Date: Thu, 30 Sep 2021 21:43:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <BN9PR11MB5433F33CB7CFBCD41BE2F5C68CAA9@BN9PR11MB5433.namprd11.prod.outlook.com>
Content-Language: en-US
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "hch@lst.de" <hch@lst.de>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "corbet@lwn.net" <corbet@lwn.net>, "parav@mellanox.com" <parav@mellanox.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "lkml@metux.net" <lkml@metux.net>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>, "Tian,
 Jun J" <jun.j.tian@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "lushenming@huawei.com" <lushenming@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>
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

On 2021/9/30 16:49, Tian, Kevin wrote:
>> From: Jason Gunthorpe <jgg@nvidia.com>
>> Sent: Thursday, September 23, 2021 8:22 PM
>>
>>>> These are different things and need different bits. Since the ARM path
>>>> has a lot more code supporting it, I'd suggest Intel should change
>>>> their code to use IOMMU_BLOCK_NO_SNOOP and abandon
>> IOMMU_CACHE.
>>>
>>> I didn't fully get this point. The end result is same, i.e. making the DMA
>>> cache-coherent when IOMMU_CACHE is set. Or if you help define the
>>> behavior of IOMMU_CACHE, what will you define now?
>>
>> It is clearly specifying how the kernel API works:
>>
>>   !IOMMU_CACHE
>>     must call arch cache flushers
>>   IOMMU_CACHE -
>>     do not call arch cache flushers
>>   IOMMU_CACHE|IOMMU_BLOCK_NO_SNOOP -
>>     dot not arch cache flushers, and ignore the no snoop bit.
> 
> Who will set IOMMU_BLOCK_NO_SNOOP? I feel this is arch specific
> knowledge about how cache coherency is implemented, i.e.
> when IOMMU_CACHE is set intel-iommu driver just maps it to
> blocking no-snoop. It's not necessarily to be an attribute in
> the same level as IOMMU_CACHE?
> 
>>
>> On Intel it should refuse to create a !IOMMU_CACHE since the HW can't
>> do that.
> 
> Agree. In reality I guess this is not hit because all devices are marked
> coherent on Intel platforms...
> 
> Baolu, any insight here?

I am trying to follow the discussion here. Please guide me if I didn't
get the right context.

Here, we are discussing arch_sync_dma_for_cpu() and
arch_sync_dma_for_device(). The x86 arch has clflush to sync dma buffer
for device, but I can't see any instruction to sync dma buffer for cpu
if the device is not cache coherent. Is that the reason why x86 can't
have an implementation for arch_sync_dma_for_cpu(), hence all devices
are marked coherent?

> Thanks
> Kevin
> 

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
