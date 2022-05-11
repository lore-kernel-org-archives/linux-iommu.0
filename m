Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17CD8C433F5
	for <iommu@archiver.kernel.org>; Wed, 11 May 2022 08:01:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B517F404F0;
	Wed, 11 May 2022 08:01:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tQZ5iMJFSbJR; Wed, 11 May 2022 08:01:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6AAB94011F;
	Wed, 11 May 2022 08:01:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 42689C0039;
	Wed, 11 May 2022 08:01:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 58F62C002D
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 08:01:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 370B941883
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 08:01:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KkBq_fwD3i9Z for <iommu@lists.linux-foundation.org>;
 Wed, 11 May 2022 08:01:18 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1405C4186D
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 08:01:17 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id p18so1545919edr.7
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 01:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=M4aeMJFFFKV21hSaluDeCVxCbgPrszET6TE6+DuKZy0=;
 b=pHErwaiX6ufGPbr+xXjlPt1Yc3gEtnWaSm8ytmYX710fnKTCNneuXmpcCLCEGqTExG
 m7Hs6QUMpa2kf0CWT3yM0LTy2PyrJCG8N6qYBW7tQGijpTswQh71X3v6WO+XdWu0TuDe
 09GmCLxd2aNLZu2aOIBXK4Nofo/Fe5dGXd/AkIQ8ZA4sJ3cl31BKatHndrY1YfzV4Cm+
 Oz1Uu7sXr1ERXN6NrCvL7Vi7oHCV30QoCD8jBzDjIsjjJvfrXNxSGICoehoho0L32G9m
 oLc7zw+8k22xvyS5HFxdVTtPJYJTjRW5Ps+XqcmHsp6UZroC3Oe4leN4M4Nu5ri+XNXa
 INXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=M4aeMJFFFKV21hSaluDeCVxCbgPrszET6TE6+DuKZy0=;
 b=4fsbDzW64Sm+WFZGWZ6+8VvBB7yMDIBmINVOr1KkadCXcbNAaX65+w8/9+nWnDua5w
 C5IzV7pne0uq5ZeEVqo6/CnjuRwatAsFmdinU3w6FbNWMl0YaPMAvN9n9wQL9gCEhK/4
 G+xxjdnvMtvnGDDoeON/iesLSPLR0YrWaOAMG6dX9KY4uXd+QjYkY0DASn+lwnFClP6P
 vlYyPV8bEgOOeuA7O9/ZrRpoPrgCaLb7QNu7LdFirqtdzsovU85l0V+YWwdNDXzWVfIM
 xFOEzjSRN5otnItbjkQ/y4XJNO6TcUjV0IB0Wkrh9oilLbEm7GfQH6oU0kk7A0gGao/y
 qzJQ==
X-Gm-Message-State: AOAM533cjv0+yOcYLyO/pqBNwDYniea81hnOS+aynegnvjps/xTZqL9W
 zAop3i5sWzDKhLkYKenZH4yXEg==
X-Google-Smtp-Source: ABdhPJxcUxYehRflQhrWm3q6OieQJAMKNGsZSTynkrhHLPcj2CC9w6aa7qaw0vo2XGXSDh8yqvw2IA==
X-Received: by 2002:a05:6402:e9f:b0:41c:df21:b113 with SMTP id
 h31-20020a0564020e9f00b0041cdf21b113mr27914392eda.217.1652256076253; 
 Wed, 11 May 2022 01:01:16 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168]) by smtp.gmail.com with ESMTPSA id
 h12-20020a05640250cc00b0042617ba63d5sm783085edb.95.2022.05.11.01.01.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 May 2022 01:01:15 -0700 (PDT)
Date: Wed, 11 May 2022 09:00:50 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v6 02/12] iommu: Add pasid_bits field in struct dev_iommu
Message-ID: <YnttMpX2geTKRzVV@myrica>
References: <20220510061738.2761430-1-baolu.lu@linux.intel.com>
 <20220510061738.2761430-3-baolu.lu@linux.intel.com>
 <20220510143405.GE49344@nvidia.com>
 <3fe05f18-6726-276a-8c42-79e0b134dfdc@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3fe05f18-6726-276a-8c42-79e0b134dfdc@linux.intel.com>
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

On Wed, May 11, 2022 at 10:25:48AM +0800, Baolu Lu wrote:
> On 2022/5/10 22:34, Jason Gunthorpe wrote:
> > On Tue, May 10, 2022 at 02:17:28PM +0800, Lu Baolu wrote:
> > 
> > >   int iommu_device_register(struct iommu_device *iommu,
> > > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > index 627a3ed5ee8f..afc63fce6107 100644
> > > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > @@ -2681,6 +2681,8 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
> > >   	    smmu->features & ARM_SMMU_FEAT_STALL_FORCE)
> > >   		master->stall_enabled = true;
> > > +	dev->iommu->pasid_bits = master->ssid_bits;
> > >   	return &smmu->iommu;
> > >   err_free_master:
> > > diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> > > index 2990f80c5e08..99643f897f26 100644
> > > +++ b/drivers/iommu/intel/iommu.c
> > > @@ -4624,8 +4624,11 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
> > >   			if (pasid_supported(iommu)) {
> > >   				int features = pci_pasid_features(pdev);
> > > -				if (features >= 0)
> > > +				if (features >= 0) {
> > >   					info->pasid_supported = features | 1;
> > > +					dev->iommu->pasid_bits =
> > > +						fls(pci_max_pasids(pdev)) - 1;
> > > +				}
> > 
> > It is not very nice that both the iommu drivers have to duplicate the
> > code to read the pasid capability out of the PCI device.
> > 
> > IMHO it would make more sense for the iommu layer to report the
> > capability of its own HW block only, and for the core code to figure
> > out the master's limitation using a bus-specific approach.
> 
> Fair enough. The iommu hardware capability could be reported in
> 
> /**
>  * struct iommu_device - IOMMU core representation of one IOMMU hardware
>  *                       instance
>  * @list: Used by the iommu-core to keep a list of registered iommus
>  * @ops: iommu-ops for talking to this iommu
>  * @dev: struct device for sysfs handling
>  */
> struct iommu_device {
>         struct list_head list;
>         const struct iommu_ops *ops;
>         struct fwnode_handle *fwnode;
>         struct device *dev;
> };
> 
> I haven't checked ARM code yet, but it works for x86 as far as I can
> see.

Arm also supports non-PCI PASID by reading a firmware property:

        device_property_read_u32(dev, "pasid-num-bits", &master->ssid_bits);

should be the only difference

Thanks,
Jean

> 
> > 
> > It is also unfortunate that the enable/disable pasid is inside the
> > iommu driver as well - ideally the PCI driver itself would do this
> > when it knows it wants to use PASIDs.
> > 
> > The ordering interaction with ATS makes this look quite annoying
> > though. :(
> > 
> > I'm also not convinced individual IOMMU drivers should be forcing ATS
> > on, there are performance and functional implications here. Using ATS
> > or not is possibly best left as an administrator policy controlled by
> > the core code. Again we seem to have some mess.
> 
> Agreed with you. This has already been in my task list. I will start to
> solve it after the iommufd tasks.
> 
> Best regards,
> baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
