Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8F01C433F5
	for <iommu@archiver.kernel.org>; Thu,  6 Jan 2022 03:51:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7BC9481348;
	Thu,  6 Jan 2022 03:51:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bE_BStgGv9Gp; Thu,  6 Jan 2022 03:51:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7707881343;
	Thu,  6 Jan 2022 03:51:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5B2AFC002F;
	Thu,  6 Jan 2022 03:51:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EDF96C001E
 for <iommu@lists.linux-foundation.org>; Thu,  6 Jan 2022 03:51:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D846260E58
 for <iommu@lists.linux-foundation.org>; Thu,  6 Jan 2022 03:51:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 44swBvBidy3a for <iommu@lists.linux-foundation.org>;
 Thu,  6 Jan 2022 03:51:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1D27060E14
 for <iommu@lists.linux-foundation.org>; Thu,  6 Jan 2022 03:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1641441113; x=1672977113;
 h=cc:subject:to:references:from:message-id:date:
 mime-version:in-reply-to:content-transfer-encoding;
 bh=duW+vQR4sMirxxEYotvqV0oLcyExanZmvqlVTiuxZFs=;
 b=NkA2NEacAS5hmZc/TByf1LYWAQPb6X2fhuTk4n1k1WcKEbFlwG+5RiOD
 6O+yXxwGuXfTqAtz+uWSZYg3uCEN5jVzgtsnbZtgLZrtmcfL/Dwlfdd2Y
 ZdwjZDLD5ANdUomNDTBzPQ441R8wl6HTF0TMwaBVneT0+BMaJX9goQpd1
 mztJpIyEGBvvjCTDGDxAbHhOFEZ/hRCFAb5UhpFRtZyhqcE43yhJ8r7S4
 rKIJPc3URdDl8dDReboXjXOfl2twJe9veNawwbl9hC74Qg0ku7PJVMj+u
 h4SS4ez/WKNNiIyiJVv8A6qPc1+ob6mzkb5UXJgaa9NmZ/PIpTedk0IeD w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="266869728"
X-IronPort-AV: E=Sophos;i="5.88,265,1635231600"; d="scan'208";a="266869728"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jan 2022 19:51:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,265,1635231600"; d="scan'208";a="526815760"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by orsmga008.jf.intel.com with ESMTP; 05 Jan 2022 19:51:45 -0800
Subject: Re: [PATCH v5 01/14] iommu: Add dma ownership management interfaces
To: Bjorn Helgaas <helgaas@kernel.org>, Christoph Hellwig <hch@infradead.org>
References: <20220104164100.GA101735@bhelgaas>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <bcb77054-f4ac-cd34-d79c-eba7cb54e042@linux.intel.com>
Date: Thu, 6 Jan 2022 11:51:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220104164100.GA101735@bhelgaas>
Content-Language: en-US
Cc: Stuart Yoder <stuyoder@gmail.com>, rafael@kernel.org,
 David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
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

On 1/5/22 12:41 AM, Bjorn Helgaas wrote:
>>>   struct group_device {
>>> @@ -289,7 +291,12 @@ int iommu_probe_device(struct device *dev)
>>>   	mutex_lock(&group->mutex);
>>>   	iommu_alloc_default_domain(group, dev);
>>>   
>>> -	if (group->default_domain) {
>>> +	/*
>>> +	 * If device joined an existing group which has been claimed
>>> +	 * for none kernel DMA purpose, avoid attaching the default
>>> +	 * domain.
> AOL: another "none kernel DMA purpose" that doesn't read well.  Is
> this supposed to be "non-kernel"?  What does "claimed for non-kernel
> DMA purpose" mean?  What interface does that?
> 

It's hard to read. I will rephrase it like this:

/*
  * If device joined an existing group which has been claimed, don't
  * attach the default domain.
  */

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
