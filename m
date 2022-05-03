Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 869B8C433F5
	for <iommu@archiver.kernel.org>; Tue,  3 May 2022 18:09:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2222383486;
	Tue,  3 May 2022 18:09:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IGHtoKiZQwd2; Tue,  3 May 2022 18:09:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E7433825CA;
	Tue,  3 May 2022 18:09:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BA0EEC0039;
	Tue,  3 May 2022 18:09:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 646E0C002D
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 18:09:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4C11183417
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 18:09:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hgclSYZ2Bwru for <iommu@lists.linux-foundation.org>;
 Tue,  3 May 2022 18:09:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 52C7D825CA
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 18:09:49 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id dk23so34955407ejb.8
 for <iommu@lists.linux-foundation.org>; Tue, 03 May 2022 11:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=9gjEyY8o65rJfUi2R/5q726th223KCfR89ZxIyy7Kvw=;
 b=ZNqaq/uE1FvHcpZ723NGH4mJuGNVsmIWAFT1HzkYo+YbUPOssbd8ZiZtdVi99Hsm+D
 ftZ0CpOSqPqAmBbDjy5WSC8rKUrwO/pDLOzEPkMG9MBpWKlCDLE+9eiBnOswGbhRYPO7
 k4Ec6IWtjWfqKNpTKPBJ+bgZkFotwJSXkFohEHaZdGkeKCbRuFmG1RDCtEtOPzdqO7Tz
 2z8wJ3hQgSS6Hna69kwpTbOTtAd1dOXSkBI9ApHUuummyXmXKYoiZ+EiHj6TTfe7G0y/
 b86duNQGCx1bfFEPhDi+0RqyNIm+SdQ9dpA/VzRzj7pnDVf4/ddErdeYhQrO0h8WQoxe
 0R+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=9gjEyY8o65rJfUi2R/5q726th223KCfR89ZxIyy7Kvw=;
 b=NLESlxD86EDZR8rAMlRScpHL9IIcTGWgIuMp1OBNGX72I5ZGo87RxmiJM6Txu39b0U
 88nW0kZ4jDlLnYV8vtxuFETDJ+k3na56pKIFielTtOYvOzpkkLaTHHLkQ+woVgsZajyZ
 5CPLrYnNaC2ABCNuHXkzPOFOPzaVQo9XrMtFVDqjPq9/3HLXHBTrZ4pVw7k9bu9Kz6rq
 S3hdGUIhg3TLkRy93bmLdD4a//R5C/htvuxFkFw2aBeismO2p7+3cfF83filqssl56aD
 SPudRMeDTpF7zJ9OzTdGtD3zVLUv0xF7nDMAo1ItjwgFY6Vuc1wjdjdxsVqTSJDGuV1s
 NxMA==
X-Gm-Message-State: AOAM533YPG++UdgPcDvbseQ90Dj+dmbM861yrIVvIpb2qUSp2p2XduKn
 O4rIZ810Txutl8D6uO/0dBFJgw==
X-Google-Smtp-Source: ABdhPJzYXKl6dp62p9Rbi2ZyThioE95HacheutFqLriaESUvTzwQS+VWO2cmCUDs03Vv6PniXk/ZdA==
X-Received: by 2002:a17:906:a08b:b0:6b9:2e20:f139 with SMTP id
 q11-20020a170906a08b00b006b92e20f139mr17550173ejy.463.1651601387539; 
 Tue, 03 May 2022 11:09:47 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168]) by smtp.gmail.com with ESMTPSA id
 s8-20020aa7cb08000000b0042617ba638csm8058733edt.22.2022.05.03.11.09.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 May 2022 11:09:46 -0700 (PDT)
Date: Tue, 3 May 2022 19:09:22 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v5 04/12] iommu/sva: Basic data structures for SVA
Message-ID: <YnFv0ps0Ad8v+7uH@myrica>
References: <20220502014842.991097-1-baolu.lu@linux.intel.com>
 <20220502014842.991097-5-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220502014842.991097-5-baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Vinod Koul <vkoul@kernel.org>, Jacob jun Pan <jacob.jun.pan@intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Will Deacon <will@kernel.org>
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

On Mon, May 02, 2022 at 09:48:34AM +0800, Lu Baolu wrote:
> Use below data structures for SVA implementation in the IOMMU core:
> 
> - struct iommu_sva_ioas
>   Represent the I/O address space shared with an application CPU address
>   space. This structure has a 1:1 relationship with an mm_struct. It
>   grabs a "mm->mm_count" refcount during creation and drop it on release.

Do we actually need this structure?  At the moment it only keeps track of
bonds, which we can move to struct dev_iommu. Replacing it by a mm pointer
in struct iommu_domain simplifies the driver and seems to work

Thanks,
Jean

> 
> - struct iommu_domain (IOMMU_DOMAIN_SVA type)
>   Represent a hardware pagetable that the IOMMU hardware could use for
>   SVA translation. Multiple iommu domains could be bound with an SVA ioas
>   and each grabs a refcount from ioas in order to make sure ioas could
>   only be freed after all domains have been unbound.
> 
> - struct iommu_sva
>   Represent a bond relationship between an SVA ioas and an iommu domain.
>   If a bond already exists, it's reused and a reference is taken.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  include/linux/iommu.h         | 14 +++++++++++++-
>  drivers/iommu/iommu-sva-lib.h |  1 +
>  drivers/iommu/iommu-sva-lib.c | 18 ++++++++++++++++++
>  3 files changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index ab36244d4e94..f582f434c513 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -42,6 +42,7 @@ struct notifier_block;
>  struct iommu_sva;
>  struct iommu_fault_event;
>  struct iommu_dma_cookie;
> +struct iommu_sva_ioas;
>  
>  /* iommu fault flags */
>  #define IOMMU_FAULT_READ	0x0
> @@ -64,6 +65,9 @@ struct iommu_domain_geometry {
>  #define __IOMMU_DOMAIN_PT	(1U << 2)  /* Domain is identity mapped   */
>  #define __IOMMU_DOMAIN_DMA_FQ	(1U << 3)  /* DMA-API uses flush queue    */
>  
> +#define __IOMMU_DOMAIN_SHARED	(1U << 4)  /* Page table shared from CPU  */
> +#define __IOMMU_DOMAIN_HOST_VA	(1U << 5)  /* Host CPU virtual address */
> +
>  /*
>   * This are the possible domain-types
>   *
> @@ -86,6 +90,8 @@ struct iommu_domain_geometry {
>  #define IOMMU_DOMAIN_DMA_FQ	(__IOMMU_DOMAIN_PAGING |	\
>  				 __IOMMU_DOMAIN_DMA_API |	\
>  				 __IOMMU_DOMAIN_DMA_FQ)
> +#define IOMMU_DOMAIN_SVA	(__IOMMU_DOMAIN_SHARED |	\
> +				 __IOMMU_DOMAIN_HOST_VA)
>  
>  struct iommu_domain {
>  	unsigned type;
> @@ -95,6 +101,7 @@ struct iommu_domain {
>  	void *handler_token;
>  	struct iommu_domain_geometry geometry;
>  	struct iommu_dma_cookie *iova_cookie;
> +	struct iommu_sva_ioas *sva_ioas;
>  };
>  
>  static inline bool iommu_is_dma_domain(struct iommu_domain *domain)
> @@ -628,7 +635,12 @@ struct iommu_fwspec {
>   * struct iommu_sva - handle to a device-mm bond
>   */
>  struct iommu_sva {
> -	struct device			*dev;
> +	struct device		*dev;
> +	struct iommu_sva_ioas	*sva_ioas;
> +	struct iommu_domain	*domain;
> +	/* Link to sva ioas's bonds list */
> +	struct list_head	node;
> +	refcount_t		users;
>  };
>  
>  int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
> diff --git a/drivers/iommu/iommu-sva-lib.h b/drivers/iommu/iommu-sva-lib.h
> index 8909ea1094e3..9c5e108e2c8a 100644
> --- a/drivers/iommu/iommu-sva-lib.h
> +++ b/drivers/iommu/iommu-sva-lib.h
> @@ -10,6 +10,7 @@
>  
>  int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max);
>  struct mm_struct *iommu_sva_find(ioasid_t pasid);
> +struct mm_struct *iommu_sva_domain_mm(struct iommu_domain *domain);
>  
>  /* I/O Page fault */
>  struct device;
> diff --git a/drivers/iommu/iommu-sva-lib.c b/drivers/iommu/iommu-sva-lib.c
> index 106506143896..d524a402be3b 100644
> --- a/drivers/iommu/iommu-sva-lib.c
> +++ b/drivers/iommu/iommu-sva-lib.c
> @@ -3,6 +3,8 @@
>   * Helpers for IOMMU drivers implementing SVA
>   */
>  #include <linux/mutex.h>
> +#include <linux/iommu.h>
> +#include <linux/slab.h>
>  #include <linux/sched/mm.h>
>  
>  #include "iommu-sva-lib.h"
> @@ -10,6 +12,22 @@
>  static DEFINE_MUTEX(iommu_sva_lock);
>  static DECLARE_IOASID_SET(iommu_sva_pasid);
>  
> +struct iommu_sva_ioas {
> +	struct mm_struct *mm;
> +	ioasid_t pasid;
> +
> +	/* Counter of domains attached to this ioas. */
> +	refcount_t users;
> +
> +	/* All bindings are linked here. */
> +	struct list_head bonds;
> +};
> +
> +struct mm_struct *iommu_sva_domain_mm(struct iommu_domain *domain)
> +{
> +	return domain->sva_ioas->mm;
> +}
> +
>  /**
>   * iommu_sva_alloc_pasid - Allocate a PASID for the mm
>   * @mm: the mm
> -- 
> 2.25.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
