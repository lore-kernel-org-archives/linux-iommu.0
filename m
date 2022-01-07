Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD57FC433EF
	for <iommu@archiver.kernel.org>; Fri,  7 Jan 2022 00:23:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7C24760D79;
	Fri,  7 Jan 2022 00:23:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z5cyuUGIRmGO; Fri,  7 Jan 2022 00:23:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 606AB60D64;
	Fri,  7 Jan 2022 00:23:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 389E8C0030;
	Fri,  7 Jan 2022 00:23:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 41FE9C001E
 for <iommu@lists.linux-foundation.org>; Fri,  7 Jan 2022 00:23:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2D8818336D
 for <iommu@lists.linux-foundation.org>; Fri,  7 Jan 2022 00:23:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OZL5XMlSNfKu for <iommu@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 00:23:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E453E83367
 for <iommu@lists.linux-foundation.org>; Fri,  7 Jan 2022 00:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1641515032; x=1673051032;
 h=cc:subject:to:references:from:message-id:date:
 mime-version:in-reply-to:content-transfer-encoding;
 bh=ZIszb2ptLlWN5jiqIqtYtNRvhlbcJxtJfClvbQTYBwI=;
 b=dMYuhm+ct68A0mK/AURSdYZzwaoMXCHBssqJ0sBrPk0JE156EZJ6n2mv
 Q8jnb2iPDsj6tJWZcwdg+0KIehA3WyzA91viaU1zX9qKa60909iFiJHFr
 JWGJvIv0HndwQUW4K5kzd+5xgH7sbDgvcio9sx1Th/Z3XPbEVMaD5GKu6
 98VgoUhnG0dK4uPqixS/2fWbOCdvJigpSzHc06TGL+sPGrONaQ0QEEwrk
 vVmVC2zzfRBUZFZPn+3eADy422LnLb4EKarkGtUkaRmpQhvuvp2TINEJ1
 nkzsw6NwpYqyWGSeJ6jNqLk7BBkxaYRIeEpAcU9SpJQYNxku2CFSeScub w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="306135913"
X-IronPort-AV: E=Sophos;i="5.88,268,1635231600"; d="scan'208";a="306135913"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jan 2022 16:23:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,268,1635231600"; d="scan'208";a="527179688"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by orsmga008.jf.intel.com with ESMTP; 06 Jan 2022 16:23:45 -0800
Subject: Re: [PATCH v1 5/8] iommu/amd: Use iommu_attach/detach_device()
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20220106022053.2406748-1-baolu.lu@linux.intel.com>
 <20220106022053.2406748-6-baolu.lu@linux.intel.com>
 <20220106143345.GC2328285@nvidia.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <456972f1-0237-81db-69cf-363f9ac611e0@linux.intel.com>
Date: Fri, 7 Jan 2022 08:23:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220106143345.GC2328285@nvidia.com>
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

On 1/6/22 10:33 PM, Jason Gunthorpe wrote:
> On Thu, Jan 06, 2022 at 10:20:50AM +0800, Lu Baolu wrote:
>> The individual device driver should use iommu_attach/detach_device()
>> for domain attachment/detachment.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>>   drivers/iommu/amd/iommu_v2.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iommu/amd/iommu_v2.c b/drivers/iommu/amd/iommu_v2.c
>> index 58da08cc3d01..7d9d0fe89064 100644
>> +++ b/drivers/iommu/amd/iommu_v2.c
>> @@ -133,7 +133,7 @@ static void free_device_state(struct device_state *dev_state)
>>   	if (WARN_ON(!group))
>>   		return;
>>   
>> -	iommu_detach_group(dev_state->domain, group);
>> +	iommu_detach_device(dev_state->domain, &dev_state->pdev->dev);
>>   
>>   	iommu_group_put(group);
> 
> This is the only user of the group in the function all the
> group_get/put should be deleted too.
> 
> Joerg said in commit 55c99a4dc50f ("iommu/amd: Use
> iommu_attach_group()") that the device API doesn't work here because
> there are multi-device groups?
> 
> But I'm not sure how this can work with multi-device groups - this
> seems to assigns a domain setup for direct map, so perhaps this only
> works if all devices are setup for direct map?

It's also difficult for me to understand how this can work with multi-
device group. The iommu_attach_group() returns -EBUSY if _init_device()
is called for the second device in the group. That's the reason why I
didn't set no_kernel_dma.

> 
>> @@ -791,7 +791,7 @@ int amd_iommu_init_device(struct pci_dev *pdev, int pasids)
>>   		goto out_free_domain;
>>   	}
>>   
>> -	ret = iommu_attach_group(dev_state->domain, group);
>> +	ret = iommu_attach_device(dev_state->domain, &pdev->dev);
>>   	if (ret != 0)
>>   		goto out_drop_group;
> 
> Same comment here

Yes.

> 
> Jason
> 

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
