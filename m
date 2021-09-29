Return-Path: <SRS0=Xpq5=OT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D5FC433F5
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 12:08:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D55E6140D
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 12:08:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5D55E6140D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 28CC160BAF;
	Wed, 29 Sep 2021 12:08:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ULR1cWbUK02G; Wed, 29 Sep 2021 12:08:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EED69606BB;
	Wed, 29 Sep 2021 12:08:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D161CC000F;
	Wed, 29 Sep 2021 12:08:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A9DB3C000D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 12:08:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 96ED940134
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 12:08:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T1NYb_APK4Ly for <iommu@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 12:08:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 14CC9400C8
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 12:08:20 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id i23so3899777wrb.2
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 05:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=iyf25v6ccH6pcjIZwVpHGzum+qBnQrA4I/SRUwhCtyo=;
 b=T8zIfXgeaPrEEdWOzvwNTpI4xwVcEDwynYkx5VAeTJ7rV02Hb29+luk4+do/R4tlYM
 WHxuynFzb2jIPamYr5joLM1NbqFkLNQ0oXsf3Cq1vMqmpxFgE+EvcDk2f7Ua7SsG6agX
 W5014cw1JRdT8BGfZPqE1nw7yLc3PKzbdYCmg8bHyHxkqJIC7qlZAsC3mMiRPMmQ1Q6B
 /n70Y9v5VrEqVNrQ4oRHi2obyy5TfM1Zz0e7jjuVuSsi1WBQAwvr1/X1uZYPwnsN9sCC
 VxAv5M5BafhvPiWSTATDETbfoIlTsGYDjGkhoPQ0oWwEIQbt2gGpFvIj8HH9WyqbKgW3
 VCtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=iyf25v6ccH6pcjIZwVpHGzum+qBnQrA4I/SRUwhCtyo=;
 b=QRcAkmgTRtITyvhCY3FCucd0/YsOIL26bCmQIIWTBNv47X80amzdiR4hRmrujJFYxD
 Bx5zWI2AesiAAQOKBFzcsctxNkimmglEo74Grng53t2jWYdtNvkC+R6Vfuq4kc1qmODo
 REfZHo+osKvyDjchJF6JqdOL80kERRrAaoOTRTINrtEJQ9w6RSyD4Eg197GbZj8vOwJT
 8HmYdSizbB/cok8nsjYwzwvSIvlI7ckKYYNLt1ixilb5RcBFOUgGsWnUUyhuKHQlDtZE
 fQYSe22EEOBfZ+lYjvlKCEFouwn4SW/C0AtEMUmNp8jzzXpPuQdQM9gtHorJ+6X+eBiT
 w6Kg==
X-Gm-Message-State: AOAM5301ELhQOF5tWjy7uPxGAUgDpqe3CJIHBCCTCcVImh5Ph7NGKlKE
 yMuW98mAGK23rAgEQ/rTi7aXNA==
X-Google-Smtp-Source: ABdhPJwTIS8HQpJZEByh3RukfaJyygW8l9IQlLTBVa0HSIUytOml9PkySYthSBAciSjRupn3Iw7g/g==
X-Received: by 2002:adf:fe8c:: with SMTP id l12mr6440976wrr.210.1632917299207; 
 Wed, 29 Sep 2021 05:08:19 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168])
 by smtp.gmail.com with ESMTPSA id i27sm1502404wmb.40.2021.09.29.05.08.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Sep 2021 05:08:18 -0700 (PDT)
Date: Wed, 29 Sep 2021 13:07:56 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [RFC 17/20] iommu/iommufd: Report iova range to userspace
Message-ID: <YVRXHDwROV2ASnVJ@myrica>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-18-yi.l.liu@intel.com>
 <YUtCYZI3oQcwKrUh@myrica>
 <PH0PR11MB56580CB47CA2CF17C86CD0D0C3A99@PH0PR11MB5658.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <PH0PR11MB56580CB47CA2CF17C86CD0D0C3A99@PH0PR11MB5658.namprd11.prod.outlook.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "hch@lst.de" <hch@lst.de>,
 "Jiang, Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "corbet@lwn.net" <corbet@lwn.net>, "jgg@nvidia.com" <jgg@nvidia.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "parav@mellanox.com" <parav@mellanox.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
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

On Wed, Sep 29, 2021 at 10:44:01AM +0000, Liu, Yi L wrote:
> > From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Sent: Wednesday, September 22, 2021 10:49 PM
> > 
> > On Sun, Sep 19, 2021 at 02:38:45PM +0800, Liu Yi L wrote:
> > > [HACK. will fix in v2]
> > >
> > > IOVA range is critical info for userspace to manage DMA for an I/O address
> > > space. This patch reports the valid iova range info of a given device.
> > >
> > > Due to aforementioned hack, this info comes from the hacked vfio type1
> > > driver. To follow the same format in vfio, we also introduce a cap chain
> > > format in IOMMU_DEVICE_GET_INFO to carry the iova range info.
> > [...]
> > > diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
> > > index 49731be71213..f408ad3c8ade 100644
> > > --- a/include/uapi/linux/iommu.h
> > > +++ b/include/uapi/linux/iommu.h
> > > @@ -68,6 +68,7 @@
> > >   *		   +---------------+------------+
> > >   *		   ...
> > >   * @addr_width:    the address width of supported I/O address spaces.
> > > + * @cap_offset:	   Offset within info struct of first cap
> > >   *
> > >   * Availability: after device is bound to iommufd
> > >   */
> > > @@ -77,9 +78,11 @@ struct iommu_device_info {
> > >  #define IOMMU_DEVICE_INFO_ENFORCE_SNOOP	(1 << 0) /* IOMMU
> > enforced snoop */
> > >  #define IOMMU_DEVICE_INFO_PGSIZES	(1 << 1) /* supported page
> > sizes */
> > >  #define IOMMU_DEVICE_INFO_ADDR_WIDTH	(1 << 2) /*
> > addr_wdith field valid */
> > > +#define IOMMU_DEVICE_INFO_CAPS		(1 << 3) /* info
> > supports cap chain */
> > >  	__u64	dev_cookie;
> > >  	__u64   pgsize_bitmap;
> > >  	__u32	addr_width;
> > > +	__u32   cap_offset;
> > 
> > We can also add vendor-specific page table and PASID table properties as
> > capabilities, otherwise we'll need giant unions in the iommu_device_info
> > struct. That made me wonder whether pgsize and addr_width should also
> > be
> > separate capabilities for consistency, but this way might be good enough.
> > There won't be many more generic capabilities. I have "output address
> > width"
> 
> what do you mean by "output address width"? Is it the output address
> of stage-1 translation?

Yes, so the guest knows the size of GPA it can write into the page table.
For Arm SMMU the GPA size is determined by both the SMMU implementation
and the host kernel configuration. But maybe that could also be
vendor-specific, if other architectures don't need to communicate it. 

> >
> and "PASID width", the rest is specific to Arm and SMMU table
> > formats.
> 
> When coming to nested translation support, the stage-1 related info are
> likely to be vendor-specific, and will be reported in cap chain.

Agreed

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
