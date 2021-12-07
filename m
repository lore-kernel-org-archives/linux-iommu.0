Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10589C433F5
	for <iommu@archiver.kernel.org>; Tue,  7 Dec 2021 02:57:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B42A540951;
	Tue,  7 Dec 2021 02:57:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zxISbETKYuGl; Tue,  7 Dec 2021 02:57:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 951A541C70;
	Tue,  7 Dec 2021 02:57:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4AF7CC001E;
	Tue,  7 Dec 2021 02:57:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8A21CC0012
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 02:57:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6507D40153
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 02:57:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zJRcl3pVoSDd for <iommu@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 02:57:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4097D400BA
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 02:57:41 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="237708088"
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; d="scan'208";a="237708088"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Dec 2021 18:57:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; d="scan'208";a="515065510"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by orsmga008.jf.intel.com with ESMTP; 06 Dec 2021 18:57:32 -0800
Subject: Re: [PATCH v3 04/18] driver core: platform: Add driver dma ownership
 management
To: Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>
References: <20211206015903.88687-1-baolu.lu@linux.intel.com>
 <20211206015903.88687-5-baolu.lu@linux.intel.com>
 <Ya4f662Af+8kE2F/@infradead.org> <20211206150647.GE4670@nvidia.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <56a63776-48ca-0d6e-c25c-016dc016e0d5@linux.intel.com>
Date: Tue, 7 Dec 2021 10:57:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211206150647.GE4670@nvidia.com>
Content-Language: en-US
Cc: Stuart Yoder <stuyoder@gmail.com>, rafael@kernel.org,
 David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
 Chaitanya Kulkarni <kch@nvidia.com>,
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

On 12/6/21 11:06 PM, Jason Gunthorpe wrote:
> On Mon, Dec 06, 2021 at 06:36:27AM -0800, Christoph Hellwig wrote:
>> I really hate the amount of boilerplate code that having this in each
>> bus type causes.
> +1
> 
> I liked the first version of this series better with the code near
> really_probe().
> 
> Can we go back to that with some device_configure_dma() wrapper
> condtionally called by really_probe as we discussed?
> 

Are you talking about below change?

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 68ea1f949daa..368f9e530515 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -577,7 +577,13 @@ static int really_probe(struct device *dev, struct 
device_driver *drv)
  	if (dev->bus->dma_configure) {
  		ret = dev->bus->dma_configure(dev);
  		if (ret)
-			goto probe_failed;
+			goto pinctrl_bind_failed;
+
+		if (!drv->no_kernel_dma) {
+			ret = iommu_device_set_dma_owner(dev, DMA_OWNER_DMA_API, NULL);
+			if (ret)
+				goto pinctrl_bind_failed;
+                }
  	}

  	ret = driver_sysfs_add(dev);
@@ -660,6 +666,9 @@ static int really_probe(struct device *dev, struct 
device_driver *drv)
  	if (dev->bus)
  		blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
  					     BUS_NOTIFY_DRIVER_NOT_BOUND, dev);
+
+	if (dev->bus->dma_configure && !drv->no_kernel_dma)
+		iommu_device_release_dma_owner(dev, DMA_OWNER_DMA_API);
  pinctrl_bind_failed:
  	device_links_no_driver(dev);
  	devres_release_all(dev);
@@ -1204,6 +1213,9 @@ static void __device_release_driver(struct device 
*dev, struct device *parent)
  		else if (drv->remove)
  			drv->remove(dev);

+		if (dev->bus->dma_configure && !drv->no_kernel_dma)
+			iommu_device_release_dma_owner(dev, DMA_OWNER_DMA_API);
+
  		device_links_driver_cleanup(dev);

  		devres_release_all(dev);
diff --git a/include/linux/device/driver.h b/include/linux/device/driver.h
index a498ebcf4993..2cf7b757b28e 100644
--- a/include/linux/device/driver.h
+++ b/include/linux/device/driver.h
@@ -100,6 +100,7 @@ struct device_driver {
  	const char		*mod_name;	/* used for built-in modules */

  	bool suppress_bind_attrs;	/* disables bind/unbind via sysfs */
+	bool no_kernel_dma;
  	enum probe_type probe_type;

  	const struct of_device_id	*of_match_table;

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
