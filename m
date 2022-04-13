Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B377C433EF
	for <iommu@archiver.kernel.org>; Wed, 13 Apr 2022 11:37:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9892040490;
	Wed, 13 Apr 2022 11:37:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id INvZUF52extf; Wed, 13 Apr 2022 11:37:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 752F440477;
	Wed, 13 Apr 2022 11:37:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5651DC0033;
	Wed, 13 Apr 2022 11:37:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 059FDC002C
 for <iommu@lists.linux-foundation.org>; Wed, 13 Apr 2022 11:37:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D7D11409F6
 for <iommu@lists.linux-foundation.org>; Wed, 13 Apr 2022 11:37:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uawBgWUmXmwb for <iommu@lists.linux-foundation.org>;
 Wed, 13 Apr 2022 11:37:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0C830409E8
 for <iommu@lists.linux-foundation.org>; Wed, 13 Apr 2022 11:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1649849861; x=1681385861;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=/ag9oz6OrTFhgh1L3jctSIOPjT1GAUan2yOt1VeoaJc=;
 b=hn2DdbD/Ty4AuiB7xh/Eigu3YPFjQmMblmWo77BeNYMbLkouoD4ZFLxB
 xoZR70hEWLzbyY3Z93UxZugqTbAKAN48VO/agrkd2f//r2dIARmr1xUxy
 T5wpNOraydAC0bXCHRgfmsJZXV3Af84c1P2s9EhI8lo5H7SMy7TCRtDEd
 M2QT8eUhuO390TuoJAbpTjn846Vi+LUfZMOtsCAUpJIGjTVW4ZDydi37r
 lrKmdaLEvdj2B8GcITDzAES0eVgbslS5gq0/qaFRZW6bo/JtAR8ywzyJ4
 Gs/Z7hUuULGENpoStZLaPY9qe1YFxFyx6jJ03G12FOsX95HBGuiDLpRHv g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="349078393"
X-IronPort-AV: E=Sophos;i="5.90,256,1643702400"; d="scan'208";a="349078393"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Apr 2022 04:37:39 -0700
X-IronPort-AV: E=Sophos;i="5.90,256,1643702400"; d="scan'208";a="573232232"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.215.67])
 ([10.254.215.67])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Apr 2022 04:37:36 -0700
Message-ID: <de2c7dff-0591-aab0-79cb-9858b978c3fa@linux.intel.com>
Date: Wed, 13 Apr 2022 19:37:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 2/4] vfio: Move the Intel no-snoop control off of
 IOMMU_CACHE
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <0-v2-f090ae795824+6ad-intel_no_snoop_jgg@nvidia.com>
 <2-v2-f090ae795824+6ad-intel_no_snoop_jgg@nvidia.com>
 <BN9PR11MB5276796235136C1E6C50A5AF8CE99@BN9PR11MB5276.namprd11.prod.outlook.com>
 <8df77a0f-55ee-bbc3-8ada-ab109d9323eb@linux.intel.com>
 <BN9PR11MB5276FD53286C0181B4987C958CED9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <a3b9d7f0-b7b9-ffdf-90c3-b216e1e19b35@linux.intel.com>
 <20220412132059.GG2120790@nvidia.com>
 <BN9PR11MB527667C637E3CFDDB611697E8CED9@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB527667C637E3CFDDB611697E8CED9@BN9PR11MB5276.namprd11.prod.outlook.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Will Deacon <will@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Robin Murphy <robin.murphy@arm.com>, David Woodhouse <dwmw2@infradead.org>,
 Christoph Hellwig <hch@lst.de>
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

On 2022/4/13 7:04, Tian, Kevin wrote:
>> From: Jason Gunthorpe<jgg@nvidia.com>
>> Sent: Tuesday, April 12, 2022 9:21 PM
>>
>> On Tue, Apr 12, 2022 at 09:13:27PM +0800, Lu Baolu wrote:
>>
>>>>>> btw as discussed in last version it is not necessarily to recalculate
>>>>>> snoop control globally with this new approach. Will follow up to
>>>>>> clean it up after this series is merged.
>>>>> Agreed. But it also requires the enforce_cache_coherency() to be called
>>>>> only after domain being attached to a device just as VFIO is doing.
>>>> that actually makes sense, right? w/o device attached it's pointless to
>>>> call that interface on a domain...
>>> Agreed. Return -EOPNOTSUPP or -EINVAL to tell the caller that this
>>> operation is invalid before any device attachment.
>> That is backwards. enforce_cache_coherency() succeeds on an empty
>> domain and attach of an incompatible device must fail.
> seems it's just a matter of the default policy on an empty domain. No
> matter we by default allow enforce_cache_coherency succeed or not
> the compatibility check against the default policy must be done anyway
> when attaching a device.
> 
> given most IOMMUs supports force-snooping, allowing it succeed by
> default certainly makes more sense.

Make sense. I will come up with the patches after this series is merged.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
