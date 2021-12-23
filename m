Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56362C433EF
	for <iommu@archiver.kernel.org>; Thu, 23 Dec 2021 03:03:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CEED360A79;
	Thu, 23 Dec 2021 03:03:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FCRpLyYg1hRV; Thu, 23 Dec 2021 03:03:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B36AE60AC7;
	Thu, 23 Dec 2021 03:03:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8A88AC002F;
	Thu, 23 Dec 2021 03:03:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1A0D1C0012
 for <iommu@lists.linux-foundation.org>; Thu, 23 Dec 2021 03:03:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E8E3960AC7
 for <iommu@lists.linux-foundation.org>; Thu, 23 Dec 2021 03:03:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xrl973tGk21B for <iommu@lists.linux-foundation.org>;
 Thu, 23 Dec 2021 03:03:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4627E607E1
 for <iommu@lists.linux-foundation.org>; Thu, 23 Dec 2021 03:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1640228610; x=1671764610;
 h=cc:subject:to:references:from:message-id:date:
 mime-version:in-reply-to:content-transfer-encoding;
 bh=5d4GcwvuSuDNN/LCrM8VSrs/VLqePmPsfkX8JRr6fXw=;
 b=UaM6k73Izx1eUslGXr1XBr61UOrgGg/wMz8YphKeP1BYNCf4csGK3Xh8
 WXg/XOCzTtLqHh9a6UwMV2BracFeo+QJsYwbdo6C3lkcI6+Q9Jlhjgh85
 JaeZMjcyNp2F5QiOgsDAQEfYGaUM6i/LQFfRGLGAtjwLvuY6FsV3XOPAM
 2hvbp+EKHjqvRpWgVcdgSAC1wzUWRfseACVGdBaP9MM3krPwhmpnUMAmh
 +O6YazyHDU+fnBKGbrXQHomfn5uBy7QifIdIlLtadTxtABd6gb+FjPrSr
 4O0guwVZm80T32UxzwsyaJCGml0QwaKhSy5dBXifYuYSYZwnAB0RUET08 Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="227590555"
X-IronPort-AV: E=Sophos;i="5.88,228,1635231600"; d="scan'208";a="227590555"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Dec 2021 19:03:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,228,1635231600"; d="scan'208";a="664454653"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 22 Dec 2021 19:03:18 -0800
Subject: Re: [PATCH v4 02/13] driver core: Set DMA ownership during driver
 bind/unbind
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20211217063708.1740334-1-baolu.lu@linux.intel.com>
 <20211217063708.1740334-3-baolu.lu@linux.intel.com>
 <YcMeZlN3798noycN@kroah.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <94e37c45-abc1-c682-5adf-1cc4b6887640@linux.intel.com>
Date: Thu, 23 Dec 2021 11:02:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YcMeZlN3798noycN@kroah.com>
Content-Language: en-US
Cc: Stuart Yoder <stuyoder@gmail.com>, rafael@kernel.org,
 David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
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

Hi Greg,

On 12/22/21 8:47 PM, Greg Kroah-Hartman wrote:
>> +
>> +	return ret;
>> +}
>> +
>> +static void device_dma_cleanup(struct device *dev, struct device_driver *drv)
>> +{
>> +	if (!dev->bus->dma_configure)
>> +		return;
>> +
>> +	if (!drv->suppress_auto_claim_dma_owner)
>> +		iommu_device_release_dma_owner(dev, DMA_OWNER_DMA_API);
>> +}
>> +
>>   static int really_probe(struct device *dev, struct device_driver *drv)
>>   {
>>   	bool test_remove = IS_ENABLED(CONFIG_DEBUG_TEST_DRIVER_REMOVE) &&
>> @@ -574,11 +601,8 @@ static int really_probe(struct device *dev, struct device_driver *drv)
>>   	if (ret)
>>   		goto pinctrl_bind_failed;
>>   
>> -	if (dev->bus->dma_configure) {
>> -		ret = dev->bus->dma_configure(dev);
>> -		if (ret)
>> -			goto probe_failed;
>> -	}
>> +	if (device_dma_configure(dev, drv))
>> +		goto pinctrl_bind_failed;
> Are you sure you are jumping to the proper error path here?  It is not
> obvious why you changed this.

The error handling path in really_probe() seems a bit wrong. For
example,

  572         /* If using pinctrl, bind pins now before probing */
  573         ret = pinctrl_bind_pins(dev);
  574         if (ret)
  575                 goto pinctrl_bind_failed;

[...]

  663 pinctrl_bind_failed:
  664         device_links_no_driver(dev);
  665         devres_release_all(dev);
  666         arch_teardown_dma_ops(dev);
  667         kfree(dev->dma_range_map);
  668         dev->dma_range_map = NULL;
  669         driver_sysfs_remove(dev);
              ^^^^^^^^^^^^^^^^^^^^^^^^^
  670         dev->driver = NULL;
  671         dev_set_drvdata(dev, NULL);
  672         if (dev->pm_domain && dev->pm_domain->dismiss)
  673                 dev->pm_domain->dismiss(dev);
  674         pm_runtime_reinit(dev);
  675         dev_pm_set_driver_flags(dev, 0);
  676 done:
  677         return ret;

The driver_sysfs_remove() will be called even driver_sysfs_add() hasn't
been called yet. I can fix this in a separated patch if I didn't miss
anything.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
