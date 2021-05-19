Return-Path: <SRS0=NBt+=KO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 344CDC433ED
	for <iommu@archiver.kernel.org>; Wed, 19 May 2021 15:43:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C67B7613B4
	for <iommu@archiver.kernel.org>; Wed, 19 May 2021 15:43:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C67B7613B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 888354061A;
	Wed, 19 May 2021 15:43:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fe8I4ZHfYRCX; Wed, 19 May 2021 15:43:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 393EA40501;
	Wed, 19 May 2021 15:43:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E28E0C000E;
	Wed, 19 May 2021 15:43:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 267DCC0001
 for <iommu@lists.linux-foundation.org>; Wed, 19 May 2021 15:43:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 12A4A60719
 for <iommu@lists.linux-foundation.org>; Wed, 19 May 2021 15:43:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ty7NWo3ouUZQ for <iommu@lists.linux-foundation.org>;
 Wed, 19 May 2021 15:43:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CDA7C60710
 for <iommu@lists.linux-foundation.org>; Wed, 19 May 2021 15:43:40 +0000 (UTC)
IronPort-SDR: A+ExD6m3xMvp510VZ8ZHXBGIbR+8QMUIyECbuc5sXXFEWTELjWBiHGpi7MDYP9KZBLrt/ATtlD
 ZglRKxefNxyQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9989"; a="199053417"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; d="scan'208";a="199053417"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2021 08:43:39 -0700
IronPort-SDR: Rq6mGhGWq0ocMcxjGSwqTjh0L6uzNef5+zlx/xUruW8mle889BFq5V15MgpXgpVzGdaiT+Qbx5
 b8/+T5xnypYQ==
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; d="scan'208";a="395307475"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2021 08:43:39 -0700
Date: Wed, 19 May 2021 08:46:08 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v4 1/2] iommu/sva: Tighten SVA bind API with explicit flags
Message-ID: <20210519084608.3d498169@jacob-builder>
In-Reply-To: <20210517143758.GP1002214@nvidia.com>
References: <20210513173303.GL1002214@nvidia.com>
 <20210513185349.GA801495@agluck-desk2.amr.corp.intel.com>
 <20210513190040.GR1002214@nvidia.com>
 <e9dd39aa8a144c23beffa5ca58936385@intel.com>
 <20210513192014.GU1002214@nvidia.com>
 <20210513124621.01421173@jacob-builder>
 <20210513195749.GA801830@agluck-desk2.amr.corp.intel.com>
 <20210513132251.0ff89b90@jacob-builder>
 <20210513223122.GV1002214@nvidia.com>
 <20210513164028.6e2d6e59@jacob-builder>
 <20210517143758.GP1002214@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "vkoul@kernel.org" <vkoul@kernel.org>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Luck, Tony" <tony.luck@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, David Woodhouse <dwmw2@infradead.org>,
 LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
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

On Mon, 17 May 2021 11:37:58 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Thu, May 13, 2021 at 04:40:28PM -0700, Jacob Pan wrote:
> 
> > Looks like we are converging. Let me summarize the takeaways:
> > 1. Remove IOMMU_SVA_BIND_SUPERVISOR flag from this patch, in fact there
> > will be no flags at all for iommu_sva_bind_device()
> > 2. Remove all supervisor SVA related vt-d, idxd code.
> > 3. Create API iommu_setup_system_pasid_direct_map(option_flag)
> > 	if (option_flag == 1)
> > 		iommu_domain_alloc(IOMMU_DOMAIN_DMA);
> > 	if (option_flag == 2)
> > 		iommu_domain_alloc(IOMMU_DOMAIN_DIRECT); //new domain
> > type? setup IOMMU page tables mirroring the direct map
> > 4. Create API iommu_enable_dev_direct_map(struct dev, &pasid, &option)
> > 	- Drivers call this API to get the system PASID and which
> > option is available on the system PASID
> > 	- mark device as PASID only, perhaps a new flag in struct
> > 	device->dev_iommu->pasid_only = 1
> > 5. DMA API IOMMU vendor ops will take action based on the pasid_only
> > flag to decide if the mapping is for system PASID page tables.
> > 
> > Does it make sense?  
> 
> I think you will run into trouble with that approach when you get to
> patches..
> 
> For 'option 1' what you want is an API that is 'give me a PASID that
> is equivalent to the RID'.
> 
> Then all the DMA API operations map IO page tables to both RID and
> PASID access. For the direct mode the PASID and RID will both point at
> the shared all physical memory IO page table.
> 
> Otherwise the DMA API won't care if the device is using RID or PASID,
> if it needs to map a range it does it to the shared IO page table and
> flushes both the RID and PASID based caches.
> 
> Then the driver will use the normal DMA API with its normal struct
> pci_device and simply tell the HW to do DMA TLP's with the returned
> PASID.
> 
> For 'option 2' it should be a completely different API family.
> 
Make sense, thanks for the suggestions.

> Jason


Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
