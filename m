Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D88DAC433EF
	for <iommu@archiver.kernel.org>; Tue, 15 Mar 2022 16:34:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8D28040414;
	Tue, 15 Mar 2022 16:34:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dexN1pRbp52U; Tue, 15 Mar 2022 16:34:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1185340012;
	Tue, 15 Mar 2022 16:34:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E6AB6C001A;
	Tue, 15 Mar 2022 16:34:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CE937C000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 16:34:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BCD91832D0
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 16:34:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G55yJ0cLdTq5 for <iommu@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 16:34:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DCA2E827AA
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 16:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647362095; x=1678898095;
 h=date:from:to:cc:subject:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5fe4aIhHkHpe8XfCx1caZ69+mJj0mxiFQCb/xeqLijs=;
 b=Cu1LIVNoVZ2Alg3gJk1mwAVJkZ9sYKYF4UETiW5Qlv3ZIaF241DlHtHr
 F31AaYNgaTxlwTmqidJiUZMYnlq+oNZHg9g+c37/SlCNIRBO58zoHFtGN
 eGdKghCfK55JVJfyE4awjB2j83/kRDZFrjeqtD+bhLvGzZ3BsWQBcw3ya
 V624SsyMd+JIvhnabBNM4QL8uqEtq3b0bicUM2b+T3tqqbOVTnS5CyziF
 uqp7kEVzHd4vfCdFi/3glLCNDmDr9TgyTOE/xbEpeyEQG3x0zpw8/YYwf
 /DpbCgvh0JT2PcHsW645nkbFOgBkZe0X8HrNHTSuS75A1BwQ4rD95EAVV A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="236298782"
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; d="scan'208";a="236298782"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2022 09:34:55 -0700
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; d="scan'208";a="690257656"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2022 09:34:54 -0700
Date: Tue, 15 Mar 2022 09:38:10 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v2 5/8] iommu: Add PASID support for DMA mapping API users
Message-ID: <20220315093810.4b4c5ebf@jacob-builder>
In-Reply-To: <20220315143535.GX11336@nvidia.com>
References: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
 <20220315050713.2000518-6-jacob.jun.pan@linux.intel.com>
 <20220315143535.GX11336@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Tony Luck <tony.luck@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Raj Ashok <ashok.raj@intel.com>, "Zanussi, 
 Tom" <tom.zanussi@intel.com>, "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
 LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>,
 iommu@lists.linux-foundation.org, Jacob Pan <jacob.jun.pan@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
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

Hi Jason,

On Tue, 15 Mar 2022 11:35:35 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Mon, Mar 14, 2022 at 10:07:09PM -0700, Jacob Pan wrote:
> > DMA mapping API is the de facto standard for in-kernel DMA. It operates
> > on a per device/RID basis which is not PASID-aware.
> > 
> > Some modern devices such as Intel Data Streaming Accelerator, PASID is
> > required for certain work submissions. To allow such devices use DMA
> > mapping API, we need the following functionalities:
> > 1. Provide device a way to retrieve a PASID for work submission within
> > the kernel
> > 2. Enable the kernel PASID on the IOMMU for the device
> > 3. Attach the kernel PASID to the device's default DMA domain, let it
> > be IOVA or physical address in case of pass-through.
> > 
> > This patch introduces a driver facing API that enables DMA API
> > PASID usage. Once enabled, device drivers can continue to use DMA APIs
> > as is. There is no difference in dma_handle between without PASID and
> > with PASID.
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> >  drivers/iommu/dma-iommu.c | 65 +++++++++++++++++++++++++++++++++++++++
> >  include/linux/dma-iommu.h |  7 +++++
> >  include/linux/iommu.h     |  9 ++++++
> >  3 files changed, 81 insertions(+)
> > 
> > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > index b22034975301..d0ff1a34b1b6 100644
> > +++ b/drivers/iommu/dma-iommu.c
> > @@ -39,6 +39,8 @@ enum iommu_dma_cookie_type {
> >  	IOMMU_DMA_MSI_COOKIE,
> >  };
> >  
> > +static DECLARE_IOASID_SET(iommu_dma_pasid);
> > +
> >  struct iommu_dma_cookie {
> >  	enum iommu_dma_cookie_type	type;
> >  	union {
> > @@ -370,6 +372,69 @@ void iommu_put_dma_cookie(struct iommu_domain
> > *domain) domain->iova_cookie = NULL;
> >  }
> >  
> > +/**
> > + * iommu_enable_pasid_dma --Enable in-kernel DMA request with PASID
> > + * @dev:	Device to be enabled
> > + *
> > + * DMA request with PASID will be mapped the same way as the legacy
> > DMA.
> > + * If the device is in pass-through, PASID will also pass-through. If
> > the
> > + * device is in IOVA map, the supervisor PASID will point to the same
> > IOVA
> > + * page table.
> > + *
> > + * @return the kernel PASID to be used for DMA or INVALID_IOASID on
> > failure
> > + */
> > +int iommu_enable_pasid_dma(struct device *dev, ioasid_t *pasid)
> > +{
> > +	struct iommu_domain *dom;
> > +	ioasid_t id, max;
> > +	int ret;
> > +
> > +	dom = iommu_get_domain_for_dev(dev);
> > +	if (!dom || !dom->ops || !dom->ops->attach_dev_pasid)
> > +		return -ENODEV;  
> 
> Given the purpose of this API I think it should assert that the device
> has the DMA API in-use using the machinery from the other series.
> 
> ie this should not be used to clone non-DMA API iommu_domains..
> 
Let me try to confirm the specific here. I should check domain type and
rejects all others except IOMMU_DOMAIN_DMA type, right? Should also allow
IOMMU_DOMAIN_IDENTITY.

That makes sense.

> > diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
> > index 24607dc3c2ac..e6cb9b52a420 100644
> > +++ b/include/linux/dma-iommu.h
> > @@ -18,6 +18,13 @@ int iommu_get_dma_cookie(struct iommu_domain
> > *domain); int iommu_get_msi_cookie(struct iommu_domain *domain,
> > dma_addr_t base); void iommu_put_dma_cookie(struct iommu_domain
> > *domain); 
> > +/*
> > + * For devices that can do DMA request with PASID, setup a system
> > PASID.
> > + * Address modes (IOVA, PA) are selected by the platform code.
> > + */
> > +int iommu_enable_pasid_dma(struct device *dev, ioasid_t *pasid);
> > +void iommu_disable_pasid_dma(struct device *dev, ioasid_t pasid);  
> 
> The functions already have a kdoc, don't need two..
> 
Good point!

Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
