Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB133C433F5
	for <iommu@archiver.kernel.org>; Wed, 11 May 2022 07:55:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7BB4B60881;
	Wed, 11 May 2022 07:55:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R0ahvy1XS5s0; Wed, 11 May 2022 07:55:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6648660BD7;
	Wed, 11 May 2022 07:55:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3CF2CC0039;
	Wed, 11 May 2022 07:55:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 73B36C002D
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:55:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5B4F2404F0
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:55:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zKxDyKid8eE8 for <iommu@lists.linux-foundation.org>;
 Wed, 11 May 2022 07:55:06 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 841AB4011F
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:55:06 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id bv19so2351422ejb.6
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 00:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=T+vt0ZVMpAStN8vtcO/W3H1y3FeI0bv62I6/uRsSEhc=;
 b=eMxDIQet9ahQhMdVrUMgQwkO/EsYnZNzv1UJDALKOX2rvcys5c3H8xAiH3t2OPUist
 k4fwOMS1K82o9wu0H71ne7MF1fN1pM8DeSYZAxfh+twlzgYbpgy1xUJMayjXiqfC2/AQ
 3qFqRtxN0o4QogT5xFHTW/YwqwbQM3OfJJPILkI8wW348+Km7BHGDfak3ERAZWL6PiGx
 n7hd/6dDe++fqJ5eJjKPQ1LZgvzSD7vNfySoL3i0CLpaEoj7NHQlQ7A16n6LisC2o6d+
 X+oBfXKYs7I63iQPWJGL0m3E6JsVafv2SPPCIxC8hi1NLit0KYzv6DItaL30wSX9bkYY
 Q9WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=T+vt0ZVMpAStN8vtcO/W3H1y3FeI0bv62I6/uRsSEhc=;
 b=5+s6LDSIbHHvwUoTpN+D14cTVF+GfDbBS1fALQ00E0ZqgcT3qj/joTRRRp8HRWk6m2
 HCZRHSDLdtZvxmh6Xho5iHy51hhAsBtLP+ywShoRF9me0EpQ0SwuVNQ8pYVwPWgDkqUH
 duY0U5YTTufrDyGiO5ECWoD8FHA0tT1XWvoYhKaZF79dHN1IjuRiTmoBwWyzY6wLgfYG
 qfgq0HY1t1o8P2RIq0/LmEC7L/42M3KIhLqDpTr+G8kBn6TF9HpM4R/d/SlouqO1fnS8
 agBjKecqXw65RA7w8ON0ajQ6EwM8soXql75x5J9d/cZYUQCHTyprlRI+vajJl3luEVqH
 Hagw==
X-Gm-Message-State: AOAM532lnUf0ub1y3lPpNNj+FCA8AWWp1uQRDS+Cs0j8Yn7gNhIIKd4o
 vqWf6MoqR8QhfrArEGYa6yJ4pw==
X-Google-Smtp-Source: ABdhPJxl7ACcQ41IVyVSbAYdpPFjcDLn4U4wPVNWNsH0JdN+uXZ/yJbWCQZIxSwd0i10FQWlfGheLA==
X-Received: by 2002:a17:907:971b:b0:6f4:3b8c:ae04 with SMTP id
 jg27-20020a170907971b00b006f43b8cae04mr23406515ejc.548.1652255704732; 
 Wed, 11 May 2022 00:55:04 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168]) by smtp.gmail.com with ESMTPSA id
 t17-20020a17090605d100b006f3ef214e50sm638962ejt.182.2022.05.11.00.55.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 May 2022 00:55:04 -0700 (PDT)
Date: Wed, 11 May 2022 08:54:39 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH v6 03/12] iommu: Add attach/detach_dev_pasid domain ops
Message-ID: <Yntrv+nq2t/IeVo2@myrica>
References: <20220510061738.2761430-1-baolu.lu@linux.intel.com>
 <20220510061738.2761430-4-baolu.lu@linux.intel.com>
 <20220510140238.GD49344@nvidia.com>
 <f56ea479-aa82-37ae-91c3-754816a4ed8b@linux.intel.com>
 <BN9PR11MB5276100AC9BBB7DE5CB800CF8CC89@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276100AC9BBB7DE5CB800CF8CC89@BN9PR11MB5276.namprd11.prod.outlook.com>
Cc: "Jiang, Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Robin Murphy <robin.murphy@arm.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Vinod Koul <vkoul@kernel.org>, "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
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

On Wed, May 11, 2022 at 04:09:14AM +0000, Tian, Kevin wrote:
> > From: Baolu Lu <baolu.lu@linux.intel.com>
> > Sent: Wednesday, May 11, 2022 10:32 AM
> > 
> > On 2022/5/10 22:02, Jason Gunthorpe wrote:
> > > On Tue, May 10, 2022 at 02:17:29PM +0800, Lu Baolu wrote:
> > >
> > >> This adds a pair of common domain ops for this purpose and adds
> > helpers
> > >> to attach/detach a domain to/from a {device, PASID}.
> > >
> > > I wonder if this should not have a detach op - after discussing with
> > > Robin we can see that detach_dev is not used in updated
> > > drivers. Instead attach_dev acts as 'set_domain'
> > >
> > > So, it would be more symmetrical if attaching a blocking_domain to the
> > > PASID was the way to 'detach'.
> > >
> > > This could be made straightforward by following the sketch I showed to
> > > have a static, global blocing_domain and providing a pointer to it in
> > > struct iommu_ops
> > >
> > > Then 'detach pasid' is:
> > >
> > > iommu_ops->blocking_domain->ops->attach_dev_pasid(domain, dev,
> > pasid);
> > >
> > > And we move away from the notion of 'detach' and in the direction that
> > > everything continuously has a domain set. PASID would logically
> > > default to blocking_domain, though we wouldn't track this anywhere.
> > 
> > I am not sure whether we still need to keep the blocking domain concept
> > when we are entering the new PASID world. Please allow me to wait and
> > listen to more opinions.
> > 
> 
> I'm with Jason on this direction. In concept after a PASID is detached it's
> essentially blocked. Implementation-wise it doesn't prevent the iommu
> driver from marking the PASID entry as non-present as doing in this
> series instead of actually pointing to the empty page table of the block
> domain. But api-wise it does make the entire semantics more consistent.

This is all internal to IOMMU so I don't think we should be concerned
about API consistency. I prefer a straighforward detach() operation
because that way IOMMU drivers don't have to keep track of which domain is
attached to which PASID. That code can be factored into the IOMMU core.

In addition to clearing contexts, detach() also needs to invalidate TLBs,
and for that the SMMU driver needs to know the old ASID (!= PASID) that
was used by the context descriptor. We can certainly work around a missing
detach() to implement this, but it will be convoluted.

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
