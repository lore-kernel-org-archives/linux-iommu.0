Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17961C433EF
	for <iommu@archiver.kernel.org>; Wed,  5 Jan 2022 06:53:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9879A40178;
	Wed,  5 Jan 2022 06:53:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w6tCP4F9w5VA; Wed,  5 Jan 2022 06:52:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4436240004;
	Wed,  5 Jan 2022 06:52:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0BE9AC0030;
	Wed,  5 Jan 2022 06:52:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C797CC001E
 for <iommu@lists.linux-foundation.org>; Wed,  5 Jan 2022 06:52:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ADD2082784
 for <iommu@lists.linux-foundation.org>; Wed,  5 Jan 2022 06:52:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1Mhf6TqZlh_6 for <iommu@lists.linux-foundation.org>;
 Wed,  5 Jan 2022 06:52:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 20D7C82786
 for <iommu@lists.linux-foundation.org>; Wed,  5 Jan 2022 06:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1641365577; x=1672901577;
 h=cc:subject:to:references:from:message-id:date:
 mime-version:in-reply-to:content-transfer-encoding;
 bh=NfLc3B58P2xIUXLczC9zkU0pb72XnW/r7ysxWZe4Nnw=;
 b=Y5ypHrakt2+u9r/4OY2rS7FDeu7zW1MIBaeXKfvS64bmAkFQGyelVqEV
 LIaZveskix6AYFZc62YjOcwsFrOG+hZV0v1WOpRTBy0Hu57MjlKg7KU5A
 9l2Z1m0eolHiiCBRYRHCyHbJ6+Q/k2wvQJo+mTZ3njg8tqCUq7V7oCzhy
 k9NOxmDvSWeMo3SV5Asod8BJBhgVjnJxfkmpr+ehgxdeHmBd6rmRP4x6u
 hj5S6wTP4ksE5bLGkZWt6UYqGGBUrkkzvUDBf85gGlfBNJV7TZSIgrnAR
 Y4xdav7ZeKmQxIrqx8Jmg5TqszXNrCT+HBC4GBU15DPMyot8kLFCCjyYt Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="239923274"
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; d="scan'208";a="239923274"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jan 2022 22:52:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; d="scan'208";a="526391598"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by orsmga008.jf.intel.com with ESMTP; 04 Jan 2022 22:52:48 -0800
Subject: Re: [PATCH v5 00/14] Fix BUG_ON in vfio_iommu_group_notifier()
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20220104015644.2294354-1-baolu.lu@linux.intel.com>
 <20220104124800.GF2328285@nvidia.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <f42e5d09-6578-98a4-a0f3-097f69bb7c3a@linux.intel.com>
Date: Wed, 5 Jan 2022 14:52:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220104124800.GF2328285@nvidia.com>
Content-Language: en-US
Cc: Stuart Yoder <stuyoder@gmail.com>, rafael@kernel.org,
 David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Kevin Tian <kevin.tian@intel.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 Li Yang <leoyang.li@nxp.com>, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Daniel Vetter <daniel@ffwll.ch>,
 Robin Murphy <robin.murphy@arm.com>
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

On 1/4/22 8:48 PM, Jason Gunthorpe wrote:
> On Tue, Jan 04, 2022 at 09:56:30AM +0800, Lu Baolu wrote:
> 
>> v5:
>>    - Move kernel dma ownership auto-claiming from driver core to bus
>>      callback. (Greg)
>>    - Refactor the iommu interfaces to make them more specific.
>>      (Jason/Robin)
>>    - Simplify the dma ownership implementation by removing the owner
>>      type. (Jason)
>>    - Commit message refactoring for PCI drivers. (Bjorn)
>>    - Move iommu_attach/detach_device() improvement patches into another
>>      series as there are a lot of code refactoring and cleanup staffs
>>      in various device drivers.
> 
> Since you already have the code you should make this 'other series'
> right now. It should delete iommu_group_attach() and fix
> iommu_device_attach().

Yes. I am doing the functional and compile tests. I will post it once I
complete the testing.

> 
> You also didn't really do my suggestion, this messes up the normal
> __iommu_attach_group()/__iommu_detach_group() instead of adding the
> clear to purpose iommu_replace_group() for VFIO to use. This just
> makes it more difficult to normalize the APIs.

I didn't forget that. :-) It's part of the new series.

> 
> Otherwise it does seem to have turned out to be more understandable.
> 
> Jason
> 

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
