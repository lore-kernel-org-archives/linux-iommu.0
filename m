Return-Path: <SRS0=Hf/t=64=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 714FDC433E0
	for <iommu@archiver.kernel.org>; Thu, 14 May 2020 10:50:33 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32F5F20575
	for <iommu@archiver.kernel.org>; Thu, 14 May 2020 10:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dXTFxbV4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32F5F20575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id DF62A8891D;
	Thu, 14 May 2020 10:50:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1j3Xq8grGMKn; Thu, 14 May 2020 10:50:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id C32FF88677;
	Thu, 14 May 2020 10:50:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A038FC0178;
	Thu, 14 May 2020 10:50:31 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3499CC016F
 for <iommu@lists.linux-foundation.org>; Thu, 14 May 2020 10:50:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 1B86A886CD
 for <iommu@lists.linux-foundation.org>; Thu, 14 May 2020 10:50:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vSCfGVXsiESg for <iommu@lists.linux-foundation.org>;
 Thu, 14 May 2020 10:50:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
 [209.85.221.67])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9E36E88222
 for <iommu@lists.linux-foundation.org>; Thu, 14 May 2020 10:50:28 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id v12so3282329wrp.12
 for <iommu@lists.linux-foundation.org>; Thu, 14 May 2020 03:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=38QmTxTEvJ+S2RAZ0sqfJydd1bsWIjyWyPL61uxbueE=;
 b=dXTFxbV4xPkr5lF2OCPKqUedgY0t6sReFjLznPu8135QK1a7rG1EDc7ReEtI+gsX1h
 9nhI7PGvc/jd2PFL3fifUvYOGN+czY8t1oia8m+HcwcgEH7qC3hmBXDtVGofOoNjEIDF
 +2oqoMus5jTzc2G8j14KYFk4pXUokob/sWThr/k4MNOy9fZLL8bBZoV7IWl7lDWBCDz+
 +9yowUBLrz6Upsqvh+Au4cUJ+7qcROlpazLY8IYe1eYkoFzm08OwcNJYl5sWVDMuaJQX
 H7EKrdPecwNVecOO8hsM00VbT366cc9mPfmKH/CWt25eLTsiZSNQCcuqh1/eL/5kw9NR
 iG2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=38QmTxTEvJ+S2RAZ0sqfJydd1bsWIjyWyPL61uxbueE=;
 b=QMSYB/cprVJ3SEcSLA73nwjnRVewyIDQFFOpfDhGaVVD9VaylWVAPtWVS4I0sAOicw
 ZXqKY7ytGgZ3MjW5y0lgy6AAzR9m0GlKnB2q2ogtKHVpQBJt6skieSD5+UiOHjkyUlCe
 zHLiSo2mVgeVnsMd9Gvnnp9kPEh3SsGcVgUVI4jl21zjwPHWDSg/AfN8dWmcJ0PaYL2w
 kQJiQ7JuIGIMXqMB0VyppUq6m8+4gfAKoNY3x0tDx802OwuCkbt8t5/w141dNr5hQ+ZJ
 sqsTNLth377Zr3KRI1maa1brNOXpsgbfz/nEzMKxw6eOr8H+wHe6I+Z91Tt9N7ibersZ
 lImQ==
X-Gm-Message-State: AOAM533pUfEDYqd/CtSHl1lMQRgdsNLDv4Ruo2fAnMNGIS6T//I8N2Z8
 PFWBK7WGLPYW7ZCCRDJAEoBVVw==
X-Google-Smtp-Source: ABdhPJylSdZ+y+t7WLaiGVL0w8Eft2SxOfv0jQvv/uh4mawVTFMnwcN4CUndqM6JXoUXPa2i1y2wyQ==
X-Received: by 2002:adf:d0d1:: with SMTP id z17mr5069970wrh.175.1589453426540; 
 Thu, 14 May 2020 03:50:26 -0700 (PDT)
Received: from myrica ([2001:171b:226e:c200:c43b:ef78:d083:b355])
 by smtp.gmail.com with ESMTPSA id g135sm22120343wme.22.2020.05.14.03.50.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 03:50:26 -0700 (PDT)
Date: Thu, 14 May 2020 12:50:16 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v6] iommu/virtio: Use page size bitmap supported by
 endpoint
Message-ID: <20200514105016.GA2252@myrica>
References: <20200514075237.3941-1-bbhushan2@marvell.com>
 <20200514043747-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200514043747-mutt-send-email-mst@kernel.org>
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 Bharat Bhushan <bbhushan2@marvell.com>, jasowang@redhat.com,
 eric.auger.pro@gmail.com
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

On Thu, May 14, 2020 at 05:31:00AM -0400, Michael S. Tsirkin wrote:
> On Thu, May 14, 2020 at 01:22:37PM +0530, Bharat Bhushan wrote:
> > Different endpoint can support different page size, probe
> > endpoint if it supports specific page size otherwise use
> > global page sizes.
> > 
> > Device attached to domain should support a minimum of
> > domain supported page sizes. If device supports more
> > than domain supported page sizes then device is limited
> > to use domain supported page sizes only.
> 
> OK so I am just trying to figure it out.
> Before the patch, we always use the domain supported page sizes
> right?
> 
> With the patch, we still do, but we also probe and
> validate that device supports all domain page sizes,
> if it does not then we fail to attach the device.

Generally there is one endpoint per domain. Linux creates the domains and
decides which endpoint goes in which domain. It puts multiple endpoints in
a domain in two cases:

* If endpoints cannot be isolated from each others by the IOMMU, for
  example if ACS isolation isn't enabled in PCIe. In that case endpoints
  are in the same IOMMU group, and therefore contained in the same domain.
  This is more of a quirk for broken hardware, and isn't much of a concern
  for virtualization because it's easy for the hypervisor to present
  endpoints isolated from each others.

* If userspace wants to put endpoints in the same VFIO container, then
  VFIO first attempts to put them in the same IOMMU domain, and falls back
  to multiple domains if that fails. That case is just a luxury and we
  shouldn't over-complicate the driver to cater for this.

So the attach checks don't need to be that complicated. Checking that the
page masks are exactly the same should be enough.

> This seems like a lot of effort for little benefit, can't
> hypervisor simply make sure endpoints support the
> iommu page sizes for us?

I tend to agree, it's not very likely that we'll have a configuration with
different page sizes between physical and virtual endpoints.

If there is a way for QEMU to simply reject VFIO devices that don't use
the same page mask as what's configured globally, let's do that instead of
introducing the page_size_mask property.

> > @@ -615,7 +636,7 @@ static int viommu_domain_finalise(struct viommu_endpoint *vdev,
> >  	struct viommu_dev *viommu = vdev->viommu;
> >  	struct viommu_domain *vdomain = to_viommu_domain(domain);
> >  
> > -	viommu_page_size = 1UL << __ffs(viommu->pgsize_bitmap);
> > +	viommu_page_size = 1UL << __ffs(vdev->pgsize_bitmap);
> >  	if (viommu_page_size > PAGE_SIZE) {
> >  		dev_err(vdev->dev,
> >  			"granule 0x%lx larger than system page size 0x%lx\n",
> 
> 
> Looks like this is messed up on 32 bit: e.g. 0x100000000 will try to do
> 1UL << -1, which is undefined behaviour. Which is btw already messed up
> wrt viommu->pgsize_bitmap, but that's not a reason to propagate
> the error.

Realistically we're not going to have a page granule larger than 4G, it's
going to be 4k or 64k. But we can add a check that truncates the
page_size_mask to 32-bit and makes sure that it's non-null.

> > +struct virtio_iommu_probe_pgsize_mask {
> > +	struct virtio_iommu_probe_property	head;
> > +	__u8					reserved[4];
> > +	/* Same format as virtio_iommu_config::page_size_mask */
> 
> It's actually slightly different in that
> this must be a superset of domain page size mask, right?

No it overrides the global mask

> > +	__le64					pgsize_bitmap;

Bharat, please rename this to page_size_mask for consistency

Thanks,
Jean

> > +};
> > +
> >  #define VIRTIO_IOMMU_RESV_MEM_T_RESERVED	0
> >  #define VIRTIO_IOMMU_RESV_MEM_T_MSI		1
> >  
> > -- 
> > 2.17.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
