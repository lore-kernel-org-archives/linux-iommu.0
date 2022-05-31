Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5EEAC433FE
	for <iommu@archiver.kernel.org>; Tue, 31 May 2022 20:40:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 71661833A3;
	Tue, 31 May 2022 20:40:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WhNZ5yskcHdV; Tue, 31 May 2022 20:40:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6799883312;
	Tue, 31 May 2022 20:40:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 468FCC0039;
	Tue, 31 May 2022 20:40:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 05ADEC002D
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 20:40:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D8DE360FCB
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 20:40:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h-qgAlcxLjk5 for <iommu@lists.linux-foundation.org>;
 Tue, 31 May 2022 20:40:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4101D60EF5
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 20:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1654029618; x=1685565618;
 h=date:from:to:cc:subject:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xVNourZTR1Kt6OmuqtuVyyuHWlgFnrM3yUwYczvadfk=;
 b=guIBtYHTLDmo0cuQ3j3nNkuk/tQ25TaEd/EVhKoiv+ZWpbJtq+mv2EkY
 jEBLzm7eYuUm//xLZ554O8gzhJh9B244elaXs4enR+0f/M2arb873PLWX
 rP7yxh6jlU4YmEWGZ3mR2dnRGHwIB58IqfWS36hcGVOl0UK1ZEHVQ8FDI
 Q4ESbPv4bLe7O3cBWcVH8FUwdFzx+BqPRxcr4Od46BfE+J0bt7n/qXChE
 WGHl7msJOyxs0e8fu7AU8JsxduYJt2yD0nLcIqlMTXzYBr506GPua0hV3
 DJw7pnlGPbP4nSjv7rRslviMJiMXxLQKnxJvG7Vrpp8xTVW0gtnSH44yV w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="257449621"
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; d="scan'208";a="257449621"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 May 2022 13:40:17 -0700
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; d="scan'208";a="612003367"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 May 2022 13:40:17 -0700
Date: Tue, 31 May 2022 13:44:14 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v4 1/6] iommu: Add a per domain PASID for DMA API
Message-ID: <20220531134414.37a62c88@jacob-builder>
In-Reply-To: <20220531190550.GK1343366@nvidia.com>
References: <20220518182120.1136715-1-jacob.jun.pan@linux.intel.com>
 <20220518182120.1136715-2-jacob.jun.pan@linux.intel.com>
 <20220524135034.GU1343366@nvidia.com>
 <20220524081727.19c2dd6d@jacob-builder>
 <20220530122247.GY1343366@nvidia.com>
 <BN9PR11MB52768105FC4FB959298F8A188CDC9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <628aa885-dd12-8bcd-bfc6-446345bf69ed@linux.intel.com>
 <20220531102955.6618b540@jacob-builder>
 <20220531190550.GK1343366@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "vkoul@kernel.org" <vkoul@kernel.org>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Jiang, Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "will@kernel.org" <will@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 David Woodhouse <dwmw2@infradead.org>
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

On Tue, 31 May 2022 16:05:50 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, May 31, 2022 at 10:29:55AM -0700, Jacob Pan wrote:
> 
> > The reason why I store PASID at IOMMU domain is for IOTLB flush within
> > the domain. Device driver is not aware of domain level IOTLB flush. We
> > also have iova_cookie for each domain which essentially is for
> > RIDPASID.  
> 
> You need to make the PASID stuff work generically.
> 
> The domain needs to hold a list of all the places it needs to flush
> and that list needs to be maintained during attach/detach.
> 
> A single PASID on the domain is obviously never going to work
> generically.
> 
I agree, I did it this way really meant to be part of iommu_domain's
iommu_dma_cookie, not meant to be global. But for the lack of common
storage between identity domain and dma domain, I put it here as global.

Then should we also extract RIDPASID to become part of the generic API?
i.e. set pasid, flush IOTLB etc. Right? RIDPASID is not in group's
pasid_array today.

Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
