Return-Path: <SRS0=900o=ON=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89373C433FE
	for <iommu@archiver.kernel.org>; Thu, 23 Sep 2021 10:15:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C4F86103D
	for <iommu@archiver.kernel.org>; Thu, 23 Sep 2021 10:15:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2C4F86103D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E76B361565;
	Thu, 23 Sep 2021 10:15:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bBuEN12r1ZoV; Thu, 23 Sep 2021 10:15:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0EBC661567;
	Thu, 23 Sep 2021 10:15:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D8424C000F;
	Thu, 23 Sep 2021 10:15:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9A643C000D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 10:15:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8316981DA0
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 10:15:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lhj0q5d3hVNd for <iommu@lists.linux-foundation.org>;
 Thu, 23 Sep 2021 10:15:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6A2C281AD7
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 10:15:49 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id t28so2258656wra.7
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 03:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=aae/RsodGlMaQv4cjf+Ghj6Vk8G4MtoQty47v2BpJnw=;
 b=vumkcNAOnHSQBaIWxGSauDBhoAHX288enF91Bo6RYzchogAsW50lE6QrWtENkUmPNt
 RfGLdLB2s5dSIhHUA3rVTAkZb00Sm6EhxzgTUOtMMozh9vHQx6jqcMe9Q8uCUexL5d9g
 AWIIskbIulJYxQzhhadfrHtT42eCYtx5raZQpt61t2J4JntsJnMbF80e5EBzt0DJAOB7
 VnUJfUncA+06CW7pkiCtp8wLtXiJvTKLWUvu9kNzUG4Nrco6knEHyqHv5xcWf9zWDsAx
 Zg/kjWtiFewwgf7M3KacTifr6nC2cImyfaiuNgMdTcGrTgkK1OKwt83ERj+WVI8YO1T7
 OPtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=aae/RsodGlMaQv4cjf+Ghj6Vk8G4MtoQty47v2BpJnw=;
 b=U76/woa9ynHi4dgsx9Dk2GXPhDXw8Nz8Po/yJp/Ga415Hi/LfeXsfvP4sMzJ/wd07u
 esqDrEoTAMVMoXLhsgnn4x5wRDxGtTG4onw8FZsuXzVaqJu8MRjpOFk8+q0kr9KsK4s+
 anR5Lo72iGIXiIwLpjyiGPZgUaETRTUFSmXIBNpCZ4B/GF0lxoO6OyrUCgJeIBazvAxw
 BFrgWKbGEsDh5u8/emc2NnWt5+HzO8boMw0mHjE/0FQpYJ3p9QRRC6R3/H17PjvyN/9a
 9epSVlZ/TSvwqOTyzqAahsC7VAd9FnZvfNtxasW7fSaKn5H6Cq2AEwVXwCtxmHbHBRhC
 I/9w==
X-Gm-Message-State: AOAM533LjYgkYQJDT7tIiGBGRaMDkXj5prKXf866jfKmGDppE8ZTAzVj
 T5sldHpVe8Ll4XSLwM/Qk098gg==
X-Google-Smtp-Source: ABdhPJxzYm05k77WJjrg1d4RZ92vsoJbfB5r3datoj+8v6STPIYXQuPQSgea8Kui3L4uijDIy+CkuQ==
X-Received: by 2002:adf:f391:: with SMTP id m17mr4122306wro.294.1632392147392; 
 Thu, 23 Sep 2021 03:15:47 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168])
 by smtp.gmail.com with ESMTPSA id 198sm4881488wma.16.2021.09.23.03.15.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Sep 2021 03:15:46 -0700 (PDT)
Date: Thu, 23 Sep 2021 11:15:24 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [RFC 10/20] iommu/iommufd: Add IOMMU_DEVICE_GET_INFO
Message-ID: <YUxTvCt1mYDntO8z@myrica>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-11-yi.l.liu@intel.com>
 <20210922152407.1bfa6ff7.alex.williamson@redhat.com>
 <20210922234954.GB964074@nvidia.com>
 <BN9PR11MB543333AD3C81312115686AAA8CA39@BN9PR11MB5433.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BN9PR11MB543333AD3C81312115686AAA8CA39@BN9PR11MB5433.namprd11.prod.outlook.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "hch@lst.de" <hch@lst.de>,
 "Jiang, Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "corbet@lwn.net" <corbet@lwn.net>, Jason Gunthorpe <jgg@nvidia.com>,
 "parav@mellanox.com" <parav@mellanox.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "lkml@metux.net" <lkml@metux.net>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>, "Tian,
 Jun J" <jun.j.tian@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "lushenming@huawei.com" <lushenming@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>
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

On Thu, Sep 23, 2021 at 03:10:47AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Thursday, September 23, 2021 7:50 AM
> > 
> > On Wed, Sep 22, 2021 at 03:24:07PM -0600, Alex Williamson wrote:
> > > On Sun, 19 Sep 2021 14:38:38 +0800
> > > Liu Yi L <yi.l.liu@intel.com> wrote:
> > >
> > > > +struct iommu_device_info {
> > > > +	__u32	argsz;
> > > > +	__u32	flags;
> > > > +#define IOMMU_DEVICE_INFO_ENFORCE_SNOOP	(1 << 0) /* IOMMU
> > enforced snoop */
> > >
> > > Is this too PCI specific, or perhaps too much of the mechanism rather
> 
> Isn't snoop vs. !snoop a general concept not pci specific?
> 
> > > than the result?  ie. should we just indicate if the IOMMU guarantees
> > > coherent DMA?  Thanks,
> > 
> > I think the name of "coherent DMA" for this feature inside the kernel
> > is very, very confusing. We already have something called coherent dma
> > and this usage on Intel has nothing at all to do with that.
> > 
> > In fact it looks like this confusing name has already caused
> > implementation problems as I see dma-iommu, is connecting
> > dev->dma_coherent to IOMMU_CACHE! eg in dma_info_to_prot(). This is
> > completely wrong if IOMMU_CACHE is linked to no_snoop.
> > 
> > And ARM seems to have fallen out of step with x86 as the ARM IOMMU
> > drivers are mapping IOMMU_CACHE to ARM_LPAE_PTE_MEMATTR_OIWB,
> > ARM_LPAE_MAIR_ATTR_IDX_CACHE
> > 
> > The SMMU spec for ARMv8 is pretty clear:
> > 
> >  13.6.1.1 No_snoop
> > 
> >  Support for No_snoop is system-dependent and, if implemented, No_snoop
> >  transforms a final access attribute of a Normal cacheable type to
> >  Normal-iNC-oNC-OSH downstream of (or appearing to be performed
> >  downstream of) the SMMU. No_snoop does not transform a final access
> >  attribute of any-Device.
> > 
> > Meaning setting ARM_LPAE_MAIR_ATTR_IDX_CACHE from IOMMU_CACHE
> > does NOT
> > block non-snoop, in fact it *enables* it - the reverse of what Intel
> > is doing!
> 
> Checking the code:
> 
>         if (data->iop.fmt == ARM_64_LPAE_S2 ||
>             data->iop.fmt == ARM_32_LPAE_S2) {
>                 if (prot & IOMMU_MMIO)
>                         pte |= ARM_LPAE_PTE_MEMATTR_DEV;
>                 else if (prot & IOMMU_CACHE)
>                         pte |= ARM_LPAE_PTE_MEMATTR_OIWB;
>                 else
>                         pte |= ARM_LPAE_PTE_MEMATTR_NC;
> 
> It does set attribute to WB for IOMMU_CACHE and then NC (Non-cacheable)
> for !IOMMU_CACHE. The main difference between Intel and ARM is that Intel
> by default allows both snoop and non-snoop traffic with one additional bit
> to enforce snoop, while ARM requires explicit SMMU configuration for snoop
> and non-snoop respectively.
> 
>         } else {
>                 if (prot & IOMMU_MMIO)
>                         pte |= (ARM_LPAE_MAIR_ATTR_IDX_DEV
>                                 << ARM_LPAE_PTE_ATTRINDX_SHIFT);
>                 else if (prot & IOMMU_CACHE)
>                         pte |= (ARM_LPAE_MAIR_ATTR_IDX_CACHE
>                                 << ARM_LPAE_PTE_ATTRINDX_SHIFT);
>         }
> 
> same for this one. MAIR_ELx register is programmed to ARM_LPAE_MAIR_
> ATTR_WBRWA for IDX_CACHE bit. I'm not sure why it doesn't use 
> IDX_NC though, when !IOMMU_CACHE.

It is in effect since IDX_NC == 0

> 
> > 
> > So this is all a mess.
> > 
> > Better to start clear and unambiguous names in the uAPI and someone
> > can try to clean up the kernel eventually.
> > 
> > The required behavior for iommufd is to have the IOMMU ignore the
> > no-snoop bit so that Intel HW can disable wbinvd. This bit should be
> > clearly documented for its exact purpose and if other arches also have
> > instructions that need to be disabled if snoop TLPs are allowed then
> > they can re-use this bit. It appears ARM does not have this issue and
> > does not need the bit.
> 
> Disabling wbinvd is one purpose. imo the more important intention
> is that iommu vendor uses different PTE formats between snoop and
> !snoop. As long as we want allow userspace to opt in case of isoch 
> performance requirement (unlike current vfio which always choose
> snoop format if available), such mechanism is required for all vendors.
> 
> When creating an ioas there could be three snoop modes:
> 
> 1) snoop for all attached devices;
> 2) non-snoop for all attached devices;
> 3) device-selected snoop;
> 
> Intel supports 1) <enforce-snoop on> and 3) <enforce-snoop off>. snoop
> and nonsnoop devices can be attached to a same ioas in 3).
> 
> ARM supports 1) <snoop format> and 2) <nonsnoop format>. snoop devices
> and nonsnoop devices must be attached to different ioas's in 1) and 2)
> respectively.

I think Arm mainly supports 3), ie. No_snoop PCI transactions on pages
mapped cacheable become non-cacheable memory accesses.

But the Arm Base System Architecture 1.0
(https://developer.arm.com/documentation/den0094/a) states that it's
implementation dependent whether the system supports No_snoop.

    In the case where the system has a System MMU translating and
    attributing the transactions from the root complex, the PCI Express
    transactions must keep the memory attributes assigned by the System
    MMU. If the System MMU-assigned attribute is cacheable then it is
    IMPLEMENTATION DEFINED if No_snoop transactions replace the attribute
    with non-cached.

So we can only tell userspace "No_snoop is not supported" (provided we
even want to allow them to enable No_snoop). Users in control of stage-1
tables can create non-cacheable mappings through MAIR attributes.

Thanks,
Jean

> 
> Then the device info should reports:
> 
> /* iommu enforced snoop */
> +#define IOMMU_DEVICE_INFO_ENFORCE_SNOOP	(1 << 0)
> /* iommu enforced nonsnoop */
> +#define IOMMU_DEVICE_INFO_ENFORCE_NONSNOOP	(1 << 1)
> /* device selected snoop */
> +#define IOMMU_DEVICE_INFO_DEVICE_SNOOP	(1 << 2)
> 
> > 
> > What ARM is doing with IOMMU_CACHE is unclear to me, and I'm unclear
> > if/how iommufd should expose it as a controllable PTE flag. The ARM
> > 
> 
> Based on above analysis I think the ARM usage with IOMMU_CACHE
> doesn't change. 
> 
> Thanks
> Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
