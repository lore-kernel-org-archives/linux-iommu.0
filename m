Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D32F9C433EF
	for <iommu@archiver.kernel.org>; Thu,  9 Dec 2021 01:20:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4E30D4010E;
	Thu,  9 Dec 2021 01:20:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tdLWwRl-qtxL; Thu,  9 Dec 2021 01:20:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DDC15402DC;
	Thu,  9 Dec 2021 01:20:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A0F35C002F;
	Thu,  9 Dec 2021 01:20:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E7F54C0012
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 01:20:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CCB2040143
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 01:20:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Opi-048drN4u for <iommu@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 01:20:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C97A14010E
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 01:20:28 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="238217721"
X-IronPort-AV: E=Sophos;i="5.88,190,1635231600"; d="scan'208";a="238217721"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Dec 2021 17:20:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,190,1635231600"; d="scan'208";a="516062926"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by orsmga008.jf.intel.com with ESMTP; 08 Dec 2021 17:20:20 -0800
Subject: Re: [PATCH v3 04/18] driver core: platform: Add driver dma ownership
 management
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20211206015903.88687-1-baolu.lu@linux.intel.com>
 <20211206015903.88687-5-baolu.lu@linux.intel.com>
 <Ya4f662Af+8kE2F/@infradead.org> <20211206150647.GE4670@nvidia.com>
 <56a63776-48ca-0d6e-c25c-016dc016e0d5@linux.intel.com>
 <20211207131627.GA6385@nvidia.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <c170d215-6aef-ff21-8733-1bae4478e39c@linux.intel.com>
Date: Thu, 9 Dec 2021 09:20:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211207131627.GA6385@nvidia.com>
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

On 12/7/21 9:16 PM, Jason Gunthorpe wrote:
> On Tue, Dec 07, 2021 at 10:57:25AM +0800, Lu Baolu wrote:
>> On 12/6/21 11:06 PM, Jason Gunthorpe wrote:
>>> On Mon, Dec 06, 2021 at 06:36:27AM -0800, Christoph Hellwig wrote:
>>>> I really hate the amount of boilerplate code that having this in each
>>>> bus type causes.
>>> +1
>>>
>>> I liked the first version of this series better with the code near
>>> really_probe().
>>>
>>> Can we go back to that with some device_configure_dma() wrapper
>>> condtionally called by really_probe as we discussed?
>>>
>>
>> Are you talking about below change?
>>
>> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
>> index 68ea1f949daa..368f9e530515 100644
>> +++ b/drivers/base/dd.c
>> @@ -577,7 +577,13 @@ static int really_probe(struct device *dev, struct
>> device_driver *drv)
>>   	if (dev->bus->dma_configure) {
>>   		ret = dev->bus->dma_configure(dev);
>>   		if (ret)
>> -			goto probe_failed;
>> +			goto pinctrl_bind_failed;
>> +
>> +		if (!drv->no_kernel_dma) {
>> +			ret = iommu_device_set_dma_owner(dev, DMA_OWNER_DMA_API, NULL);
>> +			if (ret)
>> +				goto pinctrl_bind_failed;
>> +                }
>>   	}
> 
> Yes, the suggestion was to put everything that 'if' inside a function
> and then of course a matching undo function.

Followed your suggestion, I refactored the change like below:

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 68ea1f949daa..68ca5a579eb1 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -538,6 +538,32 @@ static int call_driver_probe(struct device *dev, 
struct device_driver *drv)
         return ret;
  }

+static int device_dma_configure(struct device *dev, struct 
device_driver *drv)
+{
+       int ret;
+
+       if (!dev->bus->dma_configure)
+               return 0;
+
+       ret = dev->bus->dma_configure(dev);
+       if (ret)
+               return ret;
+
+       if (!drv->suppress_auto_claim_dma_owner)
+               ret = iommu_device_set_dma_owner(dev, DMA_OWNER_DMA_API, 
NULL);
+
+       return ret;
+}
+
+static void device_dma_cleanup(struct device *dev, struct device_driver 
*drv)
+{
+       if (!dev->bus->dma_configure)
+               return;
+
+       if (!drv->suppress_auto_claim_dma_owner)
+               iommu_device_release_dma_owner(dev, DMA_OWNER_DMA_API, 
NULL);
+}
+
  static int really_probe(struct device *dev, struct device_driver *drv)
  {
         bool test_remove = IS_ENABLED(CONFIG_DEBUG_TEST_DRIVER_REMOVE) &&
@@ -574,11 +600,8 @@ static int really_probe(struct device *dev, struct 
device_driver *drv)
         if (ret)
                 goto pinctrl_bind_failed;

-       if (dev->bus->dma_configure) {
-               ret = dev->bus->dma_configure(dev);
-               if (ret)
-                       goto probe_failed;
-       }
+       if (device_dma_configure(dev, drv))
+               goto pinctrl_bind_failed;

         ret = driver_sysfs_add(dev);
         if (ret) {
@@ -660,6 +683,8 @@ static int really_probe(struct device *dev, struct 
device_driver *drv)
         if (dev->bus)
                 blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
 
BUS_NOTIFY_DRIVER_NOT_BOUND, dev);
+
+       device_dma_cleanup(dev, drv);
  pinctrl_bind_failed:
         device_links_no_driver(dev);
         devres_release_all(dev);
@@ -1204,6 +1229,7 @@ static void __device_release_driver(struct device 
*dev, struct device *parent)
                 else if (drv->remove)
                         drv->remove(dev);

+               device_dma_cleanup(dev, drv);
                 device_links_driver_cleanup(dev);

                 devres_release_all(dev);
diff --git a/include/linux/device/driver.h b/include/linux/device/driver.h
index a498ebcf4993..374a3c2cc10d 100644
--- a/include/linux/device/driver.h
+++ b/include/linux/device/driver.h
@@ -100,6 +100,7 @@ struct device_driver {
         const char              *mod_name;      /* used for built-in 
modules */

         bool suppress_bind_attrs;       /* disables bind/unbind via 
sysfs */
+       bool suppress_auto_claim_dma_owner;
         enum probe_type probe_type;

         const struct of_device_id       *of_match_table;

Further suggestions?

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
