Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF5AEC433EF
	for <iommu@archiver.kernel.org>; Tue, 29 Mar 2022 17:36:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7DBE6418BA;
	Tue, 29 Mar 2022 17:36:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zCJnbOqC9ix6; Tue, 29 Mar 2022 17:36:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DF9E641896;
	Tue, 29 Mar 2022 17:36:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C0717C002C;
	Tue, 29 Mar 2022 17:36:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7BD01C0012
 for <iommu@lists.linux-foundation.org>; Tue, 29 Mar 2022 17:36:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 68C5460D5C
 for <iommu@lists.linux-foundation.org>; Tue, 29 Mar 2022 17:36:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KaozNdcH2CeH for <iommu@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 17:36:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7D67A605AF
 for <iommu@lists.linux-foundation.org>; Tue, 29 Mar 2022 17:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1648575390; x=1680111390;
 h=date:from:to:cc:subject:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fBn9JtbtkTc3R/g8GyiflShARTXJTrabmJczllhTBug=;
 b=VoX5m1/x1QEdDK/l3cRQe7fHFO2wa073BkR5K6NmF9B/cHz/ek3MAa2j
 rdKa2Rr1A/9bpm4ZRSbL5UnuzVcwyhcR5tcRmACedMJYDKsEavMVhyUpx
 d1QU5hv1yKq0Zw/icTgi87a+eYA9xW44ScEG+1I+wd2lUh7U8snrwq2GF
 4y98JYQfv4Y8oYikmDvn6oaoyfwHCGgbjaDTTgNqQjVpJ352z8xGvLBnb
 u4F8JXh+xwIMa/QRqn0or7tPMi/6oUUZj/53g/4cENTZUtDUumrGlZG9H
 YAUCx5AnuoTt1hyM2cdcFzB8naSDqHaH7/CQNLWUNLtL8sHxwnKt9DWnA Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="345756795"
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; d="scan'208";a="345756795"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2022 10:36:29 -0700
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; d="scan'208";a="502977142"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2022 10:36:29 -0700
Date: Tue, 29 Mar 2022 10:39:52 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH v2 6/8] dmaengine: idxd: Use DMA API for in-kernel DMA
 with PASID
Message-ID: <20220329103952.7a330c09@jacob-builder>
In-Reply-To: <BN9PR11MB527625B7AD0FBC1BCEB5D2768C139@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
 <20220315050713.2000518-7-jacob.jun.pan@linux.intel.com>
 <BN9PR11MB527625B7AD0FBC1BCEB5D2768C139@BN9PR11MB5276.namprd11.prod.outlook.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Luck,
 Tony" <tony.luck@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, "Zanussi, Tom" <tom.zanussi@intel.com>, "Kumar,
 Sanjay K" <sanjay.k.kumar@intel.com>, LKML <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>, Jason
 Gunthorpe <jgg@nvidia.com>, "Williams, Dan J" <dan.j.williams@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Kevin,

On Fri, 18 Mar 2022 06:10:40 +0000, "Tian, Kevin" <kevin.tian@intel.com>
wrote:

> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Sent: Tuesday, March 15, 2022 1:07 PM
> > 
> > The current in-kernel supervisor PASID support is based on the SVM/SVA
> > machinery in SVA lib. The binding between a kernel PASID and kernel
> > mapping has many flaws. See discussions in the link below.
> > 
> > This patch enables in-kernel DMA by switching from SVA lib to the
> > standard DMA mapping APIs. Since both DMA requests with and without
> > PASIDs are mapped identically, there is no change to how DMA APIs are
> > used after the kernel PASID is enabled.
> > 
> > Link: https://lore.kernel.org/linux-
> > iommu/20210511194726.GP1002214@nvidia.com/
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  drivers/dma/idxd/idxd.h  |  1 -
> >  drivers/dma/idxd/init.c  | 34 +++++++++-------------------------
> >  drivers/dma/idxd/sysfs.c |  7 -------
> >  3 files changed, 9 insertions(+), 33 deletions(-)
> > 
> > diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
> > index da72eb15f610..a09ab4a6e1c1 100644
> > --- a/drivers/dma/idxd/idxd.h
> > +++ b/drivers/dma/idxd/idxd.h
> > @@ -276,7 +276,6 @@ struct idxd_device {
> >  	struct idxd_wq **wqs;
> >  	struct idxd_engine **engines;
> > 
> > -	struct iommu_sva *sva;
> >  	unsigned int pasid;
> > 
> >  	int num_groups;
> > diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> > index 08a5f4310188..5d1f8dd4abf6 100644
> > --- a/drivers/dma/idxd/init.c
> > +++ b/drivers/dma/idxd/init.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/idr.h>
> >  #include <linux/intel-svm.h>
> >  #include <linux/iommu.h>
> > +#include <linux/dma-iommu.h>
> >  #include <uapi/linux/idxd.h>
> >  #include <linux/dmaengine.h>
> >  #include "../dmaengine.h"
> > @@ -466,36 +467,22 @@ static struct idxd_device *idxd_alloc(struct
> > pci_dev *pdev, struct idxd_driver_d
> > 
> >  static int idxd_enable_system_pasid(struct idxd_device *idxd)  
> 
> idxd_enable_pasid_dma() since system pasid is a confusing term now?
> Or just remove the idxd specific wrappers and have the caller to call
> iommu_enable_pasid_dma() directly given the simple logic here.
> 
agreed, will do.

> >  {
> > -	int flags;
> > -	unsigned int pasid;
> > -	struct iommu_sva *sva;
> > +	u32 pasid;
> > +	int ret;
> > 
> > -	flags = SVM_FLAG_SUPERVISOR_MODE;
> > -
> > -	sva = iommu_sva_bind_device(&idxd->pdev->dev, NULL, &flags);
> > -	if (IS_ERR(sva)) {
> > -		dev_warn(&idxd->pdev->dev,
> > -			 "iommu sva bind failed: %ld\n", PTR_ERR(sva));
> > -		return PTR_ERR(sva);
> > -	}
> > -
> > -	pasid = iommu_sva_get_pasid(sva);
> > -	if (pasid == IOMMU_PASID_INVALID) {
> > -		iommu_sva_unbind_device(sva);
> > -		return -ENODEV;
> > +	ret = iommu_enable_pasid_dma(&idxd->pdev->dev, &pasid);
> > +	if (ret) {
> > +		dev_err(&idxd->pdev->dev, "No DMA PASID %d\n", ret);
> > +		return ret;
> >  	}
> > -
> > -	idxd->sva = sva;
> >  	idxd->pasid = pasid;
> > -	dev_dbg(&idxd->pdev->dev, "system pasid: %u\n", pasid);
> > +
> >  	return 0;
> >  }
> > 
> >  static void idxd_disable_system_pasid(struct idxd_device *idxd)
> >  {
> > -
> > -	iommu_sva_unbind_device(idxd->sva);
> > -	idxd->sva = NULL;
> > +	iommu_disable_pasid_dma(&idxd->pdev->dev, idxd->pasid);
> >  }
> > 
> >  static int idxd_probe(struct idxd_device *idxd)
> > @@ -524,10 +511,7 @@ static int idxd_probe(struct idxd_device *idxd)
> >  		} else {
> >  			dev_warn(dev, "Unable to turn on SVA
> > feature.\n"); }
> > -	} else if (!sva) {
> > -		dev_warn(dev, "User forced SVA off via module
> > param.\n");  
> 
> why removing above 2 lines? they are related to a module param thus
> not affected by the logic in this series.
> 
This should be in a separate patch. I consulted with Dave, sva module param
is not needed anymore.
Thanks for pointing it out.

> >  	}
> > -
> >  	idxd_read_caps(idxd);
> >  	idxd_read_table_offsets(idxd);
> > 
> > diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
> > index 7e19ab92b61a..fde6656695ba 100644
> > --- a/drivers/dma/idxd/sysfs.c
> > +++ b/drivers/dma/idxd/sysfs.c
> > @@ -839,13 +839,6 @@ static ssize_t wq_name_store(struct device *dev,
> >  	if (strlen(buf) > WQ_NAME_SIZE || strlen(buf) == 0)
> >  		return -EINVAL;
> > 
> > -	/*
> > -	 * This is temporarily placed here until we have SVM support
> > for
> > -	 * dmaengine.
> > -	 */
> > -	if (wq->type == IDXD_WQT_KERNEL && device_pasid_enabled(wq-  
> > >idxd))  
> > -		return -EOPNOTSUPP;
> > -
> >  	memset(wq->name, 0, WQ_NAME_SIZE + 1);
> >  	strncpy(wq->name, buf, WQ_NAME_SIZE);
> >  	strreplace(wq->name, '\n', '\0');
> > --
> > 2.25.1  
> 


Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
