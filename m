Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 078ADC433EF
	for <iommu@archiver.kernel.org>; Thu, 23 Dec 2021 07:24:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9F46660A87;
	Thu, 23 Dec 2021 07:24:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mrQuq_8wdAJw; Thu, 23 Dec 2021 07:24:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 76AF160ADF;
	Thu, 23 Dec 2021 07:24:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 41939C002F;
	Thu, 23 Dec 2021 07:24:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8679C0012
 for <iommu@lists.linux-foundation.org>; Thu, 23 Dec 2021 07:24:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BE788401B7
 for <iommu@lists.linux-foundation.org>; Thu, 23 Dec 2021 07:24:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9mhlqyfF5tJr for <iommu@lists.linux-foundation.org>;
 Thu, 23 Dec 2021 07:24:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D2F98400B5
 for <iommu@lists.linux-foundation.org>; Thu, 23 Dec 2021 07:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1640244266; x=1671780266;
 h=cc:subject:to:references:from:message-id:date:
 mime-version:in-reply-to:content-transfer-encoding;
 bh=aUqSTgtjYorgHIpTZQT6Y/tE/0+lDO+GqEPURXGr+QE=;
 b=RB27nEGgJK23xmtLA4soCFrBt3qvwsmPVOhVNCSgopGUr16+apEP7SqA
 cpltkCPn+ndl5Ta2X74ILZimRIhDh1y1jAMhSQMj5rJf7d+oIhosmuZ69
 HnOk3PMl8gCGH1GqOtW+CEEMcYuSWHBY0QX0eV/tZcVxXjS124xQpp2O8
 JZQasl6Ev02D37ndGGiAEtQcf7Ah3VRJcgdF3H2PcO3Y83ID49M5nBv4X
 KPBqv719tYzkzkk0Rj1eDX8yDpK/SLc+E9DKx5NY4RlixUHyJohKjCqxi
 aWQ53yJjqzMDGVC2Q9xxBo+emtBk9KAqQnypY+foc92T7PjjQJMN/aOCW w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="240999022"
X-IronPort-AV: E=Sophos;i="5.88,228,1635231600"; d="scan'208";a="240999022"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Dec 2021 23:24:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,228,1635231600"; d="scan'208";a="664504933"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 22 Dec 2021 23:24:19 -0800
Subject: Re: [PATCH v4 02/13] driver core: Set DMA ownership during driver
 bind/unbind
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20211217063708.1740334-1-baolu.lu@linux.intel.com>
 <20211217063708.1740334-3-baolu.lu@linux.intel.com>
 <YcMeZlN3798noycN@kroah.com>
 <94e37c45-abc1-c682-5adf-1cc4b6887640@linux.intel.com>
 <YcQhka64aqHJ5uE7@kroah.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <2350bea8-1ca0-0945-2084-77a3c7f54f27@linux.intel.com>
Date: Thu, 23 Dec 2021 15:23:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YcQhka64aqHJ5uE7@kroah.com>
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

On 12/23/21 3:13 PM, Greg Kroah-Hartman wrote:
> On Thu, Dec 23, 2021 at 11:02:54AM +0800, Lu Baolu wrote:
>> Hi Greg,
>>
>> On 12/22/21 8:47 PM, Greg Kroah-Hartman wrote:
>>>> +
>>>> +	return ret;
>>>> +}
>>>> +
>>>> +static void device_dma_cleanup(struct device *dev, struct device_driver *drv)
>>>> +{
>>>> +	if (!dev->bus->dma_configure)
>>>> +		return;
>>>> +
>>>> +	if (!drv->suppress_auto_claim_dma_owner)
>>>> +		iommu_device_release_dma_owner(dev, DMA_OWNER_DMA_API);
>>>> +}
>>>> +
>>>>    static int really_probe(struct device *dev, struct device_driver *drv)
>>>>    {
>>>>    	bool test_remove = IS_ENABLED(CONFIG_DEBUG_TEST_DRIVER_REMOVE) &&
>>>> @@ -574,11 +601,8 @@ static int really_probe(struct device *dev, struct device_driver *drv)
>>>>    	if (ret)
>>>>    		goto pinctrl_bind_failed;
>>>> -	if (dev->bus->dma_configure) {
>>>> -		ret = dev->bus->dma_configure(dev);
>>>> -		if (ret)
>>>> -			goto probe_failed;
>>>> -	}
>>>> +	if (device_dma_configure(dev, drv))
>>>> +		goto pinctrl_bind_failed;
>>> Are you sure you are jumping to the proper error path here?  It is not
>>> obvious why you changed this.
>> The error handling path in really_probe() seems a bit wrong. For
>> example,
>>
>>   572         /* If using pinctrl, bind pins now before probing */
>>   573         ret = pinctrl_bind_pins(dev);
>>   574         if (ret)
>>   575                 goto pinctrl_bind_failed;
>>
>> [...]
>>
>>   663 pinctrl_bind_failed:
>>   664         device_links_no_driver(dev);
>>   665         devres_release_all(dev);
>>   666         arch_teardown_dma_ops(dev);
>>   667         kfree(dev->dma_range_map);
>>   668         dev->dma_range_map = NULL;
>>   669         driver_sysfs_remove(dev);
>>               ^^^^^^^^^^^^^^^^^^^^^^^^^
>>   670         dev->driver = NULL;
>>   671         dev_set_drvdata(dev, NULL);
>>   672         if (dev->pm_domain && dev->pm_domain->dismiss)
>>   673                 dev->pm_domain->dismiss(dev);
>>   674         pm_runtime_reinit(dev);
>>   675         dev_pm_set_driver_flags(dev, 0);
>>   676 done:
>>   677         return ret;
>>
>> The driver_sysfs_remove() will be called even driver_sysfs_add() hasn't
>> been called yet. I can fix this in a separated patch if I didn't miss
>> anything.
> If this is a bug in the existing kernel, please submit it as a separate
> patch so that it can be properly backported to all affected kernels.
> Never bury it in an unrelated change that will never get sent to older
> kernels.

Sure! I will. Thank you!

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
